Return-Path: <linux-kernel+bounces-58213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080184E2DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525A9B27D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5579DD6;
	Thu,  8 Feb 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pig0KT9B"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA776C61
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401544; cv=none; b=oasaXc8CTX0aFLgPIpCFzp/eSFdcSwkakF2DiFiq3MvyPACOVzpj5HqOVlVxwJq5LiCSMG1DvIM/TV8/NsU8+UO91aj7EZUFGfNDjZoA6PEnz7w7LdcaZUOksQpxj9dzKBkl14eL1fUe9H48uxkuITEZBn1BMvOug3YQzDqnANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401544; c=relaxed/simple;
	bh=3ik1VeqZqvrBk+hkQ4LISwGyPWvT053eJy+F7I6/4gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY7KEjwfyzyoYSLXoIYMEyWFAr8Rw8fPCrSsF/FUZsk+JS6n7MMucO00PDP9hMOoio9bAkISmG8d2pUoj2c4swC6fRZ2Yh0dCWNTsaS0gX0AgJIlrXqG3RVCL+CRjN/G++PJFIvlNEP+g2M7wMnBF8MZB/ehhlj+Hy6tvGNmlU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=pig0KT9B; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id Y4j8rHcFh9gG6Y58OrqrUk; Thu, 08 Feb 2024 14:12:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Y58Nr494NL5RlY58Nra9vh; Thu, 08 Feb 2024 14:12:12 +0000
X-Authority-Analysis: v=2.4 cv=NfZF1HD4 c=1 sm=1 tr=0 ts=65c4e13c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=avmgtr1mAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=9s2EZlhbFvVYUlpcnmcA:9 a=QEXdDO2ut3YA:10
 a=8jQmqnmTF30O56MVTtdJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NdzT1jnddPo3C2ofpdSb1STcn6/8gN+XK0UoGk/aM80=; b=pig0KT9BGEQTUgiqFgvo34xd5R
	92e52VRIZKp8OxiD9dXKPNQyP1uBFPWMorhd9dNeZDgQb+Q8bvvwjmm+DZUywpzQFlkPKFaDB1vfY
	frmH3A4pz5IDFDDDHuum4RjmBoeiOoC2FqCkLNj5zULzptXcZuOVNxbMuBgWwpAOxH6Ew2cqKNfSU
	t31rJYBL0q2FdSvmJMab8qCaLAKFGbe9iRfJa1uT72N9FrMmTStNIrFa1CsufQVZN+JSoSwWoPnqH
	/Im9Rc+aVHhmF+Fzlxr3TVGaNQuTMTqpBL4i1+CIG5MVoPuRLnDfN9nDC8aEs1Ua9KiJJ8vafRPUD
	y44VAjvA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48510 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rY58M-003UCd-2o;
	Thu, 08 Feb 2024 08:12:10 -0600
Message-ID: <98572347-e83b-41bf-aad0-08ed8e967431@embeddedor.com>
Date: Thu, 8 Feb 2024 08:12:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sun3_82586: Avoid reading past buffer in debug output
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Sam Creasey <sammy@sammy.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240206161651.work.876-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240206161651.work.876-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rY58M-003UCd-2o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48510
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK50ypFJih4BNgOwzNJq3q+ZfM45rNU0pRjJy6P9sLhC4MfEpIcQCpMYNndAA3ynBEpXwJGpNK7ytyrcWqfNCRg5W3SFFeK7P/R5ECif6jxrdYlxh4TT
 P8xdw6eLeRCJWVaeIpDHdBJRfbg08OvZgyksovrd3brdojx/Guod8TU0XoFNS1PiO8s7TjKWf0Lto86zm60fvJWBcNRKKzug6JyyfKE/aoXiFkasmyzo8CUc



On 2/6/24 10:16, Kees Cook wrote:
> Since NUM_XMIT_BUFFS is always 1, building m68k with sun3_defconfig and
> -Warraybounds, this build warning is visible[1]:
> 
> drivers/net/ethernet/i825xx/sun3_82586.c: In function 'sun3_82586_timeout':
> drivers/net/ethernet/i825xx/sun3_82586.c:990:122: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds=]
>    990 |                 printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
>        |                                                                                                               ~~~~~~~~~~~~^~~
> ...
> drivers/net/ethernet/i825xx/sun3_82586.c:156:46: note: while referencing 'xmit_cmds'
>    156 |         volatile struct transmit_cmd_struct *xmit_cmds[NUM_XMIT_BUFFS];
> 
> Avoid accessing index 1 since it doesn't exist.
> 
> Link: https://github.com/KSPP/linux/issues/325 [1]
> Cc: Sam Creasey <sammy@sammy.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/net/ethernet/i825xx/sun3_82586.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
> index 5e27470c6b1e..f2d4669c81cf 100644
> --- a/drivers/net/ethernet/i825xx/sun3_82586.c
> +++ b/drivers/net/ethernet/i825xx/sun3_82586.c
> @@ -987,7 +987,7 @@ static void sun3_82586_timeout(struct net_device *dev, unsigned int txqueue)
>   	{
>   #ifdef DEBUG
>   		printk("%s: xmitter timed out, try to restart! stat: %02x\n",dev->name,p->scb->cus);
> -		printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
> +		printk("%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
>   		printk("%s: check, whether you set the right interrupt number!\n",dev->name);
>   #endif
>   		sun3_82586_close(dev);

