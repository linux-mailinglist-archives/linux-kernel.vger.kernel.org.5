Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD75765895
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjG0QZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjG0QZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:25:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DF1984;
        Thu, 27 Jul 2023 09:24:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso12169025e9.0;
        Thu, 27 Jul 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690475098; x=1691079898;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Dtb8/XWikrPjhh1ZH6jlcJvc4+s8I+X0vtKuEd4mMc=;
        b=akxN6PqS7K8KjKHHO4u8jzlPtXTSPnqPrDK4GrhDg/d1kWuMxW6wunjd0hoy0JTkiw
         PYSznbnThXx34aSaXUSyDdWuDuv3IcruuomCIWB0zIwGDb1rg+v1zfS4v4N5FvCDb/1d
         j/ShUUgf73BKW5aaO9Sktjna54v/Y/QjR6+j2xNB5na4tYsYOl5Zy1XPmi9m29k3h1b/
         sfOFTRnB5OIgoanLgCpZ0iujZyUwsn3pQxiCgF4qVgZ49O3ndsKl0UaptrkDpDsKuWGm
         0CTWkdM1ewgRCIU3g8/Q7DbdwIhC8veOpaXO51Z8yxYCd5efA3Rd888qq9/xUUj+jH14
         unwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475098; x=1691079898;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Dtb8/XWikrPjhh1ZH6jlcJvc4+s8I+X0vtKuEd4mMc=;
        b=jQyfrOO0eLA6/e+y6fxr2p5XBa+ALfgoJVKzfU1SilOBoebBUeDwrAZvO3o3TQKhZZ
         EzySUrZyjDBN9Vo27qtNyXSHX15Gj6joSQ/Ic8WwTVPwQhfK+cJduYvw5FG01kGGwurp
         +Kr4xmkpwkQPjDs3n29Hy/PXju7KaXYHFterV+Ews5+75sG3hdOoFlPmJ7Vvcl1x7jPu
         t5aVAoC9BcD9C2gIDtfRG4BxUH391iZ4qag28Nn0tST0H7lVzE+p769ey4qU+PbVO5or
         uoUZpETAoo15bP4MXsl0p9f+u0OShbjmKAyKXwvxToldt2AWx9UB2B/x+upXoiffHEih
         E5Lw==
X-Gm-Message-State: ABy/qLbJx17CtMkFRIPqWoLq2oxUXfKA5BOr/oaSO4TkvxPmz69gPLt6
        /kM5Gp+SbL6mDTP1Eh9rrGo=
X-Google-Smtp-Source: APBJJlELdV2E51r0DbzX80QIKtgJQqds7CnqjhWhCRk68TR+/SG2Y3BxIAb/3ANSX/BU4owykrCV8Q==
X-Received: by 2002:a05:600c:2294:b0:3fb:9ef2:157 with SMTP id 20-20020a05600c229400b003fb9ef20157mr2104746wmf.28.1690475097580;
        Thu, 27 Jul 2023 09:24:57 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.28.141])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b003fbb25da65bsm2188169wmj.30.2023.07.27.09.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 09:24:57 -0700 (PDT)
Date:   Thu, 27 Jul 2023 19:24:56 +0300
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Support bridge/connector by Tegra HDMI
User-Agent: K-9 Mail for Android
In-Reply-To: <ZMKIonuTnoXcuc95@orome>
References: <20230618085046.10081-1-clamor95@gmail.com> <ZMKIonuTnoXcuc95@orome>
Message-ID: <97EE0F0B-D1EE-43B1-A13E-510DB8FA2798@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



27 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 18:09:22 GMT+03:00, Thier=
ry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>On Sun, Jun 18, 2023 at 11:50:44AM +0300, Svyatoslav Ryhel wrote:
>> This patch adds support for the bridge/connector attached to the
>> HDMI output, allowing to model the hardware properly=2E It keeps
>> backwards compatibility with existing bindings and is required
>> by devices which have a simple or MHL bridge connected to HDMI
>> output like ASUS P1801-T or LG P880/P895 or HTC One X=2E
>>=20
>> Tested on ASUS Transformers which have no dedicated bridge but
>> have type d HDMI connector directly available=2E Tests went smoothly=2E
>
>If I understand correctly, we still need the drm/tegra patch to be
>applied before the DT change, otherwise the driver won't know what to do
>about the connector, right?
>
>That shouldn't be big problem, but it means that the patches need to be
>staged in correctly to avoid breaking things=2E

Patchset contains drm/tegra patch

>Thierry
