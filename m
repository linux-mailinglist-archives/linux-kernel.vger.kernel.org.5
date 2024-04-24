Return-Path: <linux-kernel+bounces-157753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C08B1554
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078421C21FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5E15746A;
	Wed, 24 Apr 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEvs492O"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A1158852
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995448; cv=none; b=Lvwzw6BOhe0llteWkl+4tVR7+pREoMlTbiEfPxR3cCKvWblD2EVh7X8H0RfmYMRvkn6KGmUcUFCKoQUiWV+CnMkLO3Ba/coE/OlvhHohieXeqg1HOCaSI7Mx5iT0qmUwKDKNliS8rmAuHRkZuZ6kg2aWwKmh8KLPsui4g7R93Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995448; c=relaxed/simple;
	bh=U/f0nf6h9F8yps4GjM0xDWooFK92vVOs9kuCXrbPIbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke9sNVCT1IbBf74Njd8Ya1yungoqldvgJqZjc7bx3WdS4CXyLgxF/dAZyfkW0s2tBTOB+zhysCOsSK5r1AImLoq+gS1fiZOnh0qkZw2ent2Hj5vQtLjRenMVyhUX3Sjdn+WRSCihv7Jype/4mSS8LoseZ+k0uFLhMoSt2Ti1uWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEvs492O; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc80d845-5bd1-4c09-a933-1d74bed6c416@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713995444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/f0nf6h9F8yps4GjM0xDWooFK92vVOs9kuCXrbPIbU=;
	b=KEvs492Od2v18DpUsp6LMGgNVEhYwjmRfjXkyITlp7RpSdzm8dhJ/fvERbRugVeVFQjZ0Y
	zZDV3nsegoWko02dJHYexIp3zwwuqS0jULpo7gyW9WX2wHre8GOj1WViJo3jU0e0vqC797
	yJlTq/OZGPDU3Hq+NVrkbr5WCJ79Two=
Date: Wed, 24 Apr 2024 14:50:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] bpf: update the comment for BTF_FIELDS_MAX
Content-Language: en-GB
To: Haiyue Wang <haiyue.wang@intel.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240424054526.8031-1-haiyue.wang@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240424054526.8031-1-haiyue.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/23/24 10:45 PM, Haiyue Wang wrote:
> The commit d56b63cf0c0f ("bpf: add support for bpf_wq user type")
> changes the fields support number to 11, just sync the comment.
>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


