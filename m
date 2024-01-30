Return-Path: <linux-kernel+bounces-44370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14484210B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E81F263E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58560EC4;
	Tue, 30 Jan 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="joRP6Hu5"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86F18E25
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610022; cv=none; b=EmD8N8gdgaUVLVScQ9WB9eaJHcVve9LblL3J6F8hUTnDc8jYMjKgvXv5LJOZe+g7PnpZ7HY023quVGPd8KpHrLoyUL0Vb3mEiLfqebrjDFSElrc4pbH3CYt4OS0Ux3bMVMVKV/Mwdh83L4USte6Hlt2MDYVYN90oXnrnm+1x5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610022; c=relaxed/simple;
	bh=iHbQQ3MLCCcjMAInoY2a1a8pyT2oDcS0vQnY2cfXPv4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=mcD/n2zZGaPdjhWrB1wM1e5aTU0LJJ5ZoxBv9/rVDhYwYFskrhFx3pkGQq4AhNADCsKT84SocOwjsN/uI0dVglEOVgr7zua4vD05eJ6Djj+iaTrqHU6OorO5h2U4NChp4Bmhu/wMYFE2LMWPR8JyjY2EtxlvsLiD+q23HLsWopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=joRP6Hu5; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id UhqfrNY2TMVQiUlDxrthFX; Tue, 30 Jan 2024 10:20:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UlDwructHYjq0UlDwrznFc; Tue, 30 Jan 2024 10:20:12 +0000
X-Authority-Analysis: v=2.4 cv=afxyIDkt c=1 sm=1 tr=0 ts=65b8cd5c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QDmJc+5Q+8ZglzAdl2BcnLkXPCIgoF/fTkzgIRxIZk4=; b=joRP6Hu54MNNifryzWu3Xy4rOi
	XQQUmYkYX36/zGnAiAXN+joan8AbUP7d/TLcT7iGP6AKz6Ohi9Jkml6K9Xnp5VsbsViDkkUwVtsQo
	4dnIFm4Ry5vRAoiqkUHIrzsLaKV44kTZ6KcN047a1j2+2/agGw1G+V7A7aOEtZQmZYcKGC2zU4072
	JzxH7zIS5BDPCWzPceeeqaKsXx0K7xeiQrhuDqdwWUuxNlM5LbKn7hblFccNAcubLytXWXgPm0e1+
	P7bt5wfmgPj2luTquSn+EBgrhmrR/h9JbeWzUjW+ClNaFIMgvSFP+NR+lkZWvkZUkxnPPciPIYDYy
	lq5Z9yOA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:37536 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rUlDt-001IsC-2q;
	Tue, 30 Jan 2024 03:20:09 -0700
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240129170016.356158639@linuxfoundation.org>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <180be0f0-7b95-73e0-45a4-0c5fec11b487@w6rz.net>
Date: Tue, 30 Jan 2024 02:20:07 -0800
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
X-Exim-ID: 1rUlDt-001IsC-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:37536
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBzy21jzT3//0kEE/k5aE8EiBzZJGuaoU2h8dxAodt+23xCkdQZ/aWXB4+VAcPgA7LtHKOMa0N3+bQoFnhLiLGiL+jqfdj6jwFDgc0MGFOsV8190KTZ1
 3UmtVAftfArQjdvaw6GPFde+XT+bxS+iWx59biURmC1rEYaGKtHVwySerK6SZ5eXN8e9xdZNjuoIbN2njkVoYLfc6GmUisBXRps=

On 1/29/24 9:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


