Return-Path: <linux-kernel+bounces-3941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E92F81755E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2051C232C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097CF3D568;
	Mon, 18 Dec 2023 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WutFymaG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2E3A1B6;
	Mon, 18 Dec 2023 15:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325FEC433C9;
	Mon, 18 Dec 2023 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702913739;
	bh=/PRzWW+61bm8JeOBeRvqEJXgxir+CIm2dpn3TWN4lv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WutFymaGf0kheSzw6iK7t4JsxJsPTWfvgOABhP380FO7j6yCB08/b4ALn9Br1doXg
	 hnz9gmt5M5m07rN+2po3GKTfcr8BZ4Zyb+/A8V76pR/QKXh09RiJTAymWYm9UpXJIN
	 ORqbujQcMxIt3uyHz0QczEzh9AsjpsH5cVhdNcklYgebLPJHmxLFE2n7CDntE1ZyNG
	 ZDMkrgnh4NaK86wgeYywwS5KrvbieFmPdaKRIKqnvj5lNH9TbNhM6ELglU+EL0lVXk
	 4LEjySawQ4F3lX02rdymekEIaGkAOjT645We7aGKsfI6ld2eoiA7gNNE3piMdw/3+F
	 4r7DsUVT8hTGw==
Date: Mon, 18 Dec 2023 15:35:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 4/4] net: hns3: move constants from
 hclge_debugfs.h to hclge_debugfs.c
Message-ID: <20231218153533.GE6288@kernel.org>
References: <20231216070018.222798-1-shaojijie@huawei.com>
 <20231216070018.222798-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216070018.222798-5-shaojijie@huawei.com>

On Sat, Dec 16, 2023 at 03:00:18PM +0800, Jijie Shao wrote:
> some constants are defined in hclge_debugfs.h,
> but only used in hclge_debugfs.c.
> so move them from hclge_debugfs.h to hclge_debugfs.c.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Thanks Jijie,

this looks good, but I think it should come before patch 2/4,
to avoid warnings about unused symbols being flagged until this patch is
applied.

...

