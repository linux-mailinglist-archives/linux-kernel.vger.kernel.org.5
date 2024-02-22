Return-Path: <linux-kernel+bounces-77016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED448860019
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64781B215FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9547156963;
	Thu, 22 Feb 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZne/zSD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC661E874;
	Thu, 22 Feb 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624337; cv=none; b=IySoHROcvxzc11a2n5Q6cfxa7MDI3lW11Ab6KVs1a9JzGSntpOwkjfz/+1JbqBbNqBg86Jqd6YN086CxGAgDYURzlwHKRXtckP+hpKVO0XZhNpP9Iaa6zT7lTPynhFzDb3B1XI6eBgISBDA7rSvD9VtfrSYUKq7tMBNIhFw8Q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624337; c=relaxed/simple;
	bh=eL+9k62j+T2wkNoUbruSw/UNEvQBMY50/oKAF9aTu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3ILVv5luo0tF9zLTniXHnLtQB1R5nogwM7uvS/riF4aaTae2ynee/O5unirbfjXVi2fBsNXI0l5DXRGBVjY7+J7sbKy7fdqOv0UqfuwesKgxZ4oU4S29gIeTHKnJzwES2HKh6KunoekxHxRLI9kvfC16XImhE4Bla/ha5QyjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZne/zSD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso2901346b3a.2;
        Thu, 22 Feb 2024 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624335; x=1709229135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NeG/jlTUOS1kChoLvPJgLP36dfUNN+QX4mIOKkKMtk=;
        b=VZne/zSDFtEcqfHVKGmM1nK2YmIyZ+ui6cNVx2x/TcqhpCtqRRYCyNfyrO0Yr3PByy
         SOMN7Cvai2C/ZyrpgJ9Lz0ShzQLc48jBscfYOlOmUDktO2Qz5o3+y50mkpPfpsp6fBas
         ZQHlbDxiz9QyAO9jN/nA5QzLY6Q7vzMpPcrIGhS0PatwyacDoxumuZ5j/j/Nl4/9ScyG
         GTKXy0GYkbEY2cq6DsIyeHosZlPXY36L8+VyttO2htETCRGc7efIYEmdra8aEgfKiGuo
         ewzYo3H2a8MciFpCT48kNLr46lv43n1+/0Y69yNcSfJceYJgeymarbClnj1Htryb9vsk
         BAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624335; x=1709229135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NeG/jlTUOS1kChoLvPJgLP36dfUNN+QX4mIOKkKMtk=;
        b=WEehP6fGrrhWuY6U3u2fSNe5MIq7t46EK4UjetPnhwv4loD+m7c3HIAbQdE+qitbPW
         hpEPygkEd9D1n9+qHtPrdzsaE6RQhI3FyH5yCiTnt6Th9U2W+XHtETznVQRHIiLba0qm
         sUqbiOh3W+AEy5y4XZf1cDVIFfZq51H5xzL+AYaeIQRO9HY68uce0Kcyjd0x2bp1CKYe
         JepxI16BsGjjxAkhnlQ+eGVGpX+nEDG4lRI5jJv1KW1oHtAJU3Qm8aI3aIoKMtBIy7A/
         Sfa8zIRWP6HPXRMEXdOV9paBP67rNIAnYEwERbE2g6PZLl2zLZWB1aHNvJbQElB9tpM7
         6BDg==
X-Forwarded-Encrypted: i=1; AJvYcCUoxSMXa8kKYFWI7CQ1JNvSA+HohIXLwx/yL9d4PfjXMAmlFPDhZqXa+u5769DAnzjk4+G0+NB4GV1GPLDk5ziax79jFcxUh+z+WKJmYHLoBtiEWH2fmxp1CQMrWXGLbckqYT8ylgy2
X-Gm-Message-State: AOJu0YxKMtFFmuDeHgAmiUphuqwsLTC4SWz2oc1Sq/qxczQ0CXllnswp
	z3xYjaDw+ZRumP/dT4KiQGiZXy1n/jhZ1gVXV7bYWLax7XYosnBY
X-Google-Smtp-Source: AGHT+IEY4KZulJpk2BVOktl2enNQhFaSyfHvehOYpg7X+/+CP81iSn/wB/3tA9sNRFGmP5Jybgfpvg==
X-Received: by 2002:a62:cec5:0:b0:6e4:6484:1a36 with SMTP id y188-20020a62cec5000000b006e464841a36mr12436119pfg.21.1708624334599;
        Thu, 22 Feb 2024 09:52:14 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b006e089bb3619sm11708740pfg.112.2024.02.22.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:52:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 22 Feb 2024 07:52:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, paulmck@kernel.org,
	rdunlap@infradead.org, peterz@infradead.org, yanjiewtw@gmail.com,
	ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Control intensive warning threshold
 through cmdline
Message-ID: <ZdeJzZfPkpOKSH5c@slm.duckdns.org>
References: <20240222072808.5363-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222072808.5363-1-xuewen.yan@unisoc.com>

On Thu, Feb 22, 2024 at 03:28:08PM +0800, Xuewen Yan wrote:
> When CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel will report
> the work functions which violate the intensive_threshold_us repeatedly.
> And now, only when the violate times exceed 4 and is a power of 2,
> the kernel warning could be triggered.
> 
> However, sometimes, even if a long work execution time occurs only once,
> it may cause other work to be delayed for a long time. This may also
> cause some problems sometimes.
> 
> In order to freely control the threshold of warninging, a boot argument
> is added so that the user can control the warning threshold to be printed.
> At the same time, keep the exponential backoff to prevent reporting too much.
> 
> By default, the warning threshold is 4.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Applied to wq/for-6.9 with the following edit:

> +	workqueue.cpu_intensive_warning_thresh=<uint>
> +			If CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel
> +			will report the work functions which violate the
> +			intensive_threshold_us repeatedly. In order to prevent
> +			the kernel log from being printed too frequently,
> +			control the frequency and the threshold.
> +
> +			By Default, the threshold is 4 times, and the warning
> +			is limited by powers of 2. On the other hand, 0 will
> +			disable the warning.

I changed this to:

			If CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel
			will report the work functions which violate the
			intensive_threshold_us repeatedly. In order to prevent
			spurious warnings, start printing only after a work
			function has violated this threshold number of times.

			The default is 4 times. 0 disables the warning.

Thanks.

-- 
tejun

