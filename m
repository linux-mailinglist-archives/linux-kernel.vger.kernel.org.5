Return-Path: <linux-kernel+bounces-73923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DE85CDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E33283144
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A733C29;
	Wed, 21 Feb 2024 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaGYHyb4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B6566A;
	Wed, 21 Feb 2024 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480764; cv=none; b=lorUmgUFtdpAoeBkRA1BLGWlamUzyNp/cQkPizVlHWBpUqQUsWsmihQwjh1VPEi/yHdUee11CeYj/w4WWXVbH8QdhpIVreOog6lXU3rb3Koi2kWX1AjY0cUISf6Vt1dJcar6hVYJ9f+ovUk3Rr8bZTIjyhZAi1KHY2TCPKH6Cz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480764; c=relaxed/simple;
	bh=NLwamubHOdxN0Lj8uKc4TckyhPGFH9znJF09/t3gByk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IM6rmYrMPjf30PfVpUYUKzXim0e+wNiBslHG7oMMBrV+efTDc5mjFyUnP19f6QMqKxHSeNlWJO1pxWEleI1dqiZ7u8uqLUX37WGaHEOu8HfZshd8YbNcuNq9Ifg6B1/vLIWXpK/wxI6x1LZCS/aCSXRuc8uVIyhDjXZL/HQKiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaGYHyb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7324C433C7;
	Wed, 21 Feb 2024 01:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480764;
	bh=NLwamubHOdxN0Lj8uKc4TckyhPGFH9znJF09/t3gByk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaGYHyb4l+bgPYKFdVnKDbP716aWAKfQCalo5xWSEgzV7wmSjC3SvgNsUVpe5DSh1
	 G6+zXoXpOLqmXz1U1LneF7KB56L0M7EvjqTqfaxg5m6PETHel8ltpKhK01tnpJw512
	 AaHYW7Y4zUdryOXAQBZATc9BjeEwzs8919eoOKico34Gv1/O5V4HwHDQOZ2IDHdG1W
	 ORr2x/jGn0RvBmZODyDu993CfU41nt4Kug/HIT/JlwSIzTdrO2uQ4P4uYdBIT+EZfh
	 JIN/UD5W8RoL83f6sfb/7uQuhdVwhRZTEnoXjC3jMoz/5IpH4l1+qQavbGcKw9oD1w
	 wtI0rlfp/oZXw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 1/1 v2] perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h
Date: Tue, 20 Feb 2024 17:59:21 -0800
Message-ID: <170848061720.1313505.18406074637867075838.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <Zc_fp6CgDClPhS_O@x1>
References: <Zc_fp6CgDClPhS_O@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 19:20:23 -0300, Arnaldo Carvalho de Melo wrote:
> If we instead decide to generate vmlinux.h from BTF info, it will be
> there:
> 
>   $ pahole timespec64
>   struct timespec64 {
>   	time64_t                   tv_sec;               /*     0     8 */
>   	long int                   tv_nsec;              /*     8     8 */
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

