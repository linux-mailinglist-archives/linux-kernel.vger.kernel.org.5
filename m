Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD12D7CE4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjJRRdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjJRRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E31712
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so88103011fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650138; x=1698254938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KecMZIvYhLiPYK1GTiccjaRpV9Eq5PLhQIfDXh9BqmM=;
        b=Sts3Gh/iHfuxwcOKaDl6vwMNA5HSUH5CI1OyckNMimNusWTpvhGOJTON/e8B8pooiS
         Em/iLj+/R2dnS5FGOCmKTKk27wo+dm+Um3gS0xQ/U7eCYPtmAgQWv8yYi/UXJYDjsmJS
         yEkh9Z+9cSK7yzH/Ht+SSnVnYOwBudF/SeSaTDhWMPPLE8ISaq7sTtIY/ShtwWbjMxV9
         pVh20lTH8OO/A5bPZLtKYhx5LmbFuuu6iPyJQrDLg1aI+C7tNl4U6w1uVRhhjpKU1wPJ
         RpeY3j7ePCq+q1yEXj4FR1f3qNNnMqYb8XoZsnm3naClI8yFr/pRXekeavaGOHKgzGHA
         oCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650138; x=1698254938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KecMZIvYhLiPYK1GTiccjaRpV9Eq5PLhQIfDXh9BqmM=;
        b=DYw7C+pztnrqGfnKWW1SfgfrtWPsWu9UfNso30E8Xy36pFULIJFmfwz3a1KvnDkg1s
         Nvaq8OPQ98HmKojYSo/ESuMUU2sci3KGrHOIOvIzccW2BBnrdUqauviLLhtudVTI8moy
         wfOaMlh3i25fQb44cj67dMq9w/PDbpW+UtuSAC979OHCYny9/tZdbO05WVmdk+2R/EiM
         a7sf5B6qilImGQXUZi07avXI1ZUhWwZjFrOtM3bOib0SQbIcCphLgamNlv1hq5eWK65K
         ci+znjGSpufCB/c3K4IrlLuf3lWlISiuwRKJAf1aLHu0Jy5IxHqgmb/VhBPG2YLf7JHW
         Wg1g==
X-Gm-Message-State: AOJu0YxIvGNeASugJYV4sad3oo4tqJDPQBnoBV2fsX/qqtsO71P63nVJ
        0xZ02Okln/x7sUbMPhnWG/pAvjOPy8sa4AmHYVIVHg==
X-Google-Smtp-Source: AGHT+IEtoY1yZMCUmYkHB9d1SqV2lcdLSWQ0+n+bBu7Zg4eMSM1qn1YEnUNWUrCwdIkscxBAZQ3k/ahzY9IjsKI+bfI=
X-Received: by 2002:a05:651c:227:b0:2be:54b4:ff90 with SMTP id
 z7-20020a05651c022700b002be54b4ff90mr4251984ljn.53.1697650137918; Wed, 18 Oct
 2023 10:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-12-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-12-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:22 -0700
Message-ID: <CALs-HsvXt_gPCJ2hh5ftPn0sJxWKNzn3_8uyamko4OufCE0+vA@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] riscv: add ISA extension parsing for Zihintntl
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add parsing for Zihintntl ISA extension[1] that was ratified in commit
> 0dc91f5 ("Zihintntl is ratified") of riscv-isa-manual[2].
>
> Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/v=
iew [1]
> Link: https://github.com/riscv/riscv-isa-manual/commit/0dc91f505e6d [2]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
