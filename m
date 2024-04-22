Return-Path: <linux-kernel+bounces-153847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8698AD41F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE81F2174A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804F154C07;
	Mon, 22 Apr 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ds52ftOk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6889153BFE;
	Mon, 22 Apr 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811198; cv=none; b=Jm049GjnpidvbvfFd1U5lQetgouePhdr2HCQmnwt7vB5ezkLMjx/Z2YpaPJz2HAou6+Ss+uHvkzSmhvTLIDXPT5glHB0xOh4qwJws4HRCFlzlllOwrM+BtIw8AZHw4/UIYIsT7BIC3XOFDcS9hSw12lJxK0KdqhbU9OrVSIskcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811198; c=relaxed/simple;
	bh=Nyd5CC3+SeZTxf0OJyqVrpGGzfHzAExyfn45MCTlIKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUDYwSwS2zg11cVpHijUVXKrlSSoPotYo8kssTZ8UVu9Ge9XmJrr3TvZ71hSYMk6EopoDvmAAxwLDfzSj44QR+AeJoyBlmUGLlhbKCrV0VZJC4MyKnDRueITOmjwECHmAE/6+92eOKIB1qySu0IZJlATXaKIJ8ZMR4hkdFIk+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ds52ftOk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WvnAsiuZt8H1Zl4oauEZTca+TX5rbK65b3taUhfahhM=; b=ds52ftOk9Au39MxQJzq73CM5N2
	GyV5+iclVmjhqP8u/seLO1N6Mb+fe9n4Kk5dPhboUvhWAWH83j2jb36JLESOI7gdhv3Ww5LfQdT3M
	BLRzv/gZMgBEI6yH10yerKdpcnPbG3qVGmIYCXG506Mhx53ceDbSKHZaJhD64l8A7zh+d/WZmmCTq
	eoH251REzJFUgB+TTUcWu6q55bD6MVHVhOrYGzNdTPh/iy40hqx++1YUmEXCfmzfZsekvAfQ2cdPb
	7QfNAnodGujKu6nkSSGr5syzGuzSYn1lTpDTK4gdh698bI8dt247N9/uAu/hIwkH86+qL9jLXJNKE
	1fUiAdFA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryya3-0000000EdIe-0WYS;
	Mon, 22 Apr 2024 18:39:55 +0000
Message-ID: <7d24e1fb-520c-4ec2-a6aa-89856092891a@infradead.org>
Date: Mon, 22 Apr 2024 11:39:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] block: Init for CBD(CXL Block Device)
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, dan.j.williams@intel.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-2-dongsheng.yang@easystack.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240422071606.52637-2-dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/22/24 12:16 AM, Dongsheng Yang wrote:
> diff --git a/drivers/block/cbd/Kconfig b/drivers/block/cbd/Kconfig
> new file mode 100644
> index 000000000000..98b2cbcdf895
> --- /dev/null
> +++ b/drivers/block/cbd/Kconfig
> @@ -0,0 +1,4 @@
> +config BLK_DEV_CBD
> +	tristate "CXL Block Device"
> +	help
> +	  If unsure say 'm'.

I think that needs more help text. checkpatch should have said something
about that...

And why should someone say 'm' to the config question?
Will lots of (non-server) computers have CXL block device capability?

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

