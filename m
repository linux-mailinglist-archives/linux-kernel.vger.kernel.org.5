Return-Path: <linux-kernel+bounces-104778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F9D87D37B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DB0283EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A14E1D1;
	Fri, 15 Mar 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRjuN+kb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4944D9F5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526858; cv=none; b=HCn+NAh+lHTL+tc9oVYCFork27KSHwwZFuxRje3AZg5ioPnSkSfs9ViPQVLeR33kOVKBox35GWv+NW0QZRLDPEA1C5fCnZHCPG0qB8jmZDmWpSjCuTitGemITfwXsosSx94LHC32Zny0knIAkqwNN6PYlhg5r2KtYdtFIWQZi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526858; c=relaxed/simple;
	bh=oU+wtqKEvrb6U1ncUvd/CRehplkB5QsI8J8x8jxwUTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGVZNCNc5TSih34+mMW+YpDnQD9r6sGRrqpiUCcX8lfiRZZS60OGr5etjLq/1epF49d7jnTUcsFYiwCD4v+cvR5ylFCVTgMjxFoqB8Q0GTV83lo5+bsPvF9jpsAn2tPkBHf4N8YQIx0NVsLROix5oTnwWQ//wdBQ9zncwyBEDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRjuN+kb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413fea12b07so8630885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710526855; x=1711131655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5JX+srh6iZTx3hGWXMNjBUxtYKjAj6cKvbPfHIxw9s=;
        b=kRjuN+kbnQA3NvrlSXqHxJnzLsX28n+Ff8eXZ995/mi5pNF65xrsFRe9XbwE/aGMIB
         NNmg1PjRdm5y9Ksu5/SISbPELcbtc6lYCjnV2xnnKMOizjoDkEh236v46k6yiUoUx5TO
         DwiKBvTS7AdIiaW8xRSDdaeRKDxXvW4whSrtQaNXg5wYhySIBLlanhiKcPpYKz+ZLA3Z
         tJEBoIGAWR0QZLg137jqq3OCvAkszUpoNGq+enZIhx8jvuYBSatEwwfAB+CbKA/FGLIS
         qQw3jSXlgumjwXYCq3d+aXCvEj6nyhhJy5yt9A+lvLAlDv1JllgV//YA2YHbI48cga65
         Ql3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526855; x=1711131655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5JX+srh6iZTx3hGWXMNjBUxtYKjAj6cKvbPfHIxw9s=;
        b=JiQ9RuPeh5Zrlov4Ol7xPvasVbfKje8Uho9pxKuG9sMdimQ9anRMRu53yo7f0C2f+d
         PoOZ9iYs+A8w0PIrjj8LuSfxq02PeiD4vOuCiOt/facVPZGaX813sYxjNrXeWQhBBtMM
         1y94Cp4JYEafKhY+SGbXBOXvHis8p4Y0zMIBUt4a+YI4u9LZU6JzlS6dp/+QQRuu2oui
         0Z8PDRmITJPSayVLcG+CF7njol0VvMCjzMihABKnuzIThOaikmlKOP6oKP5Qy5hNjUII
         xi4QE6GgrV//oi7bxX6dp8PCXFiz9Y+pX38C3jVYgky80xUKEVa/Lhd4RMfE5r2Uy5K1
         A1eg==
X-Forwarded-Encrypted: i=1; AJvYcCX6uNJbDbhKu8+nNYWVv2KMehVtJNy7Cw+U6Qm3cn6vAKIJ1uKXlV6KYEVSlI7Gx5UtTLUUfs6xGx12AOtyq6BUBYdClMR2Au33zOG9
X-Gm-Message-State: AOJu0YyqoDUKFBG1U1cb3AReDRlzusBNSbCrw8SNTQGApZcOWwQIel38
	/rLZUkxX22zHUeO4yxqgSSrVgIcgxXO1k/rTBqo9Uv2W9y+YqNcsR6zWVYcL
X-Google-Smtp-Source: AGHT+IEUknJhMCD9YdOmBrb3UtAztWH/LqgLoBYSw8axnSvX5b5R6x5m4chC9UT+fQgPRGVgu3uimw==
X-Received: by 2002:a05:600c:314c:b0:414:1eb:287 with SMTP id h12-20020a05600c314c00b0041401eb0287mr1703304wmo.14.1710526854834;
        Fri, 15 Mar 2024 11:20:54 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b004122b7a680dsm6615005wmq.21.2024.03.15.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:20:54 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Kamil Kasperski <ressetkk@gmail.com>
Cc: wens@csie.org, samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dts: arm64: sunxi: add initial support for t95 tv box
Date: Fri, 15 Mar 2024 19:20:52 +0100
Message-ID: <4902501.31r3eYUQgx@jernej-laptop>
In-Reply-To: <bb9f1f58-67f1-49cb-aede-046ec6258ff1@gmail.com>
References:
 <20240311174750.6428-1-ressetkk@gmail.com> <4331305.ejJDZkT8p0@jernej-laptop>
 <bb9f1f58-67f1-49cb-aede-046ec6258ff1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 15. marec 2024 ob 01:57:21 CET je Kamil Kasperski napisal(a):
