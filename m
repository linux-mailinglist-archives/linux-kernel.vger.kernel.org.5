Return-Path: <linux-kernel+bounces-31710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3058332DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24665B2308B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457231879;
	Sat, 20 Jan 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBUlywDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7EE137D;
	Sat, 20 Jan 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705729002; cv=none; b=T5ZMvYP2MhW/csts5EtWlzUT6E+UHZQoBTGUMAuZ4Lz+Lg8cKywlQht2RQwaZrLDXahnFbQL65si8u/cYupnlsv7/lX7UUcGZ3F//6Rhss4IqXgYQQQefdTCGnBbug4SGRtdw/ChEj5/Lj5f5GIEdT7Q6RtvB0zI7Flv6McRg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705729002; c=relaxed/simple;
	bh=WWMrQcgQ19Jb6GYSSiSkyx3JOthmaTPXhUVWCPa+lTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEhrVvzOMNuxIO9gM7hS50dQHk1nvfH4N9mA0caUIiaeBQT4zZFvNtRL9JYaxAUT9xrPFo61ugwKoqGDdkVAcHeMhnTZMdZksKAF3bNqzr3DzSwrW9bntQADajdZTJDR3eaJvB9RobWObi0U5pml+xrCNJKgagr46EAevFHT790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBUlywDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8653BC433F1;
	Sat, 20 Jan 2024 05:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705729002;
	bh=WWMrQcgQ19Jb6GYSSiSkyx3JOthmaTPXhUVWCPa+lTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBUlywDeifY2CTBrgfYUWMbWsQN6adcqI+OfGDtCWSrdw8ukljnt3X41nmMPrWiSo
	 aQtdSEuaXw3vZainaE1CcNT/G0JTayDJAX2W1psRj6xnXKSuJCJmd9IYa94A3Eq002
	 sgTuZGVqQ+GpaVZcg/ggWyxhzlftV12cTY79mmZ0Bmm5oZEQXQNpOJF13n4mfbVmTO
	 sn8kxUAkhulq4L/Q1on4zWqVkDQ7u8H5HnGxS9zufd8Hr5kTkF/vJIVZ+Kmkocrwgd
	 v6l6HTgQ8/ZOuDqaqqrIXcBToHSLLsAYSP9yAwinC+UAmp5SjWOrxSCLG6fcEu8OHg
	 +U4SO5IL0AU/w==
Date: Fri, 19 Jan 2024 21:36:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: patrick@stwcx.xyz, Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] NCSI: Add propety : no-channel-monitor and
 start-redo-probe
Message-ID: <20240119213640.0b8efe12@kernel.org>
In-Reply-To: <20240118052220.1906721-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240118052220.1906721-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 13:22:20 +0800 Delphine CC Chiu wrote:
> Add property start-redo-probe to redo probe, because Mellanox cx7 nic card
> cannot't get mac address after nic card hot-plug.
> Setup start-redo-probe property so that nic card can get MAC address again.
> Also setup no-channel-monitor property so that the log won't keep
> popping up when nic card host-plug.

Device tree is supposed to describe the hardware (the BMC hardware)
this seems to me like configuration which can potentially be done
via the NCSI netlink, can it not?
-- 
pw-bot: cr

