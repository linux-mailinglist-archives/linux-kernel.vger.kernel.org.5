Return-Path: <linux-kernel+bounces-98927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B40878117
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FF7B22F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B703FBA4;
	Mon, 11 Mar 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QwiUryaj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD53FB9C;
	Mon, 11 Mar 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165483; cv=none; b=S4jfy0YZMdwVLYRpkp8HZjEgBbUHVU3e2GDMhS/4oLP2FOf+ufpQ8gWC3JVdhKIHelf9BOlnlww0M+vFbTTsIHm/CvTOGKALIcy9eTBVPfU3HDOgcXIqmodvOEEDtwStNApnZdqCYrqZ1deKC6ADDb5hAVdqkvhxGYTjKA+kT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165483; c=relaxed/simple;
	bh=FWMRXGnwN11kherO0jWB8E9UkYMhbotLeOkQfTIe/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIBuCXWMrQClsofjLDs5cBeZ7HGY1w97xuo1bahc91YXb1EQw2F+OVe/27mSiwh+DB+pa/Gt56hzNs5D35j7sQW28ANDlIYhV8MWKrsY6mbkw5ZN9lF/fLp3J5cDUTKpaowMBMVBx7OhB3/Ox++MHyNhECwzpd/q4Xkx9ctsB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QwiUryaj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710165480;
	bh=FWMRXGnwN11kherO0jWB8E9UkYMhbotLeOkQfTIe/z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwiUryajADe27ncwX2jdf5S6xpGZTCbkc1dKJAfEIXi43Ftqpmhd8iQpG/FYDpiJH
	 QachjINcFF7k4f8AKZ7wp0DwFzS7qLac36KqQtS3Avfrdk/Qf61sHGuvQ8lrLvfmIK
	 BPz+sKD8edRsJuFyNqOIXZ63QcyxEGLnL7hcYlq9zWoU+n1+UvJ4KXASsgErWs/81R
	 LaBHwFz5THIl4GHaygPGliwXcH1UnNTJq2RpEq+F2vGbRwrA2RahVubwC7Q+Rwh3vW
	 MvbQgqbDfvCOvtdQYWRN1Xl/mb+9WUKxJu/Oc6DJIn/wPtniwkoaBalUvaihAMQG3W
	 h5LkCV5IswixQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A1B4B37811D4;
	Mon, 11 Mar 2024 13:57:58 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:57:56 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, kernel@collabora.com,
	regressions@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: *-regressions.rst: Use collon after regzbot
 introduced command
Message-ID: <2d666b8c-96c7-4789-8282-6b28cd932920@notapiano>
References: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
 <20240308-regzbot-fixes-v1-1-577a4fe16e12@collabora.com>
 <82cf3fba-fdfa-4185-b2b9-c8ed8d123136@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82cf3fba-fdfa-4185-b2b9-c8ed8d123136@leemhuis.info>

On Mon, Mar 11, 2024 at 02:39:46PM +0100, Thorsten Leemhuis wrote:
> Thx for this!
> 
> On 08.03.24 15:09, Nícolas F. R. A. Prado wrote:
> > All the examples in the reference documentation for regzbot have a
> > collon
> 
> s/collon/colon/ here and a few lines below as well. And in the subject
> as well. Speaking of which: something like "docs: *-regressions.rst:
> add colon to regzbot commands" might be better.
> 
> > after the "introduced" command, while on the kernel documentation
> > some have and others don't. This suggests both are acceptable,
> 
> Yup.
> 
> > but in
> > order to avoid confusion, add collons after all the commands to match
> > the reference docs.
> 
> Yeah, good idea. I likely would have done this myself soon while doing a
> few other changes I plan, but whatever. :-D
> 
> > Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> With the changes above:
> 
> Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>
> 
> Side note: I wonder if the commit message could come a bit quicker to
> the point (something along the lines of "Use colons as command
> terminator everywhere for consistency, even if it not strictly
> necessary. That way it will also match regzbot's reference
> documentation.". But not really important I guess. Up to John.

Yep, all great suggestions, thanks. Will apply them for v2.

Thanks,
Nícolas

