Return-Path: <linux-kernel+bounces-22326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A9829C34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C9F1C22C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B424CB28;
	Wed, 10 Jan 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL5u0QqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F44CB31
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB08DC433C7;
	Wed, 10 Jan 2024 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704895948;
	bh=BgMHosMhdx0/coJE/dTNo3tadzvMNfGKQ6ctFHbmJYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL5u0QqLTfOpd34wrzgSzAZii3KoaXfIpbwuBpO1dDoSYtMC3fyPAozP0cgBrpRkw
	 3VN+kONAuhXwZ2qTRLTg81ORtxEZAGrN6vzwkAyJuN3GhJf8i5DSWfKF0LhvbFzvY8
	 6CzNVWdzPVUon8hISxvRPNs4yxy5InGt9njxQ+Q5+rdvjcB21H5YFZNtXZzkHMvjga
	 07s6QJ8+ajTKuluPDDSo06zAPJRO6CJ6FV2rdIY10O2abybApIWbuUVgo3NQa2YBD2
	 NPtY4N5kYPw5ikHLjbBaV8tqlLa29jgWXfTFgtJl113XdjLcz7FDueJAAucBqKmq3S
	 wlpaZhK8Fg9QQ==
Date: Wed, 10 Jan 2024 15:12:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/isolation: Warn about missing isolcpus mask
Message-ID: <ZZ6lyc5MB9CgNoBi@localhost.localdomain>
References: <20240110114610.1941474-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110114610.1941474-1-vschneid@redhat.com>

Le Wed, Jan 10, 2024 at 12:46:10PM +0100, Valentin Schneider a écrit :
> Since an empty string is a valid cpulist, this cmdline option does not
> trigger any warnings:
> 
>   isolcpus=domain,
> 
> housekeeping_setup() just carries on and we end up with the housekeeping
> mask being all CPUs in the system.
> 
> Check that there *is* a cpulist and that it isn't empty.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

