Return-Path: <linux-kernel+bounces-51917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA78490B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C03AB216A1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1742C692;
	Sun,  4 Feb 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoQdBzi5"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE128E26;
	Sun,  4 Feb 2024 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082433; cv=none; b=fWDPR2clcX9tIH8YVWA3ORrlHcVqEHgD74UDMxOWDngi1r634g1lO/5izFjEp2fSoeaGJAqX9AyV7k4hWBA2pUAxz2EmRLMoaJ60Rt6LMng+kp7jsFIuY2SNUSFIZJsDr0IRoiZXw3lXqBjgEXu3V2y4mVmxB9oWmlTwx07tNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082433; c=relaxed/simple;
	bh=FViAgGY9+E6nqcFOV1iUFPe+Yh9doxfR37J2aoGnWp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF63JSxhiuHYLsq0WcqCD7a9s8olIbRBts2dDxSDDNCt81bAJxe3qpwYMWZLzNkdkvPqYYsvHi3dzdurPVPdP+rrInt17odbCkzY1vSxfPWuZ7fE5TeQ9g++6B4m1TJEhRlNccYnV6tf8Z1aoCdzNlR00YBDfvMz1+em5JQYXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoQdBzi5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e03b583904so400518b3a.2;
        Sun, 04 Feb 2024 13:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707082431; x=1707687231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K05b5VLfrvxMvlDj2Oam+kbl/YvHi9sQJ4OaJmwSdN0=;
        b=HoQdBzi5pPeJDrimbUP6X5Q+zzOV0k7MX03SwzBtJadRf1RuY1jIWH9GBqAe834iyu
         mpX53UUcTTLi5alU0rr96Obahq+UYnnucpTtS6AQT2lcUATBsxfw3XSqqA+FWc0Sc8Np
         LWvE678CIVh+WjcYmqD7jkAuuUXJu64wlCeJtIo1d0eoRerKsb6LfGikHlFo3jWm7Sf+
         SPkMtojeEY4UbiycsPhshBoG8MYAJEYUXdRiIrq25fRig9JQDIMszbV6fHyM6y29Fy9I
         Gkt+O8oOv/Ms581iMK0Ugi3PbP0aqdWyNfSIRkz5Xj+W1b7ARn1LHVSNDwkvwUnPveFv
         Qtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707082431; x=1707687231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K05b5VLfrvxMvlDj2Oam+kbl/YvHi9sQJ4OaJmwSdN0=;
        b=JSoxlg8H6ErqSmW0ONil63OisRbeV9vGzDtDlSuc2URf0wrGB/Wcz1ttbz4Pfjiv43
         cvWgYxjnruZ8hKybRlAJPJNitYViiRy/cnPkFY5IeWCJmET9LbSGP2jwfTBbOuuQgV8V
         CY391lVwQKCi9MfoHFJZy38+fR1JHZnX6gRbffboskKBJ7js1wWHmn9FgEqK8KYsEetu
         f9E+Kyd5NOqQ1XCAkc5G+cYcEbE+qfz72xBJ50uNyo/PXu9m0SA2xGoD3YaX6wrybPyK
         LsureBkAkG5iAaFqXtb8egF29fTz2R/nkiQ7tjxwjkPP3xStd8laDlcOUIHjiHfUijd0
         D44Q==
X-Gm-Message-State: AOJu0YxcINbNSDy//8zGjUfWu6ziTowhBaTgivUP1wsmBqW7vNhQIsHK
	zk1ZFJmb9F0ZC3BCkgpNwEgXJl9WoHH44kOh5rBWz9arisk5kMH8
X-Google-Smtp-Source: AGHT+IEq90LVf9NXSqesU3tg2TwrDGP9MmY7XpUK9YJk1kiC567+EGK2eUNBHUpKMXWiuE5BEyLP7A==
X-Received: by 2002:a05:6a00:d4b:b0:6e0:3aa3:e163 with SMTP id n11-20020a056a000d4b00b006e03aa3e163mr2375756pfv.7.1707082430891;
        Sun, 04 Feb 2024 13:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTiaHeupoEVMkrMvapOSp8j4tlU0hr+rODA/5RPybihfYgmEsZTeFryROCxlOh+Hi9+lc49Z1JMO176gJFmryueU/qz5k25REqmLyWBvF7jVvLXBfWl4HxpajvW0KZP6ITyyat3d30fhdX5nfiDIUwisaj8COgExEYK/hOXNroNhEVc7pVC1YOOyRrGsOKSeI6QhXPM57V/O5NIoeXfjCL6KSAPpH4iO0eHg1AIARHRl/LUAaV2PInGvGs3HkSf+t9TYVIJhvs8FimNNZquCSVnVDAQ5ScFlENEBV7/IpleXqz+RBYBwOKXINFZbN4ltvCDlJyQ3mWOh7UShmmHF7ZvAk6qQbHQ2y0wkHGMAO+tOgRneKx80HOrSOgFn25endVqmRhOv2X6W7/teGxb5nDr77q6EhltTl9P56/0TJQMbrVNFiI
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b006db3149eacasm5177979pfn.104.2024.02.04.13.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:33:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Feb 2024 11:33:49 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
Message-ID: <ZcACvVz83QFuSLR6@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>

On Mon, Jan 29, 2024 at 11:11:47PM -1000, Tejun Heo wrote:
>  0001-workqueue-Update-lock-debugging-code.patch
>  0002-workqueue-Factor-out-init_cpu_worker_pool.patch
>  0003-workqueue-Implement-BH-workqueues-to-eventually-repl.patch
>  0004-backtracetest-Convert-from-tasklet-to-BH-workqueue.patch
>  0005-usb-core-hcd-Convert-from-tasklet-to-BH-workqueue.patch
>  0006-net-tcp-tsq-Convert-from-tasklet-to-BH-workqueue.patch
>  0007-dm-crypt-Convert-from-tasklet-to-BH-workqueue.patch
>  0008-dm-verity-Convert-from-tasklet-to-BH-workqueue.patch

Applied 0001-0003 to wq/for-6.9. Applied 0004-0005 to
wq/for-6.9-bh-conversions. Will proceed on 0006 and other conversions after
more perf testing.

Thanks.

-- 
tejun

