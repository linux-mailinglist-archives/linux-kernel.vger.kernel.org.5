Return-Path: <linux-kernel+bounces-126257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E87893456
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B791F22EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22715B96D;
	Sun, 31 Mar 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=straussaudio.ch header.i=@straussaudio.ch header.b="Z1vD5MMy"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072D15B158;
	Sun, 31 Mar 2024 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903340; cv=fail; b=OCPPtiFB7LLxxH/drKeUk8XEJ0TqsIUx+zCx1dJ7zkTupehl4dBQSColxmZuAOPT0QB/GbrxXmMd3Hqs2mG6X10kKIPMwys50AI/hV1LV247iVPgBHyxJFkagpV2rfppq0mqHgQT96uG86RRKBRB29IpKOn8qHwCpv51bkkBR4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903340; c=relaxed/simple;
	bh=K3HwuTCmEML9ugbKbeDRULaXCAh7q1GMscITS+ffC20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W/BdT5ie1lsUMAu9ClETR7qV7NIczWa9PFrGlR+YTk6EqyYlVKyY0462YZnex+/jdhFgN4KmyTJrpbYeWpVRQuV2m4a3f1AOmloCNDdFGjxlmtrUGuqcCLDICXPWX6BUeDwN/ypBN9GWHyZbDBRViYhEOu6bqhot3iA4exFuf3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=straussaudio.ch; spf=none smtp.mailfrom=straussaudio.ch; dkim=fail (1024-bit key) header.d=straussaudio.ch header.i=@straussaudio.ch header.b=Z1vD5MMy reason="signature verification failed"; arc=none smtp.client-ip=62.220.136.28; dmarc=none (p=none dis=none) header.from=straussaudio.ch; spf=none smtp.mailfrom=straussaudio.ch; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=straussaudio.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=straussaudio.ch
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4354D20184;
	Sun, 31 Mar 2024 18:42:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNSA9-uH-8WH; Sun, 31 Mar 2024 18:42:14 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 64717208AC;
	Sun, 31 Mar 2024 18:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 64717208AC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 5639280005E;
	Sun, 31 Mar 2024 18:42:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:24 +0000
X-sender: <linux-kernel+bounces-125892-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAa2QFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKADEAAADkigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 40771
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125892-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9A8EB2076B
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.220.136.28
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833830; cv=none; b=GiU3ktMB6PWZcJPaCIwdiiWJUjmLjtqnKNMBQp4pKQFPgLOu9j4SbSriPoY5LYBUNnXgC8WymIBGOEc+r9Z7fmZ7Xb7Yr2a+k+nM7NgazihJpGhBUAr3CmEnujjeunkA7NLn/MotnYYX3+2wQb+4+ahmaLDOkeImjO1shW7mVYw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833830; c=relaxed/simple;
	bh=TKX6BDlvD87m60rs/fg2nUfkJGCHXIbGMOds6yUU79I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nm0KXaPcV0PiUWFn5jTQCwZklC1s0nLXzoYIh8axrwv8B9yxxQv8+GlyO/UtfzPe9CyVh5TsSkpguFgLs4ySxQoMkuQShZs0fb2sRIcXjMpl/h19Tz8XUZP7/KZnPOejozJOaQrFPnAJ6h0o5I4LmW8xn8XUXDFEyLIa4iSAAvs=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=straussaudio.ch; spf=none smtp.mailfrom=straussaudio.ch; dkim=pass (1024-bit key) header.d=straussaudio.ch header.i=@straussaudio.ch header.b=Z1vD5MMy; arc=none smtp.client-ip=62.220.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=straussaudio.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=straussaudio.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=straussaudio.ch;
	s=dkim; t=1711833817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsTBrugEHDoEfulCNu3sX1eAMIFqf5ekTaoZTxrm1xc=;
	b=Z1vD5MMyrRK+WOTNx4kMAP7bRvJY62dsmdIxgpTy3aY55ftVWngUgTlfH1IrvX/XvY+EHT
	JZipSam1TqgBf7ek9Cc7rihNyQAxgFdCJIAeRbqgruBqZZbYb8oyHc/7/TA4s6PildZVHt
	YbZCTs46Afb7KjvU2uvKD+oPuJGTtrc=
