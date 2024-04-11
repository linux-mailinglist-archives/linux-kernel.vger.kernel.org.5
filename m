Return-Path: <linux-kernel+bounces-140620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0F8A16EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694D1289442
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54ED14EC60;
	Thu, 11 Apr 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3MFGY6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E814F9F2;
	Thu, 11 Apr 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844949; cv=none; b=T/KKaJl9TbMLPU+ErmFxIGqJuIYC02/H8QqOQ2fTgvKmy34zW0pxEJuh93y8qgatblejwyrCFSuItLvLydfKvzur/ywrhPpMGp7KsveMsPQkEFNaZqi239W9a0ShTJhPMMRaKItyRgt3pYWPerSBfWzC1V67w9aq49dErC6m/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844949; c=relaxed/simple;
	bh=f3WgQJepv3I935Ux7AoYeAMSMCATyrlhQv6obAngiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7RILUnDRSQqLAkf5B4EPXAzE27CQXV6+7jFLtRfMzIHBy2Srp7UpaQg2cF03bDcpX4pOwBKTbjWgc+Y9xUrSfV80rp199HhkSEUe9mztZqR3EmBchQHBS3XEkxKkIxa1IRZAdep58bEMmr1kdDGI9yePEs4kRielkKalIyRxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z3MFGY6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E421AC113CE;
	Thu, 11 Apr 2024 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712844948;
	bh=f3WgQJepv3I935Ux7AoYeAMSMCATyrlhQv6obAngiD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3MFGY6E+LA/q+FY4yR6DIj3BbXWlUkNJxoiDLE5cmzOjMHbOHOqCMhD2ho8gG0XR
	 A2sBNmNjaY1t9FhE7E6oJKDYcX/wvL7AOVOV2acVU0XteJsICmQquYEgPDTGgpsmXS
	 3la3jKLhTTCbywbgj4Vh5Cr8vn5Jybcp3nZUrt2Y=
Date: Thu, 11 Apr 2024 16:15:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: elfring@users.sourceforge.net, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
Message-ID: <2024041136-demystify-destitute-cfd5@gregkh>
References: <20240411095412.671665933@linuxfoundation.org>
 <ZhfQjMUvOI1QXtDN@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhfQjMUvOI1QXtDN@duo.ucw.cz>

On Thu, Apr 11, 2024 at 01:59:08PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 6.1.86 release.
> > There are 83 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> > Markus Elfring <elfring@users.sourceforge.net>
> >     batman-adv: Improve exception handling in batadv_throw_uevent()
> > 
> > Markus Elfring <elfring@users.sourceforge.net>
> >     batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
> >
> 
> Questionable cleanups, untested, do not fix any bug, please drop.

good point, now dropped.

