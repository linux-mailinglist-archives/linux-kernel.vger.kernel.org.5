Return-Path: <linux-kernel+bounces-3328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C2816B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DC7B20C80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241815497;
	Mon, 18 Dec 2023 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VchwbyIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5rlpHeeR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132414F7E;
	Mon, 18 Dec 2023 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 37A185C0059;
	Mon, 18 Dec 2023 05:26:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 05:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702895217; x=1702981617; bh=y+588vbJz/
	1rdmr2IwKe5cF2pGAKNDklWn4J6v5J2i8=; b=VchwbyINCvvDfDO4j+trtljVQU
	xrW6ZB04zg1bGCYm3XrpWvouNUPGgCzIbDBYjKezq3d343Oqia/2CRjz5qeS55Gk
	Fe4meGSz+zR7qQJw5npIINwRKID6muJo15I+v7zuYTumBLZ3g+GCeBms2Ts8aWUd
	5ueBFVeqX9SHQzZCFP5dlpDciYUEuHg76uPyo7KUWNKcvzU0OSugciGycENaFH4b
	ST6kIzpF6VGW8M5aA2blJD6J1ppbJBP7FfZ/MUY7INmCwtxAigKHpv/Ko5hAhYKg
	tGuAiPeg524YyjCB+7uqptt+at6HSG6TV6PLk3rvPBg/E4XOTSLvBZqfT8lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702895217; x=1702981617; bh=y+588vbJz/1rdmr2IwKe5cF2pGAK
	NDklWn4J6v5J2i8=; b=5rlpHeeR9+TvVoCBBym1rPuiPf7RgbQCjZYjvljSyDzD
	U8bIxLQteSoQWg+z1OJK2CYS6pisg23ld1ig+RMYnJYurJway7HlyR501avneDBy
	uf3YfAQ1throdDUlG6GKYvLooxGR8eSP10kjUW1WtPc+bZTZ8lP6sT8dxzJZQ84f
	EbzKy9RM9vszSN4sjqZFWFBeu92bOQwvZoJBS61JfCf2b/6Zw42CPzGpXPb4JBT5
	JbYi163udwyU5bF2n/mypQ87A9hBdd0g3BV3NiEaoqkIDSD2StmlPKuuQzCQKsfQ
	ZJ753oZbHZ2Pz+ZW3RU71Vmi3TWxyWZgPRnRwRXOKA==
X-ME-Sender: <xms:cR6AZZItlRMW66xc_Sfr0XIRxRQTMreXCQza5tIVTHfAUh35BZ3b5w>
    <xme:cR6AZVKvA0Qg9W5t5cN7v2iQ6ta_jMvlAQHViKhrNckwaqIqrK7WoP6_pMbP1BZLL
    BOBt7pBux5dXQ>
X-ME-Received: <xmr:cR6AZRuqDfj1jH0q3xL49nE446DQB-GNcftar-V7i_B28e2OlGsv_Eu3WUV9L3HSr1lZOFyNGEA5W6ollpkQjBpp-tXvT_Ng6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:cR6AZaYbbWR0NsCNqSPJmy7Pb-u3tQcHYdiRNuZcYlpDnNisk32hPg>
    <xmx:cR6AZQaul3YDx_We2DwUFC9BUGfRqK-8wKJo_OkFRyo8fPqz_WpvKA>
    <xmx:cR6AZeAYXeevjuLUSE15Itke2WFzy7_Y8ppNZolGdEAYrAix_IiEdg>
    <xmx:cR6AZWNPt4KhbKW37igqj-6Yp8Mxmf_48PwkCx18X9av9EOSQYvzyQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 05:26:56 -0500 (EST)
Date: Mon, 18 Dec 2023 11:26:55 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the nvmem tree
Message-ID: <2023121838-factual-unvalued-3e01@gregkh>
References: <20231218161238.59ce255d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218161238.59ce255d@canb.auug.org.au>

On Mon, Dec 18, 2023 at 04:12:38PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   82c6ba6a7d96 ("nvmem: brcm_nvram: store a copy of NVRAM content")
>   a9d68bd9fc7a ("nvmem: stm32: add support for STM32MP25 BSEC to control OTP data")
>   5bc8339a8af8 ("dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem")
>   6deccfa25e3d ("dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp")
>   e15e05ed845a ("nvmem: core: Expose cells through sysfs")
>   38ebc72019b9 ("ABI: sysfs-nvmem-cells: Expose cells through sysfs")
>   fc334e722496 ("nvmem: core: Rework layouts to become regular devices")
>   d5827449f96c ("nvmem: Move and rename ->fixup_cell_info()")
>   52be3c1543c4 ("nvmem: Simplify the ->add_cells() hook")
>   26378491d343 ("nvmem: Create a header for internal sharing")
>   c016e72f9346 ("nvmem: Move of_nvmem_layout_get_container() in another header")
>   0e7ceb1551ee ("of: device: Export of_device_make_bus_id()")
> 
> These are commits
> 
>   1e37bf84afac ("nvmem: brcm_nvram: store a copy of NVRAM content")
>   f0ac5b230396 ("nvmem: stm32: add support for STM32MP25 BSEC to control OTP data")
>   a729c0f57dc8 ("dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem")
>   a2a8aefecbd0 ("dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp")
>   0331c611949f ("nvmem: core: Expose cells through sysfs")
>   192048e5a5b6 ("ABI: sysfs-nvmem-cells: Expose cells through sysfs")
>   fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
>   1172460e7167 ("nvmem: Move and rename ->fixup_cell_info()")
>   1b7c298a4ecb ("nvmem: Simplify the ->add_cells() hook")
>   ec9c08a1cb8d ("nvmem: Create a header for internal sharing")
>   4a1a40233b4a ("nvmem: Move of_nvmem_layout_get_container() in another header")
>   7f38b70042fc ("of: device: Export of_device_make_bus_id()")
> 
> in the char-misc tree.

That's because the nvmem maintainer sent these to me for inclusion, odd.

greg k-h

