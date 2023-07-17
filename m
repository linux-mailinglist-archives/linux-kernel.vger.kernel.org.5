Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867B4756690
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGQOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGQOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:37:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE9E7F;
        Mon, 17 Jul 2023 07:37:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso42102855e9.0;
        Mon, 17 Jul 2023 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689604669; x=1692196669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYUU8YV3BqJ0I2zWti5nCz47R+nejQLyugvMd3FOv9g=;
        b=M8mHQyW3k62+jCLLDGKRyfwx32nZWnPK5ML+MVAtbEqjo6XWyCE8Q1dKc0vcYLNYOj
         0tX/zmr93MOg2fjL1VrZrlaW4s16C+NrWdl97eSkyhbia1BvBh4TQp6ae59LZAKdw1sM
         muieYaRa3vuOPD2qGm8AhzfdvM/QApB+/sXKZL9TzVy6nITKQs0WPtbUst/yWGt1NI5k
         dga02M8OEa0oTMshB6HHlJXOkMbsbYmDZ4WJAeO+vTKvju2MFp0fD0zIvqxUWoCj9/4i
         k+kOjfKblXmy0Rh+Fd1TyzEwgjG+LXMD+mI7FyOi3naGlkMGdgbSylkbhaK0Fp10cSDY
         aTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689604669; x=1692196669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYUU8YV3BqJ0I2zWti5nCz47R+nejQLyugvMd3FOv9g=;
        b=BsKkmOZ1dpm2RWmMkMTu05GUo5cZJVn/uEW0GNYxtL0cppA0KhkhheyrYukJnETTC/
         M6KOqzlTutJ5B8XqW5PGi68EH1HnAyjX8oqpMMsBaZzW/DgDxCsCKu2/kd/l41/o1+nO
         Uf4QvkgZtYj6NUU6+n7q0ECztegOVki5zcDsWuARL+00dujGYy5wm5kR8J0oA6iVzfQM
         lsjnNtimCMpfzH4H37KfTTS/GoP+ux5IqrWikUhFmNt7l9ylvD1TpXqRiRjAe3WNKfZV
         5AYqvDSk/wqwrjVs/Jmh9OYDAgOUT0zjPzh8nemgzpQJUwQlAdR3EejI5k/6ftRbzi+0
         rjwA==
X-Gm-Message-State: ABy/qLaIShGsiVRvAjKsK91KNdCmyD9UyLwqeQyTIpsDgNp32EUG6Cle
        eomlp7w9UNf+qZcbffZaCqM=
X-Google-Smtp-Source: APBJJlGlBUjN/AJOghm7qejJnwmyoRu2rFRiWEIaL7/Y/DT8/Fq1mlhKtJWadteBiwX0qpkH7F2ssg==
X-Received: by 2002:a1c:4b0e:0:b0:3fb:b4fc:be62 with SMTP id y14-20020a1c4b0e000000b003fbb4fcbe62mr9722372wma.17.1689604668611;
        Mon, 17 Jul 2023 07:37:48 -0700 (PDT)
Received: from [10.0.0.102] (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fa968e9c27sm8056153wmk.9.2023.07.17.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:37:48 -0700 (PDT)
Message-ID: <63a650a449b9937f95f5f2b47546e07e60c06630.camel@gmail.com>
Subject: Re: [PATCH v3] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
From:   Jakub =?iso-8859-2?Q?Van=ECk?= <linuxtardis@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Mon, 17 Jul 2023 16:37:47 +0200
In-Reply-To: <20230714213838.zil4c4wt3spbedvi@synopsys.com>
References: <20230714122419.27741-1-linuxtardis@gmail.com>
         <20230714213838.zil4c4wt3spbedvi@synopsys.com>
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

On Fri, 2023-07-14 at 21:38 +0000, Thinh Nguyen wrote:
> On Fri, Jul 14, 2023, Jakub Vanek wrote:
> > This reverts commit b138e23d3dff90c0494925b4c1874227b81bddf7.
> >=20
> > AutoRetry has been found to sometimes cause controller freezes when
> > communicating with buggy USB devices.
> >=20
> > This controller feature allows the controller in host mode to send
> > non-terminating/burst retry ACKs instead of terminating retry ACKs
> > to devices when a transaction error (CRC error or overflow) occurs.
> >=20
> > Unfortunately, if the USB device continues to respond with a CRC
> > error,
> > the controller will not complete endpoint-related commands while it
> > keeps trying to auto-retry. [3] The xHCI driver will notice this
> > once
> > it tries to abort the transfer using a Stop Endpoint command and
> > does not receive a completion in time. [1]
> > This situation is reported to dmesg:
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
> > Revert the enablement commit. This will keep the AutoRetry bit in
> > the default state configured during SoC design [2].
> >=20
> > Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in
> > the controller")
> > Link:
> > https://urldefense.com/v3/__https://lore.kernel.org/r/a21f34c04632d250c=
d0a78c7c6f4a1c9c7a43142.camel@gmail.com/__;!!A4F2R9G_pg!cQZmUozSCVry9wEn5TT=
VGljEo6B_nKIel0kWXsUQbaleJZwkOyrvc4FzWTlbfcUJ7hGz9V50rn0A2WMEceULIS9y9A$
> > =C2=A0 [1]
> > Link:
> > https://urldefense.com/v3/__https://lore.kernel.org/r/20230711214834.ky=
r6ulync32d4ktk@synopsys.com/__;!!A4F2R9G_pg!cQZmUozSCVry9wEn5TTVGljEo6B_nKI=
el0kWXsUQbaleJZwkOyrvc4FzWTlbfcUJ7hGz9V50rn0A2WMEceXrbrG9iA$
> > =C2=A0 [2]
> > Link:
> > https://urldefense.com/v3/__https://lore.kernel.org/r/20230712225518.2s=
mu7wse6djc7l5o@synopsys.com/__;!!A4F2R9G_pg!cQZmUozSCVry9wEn5TTVGljEo6B_nKI=
el0kWXsUQbaleJZwkOyrvc4FzWTlbfcUJ7hGz9V50rn0A2WMEceWVJz8nuQ$
> > =C2=A0 [3]
> > Cc: stable@vger.kernel.org
> > Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
> > ---
> > V2 -> V3: Include more findings in changelog
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

Thank you!

> Thanks,
> Thinh

Best regards,
Jakub
