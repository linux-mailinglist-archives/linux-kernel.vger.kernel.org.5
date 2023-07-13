Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF4752C65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjGMVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGMVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:50:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E5172C;
        Thu, 13 Jul 2023 14:49:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31434226a2eso1421592f8f.1;
        Thu, 13 Jul 2023 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689284998; x=1691876998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WawFw1m+7HfbMJFd8m7nBIUiUmmc8R2rRh/KVmJ8HY0=;
        b=M+DgUAebrreQPlwoNCNX152cEGG/FFrH9HRyf44Ihn+mBB7tlQALUMkXoA1yVZlgBh
         ibM7TswvWnCYl9mnMaDt0RNzSdEUxtviHyniBTbRNLewFVUCY3gKXPHdtUSEf4KceCZD
         0vF+2/TX8Jm9KaU1hDOZnUwrVrbLFhmGn6oLACIMRYUxo56BfLwtcqqGJumjNwNI7OiV
         v0fzv3Gv/7NwsUD3rrxAkga6IIxiWJ/NSUFid72NW/eunX1cbZGCE5BnTbn8tSoyPzcy
         zNvU7U/cERspRwN56bKczkLRYXjibeJxD/f86ad3WjkN59FcGY99foqCJcIUIm5F6wE1
         f9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284998; x=1691876998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WawFw1m+7HfbMJFd8m7nBIUiUmmc8R2rRh/KVmJ8HY0=;
        b=kpJ4095525y9yhaOP0l3riuIrYCcoE1ewvbEJ5moekBxdqRfqG5vA4PcbbHpcNWjjs
         waYj+O1BA3cdBfr4wkLOm3iVROSmhFbxpg1TDSGXILyldZbLU3gpBn0YLV7CZva9ocyR
         rAqZa8pz1hnlnrik3Ab7hAjH1XzE97zOuqDCKSV+susBA/LPm465OGPPAKtLMXHDnArR
         ELDOYhGA8Pt7i6AFYa96Pu9zof5EFV+WdixCcxOFKhhRAzx3YND/2UZFl3ZNAqZFXWzl
         QkYpNDIZ9PbGJs+gKl2kq4M5fgSDSv01D2VVJMsSjh/Q4+rNM9nvTYZfBbibx2fywTzg
         WvCA==
X-Gm-Message-State: ABy/qLbXr2Ct+MKfKrOtxauYuNjP6/YN8Mv1btPIj+oXLaDtBGRSPSNJ
        FL2+y2Oi7uKmX7NapRYXCMQ05gh77Di5HU5D
X-Google-Smtp-Source: APBJJlHnfhcCQCVy5cpSnXxfWdE7v5fXYyAz005plZepeSUxc7iY+mXKjhq+uydCysi6mMdOyn6KGg==
X-Received: by 2002:adf:f887:0:b0:314:4db:e0bd with SMTP id u7-20020adff887000000b0031404dbe0bdmr2907448wrp.11.1689284997861;
        Thu, 13 Jul 2023 14:49:57 -0700 (PDT)
