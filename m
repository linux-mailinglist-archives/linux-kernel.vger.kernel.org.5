Return-Path: <linux-kernel+bounces-122018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8CA88F0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BC229C5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A214388B;
	Wed, 27 Mar 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nO6nQhvz"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9914F12A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574617; cv=none; b=N/95XnHxr7mhTAmgrLzPwPcvebaDr4L1A3le8pVaYcDvIhtjkYBT6ucqOTaSngq4j6WZEct8z7GNPqeI6GPV3eFe+vOFTJi+Fl3KJwn74163z+7hoWKIZrmIKp6xUmPc+OtPBJAHtHXKfhs1XkmW2Gfap5WTnGBlEbT155111f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574617; c=relaxed/simple;
	bh=SFk0yMhEz0n0/INYOQ4iL0r35gb6Smhb0rfON65CVy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSLqwD+jv67zXCBpVBvPMgL1DW+7QKFmk+jPZlpgkAHYd4McDrnq0wmnzq7FTKUyu1e7xldjYRlVtKzwamnzrruZGzX4kKUuNbh2pWmaP5wr1jNJ65t9ise1+eYTU7eGI+5XsjyO0SHNuZq8lVbvdvKI44561E7wEXYnizMPi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nO6nQhvz; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id pWKlrI1Fnl9dRpakArlXv2; Wed, 27 Mar 2024 21:23:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pak9r1MoMHHoApakArl6In; Wed, 27 Mar 2024 21:23:34 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=66048e56
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=r1m6Mex8H7dn_w9A3qgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VTBvfIo+Q/FuoSo4pHyZkH/akXuqsBymcH2C02HWSbE=; b=nO6nQhvz8wxflrFyP+PfzA3NA2
	W2IkCrjoo0kgypSKPNA4F9mZrvQJkGLrKGKteQQS0koQBh40jxQeCkBxsdiguyhvzNJRgsA7Frmgq
	JevGXRf9cTerFLN8eabJwIjIvuRJ6nCWkId7e4Be4WvmRmyGBwi0JMd8gRIgBrQBNInKgdfEEp35U
	NWIDSxd3MqstORrK5VPyNgNIw4sKVzzCFCroD29AK8WCOTlpC5yp8pAiOC7i85fbDkoICja1kTWSU
	cAy9CWiUnTy3VX3vhRwmrGqdLdl9YBCXcJEaP056OLOJ6doxW1uGxBurzIeWspuEV8dljv0e/Nf3R
	/xD3mOVA==;
Received: from [201.172.173.147] (port=40896 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpak9-001WFn-1A;
	Wed, 27 Mar 2024 16:23:33 -0500
Message-ID: <db78155a-65c1-455b-aaaf-0463b17009f5@embeddedor.com>
Date: Wed, 27 Mar 2024 15:23:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: cfg80211: Use __counted_by() in struct
 wmi_start_scan_cmd and avoid -Wfamnae warning
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRqjGShTl3y5FFB@neat>
 <3670c9af-3266-4b9b-928e-e91a68db7123@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <3670c9af-3266-4b9b-928e-e91a68db7123@quicinc.com>
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
X-Exim-ID: 1rpak9-001WFn-1A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:40896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIvb4CNmZUzWZIr45ZtgdHhelv6UWPmXIOOAcXmLYqQR1yJ6nOlU2PoINzg+MjRVTKUgCvbnqLOLBJP1vb8GcoHL27nJPejaPirx0uB3grPqGPbPzWWz
 hP9u9wEqAZ01zeQsoVUfesMSCYaY+YVD7dvtEareqD/rwcTyp3X50PbEF5oGns64Tx4ZZ2UMA6b/snEW+UisZ+iHzbFPUe7uD33AaK2Qib3vZay1R0wZUlas


>> -	memset(&cmd, 0, sizeof(cmd));
>> -	cmd.cmd.scan_type = WMI_ACTIVE_SCAN;
>> -	cmd.cmd.num_channels = 0;
>> +	memset(cmd, 0, sizeof(*cmd));
> 
> Isn't this unnecessary since DEFINE_FLEX() logic "{ .obj.COUNTER = COUNT, }"
> should result in everything else being zeroed?
> 
> And if that isn't sufficient, DEFINE_FLEX() itself says we should "Use
> __struct_size(@NAME) to get compile-time size of it afterwards"
> 
> Note the current memset won't zero the flex array and hence if the actual
> number of channels is less than 4 then kernel stack contents could be exposed
> to firmware.

Yes, that's correct. The current memset() will only zero out a total of
sizeof(struct wmi_start_scan_cmd) bytes, which of course doesn't include
the flex-array member.

Thanks for the review, I'll remove that line!

--
Gustavo


