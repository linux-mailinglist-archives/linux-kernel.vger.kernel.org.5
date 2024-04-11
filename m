Return-Path: <linux-kernel+bounces-141342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7D8A1CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB931C220A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086C155324;
	Thu, 11 Apr 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IpSGw3Va"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946694779E;
	Thu, 11 Apr 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853867; cv=none; b=CBSiFp4athaE8KcAki4bFCqCWK0Bf5ZMQyHMWAHb6a9NEZBm8yswyLt3l3DyvZnmuhwntbhAAenkvG7iq108hiSG6Gm58iwo9RqgFmBZ3qFjKcBfHP/HVUjkPGdsNewohN4CXS74hv6DnF4Kk1pxHd74J6Q2NTjL1LRo8j5zVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853867; c=relaxed/simple;
	bh=8mOIOrcpTE4F/7rNflGHUTplie+JZBjQPhk37lNYj1A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=S3dMos3SXNVUXrzVjDxn28mfdI56GbpEvkGWYtGkYbNPAWJR5NVbSRIG2S7hNecL9Sazk+q5rl3IgIHh4c1LelfZEOfVhCbdE35cOoyABGlkMmbJarNiY32piPsnCKeP8bkWL++XvBVOxMQ73q0pd7Kpfle9eF+OUDyE2V2G7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IpSGw3Va; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712853812; x=1713458612; i=markus.elfring@web.de;
	bh=8mOIOrcpTE4F/7rNflGHUTplie+JZBjQPhk37lNYj1A=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=IpSGw3Va7lx9pZL0ic2y1E7w+dmHgwke/sRDAjqIHKHipidXyrRQTLcmcheUQpYL
	 aoAne8U+37ScE60uEhhUbJHbxDZyaL+KtSVUwsKEfxKGBT/UXnpYp6wfPCjQrqDN0
	 bR6DFJoVeaZYUz8HGvA1+n9WLwvso7PWJbP4gz2qoAHFaC6DTMUmm1QxNR7lDQBu2
	 GVKV8RYdj1jUdRLnWrJgRuj5o9fKOaWYZHaUJP8MEt/exWKlPOWDOoxZ8G55mYZ4t
	 QezDv2+hm/sGqiHNOU3kAB+DXF9TU/ty1GGwuReOR6yLcltFn/bTna+5zsSlxoTNo
	 /gMLgjMX2YIYv9+Rjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myf3v-1sgjU11LIr-00z0sJ; Thu, 11
 Apr 2024 18:43:32 +0200
Message-ID: <3eef0167-5dd3-443d-80aa-f450a75550df@web.de>
Date: Thu, 11 Apr 2024 18:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org,
 kernel-janitors@vger.kernel.org, Ben Hutchings <ben.hutchings@mind.be>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240411031903.3050278-3-chengzhihao1@huawei.com>
Subject: Re: [PATCH v2 2/4] ubi: ubi_init: Fix missed ubiblock cleanup in
 error handling path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240411031903.3050278-3-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QlmEVZ2NncpGVwcZQl4z4ehY4fK4uOZghUxiEaN4yE5ZajFSLMT
 lnPZqsnzskvgbHrAgIffyBbmnTlbmMV0ZIqjiJ9VpsOCMhbdDhl4S8vX+sUl4OxH+6pNGFp
 pDuyguo5udjibqch/aOKbqifAsf/RLcYvnsGe8cFWkiFk3zKaV9PjYA844bekR0WCLl/lCA
 tmSVYf/QAvoWcZ2woJpjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/pmq13PeoG4=;UUwsLfyMu2kkGJeeT9w86o5neLa
 ejn0s48ReSKJwzAs2HSb34/gFO1zh9g2sjYB9Zi6zdN6ic/OZOXfM5OLnZdjmXlECpta/xT48
 XAwF6SfNxyfrlQI/Lx33fmBtqVhgLnLoY1f28T21E1SFJj1hvl7VE0C1ATkpM5isXuUMEXnS8
 xd4G6nEYJ1oH5LALtbHzvflF5jUPafO9GUgOMDCOl+20hLPN/CqfkyiLIPQngp/e8z3DkL8up
 eH4OM5kghxQpbp1XuY1YFuYboNyR4XbMWub954BnDAQx+wjglt8h/ulQoxqKKkoKBumikaNLz
 hTwMlmKMHkbWdOTEJ2qiDL0TvQWaOrO7586kHPGm4dkaYjbnbS+OOo0aMiKA5ukU54u1v2u17
 PsRMi/JE6Vz+lVtPIopCKX+4+CfCvGulUHeVWp/vHEtUJSRdwUatecwTvDsRDjF1KGJclHWak
 qeL/EqN9XvGRm1RMSFTorbJb7bxWwZmWknT/qwptX2PU78PapiEQlFImp+SsUT/IX+yPw1HiV
 vYocOjFFI4hI5n3llsK5sQDHHzs7cmgzMKpoJf+A9gMXrLWyoy9+DPc/6Fr4Alh049pZ8cigc
 gkSShubCVlHYUDKGT1EPbTgzjSMxMdqCm1DA06wySezfoUO/hZYdq8ytjzCZSY+xV3Ig5+5fV
 VOOdGbsnBwucpsQjvu7dB3/Rwchi9Wwm6T2YU2xcOamQbNQmZP/aah5IwUtQHnGmi3riMG/E2
 wz86451CS/TidNalmiWovqK9C303Oo3+Rp8SkOdW7fGOXUyBHBDgiXtoff/5oQ/KtCnRCv9nx
 1wyv/hZ3tdIdYV3KXxgNgBNQfp1I+icL6M1oDCHA9TWIc=

=E2=80=A6
> Since ubiblock_init() registers notifier and invokes notification
> functions, so we can move it after ubi_init_attach() to fix the problem.

I find this change description improvable.
Would an imperative wording be also more desirable here?

Regards,
Markus

