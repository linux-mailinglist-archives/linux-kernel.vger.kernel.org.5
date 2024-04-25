Return-Path: <linux-kernel+bounces-158139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF408B1C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1281C21299
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328A6D1BC;
	Thu, 25 Apr 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5S9mW2P"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA4535A5;
	Thu, 25 Apr 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030775; cv=none; b=ZwG76hPWFE/T6st7PUR8SD+e0dUXSPZibTRa+4xzdSGnIOvaHqrBC0c5H1Hudqiod5LbQf+qsgbXhf4Hsoc4OM5gHHGZtQqiuiHYvRF9Ir5HPww0SUblqUfwEuKjaj8QzEj05HRzeTN1jRGs0UQ9J8WWS3vJs3HqDtrpBTgzCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030775; c=relaxed/simple;
	bh=NXH9DFSKlZTB8H14nYXZsm7pEec5UcVC0Q7UASNlYTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFdC7v7E7cWcUTWy0CzqDJlaFnC0KvyRgnCiQE4t8TzA9Zq8JvAGD5qZMIgG2mM7jKaEbY500LMYn3w+p72dc5hQWmOnoxSeyP1oc3MZ5AWiwtFKDhnKMkgxkO9SLa17h1FjfXU3bVJuxuyA48zKQDXqdHa2XFlMP2w57aWyKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5S9mW2P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F24A91140134;
	Thu, 25 Apr 2024 03:39:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Apr 2024 03:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714030772; x=1714117172; bh=+iroGCBHnk6lu8W8CuyJ3SmNRcqb
	HlQo8giK2UXnHgw=; b=W5S9mW2PHEWn2F2V9Kn04mjTM0H67/OonUvESwJqPIpA
	TChtfeF+4E2olLEgnfe0rCO/ZntpD9rjNFkN53JAYnPJgxp1gTZdadEc8TZJIzKH
	ZZ2pivpHMH2Irq+JKgRhHJu5gEV/J2VbLVAs8eE/YJIrOxDvsZCBAy6dB3/ij0Zs
	i4U6g9AMYmIQy4VoWwS1T5Ul3D6Wfpf2LNtNXCMUzBl3Y6WeFvnv9keeJRsBUlBw
	bTnuZnRqF8RGN7u/9Cu/H4e2PK5nnodTlUAp40hVPP2imihHfX1BBNoOOK38t6yN
	s2jsKMPwYVfI9bMFXjknZUX0U3MbEz5qZOLTRDfaiA==
X-ME-Sender: <xms:tAgqZqRfDmvY2wMg_7OMjN21KQ47bllRQ7OF7pfKZEJaix8auPdslQ>
    <xme:tAgqZvwsMirF1LVvFrUsj0U3mjkfHuhkuSeh0g2_1tjNo-xjL2xXjULjnyvfRAaAW
    HhqI4Y5G0PL_WU>
X-ME-Received: <xmr:tAgqZn3ndwP0kfDtRSZ2vPtkyc2yQ-w-nCi62aqWm-OjZx2faHgeCFcPZniY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:tAgqZmBKJ0bAjWIp8zZIo4q-sejqZpLMLjinyBUDvAay8_2jtgb1nw>
    <xmx:tAgqZjivUDioYhho9Ff3JaNqXclCASN5Jv_9QnHzUgntS4xZFBp5zw>
    <xmx:tAgqZiqHTRAyovXLStvxdVIgrxg0-uQIexcou-hUHbikSamwaq23fA>
    <xmx:tAgqZmjaxxG4cAYTKuIdqKf67QKbmvtm6bc_FH8xua-DA7SpI6eKag>
    <xmx:tAgqZuSno9Sh8o7kXlDnTSCSCtTZjr7wYBcCAGLsH4_PhLN2mUk8K53b>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 03:39:31 -0400 (EDT)
Date: Thu, 25 Apr 2024 10:39:23 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] net: sched: act_sample: add action cookie
 to sample
Message-ID: <ZioIq3kNjivL9AnM@shredder>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135109.3524355-6-amorenoz@redhat.com>

On Wed, Apr 24, 2024 at 03:50:52PM +0200, Adrian Moreno wrote:
> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

