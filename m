Return-Path: <linux-kernel+bounces-163764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7AE8B6F92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59677282DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6D13D268;
	Tue, 30 Apr 2024 10:23:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1F129E98;
	Tue, 30 Apr 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472589; cv=none; b=OavGUIv+j25hW9SbDpS4GLrbW1SneV3AOrX8CmV1ShQ+1C9XqoRi6RPjSBLOHKV6nWYZ0VEtmidQhH+P1X4nFN7CwQKwwC8y6dvQ1FV6ij4/+tOTaQUd35F6bwU5Uy9FGtJd3gzzpNtbnEjZnnJgw58w/jKkl+GwC3tsuCR5PKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472589; c=relaxed/simple;
	bh=BycYa9Bjts6l6h8wDIs/N76MQ2we6WqNtdkymDZ5UWc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka4f83N+cj5yIz6xRJwh8y6nDFo/tpeSB3uQFV1yIk73zj6zz/29rayYkUtx3xyHaHueQELkWL+5lhPDVbGgX7+Z+bOkQCXOBx/ZGM7+ooDqfteAV4xbLQEL8E7FsAleFvyBWpFEpAX8Q9vDfFSPSTIpHV3ZT9Hd4auTGD0w/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTGVH0bz4z6K8xB;
	Tue, 30 Apr 2024 18:22:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D76C9140B2F;
	Tue, 30 Apr 2024 18:23:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 11:23:04 +0100
Date: Tue, 30 Apr 2024 11:23:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Marius Cristea <marius.cristea@microchip.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the iio-fixes tree
Message-ID: <20240430112303.00001191@Huawei.com>
In-Reply-To: <20240430082645.45d72934@canb.auug.org.au>
References: <20240430082645.45d72934@canb.auug.org.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 08:26:45 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   40297eee0f39 ("iio: adc: PAC1934: fix accessing out of bounds array index")
> 
> Fixes tag
> 
>   Fixes: 0fb528c8255b: "iio: adc: adding support for PAC193x"
> 
> has these problem(s):
> 
>   - The subject is not in the expected format
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
> 

Thanks. I must have fumbled my local checks to miss this.

Sorry for the noise!

Jonathan

