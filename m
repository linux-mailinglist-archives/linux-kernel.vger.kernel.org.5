Return-Path: <linux-kernel+bounces-9720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF381CA31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE951C21645
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CD18636;
	Fri, 22 Dec 2023 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="El/Eu3P0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2PMZ1l7M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F1182BB;
	Fri, 22 Dec 2023 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id F166A3200A22;
	Fri, 22 Dec 2023 07:47:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Dec 2023 07:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703249225;
	 x=1703335625; bh=tIVbnmL5/XEhiKUG9sZN0NOkNUx7Xn+vtggbKdx4D0Y=; b=
	El/Eu3P0vz/aRPJ06xGvxbWtolatYWrNTpoOVBp/+9FFiJfLkWNRJ2OcVz0yL8yu
	hW1eTzQfat9oDV/SzM5Ks4W0TVp+l2Kadb57smJ1by07LkoGnX9vRThpi5aOJFld
	NXxn5jA5BRdBMeBKy1vgMak09GlE/3jIJ4h0P7C5xdJL8O4t5wpTSKqE7QCe6ZRp
	JciWMlI+8Lk2dcjvuenJaNAofbT5J67IpBvY9C5EaZ4isuGUmXvcsk+g/B9tASyc
	sfMjU0N4V0XwODSiJdlcx5JvrRh3A1clMBgkLv/lwfR7/nWCV6Nx+hlQXcMlljBr
	OH8a8q066sRYLPnlxaYFGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703249225; x=
	1703335625; bh=tIVbnmL5/XEhiKUG9sZN0NOkNUx7Xn+vtggbKdx4D0Y=; b=2
	PMZ1l7MuonvF1m8nyyIWYDeRVlP7Wc7j6pYgq3pvxwr/JvsMBPupss3U13sFYmI4
	kE0yc/jSwQuxu1qU6e3sE6igHZIVwmApKCUsKszT5A4Zv5hX1tRwHNJ6edsVE5KB
	GdpV7rg0JNtXqOQ4IC8wtuza7swcqhg2BylJbFaCzQ7T6W5XhYLBdoPailti0/c7
	crjjBAX3RL7Hn+fGSv07XTGMo3R8zCEVc/Xf1KzkD0wmsBmH722RXawswh6RCDml
	9h3EIN5+as1NBzrpQuObN/Z9L/ScAs/kpBq/+I4ceYK3LrulVdyFCjEyqJ5aXXri
	/r7WNE5NcnP6nLnxGK7cw==
X-ME-Sender: <xms:SYWFZeLoMZLVOsY-YImjZWFtfhLRIsXsrFtO6hsw5vmDKh06UsSz2g>
    <xme:SYWFZWJQyQpTWinbY8Snrq6WJtJrIYEnka2X8OfE0wDNxh-lrXF-PZGFl9UkSTsEe
    jfZpSH6LPr4XFSXofg>
X-ME-Received: <xmr:SYWFZeudp4OdrLEJXEENdm2FwQQJo8YhP-ELlXwpd_eOBro_UwM-kD-L1WVxISxSTdGGs-TT-HJW4VNNUPYa_OCokCfj13FK8kq6bkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:SYWFZTbLxklLbpt9pv-UB12Cb0BmTETT-5RL-Podmc1ICn1khG8hlQ>
    <xmx:SYWFZVbOQmpiHPyephu0bCTk2Ym7IKA3F_VcX7hBCspBvB-FSzuqtA>
    <xmx:SYWFZfC6AZDutSYTd2VbuqW7A7_RgWDQInCIlIkzWNcr-4jmgf-_gQ>
    <xmx:SYWFZZGOrJ1mn9VQ37tE-d5M0ZiD7yARnmwlxPqCJzoeEAP_GOD4kQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 07:47:04 -0500 (EST)
Message-ID: <936a4dd1-b595-49b4-ab19-f587a9adb000@flygoat.com>
Date: Fri, 22 Dec 2023 12:47:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] MIPS: traps: Handle CPU with non standard vint
 offset
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregory.clement@bootlin.com, vladimir.kondratiev@intel.com
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
 <20231027221106.405666-8-jiaxun.yang@flygoat.com>
 <ZYV+zdm4fjYgATVW@alpha.franken.de>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <ZYV+zdm4fjYgATVW@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/22 12:19, Thomas Bogendoerfer 写道:
> On Fri, Oct 27, 2023 at 11:11:03PM +0100, Jiaxun Yang wrote:
>> Some BMIPS cpus has none standard start offset for vector interrupts.
>>
>> Handle those CPUs in vector size calculation and handler setup process.
> hmm, I see no connection to what this series is fixing. How does it
> work without this patch ?

In this series reservation of exception vector is moved to here, so it's 
critical
to have correct size.

Thanks
- Jiaxun

>
> Thomas.
>


