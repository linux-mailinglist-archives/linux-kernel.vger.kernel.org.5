Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1837513C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjGLWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGLWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:51:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225A1991;
        Wed, 12 Jul 2023 15:51:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so7983381fa.0;
        Wed, 12 Jul 2023 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689202303; x=1691794303;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cIU/c/E226BSF5Ct8kPuHxBMkdexl3G5oO/oar1yg4Q=;
        b=rwQhOX9i6QWwbHTl6xNOa+h8wNi6MGBXMSPmMitEYOZRm3uDw2TR9gn9TW4xIoFy8d
         PqMjJmxusuxC8ks2zEDah4jBHrkk1N+eDjvoDmpT/OEKKP8BD9ywZcWDoZMnSMZCwwKt
         QnSjc9bXMWILCf4yPC+G/B1cpyVDecN6BwH2AkRzEsbJOADukfvxfHsu0hrVadUAaXKo
         a1yEPtZw3AtBbmWx5/cg9Y8lEVVJioPWmZPya7zSM8ohcRoxgl0/aiKkJa693guWa+WW
         CyRQia1cSKmNtnIv+yhu39SLtA6XYk/GjfwQhD1ma1HAGhkVKDuO2fgzDCNrhXoJMOb5
         MgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689202303; x=1691794303;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIU/c/E226BSF5Ct8kPuHxBMkdexl3G5oO/oar1yg4Q=;
        b=dV+QLDasfQcl+ENH+y1hK2ecQME8qX0ZQ/OZRlVk9ZlIMobcJP3s70IBPIHQf3Ujw7
         UP8lVQ626xbETa09+gC8RxYU8SmTj2BvYqMRGUXd2RCrgyYn0Hm8hUlD4BZr4eWiNnRq
         4EyB9fB6fhuOnjv27GIchUkzbdtzFTbEvkGJWFV0x1DK++Hore8qEsHvJ/BPGakaGnjJ
         K5UZv2BetMjjaaiVhxuVevE37s91zGmqVoebvffXUGlz2MJtaByKTnv0vvX5M3iAKGST
         oSVQheef0nFbAVzg/pGAJEujyvN+BWpm603qZRwu9Tv0jmDeuarmsQd9UtKKDvBUt+Mi
         Z8vg==
X-Gm-Message-State: ABy/qLbPlvK4PzdaGupBv3PfZv3zgieQu4Gnoybkrib9wWVvtNLsE//5
        go4LD9FBGRuVPmVSjovfLoU=
X-Google-Smtp-Source: APBJJlERmfvMOu+p718yPBMavsvTlkv+BYExDUjz5Fu7beribLO1sdBzez2lv9F9Wq49V2guUJoc7Q==
X-Received: by 2002:a2e:9c07:0:b0:2b6:b575:b26c with SMTP id s7-20020a2e9c07000000b002b6b575b26cmr16220851lji.47.1689202302475;
        Wed, 12 Jul 2023 15:51:42 -0700 (PDT)
