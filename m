Return-Path: <linux-kernel+bounces-91079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C653A870950
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82101282C68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB162141;
	Mon,  4 Mar 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DXzRlVfD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786060265;
	Mon,  4 Mar 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576236; cv=none; b=j+thPJq3TxaoiBPj23VKDRrQWdoHcFTwMZE/efuNRCvnK6cLTdXmzyErX1HfykbjMlKwjg64m9s3HGBGQZnj58gMOxTF5qoGB9xS1Zt5wbnrd+D51sFquva+mRjkWLK/8dXAxsRaawPBOgRJhtht9F6xaBymMBlLeoc0Cz+Frl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576236; c=relaxed/simple;
	bh=mGcU7Q/+0jxgOeDAGcFHkNyqKrKFJjMKqnfcQIcdE5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+AoQy+AnjulZXY8w0uKPrQiSMp+Sze5q4zJ8T/tXNqSC8Aqq13kCAFxJeq6Gy47gPnUMsV6OEgoYZNe1sTag0+r+m/Z1Wc51owshvaCYZ/1DczQV5Cpd+2X7kX7CC65yqe9iMrHWkFE856DPckAK6WEESJJu4rC1wtWSxGLI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DXzRlVfD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709576232;
	bh=mGcU7Q/+0jxgOeDAGcFHkNyqKrKFJjMKqnfcQIcdE5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXzRlVfDBER/2IW3C3rLcqjWTJoTzGp7X1SUCtdpqqcxxG4AOuXJ67twVAxjzthaA
	 2bMp7aGKZd06aiAFEOJ/1qlnbEOJFYZnuSlxr+W7zzecStWgEdHEjQztoi6N9Usiju
	 iC+LK9nF6XJAwhqxnu12I8dc04/YWQYf5+SidcHvrNWSbedBtIKx9vyabfsxkt3sp5
	 3Q4ttO5zIzm8BoweSqo2R+PlPjaYH4om2rMOgz4eiFAwKlH/Rn3oHSfgByxfbH1ATt
	 1VaxwHTSGynAw5cKD/DqWmNm15l1ThnbYho9lsJlNGquSWVwj0ltwhYCzwrZ3hU9hp
	 w78ddQrDJPEvg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E51E3780C6C;
	Mon,  4 Mar 2024 18:17:09 +0000 (UTC)
Date: Mon, 4 Mar 2024 13:17:07 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@collabora.com, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable
 cbmem in the arm64 defconfig
Message-ID: <533d8c52-3b7d-4390-984b-05fa55996e31@notapiano>
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
 <36df8535-083f-4ce3-84c7-b8f652a9085b@notapiano>
 <a9063efe-1faf-4945-83ce-449a23d44fc5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9063efe-1faf-4945-83ce-449a23d44fc5@app.fastmail.com>

On Mon, Mar 04, 2024 at 03:02:21PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 4, 2024, at 14:56, Nícolas F. R. A. Prado wrote:
> > On Mon, Feb 12, 2024 at 09:50:04AM -0500, Nícolas F. R. A. Prado wrote:
> >> Nícolas F. R. A. Prado (4):
> >>       firmware: coreboot: Generate modalias uevent for devices
> >>       firmware: coreboot: Generate aliases for coreboot modules
> >>       firmware: coreboot: Replace tag with id table in driver struct
> >>       arm64: defconfig: Enable support for cbmem entries in the coreboot table
> >
> > is it ok for Tzung-Bi to merge this last patch for the defconfig through the
> > chrome-platform-firmware tree?
> 
> I would much prefer to see this patch get sent to soc@kernel.org
> so I can pick it up through the soc tree. I'm usually not worried
> about bisection issues with defconfig changes since most users
> have their own .config anyway, and in this case I don't see
> any strict dependency and would just merge the patch directly.

Sounds good, I'll send it separately there. And you're right, the patch doesn't
have any dependency.

Thanks,
Nícolas

