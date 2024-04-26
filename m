Return-Path: <linux-kernel+bounces-159522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05818B2FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415DB1F223E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E013A3E2;
	Fri, 26 Apr 2024 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DywkY+jI"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27751849
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109297; cv=none; b=YV3wMaPweDPP185ngaLTxw7M1BIFjzrhuZEArGG8Nvu/Qpik/6FPPT6plW/iepkIn8/EB6FSon1rEAn48elH3Sttt583FGvURa5hk1w0q1rOCHazxppsvvflt/nxwURUbXwENg/eZZ8drMGIs/Sva7lp94r5Uk/AuJO2GWfZpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109297; c=relaxed/simple;
	bh=YAygnoqbF/vIu/Fz13dn5xS/VaqxnlE0o1fwW+ngHyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JclCp9c8DE9ABZ66sZbgIKI77HTwWe67UQC43QW2bPWzInItmONxv0Q6RmfAPAVy+Jw4+HcboaNBVBd9mOP7SBBFYp9X4SGbMKnullO1i2/Y4K6zmqRi1yeeqN5bCM2zCvEqy/VMF+OXfsK7ivFakvRnkExWgje/fs8vGpXL2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DywkY+jI; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240426052814euoutp0211230ac9b4c49decea86b1839db63f02~JvVJEykG11513915139euoutp02U
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:28:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240426052814euoutp0211230ac9b4c49decea86b1839db63f02~JvVJEykG11513915139euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714109294;
	bh=Y0vn7kvvUs7lANm+ckOWReOOvG7PvdS8VqZnhGqmjwQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DywkY+jIaVZM9h3or6c9KR0QiEwluydAxb7ej8UARmVyLSkIVHUq3TqlD6zzqnjpn
	 /Xg1vsMf+yZGOwRScwwoHatKxv4ogE/wkpvJzQRK4OJlODyCSVO3ixeU6KkkQPAjsn
	 u1cE0ztpX/6OMIq22DVPWiIR8P+vrdRqsntPhB3o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240426052813eucas1p25799080f97e67dbe9c37c4328e93a3f5~JvVIvHZN82689226892eucas1p2U;
	Fri, 26 Apr 2024 05:28:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 88.A9.09624.D6B3B266; Fri, 26
	Apr 2024 06:28:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240426052813eucas1p25e736cfb470e6d41dd664359157e2d9e~JvVIRJrNl1721617216eucas1p2B;
	Fri, 26 Apr 2024 05:28:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240426052813eusmtrp2b5764e97e75a237e66c324ca891820c2~JvVIQSCvn0040400404eusmtrp2p;
	Fri, 26 Apr 2024 05:28:13 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-6e-662b3b6d6312
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.66.09010.D6B3B266; Fri, 26
	Apr 2024 06:28:13 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240426052811eusmtip17296696e51201f48097f3ca94170befa~JvVG8TDWP2254022540eusmtip1f;
	Fri, 26 Apr 2024 05:28:11 +0000 (GMT)
