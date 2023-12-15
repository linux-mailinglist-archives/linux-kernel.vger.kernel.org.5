Return-Path: <linux-kernel+bounces-499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B447A8141FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7150C2839AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E610A17;
	Fri, 15 Dec 2023 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqoU46jL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5C10973
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702623055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC1JfTqJ9MdUe1APXMHHq5zDpWh9AyaHnyrlMTWegK8=;
	b=XqoU46jL1Bh3WtccXXgH6rvYZRpoLu0bjfk8IM6ElRfGcPNNwdCUmCxn77SUg4k4n+Dh3x
	hYswT7fxTuQEKADEc98Oht1FFxH8WRkaWH0AfE3TDB2UHY/+5q4qX7bwjN/MmM32gaEmkJ
	qTr4Tb+Y/7v6AzNWiXUKn0z/e1Ln0+g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-qAK8QrfwP62FmMy7sYAxog-1; Fri, 15 Dec 2023 01:50:54 -0500
X-MC-Unique: qAK8QrfwP62FmMy7sYAxog-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67ee87ff6bfso4080336d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702623052; x=1703227852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC1JfTqJ9MdUe1APXMHHq5zDpWh9AyaHnyrlMTWegK8=;
        b=wJRm1ebLriy4eQYtpQy4vf05auCatoXsswvBCu2iwm6PGFO0MsmZouNpmeVTphjgtX
         Eg2gLZVx0inYEkJGwTbPbELMB6O7ECbQE0zcUJuUYzpC9hzsA2xq8qY9eiP+aSMVQMnd
         QxNb6i9yDp9nRUB76BqexaX06jfNLkML6nzaEQaQiX91pTltVu8CSzAAdHjMUGLrqG53
         7x1kCMzN5lE/A3QmSrfN47f6XGl9ujMBkrold3bR/Bp1ABQ1q4ahZtuymvfdMPUOr/Kz
         T2oYoXIhB+TeO7p6FXpWV+tBLuSt3eHF/arwzTzyYAZVmuXr/63Kcyb2zPu2tdN4Bcfx
         xdFQ==
X-Gm-Message-State: AOJu0YxzF7X23flb0prAzzVm+x8cJtJq6hUUBN7/6wzxK/iZ9nWeLbFu
	/mRr/wypK8AgfIaxdqngKhiS9PKqYIjYp3x6lccNSfv+o6i+yVVaPvIzGZ/ZtLaUUYRHkSORfd0
	WKRLBGo8c1QaNNMuFXeclk58sX0q7SWfn
X-Received: by 2002:a05:620a:3915:b0:77d:8f07:d3da with SMTP id qr21-20020a05620a391500b0077d8f07d3damr10429259qkn.40.1702623052599;
        Thu, 14 Dec 2023 22:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/EZu1ps9aGyJ7Sllj9zA4OsO2Apdl51SLBU4Ps4/yFiYnMt07yhuanoyj0rF1fUln4ONaEQ==
X-Received: by 2002:a05:620a:3915:b0:77d:8f07:d3da with SMTP id qr21-20020a05620a391500b0077d8f07d3damr10429254qkn.40.1702623052330;
        Thu, 14 Dec 2023 22:50:52 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a271300b0077d7eaefc08sm5876283qkp.87.2023.12.14.22.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 22:50:51 -0800 (PST)
Date: Fri, 15 Dec 2023 07:50:46 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
	jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXv3RnYNkpaPGYb_@localhost.localdomain>
References: <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
 <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
 <ZXn4qiMetd7zY1sb@localhost.localdomain>
 <ZXn6J5bN-dPC1WSk@slm.duckdns.org>
 <ZXrmJYvekzrLSaGo@localhost.localdomain>
 <ZXtb066P-ZnjxfgK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtb066P-ZnjxfgK@slm.duckdns.org>

On 14/12/23 09:47, Tejun Heo wrote:
> Hello,
> 
> On Thu, Dec 14, 2023 at 12:25:25PM +0100, Juri Lelli wrote:
> > > So, we have to use set_cpus_allowed_ptr() but we still don't want to change
> > > the affinity of a rescuer which is already running a task for a pool.
> > 
> > But then, even today, a rescuer might keep handling work on a cpu
> > outside its wq cpumask if the associated wq cpumask change can proceed
> > w/o waiting for it to finish the iteration?
> 
> Yeah, that can happen and pool cpumasks naturally being subsets of the wq's
> cpumask that they're serving, your original approach likely isn't broken
> either.
> 
> > BTW, apologies for all the questions, but I'd like to make sure I can
> > get the implications hopefully right. :)
> 
> I obviously haven't thought through it very well, so thanks for the
> questions. So, yeah, I think we actually need to set the rescuer's cpumask
> when wq's cpumask changes and doing it where you were suggesting should
> probably work.

OK. Going to send a proper patch asap.

Thanks!
Juri


