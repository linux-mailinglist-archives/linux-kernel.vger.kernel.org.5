Return-Path: <linux-kernel+bounces-32033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C9B835587
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2302822F9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202736AF8;
	Sun, 21 Jan 2024 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="dUiAyyKm"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3D4101FA;
	Sun, 21 Jan 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705837494; cv=none; b=L6RhmHEKROdvei/dIfhGl0mx3tTyNtrhPu2pTrqLPjVwJCbyrNCBPbsDwh/59wTLL5YzJX8YOeJfuXdo1s8ytDsIS3R4kCh7ZmO9mXFzELqYHuRwxpDVbYgT6JLI+l/cK0Zf41D5pYBOqjHnirGXsU+v/AwavIZxDUeBalY2UZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705837494; c=relaxed/simple;
	bh=/iiOZBUIKMJCyS5qs36JSqDPr7q1cQvorRERzDAmJws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCn48S4JKTT+6GWPcpIkzJtcWsAk/9Gi8WfHoxGURaMMtmuksj4ySqJcDNsS+h9AcJrJhlWTDTmt+dpd/hptUzErPnxICGpZvKprFVKhwBGUjWgCLFHw0TxFfouy4t5sa8SY3cVCneOR87FAQTgtYlW54ydhLPAtRqdzFMAFLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=dUiAyyKm; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705837475; x=1706442275; i=erick.archer@gmx.com;
	bh=/iiOZBUIKMJCyS5qs36JSqDPr7q1cQvorRERzDAmJws=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=dUiAyyKm+7gZQqEs7jaFs8x2W/DQfz0f42OP+RJ5/2PMssz43v68EW6iaqaFtYaG
	 1LawT22uXpek1K16Y+CBN9MHovfEP+GtkAKAZYY9YDkDJIZVvcOzaeX8LyHriyEOU
	 rLcqVJ0ysp/bgQOoTrEf00drWm0kS60ft3td5ysSOBYdyLHl9DAzuzlkliudIfxm/
	 WTHvpt2l1UpRk0uSMBj77tke+pkb+B4plcGN1t0y4IgC5ys1MnwR5IwGKfDBb4quk
	 n6NwcqF63eMJrBFU/PQY50bcpxOJtBpp0+f4ltEkjGDZne+fcwVtDPViqsn+jpngh
	 trGvzLpntWwe3x2JaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from titan ([79.157.194.183]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacOQ-1qqoaf051u-00cDUT; Sun, 21
 Jan 2024 12:44:35 +0100
Date: Sun, 21 Jan 2024 12:44:31 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation: power: Use kcalloc() instead of kzalloc()
Message-ID: <20240121105143.GA4546@titan>
References: <20240120120527.3866-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120120527.3866-1-erick.archer@gmx.com>
X-Provags-ID: V03:K1:cdmaWmbYoa/RJ2JKUL9HvdAuGmTiRdeyO/6pH/NsKM1VPkMfiVe
 zNCJ/FMQL313OPf3HK3JFf54Ee98zj09IJEPBtz7nSTdhhAyqRIH91H6IBgJmmFdxiGhwOO
 3tTmG8UtCRRkLFxPU0RFQcfef18OIGFz45mXwJDdiUu/zkklKoimC0/DSuomBNksz0hvpoG
 EpGHa3wUcydWaknK7XPgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rERkRzJHHsI=;z3yEKJpJHmLXTIz240asfeTKJ5M
 p0RBSc5bFwhpJDdkmwWDSxCtDWe772+ijFYA6gHVXjU1c7UO0KBOBvsygol8S9kkTiA6SMKXu
 KbBdmW5zL7f1vl+xEPBOR1UaSesQcAMNguD+/q1NJxihjuuyks4iqhJP8NtUxSIGbu9hBxCC0
 KAc+zLsErk9qX+5FqU5EJ9H58oYe/QK1vcO6/1lHOPAPzRBYUPZPEABcLIXLpY2tycRsKDT4l
 JQXd2oqEwpvXjvszagOL6VZCGjMU5bXT5TPk/1pH6C3K5XPDe+0FzV/j7gFPEMmVJ2RSkxz5X
 8E8+x+6j7rHZ0gQK6GbjPV64U1YeKVtPzlk9AEs/Zu6P37r0LLS5wu2ebnnLpln+2xQIjNOMA
 39ub25PsstoyU/mDAAQR21Clg2fMoqgmRndD+ptPExwRbn2yPlLMFlnfs1s2achgxifzbYMS+
 D2CHIG1u6obuzReOCDELsLboJzyxFEbYyx51huSfgcnr75JEM3IV/BXMuM/FV3GACEsN9/+90
 nPEY1N9T7xZLmCrd7PLCq4W3weEU4u28zmnHu09ujkuiyDCyQ10SON29xpfjhnmgmcOsDJtm9
 tjhkmGmU0Qf7BSN0LtVsX5xtIaX+3JTb57/k1TshCE+/GQaqUH4Z3+PkticFr+EvlHZoR5GtN
 SXaumvWfM6m1YnCoPvr2gvCsHCgLCFo6AZORCxlBj7Jbnl+KJF8nJh17b/0KDJ7rdFSQm/8A4
 umEkVhud8+gp9u0ftgyvBTa0CmFp21zcn4t0RBIgGqWcrdbTWNFQGE1z533XvkPrHevClwKEz
 vrJXuaYWLyyscqSee313ij6cCwwU3WZwMmcv6MvFiH6i3g62EykLaq+4F2LBFnrY/bargJ2+8
 xfPM8+wlkPnDLfHn7fCGs4GkgBgSJSOtuxXsdQznZmfklTLFGfWYgmEbx0P2WpQcsmuSY4eAk
 ZyOyR1unEgqIaTUXYfi58EpNs78=
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 01:05:27PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, in the example code use the purpose specific kcalloc() function
> instead of the argument size * count in the kzalloc() function.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Hi,

Drop this patch as a new version has been sent to change at the
same time the translations.

Thanks,
Erick

> ---
>  Documentation/power/opp.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
> index a7c03c470980..1b7f1d854f14 100644
> --- a/Documentation/power/opp.rst
> +++ b/Documentation/power/opp.rst
> @@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
>  	 {
>  		/* Do things */
>  		num_available =3D dev_pm_opp_get_opp_count(dev);
> -		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
> +		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);
>  		/* populate the table in increasing order */
>  		freq =3D 0;
>  		while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &freq))) {
> --
> 2.25.1
>

