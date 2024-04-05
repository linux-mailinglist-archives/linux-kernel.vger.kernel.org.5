Return-Path: <linux-kernel+bounces-133468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C45789A422
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAD41C223E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20F17278F;
	Fri,  5 Apr 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yYNUPDj/"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3E1EB36
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341299; cv=none; b=OfASRXgO7YstMfqdxy6VVdvHshpSibEnhrgbfYBrrNTZLqCwDZxA8N/7IccAabqeU5TELj5Ozmzu0r+3Y/A7hXlf+Ix1kAQxutYbJ/hF6SfHUKNNcj7piShGvDjYE65XFJEaKSIbyEMWBs4FVgSmNUY4GPzqkVZ5/nkAzvXE+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341299; c=relaxed/simple;
	bh=dGQ9L9Gqb7CW2OtaU8Wy3RHDhaPbUhgR+jApHhmerTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rodd31WxL1cYIBCyTKiPM114OhoFIgHMBX6DrCvkWsZKRaVq7SndqGDAUlgLRcZzTeqHT5AJgNNN3YtnOakGkbBQoDaEYo+2qhlPz/qI1BHsm3Pna7JW8owa0Ky0XNBUMWURFYO+RfO3e1w01siu6HZ7JOJtSZgzZJX6M7zOceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yYNUPDj/; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id smrhrTLL1s4yTsoC0rjGV1; Fri, 05 Apr 2024 18:21:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id soBzrtN37iKqRsoBzr0LgQ; Fri, 05 Apr 2024 18:21:35 +0000
X-Authority-Analysis: v=2.4 cv=I9quR8gg c=1 sm=1 tr=0 ts=66104130
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=r+LGvmNWHIxDfVLo7hoBkw==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=dZbOZ2KzAAAA:8 a=kNg_QPtJy2UKAXtLnxAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VIFZ+bWm8IsLbE/ymrmq2FfEB7EmgRKFm77/qFhUpCs=; b=yYNUPDj/Bu3kjYD9Nf7Fz79er4
	1xlAZ09tehwne4pXgnv5ErbsQv/UsMaDgmsVISMlQHhcslf73DiP7IL37i1V2knBGp+ZbJdtqOODx
	TliSpjI2q/o7AoeaZnMP1M96Nx3uarVEp2gHGEblwtdjXboEc/Y6n0t+2XnYCIkmcVgLeZAJTNcZS
	etIDo/hprsgvpw3ltr95SmJvphUNIYyKE71T/FG/272/07G2J79GG6OMfqTcVyR73OnqV1YDPTrzQ
	Dj5DhaVdXg1RWFcGvJjamxboUjuzmCbB+DgzperhuYd8yGFU98vROwcmKgwuMCvh1hLZXn4onr+WN
	MIhE8pwg==;
Received: from [187.184.159.58] (port=60722 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rsoBy-001e05-2b;
	Fri, 05 Apr 2024 13:21:35 -0500
Message-ID: <48fe7b01-8cc4-477b-8f74-a5d662a76bfb@embeddedor.com>
Date: Fri, 5 Apr 2024 12:21:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [hardening?] BUG: bad usercopy in do_handle_open
To: Andrew Morton <akpm@linux-foundation.org>,
 syzbot <syzbot+4372e026c95b0e36d0ee@syzkaller.appspotmail.com>
Cc: gustavoars@kernel.org, keescook@chromium.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 Aneesh Kumar <aneesh.kumar@kernel.org>
References: <000000000000b8974d06155cf3a2@google.com>
 <20240405110940.e787791b7d53aff7f216a168@linux-foundation.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240405110940.e787791b7d53aff7f216a168@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.58
X-Source-L: No
X-Exim-ID: 1rsoBy-001e05-2b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [187.184.159.58]:60722
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNC1Cx8fWR6YAKn6HsIL1ljRrekazv8xS+xrUTjr8XS8nu7b0YWDSKfJEHt24nsTjiHKB5Pq4vtXpZ2/xUeYIap07IOYJM9kzLqUJOsjWYTRNkNILQHy
 exlN9Nely7CS2C8ypp8Ln56iYn/4RfK2WaWwgvpx6MZbxy3OFTO7uZjHR7BgO+f4quMN68wzXHaIzNvQ8VPAO3nQ8YV/8Y1n8/WUlzu8d7omKbczFrJMbN6o


>> usercopy: Kernel memory overwrite attempt detected to SLUB object 'kmalloc-16' (offset 8, size 9)!
> 
> We tried to copy 9 bytes into the f_handle[] array.
> 
> But from my reading of the reproducer, f_handle.handle_bytes was set to 1.
> 
> Aneesh, any thoughts on this?

This was previously reported:

https://lore.kernel.org/linux-nfs/tencent_A7845DD769577306D813742365E976E3A205@qq.com/

and it's fixed in linux-next already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=02426828cde24cd5b6cf5f30467cea085118f657

--
Gustavo

