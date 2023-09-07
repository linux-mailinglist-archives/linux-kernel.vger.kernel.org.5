Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF82797839
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbjIGQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbjIGQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:43:13 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05715270E;
        Thu,  7 Sep 2023 09:42:30 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44ee1123667so1374132137.0;
        Thu, 07 Sep 2023 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104886; x=1694709686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI3qPKykEdBORFQX/2gwFAk427YJVxD6Vt6XnXeCVFE=;
        b=CPlho9F7cPnarIVnLCgNqYLStL2W+QQ/Zm9dd/iKFeT+rihn5rmLPkiC5m6UVzPcEq
         ycXeiz4u1r2GAXb+bXgSuFtOhA+34CCumFTR7HYLAvEvMbWkHInuYmR2oGfSEh1QUjsK
         JQuN7ux4IOGqptQKLU0RKnQ75b3hn0/XItOX3csSD7GPthP9kB1jQpSmWWbbbop0Hmc9
         x6KO3ZrHEwr1asvDisiyKWF1kw/EC4MYNzLQoQvQ5FyCkCFoGGW2Q8EXmw+GJZ4e8bwW
         L0O6C3BGUG3DJsDkL0FQTdSIkoHS+aofQBKIWOAMasjOH1IPMAUCsikpx9FnvIH4PCNT
         Qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694104886; x=1694709686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI3qPKykEdBORFQX/2gwFAk427YJVxD6Vt6XnXeCVFE=;
        b=lT8vM7gYzk1dox8yU/DUQ40cxltmvvmFhq46ApPQw+XHth5ah5Xpsg8ajI0WiCgzOK
         gAix49g6y2XJkfT8kihoxQ5iHgwOwADnCxc+E7fH0nnywMnBwdd3jv/xsra5QokNDFav
         s/CPNBDx8pau+5ing9pH7+FV0u6Oh4dKrmT/NT/VKI3Ary31qc3y0VzRMA8+yRp4TO8i
         cJsWt8cmgJs4HzqnhWz9wFjlfkSKvDwuOvmgNqGQb8JwIK+eqMQE6kk7+XmQXu1hyynG
         4w0sn856TTL6PqP9xUdQw9CJ18/zAE364bFYuHpNTVR/poAuMk3hSRFl2dUz/8PzibmK
         xC3Q==
X-Gm-Message-State: AOJu0YxU/auIMTELaCgPLgFK0e/8xoPEfKtp/YrIyGWonmCE1hZcKaka
        +TfWwyABrS9uVdod5scMqaCfyuo93eRLwH+q1e2dWH5sXYE=
X-Google-Smtp-Source: AGHT+IF2f4clu8FhKmXoRyt84gz3p/VGGZk0W2EEiHKFFPj3WYNiCuC7y3dygDgVnoHXLhkSMaZJGcIsjO8h6WPehI4=
X-Received: by 2002:a25:b29d:0:b0:d78:2258:f5b8 with SMTP id
 k29-20020a25b29d000000b00d782258f5b8mr3003998ybj.19.1694090091695; Thu, 07
 Sep 2023 05:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1eZtsBzGb_UxOqZpNiEsk8Uk7DkqPh5AnYRRNc_kkr-tFasQ@mail.gmail.com>
 <ZPUciRLUcjDywMVS@debian.me> <20230906013209.jlcxluxemyg3va6l@synopsys.com> <ZPio6QD64cjJza29@xhacker>
In-Reply-To: <ZPio6QD64cjJza29@xhacker>
From:   Kenta Sato <tosainu.maple@gmail.com>
Date:   Thu, 7 Sep 2023 21:34:35 +0900
Message-ID: <CAF1eZttQbY23MHK7tKyaUORc6WAkMWaNqt3VyaBsDuhi0TOmRQ@mail.gmail.com>
Subject: Re: usb: dwc3: some USB devices not working after 6.4.8
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 7, 2023 at 1:41=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> On Wed, Sep 06, 2023 at 01:32:22AM +0000, Thinh Nguyen wrote:
> > On Mon, Sep 04, 2023, Bagas Sanjaya wrote:
> > > On Sun, Sep 03, 2023 at 09:19:13PM +0900, Kenta Sato wrote:
> > > > Hi,
> > > >
> > > > I am using the FriendlyElec NanoPi R4S board.
> > > > When I update the kernel from 6.4.7 to 6.4.11, 6.4.13, and 6.5.1, i=
t
> > > > doesn't recognize some USB devices.
> > > >
> > > > The board has two USB 3.0 ports. I connected 1) BUFFALO USB Flash D=
isk
> > > > (high-speed) and 2) NETGEAR A6210 (SuperSpeed) to each port.
> > > > 1) is often not recognized. On the other hand, 2) was working while=
 I
