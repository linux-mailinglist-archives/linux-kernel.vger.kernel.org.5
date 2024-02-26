Return-Path: <linux-kernel+bounces-81588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD68677DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4FC1F258C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD43127B4B;
	Mon, 26 Feb 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UgsdCwit"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13322129A65
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956411; cv=none; b=lRPfatWtCDB05P8AqqwrJ/w6TQmkmt1BAxEuz/IKOGyTqSiriTA1+XySBM5pEbAPGrnx1BkTJOoeUyA2byS/1sh+VL5F3r3jOg051KTb3DJHhEMxqKJULWpf5qNS4r7zxbhxb4KwbcjBUH/4+Ybuq/X0CSTYk1J1QVgfacOCp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956411; c=relaxed/simple;
	bh=fuDYuRjoR1UI44uUimtjxVT+fQA/4pO33d2wXEFS/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1FJuznQTORqdkqDKeoofbpbQ6xzjvPIwxmL+d1FKj4kd2hKz8DuOhQO7RrgyMXUFT4ebaCxb4Z11pciFTTDjFuUq6C3X8SheeyaDSIjJPj6IjODIBsSxFbMC5b21Oum+fLFAg961ZVZeMzXYdulgB3OZdCXobQ/+LwZ3LdMxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UgsdCwit; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690105304b4so1572336d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708956409; x=1709561209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgXdMwNKjGPBb2jpZ6gPX8zZl4gfkP26DGkK0D6WeTY=;
        b=UgsdCwitBiz+xtCbUTePRe07RJQveLz8I7gdJShlUy+xkHSBpkU4B0/VLwKJu02XeQ
         3n28/jIQ8sTd4FAN3UpAtF3j4cCU5Z1JvM2niShQ/CurtG09/o10+D1mAGIV42+c16w5
         2NY/nWfA6zDQHMWxFuMfzcpc7nKhVRwBEZC3hg4vq0WOMG6IrMizCZ/WiEp/2z6MHJyQ
         1MJmFFHk4w0k6FtCIGZ4MqAW1TR9Igv8S3aUofajQ5FIyVv6FjYL7OfeDp7Vv44NdQz7
         PdjZQGEhcxtA3nd5MWGA9SgYNojhailbUzo6Bcu0o13ebYgWk2xIw5ZV66f1IF2q82XA
         fCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956409; x=1709561209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgXdMwNKjGPBb2jpZ6gPX8zZl4gfkP26DGkK0D6WeTY=;
        b=XmDrjVGDjbVISbHDk3PSgjt2TyrJ1KvR2x3Ql+k5d1NpJrHMzz92GQefC6lWhBMA1G
         Fe7yMa20SklR+1Q9F2AGrNrtzvVFYFiEHHTror/nUJ2HnEDeteRNFkoE5lf5ha4ycl9F
         xQ/vZHGQr9m161DXwzCydxqyI9M74SO7rpS8fh4jOo1AygvzZBTr1dhSWt/XtuqSxtSV
         urXp58oX5dGZSFfU4fyTGOj/JKxVZuZGW6ENh/SZtPD0cmUEk+WbSXE6njC50IWy0KPm
         MeQjiba8K8wyVyCumik4CdFpsdzGek7oBZGrmJfZCkOCBpLCG8g8cEnoZbNr8OmtdnFK
         0WOw==
X-Forwarded-Encrypted: i=1; AJvYcCVisQ8rEqxrmfaVXH5t4EWAbRCAjSRdTksW803EodRYc8yr+JG4swHZj2nWYWC16s7x5Pkfw7dN5h+JXxOrCHKVZJMxA9GxfjTxRqQG
X-Gm-Message-State: AOJu0Yzd7js3V0JD/ZXZPeI+Ds8SSvnZca2S+gG3AGSJC8DeaCJEv37D
	c/2BuS0kjrVbAfZlUH4rnp0uWaeCKWvAlDJCLRxN7IJqeoATxEvMWjFd1nxyqDs=
X-Google-Smtp-Source: AGHT+IHuYe+Ziwtz0L97YB60rihCZgCj8vYXG569z7yDIQX+tSqbQfmrb9b1cCNldq72fbT5tHzH7w==
X-Received: by 2002:a0c:da92:0:b0:68f:1daf:d696 with SMTP id z18-20020a0cda92000000b0068f1dafd696mr7858676qvj.31.1708956408934;
        Mon, 26 Feb 2024 06:06:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ol8-20020a0562143d0800b0068fb9bdd7absm2979537qvb.74.2024.02.26.06.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:06:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rebd1-00HHN4-B2;
	Mon, 26 Feb 2024 10:06:47 -0400
Date: Mon, 26 Feb 2024 10:06:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support userspace configuring
 congestion control algorithm with QP granularity
Message-ID: <20240226140647.GB3220539@ziepe.ca>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
 <20240208035038.94668-3-huangjunxian6@hisilicon.com>
 <20240221155248.GD13491@ziepe.ca>
 <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>

On Thu, Feb 22, 2024 at 03:06:20PM +0800, Junxian Huang wrote:
> >> +enum hns_roce_congest_type_flags {
> >> +	HNS_ROCE_CREATE_QP_FLAGS_DCQCN = 1 << 0,
> >> +	HNS_ROCE_CREATE_QP_FLAGS_LDCP = 1 << 1,
> >> +	HNS_ROCE_CREATE_QP_FLAGS_HC3 = 1 << 2,
> >> +	HNS_ROCE_CREATE_QP_FLAGS_DIP = 1 << 3,
> >> +};
> > 
> > Why are these bit flags if they are exclusive?
> > 
> 
> Our FW uses bit flags. Although there is no direct relationship between
> FW and ABI, but from the perspective of readability, bit flags are also
> used consistently here in ABI.

Don't do that in uapi.

> >> +enum hns_roce_create_qp_comp_mask {
> >> +	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,
> > 
> > Why 1<<1 not 1<<0?
> 
> This is to keep consistent with our internal ABI, there are some
> features not upstream yet.

Nope, pack them tightly. Don't keep an "internal ABI"

> >> @@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
> >>  	__u32	reserved;
> >>  	__u32	config;
> >>  	__u32	max_inline_data;
> >> +	__u8	reserved0;
> >> +	__u8	congest_type;
> > 
> > Why this layout?
> 
> Same as the 1<<1 issue, to keep consistent with our internal ABI.

Same answer

Jason

