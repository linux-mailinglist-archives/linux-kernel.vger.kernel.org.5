Return-Path: <linux-kernel+bounces-104608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3C87D0E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB788B232CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9D40BE5;
	Fri, 15 Mar 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="LP6zeCjc"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A21773D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518521; cv=none; b=eFm/ThKGBiDN8O1DEbLvNLas8e+jRZAwEYbVWgFT2j2ysk9oEegqfVDRNiXaTlJqNMCnKR62MzwZ+aQJKWosko9e0mQXKVWkLYQRNwe78IvOGFp3kEiBhoTc4DdvbYDAdhvXppGkuJhcMyWgf24gGUPHaIgQHdPBVJ8y1QgWAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518521; c=relaxed/simple;
	bh=N2TNj6SzVcm4tQs2+i96GqLhQOMd+qQHIk54pEso/0s=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=jCQpScoyJ09F8kZcxttEMigso/vKsXnxFQ/l2xGL8/AnyCER7ag70GyYhnzfEr57VhwOqzQIVklCY+ac69OHvfGq6sZjWdLLfiVk/cayNB+ktwwiO+C8gFrsARh+z5v46Alt9cFc56vu3D2I6UIpLHpqiicCJKrQ2Bh2uepauE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=LP6zeCjc; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id l9bWrO2PBPM1hlA0FrrC8m; Fri, 15 Mar 2024 16:01:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id lA0ErT6dhmxLNlA0ErlW1x; Fri, 15 Mar 2024 16:01:50 +0000
X-Authority-Analysis: v=2.4 cv=GaARnxXL c=1 sm=1 tr=0 ts=65f470ee
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
	bh=XineX5Z/IkLFuTEpgzr7Cw7iEBWcAoh1wS8sfk9tgtM=; b=LP6zeCjc5X1W2KfwOUDXdYpkbi
	3yyo/tmSCx4QRUVOCqilXeg1u8OODg7gZvw6Cpa0N+Q576hagSlNRhltIZv00wNwoNJFZ5jGSTWUM
	fQpdLDO/zvhTTg6U3MfOGKdO+4lurasIXF7sDWOwob6QlA2X2qr8LE7AIVjJoVpOMol6eMB1Tt0Uy
	9XUtBwYMkeLTWGq4tZgP+oouI9BdSXCYo5q8fJT/gfINVxxBzR/h5INA9qMFU8hYV86oWB/7R48+Y
	cpv0fHRRh9+Aw5ZnKcYXe0yx8HWvZ+FYIORccPv3AQ3A7EyFytZqJ4vYtgXuBaN1tAHbQHe2Ll1yN
	28PfGiqw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51158 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rlA0D-001OIi-29;
	Fri, 15 Mar 2024 10:01:49 -0600
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163707.615000-1-sashal@kernel.org>
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <28ee915b-dc41-d8a3-594b-b269014cb6a3@w6rz.net>
Date: Fri, 15 Mar 2024 09:01:47 -0700
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
X-Exim-ID: 1rlA0D-001OIi-29
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51158
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOl4p4owzGUoKuXRtkB7SXAfhRV3zHmhl4roo9e52CCwtU7IABLY69tqFLPOO1cc+FG1R9xIrMQri8naZE7GtYh22ZC7fj/C4z1HZI3JWA/wkj6PKUS+
 SFLB5WLzFm13nxANN0EGIBiGuorU08Rksw6R2w8IY16QFTGps+r+HP85r+pzj9YIoYJWYOaexceYdQnIUTdGxHEU0dWIpEI2DRQ=

On 3/13/24 9:36 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:36:58 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.21
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


