Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAA7D0C40
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376701AbjJTJtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376629AbjJTJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:49:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA896D49
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:49:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so897241a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697795370; x=1698400170; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y44OW1J6JIDiZk1ndwKKkQEZ9MRTX8zlFxWnOFyWMHw=;
        b=GCvScr0TGlDunaG0QzaIyfycIG6wgJJ6B0+8dBGBYJXTpCAA6WTsHDWQQtXKKWc3XE
         i9pHZ/BUWamiqauziyqvZHtGqjHmSNm6bunSSqq3KMqcPCufLIDCsirwo6QM5h0FkyUA
         zqCaYPrUgMRJZSzr+6SzfjA3zzNQieg67d8nPaJ+x2bfebw6KIx0jNKRDrR4SVQTUBbz
         /7T0PJDwATQbTFd13QFRlt77XgEhQiYGfIj2F9UkTfMeYsTmGwWTDcHweSzK0+aXKsje
         j6WhSZHMUOlMwE+9Y8vA9sYyQIn2NQcVes4s+/UDGWxYTZO98UQTRRyFW3wpzUtf/ptn
         haCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795370; x=1698400170;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y44OW1J6JIDiZk1ndwKKkQEZ9MRTX8zlFxWnOFyWMHw=;
        b=B7YRwP/R8/Cmo0htRhJZq1CeJLC8bkwfLZCFUyxuGrOzUYFiBQ4H9si3QeqMgVzqRy
         5VVnv/lqrOjyN4L4KZXHpg99iJ1pAcEvEhBvzTb6otgw4joYngxE5KCZ1R91AFNlMzS4
         +kcHzrf3qxePsYg2tX5B0gNgKalAuYR7+qMx4CUb5RNInTO3x+MknfWg6EGn9eafKqs3
         OCkyOTiR+z3t+FQTa6Z33YpZIF1T28S2A4VL4pyDPCpqUyoJEF4SF13AlItqHfEHyejv
         sOakWmobl0YjmLQs4OfvcgT4DX1A5OIWj4eJTnfaaHlWqUSGm55hglPMUWSJBfNihwoM
         VPRQ==
X-Gm-Message-State: AOJu0YzF3RvNo1xweEHCp3Bix2MEAv8ZOIWDwew8nue6PVp4cStCE1fe
        Akmz2jJcPazHhA0kL6ZUM+m0gQ==
X-Google-Smtp-Source: AGHT+IEV1HsuFwDhHijM/7iC+A50rGae2ktwLJK4dZ7FF06nmrK6c3QxSHS7T8JUbYnkd0qj59n6bA==
X-Received: by 2002:a17:907:c18:b0:9be:bf31:335f with SMTP id ga24-20020a1709070c1800b009bebf31335fmr989381ejc.46.1697795370105;
        Fri, 20 Oct 2023 02:49:30 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id pw7-20020a17090720a700b00992ea405a79sm1139574ejb.166.2023.10.20.02.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 02:49:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 Oct 2023 11:49:27 +0200
Message-Id: <CWD6889N9X4U.3N5P65PFK5XK1@fairphone.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: typec: add support for PTN36502 redriver
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     <neil.armstrong@linaro.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
X-Mailer: aerc 0.15.2
References: <20231013-ptn36502-v1-0-98109a430efc@fairphone.com>
 <20231013-ptn36502-v1-2-98109a430efc@fairphone.com>
 <ZS5HAQrUObdhHSdV@kuha.fi.intel.com>
 <CWD1MKL68P2V.1QBJXJ0E5U171@fairphone.com>
 <f29c43c6-0e73-4c04-9180-6c6088ab1f8a@linaro.org>
In-Reply-To: <f29c43c6-0e73-4c04-9180-6c6088ab1f8a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 20, 2023 at 9:18 AM CEST, Neil Armstrong wrote:
> On 20/10/2023 08:13, Luca Weiss wrote:
> > On Tue Oct 17, 2023 at 10:34 AM CEST, Heikki Krogerus wrote:
> >> Hi,
> >>
> >> On Fri, Oct 13, 2023 at 04:24:48PM +0200, Luca Weiss wrote:
> >>> Add a driver for the NXP PTN36502 Type-C USB 3.1 Gen 1 and DisplayPor=
t
> >>> v1.2 combo redriver.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>
> >> Looks OK to me, but couple of nitpicks below. With those fixed:
> >>
> >> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >>
> >>> ---
> >>>   drivers/usb/typec/mux/Kconfig    |  10 +
> >>>   drivers/usb/typec/mux/Makefile   |   1 +
> >>>   drivers/usb/typec/mux/ptn36502.c | 421 ++++++++++++++++++++++++++++=
+++++++++++
> >>>   3 files changed, 432 insertions(+)
> >>>

