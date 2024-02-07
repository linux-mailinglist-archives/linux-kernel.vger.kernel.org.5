Return-Path: <linux-kernel+bounces-56398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B18B84C9AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D846B24BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FA1B7F7;
	Wed,  7 Feb 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI4P03/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1691B7E1;
	Wed,  7 Feb 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305776; cv=none; b=TMC5dhz33Zjv0ljxPxkOPw6WFJalzZUdDx71UQb9yVvon++K3SzNBMqKmwkQfE4S+7nunol8AbRFXBzsbWCfxgFEg9uKUgmNOrmwqsWKAh4YPWszpEwD1/MYahip0RIZP+ioD8O28SwyWD602KljoAkXNTCqfhgEP2kWxqwy3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305776; c=relaxed/simple;
	bh=CAiqqzNXHS+TiKRMG6pw7gNqGd6dm1O5Bngf8qWV1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud2h81Cl5IogYx04uGHFtd7JMZihEcU2eA7FbPoODLsi7jymru6wJJZTqNsKwshCMQcz5fwtchPamPbuXp3AXxLZJRGr5PbymVy10leLzE+PA+ElWTbYc9zeQYcIDtO7GSdJ5mq9rsM5c+e/IN3B8fUzmWy5OremkGU6GDo+AUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI4P03/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D26C433F1;
	Wed,  7 Feb 2024 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707305775;
	bh=CAiqqzNXHS+TiKRMG6pw7gNqGd6dm1O5Bngf8qWV1UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qI4P03/50EKsnaSzyyASzDP9cnyRrqrACbpg4oOeOCnuo/6m4Bj+XqDV1NOfCJxtK
	 kSXtWyZOyjerIaJMjjRW5ab5FVZ9Hfw3oB8Gy7FUPt0sAdOS/SxtVUJpFylDPV5OEo
	 pNuwi4tYwYTC8cVuHJi8UcOom8jOh9xuaA47HVxV6WegHNlQmuoqCiLUhXO0d3LhEh
	 Ft21I/CfG1Pv4LnJmrmiFeP2jtVpHZbddSG47RhdJRFpPtX2UkdqNbEMXFdxJMEDeW
	 GVY9Pqsl54sdjkuMjl3ukrEQuj/GdF8bav4OZSvZ+SXGpcmGhRiqjJLYFr8g2SjHwJ
	 BO2ghSq0K62PQ==
Date: Wed, 7 Feb 2024 11:36:11 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch
Subject: Re: [PATCH net v2 7/9] net: fill in MODULE_DESCRIPTION()s for
 net/sched
Message-ID: <20240207113611.GD1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-8-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-8-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:26AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the network schedulers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Hi Breno,

I wonder if it would be useful to mention Ematch somehow
in the module descriptions as that is the context in
which they operate.

