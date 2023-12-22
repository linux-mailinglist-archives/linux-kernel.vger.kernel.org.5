Return-Path: <linux-kernel+bounces-9431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD8681C568
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A911F24095
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7B944D;
	Fri, 22 Dec 2023 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="k2PgjN3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIW7i2q0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670C8F6E;
	Fri, 22 Dec 2023 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 4CCB35C0277;
	Fri, 22 Dec 2023 02:06:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Dec 2023 02:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703228817; x=1703315217; bh=BoUi0Lx1gZ
	P9nFMwdw0C6puWbb+B9pctDK1EXIQql98=; b=k2PgjN3G55LwNDgK9tBqE8is8f
	CHlxQLXVbwCYod8cNkJMa370Y1aYl85MbVkhF6lhvzq7lkJSaQ70QaP+Rk024B25
	14GbtUbpXXbz/27jKhcoxAK12Xm7LO12Yp/BZaFypa5PSmElPJRRVGqoMb9pavD1
	sAdwBF+AH0O5zNT7rtNj+/aQxwlxYY89Gw+s1k9bpUgiJ0gORqQqUIuVmk2L9b2L
	e6lyPZxRRU/yU3iWbjLglgHN0DpsHQE3XqHFd0Uq9sN6YRfanlmMW+0pOQS+piH3
	B5BYtGi3KMx/DRz61IVo6y/xz4Rv9oF7NqSJR+6qy9NRtiVhEtQWtf+3oXUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703228817; x=1703315217; bh=BoUi0Lx1gZP9nFMwdw0C6puWbb+B
	9pctDK1EXIQql98=; b=GIW7i2q0iNjL41970vV08yUaZJVbJj69iSQbURmYhzRX
	WM6ARsYauICcmTURsWD7IndffkMKzvc8j/VV+VffpFDyBzIpI9TUQrjM4aDqQei8
	7mb9o89NWHxuJO0gHXJN4ja7gp7oIwi6IoaKSh23XWOm55Hn0eAPeE35fXdna3eQ
	pQdizvbI5k7aL2HsLZhiIzMrL2fmX42X8IJnyufXKu/P4KVE5ryvVMY+WP8W2hsE
	88aMq1epAQhcK50ijwbSwdVKw+uHz0d8mGfFLsv52EHe9G7jyhFJW3SEzFwibHvi
	362cL6xUiwOhOVwd/15Tw2AP0QNXH606iYLGgz022A==
X-ME-Sender: <xms:kDWFZWiUpC_2dZubuJ0K4Zt2SVK_FNz9rc7I22ePdcDU_wQ5303Q7Q>
    <xme:kDWFZXC8Pm7VPfYEHaitRraNXPYWSv2qIfiwMh3o6xWP_JcSaisLLwMbdwBLXharY
    ehG1klrRTszLA>
X-ME-Received: <xmr:kDWFZeEzoxzGul4z6i5gvJ6pnfW_Gcg-PoK91Gz6rwMM0JK2gzy_Uf3S1pQ-QwXYggciVNXTRZcJQt2Yz02vfQHbcd8bIDgz0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduiedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:kDWFZfSoaAg-TLcnCyy4YMrXPWXx4X97u8eN97QST4eDSrgCpoRJNA>
    <xmx:kDWFZTzsjjHVigfErfTZm_Jr6f2lEDB6nF3suejAinorLWSRAEE2aA>
    <xmx:kDWFZd4ZT9LgMxMuJTxeFckvYJ_4IBP8kzyGdMLGlf1LrHTmhqs6xw>
    <xmx:kTWFZanjf0zzZQDxKcOxnNaRHsWnTxFjzNAC9BK4tUYRX9bTKZWllQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 02:06:56 -0500 (EST)
Date: Fri, 22 Dec 2023 08:06:55 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tejun Heo <tj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patchs in the cgroup tree
Message-ID: <2023122248-dayroom-coveting-1b2d@gregkh>
References: <20231222142049.397619e5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222142049.397619e5@canb.auug.org.au>

On Fri, Dec 22, 2023 at 02:20:49PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the driver-core tree as a different commit
> (but the same patchs):
> 
>   2bf46683842b ("kernel/cgroup: use kernfs_create_dir_ns()")
> 
> This is commit
> 
>   fe3de0102bc8 ("kernel/cgroup: use kernfs_create_dir_ns()")
> 
> in the driver-core tree.

Should be fine, thanks!

greg k-h

