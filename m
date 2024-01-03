Return-Path: <linux-kernel+bounces-15669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8B822FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9456B21C66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8A1BDE2;
	Wed,  3 Jan 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExXQmuKX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485F1BDDE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704293373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYLCwmmbmYheSadYB7YVd1kluDxaizgGDhgVT6F+P/E=;
	b=ExXQmuKXya325F4Xjk/zfg2EDwaUdFHKS8aVUnyq/V1syWUEQaeE2gCCeS8dm/a9aB7AGc
	6xqo1qEOGJfdFhX2+uOvwxeoVSG3dkm6wTGqghZoYTzMA1ZYIePt0c9CL/fFEqSN/1YXxU
	NkZglqjPCgQvP9YSPkZ0TUeUbP18jEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-oRUyMfEkMWuzYcglUmxmKQ-1; Wed, 03 Jan 2024 09:49:31 -0500
X-MC-Unique: oRUyMfEkMWuzYcglUmxmKQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-336992b0f37so6746763f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293370; x=1704898170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYLCwmmbmYheSadYB7YVd1kluDxaizgGDhgVT6F+P/E=;
        b=cEYX2BgNCwEPzoUWMyMCqzY2XBTqpfLZ/3g4j6aXPne4IbE6gpki7kYjnVopG262jK
         RiZChA6rMs4XIvYGzSTYfL6/u5aS717qrHD1ppYEqPyAJ5/zBz0nY29UhC0lQptsGUGd
         HFf0tiUJPe1tnEc3ArZrO7IzqwjGgE/pH2GtR3TvldaNEuYDOMp8cCqUTscttR1NL2FB
         5lv7/+C06bl5Dgxf/ynQPhWyQMo8595L3dYEVyFtMpo3oCfNy2F7LH+xxd3oy4Wu00o5
         fl93l40lZID/vdTmgkFkEBzPNi9NgLkviAg+2BcpBn9wLzRa3UFIlYWccBsazc59nH8F
         PF6A==
X-Gm-Message-State: AOJu0Yw2ZcZdbrUkbkvjpetdWTbYW/D1vgdXhpdAXPn6W8VwzgWWnFee
	ByJNNorsPGM44+R+u8RXM48/62GXmIJjSfH3uIBkR1ZvOImzUcAqt00dTsEfGSagNcRZZaCIRxf
	qA3uVyD79JF9AteZy0vV0sGqf2z44ZtH8
X-Received: by 2002:a05:600c:548d:b0:40c:3856:5e07 with SMTP id iv13-20020a05600c548d00b0040c38565e07mr11517306wmb.9.1704293370723;
        Wed, 03 Jan 2024 06:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeBCjdcxE8tK2QOCpdNihA79iW3/WbizbCwS3mxRJbVsBelw8lquTOEQ0Ng8mulkfrA0XMhw==
X-Received: by 2002:a05:600c:548d:b0:40c:3856:5e07 with SMTP id iv13-20020a05600c548d00b0040c38565e07mr11517302wmb.9.1704293370376;
        Wed, 03 Jan 2024 06:49:30 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c4e5000b0040d933ad598sm411018wmq.27.2024.01.03.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:49:29 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes
 <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Metin Kaya <Metin.Kaya@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, Connor
 O'Brien <connoro@google.com>, John Stultz <jstultz@google.com>
Subject: Re: [PATCH v7 08/23] sched: Split scheduler and execution contexts
In-Reply-To: <20231220001856.3710363-9-jstultz@google.com>
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-9-jstultz@google.com>
Date: Wed, 03 Jan 2024 15:49:28 +0100
Message-ID: <xhsmh7ckqjwuf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/12/23 16:18, John Stultz wrote:
> NOTE: Peter previously mentioned he didn't like the name
> "rq_selected()", but I've not come up with a better alternative.
> I'm very open to other name proposals.
>

I got used to the naming relatively quickly. It "should" be rq_pick()
(i.e. what did the last pick_next_task() return for that rq), but that
naming is unfortunately ambiguous (is it doing a pick itself?), so I think
"selected" works.


