Return-Path: <linux-kernel+bounces-18826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCA8263A2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D418528279A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6812B8B;
	Sun,  7 Jan 2024 09:56:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF712B78;
	Sun,  7 Jan 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rMPtH-0005kk-7T; Sun, 07 Jan 2024 10:56:23 +0100
Message-ID: <9e7cb70d-1eff-4240-841f-e08a91ca995c@leemhuis.info>
Date: Sun, 7 Jan 2024 10:56:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror
 detachment
Content-Language: en-US, de-DE
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20231218164532.411125-2-mailingradian@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20231218164532.411125-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704621385;e512b629;
X-HE-SMSGID: 1rMPtH-0005kk-7T

On 18.12.23 17:45, Richard Acayan wrote:
> In 6.7-rc1, there was a netif_device_detach call added to the
> gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> the netif device and suppresses pings (ICMP messages) and TCP connection
> requests from the connected host. If userspace temporarily disconnects
> the gadget, such as by temporarily removing configuration in the gadget
> configfs interface, network activity should continue to be processed
> when the gadget is re-connected. Mirror the netif_device_detach call
> with a netif_device_attach call in gether_connect to fix re-connecting
> gadgets.
> 
> Link: https://gitlab.com/postmarketOS/pmaports/-/tree/6002e51b7090aeeb42947e0ca7ec22278d7227d0/main/postmarketos-base-ui/rootfs-usr-lib-NetworkManager-dispatcher.d-50-tethering.sh
> Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced f49449fbc21e
#regzbot title usb: gadget: u_ether: network gadgets don't work
#regzbot fix: usb: gadget: u_ether: Re-attach netif device to mirror
detachment
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

