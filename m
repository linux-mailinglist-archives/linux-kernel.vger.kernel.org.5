Return-Path: <linux-kernel+bounces-21741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A3182939F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7666B1F26CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F632C75;
	Wed, 10 Jan 2024 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I9MEITYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91C2E623
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD08AC433C7;
	Wed, 10 Jan 2024 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704867289;
	bh=ubcvQfp0UsJ8CksAdInXVosl+AP1MYyH7VK3oTymF4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9MEITYad+YTclrI5Z5Py70FcaVZsU4ak8qh2Zuc4jHUxOBhdfb9Hw+XR1Paowne8
	 JRiXTvRbGxxVpvNxfaeZE2kN1frRUqOp0xQp0Ma7XUq3y8vJg7Vr2HDbMwCA/pKPfq
	 gn/bSWBRx6KtYxhUYXo39uZpqpIzVwQR7JiV8vpw=
Date: Tue, 9 Jan 2024 22:14:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: irogers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] lib min_heap: Min heap optimizations
Message-Id: <20240109221447.3d5e8878b0d6424d26666be5@linux-foundation.org>
In-Reply-To: <20240103205259.2108410-1-visitorckw@gmail.com>
References: <20240103205259.2108410-1-visitorckw@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jan 2024 04:52:57 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Hello,
> 
> The purpose of this patch series is to enhance the existing min heap
> implementation. The optimization focuses on both the heap construction
> process and the number of comparisons made during the heapify
> operation.
> 

The patches look nice, but the only user of this code is
kernel/events/core.c and the developers of that code aren't cc'ed, so
please rectify that.

Has Ian commented on these changes?

The amount of inlining in min_heap.h is amazing.  Was there some
special reason for this?  It makes min_heap somewhat unsuitable for
more general use.

