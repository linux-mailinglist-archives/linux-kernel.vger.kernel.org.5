Return-Path: <linux-kernel+bounces-94249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D7873BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204C2B24D95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31922137904;
	Wed,  6 Mar 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="w5TNgDer"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E9133425
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741945; cv=none; b=Aqd+nUmHc/PWFyUB+4BD5fePoyeVeObt6wkDg3jYeLX0I+lITGBEsfQLvZrD5wtfMioKrymSQONktGnnPhimLXrwr416YzuQmr2PIjy/znZHdUDWa50EvmZ955RgP7swFRSfkOptkOFCOQZbLMkbN9WYiOcIEslOh1q3wPwNRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741945; c=relaxed/simple;
	bh=GvHVYUIICAjaOAWJhNYu3ax4WnZhZi/ldWdGTVyeb5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o0ZFlM6fE2EvosiwuOQuAa+yaaz0lIPAiK1IjMO0vhnPczBh1d2PgLzAUtYMJDnj/WIoY3OyNR56CJjKa2GU/LtxKCKpL44vhwxpJ8LcN6gTpk//vUZ6YkC73ZjNH63lUK0BjQUuJLR8kHyyBRINd/l2/e4jybycpfdY7hbbyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=w5TNgDer; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id hsGKrGUcJuh6shtywrSN3b; Wed, 06 Mar 2024 16:19:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id htyvrfNONz883htywrL5hf; Wed, 06 Mar 2024 16:19:02 +0000
X-Authority-Analysis: v=2.4 cv=R6IFG8RX c=1 sm=1 tr=0 ts=65e89776
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=CEfcKhwxmaDNtT7VeCoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GvHVYUIICAjaOAWJhNYu3ax4WnZhZi/ldWdGTVyeb5c=; b=w5TNgDer9Gh3Pg1uMCPC6U4Azk
	iBJbZRsqcNsrwgzqGZS5ExHsPTxg2p+pXN1pA6U0hymRTv2UE2FBEuooD43q9C1w1ji+x2IdozLRG
	j98DSEZ2z5+aPB3tCAPRKLawdhcatSmAUhWgV4wYEgKQUbK8ILopk3IP9W/QukMhMYf6TM2SN9pLX
	VjUJdIoEnhdMLILYws+8kA+bbefw2Iy/YfFI8AaG+qWlBF0gmxdhPNwX7s9M22ErXeLYfcOKpXngW
	KduVBPEifkU0VlUISavWQr12Zk1Zd4plnZRt+swKX5eYMejgBU1jWWH6uN2LtOwGoXthGA8WbIcuk
	kHeAbxqQ==;
Received: from [201.172.172.225] (port=49378 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhtyv-001RDq-0D;
	Wed, 06 Mar 2024 10:19:01 -0600
Message-ID: <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>
Date: Wed, 6 Mar 2024 10:18:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net
References: <cover.1709658886.git.gustavoars@kernel.org>
 <20240306011030.GA71684@workstation.local>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240306011030.GA71684@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhtyv-001RDq-0D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:49378
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEVGmTjNGYdteUUzbm7vbFbeAEX2SpDCEP3PQCa5TOgQfi3N2kw7f2M9lh6s1qgyfSb7aH6eExinlu3K9gDRfQl6lrfe4pwnBzwPwJeB7QhHJvn4cg8X
 mfTKcf8s5SEBfSYplCKR9WXqPvdO/fDjGRH0gXTAcctYXP6F/GMZUizPlPfmBLnvU6pfjGJcwNdt98F73znfgeHnZw/vxb/jBJIXxshQAGzwSufpCajOG+Y1


> Thanks for the improvements, however we are mostly at the end of
> development period for v6.8 kernel. Let me postpone applying the patches
> until closing the next merge window (for v6.9), since we need the term to
> evaluate the change. I mean that it goes to v6.10 kernel.

Sure, no problem.

Actually, I'll send a v2 with DEFINE_FLEX(), instead.

Thanks
--
Gustavo