> W dniu 14.03.2024 o 17:50, Jernej =C5=A0krabec pisze:
> > Dne =C4=8Detrtek, 14. marec 2024 ob 01:19:28 CET je Kamil Kasperski nap=
isal(a):
> >> Hi Jernej, Andre!
> > Please no top posting as per rules.
>=20
> Sure. I'm not used to this kind of work, so please bear the mistakes I ma=
ke.

And line length should be 78 character max. Please read Linux netiquette.

>=20
> >
> >> Thanks for the reply. My board has a name "H616-T95MAX-AXP313A-v3.0".
> > Ok, we for sure need to integrate this somehow to compatible string, si=
nce
> > there are at least two incompatible versions.
>=20
> It's good idea to introduce dtsi with common configuration for both boxes=
 and add 2 new dts files with compatible string
> "t95,t95max-axp313" and "t95,t95max-axp305" with separate PMIC configurat=
ion. Similarly as OrangePI Zero got handled.

Correct.

>=20
> Not to mention, that it looks like arch/arm64/boot/dts/allwinner/sun50i-h=
618-transpeed-8k618-t.dts also has very similar configuration to my T95 box=
=2E Question is should we mix up the compatible strings for SoC?
> I know that H616 and H618 are almost identical SoCs, but if it's not only=
 a matter of documentation it's still better idea to push new dts.

Not sure what do you mean. We can mix and match whatever DTSI we want. Howe=
ver,
board compatible reflect SoC in them. So yes, if it make sense, Transpeed 8=
k618-t
can share same common DTSI, just board level DTS will have H616 compatible.

Best regards,
Jernej

>=20
> Best Regards,
> Kamil
>=20
> >> I believe these boards are two different revisions and the one with=20
> >> AXP313A is a newer one, besides incorrectly label as v3.0. Sharing=20
> >> common configuration between boxes is also a good idea but for this=20
> >> specific configuration I would be cautious. From my experience with th=
is=20
> >> board the default configuration for X96 Mate is not working at all. I=
=20
> >> suspect because of the PMIC and DRAM differences.
> >>
> >> Memory installed in X96 Mate is DDR3L and in mine T95 it's DDR3, hynix=
=20
> >> H5TQ2G43BFR, that requires 1.5V to operate.
> > PMIC is important difference, yes, but not DRAM. DDR3L is completely co=
mpatible
> > with DDR3. It just additionally supports lower voltages. Additionally, =
Linux
> > doesn't care about DRAM type and all. It's firmware responsibility to p=
roperly
> > initialize it.
> >
> > Best regards,
> > Jernej
> >
> >> The rest of configuration for both boards, like HDMI, MMC, EPHY and=20
> >> audio codec seems to be the same across almost all H616-based boxes th=
at=20
> >> I've researched.
> >>
> >>
> >> Moreover please let me update the patches and send v2 that aligns with=
=20
> >> mainline branch. I've incorrectly assumed to use sunxi fork instead of=
=20
> >> master. Sorry!
> >>
> >> W dniu 13.03.2024 o 19:00, Jernej =C5=A0krabec pisze:
> >>> Dne sreda, 13. marec 2024 ob 18:38:08 CET je Andre Przywara napisal(a=
):
> >>>> On Wed, 13 Mar 2024 18:25:14 +0100
> >>>> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> >>>>
> >>>>> Hi Kamil!
> >>>>>
> >>>>> Dne ponedeljek, 11. marec 2024 ob 18:47:47 CET je Kamil Kasperski n=
apisal(a):
> >>>>>> T95 is a most commonly known for being a box with a pre-installed =
malware.
> >>>>>> It uses Allwinner H616 and comes with eMMC and DDR3 memory.
> >>>>>> This device comes with two versions - one with AXP305 PMIC and ano=
ther with AXP313 PMIC.
> >>>>> I have this board and it always felt like a clone of X96 Mate, whic=
h is
> >>>>> already supported in kernel, except for broken sd card detection. W=
ould it
> >>>>> make sense to unify those two boards and just overwrite or update p=
arts here
> >>>>> that are not the same?
> >>>> I think the box you have is an older one, with the AXP305? IIUC, thi=
s is
> >>>> about a newer revision with the AXP313. There are quite some differe=
nces
> >>>> between the two PMICs, though it might still make sense to share the=
 DTs,
> >>>> see the OrangePi Zero[23].
> >>> Right, mine is with AXP305. It has "T95MAX v4.0" printed on PCB.
> >>>
> >>> Kamil, does your board also have "MAX" mentioned somewhere?
> >>>
> >>> Best regards,
> >>> Jernej
> >>>
> >>>> Cheers,
> >>>> Andre
> >>>>
> >>>>>> Kamil Kasperski (3):
> >>>>>>    dt-bindings: vendor-prefixes: sunxi: add T95 to vendor-prefixes
> >>>>>>    dt-bindings: arm: sunxi: add t95 compatible string to list of k=
nown
> >>>>>>      boards
> >>>>>>    dts: arm64: sunxi: add initial support for T95 AXP313 tv box
> >>>>>>
> >>>>>>   .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >>>>>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >>>>>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>>>>>   .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++=
++++++
> >>>>>>   4 files changed, 146 insertions(+)
> >>>>>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95=
=2Daxp313.dts
> >>>>>>
> >>>>>>   =20
> >>>>>
> >>>>>
> >>>>>
> >>>
> >>>
> >
> >
> >
>=20
>=20





