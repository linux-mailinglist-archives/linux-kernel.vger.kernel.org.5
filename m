Return-Path: <linux-kernel+bounces-97762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A873876F10
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A1F1F21932
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BF364BF;
	Sat,  9 Mar 2024 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNIg/8LI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BD3611D;
	Sat,  9 Mar 2024 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956940; cv=none; b=ahEx3rQ7bjZm4kJtWVfhfySLLfRfpi1qPUdOKn/HDFGb8U48a+vfmk490UTKM6Ot4lSS2CB65iyNGIhpAk3ZhVT9JSkzbT7byXgsGoSf6PB4fdVgCB3dU3zs/W4YUSAg9hIqDEUvFbZab3mTL6nOGhxC0y7XKhtp/srOR45qdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956940; c=relaxed/simple;
	bh=4POfnc1a/5kHoObarFvA/ywHr33AwhH9oxhmOA8d76c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3/e5NnIKhZkK79pyu15U+Hyxqo+C9rJi52w1imP3dpSMH886Mr1rgWqhR9VyGiqhWRsj5t+0YeL+dV8/Qbq0d6x2aZ8+5JkUZcG6K8ZSAZ6mrmasMkm4tr7mVPUVwUa+Jfc8CioLx7WW6LYpFPhOaTjwFqLbOXAxB/RDMcAruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNIg/8LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E67AC433F1;
	Sat,  9 Mar 2024 04:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956940;
	bh=4POfnc1a/5kHoObarFvA/ywHr33AwhH9oxhmOA8d76c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WNIg/8LIxt4oDr/rEZEqeDQRwM7t01MaNgUmFLqL9hQLe7Az1LA4Zp7kvIh/mHNht
	 eiGDp2yghrMGK7C1JjaY3NoF/KrQ+zSXp9Qkef66d3YsXIJjrNtOHOt+R0Jvjow1C8
	 HnQx5HXMZYmLsHS5+PHuRQsJjaO2yibikUWOgan/boeLsgm3Q+d33un9YmcPia7q24
	 5kxNXqtAzcA7QkXY2jb5WbuK04pfDMIPnCEpPB5G3kq5J2iuvcxieFQ7xw5KMUan5Z
	 oO1MOi1PQTtT0ME5JUphJ/h1TvOhOp6YE88tyOwMhdK07ahXww4HB2yfVZE8a3IoOK
	 w3CiF8WujrPHg==
Date: Fri, 8 Mar 2024 20:02:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Simon
 Horman <horms@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
Message-ID: <20240308200218.2e60f8a1@kernel.org>
In-Reply-To: <20240308104725.2550469-1-o.rempel@pengutronix.de>
References: <20240308104725.2550469-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 11:47:24 +0100 Oleksij Rempel wrote:
> +		problem = "Failure in VLAN settings on this port might disrupt "
> +		          "network segmentation or traffic isolation, affecting\n"
> +		          "network partitioning.\n";

nit: checkpatch spies with its little eye that there are spaces instead
of tabs here

FWIW I'd also personally go for splitting the string only where the \n
are, but that's up to you.
-- 
pw-bot: cr

