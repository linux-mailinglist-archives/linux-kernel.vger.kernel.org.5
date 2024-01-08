Return-Path: <linux-kernel+bounces-19161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542268268F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114F11F21E81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4F13FE0;
	Mon,  8 Jan 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OUm55Ua5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDTFuJxv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E813AC7;
	Mon,  8 Jan 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 20C183201115;
	Mon,  8 Jan 2024 02:54:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 02:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704700455; x=1704786855; bh=TkPBuXt9FM
	qTeLEzSpb8ZAo+9PQKDnWspnrgC8B7/NY=; b=OUm55Ua5ZmPzmKCOT3/+dyrwOI
	6RN4XXBU8sGvyTkRGa3iupMl0jmWfUJa0ARveU1kh/Z3/XAJ3jjACmekuj5+z3w7
	YFW0Lwf+rirbYS3d6Sr9BgboQ/VtXFxJWDY2eKNHrEbyhVLx8IpqVAvhByanzQ3d
	D2QCfxrIzmIZFJQXjSCq+LwqTDnkqklTl9VMLY7SaLswwSN8+Btl0hwatpnUlR/q
	Rwaky5h85hr0uf47rlwboKIBDrlwEKZuX1sVeUYFyNgBT7ymG6XDlFyMM207EjHG
	q+DZXbYrjHGTc2I0sYVQClu5FaAwG24usjNMUWpN+ZQ3vDSRqYewrcR0ZaSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704700455; x=1704786855; bh=TkPBuXt9FMqTeLEzSpb8ZAo+9PQK
	DnWspnrgC8B7/NY=; b=WDTFuJxviyZQbXdEbVFXvtsw7njHgQOA0hsz+qAgOEmf
	lhl1xqmaPDMTqe4tCnil22iUv0hWOSqkiAbySeANqHw0AWYYy6EivoiFhDsTdIU3
	QtLVeDIum3HFeEqNW9Q7CCtXsI15soDCZXQq85hhYO+MGieD2oX8BrDIQQvWJ/+r
	BWwkTfw2RrZNNZhDV5F24862ZpNnd+dXE/vF7mp4sZmt1/uXlOtrxtCFkpbAbNX1
	jgYgOgk8bB5ynF/l2gvmehtIJi6NSucN97N8l/FWBWw+tU+j4Zi/NVieEaCY3X2C
	TxnJoe5Q+xq/wIFQuBtssGP/ApC+93fgNTHLYbQT7Q==
X-ME-Sender: <xms:J6qbZX9csPmdyjODmCTt5qFRRZmzfkJDNiwTiUgVe_azXjXWBrE6Mw>
    <xme:J6qbZTuYO3LHhDMNYYlHveiSOVIGIMPMTRI4WwbOlpMySXIx3jfz1HJDsn4MMm-S9
    Eg7t0bRKqG-qw>
X-ME-Received: <xmr:J6qbZVAr6aU9wYpLiBr8D1fbPO1Y45USNVH423d78goOLfiZao7Cuyl3KFQXb5k27avlU0gx_Vo7_wFvHBobbFC0cLL3EBw0vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:J6qbZTe91LOCtyruswNuvBwSPWA0flDQO6P7trHzKbahGotVVaqxaw>
    <xmx:J6qbZcO-ixAsAGa1N5HkmdVjrnHwpzWywrqdcu4FkGWFGnwC59X6Fw>
    <xmx:J6qbZVkHjg-ELMrFhvuQV0vMiMrfvjPyWezVe4v012ctkrucgDWIrg>
    <xmx:J6qbZdGHu2tO8LOA1hEsBKkR921tfIwu3K2ny0-lKd_8hogPv3QsUw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 02:54:14 -0500 (EST)
Date: Mon, 8 Jan 2024 08:54:13 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Chrome Platform <chrome-platform@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the char-misc tree
Message-ID: <2024010805-stagnant-statute-ac41@gregkh>
References: <20240108140713.143f27e1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108140713.143f27e1@canb.auug.org.au>

On Mon, Jan 08, 2024 at 02:07:13PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the chrome-platform-firmware tree as a
> different commit (but the same patch):
> 
>   f69583d32fcb ("firmware: coreboot_table: Convert to platform remove callback returning void")
> 
> This is commit
> 
>   09aeaabebdaf ("firmware: coreboot: Convert to platform remove callback returning void")
> 
> in the chrome-platform-firmware tree.

Should be fine, thanks.

greg k-h

