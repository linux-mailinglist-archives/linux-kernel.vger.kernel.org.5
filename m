Return-Path: <linux-kernel+bounces-670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AD814440
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0986BB21ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F4182B5;
	Fri, 15 Dec 2023 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpE5hUKF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59817994
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702631349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycG62I0QVkhqLqj8HTY5IOSjAnYemrRYuhWB+WN9E4k=;
	b=fpE5hUKFvrwmEnOZpzEa/ORVVU/gIJcig2xtStWnPh+t4art+OBkJMAWXIoxj68WbfobVy
	8j/Iik0kSyVQ3KAvtffA26AWGjZXpyecN9TQtwiK82nlJFgRboWuba7FqTfsCa0CPWgmiP
	f3gKBhSGla9d6EHCcOXN7bpylGYCJ+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-GrfJGo9cPce8uYu9onZBYQ-1; Fri,
 15 Dec 2023 04:09:05 -0500
X-MC-Unique: GrfJGo9cPce8uYu9onZBYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E78FA1E441C7;
	Fri, 15 Dec 2023 09:09:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CF1C1121306;
	Fri, 15 Dec 2023 09:09:03 +0000 (UTC)
Date: Fri, 15 Dec 2023 17:09:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH] crash_core: remove duplicated including of kexec.h
Message-ID: <ZXwXrU8YO1FC4A+W@MiWiFi-R3L-srv>
References: <202312151654+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312151654+0800-wangjinchao@xfusion.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 12/15/23 at 04:54pm, Wang Jinchao wrote:
> remove second include of linux/kexec.h

Good catch.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  kernel/crash_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..d72985222b16 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.40.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


