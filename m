Return-Path: <linux-kernel+bounces-128962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48FD896250
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F9EB24216
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B11798C;
	Wed,  3 Apr 2024 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IwenuWbj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70A168A8;
	Wed,  3 Apr 2024 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110211; cv=none; b=l1LIINcwNP8bJePwwiBCloe+yaZU4NT66fhPX4426i5/lTLfEX5jYIp7mk5utynWibySCVWhFS610BIW+/VPHCpva+h7EFD5GDshD4woCaY2Ddoc73vdL5xI/2HlwukYPuv+yx/fUh+vIiFppPcU5/D67g8nWBVAIwYQtNK4uTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110211; c=relaxed/simple;
	bh=zeKYRYohlTStC7Tkr+cr5vBo/cYYssPjfX2YsNmGqco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2y2BerH6VwbfdzRfcLvUQIpyEr7AAg1irzqRVc/2CR275Csb4sMo07zg5TGQjNTDgUW8xxspKsmbMIR5TbTg+FoWFTi5rnb06SoCONd8z2qYtnSdaxi/NxRA/7h4DjyApfWzkwOD5l8duY3Gn9SsNMMmwgYY4cWvtwe8BKtlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IwenuWbj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=e9SSw5eWjtK7BQOqCZkczD3EG3WrEvANQjFrXS/TIIA=; b=IwenuWbjyX9y5yVq4O0ZlNg1fU
	XEZnPilzGPfDZkfXI59ii49I5QEpx3RwKL8VstaNNWQzwRfyGHaLzIyh06WjuEAh3L8evSi7oC6oE
	Y5Sc/6j5ceWyisvNZCYLkx5fU5pUTNwdMnhPh5yJHEHYKx867MXrxGRcoX1bY7MxeFokbFwGYQhW0
	DRpre5Vwlm+e8MXYPtmjtR+nnek97OPsMgOUIXJ03JB35rbQG1f+Bbt3db86Tfhu6cxEXD8ntK/9p
	WbKRBj+tdObhPQDNHzCiLMaxmKpkJ1Lyp1iKmBju3r2Dk5XMAMQYuXSiQJosDyeWf3qSQFFF9iG2Z
	z0WWk4Ug==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrq4l-0000000DcIO-1RT5;
	Wed, 03 Apr 2024 02:10:07 +0000
Message-ID: <b102d460-adbe-4396-ac1b-ad2f2244061c@infradead.org>
Date: Tue, 2 Apr 2024 19:10:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add MO(mod objs) variable to process ext modules with
 subdirs
To: Valerii Chernous <vchernou@cisco.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402153028.1378868-1-vchernou@cisco.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240402153028.1378868-1-vchernou@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/2/24 8:30 AM, Valerii Chernous wrote:
> The change allow to build external modules with nested makefiles.
> With current unofficial way(using "src" variable) it is posible to build

                                                          possible

> external(out of tree) kernel module with separating source and build
> artifacts dirs but with nested makefiles it doesn't work properly.
> Build system trap to recursion inside makefiles, articafts output dir

                                                   artifacts

> path grow with each iteration until exceed max path len and build failed
> Providing "MO" variable and using "override" directive with declaring
> "src" variable solve the problem
> Usage example:
> make -C KERNEL_SOURCE_TREE MO=BUILD_OUT_DIR M=EXT_MOD_SRC_DIR modules
> 
> Cc: xe-linux-external@cisco.com
> Cc: Valerii Chernous <vchernou@cisco.com>
> Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> ---
>  Makefile               | 17 +++++++++++++++++
>  scripts/Makefile.build |  7 +++++++
>  2 files changed, 24 insertions(+)
> 

If this code is going to be merged, there should also be a Documentation
update to Documentation/kbuild/{kbuild.rst,modules.rst}.

Thanks.
-- 
#Randy

