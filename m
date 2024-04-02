Return-Path: <linux-kernel+bounces-127647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3903E894EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9453FB2269C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633265914C;
	Tue,  2 Apr 2024 09:41:26 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E358AB4;
	Tue,  2 Apr 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050885; cv=none; b=DaxqZL2m9GEyr0Jl9u/qB+T0InyISzuT1bRzaC/sjXYPsdCrf6CCg9pElLe8p5O0SzGq0n2cXHYF6w3s8+s/pD+t19lFWXzjqGNglVNr4xgnEk6qMAaC2OWY8W5uX5/9Ob93IjXQD7ATBPkP1XEeZDsErlU2X4Krrm/jh4dJPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050885; c=relaxed/simple;
	bh=tN5oFyh5FT8nbCxWgzIRTCIMvlCH6sP7pAG/9YBbhUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slM8bwvsRiETx2pLwUVw7zZwjKATie1S1BOF1/3m6trkwsj4NuMcPzkrdcX/aG4lbDj/Us8Buz2kf3/AjkI8MQw3iPvfsO+k36tWwaQfMAHcceNZ1twsTh8JLoad9FEK4+Rgx20/q9QGvbTUvREOfuRjn0Xz4Inr41WYvNay09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17803240009;
	Tue,  2 Apr 2024 09:41:17 +0000 (UTC)
Message-ID: <0643e9d2-3799-4b6b-81fa-fe516e850f72@ghiti.fr>
Date: Tue, 2 Apr 2024 11:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix the warnings in the 32-bit platform
Content-Language: en-US
To: Ben Zong-You Xie <ben717@andestech.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: dylan@andestech.com, tim609@andestech.com
References: <20240305120501.1785084-1-ben717@andestech.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240305120501.1785084-1-ben717@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Ben,

On 05/03/2024 13:04, Ben Zong-You Xie wrote:
> This series fix two incompatible type warnings when building perf in the
> 32-bit platform.
>
> Ben Zong-You Xie (2):
>    perf daemon: Fix the warning about time_t
>    perf riscv: Fix the warning due to the incompatible type
>
>   tools/perf/arch/riscv/util/header.c | 2 +-
>   tools/perf/builtin-daemon.c         | 9 +++++----
>   2 files changed, 6 insertions(+), 5 deletions(-)
>

For the series, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

To me this should go into -fixes, but which tree? perf or riscv?

Thanks,

Alex


