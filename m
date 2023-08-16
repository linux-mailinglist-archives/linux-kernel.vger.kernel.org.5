Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5758777E6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbjHPQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbjHPQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:40:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6DB199B;
        Wed, 16 Aug 2023 09:40:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso877724066b.0;
        Wed, 16 Aug 2023 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204054; x=1692808854;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZnAg5Sl149z7ViygrBQ3MpmOtkYN8kNq0j+PK91FRkA=;
        b=k9PU1QbtDp9pJtbV4tv5vbKng3HPJRyWMCPUe9pVPfy8bT0yzusB13SoSbhte0puc+
         5XHiO2d1lEF3NIwP3O5sb737ciKUU+Ihg2EWPjr9eFk6Qwcz2gfpqkU8twkJut7+xrpP
         Dl5BqQT/k9CquUrrr9tNIeWINdJhpf0d+k20aXtBWDDbzhzZJoYx290mpEuxi4LGnuVv
         u3lSiP4wsfPgcBU6H1VK4HXXHtjW6EvP61RppgvERXwFZMyztWKDyrrEEAAzJW5y9ALZ
         n1ISny/JnhFIqA1UoVKVajGVT+xb4r85ywDp3Pfsa9RS7l2y9TAnvQF1bdqGDRDAOQqm
         0KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204054; x=1692808854;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnAg5Sl149z7ViygrBQ3MpmOtkYN8kNq0j+PK91FRkA=;
        b=LEZsts+48Zmmr+SJgJ1YKejXSxh3gBn7nNGFxwABWMVMR4cA+xoIZzAE1ErFw1jiOI
         6U7F6usWB8/D023V9gel701JmRw3RDo6+0ZHWYEeGvZ01N6LNkZxV5xPgOwlrQUv/IqS
         vaSkU6qaBtMDBet7ejwLuB2Id8Ut0AJ8nItEo1VsF6j/ngvAiqr9MC8yXouvuSGK07GT
         IzxUXh9wAqFCZL2C4Rrd7Dv0T2xfSHh9OSiC+P6TzIsbNDl0iuzv7P8uztar5eu/yEo9
         GgAc4bV5TNmjZF3X6isfz08pdToOCvD2IvebETB1z9i0w2BiC0z8ifALlSBOe2hqh19e
         pr2Q==
X-Gm-Message-State: AOJu0YxcITmcIiKokjmuW/M30CDYrAK/DImmOT2BpyGNwDgn6itQwk+v
        P0hpjj8hZstdFoq1IXiX2xw=
X-Google-Smtp-Source: AGHT+IEjxT84OgkQa8mveW5q/Es+b+AQV5j79gPtNTYmi7XhBX86o72+WMhwZmmu4GbNc7iqC7Xp0g==
X-Received: by 2002:a17:907:75f8:b0:99b:4908:1a6d with SMTP id jz24-20020a17090775f800b0099b49081a6dmr1832648ejc.52.1692204053659;
        Wed, 16 Aug 2023 09:40:53 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.8.232])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b0099cd008c1a4sm8726210ejb.136.2023.08.16.09.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:40:53 -0700 (PDT)
Date:   Wed, 16 Aug 2023 19:40:52 +0300
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_ARM=3A_tegra=3A_trans?= =?US-ASCII?Q?former=3A_use_labels_for_mmc_in_aliases?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZNz6VyWASDV2Srie@orome>
References: <20230730125150.4716-1-clamor95@gmail.com> <20230730125150.4716-2-clamor95@gmail.com> <ZNz6VyWASDV2Srie@orome>
Message-ID: <900CEBDC-61FB-4123-9E1F-18D18FF0B2CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



16 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 19:33:27 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Sun, Jul 30, 2023 at 03:51:50PM +0300, Svyatoslav Ryhel wrote:
>> Use phandle references for mmc instead of path in aliases=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/boot/dts/tegra114-asus-tf701t=2Edts           | 12 ++++++----=
--
>>  =2E=2E=2E/boot/dts/tegra30-asus-transformer-common=2Edtsi    | 12 ++++=
++------
>>  2 files changed, 12 insertions(+), 12 deletions(-)
>
>The commit message doesn't describe why this is useful and without any
>clarification I don't see any benefit in doing this=2E

1=2E Simplify comprehension of aliases, path is harder to read then a labe=
l
2=2E Unify with other t20 and t30 trees (paz00, tf101, grouper, picasso et=
c)

>Thierry
