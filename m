Return-Path: <linux-kernel+bounces-131080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE68982CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE7128CDA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724E5EE76;
	Thu,  4 Apr 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="L6KuHXmo"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB557899
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217943; cv=none; b=uNdILy4g1pH4oeRuix9m/WfO/Fgg5hJCCiboYR08A9R2i7BJt+KpYl1hBveuAyw3Kw4quuwlFylv9uTGdQbVKvcfwWfpiYQMuIBrB29CvF45912ha435xjpwNyAgqOSKgrzptLbmN5AoCDGmhUIDkyeDL9WsUVGUi7a1GOnvrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217943; c=relaxed/simple;
	bh=FfogCXg1denSKnv+e57KH681GF6JAWJwkueVafmTSqk=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=udnbn9qNB7EzwCvVouiOMspsocP6pesJhvswUoCYzXsklyElG14sEJ31Tw2C/jkW0QoiN4TQcVe5/YLQzLVsvCK45ZE7aD3+8uBo2GClt4lT/yyp1a2YVghfG/oD9+oXO+3HmTvkzx+BkVuc3Z+KRkjUw7o4g+YDCaTu53VShXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=L6KuHXmo; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id rsRIrEoTZPM1hsI6OrAlhj; Thu, 04 Apr 2024 08:05:40 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id sI6NrPPFzHHoAsI6NrhcHn; Thu, 04 Apr 2024 08:05:39 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=660e5f53
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=so6cLkOekY8GEi8VpEyPTvjrn71W93dZ8SYl/vuJ+sY=; b=L6KuHXmoNv8cssyK48RTDHf5q7
	oKJYss8d0T71zr7KREFnsRBPBDJgYnrD2KTRvxCIPGaWVXhMh4tSSW/EiiNiJ79tvXGk66+6JEPyf
	t2HzY9WM7IbVGXhXqHwOAz6abjw8keTSizHATvD87aYOEm29Y9VoHYAYrBKqTnVa/8GkzEWTBN00Z
	XoWmVuBtD+VbzE6L/qTccXRDY8MRjtI0HnK1fXL7HwkBUKoCnXf/T1/mgyOJzBslh7uasR2x75E78
	EPvirEgIi4VZDZ99iNKxuwZ2hRwrb2fVy6UcntsU6BNEJSEJvtzP+xVTsWECbkCLJ0SQmHcGVRSZK
	Cf+uQ2IA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55684 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rsI6L-002nsX-0m;
	Thu, 04 Apr 2024 02:05:37 -0600
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240403175126.839589571@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <cfd9c3a9-6ac1-1e52-c2dd-8fc6c89d1942@w6rz.net>
Date: Thu, 4 Apr 2024 01:05:34 -0700
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
X-Exim-ID: 1rsI6L-002nsX-0m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55684
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMDyLJKVc0Bwr9xeCM9sEY207RfQekekOkbDvxHA+t4HzHocTN5/wRCR9fwzEmJxNBfYst4o8kHbaknR325iSEvK6OPQGg2rkG2Qt/wCkOvupCjiQLAs
 rj21LaeYRh//iAPYH6t4/ZS2UAurEBow1sAey/88n3X6jvV1Vca1EDTY2uL2v/koN2zNnUeikCZCZxqAIzM4ko8jsNbTHosGgjg=

On 4/3/24 10:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


