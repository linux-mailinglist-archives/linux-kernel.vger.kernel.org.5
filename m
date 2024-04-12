Return-Path: <linux-kernel+bounces-142590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D473F8A2D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289232875C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1558056472;
	Fri, 12 Apr 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdASKxz9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6456457;
	Fri, 12 Apr 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921730; cv=none; b=aK6BLwxWaaqQAbNWmRy1Nl4qKOqTk2i+6+KgWd3myNiz9MQOXnzyPBYj+QKzn9oOdVnQIWjytJUjcW+dx3P6235Wd1BgSynIR0ZH3cGqXpL+WfgL1gXpFXHH9LWQe2DRXrihHpu73CbvWLx+RNqeEAmJrWCLEJyZ7UMFNYhvQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921730; c=relaxed/simple;
	bh=1akF5iagUaB6cD6uyJ9MQX0Y3EivkySknkIgwedFIaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8BPEdvH2DzosClMlWQ0JSTyB4dTnNVAbmYpmNOp3ZBLT3PqlWg68NWP1K54bGuDmeXE2Vl5rPNPKFHv7T8LX6uyY+M+Rvp/R6kwy/04wT1oBwDH0mQUBEMma66VGczAnxFSHvWiy8xdGMwBJlp+Iw40IwY/0wULcZn5CVpklQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdASKxz9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51d3193e54so89772166b.2;
        Fri, 12 Apr 2024 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712921726; x=1713526526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WYB9yyaCzAwqXK/Ahmpy8sL9cF8RGoNGdT7aUNX4d3I=;
        b=KdASKxz9mJ4Nt5BhenH1mIseVAnZbE5OuUfXcAHXOapFUynBFtMS8TzaUEcqLNxQNE
         iCBKOdFmqi9oQ33ldJPo3vkL4Kr2EJ4h2osbM4ayCOcIDOqoMrwQYMQ4OTGGuumezJys
         TP+24ylpep+Y5URM9FBG3hUixPikVv59QT/Dngo9rXAeF7JqLQWD/+AUKu/CKkCYleHC
         slcJvu+dBF0l2mAMjnDEyO/vYPNJNssi+JmeVBbKQbUWP+WfoMe7dK43ZiXTvP32StrA
         VfSqbFphM3EXkh4DK3aRKLeDUH2+VgUARdFwjFgRlHdRqxq85FQy7Wg1TDS7PEuXV8fU
         jnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921726; x=1713526526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYB9yyaCzAwqXK/Ahmpy8sL9cF8RGoNGdT7aUNX4d3I=;
        b=om6GhreDYL9kY5BcjuGk/usM8laJj6oqLuPgIwZ/GBuL/fEqUo75BDl4L1aZn46KXH
         PTdzjtseWPVIZgm2gg2rLvwDPEd9GQ7rasIGFZOB0CANqFaPaFJy2Wy8XH5bQtVYVsuO
         WWXid1gazSrQwn6g2lyDTbsdLAMG58l9NANpw1AgfDOaOXel3PZujUJ/KTroF4mJujcX
         ud3hgoq8TqV5acul+py67Jzonko3YwkdtU5yEhxLhz6p7JBAsq094Ss3meILnvqOc+/B
         d8rJWaNBvIT7nP1JNmXNUZoYuDIOSIMsWgteHKcP4bPKEw72yWp1C63dsfQ2AqONpWZH
         86iA==
X-Forwarded-Encrypted: i=1; AJvYcCVSa0VtQx8XjhAOaFwNE4SMvoZQ4CK+D7ZwfUaaZw00znxO9z2QgNOddFEdnUkiZ4sRzP8k8fA+hyWDIC6VaM6LHKH08DZxcNQqgnFu
X-Gm-Message-State: AOJu0Yz/xWoIeQmsG65A3YG2F4mFT/QqLbO/mcuQXg9I3WdPB6eGqSGA
	If/8K34159cf2Yg/T0xswYnmfwHK5dtZd0tgNwsgViSadK1YPrZ9
X-Google-Smtp-Source: AGHT+IG+qwTasLEBhJeMoo3FMZAd30TRMHh69bnxJcBL7Bwu6YenqqMwO040OJhkHA/0qPPr7DvmNQ==
X-Received: by 2002:a17:906:ef0c:b0:a51:d80c:157d with SMTP id f12-20020a170906ef0c00b00a51d80c157dmr1878318ejs.26.1712921725945;
        Fri, 12 Apr 2024 04:35:25 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a91:3c00:4937:6ff3:a774:89f7? (dynamic-2a01-0c22-7a91-3c00-4937-6ff3-a774-89f7.c22.pool.telefonica.de. [2a01:c22:7a91:3c00:4937:6ff3:a774:89f7])
        by smtp.googlemail.com with ESMTPSA id do21-20020a170906c11500b00a46baba1a0asm1708212ejc.100.2024.04.12.04.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 04:35:25 -0700 (PDT)
Message-ID: <503a066b-e2be-48ad-91d5-15ea9fd5bb62@gmail.com>
Date: Fri, 12 Apr 2024 13:35:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: phy_link_topology: Handle NULL
 topologies
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.04.2024 12:46, Maxime Chevallier wrote:
> In situations where phylib is a module, the topology can be NULL as it's
> not initialized at netdev creation.
> 
> Allow passing a NULL topology pointer to phy_link_topo helpers.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> ---
> 
> Hi,
> 
> This patch fixes a commit that is in net-next, hence the net-next tag and the
> lack of "Fixes" tag.
> 
> Nathan, Heiner, can you confirm this solves what you're seeing ?
> 
> I think we can improve on this solution by moving the topology init at
> the first PHY insertion and clearing it at netdev destruction.
> 
Not on every system the topology extension is needed, it may just create
overhead on such systems. Would it make sense to hide it behind a config symbol?

> Maxime
> 
>  drivers/net/phy/phy_link_topology.c | 10 +++++++++-
>  include/linux/phy_link_topology.h   |  7 ++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 985941c5c558..0f3973f07fac 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
>  	struct phy_device_node *pdn;
>  	int ret;
>  
> +	if (!topo)
> +		return 0;
> +

This one I added as temporary workaround already, it fixes the issue for me.

>  	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
>  	if (!pdn)
>  		return -ENOMEM;
> @@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
>  void phy_link_topo_del_phy(struct phy_link_topology *topo,
>  			   struct phy_device *phy)
>  {
> -	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
> +	struct phy_device_node *pdn;
> +
> +	if (!topo)
> +		return;
> +
> +	pdn = xa_erase(&topo->phys, phy->phyindex);
>  
>  	/* We delete the PHY from the topology, however we don't re-set the
>  	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 6b79feb607e7..21ca78127d0f 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h
> @@ -40,7 +40,12 @@ struct phy_link_topology {
>  static inline struct phy_device *
>  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
>  {
> -	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
> +	struct phy_device_node *pdn;
> +
> +	if (!topo)
> +		return NULL;
> +
> +	pdn = xa_load(&topo->phys, phyindex);
>  
>  	if (pdn)
>  		return pdn->phy;


