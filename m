Return-Path: <linux-kernel+bounces-118692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273BB88BE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4EA1F3B1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8124F88C;
	Tue, 26 Mar 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yxSfnXz9"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA744393
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445788; cv=none; b=R23LrLPIQZHf+KyRBityj2N8OmpM417qx9P4Al+EsMTp5Nqpc7Gsn8pe1B7UeavuDwGe/vQ6m3K6MnVaCnHyOS0hj1yWnn3Bz4tTD85gajldZDb5/qA8XN4Evdq9nLK6s0QKGzNqmu15LEdqCf6AsoBSYUNaLUhVTTCHCUJ5Am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445788; c=relaxed/simple;
	bh=o5C3GkJI1teIOoQde29gZtmnTs5PIrjRWxe/Bv0X+Ec=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=sWR7NURRtswOB+aXt3KlZlIcuZsQ8aAeSo1o/qB3FZ/dIG4qkx0SnOIBEtvc6PnAWoQ64hiL5NDo4djs7RZAFXyep8DDNWUtU+jIVesxlSvqg5PhPapZHiQMPI6t24lQoOzkqAAjatAvaBmLv/2vVQIaHfN4/VeJvk2lK+BaAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yxSfnXz9; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id ompxrHDzcs4yTp3EGruTz2; Tue, 26 Mar 2024 09:36:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p3EGrVPB4EKylp3EGrck39; Tue, 26 Mar 2024 09:36:24 +0000
X-Authority-Analysis: v=2.4 cv=Bombw5X5 c=1 sm=1 tr=0 ts=66029718
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=fgEOHDi3K2wBU5iTwNUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pa4+v+OWWgs+Mhq7aqttUTDLzvnew8aROhgGfDA182k=; b=yxSfnXz9hXztGLvF8k44vLbD9A
	4Q7p2aqUFFM0MIRN+fEHofArkIbn6PkgdbbAMV3V0Vrvq+b4uzcRtDCY4sfmXM906SqCWwijqsR5n
	XoxVi/2ZMN2YjvGnKIPKKJYZjg3PfYrnFBU4Jo3v+LyOqYEafqP2vLZrEPoKdPDh33oD6a/hjIR4/
	1hab5PsZwHktqEkYLFj0LH8vZQQ4/5B7u2bRoYjFfgbj32op/MphGqZG+T2p7+gSPQkQeqCgyfIaj
	oJzXaA2H7sDVe1KzXj2rRLRO0KcbsMOfhm9zz2WoU016Ib4eqy3owMagAcEgvmCSLNRawmcZ6i9yN
	VhdZkKAg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53514 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp3EF-001e57-2F;
	Tue, 26 Mar 2024 03:36:23 -0600
Subject: Re: [PATCH 6.8 002/715] workqueue.c: Increase workqueue name length
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Audra Mitchell <audra@redhat.com>, Tejun Heo <tj@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-3-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20240324223455.1342824-3-sashal@kernel.org>
Message-ID: <10844429-b80f-ca9d-bf1d-c42efcc635f6@w6rz.net>
Date: Tue, 26 Mar 2024 02:36:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rp3EF-001e57-2F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53514
X-Source-Auth: re@w6rz.net
X-Email-Count: 46
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAtJXEDQJBW2J507va10O6rxrajr8umZ9+CfhytwmAsUbhd9TH7yscipQriFq8RftQBJI/qgxkg3YZ1OosPxd6CbiOjbgDU1zEvrwR4BJ2kykF6DeEsz
 ndqSRPXceX927eTmQlFxA6EgG2UvJ7tYuUofxlvCJiep7PmmxZLrolnxrVl0ept5ZuzBWf7/3O85aQ5RoAHO4Me1Y5cyfx8l20w=

On 3/24/24 3:23 PM, Sasha Levin wrote:
> From: Audra Mitchell <audra@redhat.com>
>
> [ Upstream commit 31c89007285d365aa36f71d8fb0701581c770a27 ]
>
> Currently we limit the size of the workqueue name to 24 characters due to
> commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
> Increase the size to 32 characters and print a warning in the event
> the requested name is larger than the limit of 32 characters.
>
> Signed-off-by: Audra Mitchell <audra@redhat.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   kernel/workqueue.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7b482a26d7419..8a06fddb23e66 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -108,7 +108,7 @@ enum {
>   	RESCUER_NICE_LEVEL	= MIN_NICE,
>   	HIGHPRI_NICE_LEVEL	= MIN_NICE,
>   
> -	WQ_NAME_LEN		= 24,
> +	WQ_NAME_LEN		= 32,
>   };
>   
>   /*
> @@ -4666,6 +4666,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>   	va_list args;
>   	struct workqueue_struct *wq;
>   	struct pool_workqueue *pwq;
> +	int len;
>   
>   	/*
>   	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> @@ -4692,9 +4693,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>   	}
>   
>   	va_start(args, max_active);
> -	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> +	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
>   	va_end(args);
>   
> +	if (len >= WQ_NAME_LEN)
> +		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
> +
>   	max_active = max_active ?: WQ_DFL_ACTIVE;
>   	max_active = wq_clamp_max_active(max_active, flags, wq->name);
>   

Minor issue. The upstream commit 
8318d6a6362f5903edb4c904a8dd447e59be4ad1 "workqueue: Shorten 
events_freezable_power_efficient name" goes with this patch. Otherwise 
the warning "kernel: workqueue: name exceeds WQ_NAME_LEN. Truncating to: 
events_freezable_power_efficien" occurs.

Same for 6.7.11-rc2 and 6.6.23-rc2.



