Return-Path: <linux-kernel+bounces-118697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238AF88BE28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4828F1C26D21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6A7173C;
	Tue, 26 Mar 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVq9MjYS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0171723
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445944; cv=none; b=W/Gl5Ivaqadf7OW/6ZMpv5MpURuRTgkopSEAyagoXU+YXjEFavTz7byktol6mRfocslWAxzLQHb5rmjFtulz3AzvPwSX9Zs32EK0m3UtjVDWCUiOwZvqT3XHoWvnMw7dPyVspdrHgyaPxXr4IdNCqVZuNUPqWZfrfPGDBnBDXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445944; c=relaxed/simple;
	bh=SxX4N38CRIZ9wOS6MJ+Zdg1b6RZz4tLgVJyZOhtiMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXXGJQzEHd8TQlTKHnDu/XCCnxmPkQkdxNvGF2ee3lWBC4uNFKd3P+k+tSZT8p3LOhfp0VWfAatPDwGKqhYZTCkTofLxV5oVOr8bUQ2idwuMguTyxGxE+5T8SQkdnNNx+lQ/iH59aJrBUjDnG4Sl5kuW9+6/LjfzJB5RzJ4iQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVq9MjYS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4148c09ec6bso49375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711445941; x=1712050741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBfa7bD+DHZlqzDRNnmeC7FlWZiV7yjPXXmtlDzPpsM=;
        b=rVq9MjYSmqLKOP+g06H23O1dJPNW/1EKM6LzKgjqSxTQjYWf5Lc9HgZ4sC5v6Vr9CZ
         EQNptFJgk6/KJXmdvX2FRBe4Nt39Y9l/xTKmXf0UMNaozPU/Eg7o7k2FC+Gh+5Tzopxd
         SZ1Z8vg+M+n8KEpAKUzpfI07P+2R6zRbleBbvDQ7k6INWsWiA2+cLKrlXrqQWvVolxyp
         /s0G5tT7gWRzxGNVJZq1VM1N+MNSCM473MOYAez8mmh9zyJ/HJuL3pRYwuAoNOTIfkRA
         Mv5eYCPwJqjKRCOOfbpNljH2CSekfYisoE+2ivz6TyHvK568VNHG+AiERpDsqlUmvu8z
         yqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711445941; x=1712050741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBfa7bD+DHZlqzDRNnmeC7FlWZiV7yjPXXmtlDzPpsM=;
        b=Mw2YldujOtfUb9yfOwypyjpuoH8t2NFRnZzi8kkWCUe0QsLywndnL6RXNTauOKXSPi
         B96ZBvCEaG8s61j+l68jTuSKw1+fqbF9TwL9KJC9Fv2/LvRogAGuWKZ3fHLWoeCuSAQK
         aqtnpQOS1UZvXfAWOVc0FKasxbp+43P191RXhvjiRUe3cujJD+5fQMvSx/JJNV55TRN/
         myEB61JaMcCVAnCEDUHZ8AbCpFHtc6FKVFGR1/yXCzdOQ/FY9np00ub+icvkFfzZXKF0
         e9v7hIolxAI0Hk8ucFVt2RyClab88Dbr+oy+9TyPNiDLcX/o1V0eD+pTf18/SXiwEww8
         gH+w==
X-Forwarded-Encrypted: i=1; AJvYcCV+bteiGTB3pELxgGrzHtg/7G0H6srCfqs0/E9ZFJuR7nNY0INbfzq9qTyDSYAloxexvHNGcgc1fmdBhD+ckNC84q+Vl7ijujoYdJgD
X-Gm-Message-State: AOJu0YwBjeievMqEOQidfN/p2A2/eK+H1rS2ejVygBwxbgP6uRmn9hKu
	eSu260VZAIp2BwReiT5hTvFffDfuCc+k4s0AlcLzZ47mQySU9+DTx0oG01DnHQ==
X-Google-Smtp-Source: AGHT+IE+q/VP+Y5OuAlcSHXpSI2sdtUwAKOteOf+H3BRkrfJpESuCtSgjAvRcoND0mJ6ryAOmNSbIQ==
X-Received: by 2002:a05:600c:6cf:b0:414:908c:460d with SMTP id b15-20020a05600c06cf00b00414908c460dmr19791wmn.7.1711445940511;
        Tue, 26 Mar 2024 02:39:00 -0700 (PDT)
Received: from google.com (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with ESMTPSA id g23-20020a19e057000000b00513d244005asm1491791lfj.199.2024.03.26.02.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:39:00 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:38:55 +0000
From: Keir Fraser <keirf@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <ZgKXr8IQ51xBECuP@google.com>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326033809-mutt-send-email-mst@kernel.org>

On Tue, Mar 26, 2024 at 03:49:02AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 25, 2024 at 05:34:29PM +1000, Gavin Shan wrote:
> > 
> > On 3/20/24 17:14, Michael S. Tsirkin wrote:
> > > On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
> > > > On 3/20/24 10:49, Michael S. Tsirkin wrote:>
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 6f7e5010a673..79456706d0bd 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > >    	/* Put entry in available array (but don't update avail->idx until they
> > > > >    	 * do sync). */
> > > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
> > > > > +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
> > > > >    	/* Descriptors and available array need to be set before we expose the
> > > > >    	 * new available array entries. */
> > > > > 
> > 
> > Ok, Michael. I continued with my debugging code. It still looks like a
> > hardware bug on NVidia's grace-hopper. I really think NVidia needs to be
> > involved for the discussion, as suggested by you.
> 
> Do you have a support contact at Nvidia to report this?
> 
> > Firstly, I bind the vhost process and vCPU thread to CPU#71 and CPU#70.
> > Note that I have only one vCPU in my configuration.
> 
> Interesting but is guest built with CONFIG_SMP set?

arm64 is always built CONFIG_SMP.

> > Secondly, the debugging code is enhanced so that the available head for
> > (last_avail_idx - 1) is read for twice and recorded. It means the available
> > head for one specific available index is read for twice. I do see the
> > available heads are different from the consecutive reads. More details
> > are shared as below.
> > 
> > From the guest side
> > ===================
> > 
> > virtio_net virtio0: output.0:id 86 is not a head!
> > head to be released: 047 062 112
> > 
> > avail_idx:
> > 000  49665
> > 001  49666  <--
> >  :
> > 015  49664
> 
> what are these #s 49665 and so on?
> and how large is the ring?
> I am guessing 49664 is the index ring size is 16 and
> 49664 % 16 == 0

More than that, 49664 % 256 == 0

So again there seems to be an error in the vicinity of roll-over of
the idx low byte, as I observed in the earlier log. Surely this is
more than coincidence?

 -- Keir

> > avail_head:
> 
> 
> is this the avail ring contents?
> 
> > 000  062
> > 001  047  <--
> >  :
> > 015  112
> 
> 
> What are these arrows pointing at, btw?
> 
> 
> > From the host side
> > ==================
> > 
> > avail_idx
> > 000  49663
> > 001  49666  <---
> >  :
> > 
> > avail_head
> > 000  062  (062)
> > 001  047  (047)  <---
> >  :
> > 015  086  (112)          // head 086 is returned from the first read,
> >                          // but head 112 is returned from the second read
> > 
> > vhost_get_vq_desc: Inconsistent head in two read (86 -> 112) for avail_idx 49664
> > 
> > Thanks,
> > Gavin
> 
> OK thanks so this proves it is actually the avail ring value.
> 
> -- 
> MST
> 

