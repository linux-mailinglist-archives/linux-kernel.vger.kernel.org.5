Return-Path: <linux-kernel+bounces-37970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445B83B8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21B62869F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DE883D;
	Thu, 25 Jan 2024 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oolXXpRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A810A01;
	Thu, 25 Jan 2024 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159732; cv=none; b=MLO1qEHFV3dy/8c5UpfFzDfOpGQYdt6oW7bjc1ImlnA1QH72OXETKZ4ugAw+LzW/5bJV04eq1BqhMqqV0yPcXsgB2UE4O14vskK3dwWlqQF35JgmDf+w8AQLIK7kiZBuYiCPBgzYPIT3JUalBwlrYzOaVS6TP+c6BHUGCOTvxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159732; c=relaxed/simple;
	bh=2iejzWtqKJOjXQRJ+5zq5BMXtUFZhl5BEYKk2fZRQhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2Aa7h+DZ8KV0huWPjRGpiHGMbWjovEGtajPUr9Lo6jw5+ckhHLnDnDXq3Xly0fsMZu3ThnDA30eM7xblEhGVEKkAWhOaYpHZiw7DtmZZzLpIaKG1d+AY+H+2OxlDL5EgVDE14Qh1a2yT5RfjPCNI/YtsWhbg0SkNpO1Vie9Ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oolXXpRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE44AC433C7;
	Thu, 25 Jan 2024 05:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706159732;
	bh=2iejzWtqKJOjXQRJ+5zq5BMXtUFZhl5BEYKk2fZRQhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oolXXpRyTEHMUx2d49baHc5THde+z2zSQRuT+Swl6JwfWNyw0eyUN/nw82rpmuBPE
	 yP6W6zoyadwzXSHWWSEAPIe2s/3E6Fp6OSoyj8GnTzwGIXm61hxMFGWg+K+vEPSNu4
	 ZmjAX+0dGYzvAiQXNpna99c/spRHAS3xjQYtNEo2onJHntSrdR8vPC9dNxdpbS1ImQ
	 s7FN0VgFlnB7fhjsPoEo0PGvOiThJLnEpKr3QNEB3VVIPkmbB9qXiYFuUaWMQnV6O0
	 B2M4SQhuqZFhTNEACF4PvfKRTJfxUDJiDsfG+ORCKGakW99J/ZpzBRcgAlm16OZM84
	 WZLehJaW3qWZg==
Date: Wed, 24 Jan 2024 21:15:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, leitao@debian.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/8] net: netconsole: add a userdata
 config_group member to netconsole_target
Message-ID: <20240124211530.77f5e307@kernel.org>
In-Reply-To: <20240124174711.1906102-6-thepacketgeek@gmail.com>
References: <20240124174711.1906102-1-thepacketgeek@gmail.com>
	<20240124174711.1906102-6-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 09:47:03 -0800 Matthew Wood wrote:
> +	struct config_group userdata_group;

also kdoc, ./scripts/kernel-doc -none $files will help you check for
warnings