> > > > was testing.
> > > > Regardless of whether a USB device is connected, I could see the be=
low
> > > > message on dmesg:
>
> Hi Kenta,
>
>
> Besides the comments and patch from Thinh, may I know some details of
> your HW and SW env? Such as
>
> From HW support points of view, is the usb3.0 ports dual mode or host onl=
y?
The board should be designed for host-only as it has two USB 3.0 Type-A por=
ts.

>
> From SW side, how do you configure the host controller? I.E set dual
> mode or host only?
According to the device tree file in the kernel source tree
(arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi), it is configured
as host only.
&usbdrd_dwc3_1 {
  dr_mode =3D "host";
  status =3D "okay";
};

>
> Lastly, did you have modifications or local patches to dwc3 driver?
No, except for reverting the commit I mentioned in the first post.

Right now I am using the tag 6.5.1 with a few small patches. You can
find them and config in the link below.
https://github.com/Tosainu/PKGBUILDs/tree/a460f4826e44d666661f3049413628f30=
64a2751/core/linux-aarch64

>
> Thanks in advance
>
> > > >
> > > > [    0.740993] phy phy-ff7c0000.phy.8: phy poweron failed --> -110
> > > > [    0.741585] dwc3 fe800000.usb: error -ETIMEDOUT: failed to initi=
alize core
> > > > [    0.742334] dwc3: probe of fe800000.usb failed with error -110
> > > > [    0.751635] rockchip-usb2phy ff770000.syscon:usb2phy@e460:
> > > > Requested PHY is disabled
> > > >
> > > > Is there any idea on this?
> > > >
> > > > The cause seems to be related to this commit. I tried reverting thi=
s
> > > > change and the issue seemed to be solved.
> > > >
> > > > >From 317d6e4c12b46bde61248ea4ab5e19f68cbd1c57 Mon Sep 17 00:00:00 =
2001
> > > > From: Jisheng Zhang <jszhang@kernel.org>
> > > > Date: Wed, 28 Jun 2023 00:20:18 +0800
> > > > Subject: usb: dwc3: don't reset device side if dwc3 was configured =
as
> > > >  host-only
> > > >
> > > > commit e835c0a4e23c38531dcee5ef77e8d1cf462658c7 upstream.
> > > >
> > > > Commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
> > > > system_suspend in host mode") replaces check for HOST only dr_mode =
with
> > > > current_dr_role. But during booting, the current_dr_role isn't
> > > > initialized, thus the device side reset is always issued even if dw=
c3
> > > > was configured as host-only. What's more, on some platforms with ho=
st
> > > > only dwc3, aways issuing device side reset by accessing device regi=
ster
> > > > block can cause kernel panic.
> > > >
> > > > Fixes: c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
> > > > system_suspend in host mode")
> > > > Cc: stable <stable@kernel.org>
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > > > Link: https://lore.kernel.org/r/20230627162018.739-1-jszhang@kernel=
.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmit/?h=3Dv6.4.8&id=3D317d6e4c12b46bde61248ea4ab5e19f68cbd1c57
> > > >
> > >
> > > Thanks for the regression report. I'm adding it to regzbot:
> > >
> > > #regzbot ^introduced: e835c0a4e23c38
> > > #regzbot title: some USB devices unrecognized caused by not resetting=
 dwc3 device if it is host-only
> > >
> >
> > When there's phy reconfiguration, we need follow through a soft reset
> > sequence. It may be done when we pass to xHCI driver through its
> > initialization of USBCMD.HCRST. However, looks like we need to do a
> > soft reset before setting more core parameters in dwc3.
> >
> > Can we try to just reset the phy instead to see if it helps? If not, we
> > may have to teach dwc3 about xHCI's USBCMD.HCRST.
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 9c6bf054f15d..66186ef34c6d 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1104,9 +1104,42 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >       if (ret)
> >               goto err_exit_ulpi;
> >
> > -     ret =3D dwc3_core_soft_reset(dwc);
> > -     if (ret)
> > -             goto err_exit_phy;
> > +     /*
> > +      * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings whe=
re n
> > +      * is port index. If this is a multiport host, then we need to re=
set
> > +      * all active ports.
> > +      */
> > +     reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> > +     reg |=3D DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > +     dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> > +
> > +     /*
> > +      * Must meet usb3 phy reset assertion timing,
> > +      * should be much less than 20ms.
> > +      */
> > +     msleep(20);
> > +
> > +     reg &=3D ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > +     dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> > +
> > +     reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> > +     reg |=3D DWC3_GUSB2PHYCFG_PHYSOFTRST;
> > +     dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> > +
> > +     /*
> > +      * Must meet usb2 phy reset assertion timing,
> > +      * should be much less than 20ms.
> > +      */
> > +     msleep(20);
> > +
> > +     reg &=3D ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > +     dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> > +
> > +     /*
> > +      * Some platforms may need more time to synchronize the clocks,
> > +      * 100ms should be enough for all.
> > +      */
> > +     msleep(100);
> >
> >       if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD &&
> >           !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
> >
> >
> > --
> >
> > Thanks,
> > Thinh

Thank you,
kenta
