Return-Path: <linux-kernel+bounces-145401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECB8A55BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB161F22B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C867691F;
	Mon, 15 Apr 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEgd9GAE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50B2119;
	Mon, 15 Apr 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192990; cv=none; b=K1zQpoiLPCUAOMJoVOEfCJgiheQxGJhnnTPgERA0FlFmGhiiWYkBtXQbyfbrTVByf6bYfO5RPSDetHF2lRtHLxQSCx7THsClecTOKonjls1ytl/Tz4u0svNXJ9VkroPPJjYuqExiTDeOpcVbzgudCBRyzsie0TYxqKct9smYi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192990; c=relaxed/simple;
	bh=/mvT0EDWyKl1LlJVsDqLsYJZ3bKhS9o6DCyFrjILGz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+/bD4rjy0/gOOgGqkFGIwIMAD2Eymhf+YorS2kdHcQHJ5SXmwY9us/82UWP3mtVt5p9EX/SkB6Gw0P0o2JbHAxiDQ2LzbZ8VLI7khY/95Ld7ZFwdhKGfdb03QXw37V+7Q0xEiZEaMWWESpCR19iDXG238bdUhNsu2l1Pk4vLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PEgd9GAE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rSYz6ltDs8l3GpHsJ/BNWBnXGvHDJcVElTYrkRgq2hM=; b=PEgd9GAEOSK8jC+Q0K+Ai2oK2K
	ExbXvP+V+x9B7nHBgxud3TaOYOIy9C8rQk3bulN65+YLSbnA/IzFGchEKzw8a0ruwr2eRMzuIsKw6
	2nBUzrYjQsk2tPaPavs8/sCArkepf5xZW9R0U8EYT4SoL1PqT27hmYa2ZhgwamTYMANJTBN3AGF/8
	PWjYVfJ3h3sjLfCw2UMqynzWUsHi0p1hxHnxIrA5vfJILn/QKfFic8c2Wsr038SOe55C08W/st6lB
	QGQp/r/E0diq89k0udzMPfodXjo/kZ/Vkbmntrz8wFf3mV22PiW4DuMLztUyomxJaYvzv1rb9KBuM
	UbjQzQeQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwNkq-00000008mEB-0FKk;
	Mon, 15 Apr 2024 14:56:20 +0000
Message-ID: <a2266217-c3ad-4bb2-8188-498a2c8ae36c@infradead.org>
Date: Mon, 15 Apr 2024 07:56:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 20/21] Documentation: add ipe documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>, Fan Wu <wufan@linux.microsoft.com>,
 corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deven Bowers <deven.desai@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>
 <Zh0Zh3-xraVl85Lm@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zh0Zh3-xraVl85Lm@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/15/24 5:11 AM, Bagas Sanjaya wrote:
> The doc LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Hi,
Please see netiquette, section "Trim replies".
Thanks.


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

