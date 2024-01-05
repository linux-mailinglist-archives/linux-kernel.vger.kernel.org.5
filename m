Return-Path: <linux-kernel+bounces-17745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB48251EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA05D1F2221E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C628E1E;
	Fri,  5 Jan 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoBok7HT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528C28E08
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F8C433C8;
	Fri,  5 Jan 2024 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704450419;
	bh=lYtPk7pnl7UFoUPdIHhfhbO5M8cu9gEH+/gq3HHPY9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoBok7HTiDgbbdG4kCE6da/L0ZXhRPtPPJELfWvyzhLfSDZ9UEmawVkpkt5JY2yL7
	 kkaigUwqCqnM80HdziRzpjoIdE9gNHSxh8dncVwcM0th3vLymICJYEax8onjVyA9nQ
	 Gj1XIhzdWOL7IO7btWv1NP9NJAiGcn5CjuQIG7yAJz2mSzBfTAY8dz2rttsiBVMuGU
	 Gm0/w9IbB5HigZb8TRP2yBKyjQRADUaOjYjxIQe+gZo8+yZqpXA7Gh7MDmSHX4MTVY
	 lHbP3YCFek84orBlwWu2AbCgXESHk6UKY58gARwYT4Wg+ZtQ9A8DhU22ad2h/rwVVx
	 s8ZUlw2DApOPg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rLhPl-0002zL-0z;
	Fri, 05 Jan 2024 11:26:58 +0100
Date: Fri, 5 Jan 2024 11:26:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	Alex Elder <elder@kernel.org>
Subject: Re: [PATCH] greybus: make greybus_bus_type const
Message-ID: <ZZfZccwT9pOb8FVS@hovoldconsulting.com>
References: <2024010517-handgun-scoreless-05e7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024010517-handgun-scoreless-05e7@gregkh>

On Fri, Jan 05, 2024 at 11:16:17AM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the greybus_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Johan Hovold <johan@kernel.org>