[snip]

> >>> +#define PTN36502_CHIP_ID_REG				0x00
> >>> +#define PTN36502_CHIP_ID				0x02
> >>> +
> >>> +#define PTN36502_CHIP_REVISION_REG			0x01
> >>> +#define PTN36502_CHIP_REVISION_BASE(val)		FIELD_GET(GENMASK(7, 4), (=
val))
> >>> +#define PTN36502_CHIP_REVISION_METAL(val)		FIELD_GET(GENMASK(3, 0), =
(val))
> >>> +
> >>> +#define PTN36502_DP_LINK_CTRL_REG			0x06
> >>> +#define PTN36502_DP_LINK_CTRL_LANES_2			(2 << 2)
> >>> +#define PTN36502_DP_LINK_CTRL_LANES_4			(3 << 2)
> >>> +#define PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS		(2 << 0)
> >>> +
> >>> +/* Registers for lane 0 (0x07) to lane 3 (0x0a) have the same layout=
 */
> >>> +#define PTN36502_DP_LANE_CTRL_REG(n)			(0x07 + (n))
> >>> +#define PTN36502_DP_LANE_CTRL_RX_GAIN_3DB		(2<<4)
> >>> +#define PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD		(2<<2)
> >>> +#define PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB	(1<<0)
> >>> +
> >>> +#define PTN36502_MODE_CTRL1_REG				0x0b
> >>> +#define PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE		(1<<5)
> >>> +#define PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON		(1<<3)
> >>> +#define PTN36502_MODE_CTRL1_MODE_OFF			(0<<0)
> >>> +#define PTN36502_MODE_CTRL1_MODE_USB_ONLY		(1<<0)
> >>> +#define PTN36502_MODE_CTRL1_MODE_USB_DP			(2<<0)
> >>> +#define PTN36502_MODE_CTRL1_MODE_DP			(3<<0)
> >>> +
> >>> +#define PTN36502_DEVICE_CTRL_REG			0x0d
> >>> +#define PTN36502_DEVICE_CTRL_AUX_MONITORING_EN		(1<<7)
> >>
> >> You have couple of different styles here. Please try to always use
> >> BIT() and GENMASK() macros when possible. At the very least put spaces
> >> around << and >>.
> >=20
> > Hi Heikki,
> >=20
> > I was wondering when writing that whether GENMASK was actually proper
> > use for values you write to registers, when not actually used as a
> > bitmask.
> >=20
> > Since the datasheet refers to e.g. with TX_SWING_800MVPPD (2<<2) that
> > you write a '2' to the correct bits of this register. But when using
> > BIT(3) kind of hides this relationship if someone refers back to the
> > datasheet. Or same with "3<<2" -> GENMASK(3, 2) or whatever.
>
> The proper way is to define the MASK for the field GENMASK(3, 2) and then
> use FIELD_PREP(GENMASK(3, 2), 2) to write 2 in this field.
>
> You could replace with:
> #define PTN36502_DP_LANE_CTRL_TX_SWING_MASK		GENMASK(3, 2)
> #define PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD		(2)
>
> and in the code
> lane_ctrl_val =3D FIELD_PREP(PTN36502_DP_LANE_CTRL_RX_GAIN_MASK,
> 			   PTN36502_DP_LANE_CTRL_RX_GAIN_3DB) |
> 		FIELD_PREP(PTN36502_DP_LANE_CTRL_TX_SWING_MASK,
> 			   PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD) |
> 		FIELD_PREP(PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_MASK,
> 			   PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB);
>
> It's a little more verbose but it's much clearer and defines stuff correc=
tly,
> no confusion possible.

Thanks for the advise, I'll update for v2!

Regards
Luca
