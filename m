Return-Path: <linux-kernel+bounces-94786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF0E874538
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DA91C23B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CE4689;
	Thu,  7 Mar 2024 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KU46e9cx"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6B17F0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772067; cv=none; b=Z8TXDtG0XTCgsHSn4xM+dhmlzQTbPnxbVbL+PI/TRKfTdnhnwvH7Vc6AEIU8atnOZzKWvwpb+yKVXKOrJULwXZUshdSB4ClE3zAKcGeiRabD/nkkqtLywdkIXWGBGxxws8h4oik79EtRBXIbJnpbOVaZ8Qn4v/IM6ImbstDW1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772067; c=relaxed/simple;
	bh=EbCRrC7D836n3/gfVrkt21cUTLd++USvTDfHPhMW0+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRneLRgWpxO9xtPfO2gePTrzfWVCGeokQCThd0Jv7lgcPllrxaxfU34ccatVHKKqQuh8j460ZY4tK4ZVL1zu+NIMNU1u3K4AJz7OPvSNQMX5FzKsSQQ1foOp+V2+2XxtvZ/mFZPHZlvyajHY83ooRzXF3aeV5yXOolm3ec2vLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KU46e9cx; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id hwyZrHwZsuh6si1omrWm8k; Thu, 07 Mar 2024 00:41:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id i1olrRwfMKt8Mi1omr0noT; Thu, 07 Mar 2024 00:41:04 +0000
X-Authority-Analysis: v=2.4 cv=dLegmvZb c=1 sm=1 tr=0 ts=65e90d20
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=vznqr7mipjY0YkA7v-cA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5BVrUIvBfOEk6nFXkFrEkJGrcbLKTx3N+QLOz2Ii6fA=; b=KU46e9cxXRHxCpm2jlbl/bYAGv
	3QO4r2zEV4/MVLI/+DgJSKHhOuGD6putlxEfPmr3mE+S72URrEbonRTC5l4C6arewij3hE0bDSYcr
	4fICckYkdF4Q+Kpk01lNNNSvoot+pNWMwiY5D1Pqv6N0imQAeYgbUXUkAgIBrjW62oGjouS4oAF2h
	MrWsRiT5oqzyi9wsKutmBFsyQ1V3eBHiFWbqi3qcfloky9O81heGE8bRHZG6b+9PuNTJMCHOuMDa/
	qre1mj//RwuYb4dnyBSx4HOBF03/5MkX4uimbVSS+FvdB2WI55CEp2IFgRS3zxNmMmBTCfOTALUKv
	b1fCumUg==;
Received: from [201.172.172.225] (port=38044 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ri1oj-003fVW-27;
	Wed, 06 Mar 2024 18:41:01 -0600
Message-ID: <22b99862-5889-4acb-96e5-7552c06e362b@embeddedor.com>
Date: Wed, 6 Mar 2024 18:40:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] overflow: Change DEFINE_FLEX to take __counted_by
 member
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20240306235128.it.933-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240306235128.it.933-kees@kernel.org>
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
X-Exim-ID: 1ri1oj-003fVW-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:38044
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGP3WhXpaybsg2e+WkIEKJYpsgdFbol/24tz7GKnLG+G+DKRCroyfqKKxw3yM81a06uRETzYtxIBDcG1UMP367h+j1vdfuMzBLqDJS/4YijmqbWi+rqq
 zFYCwPH7PRBRsMfm0SLRtC8Uv5Ev2SS8grjKUBVHi90a9CBbu+9JtUrxuyMiBd1xmOknRvGorqA8YYKiJpWe5VCymt+pILMY9jNB+u9ry9BOxbvBzygpTsCR



On 3/6/24 17:51, Kees Cook wrote:
> The norm should be flexible array structures with __counted_by
> annotations, so DEFINE_FLEX() is updated to expect that. Rename
> the non-annotated version to DEFINE_RAW_FLEX(), and update the
> few existing users.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

