Return-Path: <linux-kernel+bounces-36628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079A83A404
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8992833F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765D23CC;
	Wed, 24 Jan 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="IM5Ll+7q"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA817730
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084465; cv=none; b=IXAZ0nraZjJOulFgpFtiXDHstIctZroNmNhCldXmnz0eqcrelTa6+VOQjjqO2/forHuiScGLlvioYmonAIV21Yg5KLhhkk89u76nseTz7JDrBusVAi7IRNQQ/GtH/SJ1ZLMMjpuw7nQj6EXiXNpVA3EQBic7pe+fexwWmmL33nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084465; c=relaxed/simple;
	bh=kNaiPGrs8nD88my9Fn5D/zX0kIJPxjZ6wZCXgTlnhYs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=LykCxj7tOUTPfAS3bOv+UU29MMOoLjyNpBYpGGHxT468mycxYdTV7/osxk9y2CrHYXhUoFQzW/sawi3etUXcNATcSGOLn0VX08x1BRHv4Na64zuSwUd3wtVgIUBP54kQ1Ply2weVsUMewJ3GQsdoQnXLFGDxxojTI/y4AgvMcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=IM5Ll+7q; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id SOoWruiOiTHHuSYVEruc91; Wed, 24 Jan 2024 08:20:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id SYVDrky6qjqQkSYVDrXxWy; Wed, 24 Jan 2024 08:20:55 +0000
X-Authority-Analysis: v=2.4 cv=A7F/goaG c=1 sm=1 tr=0 ts=65b0c867
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=6j8iSFRaj0e73z2mVzkA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G8jFBv3eg45RGx90JF5eD4WDYEyR/MytscwrHvwwgiY=; b=IM5Ll+7qHW91El8O5cB6SGu031
	3W7W76l4eA4S6bQ4dKsPYCxmMexwmZZdpq8+bMJdUUd1RTnpqeUm8+PAbD/jN0p2TBb/ykIW5H+zk
	3fXLr77QN3yx44ooRcmUulSwZns9eFaqypdD8ymjH4zCqkpmQwyeOFEaZgPOKsnJiSIqF6MCRTgV6
	yIadrJ1i5PjnqWP3FOQ4XUIWjzaUdH9qZZed9L/mJxoccIA70mYj9ivXXXxRAYX/7PloGYXYdZTLF
	e+amhll1CBbUqcV7vJYbjJuc3Ns1ozk2H4OxzdVNvp7Wx61ydA3qqXeebO93syIvQJC4JiXvI9DMh
	LmdJEaXg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:36748 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rSYVB-002XvO-0a;
	Wed, 24 Jan 2024 01:20:53 -0700
Subject: Re: [PATCH 5.15 000/371] 5.15.148-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240123174500.819179356@linuxfoundation.org>
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <64ce4ec6-3955-fba5-db4f-f7ab8c33c746@w6rz.net>
Date: Wed, 24 Jan 2024 00:20:50 -0800
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
X-Exim-ID: 1rSYVB-002XvO-0a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:36748
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKKamMh+6PkOmvBtRwsptHeIb3CR7fRI2RfJW3ecCx2MArTBX+I1Toly8Lv7sBstW/TMijIbzxnL2L/+quy4uAkhfxys9pW/myb+hQ0gzqa5IBDnG/T3
 cyYFXqblc2oXPF6r3G24SqJXDF6i4NtBcO7Gnn0y++R/2pvXh3wFk1qTYnfE6dTltlKBxos/H23XTXLpn5HWqTqUTOxOebafWpk=

On 1/23/24 9:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.148 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


