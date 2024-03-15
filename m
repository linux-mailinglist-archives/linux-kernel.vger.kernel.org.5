Return-Path: <linux-kernel+bounces-103950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927B587C6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEA8284543
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E34C91;
	Fri, 15 Mar 2024 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="npWq4onb"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E383320A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464666; cv=none; b=M7bi0T9A05WXFZY8y7fGO1px/skCXvpKv1BB49fSaFuxWeoXmVGntWS+HS+JqelCno+srZiuPexTzkKQrSM02uasr0SwQmCwPKoqWBt2MvMkFQtCjHU+mKuj4LvwowPn8WmMbppPMCOhEksPLhrFecRBiub39UnEmLffJu7LmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464666; c=relaxed/simple;
	bh=X/ZyG0aTHgaF46xsq3TWe49VpLqiKQo0/7ojJDuiYbQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=C1rRu0JFkN1OqbcroAMmAq3goGjLzq5qvphjfQ7tXzI3tieRYX+XKNTcpuqAyrzraeoNbUjBF1xGAf8RqbiBxXsP6cNIKdtS97Ar80Pu2BWmYFXYsIu6JjbPSyniZAZeRRdySzWO0irBCYOfTpnhkCrJfly0zynjv5wf6LOg2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=npWq4onb; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id kvgcrKBhDPM1hkvzirkOnm; Fri, 15 Mar 2024 01:04:23 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id kvzhrMH0Za5IrkvziriLhl; Fri, 15 Mar 2024 01:04:22 +0000
X-Authority-Analysis: v=2.4 cv=HpZwGVTS c=1 sm=1 tr=0 ts=65f39e96
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fgzz3YHIOOb4mvquEeWZhyzOq+Bfy/+Qp273CxCSJKo=; b=npWq4onb17h3/jlXmSSSbF126P
	gQRNXao1si/AoQUZUmrjs9iWVT1fzKIAAuICKxWMtH6qLARS63v6dXCszE9ZsTrqCHufG0YooAu0i
	luM9Whmk3PAZQNcRfl1r/lh9GpKA5VPd5x8CSsyO+W5wYIQioc95PjhfoczYJtWh0zGYLnwAsivlc
	VZFZs1HeEdkiGbyzXQ9lnBphvu4J2hMoHLTF7huhTHP4blULpJopD3YQYP1l5CIh/uftngfod313Q
	4/1yGPHII7opsLnlG5gH/sd1a2FaTV0G9sZTNfFQ1Qy+hbMEp/66UWDbMTwZRTGOyXGW3akSJlCK+
	cQmECvPQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51114 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rkvzh-003VVH-0O;
	Thu, 14 Mar 2024 19:04:21 -0600
Subject: Re: [PATCH 6.7 00/61] 6.7.10-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163236.613880-1-sashal@kernel.org>
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <db6e3a90-a4e8-5332-c1a2-7dbd869a8c79@w6rz.net>
Date: Thu, 14 Mar 2024 18:04:19 -0700
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
X-Exim-ID: 1rkvzh-003VVH-0O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51114
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDejpM79mGjI+wE4n6gQMbM+bw0rlXSZgQ7iXHpkd8hUtyR5rdLDjEGgWyG2OO0VuLDVCarqGzm+6y+QOdJammS1OmDuBuNHn8bElwiNkJMP4CfsA6BO
 UwG2dwLvUXGexYau5GJk98FqFEe+fHmOqlyu4FfN2O3zmtLSRvx/xvVl65kfv8At1oCUw6b8VF9jeHiAmEcy6KYCIYKyDG1m0y0=

On 3/13/24 9:31 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:32:27 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.9
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


