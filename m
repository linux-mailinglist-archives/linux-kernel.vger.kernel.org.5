Return-Path: <linux-kernel+bounces-162840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59B8B6143
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A84DB218C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A33135407;
	Mon, 29 Apr 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mQMOePvc"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2F1353F3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416159; cv=none; b=jOPcth0JY6wzOr6ZOaZII2G9D3r++45Tjx7U+D3VakjVqI/tFpa7VY5njMiHnc5gbIqwvU3MIE0ckNYp/lTQ43+PucUGdEJN437TN8MTTfVgxX0P2/NDSoL8VUS1XSeQnxRVyRV0QwtnkLnUJiQbhEIgG42eP4CU8eZZaCkY+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416159; c=relaxed/simple;
	bh=o7Rzh6vzHe9kqHnyh0XzcOChBzUGpfd9DHW4G5UZ8Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlX2pGi4aJaGstWFkwn+3RDFrHE+GNQdXpSBd/HpURcfqIN9w+obp6jep/YYVrAhPd8OVkVUoDZcGFDfjw6Bg129jEPhgxmrOfgvSkqBfN3xdQ+DFbu85fkEtB6YpsDyRthdAtVR5bp+E5wXKwapVDduWt5452RZZqjmildP85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mQMOePvc; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 1TkVst1YuSqsh1VxPsqV4Z; Mon, 29 Apr 2024 18:42:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1VxOshYwOELAW1VxOskTQz; Mon, 29 Apr 2024 18:42:30 +0000
X-Authority-Analysis: v=2.4 cv=EfzOQumC c=1 sm=1 tr=0 ts=662fea16
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=v1GTFQr46au9FOpdLhIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7R8iOZZv1UeQk5saLx+Pr9H4OJPkevAvXI2B0KeGlbY=; b=mQMOePvckb+lme1Q4LIcIVB07P
	vApm5UCTHavk75lmlhzQw6NYVve7lvc2S8gFrW+bstGZeHJBHz2quTQp2ZrmkJhapCcZ1jDOx5dWL
	eqDz94RZfiB0uBPKs9LciR4tw4ZpyN1j31WWOJJCSxH+pMlM9tzvQld8CxTql6R6PCPbajVa8yw8Y
	dGvZI5VNhSc9s2+sQeL3/gCgMBq1yABRHIa+UhBFqb5eaRsYfwPcZoedGpuhhbRNDHOHEf3YdV0/j
	ha/cRMnszSG69sF+d8fQvy1yfqJ0N3Aygz6iT+GOnveQIg/5RyyPAEaCDJGwORAbzRWiEyoh2vNT6
	wDjKAcCQ==;
Received: from [201.172.173.147] (port=36178 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1s1VxN-002n1Z-1F;
	Mon, 29 Apr 2024 13:42:29 -0500
Message-ID: <90ddce3b-1ad5-49be-89f9-2f3e48d73e19@embeddedor.com>
Date: Mon, 29 Apr 2024 12:42:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <cover.1709658886.git.gustavoars@kernel.org>
 <20240306011030.GA71684@workstation.local>
 <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>
 <202404291129.F261DEA21F@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202404291129.F261DEA21F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1s1VxN-002n1Z-1F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:36178
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC41sFAjlIv9us6jFIm2r9tbidEHAsmezYtDXHyR6UDLqsUQFlToBo1pIjo+MmswoZgufTReTPOgoFuVtwUopAjveVnadJdqUm8718kR6YzesRmdyYm7
 cm9+7iam1XRAIWnln8q5ATLS92u+H7OkTRu5sT4PnqwuhdJpEkzx/jHExS6WRjxJoNgFNjLQYTBGs/RiCkx8Svw6TvJFiIjfOW/yL4zTuxKZBQh/Ko5MYUJf



On 4/29/24 12:30, Kees Cook wrote:
> On Wed, Mar 06, 2024 at 10:18:59AM -0600, Gustavo A. R. Silva wrote:
>>
>>> Thanks for the improvements, however we are mostly at the end of
>>> development period for v6.8 kernel. Let me postpone applying the patches
>>> until closing the next merge window (for v6.9), since we need the term to
>>> evaluate the change. I mean that it goes to v6.10 kernel.
>>
>> Sure, no problem.
>>
>> Actually, I'll send a v2 with DEFINE_FLEX(), instead.
> 
> I was just going through the patch tracker to make sure stuff got
> handled -- did a v2 of these ever get posted? I don't see anything in
> the tracker nor changes here in -next.

Yes, it's in linux-next already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1d717123bb1a7555a432e51a41709badf8545dba

--
Gustavo

