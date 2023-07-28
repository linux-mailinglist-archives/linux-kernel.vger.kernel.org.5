Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5566876693F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjG1Jsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjG1Jsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560462727;
        Fri, 28 Jul 2023 02:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E685E62062;
        Fri, 28 Jul 2023 09:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A87BC433C8;
        Fri, 28 Jul 2023 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690537724;
        bh=1k7ueSeUNImvta8Fj6igOwb07qsyQNnCTRc4trStukY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IfNTSRXisiYfZ2MwOXHVMlLlpGmu7kPZwyWWL4A0JI/0kq30mMR7w9/FqMbVtLtsI
         bkJZbB2+SEbkZegOx6wJbjJy3gHO6pBiMlyM2WJSk+dPgnzVlLm1u1IGuw4F3ns0V4
         6/N1V4WphwazZrrlX0+gMLFuVrdCEOOD05MgXRC7yWKUmOsj1usXBSu8Hvr652pNs5
         YQqmLhMFteBoQg5oGwMBrOoKJ7qOQGlE5M3+5SFacoqxtEivnah4g8+PkMY61Vcqna
         0bOrw6+6ANImaS4CtYC0CDZdzmavBhD/L1DkF5SH3aoU38prp1zbTjBBH5WEOhDlp/
         n3EyIJUGD3H5w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso2760488a12.2;
        Fri, 28 Jul 2023 02:48:44 -0700 (PDT)
X-Gm-Message-State: ABy/qLa1tRnNXNNUABGGPAGw1Q3Hki/sCAs68ETwU6hB4HPitlStJnay
        eNViq0N37GOmiXDlmQRXRmBZI7Fq2zs9JXINyqw=
X-Google-Smtp-Source: APBJJlFxRcUg1wds9NGy1VRafPxp3phq+HmyJYIPGMX7kCQ60jU036RKV4MX9qk4B1E76zLWKrXq9E4gCF6IRIsa4H0=
X-Received: by 2002:aa7:d98a:0:b0:522:586d:6f3a with SMTP id
 u10-20020aa7d98a000000b00522586d6f3amr1665860eds.6.1690537722487; Fri, 28 Jul
 2023 02:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230728074944.26746-1-zhuyinbo@loongson.cn> <20230728-cornball-preacher-a7e4644fcbef@wendy>
In-Reply-To: <20230728-cornball-preacher-a7e4644fcbef@wendy>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 28 Jul 2023 17:48:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com>
Message-ID: <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>,
        kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor, Arnd,

On Fri, Jul 28, 2023 at 4:44=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey,
>
> +CC Huacai & WANG.
>
> On Fri, Jul 28, 2023 at 03:49:42PM +0800, Yinbo Zhu wrote:
> > Loongson-2 platform support Power Management Controller (ACPI) and this
> > series patch was to add PM driver that base on dts and PM binding suppo=
rt.
> >
> > Change in v5:
> >               1. The patch "[PATCH v3 1/3] loongarch: export some arch-=
specific
> >                  pm interfaces" had been merged into linux-next tree th=
us this
> >                  v4 series patch need drop it and need depend on it and=
 it's
> >                  patch link was:
> > https://lore.kernel.org/all/20230615091757.24686-2-zhuyinbo@loongson.cn=
/
>
> Just to note, it might be in linux-next, but more importantly it is also
> in v6.5-rc1, so there is no issue with dependencies.
>
> >               2. Swap the positions of compatible for 2k1000 and 2k0500=
.
>
> I noticed you sent a mail pinging the v4 of this series yesterday as it
> had not been picked up. Who do you actually expect to apply these
> patches? There does not appear to be a maintainer listed for the
> drivers/soc/loongson directory, just one for your GUTS driver.
>
> As a result, patches like
> <https://lore.kernel.org/all/a69170cb55cfc73e378b40ccf1d9c16f@208suo.com/=
>
> have gone ignored. Granted, that patch is probably crap that does not
> apply, due to 208suo.com people sending corrupted patches, but you the
> point.
>
> More interestingly there is also
> <https://lore.kernel.org/all/40b324af-3483-4b3d-b65a-a97944aa4a70@app.fas=
tmail.com/>
> which seems to have also gone missing (I don't see it in linux-next),
> despite some discussion about how the patch should be merged.
>
> Looks to me like drivers/soc/loongson/ needs someone to take
> responsibility for picking up patches for the directory & sending them
> to the soc maintainers (with a new MAINTAINERS entry reflecting that) so
> that patches don't fall through the cracks.
As discussed when the guts driver gets merged, I think it is better to
go via Arnd's soc tree for these patches under drivers/soc/loongson/.

To Krzysztof,

I'm very sorry for the disclaimer, I will remove it, and please take it eas=
y.

Huacai

>
> Thanks,
> Conor.
