Return-Path: <linux-kernel+bounces-21032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB88288D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FBF287D68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FD39FD8;
	Tue,  9 Jan 2024 15:18:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194502A1C5;
	Tue,  9 Jan 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8ZJ923BLz6D90c;
	Tue,  9 Jan 2024 23:15:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DAF8C140D1A;
	Tue,  9 Jan 2024 23:18:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 15:18:10 +0000
Date: Tue, 9 Jan 2024 15:18:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yang Li <yang.lee@linux.alibaba.com>
CC: <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] cxl: Remove duplicated include in cdat.c
Message-ID: <20240109151809.00004594@Huawei.com>
In-Reply-To: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
References: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 08:47:28 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> The header files core.h is included twice in cdat.c,
> so one inclusion can be removed.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Obviously correct :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/cdat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index f5e649407b8b..6fe11546889f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -9,7 +9,6 @@
>  #include "cxlmem.h"
>  #include "core.h"
>  #include "cxl.h"
> -#include "core.h"
>  
>  struct dsmas_entry {
>  	struct range dpa_range;


