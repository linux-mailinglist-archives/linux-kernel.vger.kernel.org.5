Return-Path: <linux-kernel+bounces-124022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76989114E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280AD28C62E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976B250EC;
	Fri, 29 Mar 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdQcq9fd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625F11182;
	Fri, 29 Mar 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677748; cv=none; b=tUS9CV09X+59z2jCWxCLX9yWXepSjdN+HWM3YJmTDE/FNp5maOBbRApLAla4QY/1HPrVdJp85trmQL+TphVc0CEOuxTq7IRm36Ede3NuletGPGl7kl4TLmXiKh/ehP2YVytRG2QuJnS4P2upZWh3qnTD4l3Y1ao2w2LZMqShcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677748; c=relaxed/simple;
	bh=bZ9pG4B9nGRafy5pviDQ+t6Ja+dC+HfN6Fq7ez+Awgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4XWUHWVi6VZMXlPtKRE3pMqgieidnLrZzoJCY2XfINUPqKbP5Vh5ZOI1bU0uShWfkl0rYboHOtcQz76mUpy0eXsvuKqVWhMwNV219/glHv9YRNvBrOzvhdTSv2JtedFbA9I6yEaUClTrs5TfQhGpMBST8Jh3IDZFZOr6iSdD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdQcq9fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25140C43394;
	Fri, 29 Mar 2024 02:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677747;
	bh=bZ9pG4B9nGRafy5pviDQ+t6Ja+dC+HfN6Fq7ez+Awgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MdQcq9fdpZ3+rq7tnElCgdpKheh5fsIXzBZxJC6H1Pe5v1OOpJ+sX+3WQYH6wNxzE
	 b2z092UtDjwySkpSyV4wBq03YBJsYgUv4orlgGSg4NNeBrcvjDDJ2qn/hzE6QOp1lu
	 inBskuyyIP+TAJ4FTu9Mqx/qYmm3KE6X+VssQ9P969jFDHVsAuHIbgqkEK74QAXG6B
	 6JMSnliZrsunORKsrBTOa+BACDoHe8H6CnZQzNlNvyzNDNJxAIxgq7GvSgjItBw0G5
	 r1G8zEEQkqEKcEfmpJa+T27xGChezdVJl/bKiTvApZD7T3So+CelQSvYDPidPDI6eX
	 yCieP7/osw9Og==
Date: Thu, 28 Mar 2024 19:02:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Stefan Eichenberger <eichest@gmail.com>, Dimitri
 Fedrau <dima.fedrau@gmail.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Shay Agroskin
 <shayagr@amazon.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: ethtool: Add impedance mismatch
 result code to cable test
Message-ID: <20240328190226.7aab8b76@kernel.org>
In-Reply-To: <20240327162918.2426792-2-paweldembicki@gmail.com>
References: <20240327162918.2426792-1-paweldembicki@gmail.com>
	<20240327162918.2426792-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 17:29:13 +0100 Pawel Dembicki wrote:
> This commit introduces a new result code:
> ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH
> which represents the results of a cable test indicating abnormal impedance.

I'm not a cable expert but going purely by the language
abnormal != mismatch. Mismatch indicates there are two
values we are comparing.

