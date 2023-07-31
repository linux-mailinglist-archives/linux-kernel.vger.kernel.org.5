Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628A276992D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGaON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGaONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3101B7;
        Mon, 31 Jul 2023 07:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4104761172;
        Mon, 31 Jul 2023 14:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA61AC433CC;
        Mon, 31 Jul 2023 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690812808;
        bh=Wo4CjExlbRCO9K5AAKZ4NSSIulizDzrcAHK9CM5ig/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HN/orTerPxZtILAHUFAFD+nTlKRVfovJyNZ5nDtXeuJJWb1G3lo2JUWBImZ1LWH0j
         u6dlyZjswN6SW5HyFN3V9dPCD2eg5BMsw2Z3rHT4Fbu/O5rJk6XfPra1sv1CW1OpaL
         t4Qq48e52xRoPVSuXIOFFNjlUmwt6018qahEVq7n5QwPnB04c6lMbWwDWnb7hc2/AQ
         zUMP2zo6jIujtEI1BtO22CBQpJtktMzgpggk0Ktp5nCKaXTDBjX6LDC2wtAml9SaGb
         DEZidIxviJPHpt6qaMDR/6abDStExjwefPHjwwyhPvpjxktPC3dun85Y2K+ZeK6cKa
         wDV/1CmhSIMVA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe1a35a135so6691713e87.1;
        Mon, 31 Jul 2023 07:13:28 -0700 (PDT)
X-Gm-Message-State: ABy/qLZGhu8imGQIZGdo2wKBusNCKrqwxaEsfbeXChYSt4KawwiJOXpt
        E0ifbWQ6NqY8gMvx8CIZ7hlwgd173IqZwC1N/nY=
X-Google-Smtp-Source: APBJJlEigP5KHBpGtJm22eSehD5FHHz9MoqyFW/ve8Kz0t7P2XvtMu7sRQAb9xNAYwk3pqpgl1EwZ4FpnRBUgh8+8BE=
X-Received: by 2002:a19:e619:0:b0:4f8:5d0f:c779 with SMTP id
 d25-20020a19e619000000b004f85d0fc779mr5982275lfh.40.1690812806591; Mon, 31
 Jul 2023 07:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230728074944.26746-1-zhuyinbo@loongson.cn> <20230728-cornball-preacher-a7e4644fcbef@wendy>
 <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com> <20230728-unedited-thank-366462ab471d@wendy>
In-Reply-To: <20230728-unedited-thank-366462ab471d@wendy>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 31 Jul 2023 22:13:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7jVp2fX5Rosd8YSj_6oFdmsu5iHsBmYH_8iX2qan7r+w@mail.gmail.com>
Message-ID: <CAAhV-H7jVp2fX5Rosd8YSj_6oFdmsu5iHsBmYH_8iX2qan7r+w@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor and Arnd,

On Fri, Jul 28, 2023 at 6:18=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Jul 28, 2023 at 05:48:29PM +0800, Huacai Chen wrote:
> > On Fri, Jul 28, 2023 at 4:44=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > > On Fri, Jul 28, 2023 at 03:49:42PM +0800, Yinbo Zhu wrote:
> > > > Loongson-2 platform support Power Management Controller (ACPI) and =
this
> > > > series patch was to add PM driver that base on dts and PM binding s=
upport.
> > > >
> > > > Change in v5:
> > > >               1. The patch "[PATCH v3 1/3] loongarch: export some a=
rch-specific
> > > >                  pm interfaces" had been merged into linux-next tre=
e thus this
> > > >                  v4 series patch need drop it and need depend on it=
 and it's
> > > >                  patch link was:
> > > > https://lore.kernel.org/all/20230615091757.24686-2-zhuyinbo@loongso=
n.cn/
> > >
> > > Just to note, it might be in linux-next, but more importantly it is a=
lso
> > > in v6.5-rc1, so there is no issue with dependencies.
> > >
> > > >               2. Swap the positions of compatible for 2k1000 and 2k=
0500.
> > >
> > > I noticed you sent a mail pinging the v4 of this series yesterday as =
it
> > > had not been picked up. Who do you actually expect to apply these
> > > patches? There does not appear to be a maintainer listed for the
> > > drivers/soc/loongson directory, just one for your GUTS driver.
> > >
> > > As a result, patches like
> > > <https://lore.kernel.org/all/a69170cb55cfc73e378b40ccf1d9c16f@208suo.=
com/>
> > > have gone ignored. Granted, that patch is probably crap that does not
> > > apply, due to 208suo.com people sending corrupted patches, but you th=
e
> > > point.
> > >
> > > More interestingly there is also
> > > <https://lore.kernel.org/all/40b324af-3483-4b3d-b65a-a97944aa4a70@app=
.fastmail.com/>
> > > which seems to have also gone missing (I don't see it in linux-next),
> > > despite some discussion about how the patch should be merged.
> > >
> > > Looks to me like drivers/soc/loongson/ needs someone to take
> > > responsibility for picking up patches for the directory & sending the=
m
> > > to the soc maintainers (with a new MAINTAINERS entry reflecting that)=
 so
> > > that patches don't fall through the cracks.
>
> > As discussed when the guts driver gets merged, I think it is better to
> > go via Arnd's soc tree for these patches under drivers/soc/loongson/.
>
> Discussed perhaps, and that does seem to me like the correct thing to do,
> but nobody actually did anything about it.
> Somebody needs to set up a git tree, add a MAINTAINERS entry for the
> directory, actually apply the patches and then send a PR to the soc
> maintainers (as mentioned by Arnd in the second patch I linked there).
>
> Perhaps that someone is you, or maybe it is Yinbo, up to you guys to
> decide :)
I'm a "merge hater" and "rebase lover", so I think it is better that
Arnd picks up these patches to the soc tree directly. But if
necessary, I can also create a "soc-loongson-next" branch in my tree
and then send PR to Arnd.

Huacai
>
> Cheers,
> Conor.
>
