Return-Path: <linux-kernel+bounces-86106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E878B86BFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A16B2384A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48D376FE;
	Thu, 29 Feb 2024 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEPmSLcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DC376E0;
	Thu, 29 Feb 2024 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178982; cv=none; b=B8jKbZPfYd16gMdYB9P3XmixVsPR9/geJnimLK1q9+TXDclwKYgY7qPC9XtBggjABuPqGPxm2WiYvY3EnhzLxE1VIs0kc19ZZiZArj6ZoomUkddpFsbdK/oKC8ed5J8IOc9UgF/ABArp2fASjXkRRTD8R2sls7l3fv009MGsaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178982; c=relaxed/simple;
	bh=crUt0JaOGULcTF2Mh7fFpETU3vhhak7TGdKBx2myhSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr8Knla2GV798goqKMCEROj75rrrNd8ivUwjdpcscvRvQwDc9oIqV7UQDQqjcWzD4GOQPJQlzjdW4rogfBfQo7eLRPovgQZfpe3Hswrgj7yhumeLAx2Jywp7tkQ7UAC0dWBriDAdhYenw6fzq/cQOhSpGbFqm9zfom8HJD5LixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEPmSLcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5808C433C7;
	Thu, 29 Feb 2024 03:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178982;
	bh=crUt0JaOGULcTF2Mh7fFpETU3vhhak7TGdKBx2myhSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEPmSLcbPlc1ZABwK+YDSXKA0Qz1D4swx7+QbOYpzneMUiQfPNAwTd2yVd8wh9pZD
	 m9/DkES57b6nvwiUI8JoKA24AcfiIgAI2aq8AJSl3EZjODRNiqV3t3IYCog87FAZNU
	 isgGv0ie3EV1jqVT4jJ1uY1wIXalGuqdEG6nyyNkDpHbwr45uJnDxvK+WUu/B3FGpi
	 spCl8TvOws+LiSxri/M9vA//C0Mq1m9H8wgKJCawryNAaIoZNfZ1LstbyzRwn770N8
	 ZBRXSlEijnUOOw/uswjb4MJVMSGAPzXH3YQOqLZDhLrxnkiSFk61S/MTTeLYRmyEz4
	 O0FyKG3BC75tA==
Date: Wed, 28 Feb 2024 19:56:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v2 1/2] doc: sfp-phylink: update the porting
 guide with PCS handling
Message-ID: <20240228195620.35442c0f@kernel.org>
In-Reply-To: <20240228095755.1499577-2-maxime.chevallier@bootlin.com>
References: <20240228095755.1499577-1-maxime.chevallier@bootlin.com>
	<20240228095755.1499577-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 10:57:53 +0100 Maxime Chevallier wrote:
> +                struct foo_priv *priv = container_of(config, struct foo_priv, phylink_config); 

The watchful eye of checkpatch spots a trailing space at the end of
this line. While fixing it, perhaps wrap the line as well, it's long.
-- 
pw-bot: cr

