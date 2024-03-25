Return-Path: <linux-kernel+bounces-116927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C688A534
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DEF287EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2C15099E;
	Mon, 25 Mar 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1/2Y4Lmm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88491BB756;
	Mon, 25 Mar 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365481; cv=none; b=lXXlgoU0ZtroVf98LV9oY5nMAI54zWGq8OSveZIfP4R/cWfiY2KkWaGHO9wlkglhtryl12yEjoLj5+lwCld88VAuJFDr0kE3PGRkJ+uO12Hbx2EenfVMGjw/tnNcCjFIfvt9ZzmtGBYSHPOdx41XAkYn6mV0nkO4mo5L/Col+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365481; c=relaxed/simple;
	bh=lTVg3fc6MdE/fo1cwqrDYHPkWi51KMLwn/j+U7Nw9ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=un7set2OnJ/pTzC21eX13ISCu2lR6Y9kfCRCRdrRrz1tZd35dnzByPHNXZPXHKnCMe/8Q58m16O/bqhoywrgji6a+IxEO6Z/YLGtNffBvM6vkA99bdYpVwEG1oQiM9oOe1ByH/fLciRkYcloF21rfN6FXfmFA/Vh7G1tStlvhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1/2Y4Lmm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0I8AaUTcrQp55wpf5askd+06931BKAoEDY7FD5BFLeQ=; t=1711365479;
	x=1711797479; b=1/2Y4LmmZD2hQLf8n1wMhik4twLS9AWFxSYWazx+REOmDC9QWupPl4IxynzMH
	QZpe8z2NdoxMyS38mF6NcTBYRa9ICN9CdV6K2cBYeii+AdkWR3iKKM2a0QgVnt05ddhb1JhhXH/ZJ
	Hd8IVdxk6KRazNibW/PkWjma6pbGaNPnG9DKG6ZOIcaI+TpwULoIdy4P5JyrTzJHNO0mfmPxKj/TF
	4NhXSiDf3Ta+cS7ladp0w9pJXA6ojpRp/+V0k0f80H2ClDWPQdhC66DRl/F2nnrBDtussunVDzEmX
	nw2Q2/8rthNnuiHkUQLV4rXbgE29mP3Kw+tEL9O8n4G0eMq9Vw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1roiKy-0002OP-Mb; Mon, 25 Mar 2024 12:17:56 +0100
Message-ID: <c89f9cc6-9676-46a4-8f8e-01d8dbf41aa8@leemhuis.info>
Date: Mon, 25 Mar 2024 12:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 119/715] libbpf: Add bpf_token_create() API
Content-Language: en-US, de-DE
To: Jiri Slaby <jirislaby@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-120-sashal@kernel.org>
 <e35cc021-7f17-479c-bd7c-ea6df836a04b@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <e35cc021-7f17-479c-bd7c-ea6df836a04b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711365479;ae128cdd;
X-HE-SMSGID: 1roiKy-0002OP-Mb

A quick "me too" from my side below:

On 25.03.24 06:40, Jiri Slaby wrote:
> On 24. 03. 24, 23:24, Sasha Levin wrote:
>> From: Andrii Nakryiko <andrii@kernel.org>
>>
>> [ Upstream commit 639ecd7d6247c48a0175f5b458b648f5d4b6dc34 ]
>>
>> Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.
>>
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> Link:
>> https://lore.kernel.org/bpf/20240124022127.2379740-13-andrii@kernel.org
>> Stable-dep-of: c81a8ab196b5 ("libbpf: Add btf__new_split() API that
>> was declared but not implemented")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   tools/lib/bpf/bpf.c      | 17 +++++++++++++++++
>>   tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 42 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 9dc9625651dcf..d4019928a8646 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -1287,3 +1287,20 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
>>       ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
>>       return libbpf_err_errno(ret);
>>   }
>> +
>> +int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
>> +{
>> +    const size_t attr_sz = offsetofend(union bpf_attr, token_create);
>> +    union bpf_attr attr;
>> +    int fd;
>> +
>> +    if (!OPTS_VALID(opts, bpf_token_create_opts))
>> +        return libbpf_err(-EINVAL);
>> +
>> +    memset(&attr, 0, attr_sz);
>> +    attr.token_create.bpffs_fd = bpffs_fd;
>> +    attr.token_create.flags = OPTS_GET(opts, flags, 0);
> 
> With openSUSE config [1], I see:
> bpf.c:1293:60: error: ‘union bpf_attr’ has no member named
> ‘token_create’; did you mean ‘iter_create’?
> bpf.c:1293:60: error: ‘union bpf_attr’ has no member named
> ‘token_create’; did you mean ‘iter_create’?
> bpf.c:1301:14: error: ‘union bpf_attr’ has no member named
> ‘token_create’; did you mean ‘iter_create’?
> bpf.c:1302:14: error: ‘union bpf_attr’ has no member named
> ‘token_create’; did you mean ‘iter_create’?
> 
> 
> [1]
> https://github.com/openSUSE/kernel-source/blob/master/config/x86_64/default
> 
>> +    fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
> 
> And:
> 
> bpf.c:1304:25: error: ‘BPF_TOKEN_CREATE’ undeclared (first use in this
> function); did you mean ‘BPF_ITER_CREATE’?
> 
> They are added by:
> commit 35f96de04127d332a5c5e8a155d31f452f88c76d
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Tue Jan 23 18:21:00 2024 -0800
> 
>     bpf: Introduce BPF token object
> 
> 
> But if you should take it or drop this all, I don't know...

I ran into the same problems while building 6.8.2-rc1 for Fedora using
the Fedora 39 config and its RPM spec file (with minor modifications):

https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/stable-rc/fedora-39-x86_64/07210895-stablerc-stablerc-releases/builder-live.log.gz

Ciao, Thorsten

