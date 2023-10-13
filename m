Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3164E7C868D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjJMNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjJMNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49B91;
        Fri, 13 Oct 2023 06:16:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52048C433C9;
        Fri, 13 Oct 2023 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697202966;
        bh=AeyLxzVXp4snQoUowgdXYGOaSazywtRR9uBrWP/FXDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FbFN9cK7+7/w/muL8+KXexz1HLGb3n6ZTN9qmc/GyDP6LNOA50t0/CsYdbXZtt6ao
         8PjCBQobr+sYezwCxR77wktQt2zJruVXxS/Kid27wolCLAlsVeYPgRW8qkv/4G6sNU
         OXygYsgXKGQGH6Ycf+DbdZOUnsO+KUlxibmP38KCYz6KEtVZdCxsREn/Z4QfkzuUqs
         Uc/v8bkDRpA/qEiOPfyTswyPHld5ZyK80iYD/xA41tU9iy5ac3/yetBzo+RJozY4V5
         XYeTWLg9qEsjyhkTv+BgLpG9WWT+yqw+tx7rhty1xtKfSvIuST22+X6NSrZx2vm/8q
         cGSu9brb7srPg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so2814546e87.2;
        Fri, 13 Oct 2023 06:16:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwaoOVgLnYvvsLhUKIWZ+TavAbXigZRsbvnUX3MrB4yOrk9kzLp
        vUtb2E0+wI5+GRqzYEs9BCSKdRhKG+MOQJUemA==
X-Google-Smtp-Source: AGHT+IF5wN1WRycCZTTLhq1TMC9nlzoXrbnKcsIup2bCQrX2FztreQWlk5fXuvhjl7rkoOJE0TWx+nh4lFUZa/AtE0k=
X-Received: by 2002:a05:6512:3f4:b0:504:7dc9:671a with SMTP id
 n20-20020a05651203f400b005047dc9671amr18824302lfq.69.1697202964533; Fri, 13
 Oct 2023 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231012192149.1546368-1-robh@kernel.org> <ZSkPjRp/xPfVQ/NB@yilunxu-OptiPlex-7050>
In-Reply-To: <ZSkPjRp/xPfVQ/NB@yilunxu-OptiPlex-7050>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Oct 2023 08:15:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLHKTQi0i-V4C5UA6WJjnMeen0WR4jjcA4YSRXOYZOrZA@mail.gmail.com>
Message-ID: <CAL_JsqLHKTQi0i-V4C5UA6WJjnMeen0WR4jjcA4YSRXOYZOrZA@mail.gmail.com>
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Fix unused xlnx_pr_decoupler_of_match
 warning for !CONFIG_OF
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        kernel test robot <lkp@intel.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:37=E2=80=AFAM Xu Yilun <yilun.xu@linux.intel.com>=
 wrote:
>
> On Thu, Oct 12, 2023 at 02:21:48PM -0500, Rob Herring wrote:
> > Commit 8c966aadcc02 ("fpga: Use device_get_match_data()") dropped the
>
> Hi rob:
>
> Unfortunately I re-applied Commit 8c966aadcc02 and the previous commit
> id is lost.
>
> Since the 2 patches are not upstreamed yet, could I just merge them into
> one?

Yes, that's fine.

Rob

>
> Thanks,
> Yilun
>
> > unconditional use of xlnx_pr_decoupler_of_match resulting in this
> > warning:
> >
> > drivers/fpga/xilinx-pr-decoupler.c:94:34: warning: unused variable 'xln=
x_pr_decoupler_of_match' [-Wunused-const-variable]
> >
> > The fix is to drop of_match_ptr() which is not necessary because DT is
> > always used for this driver.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310100247.Y7BFcalX-lkp=
@intel.com/
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/fpga/xilinx-pr-decoupler.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-p=
r-decoupler.c
> > index 0c012d0f616d..68835896f180 100644
> > --- a/drivers/fpga/xilinx-pr-decoupler.c
> > +++ b/drivers/fpga/xilinx-pr-decoupler.c
> > @@ -167,7 +167,7 @@ static struct platform_driver xlnx_pr_decoupler_dri=
ver =3D {
> >       .remove =3D xlnx_pr_decoupler_remove,
> >       .driver =3D {
> >               .name =3D "xlnx_pr_decoupler",
> > -             .of_match_table =3D of_match_ptr(xlnx_pr_decoupler_of_mat=
ch),
> > +             .of_match_table =3D xlnx_pr_decoupler_of_match,
> >       },
> >  };
> >
> > --
> > 2.42.0
> >