Received: from [10.0.0.98] (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b003fa74bff02asm26587wmj.26.2023.07.13.14.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:49:57 -0700 (PDT)
Message-ID: <aad3936c41c6520f6863a859eb4c4cdb5fdc0549.camel@gmail.com>
Subject: Re: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
From:   Jakub =?iso-8859-2?Q?Van=ECk?= <linuxtardis@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Thu, 13 Jul 2023 23:49:56 +0200
In-Reply-To: <20230712225518.2smu7wse6djc7l5o@synopsys.com>
References: <20230712224037.24948-1-linuxtardis@gmail.com>
         <20230712225518.2smu7wse6djc7l5o@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Wed, 2023-07-12 at 22:55 +0000, Thinh Nguyen wrote:
> On Thu, Jul 13, 2023, Jakub Vanek wrote:
> > This reverts commit b138e23d3dff90c0494925b4c1874227b81bddf7.
> >=20
> > AutoRetry has been found to cause some issues. This feature allows
> > the controller in host mode (further referred to as the xHC) to
> > send
> > non-terminating/burst retry ACKs (Retry=3D1 and Nump!=3D0) instead of
> > terminating retry ACKs (Retry=3D1 and Nump=3D0) to devices when
> > a transaction error occurs.
> >=20
> > Unfortunately, some USB devices fail to retry transactions when
> > the xHC sends them a burst retry ACK. When this happens, the xHC
>=20
> For some clarity: if the device continues to respond with CRC error,
> the xHC will not complete endpoint related commands while it keeps
> autoretry.

Acknowledged. Do you think it it would be better to respin this patch
once more to include this in the changelog?

> > enters a strange state. After the affected transfer times out,
> > the xHCI driver tries to resume normal operation of the xHC
> > by sending it a Stop Endpoint command. However, the xHC fails
> > to respond to it, and the xHCI driver gives up. [1]
> > This fact is reported via dmesg:
> >=20
> > [sda] tag#29 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
> > [sda] tag#29 CDB: opcode=3D0x28 28 00 00 69 42 80 00 00 48 00
> > xhci-hcd: xHCI host not responding to stop endpoint command
> > xhci-hcd: xHCI host controller not responding, assume dead
> > xhci-hcd: HC died; cleaning up
> >=20
> > Some users observed this problem on an Odroid HC2 with the JMS578
> > USB3-to-SATA bridge. The issue can be triggered by starting
> > a read-heavy workload on an attached SSD. After a while, the host
> > controller would die and the SSD would disappear from the system.
> > [1]
> >=20
> > Further analysis by Synopsys determined that controller revisions
> > other than the one in Odroid HC2 are also affected by this.
> > The recommended solution was to disable AutoRetry altogether.
> > This change does not have a noticeable performance impact. [2]
> >=20
> > Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in
> > the controller")
> > Link:
> > https://urldefense.com/v3/__https://lore.kernel.org/r/a21f34c04632d250c=
d0a78c7c6f4a1c9c7a43142.camel@gmail.com/__;!!A4F2R9G_pg!aCe0isNmX63t6ILE2Tv=
2cX4UnrpDFo6LXWb6oS3-OYFYfX88igrfqmW4Z8UdO7sWz0mdco6vbBrR_KMzYaccpLF7Kw$
> > =C2=A0 [1]
> > Link:
> > https://urldefense.com/v3/__https://lore.kernel.org/r/20230711214834.ky=
r6ulync32d4ktk@synopsys.com/__;!!A4F2R9G_pg!aCe0isNmX63t6ILE2Tv2cX4UnrpDFo6=
LXWb6oS3-OYFYfX88igrfqmW4Z8UdO7sWz0mdco6vbBrR_KMzYae75T8GCw$
> > =C2=A0 [2]
> > Cc: stable@vger.kernel.org
> > Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
> > ---
> > V1 -> V2: Updated to disable AutoRetry everywhere based on Synopsys
> > feedback
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reworded the cha=
ngelog a bit to make it clearer
> >=20
> > =C2=A0drivers/usb/dwc3/core.c | 16 ----------------
> > =C2=A0drivers/usb/dwc3/core.h |=C2=A0 3 ---
> > =C2=A02 files changed, 19 deletions(-)
> >=20
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index f6689b731718..a4e079d37566 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1209,22 +1209,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dwc->dr_mode =3D=3D USB_=
DR_MODE_HOST ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc->dr_m=
ode =3D=3D USB_DR_MODE_OTG) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Enable Auto retry Feature to make the controller
> > operating in
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Host mode on seeing transaction errors(CRC
> > errors or internal
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * overrun scenerios) on IN transfers to reply to
> > the device
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * with a non-terminating retry ACK (i.e, an ACK
> > transcation
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * packet with Retry=3D1 & Nump !=3D 0)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0reg |=3D DWC3_GUCTL_HSTINAUTORETRY;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Must config both num=
ber of packets and max burst
> > settings to enable
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * RX and/or TX thresho=
ld.
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 8b1295e4dcdd..a69ac67d89fe 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -256,9 +256,6 @@
> > =C2=A0#define DWC3_GCTL_GBLHIBERNATIONEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0B=
IT(1)
> > =C2=A0#define DWC3_GCTL_DSBLCLKGTNG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BIT(0)
> > =C2=A0
> > -/* Global User Control Register */
> > -#define DWC3_GUCTL_HSTINAUTORETRY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0B=
IT(14)
> > -
> > =C2=A0/* Global User Control 1 Register */
> > =C2=A0#define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0BIT(31)
> > =C2=A0#define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0BIT(28)
> > --=20
> > 2.25.1
> >=20
>=20
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Thanks!


> Thanks,
> Thinh

Best regards,
Jakub
