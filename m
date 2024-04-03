Return-Path: <linux-kernel+bounces-128902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E18961A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930621C226AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB209F9D4;
	Wed,  3 Apr 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DcBqJ7oG"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972363C8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105387; cv=none; b=d1dFAAI5haGU6cSdxSlg9XseXhweH/3off7ruho+UC7MnqDaxqhjh7idh+MPCf3zHyV3HlltApnJ/7Djthhkroz6Snrg8fzAQUm9+tWqdGUQXzsE6PunDK1fWoTpHrhw42wj4bLdwvNe3+GZiJkMPLMDUnPLKJ9Wv6zBhUPQDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105387; c=relaxed/simple;
	bh=4dK7C/kJTg/Koy+Ep9OVvmuPGFqFUCucC4exXTmjsvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEXTQpEkKLWwy2L6EEsK9V/MGo4hDTpyFXYwFX5wvU69idlz66hc/UQH27rVt14QzhnICm6ZrjnrLtveTjaSf+x2o28dW6ago9lWFksciL6nzwlpU0iSyvQhSMSpTE6IAQsuY3Igezc62oApPO5Ivo9YDr3Lw/VaoS6425vlmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DcBqJ7oG; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id rgpQrjED5uh6srooxrw67t; Wed, 03 Apr 2024 00:49:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id roowrvxxQ9zHMroowrTcV1; Wed, 03 Apr 2024 00:49:43 +0000
X-Authority-Analysis: v=2.4 cv=fo4XZ04f c=1 sm=1 tr=0 ts=660ca7a7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=g72bLlCj1y9NqcwAG1Fglw==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10
 a=WFhDUUEJ9-S_0BG-ZiwA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VqSzRgQgO9eTxbwoLbmir62oY7qQGk+N1QEYVP7K5rY=; b=DcBqJ7oGhUHVJmv1gPsIUQNAl7
	TGhTZ2d1xTlXKI8l3Mm2gs3S/F5o+kIMdeV6abMB7a7Yx/uKDpG9HAPmPA3K9oN0m43/BxV7GidmZ
	Mw+F8REthGPeIG4NMLZfwyY7T9bJTCdh2uLGEB6aFqWtk3v7JwaKAhvMWu5g7X5tr8ND1zZ24N0bI
	qqxAN3Spy41t6YxDI8VpccTFlvYmBbao3C5+GRqB5d1hRdC+VKm6vjvWOQFna/i4qN62mXPSSlCbs
	Xp0tjswCddJsaWsbR1n2L733wO1wh/AuSHxuV5S1gmZgr6g0txUzbUj+E8lDLz/vjtbfOPowrOJeB
	FINiheUw==;
Received: from [201.162.240.213] (port=29677 helo=[192.168.166.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rroov-00178Y-2X;
	Tue, 02 Apr 2024 19:49:42 -0500
Message-ID: <d572be26-0217-4522-8cc4-b9c6a62e6f7c@embeddedor.com>
Date: Tue, 2 Apr 2024 18:49:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nfp: Avoid -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgYWlkxdrrieDYIu@neat> <20240401212424.34a9a9cd@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240401212424.34a9a9cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.240.213
X-Source-L: No
X-Exim-ID: 1rroov-00178Y-2X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.166.44]) [201.162.240.213]:29677
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMlf823UTiawc/cfvKo42EWsudLMldnkN7wB03RIqGfbKgPcN/aY3K9sD5KFazdEx0wVJuAIMx1uhmO61YZMah5qZsqIq8DdSVrR9Vlj5Y0kTdOwfs14
 PtsHPxSnQMrn/tOmZPln3m7HNryBFgPplS1/LBzeCm6qxgCP5OXaIz+Jeobj0+itSGnhJtv5PBmODsplqYlhJbyfrJzHJOJQczHf9Wsm6UykbDnMchlSCjwX



On 01/04/24 22:24, Jakub Kicinski wrote:
> On Thu, 28 Mar 2024 19:17:10 -0600 Gustavo A. R. Silva wrote:
>> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
>> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
>> @@ -34,8 +34,11 @@ enum nfp_dumpspec_type {
>>   
>>   /* generic type plus length */
>>   struct nfp_dump_tl {
>> -	__be32 type;
>> -	__be32 length;	/* chunk length to follow, aligned to 8 bytes */
>> +	/* New members must be added within the struct_group() macro below. */
>> +	struct_group_tagged(nfp_dump_tl_hdr, hdr,
>> +		__be32 type;
>> +		__be32 length;	/* chunk length to follow, aligned to 8 bytes */
>> +	);
>>   	char data[];
>>   };
> 
> I counted 9 references to nfp_dump_tl->data.
> Better to add:
> 
> static void *nfp_dump_tl_data(struct nfp_dump_tl *spec)
> {
> 	return &spec[1];
> }

Unfortunately, that's out-of-bounds for the compiler, and well, basically
the reason why flex-array members were created in the first place.

I was looking into implementing two separate structs:

struct nfp_dump_tl_hdr {
         __be32 type;
         __be32 length;  /* chunk length to follow, aligned to 8 bytes */
};

struct nfp_dump_tl {
         __be32 type;
         __be32 length;  /* chunk length to follow, aligned to 8 bytes */
	char data[];
};

and at least for structs nfp_dumpspec_csr, nfp_dumpspec_rtsym, nfp_dump_csr, and
nfp_dump_rtsym it'd be a clean change (no need for container_of()), but not for
structs nfp_dumpspec_csr and nfp_dumpspec_rtsym because of some casts from
the flex struct:

nfp_add_tlv_size():
         case NFP_DUMPSPEC_TYPE_ME_CSR:
                 spec_csr = (struct nfp_dumpspec_csr *)tl;
                 if (!nfp_csr_spec_valid(spec_csr))
		...

         case NFP_DUMPSPEC_TYPE_INDIRECT_ME_CSR:
                 spec_csr = (struct nfp_dumpspec_csr *)tl;
                 if (!nfp_csr_spec_valid(spec_csr))
		...

	case NFP_DUMPSPEC_TYPE_RTSYM:
                 spec_rtsym = (struct nfp_dumpspec_rtsym *)tl;
                 err = nfp_dump_single_rtsym(pf, spec_rtsym, dump);

nfp_calc_rtsym_dump_sz():
         spec_rtsym = (struct nfp_dumpspec_rtsym *)spec;


At least for those two structs, it's probably more straightforward to use
struct_group_tagged() and container_of().

--
Gustavo

