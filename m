Return-Path: <linux-kernel+bounces-97151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FD876631
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367311F26E61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518CC4CE05;
	Fri,  8 Mar 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZffZFxcW"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364F4CDE0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907538; cv=none; b=XOhcJgE73+Fb5rdO6DBafJr4kCuqzz4Aos7LU+KAPo0NBScEqYpU48nC5Km65HEMYbdpZegxXkbgkUIh3m+0GzjUaMMfaOVWf1Iv32x1BCLMeIkcH+wQa/4Wvy/7H5bZscIGftEN2SOjMGQmGCUZ5KNq7mr+l5fMDIiBQSgfcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907538; c=relaxed/simple;
	bh=g2IbeBgxF2IScVqElByfb2CiSQILHCFJ/6rXqksPwUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMK4XuBAhJbehMXovLf6mTSw7G9YP3kcjF8Lu3xYUlPQ6j0cuc/UHXZYzm8KpJLroqpKvnwKRFjNnq8qv8F5lAPX9QeKamvClBTQVa7xNDer5xi1mCPtbHd31GhfOwVHknlXaygrAJcIxQVOhWdDljOOt4l1BQXNEAycQMYfaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZffZFxcW; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6e51d0so500221b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709907535; x=1710512335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKNK8ijls9E1tXAMdefGz1vvEQq+pkHwtEVYw+/+5yQ=;
        b=ZffZFxcW7Nc1arVgpnSSuGykw2CactgG6K8JMJib9wDsjwfXKneTEb8yLgHxWIV9N7
         kX+5Z6Jn1YIaJGTXeqrYybBzDZ8XD+HfaxcCo6KFSw6bZelKiTg9z1bD3cJWPQQgduVi
         79qtqe1Sjmd5ZxdsmiJRNwAOWG++b2L7KW8feDhC1U4ZkUMdMAnrNa6jXIxGDEm4UenJ
         jeKgTWBpdCSNLHPSGSM/Q8/BwdV3NuYMWEgBuUT6fbiAEnItOXCvdz9sErFHtq7E5hTk
         yAIi/IOvdFHMIbu4zfEfQoaGMlPicYnMGU8C1Z/Luq+nvGT4ng7ObpgectH1XXOR6k2/
         Gy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907535; x=1710512335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKNK8ijls9E1tXAMdefGz1vvEQq+pkHwtEVYw+/+5yQ=;
        b=YhGJoG+qGrnUvlnDqwB1m/ancpBZOC6PUU5DgUcSbGZc/kZFc8H7C9lEEb8upeoeOg
         WuU11evFq6oIIZoRBkbOGFffWY5Au/EKWBgu6IYr0eNaHs+n/1LexLiMdU4yLF+2K7c7
         lCMK6oqJ9nB0pKWH9ZyB15LNgdrwwGr4R1b7I6WrOMt0C/CXZbLYHlvXXRSEF/SYi1YX
         vFbPbIH+XN+N4ote9CXL1+JuOs/49lwUhjVlS0rrnIyuPZCEbXTSovkpulDkJxvu0rY3
         aov/+N+UcKS6KFfLv6dzGpWsWhMaTm3y5c+c2ysXf7EXHziZFNNQsBCIQw2yIQiN6gxI
         5Giw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ68VeLLPfLXANLa7sja6bait33WNoEGkPyGYrmVRfOQ34vZrr1xIIhsNEOhWPKFsr8/N3YyS26EChD/7QiJJaKQ/qKC25aDvUGLI9
X-Gm-Message-State: AOJu0YxgBNAm/cj6b+6o7tw1DJNop7qpAFhOVFhkEuFGlYh/+uYyhlpv
	h9W7u/RMVl3Dl2IlR+9HUGvKv9Y6E8TfUUSw/2IrmuvoEbslWjq7QzUfD/o4uEo=
X-Google-Smtp-Source: AGHT+IFWB1QntIiNT4+U/xqUoEl+DYSh/yAfPeecIIwlOkibGyrVGCSa2iXWSWVwnOBj2hPKgjs70Q==
X-Received: by 2002:a54:4609:0:b0:3c2:139b:cc36 with SMTP id p9-20020a544609000000b003c2139bcc36mr9328345oip.7.1709907534997;
        Fri, 08 Mar 2024 06:18:54 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id m9-20020a056808024900b003c21d1dffaasm816716oie.6.2024.03.08.06.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:18:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rib3k-0072p5-HX;
	Fri, 08 Mar 2024 10:18:52 -0400
Date: Fri, 8 Mar 2024 10:18:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
Subject: Re: [PATCH] RDMA/cm: add timeout to cm_destroy_id wait
Message-ID: <20240308141852.GR9225@ziepe.ca>
References: <20240308005553.440065-1-manjunath.b.patil@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308005553.440065-1-manjunath.b.patil@oracle.com>

On Thu, Mar 07, 2024 at 04:55:53PM -0800, Manjunath Patil wrote:
> Add timeout to cm_destroy_id, so that userspace can trigger any data
> collection that would help in analyzing the cause of delay in destroying
> the cm_id.
> 
> New noinline function helps dtrace/ebpf programs to hook on to it.
> Existing functionality isn't changed except triggering a probe-able new
> function at every timeout interval.
> 
> We have seen cases where CM messages stuck with MAD layer (either due to
> software bug or faulty HCA), leading to cm_id getting stuck in the
> following call stack. This patch helps in resolving such issues faster.
> 
> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
> ...
> 	Call Trace:
> 	__schedule+0x2bc/0x895
> 	schedule+0x36/0x7c
> 	schedule_timeout+0x1f6/0x31f
>  	? __slab_free+0x19c/0x2ba
> 	wait_for_completion+0x12b/0x18a
> 	? wake_up_q+0x80/0x73
> 	cm_destroy_id+0x345/0x610 [ib_cm]
> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
> 	ucma_write+0xe0/0x160 [rdma_ucm]
> 	__vfs_write+0x3a/0x16d
> 	vfs_write+0xb2/0x1a1
> 	? syscall_trace_enter+0x1ce/0x2b8
> 	SyS_write+0x5c/0xd3
> 	do_syscall_64+0x79/0x1b9
> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
> 
> Orabug: 36280065
> 
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
>  drivers/infiniband/core/cm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index ff58058aeadc..00a16b08c7e2 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
>  MODULE_DESCRIPTION("InfiniBand CM");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
> +static unsigned long cm_destroy_id_wait_timeout_sec = 10;

Don't need this to be a variable, just make it a #define

>  static const char * const ibcm_rej_reason_strs[] = {
>  	[IB_CM_REJ_NO_QP]			= "no QP",
>  	[IB_CM_REJ_NO_EEC]			= "no EEC",
> @@ -1025,10 +1026,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
>  	}
>  }
>  
> +static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
> +{
> +	struct cm_id_private *cm_id_priv;
> +
> +	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
> +	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
> +	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
> +}

WARN_ON? Is the backtrace valuable?

Jason

