Return-Path: <linux-kernel+bounces-51851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFF6849003
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8022837CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2025558;
	Sun,  4 Feb 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="MsyROH5e";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="BAmgq8bv"
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D64250ED
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707073934; cv=none; b=JNAdoEIgnUyujALjegmKlKcSP7s5WnA8nQmegB4I8bl+3Q0cFVHAZq08x1UunX2B+wAXtNnBg9NyfcVHfiR0P6wcr0/7UJ/vFJplAdqCp64eAZHH6gTTO8x1xbbm6DDueDqY/rn3QyW3M+6JITnCumfminvqkkERfdAnFpiLqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707073934; c=relaxed/simple;
	bh=EAtoAQ3+u49g8oG47jFKJk9i8V8wtqouRudycbUsgm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3GWpbTPN4xspxuhbRGUjWrRduWRlWS7wHrG6kwIGjPcWWzY+0+1STJYRfMMf6xQ+jrHRMtr5W8S7qcVdeQrnZhzNng667FFZ430dKe1HOMLRUBlLKB9qG1xYokzt2iJmlybxbHe6+u5/je4cWoDDz6uKlVDdNXcS7I2egsQLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=MsyROH5e; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=BAmgq8bv; arc=none smtp.client-ip=46.30.211.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=5U9Gn9tK/aP/N7YmuXyVhqmYDMBaUO/VArhiN55jyt4=;
	b=MsyROH5eAE/5FKulTyMOo0n/tFzoqCqrXHMy0SZv5yF9zzgSCmmybzMh/ap6fCTHQUxC1xJopDxNV
	 8KvdoFwtpVDmxRYI1SBsivExanNI/Qj/wYfzjkvd10C96qGIkxZaOS33gB2wMCoYQY+nsIHJvOtBa3
	 g1mzKQoC5YwCpUAWskYt6M6XMsC2njUn+CqLBcPOvo5OIu9vvd27bN4zUSjQExqthIa0i47igK0252
	 vyWrIDmFTslGyc5wtVxTo/lahYcR3xLVWQX4n1X6zpMeSlDMMeZRdCNGnBIcgO0MfTdIcUiQs1DZEN
	 Kf8O5AJMUnnfJAK7BTewFytz10uBaxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=5U9Gn9tK/aP/N7YmuXyVhqmYDMBaUO/VArhiN55jyt4=;
	b=BAmgq8bvF8S938DBAk8hWdYpOkJug9UxKC28dT9ight4DlgS9se1rZGGkSy3s/ZCJ87VQDe4heFAA
	 pmEjcB9Dw==
X-HalOne-ID: 202361de-c391-11ee-86d6-dfbeffc51846
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 202361de-c391-11ee-86d6-dfbeffc51846;
	Sun, 04 Feb 2024 19:10:58 +0000 (UTC)
Date: Sun, 4 Feb 2024 20:10:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] sparc: vio: make vio_bus_type const
Message-ID: <20240204191057.GA896678@ravnborg.org>
References: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>

On Sun, Feb 04, 2024 at 12:19:50PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the vio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

