Return-Path: <linux-kernel+bounces-74092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918E85CFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACB31C21B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8E39FCC;
	Wed, 21 Feb 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUhohgDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48215A5;
	Wed, 21 Feb 2024 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494087; cv=none; b=MeyA79TTWaargFQDA/8S44YoFnlVB/+gUKgh9FSF5AScukUODUoj1C9aK4B8DrhFUHNUT4QeDAwLvl0rfnSXjM8y2DwNjetj8NgDM1OvsTgpRmzJvlHJ4sm1QJFgcyoSjN8LmrpUe+nJvIIUwPlulZTYAxFTxcdGWaPL6W2fX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494087; c=relaxed/simple;
	bh=PFv5dcclqc5fxx24pQhxAqGrKur7Dj/gyayYbUFSDqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+NIRyQZqjCyRRi/YgbtEjTD2L27w6bKwXchEuu3DOASG8AGrRmasEJfjbSv4TCC/RH+F5XT9BeootXm+LleV195r9e9x2Mql+d8gWd/S2x1MTWXCpvvAiXp6+kI2wkGEFfZTI+7ntmgm5fVhBpPdgRqlexWrOgCJF47uEfosrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUhohgDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E8C433C7;
	Wed, 21 Feb 2024 05:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708494086;
	bh=PFv5dcclqc5fxx24pQhxAqGrKur7Dj/gyayYbUFSDqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUhohgDWo8d11YY3Om7rAXNZBi9f8bLS934fpkbSivLpblFQW2I6lLTpedbpDPZCm
	 qbOVqJB+oA5DOmPUC6LZesVBVbT8PK4gXBT55geg0hbtL1i2mq+C/5MZSXSzzPcqLT
	 lv0ljBO5LsZextn/f/syOv/Jw3n69J8Rw12Sf9iQnbq9YzNNlI4C5CSQbc2PGth2KM
	 moaocIda/dEhxBny9f9ID2EP/M1NSqN203Xtko167s6jZzdUaPSjODkUaW8CdXIeJ3
	 D+9kVHmmGFArBuI5r9R+UJ+S6kpx9iColYsAhGc84rL1uZarYk931UdQvyrYg6rWez
	 bxJQSAaNUIUaQ==
Date: Tue, 20 Feb 2024 21:41:24 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [Resend PATCHv9 1/1] block: introduce content activity based
 ioprio
Message-ID: <20240221054124.GA14358@sol.localdomain>
References: <20240221052624.573287-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221052624.573287-1-zhaoyang.huang@unisoc.com>

On Wed, Feb 21, 2024 at 01:26:24PM +0800, zhaoyang.huang wrote:
> +/*
> + * bio_set_active_ioprio_folio is helper function to count the bio's
> + * content's activities which measured by MGLRU.
> + * The file system should call this function after bio_add_page/folio for
> + * the buffered read/write/sync.
> + */
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)

How did you test this?  Nothing calls this function, so this patch can't
actually be doing anything.  Are you planning to update any filesystems to use
this?

- Eric