Received: from [10.0.0.98] (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709061c0500b0099307520b8csm3090568ejg.29.2023.07.12.15.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:51:42 -0700 (PDT)
Message-ID: <4246badbbe4c106f965cc8758849390effc48c36.camel@gmail.com>
Subject: Re: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
From:   Jakub =?iso-8859-2?Q?Van=ECk?= <linuxtardis@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Thu, 13 Jul 2023 00:51:41 +0200
In-Reply-To: <20230711214834.kyr6ulync32d4ktk@synopsys.com>
References: <20230630223638.2250-1-linuxtardis@gmail.com>
         <20230705224754.zmffebz2geg3bclh@synopsys.com>
         <d4576e776d49498dcc1f82ddf2b81b415e0c6e4b.camel@gmail.com>
         <20230711214834.kyr6ulync32d4ktk@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Tue, 2023-07-11 at 21:48 +0000, Thinh Nguyen wrote:
> Hi Jakub,
>=20
> On Thu, Jul 06, 2023, Jakub Van=C4=9Bk wrote:
> > On Wed, 2023-07-05 at 22:47 +0000, Thinh Nguyen wrote:
> > > Hi,
> > >=20
> > > On Sat, Jul 01, 2023, Jakub Vanek wrote:
> > > > AutoRetry has been found to cause issues in this controller
> > > > revision.
> > > > This feature allows the controller to send non-
> > > > terminating/burst retry
> > > > ACKs (Retry=3D1 and Nump!=3D0) as opposed to terminating retry ACKs
> > > > (Retry=3D1 and Nump=3D0) to devices when a transaction error
> > > > occurs.
> > > >=20
> > > > Unfortunately, some USB devices do not retry transfers when
> > > > the controller sends them a non-terminating retry ACK. After
> > > > the transfer
> > > > times out, the xHCI driver tries to resume normal operation of
> > > > the
> > > > controller by sending a Stop Endpoint command to it. However,
> > > > this
> > > > revision of the controller fails to respond to that command in
> > > > this
> > > > state and the xHCI driver therefore gives up. This is reported
> > > > via dmesg:
> > > >=20
> > > > [sda] tag#29 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
> > > > [sda] tag#29 CDB: opcode=3D0x28 28 00 00 69 42 80 00 00 48 00
> > > > xhci-hcd: xHCI host not responding to stop endpoint command
> > > > xhci-hcd: xHCI host controller not responding, assume dead
> > > > xhci-hcd: HC died; cleaning up
> > > >=20
> > > > This problem has been observed on Odroid HC2. This board has
> > > > an integrated JMS578 USB3-to-SATA bridge. The above problem
> > > > could be
> > > > triggered by starting a read-heavy workload on an attached SSD.
> > > > After a while, the host controller would die and the SSD would
> > > > disappear
> > > > from the system.
> > > >=20
> > > > Reverting b138e23d3dff ("usb: dwc3: core: Enable AutoRetry
> > > > feature in
> > > > the controller") stopped the issue from occurring on Odroid
> > > > HC2.
> > > > As this problem hasn't been reported on other devices, disable
> > > > AutoRetry just for the dwc_usb3 revision v2.00a that the board
> > > > SoC
> > > > (Exynos 5422) uses.
> > > >=20
> > > > Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature
> > > > in the controller")
> > > > Link:
> > > > https://urldefense.com/v3/__https://lore.kernel.org/r/a21f34c04632d=
250cd0a78c7c6f4a1c9c7a43142.camel@gmail.com/__;!!A4F2R9G_pg!YWgF6oqfuVY6xst=
ZmroukjlrwAFEYEQE8uj_iUu4fd10mnJxEPG345k75dMLLdNFP8rT1leok-aPNkz_FuAJ1zxnmw=
$
> > > > =C2=A0
> > > > Link:
> > > > https://urldefense.com/v3/__https://forum.odroid.com/viewtopic.php?=
t=3D42630__;!!A4F2R9G_pg!YWgF6oqfuVY6xstZmroukjlrwAFEYEQE8uj_iUu4fd10mnJxEP=
G345k75dMLLdNFP8rT1leok-aPNkz_FuCzOGIVPA$
> > > > =C2=A0
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> > > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > > > Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
> > > > ---
> > > > =C2=A0drivers/usb/dwc3/core.c | 10 ++++++++--
> > > > =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index d68958e151a7..d742fc882d7e 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -1218,9 +1218,15 @@ static int dwc3_core_init(struct dwc3
> > > > *dwc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Host mode on seeing transaction errors(CRC
> > > > errors or internal
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * overrun scenerios) on IN transfers to repl=
y
> > > > to the device
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with a non-terminating retry ACK (i.e, an
> > > > ACK transcation
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * packet with Retry=3D1 & Nump !=3D 0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * packet with Retry=3D1 & Nump !=3D 0).
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Do not enable this for DWC_usb3 v2.00a. This
> > > > controller
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * revision stops responding to Stop Endpoint
> > > > commands if
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * a USB device does not retry after a non-
> > > > terminating retry
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * ACK is sent to it.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg |=3D DWC3_GUCTL_HSTINAUTORETRY;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (!DWC3_VER_IS(DWC3, 200A))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg=
 |=3D DWC3_GUCTL_HSTINAUTORETRY;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > --=20
> > > > 2.25.1
> > > >=20
> > >=20
> > > I brought up this inquiry internally. Please wait as I need to
> > > review
> > > this further. The handling for this may be different depending on
> > > the
> > > team's feedback.
> > >=20
> >=20
> > OK; feel free to contact me if I could be of any help.
> >=20
>=20
> Sorry for the delay. After discussion, this behavior is the same
> across
> different controller versions. The consensus is to disable this
> feature
> altoghether. There will not be any noticeable performance impact.
>=20
> Would you mind revise the patch to disable this feature for all?

Not at all, I have sent a new revision of the patch:
https://lore.kernel.org/linux-usb/20230712224037.24948-1-linuxtardis@gmail.=
com/

Reverting the commit altogether seemed preferable to me to updating the
revision-specific patch. However, if the other way would be better, I
can send an updated revision.

> Many thanks,
> Thinh

Thank you,
Jakub
