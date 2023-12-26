Return-Path: <linux-kernel+bounces-11430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B381E626
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A6D1F22829
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2884CE18;
	Tue, 26 Dec 2023 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmPjQx43"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C14CDF9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703581511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve1uqTx9MMoZ3Gc+pAWDljbgIT4AroaD+W2YAl66BV4=;
	b=VmPjQx43ZrErVM0YKAbfGJJwuuad09J27D+ugiQcCPbBLGD2lVirOMegGFg4CZjobX4vbE
	39FSjzR8+SQqG95B3GbeyE/AOffnMSkRIgfOFzX0Wg4k5ylB6sNey/o4+M4VgFm7eQ0UMW
	EIuI2VOzmqiIkdEmMHc8Sf6HvP8dupc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-wgmJgcOGO4-KozNJ0jitvw-1; Tue, 26 Dec 2023 04:05:10 -0500
X-MC-Unique: wgmJgcOGO4-KozNJ0jitvw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3367b16449bso2789372f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581509; x=1704186309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve1uqTx9MMoZ3Gc+pAWDljbgIT4AroaD+W2YAl66BV4=;
        b=Ya1nxQJzyH/admtpC00zKuM/bJyyvy4Ug5Wyfpf7m0aeAybVJjUeSLPeJH1gHzJQM5
         leUivx/U97yyjCzY5OoQULlcgPsZcx5m+NVWTMqldcip/auEFKG/NhddO9R3PT8B6+aa
         /BBwfE3LeJZDG1vVOcRv8VxTfv1NlqQwhmz93mFy5ie1v4nR05QlznxYFTQWVsa8gndm
         sisRJl8XQNN0Sn10x1lN6s1IDTPTLJ8pbQfrrOSy8uSOn0qLK7yekiHkEZKVKx6Y14Yc
         wZfXoMsXnva7q4G3ifcpJ8bLdBDjvh+XS7H6zvbiILrV3olMJSsecvPopECoR46rEf0a
         exWQ==
X-Gm-Message-State: AOJu0Ywuo9KJGQlHYPO/6adSeL1OFQOpKvuS66CckuwXh4WPecu/ApNE
	ZkwO1kmMW5STBeN7Q7s9WQXz4T0a92L7yxx/5bfYyJziLLcTjcVFek6VsDfJLgODgoiYZUvx9ec
	89HlwA4hINrKhehq2BhUJP5NqnITpy0Bn
X-Received: by 2002:a5d:4590:0:b0:336:6895:f5fb with SMTP id p16-20020a5d4590000000b003366895f5fbmr3586469wrq.75.1703581509056;
        Tue, 26 Dec 2023 01:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLiMWpmfAgwDwhbbW5uVJ8j6cbfhcNo+n6TStySwWGpppm3cK94RSMZ4VKjncgbKZYFbBFBA==
X-Received: by 2002:a5d:4590:0:b0:336:6895:f5fb with SMTP id p16-20020a5d4590000000b003366895f5fbmr3586459wrq.75.1703581508742;
        Tue, 26 Dec 2023 01:05:08 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id df15-20020a5d5b8f000000b00336c43b366fsm3580935wrb.12.2023.12.26.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 01:05:08 -0800 (PST)
Date: Tue, 26 Dec 2023 04:05:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231226040342-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>

On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> Hi MST and paolo,
> 
> mq-deadline is good for slow media, and none is good for high-speed media. 
> It depends on how the community views this issue. When virtio-blk adopts
> multi-queue,it automatically changes from deadline to none, which is not
> uniform here.

It's not virtio-blk changing though, it's linux doing that, right?
Is virtio-blk special somehow?

> I don't have ideas right now to answer Christoph/Paolo's question.
> 
> Thanks,
> Li

-- 
MST


