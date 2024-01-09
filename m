Return-Path: <linux-kernel+bounces-21523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C67D8290B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400DE1F26FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EB33F8E1;
	Tue,  9 Jan 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBWsZRWD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B833F8C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704841671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmsOSA8e0agbmpKIvz+4i4zAbpgfLcQxgusd1VNG7pQ=;
	b=ZBWsZRWDTNR/wBRr4o2rHmqFNKezg1MqGrLVRPBzIMgUcS7NuXArTcm///GWwhkYY4f8jK
	1ixen/TGqVs3TqVnIcOLx/0cF8t3SCZ4ROYzXNnMXiiJkFDQBuG2RUuVa6n/DLS/UN0sCr
	m7E2uRIFJPif8dY7revvW1g6pS11UP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-UlL954DrMp-WSWk8-BUZWg-1; Tue, 09 Jan 2024 18:07:49 -0500
X-MC-Unique: UlL954DrMp-WSWk8-BUZWg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d5aa2f118so31186875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841669; x=1705446469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmsOSA8e0agbmpKIvz+4i4zAbpgfLcQxgusd1VNG7pQ=;
        b=qGgfdgno1OzPT9Py4sU9lv1JyiYpdSMc+00oQHkLdPCKmkeDfkp1+KYjA8sUXC/yAf
         BuwY+EtS07MBLqRfqrpOA+hVSTpFgqRSw/vSDHlxaM3sdWj6nN0BPbod4IiJ0MQfhYEc
         i2KJ6G35R9RdxT693L7xW6cv7NNe+J2XAyk8z2h1CL+YvuKF3P5V/KSlBatUC3e4PFu3
         8zqN4qY5pPmZ0aDGhzCzJhJZwkdF/sUVondEoEuppxPHDVK/EKwCJ0Jdf4chBtm7DZvp
         HWCvC+AJmie4SaGSiP/RCQh8Z8vjbswG1mR6P/TvEQp9yT7CpkTWrh5b1qfLO8RiYxKz
         xNnQ==
X-Gm-Message-State: AOJu0YyoF1vH3RBZ8xDL83Q29bHnSyTlj0aC4ibNr0SqFaHRBwDcu33A
	D9Plet2ev4YbRSIoBcWP+5xtVdnR+XXfLqJPrn9F0bbu8Cd5tnKU28KsiTF2PIDnkc388z4Up3Q
	FHpZQtVYquBhfFeYaYwqEA9DzJV+Ha1TT
X-Received: by 2002:a05:600c:1603:b0:40e:4800:c91f with SMTP id m3-20020a05600c160300b0040e4800c91fmr31974wmn.9.1704841668808;
        Tue, 09 Jan 2024 15:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO3FEhMXyQFhkdwPMbAGnlA5UDqENRCt3LgtBWXNMza5r2kTWnZqKT5YT16xPNccXd/SHk6A==
X-Received: by 2002:a05:600c:1603:b0:40e:4800:c91f with SMTP id m3-20020a05600c160300b0040e4800c91fmr31970wmn.9.1704841668528;
        Tue, 09 Jan 2024 15:07:48 -0800 (PST)
Received: from redhat.com ([2.52.133.193])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040d7c3d5454sm59173wmo.3.2024.01.09.15.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:07:47 -0800 (PST)
Date: Tue, 9 Jan 2024 18:07:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240109180706-mutt-send-email-mst@kernel.org>
References: <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92916.124010808133201076@us-mta-622.us.mimecast.lan>

On Mon, Jan 08, 2024 at 02:13:25PM +0100, Tobias Huschle wrote:
> On Thu, Dec 14, 2023 at 02:14:59AM -0500, Michael S. Tsirkin wrote:
> > 
> > Peter, would appreciate feedback on this. When is cond_resched()
> > insufficient to give up the CPU? Should Documentation/kernel-hacking/hacking.rst
> > be updated to require schedule() instead?
> > 
> 
> Happy new year everybody!
> 
> I'd like to bring this thread back to life. To reiterate:
> 
> - The introduction of the EEVDF scheduler revealed a performance
>   regression in a uperf testcase of ~50%.
> - Tracing the scheduler showed that it takes decisions which are
>   in line with its design.
> - The traces showed as well, that a vhost instance might run
>   excessively long on its CPU in some circumstance. Those cause
>   the performance regression as they cause delay times of 100+ms
>   for a kworker which drives the actual network processing.
> - Before EEVDF, the vhost would always be scheduled off its CPU
>   in favor of the kworker, as the kworker was being woken up and
>   the former scheduler was giving more priority to the woken up
>   task. With EEVDF, the kworker, as a long running process, is
>   able to accumulate negative lag, which causes EEVDF to not
>   prefer it on its wake up, leaving the vhost running.
> - If the kworker is not scheduled when being woken up, the vhost
>   continues looping until it is migrated off the CPU.
> - The vhost offers to be scheduled off the CPU by calling 
>   cond_resched(), but, the the need_resched flag is not set,
>   therefore cond_resched() does nothing.
> 
> To solve this, I see the following options 
>   (might not be a complete nor a correct list)
> - Along with the wakeup of the kworker, need_resched needs to
>   be set, such that cond_resched() triggers a reschedule.
> - The vhost calls schedule() instead of cond_resched() to give up
>   the CPU. This would of course be a significantly stricter
>   approach and might limit the performance of vhost in other cases.

And on these two, I asked:
	Would appreciate feedback on this. When is cond_resched()
	insufficient to give up the CPU? Should Documentation/kernel-hacking/hacking.rst
	be updated to require schedule() instead?


> - Preventing the kworker from accumulating negative lag as it is
>   mostly not runnable and if it runs, it only runs for a very short
>   time frame. This might clash with the overall concept of EEVDF.
> - On cond_resched(), verify if the consumed runtime of the caller
>   is outweighing the negative lag of another process (e.g. the 
>   kworker) and schedule the other process. Introduces overhead
>   to cond_resched.
> 
> I would be curious on feedback on those ideas and interested in
> alternative approaches.



