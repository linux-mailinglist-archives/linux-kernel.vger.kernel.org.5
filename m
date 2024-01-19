Return-Path: <linux-kernel+bounces-31624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586683315C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578F01C234F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2B58ACE;
	Fri, 19 Jan 2024 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuk5vwF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECBB55C22;
	Fri, 19 Jan 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705960; cv=none; b=iWjjcjnlVlbDQT7CyqzR77N9VOhTaor6hW5dVnUORUwxY5kpaE3NTJbdvh4JTpa/qUr9zsRXjDUYydvlBD2ll60nTBX6VheCOS79F+b7G+I5O4FTMradYNLg1OWJWD/O8yUASzyJ2ooobCpgAdPrnKIPJwjI5NJ3Zw7QeFHXh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705960; c=relaxed/simple;
	bh=QWLoWPTVSJk5hBdkRxtSR5LOwrHHVowDsyCeyV+Yr+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQFUme/w3whPSCuFqoIdRG35+ZXnsGVSxrS9yZ7ooHf49VYm9wjXUebT5VVbiYHetwvXDMs99roqWAgK5KlARUqKGaGyw0VJYsK7lsoVkEZVA1wl7flbfNcOBRGjYgCFy5q31T8iw6yBaDFpOO64JoHEfSdHJ7MQj4ULSSJvFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuk5vwF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15624C433C7;
	Fri, 19 Jan 2024 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705705960;
	bh=QWLoWPTVSJk5hBdkRxtSR5LOwrHHVowDsyCeyV+Yr+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yuk5vwF28PLjn9QVyUzzMK8NDXjnOdkIxZ8nhcuNJXlIwBBcEefuRK0Saf48UOWmg
	 AI/1EiIwgZMpVYEH28BYogH3MN6lZAtuAVDY/9lEgRzX3rJ652SB58lYoNZQIqIyf9
	 GKC/0fbeUQkdNp/36oNdaPtomYF5oNsV2aS7ij4pjophACJjrpezkLjiZB44/3Bvay
	 VTttKwi6HVoi5Gu63uNlPIRAVSqUecBJHtkgrUjEV8eAo3zPxaatIJZBmQy+zfiCxy
	 1nRbZjXQVxg45Yv+aJkRr5AXS7O4wKWB3+ZHoVHABl0YeqYs+wsj/Y/ZoO/FeK3OGX
	 b9gvGBrKkY9MQ==
Date: Fri, 19 Jan 2024 17:12:38 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] of: property: Make 'no port node found' output a
 debug message
Message-ID: <170570595710.1290663.500028571860662803.robh@kernel.org>
References: <20240117083206.2901534-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117083206.2901534-1-alexander.stein@ew.tq-group.com>


On Wed, 17 Jan 2024 09:32:06 +0100, Alexander Stein wrote:
> There are cases where an unavailable port is not an error, making this
> error message a false-positive. Since commit d56de8c9a17d8 ("usb: typec:
> tcpm: try to get role switch from tcpc fwnode") the role switch is tried
> on the port dev first and tcpc fwnode afterwards. If using the latter
> bindings getting from port dev fails every time. The kernel log is flooded
> with the messages like:
>  OF: graph: no port node found in /soc@0/bus@42000000/i2c@42530000/usb-typec@50
> Silence this message by making it a debug message.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


