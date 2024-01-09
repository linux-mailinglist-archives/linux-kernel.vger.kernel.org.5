Return-Path: <linux-kernel+bounces-20919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBA82875D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886231C242B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0538FB0;
	Tue,  9 Jan 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voZqk7gV"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C138FA3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3368ae75082so2248119f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704808073; x=1705412873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8ptE3MfMCNPnA4x0tsihK9wQ9HIxrC2BPD7lupKPdw=;
        b=voZqk7gVGwIBawLTaRXiIdNZEfnDQrA1/OIKiP2hg3KLl1PYA/vTzBu7HWbSjbSo4o
         pq1u5IJ+hDBnMeYPC3s7ZnDhemOOP3DMHC0qv+5giyylXyClcFzScKuj6Ttr22y1MCOx
         QIl20y+SS1Hxdo7Q+2Hvb5Ov75jQ9gqmDyBhrley6f1LZ01EMrB7ldekjChO+A/2yLum
         EFWwf3awUSLBv8wMrbvb6XcDyAPVkoLwB2GY2HcLOyf+Wn4sb3Ouu5VHt0NnfGV3rUPN
         7qPfNvb++t2WYV/3jDIiBigXFaGEWWDC1u90o9Dysx9Nu4kLvptQ9n3RyjVgHyZYhojf
         G0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808073; x=1705412873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8ptE3MfMCNPnA4x0tsihK9wQ9HIxrC2BPD7lupKPdw=;
        b=dYHaMqVJf+a8R9x8Rt3xyi/kV1ZCKO82HtGWtHO9xRRTt1HUeBiVPWoAfFrRk61XaI
         FoKv5njE32574JAFF5j+sUYIrStPZw0BR1B7eDyje7Gb1HIb1aJ87RAc24Vlk4URRZwB
         SuVxOx55YSHKG9+kARAyOkP6RDMMnW87CNoPyNIXgrZT/V2fFl+Mpi4z5hdpQT+i4HtS
         VPazHesfrOeU7XCqYAlHXpXuLoy2uKNizfeA+Z0st74A59XbwvIfOMEm3Akcch/yQS4Q
         gQOHEuvq5/zKHpmhA43fOs3yYGuY4KO5plkNop6TpNlAbIfnUl4PfNJ/3lgRUYeJPVpz
         V2EQ==
X-Gm-Message-State: AOJu0YxjM/9/RHxmHB2XefHtSb0jQx+twHrfnAgI9P/MyXuubgkJ0cw0
	VzmewY8dJqOPNJb7rv9AwXmvYvq8y6Dy
X-Google-Smtp-Source: AGHT+IEXYfwbjMuOhaavTU76/l1dg18I1F9vBu9R0Zw3RN6i+CppLr4+FB7CQH5A9Vaq6ifuIf4nKg==
X-Received: by 2002:a05:600c:298c:b0:40d:5aea:c89b with SMTP id r12-20020a05600c298c00b0040d5aeac89bmr438395wmd.64.1704808072719;
        Tue, 09 Jan 2024 05:47:52 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d46c8000000b003372befd19bsm2455240wrs.104.2024.01.09.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:47:52 -0800 (PST)
Date: Tue, 9 Jan 2024 13:47:48 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v10 0/2] Introducing trace buffer mapping by user-space
Message-ID: <ZZ1OhPXsDE4JCno0@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
 <20240109220445.5683e4af0cea6b034945b2bb@kernel.org>
 <20240109082057.2bb6da70@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109082057.2bb6da70@gandalf.local.home>

On Tue, Jan 09, 2024 at 08:20:57AM -0500, Steven Rostedt wrote:
> 
> Hi Masami, thanks for looking at this.
> 
> On Tue, 9 Jan 2024 22:04:45 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > The tracing ring-buffers can be stored on disk or sent to network
> > > without any copy via splice. However the later doesn't allow real time
> > > processing of the traces. A solution is to give userspace direct access
> > > to the ring-buffer pages via a mapping. An application can now become a
> > > consumer of the ring-buffer, in a similar fashion to what trace_pipe
> > > offers.  
> > 
> > I think this is very nice feature. But this series seems just a feature,
> > no document and no example code. Can you add 2 patches to add those?
> > I know libtracefs already provide a support code, but I think it is
> > better to have a test code under tools/testing/selftests/ring_buffer.
> 
> Yeah, we should have sample code and a test.

Ack. I will recycle what I had in the cover letter in a ring_buffer selftest.

> 
> > 
> > I also wonder what happen if other operation (e.g. taking snapshot) happens
> > while mmaping the ring buffer.
> 
> Hmm, good point. We should disable snapshots when mapped, and also prevent
> mapping with latency tracer if we are not already doing that.

ring_buffer_swap_cpu() is already disabled when mapped as well as
resize_disabled set. Is something else necessary?

> 
> -- Steve

