Return-Path: <linux-kernel+bounces-11551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82581E81A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06311C21ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CF4F215;
	Tue, 26 Dec 2023 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJUcXDWt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B64F207
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703605140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wV/f9f0in7gn4gktkxuOHq7lnBTOjC718N9fK7Gr2Iw=;
	b=NJUcXDWtzZk/5joPmmoSG3Jg4IEqRHrVKvwHAxbynLmkJ0YLqZeYYecp84BI6m7CFR+fTu
	m4YW8w1OUnP9gQWWz9yj/cGXhB9gziG8m5ZQ7gxqf39MjemDnkJQU+PP22zabu9qrareix
	7XrgLpPvBp6AUngKLvkaLZ6BXztY0dU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-sixYqUSePx-65616kU37Mg-1; Tue, 26 Dec 2023 10:38:58 -0500
X-MC-Unique: sixYqUSePx-65616kU37Mg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d597040c9so6720335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 07:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703605137; x=1704209937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV/f9f0in7gn4gktkxuOHq7lnBTOjC718N9fK7Gr2Iw=;
        b=QZyNxsyXu2YKAL5+ntI3K3Qk2BGsnnU8zhkviiW8u30T9K3whL+tEynVYt1SHTAKd6
         whQHkm9qIrhFaOpD/6EK8udKInsEvR0smQEsA6eO7GcegGbLn4GAgKERgJFSjvuoQLSe
         a8msHG4FPZAY31P1jTe3DBz906+XZnLrLx9ayQhE7z0NHe9smiXuk1vuWEXKtkxazZLh
         EONHF4PoznQhQidVyBFeuRV1uU2nSzXDo/B8gb/LYxNY8lDqkik4yYMeDtE9dmmHq4U7
         KRs3q7phxcfYBDeCdKiSYJ1T+XnFErfK7lNLhm0zpd0/kai9049oy54VY2kpDMCwWeZT
         wUHQ==
X-Gm-Message-State: AOJu0Yw4NfXcpfTm3lJn9hHxU18CUX/zXlWolQCjsGYDhXWyLPRpZvmq
	yNRJKqe5G639DWtj/QJM2ktBh+aqgIETostZWv4PF8wow01O7oDb3ZczoYsuHe5k6RLydx6pEyI
	wDx8P/WZGvGitrZNuU9W8+8vW4VLAjl41
X-Received: by 2002:a05:600c:5405:b0:40d:2d25:b8ee with SMTP id he5-20020a05600c540500b0040d2d25b8eemr2051624wmb.171.1703605137304;
        Tue, 26 Dec 2023 07:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF95K6/sVk5zmbFYd7DofTvHL9+lGHyoYvlXR0NoGkiR28DSEG18rrqgMucy+nDqg7Ulg/sXg==
X-Received: by 2002:a05:600c:5405:b0:40d:2d25:b8ee with SMTP id he5-20020a05600c540500b0040d2d25b8eemr2051613wmb.171.1703605136846;
        Tue, 26 Dec 2023 07:38:56 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b003feae747ff2sm14254261wmq.35.2023.12.26.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 07:38:56 -0800 (PST)
Date: Tue, 26 Dec 2023 10:38:52 -0500
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
Message-ID: <20231226103743-mutt-send-email-mst@kernel.org>
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
> I don't have ideas right now to answer Christoph/Paolo's question.

Paolo did some testing on this thread and posted some concerns.
Do you disagree with his analysis?

-- 
MST


