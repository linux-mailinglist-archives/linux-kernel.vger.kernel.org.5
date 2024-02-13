Return-Path: <linux-kernel+bounces-64563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62060854050
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172BC1F239F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5E6313F;
	Tue, 13 Feb 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxxtW7HM"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96062810
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868061; cv=none; b=i9JxU/SdtwKF+rPUsAbIAzgf7IWd2mwbpls3tqOHtiUK7szZTPdfDB52XPM8ORWFrln0RY2pXGL2uK6X4OibHMl1y6FaLkq12fDcIIVEfiTuFBs6dK5NSGspZLBO/pAI9IEtXy08nhWrNbFh6T51WivhCxbvqLKn1glTA38TWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868061; c=relaxed/simple;
	bh=1OBCRnlZJiUNgmqrqru5Gnm9jN5M8aBjgnUT/VYI22w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwVITXHIUbtUDZfo7CtB1Nw15Qx17QITX6CFZN1LEITYw9wd4N2VGswtvm7zIVjh0lk+bD9oGxKO2RS4RgfMNGl3vYdCU8TejRjWM6Jmw497SYUUQfvai2QyNluu4loUkj1UQ1wZaeNw1ajMflFMnxFflRW0G6+/EaZdLPGBWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rxxtW7HM; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1fa358e9-5a39-4d03-83b4-310a08aeedd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707868057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV6c9Kxgc2BZuaDPGNbAUxKGIn3whIFP96peZqimM+M=;
	b=rxxtW7HMEYuiMkDdQcmBD3AGEttDQgWs/eXaNnHrJwOyeAVnF4LvUGpKFQM7b1QP4qq9TB
	dWJdl7JkZFTfaMXX0Mbq9uv4NyjPPOL20RX3JGMFqq/AXT/WgWoiJKiWqHOnLNeAqnicz1
	BT+Zb+gBPBCIQpKUFZaxgvPlj/mJhHQ=
Date: Tue, 13 Feb 2024 15:47:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next] net: remove check in
 __cgroup_bpf_run_filter_skb
Content-Language: en-US
To: Oliver Crumrine <ozlinuxc@gmail.com>, Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
 <ZcpMCnJMwbgiUMmE@google.com>
 <r4mpzzib2rzcinai6ctcb32jvcbaenrjfddfcr4o6ghfvnqwct@gcmlz3pi253f>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <r4mpzzib2rzcinai6ctcb32jvcbaenrjfddfcr4o6ghfvnqwct@gcmlz3pi253f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/24 10:37 AM, Oliver Crumrine wrote:
> On Mon, Feb 12, 2024 at 08:49:14AM -0800, Stanislav Fomichev wrote:
>> On 02/09, Oliver Crumrine wrote:
>>> Originally, this patch removed a redundant check in
>>> BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
>>> the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
>>> reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
>>> and add the checks to the other macro that calls that function,
>>> BPF_CGROUP_RUN_PROG_INET_INGRESS.
>>>
>>> To sum it up, checking that the socket exists and that it is a full
>>> socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
>>> BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
>>> function they call, __cgroup_bpf_run_filter_skb.
>>>
>>> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
>>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> Quick question: My subject had "net:" in it. Should it have had "bpf:" in
> the subject instead?
> 
> If yes, would this warrant another version of this patch or resending it
> with a different subject?

I fixed it up with "bpf:". Applied. Thanks.


