Return-Path: <linux-kernel+bounces-121878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4288EEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC4B1C3368A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36851509AE;
	Wed, 27 Mar 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qGdsfb5n"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F17131BC0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566589; cv=none; b=QGO1WpsgqRSVQKGjqe8JaHhRYB9Qvwh3RMbLG8UN9LOxm+ubRJEewIx7eFLNTHKCC1G1tmRWej/1399tX+wcpZ8tOHlalMBdGb1KIZtBZq7lOLb71XLtF5h47W0O57kR3pvoSc/TBKfKko+ZGTezHZqCBeltq2CQ4NJzqWIRD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566589; c=relaxed/simple;
	bh=VuFdCUTeCOnad4gk6omCYrg21NlNNqeSLBu5rRtqVXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6wgoCnYIIJQQNXA3+WiVxS1MyPc110ZL1rdJHbZRvxoH5HWPP571bob+J3h1cW8hkeg0I9FqWqSu/NFExAPhlkiiMqGxz2QX6UjCgKaSTf9y+Qd9bM9SdMIbX/oU/sVvckZefFOB2e85I1Rzvg47o1q1J4D7DUYuvdSyZcjM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qGdsfb5n; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id pWKkrLIEGtf2QpYehr430H; Wed, 27 Mar 2024 19:09:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYegrqKI8QufZpYehrvOzC; Wed, 27 Mar 2024 19:09:47 +0000
X-Authority-Analysis: v=2.4 cv=eK4Vjmp1 c=1 sm=1 tr=0 ts=66046efb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=jgUHHrBZrz3db-_ODY8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=agm2AiH62BDQPh9qtko/Ix12J6Yxy9RCLO/4NODZzQU=; b=qGdsfb5n3srrLy6Jbt0CD1F9Ay
	CnkPWga/hrZcYJpakf7dMoa5k7jGT+aNsEAUb9q8H8wv2wRB8l+jOC/zR3JZdFkYcX5gf5buskJII
	fwRfy6b9HE5BEiN9J9FneDQ3xFEvzPSByG2S2NTmZ30Fy3w7zX7gp2GdcAeS6tKGEUFdtniyvh9zr
	n2nFX1hsQ5fk+hxRnY03QzzhlcSYShxZsjpLDMw3axJVvdEXbnBzDC8dJMG48ltyuS3pEdVOyTbBw
	fcl38+ziLh8h9ZnAxMBBLsYyc2fNQPjOrr40I1N4cZ3TRv9XzfI7rrJQzDPF5+PF7feKalGZHSFGF
	itV6vdGg==;
Received: from [201.172.173.147] (port=55016 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYeg-003lvN-10;
	Wed, 27 Mar 2024 14:09:46 -0500
Message-ID: <62d3dd2c-ef46-4931-a9d6-8455b7b60870@embeddedor.com>
Date: Wed, 27 Mar 2024 13:09:44 -0600
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
To: Kalle Valo <kvalo@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgRqjGShTl3y5FFB@neat> <87edbv7b9z.fsf@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <87edbv7b9z.fsf@kernel.org>
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
X-Exim-ID: 1rpYeg-003lvN-10
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:55016
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAEcBxiMwUExBa3UFLhNSlM2OeUYKj8NOaAg6wQ3TwtTlUDxaslV5tMUZCj09y8EAbGPblN3g8JQfBbot/Hx/J/RxfDMStaBvB+8Ex+AgCY47EA+iwyf
 gc9OgfuOalcaxiudMnbDfmdMGPfPyMcFTl4Mm+fAwwbhlaBvUeWFKpMvauYemKxve/HtydlB2s2ChMdp8dM2HrqyrrWGVgq3Qu/XjatTADhOumXhqrM/J9Yr


> The subject should being with "wifi: wil6210:", I can fix that. (Didn't
> review the rest yet.)
> 

It seems I got it right in a subsequent patch. :)

Thanks, Kalle.
--
Gustavo