Message-ID: <552f5b91-d9ed-49cf-aaee-2cf5fe9fbbe8@straussaudio.ch>
Date: Sat, 30 Mar 2024 22:23:36 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth broken for some people with 6.8.2 [Was: [PATCH 6.8
 308/715] Bluetooth: hci_core: Cancel request on command timeout]
From: Philippe Strauss <philippe@straussaudio.ch>
To: Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-309-sashal@kernel.org>
 <bf267566-c18c-4ad9-9263-8642ecfdef1f@leemhuis.info>
 <2024033018-speller-supremacy-5436@gregkh>
 <f52daf9a-f934-4756-8a94-e7e383fbcb85@straussaudio.ch>
Content-Language: en-US
In-Reply-To: <f52daf9a-f934-4756-8a94-e7e383fbcb85@straussaudio.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Oh it's in the debugging code, my problem, I've reconfigured my kernel=20
without debugging in iwlwifi and btusb/btintel and can now use 6.8.2 as=20
my laptop kernel.

On 3/30/24 6:22 PM, Philippe Strauss wrote:
> I'm a good linux sysadmin with basics C abilities and no prior kernel=20
> dev experience having subscribed to the lkml yesterday to report two=20
> oopses which may be related:
>
> --=20
>
> 6.8.2
>
> Mar 30 17:27:26 PulseG2 NetworkManager[963]: <info> [1711816046.7303]=20
> device (wlp3s0): state change: unmanaged -> unavailable (reason=20
> 'managed', sys-iface-state: 'external')
> Mar 30 17:27:26 PulseG2 kernel: Bluetooth: hci0: command 0xfc05 tx=20
> timeout
> Mar 30 17:27:26 PulseG2 kernel: Bluetooth: hci0: Reading Intel version=20
> command failed (-110)
> Mar 30 17:27:27 PulseG2 kernel: iwlwifi 0000:03:00.0: Registered PHC=20
> clock: iwlwifi-PTP, with index: 0
> Mar 30 17:27:27 PulseG2 kernel: BUG: kernel NULL pointer dereference,=20
> address: 0000000000000027
> Mar 30 17:27:27 PulseG2 kernel: #PF: supervisor read access in kernel=20
> mode
> Mar 30 17:27:27 PulseG2 kernel: #PF: error_code(0x0000) - not-present=20
> page
> Mar 30 17:27:27 PulseG2 kernel: PGD 0 P4D 0
> Mar 30 17:27:27 PulseG2 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> Mar 30 17:27:27 PulseG2 kernel: CPU: 15 PID: 963 Comm: NetworkManager=20
> Not tainted 6.8.2 #1
> Mar 30 17:27:27 PulseG2 kernel: Hardware name: TUXEDO TUXEDO Pulse 15=20
> Gen2/PF5LUXG, BIOS N.1.06A12 03/15/2023
> Mar 30 17:27:27 PulseG2 kernel: RIP:=20
> 0010:iwl_mvm_vif_dbgfs_add_link+0x88/0xd0 [iwlmvm]
> Mar 30 17:27:27 PulseG2 kernel: Code: f3 48 ab 4d 85 f6 74 35 48 89 f3=20
> 4c 89 f1 48 c7 c2 26 34 31 c2 4c 89 ef be 64 00 00 00 e8 70 83 1d ef=20
> 49 8b b4 24 c8 1c 00 00 <49> 8b 7e 28 4c 89 ea e8 fc 61 8c ee 48 89 83 >
> Mar 30 17:27:27 PulseG2 kernel: RSP: 0018:ffffad53c7557510 EFLAGS:=20
> 00010246
> Mar 30 17:27:27 PulseG2 kernel: RAX: 0000000000000018 RBX:=20
> ffff930126395b98 RCX: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: RDX: 0000000000000000 RSI:=20
> ffffffffffffffff RDI: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: RBP: ffffad53c75575a0 R08:=20
> 0000000000000000 R09: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: R10: 0000000000000000 R11:=20
> 0000000000000000 R12: ffff92feb9291fc8
> Mar 30 17:27:27 PulseG2 kernel: R13: ffffad53c7557514 R14:=20
> ffffffffffffffff R15: ffff930126395b98
> Mar 30 17:27:27 PulseG2 kernel: FS:=C2=A0 00007d4436d44500(0000)=20
> GS:ffff9301ee980000(0000) knlGS:0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
> 0000000080050033
> Mar 30 17:27:27 PulseG2 kernel: CR2: 0000000000000027 CR3:=20
> 0000000105df2000 CR4: 0000000000350ef0
> Mar 30 17:27:27 PulseG2 kernel: Call Trace:
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 <TASK>
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? show_regs+0x71/0x90
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? __die+0x28/0x80
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? page_fault_oops+0x176/0x500
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? dentry_name+0x180/0x370
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? iwl_trans_txq_send_hcmd+0x389/0x4=
60=20
> [iwlwifi]
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? do_user_addr_fault+0x2f2/0x6c0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? exc_page_fault+0x87/0x1b0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? asm_exc_page_fault+0x2b/0x30
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ?=20
> iwl_mvm_vif_dbgfs_add_link+0x88/0xd0 [iwlmvm]
> Mar 30 17:27:27 PulseG2 kernel:=20
> iwl_mvm_mld_mac_add_interface+0x2f1/0x3b0 [iwlmvm]
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 drv_add_interface+0x58/0x280 [mac80=
211]
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ieee80211_do_open+0x515/0x7d0 [mac8=
0211]
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ieee80211_open+0x6d/0xa0 [mac80211]
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 __dev_open+0xfa/0x1b0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 __dev_change_flags+0x1ec/0x270
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 dev_change_flags+0x2b/0x80
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 do_setlink+0x3a8/0x12c0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? __nla_validate_parse+0x5b/0xe40
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? get_partial_node.part.0+0x19d/0x2=
e0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 __rtnl_newlink+0x717/0xb60
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? rtnl_newlink+0x62/0xb0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 rtnl_newlink+0x7b/0xb0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 rtnetlink_rcv_msg+0x174/0x430
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? kmem_cache_alloc_lru+0x372/0x420
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? __alloc_skb+0x178/0x1c0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? __alloc_skb+0x178/0x1c0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 netlink_rcv_skb+0x61/0x110
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 rtnetlink_rcv+0x19/0x30
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 netlink_unicast+0x248/0x380
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 netlink_sendmsg+0x218/0x470
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 __sock_sendmsg+0xae/0xb0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ____sys_sendmsg+0x25f/0x300
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? copy_msghdr_from_user+0x80/0xd0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ___sys_sendmsg+0x96/0xe0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 __sys_sendmsg+0x81/0xe0
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 __x64_sys_sendmsg+0x21/0x30
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 do_syscall_64+0x7b/0x140
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? do_syscall_64+0x87/0x140
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x5f
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 ? do_syscall_64+0x87/0x140
> Mar 30 17:27:27 PulseG2 kernel: entry_SYSCALL_64_after_hwframe+0x6e/0x76
> Mar 30 17:27:27 PulseG2 kernel: RIP: 0033:0x7d4437a9fb9d
> Mar 30 17:27:27 PulseG2 kernel: Code: 28 89 54 24 1c 48 89 74 24 10 89=20
> 7c 24 08 e8 4a 9f f7 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24=20
> 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 >
> Mar 30 17:27:27 PulseG2 kernel: RSP: 002b:00007ffcc6e0d7a0 EFLAGS:=20
> 00000293 ORIG_RAX: 000000000000002e
> Mar 30 17:27:27 PulseG2 kernel: RAX: ffffffffffffffda RBX:=20
> 0000634f86cfcca0 RCX: 00007d4437a9fb9d
> Mar 30 17:27:27 PulseG2 kernel: RDX: 0000000000000000 RSI:=20
> 00007ffcc6e0d7f0 RDI: 000000000000000d
> Mar 30 17:27:27 PulseG2 kernel: RBP: 00007ffcc6e0d7f0 R08:=20
> 0000000000000000 R09: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: R10: 0000000000000000 R11:=20
> 0000000000000293 R12: 000000000000000e
> Mar 30 17:27:27 PulseG2 kernel: R13: 0000634f86d69590 R14:=20
> 0000000000000000 R15: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 </TASK>
> Mar 30 17:27:27 PulseG2 kernel: Modules linked in: qrtr bnep=20
> intel_rapl_msr intel_rapl_common joydev nls_iso8859_1 edac_mce_amd=20
> nls_cp437 iwlmvm snd_hda_codec_realtek vfat snd_hda_codec_generic fat=20
> snd_hda_codec>
> Mar 30 17:27:27 PulseG2 kernel:=C2=A0 i2c_piix4 realtek drm wmi aesni_int=
el=20
> crypto_simd cryptd
> Mar 30 17:27:27 PulseG2 kernel: CR2: 0000000000000027
> Mar 30 17:27:27 PulseG2 kernel: ---[ end trace 0000000000000000 ]---
> Mar 30 17:27:27 PulseG2 kernel: RIP:=20
> 0010:iwl_mvm_vif_dbgfs_add_link+0x88/0xd0 [iwlmvm]
> Mar 30 17:27:27 PulseG2 kernel: Code: f3 48 ab 4d 85 f6 74 35 48 89 f3=20
> 4c 89 f1 48 c7 c2 26 34 31 c2 4c 89 ef be 64 00 00 00 e8 70 83 1d ef=20
> 49 8b b4 24 c8 1c 00 00 <49> 8b 7e 28 4c 89 ea e8 fc 61 8c ee 48 89 83 >
> Mar 30 17:27:27 PulseG2 kernel: RSP: 0018:ffffad53c7557510 EFLAGS:=20
> 00010246
> Mar 30 17:27:27 PulseG2 kernel: RAX: 0000000000000018 RBX:=20
> ffff930126395b98 RCX: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: RDX: 0000000000000000 RSI:=20
> ffffffffffffffff RDI: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: RBP: ffffad53c75575a0 R08:=20
> 0000000000000000 R09: 0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: R10: 0000000000000000 R11:=20
> 0000000000000000 R12: ffff92feb9291fc8
> Mar 30 17:27:27 PulseG2 kernel: R13: ffffad53c7557514 R14:=20
> ffffffffffffffff R15: ffff930126395b98
> Mar 30 17:27:27 PulseG2 kernel: FS:=C2=A0 00007d4436d44500(0000)=20
> GS:ffff9301ee980000(0000) knlGS:0000000000000000
> Mar 30 17:27:27 PulseG2 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
> 0000000080050033
> Mar 30 17:27:27 PulseG2 kernel: CR2: 0000000000000027 CR3:=20
> 0000000105df2000 CR4: 0000000000350ef0
> Mar 30 17:27:27 PulseG2 kernel: note: NetworkManager[963] exited with=20
> irqs disabled
>
> --=20
>
> 6.6.22
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bluetooth: hci0: Found device=20
> firmware: intel/ibt-20-1-3.sfi
> ..
> Mar 29 17:04:59 PulseG2 kernel: Bluetooth: hci0: FW download error=20
> recovery failed (-19)
> Mar 29 17:04:59 PulseG2 kernel: Bluetooth: hci0: sending frame failed=20
> (-19)
> Mar 29 17:04:59 PulseG2 kernel: BUG: kernel NULL pointer dereference,=20
> address: 0000000000000068
> Mar 29 17:04:59 PulseG2 kernel: #PF: supervisor read access in kernel=20
> mode
> Mar 29 17:04:59 PulseG2 kernel: #PF: error_code(0x0000) - not-present=20
> page
> Mar 29 17:04:59 PulseG2 kernel: PGD 0 P4D 0
> Mar 29 17:04:59 PulseG2 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> Mar 29 17:04:59 PulseG2 kernel: CPU: 0 PID: 160 Comm: kworker/u35:0=20
> Not tainted 6.6.23 #5
> Mar 29 17:04:59 PulseG2 kernel: Hardware name: TUXEDO TUXEDO Pulse 15=20
> Gen2/PF5LUXG, BIOS N.1.06A12 03/15/2023
> Mar 29 17:04:59 PulseG2 kernel: Workqueue: hci0 hci_power_on [bluetooth]
> Mar 29 17:04:59 PulseG2 kernel: RIP:=20
> 0010:btintel_read_debug_features+0x4f/0x100 [btintel]
> Mar 29 17:04:59 PulseG2 kernel: Code: 00 00 53 48 83 ec 10 65 48 8b 04=20
> 25 28 00 00 00 48 89 45 e0 31 c0 c6 45 df 01 e8 8c cb b4 ff 48 89 c3=20
> 48 3d 00 f0 ff ff 77 56 <83> 78 68 13 75 73 48 8b 80 c0 00 00 00 be 02 >
> Mar 29 17:04:59 PulseG2 kernel: RSP: 0018:ffffc900016a7c78 EFLAGS:=20
> 00010207
> Mar 29 17:04:59 PulseG2 kernel: RAX: 0000000000000000 RBX:=20
> 0000000000000000 RCX: 0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: RDX: 0000000000000000 RSI:=20
> 0000000000000000 RDI: 0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: RBP: ffffc900016a7ca0 R08:=20
> 0000000000000000 R09: 0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: R10: 0000000000000000 R11:=20
> 0000000000000000 R12: ffffc900016a7cb0
> Mar 29 17:04:59 PulseG2 kernel: R13: ffff88820e73c000 R14:=20
> ffff888122cf8400 R15: ffff88820e73c6d0
> Mar 29 17:04:59 PulseG2 kernel: FS:=C2=A0 0000000000000000(0000)=20
> GS:ffff8887ee200000(0000) knlGS:0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
> 0000000080050033
> Mar 29 17:04:59 PulseG2 kernel: CR2: 0000000000000068 CR3:=20
> 0000000780c24000 CR4: 0000000000350ef0
> Mar 29 17:04:59 PulseG2 kernel: Call Trace:
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 <TASK>
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? show_regs+0x71/0x90
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? __die+0x28/0x80
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? page_fault_oops+0x176/0x500
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? do_user_addr_fault+0x2fb/0x6a0
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? exc_page_fault+0x87/0x1b0
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? asm_exc_page_fault+0x2b/0x30
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ?=20
> btintel_read_debug_features+0x4f/0x100 [btintel]
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ?=20
> btintel_read_debug_features+0x44/0x100 [btintel]
> Mar 29 17:04:59 PulseG2 kernel:=20
> btintel_register_devcoredump_support.isra.0+0x3e/0xd0 [btintel]
> Mar 29 17:04:59 PulseG2 kernel: btintel_setup_combined+0x2b3/0x780=20
> [btintel]
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 hci_dev_open_sync+0x10b/0xcb0=20
> [bluetooth]
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? srso_return_thunk+0x5/0x10
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? try_to_wake_up+0x2e2/0x6f0
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 hci_dev_do_open+0x28/0x70 [bluetoot=
h]
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 hci_power_on+0x54/0x220 [bluetooth]
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 process_one_work+0x182/0x370
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 worker_thread+0x299/0x3e0
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? __pfx_worker_thread+0x10/0x10
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 kthread+0xf6/0x130
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? __pfx_kthread+0x10/0x10
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ret_from_fork+0x4b/0x70
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ? __pfx_kthread+0x10/0x10
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 ret_from_fork_asm+0x1b/0x30
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 </TASK>
> Mar 29 17:04:59 PulseG2 kernel: Modules linked in:=20
> snd_hda_codec_generic uvcvideo(+) amd64_edac(-) nls_iso8859_1=20
> edac_mce_amd ledtrig_audio btusb uvc snd_hda_codec_hdmi mac80211=20
> nls_cp437 videobuf2_vmalloc btrtl>
> Mar 29 17:04:59 PulseG2 kernel:=C2=A0 drm wmi
> Mar 29 17:04:59 PulseG2 kernel: CR2: 0000000000000068
> Mar 29 17:04:59 PulseG2 kernel: ---[ end trace 0000000000000000 ]---
> Mar 29 17:04:59 PulseG2 kernel: RIP:=20
> 0010:btintel_read_debug_features+0x4f/0x100 [btintel]
> Mar 29 17:04:59 PulseG2 kernel: Code: 00 00 53 48 83 ec 10 65 48 8b 04=20
> 25 28 00 00 00 48 89 45 e0 31 c0 c6 45 df 01 e8 8c cb b4 ff 48 89 c3=20
> 48 3d 00 f0 ff ff 77 56 <83> 78 68 13 75 73 48 8b 80 c0 00 00 00 be 02 >
> Mar 29 17:04:59 PulseG2 kernel: RSP: 0018:ffffc900016a7c78 EFLAGS:=20
> 00010207
> Mar 29 17:04:59 PulseG2 kernel: RAX: 0000000000000000 RBX:=20
> 0000000000000000 RCX: 0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: RDX: 0000000000000000 RSI:=20
> 0000000000000000 RDI: 0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: RBP: ffffc900016a7ca0 R08:=20
> 0000000000000000 R09: 0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: R10: 0000000000000000 R11:=20
> 0000000000000000 R12: ffffc900016a7cb0
> Mar 29 17:04:59 PulseG2 kernel: R13: ffff88820e73c000 R14:=20
> ffff888122cf8400 R15: ffff88820e73c6d0
> Mar 29 17:04:59 PulseG2 kernel: FS:=C2=A0 0000000000000000(0000)=20
> GS:ffff8887ee200000(0000) knlGS:0000000000000000
> Mar 29 17:04:59 PulseG2 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
> 0000000080050033
> Mar 29 17:04:59 PulseG2 kernel: CR2: 0000000000000068 CR3:=20
> 0000000780c24000 CR4: 0000000000350ef0
> Mar 29 17:04:59 PulseG2 kernel: note: kworker/u35:0[160] exited with=20
> irqs disabled
> ..
> (reboot in between)
> Mar 29 21:17:26 PulseG2 kernel: Bluetooth: hci0: Reading Intel version=20
> command failed (-110)
> Mar 29 21:17:26 PulseG2 kernel: Bluetooth: hci0: command 0xfc05 tx=20
> timeout
>
> (.pylocal) catseye@PulseG2:~$ lspci
>
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne=20
> Root Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=20
> Dummy Host Bridge
> 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne=20
> PCIe GPP Bridge
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=20
> Dummy Host Bridge
> 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne=20
> PCIe GPP Bridge
> 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne=20
> PCIe GPP Bridge
> 00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne=20
> PCIe GPP Bridge
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=20
> Dummy Host Bridge
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal=20
> PCIe GPP Bridge to Bus
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller=20
> (rev 51)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge=20
> (rev 51)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 0
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 1
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 2
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 3
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 4
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 5
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 6
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
> 24: Function 7
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> 02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd=20
> NVMe SSD Controller 980 (DRAM-less)
> 03:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
> 05:00.0 VGA compatible controller: Advanced Micro Devices, Inc.=20
> [AMD/ATI] Lucienne (rev c1)
> 05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir=20
> Radeon High Definition Audio Controller
> 05:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]=20
> Family 17h (Models 10h-1fh) Platform Security Processor
> 05:00.3 USB controller: Advanced Micro Devices, Inc. [AMD]=20
> Renoir/Cezanne USB 3.1
> 05:00.4 USB controller: Advanced Micro Devices, Inc. [AMD]=20
> Renoir/Cezanne USB 3.1
> 05:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]=20
> ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
> 05:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family=20
> 17h/19h HD Audio Controller
> (.pylocal) catseye@PulseG2:~$ lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 002: ID 04f2:b71a Chicony Electronics Co., Ltd=20
> Integrated IR Camera
> Bus 001 Device 003: ID 05e3:0608 Genesys Logic, Inc. Hub
> Bus 001 Device 004: ID 046d:c077 Logitech, Inc. Mouse
> Bus 001 Device 005: ID 8087:0029 Intel Corp. AX200 Bluetooth
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>
> Not a single oops up to 6.6.20 (included), haven't tried 6.6.21, and=20
> started with 6.6.22, while 6.6.23 seems stable for now, 6.7.11 also=20
> trigger oops around BT.
>
> The configuration is my own, derived from debian, but heavily modified=20
> (trimmed down) and hardened using KSPP recommendations.
>
> I have spare time, let me know if I can be of any testing help.
>
> Regards.
>
> Philippe, Lausanne, switzerland.
>
>
> On 3/30/24 5:23 PM, Greg KH wrote:
>> On Sat, Mar 30, 2024 at 03:59:22PM +0100, Linux regression tracking=20
>> (Thorsten Leemhuis) wrote:
>>> On 24.03.24 23:28, Sasha Levin wrote:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> [ Upstream commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8 ]
>>>>
>>>> If command has timed out call __hci_cmd_sync_cancel to notify the
>>>> hci_req since it will inevitably cause a timeout.
>>>>
>>>> This also rework the code around __hci_cmd_sync_cancel since it was
>>>> wrongly assuming it needs to cancel timer as well, but sometimes the
>>>> timers have not been started or in fact they already had timed out in
>>>> which case they don't need to be cancel yet again.
>>>>
>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>> Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting=20
>>>> request callback")
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> Hey stable team, I wonder if it might be wise to pick up 1c3366abdbe884
>>> ("Bluetooth: hci_sync: Fix not checking error on
>>> hci_cmd_sync_cancel_sync") from next
>>> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co=
mmit/?id=3D1c3366abdbe884)=20
>>>
>>> for the next releases of all series that a few days ago received
>>> 63298d6e752fc0 ("Bluetooth: hci_core: Cancel request on command=20
>>> timeout").
>>>
>>> The latter patch sadly on quite a few systems causes a Oops due to a
>>> NULL pointer dereference and breaks Bluetooth. This was reported for
>>> mainline here (yes, coincidentally it was reported by yours truly):
>>> https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhu=
is.info/=20
>>>
>>>
>>> Now that the patch landed in 6.8.2 it seems to happen there as well
>>> (guess in 6.7 and others, too), as can be seen from this bug report
>>> where multiple people already joined:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D218651
>>>
>>> The fix mentioned above is on the way to Linus, but due to unlucky
>>> timing missed this weeks network pull, hence will likely only reach
>>> mainline next Thursday. But the fix afaics has a stable commit id, so
>>> might be worth picking up soon for the stable releases to fix the
>>> regression quickly.
>> Now queued up, thanks for letting us know.
>>
>> greg k-h
>>
>


