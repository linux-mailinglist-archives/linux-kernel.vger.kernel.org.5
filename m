Return-Path: <linux-kernel+bounces-134834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F389B79E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1C51C2154E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E9B1427B;
	Mon,  8 Apr 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFzNqVZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0D101EC;
	Mon,  8 Apr 2024 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557786; cv=none; b=sIGyoQNT0cblQw3URzHtjcJHSP+a+jSHd1sh6wp8/8dHq3fTr5Sv4A7MOeJYd0soTis2bFgs8gb6dC28GKw30rGVYeu3knbrRoVnigZnsktpB0ohvpWvNJuW3oATgCFsIMD4H8wcF4Gjg8VYuXlnb6zmGFqkGQiLGo42gklN9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557786; c=relaxed/simple;
	bh=tYGm1Wlc83AANEmNhUlaWG/yPJVBv4tT7LpQHu6j0Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEUWxc46wu9eGJeMAL1ISzrN/dS5ZOhHrdwavDdZpmNMWxTRxGciSSQB9boT37F8+ybRi4a0NBcLEV5G6GG8/W/EMSSZOWxTZS8MYf0iQiQQ4npSbIdWL1X14aGo7CtgUt1Q7b+x7P+yIQinM1jxuYB0ApsyAMy8lBy89b02oRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFzNqVZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33395C433F1;
	Mon,  8 Apr 2024 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712557785;
	bh=tYGm1Wlc83AANEmNhUlaWG/yPJVBv4tT7LpQHu6j0Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFzNqVZXR1Wo7mNMG5ZdFcfP+tc50d3NZE64DFL9ao/r5t2nvY+pBf07cyP5AsQIl
	 Ucr0aRthRFiE4XXEpt9omqyAu9FdGqk8JHFgdL1upMC539YHDNjT0WWb1+YzDpmVka
	 KLo5KVgQLNl1fmhIhpaMYCDnDFYMk9zKAVz5pzUh2zmmDtoYmjxlQfrUdSqVI8QZNq
	 wzyr6qB+Kg0gX3WSPYTmJaV8RESoBE6FdKgrrE4rwM9IDPkALh8eplSYoQGeofDObi
	 ClJdiIfHW0pA2t6qcB0CzU/kt51/BcgbYaXn/+z7rf8N4fckleVSpFhqaT6KKHGt/Z
	 5REdMpVPic58A==
Date: Mon, 8 Apr 2024 14:29:42 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Mario Limonciello <superm1@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	"open list:CHROMEOS EC SUBDRIVERS" <chrome-platform@lists.linux.dev>,
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Dustin L . Howett" <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] power: supply: cros_usbpd: Don't show messages for no
 charging ports found
Message-ID: <ZhOO1hCJroxf0oHy@google.com>
References: <20240406191734.137797-1-superm1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406191734.137797-1-superm1@gmail.com>

On Sat, Apr 06, 2024 at 02:17:34PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Framework 13 and 16 don't use cros_usbpd but do use cros_ec. The following
> sequence of messages is totally unnecessary.

In the case, the EC firmware shouldn't report the feature.  See [1].

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/mfd/cros_ec_dev.c#L106

