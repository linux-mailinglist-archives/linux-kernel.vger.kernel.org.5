Return-Path: <linux-kernel+bounces-72432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809FD85B328
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CE0282413
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688C288AE;
	Tue, 20 Feb 2024 06:51:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0551DDFC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411903; cv=none; b=Osk6yzlHVo/RH9gXiFh6EQU+gSGUlxERMVVEj0O1G30D8nmei5Ir1noHI85kg7OVqFT9pEgApdpj4e3GXV1LBQqh0lv8fnG6plQUnPsNdn2+AaZ3PrvaYCipmIwhE/ziG8LBe8klgbgxNLOfOhuuDBqj9XamQ6WtU8VRkxYsK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411903; c=relaxed/simple;
	bh=tkxEBUHWm9trNzsG//zbI8cdUdecOc1mtQHx43KyyH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz5EQzP9csuNNFkTkkTLlYlOYSNfWov8G1v4JDE4IbRnBYOtTHNxpd0FJTn2Pu3rvE87NevAzFFQ1RausxCPjVJ2O31/CbpGbLeuf55Fzhar4+C9az/NxtW94tMymqElse8IAg0hiFdUuH5xxHyeYkvrpiZWXGF9aYZlWRPG9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A55F368AFE; Tue, 20 Feb 2024 07:51:31 +0100 (CET)
Date: Tue, 20 Feb 2024 07:51:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <20240220065131.GA9150@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-2-dwagner@suse.de> <20240216094909.GA19961@lst.de> <jfjchxptpfcpolpy2etiigflqvfcp2nzk53iwb6rx2zsdfd6by@h6ezfayjfqai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jfjchxptpfcpolpy2etiigflqvfcp2nzk53iwb6rx2zsdfd6by@h6ezfayjfqai>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 16, 2024 at 05:44:02PM +0100, Daniel Wagner wrote:
> James answered this point on my attempt to make this synchronous:
> 
> https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/

That needs to go into the commit log.  And I call complete BS on that
to be honest.

> Ideally, we could agree on behavior which is the same for all
> transports.

sync and async opt in it is.  I'm still pissed FC did this differently
without any proper discussion of the tradeoffs.

