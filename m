Return-Path: <linux-kernel+bounces-148384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF088A81D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EABFB25C53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E613C8FB;
	Wed, 17 Apr 2024 11:14:27 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906313C68A;
	Wed, 17 Apr 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352467; cv=none; b=Xl9KMYjqiWXVtFeIhBARzIra9E0ufqyXUrco+iiJN+cE7yfymRW2BLmUK7lsZMsVkf96k7seVIQirZwB1ui92SwQv/k8flYk8vzuTZgns7AkVssyvtzw59sco1qR/ZE6lZ/KLiXJYtxdnUqdHRLxGcO2QXHmuRYjh6ah/IDmC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352467; c=relaxed/simple;
	bh=Gl1vItHn+rNA+MEGIq5JA3lS5NZmhUbWAoI2YhYHJTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsM5I4ZHhNsK1v42NDj0YK1MqvzDTydIGtOglBEmVZuDPvZ2PAl4oA5SHmvORK2XjSOeuYeWBK/7h6Ig6pt7+M5zqwq1PFBEXaWr52lTMPQAtGxO7hHXF6jce9laWPRtMI3ViiR/o3B/+f+qs0M+2JRGwJ+wPy1MCfEmnGl1lDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rx3En-0003qh-00; Wed, 17 Apr 2024 13:14:01 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D8324C0168; Wed, 17 Apr 2024 13:13:48 +0200 (CEST)
Date: Wed, 17 Apr 2024 13:13:48 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] MIPS: SGI-IP30: Use bitmap API when iterating over bitmap
Message-ID: <Zh+u7JM358bCntr7@alpha.franken.de>
References: <20240417071830.47703-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417071830.47703-1-philmd@linaro.org>

On Wed, Apr 17, 2024 at 09:18:29AM +0200, Philippe Mathieu-Daudé wrote:
> Do not open-code bitmap_set(). Besides, <linux/bitmap.h> API
> allows architecture specific optimizations, so prefer it.
> 
> Use the HEART_NUM_IRQS definition to express the end of the
> HEART bitmap.

please use HEART_L4_INT_HEART_EXCP + 1, like what the code did before.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