Message-ID: <c9e8ef97-8c06-4c85-9326-128740b2c7fd@samsung.com>
Date: Fri, 26 Apr 2024 07:28:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch
 calcalcuation rounding
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, marex@denx.de,
	aford@beaconembedded.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
	Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
	Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
	<jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Marco Felsch
	<m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAHCN7xJRgW4Y3YML+tToPw1TgA3o158XCEUcb9p-S+nvDWgzRQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGee9XL2XVe4uEVyVgGnGbTqRuZC/BEGYG3s1JcB/BzZitgQuS
	QSGtzDkxKzMWW5y0EDdp+ehWBcRZMihkFGSxUaBBycaHjg53CSMSGQq1uEWNMsqtG//9zjnP
	k/OcNy+Nyy3UOjpPfYjXqFX5CkpKdPQ+GtxakLQlJ/5Jyyto/PcBHHWNlktQ/63vMSTY/QRa
	7DDjaOThHIW+Pj9IokrBRKCFVhOFpusdAHlmRwlkMJ+ToGFXDYXmXaM46mha0n3nayfQrL4U
	IL2hgURznV6AKuvGSOScNZMpEdwln0Bydxt1OFdn6Se4y3/bCK7TclvCWU9Wk5y9+y7GtTYb
	KO7qqJ3k+k1DGDd+s5vi6jx7OaG8D+MqnsZzp53NgGsbOJrBfiTdkc3n533Ga7YlfyI9eM7e
	hBXNrf3cbe0kdWAg3AhCaci8Bi96yzAjkNJypglAoWoeiMUCgH7PHVws/AAu1k2A55aJb4YJ
	cdAI4J/O0qDfB2BP24klFU3LmGTYW50cMBBMLNR3CXiAZQwLPdVTRIAjmBgoeM9KAhzO7IML
	VT8sa9YwCnj7+tPlGDhzioIXR2qXRTgTCb1T9ViAKUYJjfeMVIBDmb1wYWqOFDUx8Hi7dTk2
	ZM5IYcOwJxj7TXh68I8gh8OZPqdE5Ci42FmPiYYyAG1PhGBhAlA37Q06kuD44GMqcBrOvAxb
	XNvE9hvwhquHDLQhswr+do8VQ6yClR3f4mJbBk/q5aJ6E7T0Of5be+WXIdwEFJYV72JZcaZl
	xTmW//faANEMIvlibUEur1Wq+cNxWlWBtlidG5dVWNAKlr7vwLO+Bz+B2hlfnBtgNHADSOOK
	NbIx30s5clm26sgXvKbwY01xPq91g/U0oYiUxWbH8HImV3WI/5Tni3jN8ylGh67TYaEnXszS
	xdwv3Kfz77zQnpK6J+tqiXO77t0SCeumsa/SnWP2y7uOODan5m3Q5bxVgb+T9+tqhN1R9nRZ
	zEJm0Y8NibW3TNuvcbJrO+SpbPTxGnS4GB+6nzY/NHdg5qEjvr9l46YPExtii569nuOeDNHt
	TthfW5NhD7OOsPTGSVnBl34Xy17IfK8iQmobLWd7k9ISow2o10aFHFW+ulOhOHWlzf/42F/n
	EzbcyIpWs+sjYjPtFT2zKcdCOhu7FUwWG2UNO7vHqiT/MW8ZcUdN7pJUhXlUDxLCPnAOp1+a
	3l9yUyj5+QWl8YDc8f6EgXg7Xp8x8Cg9Tro2Iq2sYev1UgWhPahSbsY1WtW/l5wUBy0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsVy+t/xu7q51tppBjePcVvcuX2a2WL31W52
	ixPXFzFZ3F/8mcXi/7aJzBZXvr5ns+hdeo7VYtL9CSwWXzZNYLN4Pn8do8XJN1dZLDonLmG3
	uLxrDpvFh11XmS22rQCqW/hxK4vFm7ZGRou2zmWsFu933mK0mDTvJqvFljcTWR1EPdZ+vM/q
	8XJ5A7PHvFknWDz2flvA4rFz1l12j9kdM1k9Fu95yeSxaVUnm8eRq4tZPU5MuMTkcefaHjaP
	eScDPe53H2fy6P9r4NG3ZRWjx+bT1QGCUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
	5rFWRqZK+nY2Kak5mWWpRfp2CXoZSxavYCp4L1lxaPZO1gbG08JdjJwcEgImEg+mXWbpYuTi
	EBJYyihxru0mE0RCRuLktAZWCFtY4s+1LjaIoveMErt2TGTsYuTg4BWwkzg20w6khkVAVaJt
	931mEJtXQFDi5MwnLCC2qIC8xP1bM9hBbGGBCImbU5vAbBEBJYm7Z/4ygtjMAj1sErfe10PM
	384k8f7we1aIhLjErSfzwQ5iEzCU6HoLcgQnB6dAoMSXJzA1ZhJdW7ugBslLNG+dzTyBUWgW
	kjtmIRk1C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSmmm3Hfm7Zwbjy1Ue9
	Q4xMHIyHGCU4mJVEeG9+1EgT4k1JrKxKLcqPLyrNSS0+xGgKDIyJzFKiyfnAZJdXEm9oZmBq
	aGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cC0o1Zs/rR8O+45PyfZfdni+L4m
	oHretLcF7Q6rz1QKNzhuiDvdVbplgVtj+fENQfeTDUO/ye9yNbLfMVFQyf5IxJ8VO3IzquJm
	qXVwXFP7s/0pp9SvIpf2lbpb+VaWfl2dprahjyXmZPqb09/VPDI+hSiJbZTzttii7bFhefjk
	1zytqdzssiJXmBdwip65Ze4XsVkmQCH4YtpTf+df5ot2hBx9Hdox74HQzY5n7GsXTrKSyrxp
	uNaqXniOluWrZ7rnJdg7eKckSqm2nSu49/3akWMqN3dMMlro0TOPXbpn0QktlcfuO94uP7yl
	q2u1X8bp3jDtLDcjNo7H+bGZ6bk7NHpfBnx1WP5EdZ16pYESS3FGoqEWc1FxIgBHnn3ovgMA
	AA==
