Return-Path: <linux-kernel+bounces-61515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222485131A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650011C20CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B43A1C7;
	Mon, 12 Feb 2024 12:05:19 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205453A1A2;
	Mon, 12 Feb 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739518; cv=none; b=dbKf2LxUH3alzidaXniygkvV21wssjaAnCdf3Yc6wNyO9O9xWIzEBS5FAv83QehHqA254QI/etHsdgRdNdSg8wWcGYCBHCZJJXtehslv1PgptVJoJEnm+rP+FQWAErJG4rhZTqK2CLdtkC8ByiwXLINSXjBcfV5p1UjBhrxznF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739518; c=relaxed/simple;
	bh=E3KFB6K5OgQs2dHpXglx69hmIvkGlu7uEPBJjLo5jMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSCNy5vu2KJLRvxl4Cqo90SedGQlCdmS7sDlm3tGOYt7xeqL1aZQJt7VcssspOtwgSe6jKb+5mI5J6q8FtONqskpi18bxODcL/YOhR+PGyTCPoDV7MmYs34Ta8obMrLXwDM45G728q2Ic4XrRxv9CW92lTXcKsdo1zG52kS7FAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 0F1466F065;
	Mon, 12 Feb 2024 12:58:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id qrdKvZuhnK0i; Mon, 12 Feb 2024 12:58:40 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id 91EF76EF02;
	Mon, 12 Feb 2024 12:58:39 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id 2722E472; Mon, 12 Feb 2024 12:58:39 +0100 (CET)
Date: Mon, 12 Feb 2024 12:58:39 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop
 redundant GPIO node
Message-ID: <20240212115837.efz73yxinkysdmgh@runtux.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
X-ray: beware
User-Agent: NeoMutt/20180716

On Mon, Feb 12, 2024 at 12:25:48PM +0100, Krzysztof Kozlowski wrote:
> 
> Hm, I don't understand how exactly it helps. The GPIO expander has its
> own example and as you pointed below, this is basically the same code,
> except rw and backlight GPIOs.

The hd44780 is a display that is very often used.
By people (like me some time ago) not familiar with the nice io expander
implementation in Linux. The consequence of that is that you'll find
several out-of-tree implementations for this display with i2c out in the
wild. So my thought of documenting this (again) at that location is to
make it easier for people with a hd44780 with the standard i2c interface
to see how it is done in Linux.

So I really think it helps. It would have helped me :-)

Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

