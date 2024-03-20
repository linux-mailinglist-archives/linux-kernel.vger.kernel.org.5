Return-Path: <linux-kernel+bounces-108981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65288812F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18859B229D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9DF43ADE;
	Wed, 20 Mar 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qM5SVBSo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEF3B2BE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943747; cv=none; b=YDRSUyhtR89t9ZaVLrYNPUh+6oN20N1TV6wmT6lwHK9Lvsc/nQq5mA/ZhCMhJJyez7vHwGz9r4cvizuOR9/HnsQAoTP7eLUd6t4yMgc9Sn7NpW0TNneX2TPDwt2LOmjiC5L3BnAUl5W+AxsTr8n7xCTe2YCx+4jK8etO0GxYPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943747; c=relaxed/simple;
	bh=H1XOmKD7bRcfqq1UFgWSVIBC/zw9QBBFa1xm/jed5/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+vMqOQsi0uozxMg6eqNGp6v37gBWbwLseMUHY7BmwV9Gs8kJL2tP6qbo7bj3YHzg0Txmg86/L/O9KFfEWbrS+AyCRcfU/wCYuX+1X2SAGlVZtlslU1KsYWWArG/OpnG1VGj3BQx81JSSoP4EYGQd+JWxMwVBUwf1qPVsc28dAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qM5SVBSo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so175483766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710943744; x=1711548544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIdJ3/H6efkxnibONQiSADbnnZKfOXj3hF+4ocmjhSc=;
        b=qM5SVBSoKeNhdvQn/Y5ZfyBfAt7AxFmnl0fF+cYjriNoMYpfaAzVV0O2X5rq9n1C0X
         4L+jkUWg/FgyOKTd7RCSCcCkrQfzfRapLvr1n+lCTvCOeBvjAAPXO083Q55t51m5mFKL
         cEaJUlY7E1ZBp6+2yrBjWSAzGQFj62+5NLR/QbmyFD4M7VzpRyK/rClnQO6TfiAoMzSk
         vDb9XCqcLY5iFC9JfInA9SuOJVhh6eXk+WsbSEQDgGzwjsAgnlxlB0mCT+tBpXlNbZmK
         ndgH2FPWPeCEmmNv1yLybCTtCd79TXNS//bH2xARGTYQCKwjvVmI0Jhw9rCbA6jcyzDe
         vIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943744; x=1711548544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIdJ3/H6efkxnibONQiSADbnnZKfOXj3hF+4ocmjhSc=;
        b=oz1tmx1cW90bezfF/AYXQWpPOGWG+XW1XLBiXa9RlEgqFJ0k3J6zeQYRnvtk2yO5Tv
         m/JASirlR0NbzbNptmQ3m+CYyH92eLncFdO5O5rEFupXJiZkB4E/eGmxUVJmmMNFbQlp
         J4hOTShI3/A+r+3t4udwKpGdx5CbbdS62ETltIF1Wn3oixy4U9qn+Gq7Wx3jQLCM6qAu
         DhjWO1EXWVj8CBjXdAerEfpWKPMebqAIvwVF1lZCZAHYaJ1CMGhAnAbY2/GhqCCT40pX
         EW9NyiOcVM63knKr6EonXIgKH42oI0sy7XdqgpfaIZJfekYK4qWnEZbgHlrMDZRipj/S
         jFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVPtQKZZCHanxJmo8bH7YEUFV2vtXBqHau7RPunLm28f5IjyzJOyWs6FRV6X+9MHPAV6UkZoNWF1c4h6n5DEt7V7BGaauYsgfku0ZUx
X-Gm-Message-State: AOJu0YyagaLhoJONDYdU9XbGURHlWpThpitukevzojMoQB30S+/ZtUSx
	CCSwzhvm8d0H6ECKUG18x+s6QISooyMMcPjyN/D+sMhAhp9w/RThfm1Df+xmGpg=
X-Google-Smtp-Source: AGHT+IHKaLgVKjjmaMssGPhGPgENyTmaminl2pI+37dLFhxxBpGvoUD3MhYFhaUXJ1R45Y5fsUtQ3g==
X-Received: by 2002:a17:906:b247:b0:a45:f9c5:3024 with SMTP id ce7-20020a170906b24700b00a45f9c53024mr5416028ejb.11.1710943743915;
        Wed, 20 Mar 2024 07:09:03 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bp14-20020a17090726ce00b00a46bdc6278csm3699309ejc.71.2024.03.20.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:09:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:09:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Message-ID: <Zfrt_dlYvBzlxull@nanopsycho>
References: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>

Wed, Mar 20, 2024 at 02:48:55PM CET, josua@solid-run.com wrote:
>mv88e6xxx supports multiple mdio buses as children, e.g. to model both
>internal and external phys. If the child buses mdio ids are truncated,
>they might collide which each other leading to an obscure error from
>kobject_add.
>
>The maximum length of bus id is currently defined as 61
>(MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
>names and multiple levels before the parent bus on whiich the dsa switch

s/whiich/which/


>sits such as on CN9130 [1].
>
>Test whether the return value of snprintf exceeds the maximum bus id
>length and print a warning.
>
>[1]
>[    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
>[    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>[    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>[    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
>[    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
>[    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
>[    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
>[    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
>[    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22
>
>Signed-off-by: Josua Mayer <josua@solid-run.com>

This is not bug fix, assume you target net-next. Please:
1) Next time, indicate that in the patch subject like this:
   [patch net-next] xxx
2) net-next is currently closed, repost next week.


>---
> drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>index 614cabb5c1b0..1c40f7631ab1 100644
>--- a/drivers/net/dsa/mv88e6xxx/chip.c
>+++ b/drivers/net/dsa/mv88e6xxx/chip.c
>@@ -3731,10 +3731,12 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
> 
> 	if (np) {
> 		bus->name = np->full_name;
>-		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
>+		if (snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np) >= MII_BUS_ID_SIZE)
>+			dev_warn(chip->dev, "Truncated bus-id may collide.\n");

How about instead of warn&fail fallback to some different name in this
case?


> 	} else {
> 		bus->name = "mv88e6xxx SMI";
>-		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
>+		if (snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++) >= MII_BUS_ID_SIZE)

How exactly this may happen?



>+			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
> 	}
> 
> 	bus->read = mv88e6xxx_mdio_read;
>
>---
>base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
>change-id: 20240320-mv88e6xxx-truncate-busid-34a1d2769bbf
>
>Sincerely,
>-- 
>Josua Mayer <josua@solid-run.com>
>
>

