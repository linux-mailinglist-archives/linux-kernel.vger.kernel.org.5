Return-Path: <linux-kernel+bounces-69726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8970858DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0581F22413
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AF200DD;
	Sat, 17 Feb 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cmfYTQpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+pTWRTA"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F31EB3B;
	Sat, 17 Feb 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155698; cv=none; b=lA+BkAfhhE/fTiFpqDgJKJ+18ANcxvV83UU6byCoRIXkN+Gv+ROzYgafEeChMRvrtvGxnEowqHE2Egv+lP2bmBuMY/4sk65avH4YeoFsEqf57peVRGxAePNclTcJ98UR+3eRyEaWEmOD9eBSjhMbVNV/NHU2GevBmRldmlVASEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155698; c=relaxed/simple;
	bh=nrCCv6T5C8KQMncw5eFYVShocADNiOxVr7vH8DHZlBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB3D4gfbUji++bUcmLkh3UUqFml1qK1CeH9y9k980Yow7EhUeLM1Gd1ngY5ykCmr/JmbEBkDosvAQhKWnGN0avnxoqTHvAephKSFTp/q1yTldi3ohVWNtAmPXlM2WyCa1TE1M0KemAovwgN8GtsO3pEjn3OeDcSkS+Ah7hGlx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cmfYTQpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+pTWRTA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5101311400BE;
	Sat, 17 Feb 2024 02:41:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 17 Feb 2024 02:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708155695; x=1708242095; bh=yzscl6eUgx
	QrEdqt6+ABAiAuOZEKasOQBugBShA9lzg=; b=cmfYTQpd6YNtQYlajIp2FpY5yg
	3AaWFGYRcCFjxZ/K76/pQNQJa+UOl+XXWDVNQzCIQiN189ijaYibMNKRMMcM/O4N
	dSKM8xsbgXD01NUVyoNxjvFd1KULM9iERF7nOoaAB3pbWcHJuAwKg4t+pIRrlw81
	NItTJguy3vggSKvAREKpIXthvTPvoeSeSIJ0eL+QEl36MrM0vgJtiocODN/AxEwF
	+bO/X2ia1moPp+rRBYymlhzVX0aZZqPnIrxSegniD+Oq+xh/r8oycLfL49bQGB5P
	l/QXhR9LWe+8izDGj4raIt98WI5j7FlXzDvNgESkUYKOGaVk3AWx0tCNxuDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708155695; x=1708242095; bh=yzscl6eUgxQrEdqt6+ABAiAuOZEK
	asOQBugBShA9lzg=; b=C+pTWRTA+ZQA9VWAmohX9ztshfInZ//vdyvFb79tpGaB
	BLVIqhvcz2N4sZpzvAHXiqpc7hA7Ho5+qIEE6K0mKdwSFKv+9EtQkTWaFtiJNGIO
	l8R4zGgjlqlFukR6xrI1QYSW8xSAyLIjJSk/B5M8Juo/jwKXrBPxD1kmuo0psLUE
	pNnCUOdy/yub3a2w0T/Z3/7WWkPWwq9SKw1n7qNd486jPbXYgl2TBMzEZuwBj8ni
	96b2c8C2HoEEHvb+NoeZGVSGlQp6H02n4aG1aycxLUMCoj7vuaoCIehqfu/qSYte
	EsKkK/Fc42mju38h69DlxUmGA/Sd5IAPxfpDt1bLLA==
X-ME-Sender: <xms:LmPQZYRytwuFRw0MMgx4gRgo0GYH5-VtZaDZ2DKbK7AUYbxNuPzL0w>
    <xme:LmPQZVx2pB8yZh4wXqs3Ncnl4gEI_odRSJIUTM-Sn7i8U9duxGIwn3S_U8Si0fx6e
    7cLev1AL-oz_A>
X-ME-Received: <xmr:LmPQZV1ljRcWBhScsK7SxvPpugG_Q1KZnvYnVogfq-Zv_rfdIYEGHZkE2F7ZXrwxbBnQgGAzoBJQPhrib3RhTICZb4Xnu08DCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:LmPQZcAi5WwbIXbP-G76PnVTK4H3WZXZFYHP3TWwW4ZP-wbu50jkBw>
    <xmx:LmPQZRgQDAAYNjvZKjMUX-MLtoG5ljwfYqtQvGKFFfR1UoqG6ddBXw>
    <xmx:LmPQZYoGnwLSModAQlNHAnwa7tP-XF_0gasXiqd6xiKYhjJYcVNfzw>
    <xmx:L2PQZUg6ji-Q6AMZHuR5VjshVMB2oLX1Ko97UHhqms49qgflMqdniQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Feb 2024 02:41:34 -0500 (EST)
Date: Sat, 17 Feb 2024 08:41:33 +0100
From: Greg KH <greg@kroah.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com, isely@pobox.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org, mchehab@kernel.org,
	pvrusb2-owner@isely.net, pvrusb2@isely.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH usb] media/pvrusb2: fix uaf in pvr2_context_set_notify
Message-ID: <2024021716-accent-islamist-6a87@gregkh>
References: <00000000000028b68806103b4266@google.com>
 <tencent_19D16EF24CA0E7F686C252C8C66D49A2AE06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_19D16EF24CA0E7F686C252C8C66D49A2AE06@qq.com>

On Fri, Feb 16, 2024 at 03:30:47PM +0800, Edward Adam Davis wrote:
> [Syzbot reported]
> BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
> Read of size 4 at addr ffff888113aeb0d8 by task kworker/1:1/26
> 
> CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.8.0-rc1-syzkaller-00046-gf1a27f081c1f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:488
>  kasan_report+0xda/0x110 mm/kasan/report.c:601
>  pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
>  pvr2_context_notify drivers/media/usb/pvrusb2/pvrusb2-context.c:95 [inline]
>  pvr2_context_disconnect+0x94/0xb0 drivers/media/usb/pvrusb2/pvrusb2-context.c:272
> 
> Freed by task 906:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
> kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
> poison_slab_object mm/kasan/common.c:241 [inline]
> __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
> kasan_slab_free include/linux/kasan.h:184 [inline]
> slab_free_hook mm/slub.c:2121 [inline]
> slab_free mm/slub.c:4299 [inline]
> kfree+0x105/0x340 mm/slub.c:4409
> pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
> pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
> 
> [Analyze]
> Task A set disconnect_flag = !0, which resulted in Task B's condition being met
> and releasing mp, leading to this issue.
> 
> [Fix]
> Place the disconnect_flag assignment operation after all code in pvr2_context_disconnect()
> to avoid this issue.
> 
> Reported-and-tested-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

What commit id does this fix?

And should it be cc: stable as well?

thanks,

greg k-h

