Return-Path: <linux-kernel+bounces-112631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBA887C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E761F21527
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD51756A;
	Sun, 24 Mar 2024 10:28:21 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF7168B9;
	Sun, 24 Mar 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711276100; cv=none; b=FOpH4tK3H5K3ECdiKqjTRqdsGapUsxlbd5vNQe9jSTwcadxF3xWGb3V7U/8VLQUe+WwY38asIDuQnx8W80xxRlzlLYi6+dLSrOKC46WdpjelTb+4a+YjIv6Vd+u6ucSPWrfll3+9uYD4YfgZWxMG+VKvRb1QYKXOqBOQuyJls1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711276100; c=relaxed/simple;
	bh=R92CvuI0wRWplyImURWd+63ngxUZuydpFkQzB8D+C8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwE1DPV/FU6RIdYyrA2k7Qf2xsBcOybC0co9wj1oQ2vR5oNVIR6y6YYrUTFdaJ+uBK+f746Z5LKsOSMJbjkOWKAE20H7mG3DdbJxCuvyPyhKub3A4WgNEaXmVbQKS9Yfd+Jc92BGuXC+Zd+k/x1ui9i2yYC7EnlcfG+Cj+ubEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1roKme-0008DD-00; Sun, 24 Mar 2024 11:08:56 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 8DA64C0267; Sun, 24 Mar 2024 10:37:54 +0100 (CET)
Date: Sun, 24 Mar 2024 10:37:54 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: mengfanhui <mengfanhui@kylinos.cn>
Cc: geert+renesas@glider.be, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config/mips: support zswap function
Message-ID: <Zf/0clNxqiEUb0VS@alpha.franken.de>
References: <20240126075547.1521556-1-mengfanhui@kylinos.cn>
 <a38359d5-0fde-439c-bc04-3452a34482da@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a38359d5-0fde-439c-bc04-3452a34482da@kylinos.cn>

On Wed, Mar 20, 2024 at 10:00:49AM +0800, mengfanhui wrote:
> Who will be responsible for reviewing this? This is a necessary feature of the kernel that many testing agencies need to test

so they should add it to their kernel config. I don't see why a default config
should collect every bell and whistle somebody out in the world needs.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