X-CMS-MailID: 20240426052813eucas1p25e736cfb470e6d41dd664359157e2d9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270
References: <20240211230931.188194-1-aford173@gmail.com>
	<CGME20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270@eucas1p1.samsung.com>
	<20240211230931.188194-2-aford173@gmail.com>
	<6fcfe1bb-a1e9-4d7c-aff7-e572bcdf5d31@samsung.com>
	<CAHCN7xJRgW4Y3YML+tToPw1TgA3o158XCEUcb9p-S+nvDWgzRQ@mail.gmail.com>

On 25.04.2024 22:30, Adam Ford wrote:
> On Thu, Apr 25, 2024 at 4:19 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 12.02.2024 00:09, Adam Ford wrote:
>>> When using video sync pulses, the HFP, HBP, and HSA are divided between
>>> the available lanes if there is more than one lane.  For certain
>>> timings and lane configurations, the HFP may not be evenly divisible.
>>> If the HFP is rounded down, it ends up being too small which can cause
>>> some monitors to not sync properly. In these instances, adjust htotal
>>> and hsync to round the HFP up, and recalculate the htotal.
>>>
>>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Thank you very much for testing!
>
>>> ---
>>> V2:  No changes
>>>
>>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
>>> index 8476650c477c..52939211fe93 100644
>>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
>>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
>>> @@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
>>>                adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>>>        }
>>>
>>> +     /*
>>> +      * When using video sync pulses, the HFP, HBP, and HSA are divided between
>>> +      * the available lanes if there is more than one lane.  For certain
>>> +      * timings and lane configurations, the HFP may not be evenly divisible.
>>> +      * If the HFP is rounded down, it ends up being too small which can cause
>>> +      * some monitors to not sync properly. In these instances, adjust htotal
>>> +      * and hsync to round the HFP up, and recalculate the htotal. Through trial
>>> +      * and error, it appears that the HBP and HSA do not appearto need the same
>>> +      * correction that HFP does.
>>> +      */
>>> +     if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lanes > 1) {
> Frieder  &  Marek S,
>
> Marek V is proposing we eliminate the check against the flags and do
> it unconditionally.  If I send you both a different patch, would you
> be willing to try them on your platforms?  I don't want to risk
> breaking a board.

I'm fine with testing it. I also have some additional spare boards to 
replace the broken one, but so far none was bricked by my weird testing 
activities.

> I used the check above from the NXP downstream kernel, so it felt
> safe, but I am not as familiar with the different DSI modes, so I am
> not sure what the impact would be if this read:
>
>   if (dsi->lanes > 1) {
>
> Does anyone else have an opinion on this?
>>> +             int hfp = adjusted_mode->hsync_start - adjusted_mode->hdisplay;
>>> +             int remainder = hfp % dsi->lanes;
>>> +
>>> +             if (remainder) {
>>> +                     adjusted_mode->hsync_start += remainder;
>>> +                     adjusted_mode->hsync_end   += remainder;
>>> +                     adjusted_mode->htotal      += remainder;
>>> +             }
>>> +     }
>>> +
>>>        return 0;
>>>    }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


