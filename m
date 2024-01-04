Return-Path: <linux-kernel+bounces-17119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA6824885
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444071F2566B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985928E30;
	Thu,  4 Jan 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="OR9Za0gO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294D28E1F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id LAzQrSS8voMN9LSzOrNBRo; Thu, 04 Jan 2024 19:02:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id LSzMrhMuVL3AmLSzNrptO8; Thu, 04 Jan 2024 19:02:45 +0000
X-Authority-Analysis: v=2.4 cv=Sdrky9du c=1 sm=1 tr=0 ts=659700d5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10
 a=dIpWgY-jgDhoewjHQY8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mt+6zgJaLgFfhWMgUm7nd0AlSM3f/JNvko4jdQ8TmAo=; b=OR9Za0gOccAKn03Q+MnOjskAXu
	y55SvEutcGLngjuhW1bkIhjhcvCkQE1Y4JUEgv3mIZykjswa6YY77AyqjcjLjkKh6i9rU7SWTKGn2
	jqkdZpn9NvGv1ju7mqsCvxOJ1F/F86QNmyqb8a0VOFCMnbLbU//RsvZk8EuWWb8S8PAd7zo0p8nAW
	6tqhRmmU4SUm7g1Z33L6kyL3+fu6aKuVTmjLnVj/ZPL4Q9n2JlTFRP6YofSW9N8+r1BvyjU3mlDWJ
	ZXWiKnzpK5+ftsU8S2+KpPW8MoAndm9nXF8UVsrgV/KLuZrLIkz1j6BoFkzYEt3QZKkSPWOaWGNKR
	mbuWrWOw==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:29876 helo=[192.168.0.3])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rLSzL-001fme-0B;
	Thu, 04 Jan 2024 13:02:43 -0600
Message-ID: <c9f029c5-713b-4500-85f1-a72dec5c3909@embeddedor.com>
Date: Thu, 4 Jan 2024 13:02:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] VMCI: Silence memcpy() run-time false positive
 warning
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
 gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
 <2024010103-connector-plausibly-bc35@gregkh>
 <c42282c1-238b-4e35-bdac-1eb8260fe351@oracle.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c42282c1-238b-4e35-bdac-1eb8260fe351@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rLSzL-001fme-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.3]) [187.184.157.186]:29876
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCOGwRhp4Xk8HCi0CMfxCcBkS1Cc9WiEqZigBAoreMpGYngwniVbEV/h4DSDk8ycg9PAmx5g9o1NFoJkroRtTvcGqf/Dd1g7rFgIJqbTbdq8GpmqPqpx
 /Av/EQPkgiurtKtfo7GJUar2I4UgkX84cDaZSpQEZ1Ai2fT2PQ7pPRqVU1l02fuMw/1AKKLphzEYkI0/n3BeY8o7VjSXycJAqhwljhNC77NJrpaOfcTCse+b



On 1/4/24 12:31, Vegard Nossum wrote:
> 
> On 01/01/2024 14:55, Greg Kroah-Hartman wrote:
>> On Mon, Jan 01, 2024 at 05:08:28AM -0800, Harshit Mogalapalli wrote:
>>> One possible way to silence the warning is to split the memcpy() into
>>> two parts -- one -- copying the msg and second taking care of payload.
>>
>> And what are the performance impacts of this?
> 
> I did a disasssembly diff for the version of the patch that uses
> dg->payload_size directly in the second memcpy and I get this as the
> only change:
> 
> @@ -419,11 +419,16 @@
>          mov    %rax,%rbx
>          test   %rax,%rax
>          je
> +       mov    0x0(%rbp),%rdx
>          mov    %r14,(%rax)
> -       mov    %r13,%rdx
> -       mov    %rbp,%rsi
> -       lea    0x30(%rax),%rdi
> +       lea    0x18(%rbp),%rsi
> +       lea    0x48(%rax),%rdi
>          movb   $0x1,0x28(%rax)
> +       mov    %rdx,0x30(%rax)
> +       mov    0x8(%rbp),%rdx
> +       mov    %rdx,0x38(%rax)
> +       mov    0x10(%rbp),%rdx
> +       mov    %rdx,0x40(%rax)
>          call
>          mov    0x0(%rip),%rsi        #
>          lea    0x8(%rbx),%rdx
> 
> Basically, I believe it's inlining the first constant-size memcpy and
> keeping the second one as a call.
> 
> Overall, the number of memory accesses should be the same.
> 
> The biggest impact that I can see is therefore the code size (which
> isn't much).

Yep, I don't think this is a problem.

I look forward to reviewing v2 of this patch.

Thanks
--
Gustavo

> 
> There is also a kmalloc() on the same code path that I assume would
> dwarf any performance impact from this patch -- but happy to be corrected.
> 
> 
> Vegard
> 

