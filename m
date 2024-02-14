Return-Path: <linux-kernel+bounces-65614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0155854F60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC382881BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7060DC7;
	Wed, 14 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfAwVp4p"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CF535D7;
	Wed, 14 Feb 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930291; cv=none; b=BuLTK877lib8yQ/XZwaHzHsU3x4AOGRz9QcocIYGPmAZ4V7yHA0dVU4FHA8E8jKzI93rDIN4oA15ZGH8dKgHe/dETqlnX3aVoI+/cgxqn6ZPkvayOmrWYQNCOchCJGR8kpB2brJEQyz9WDp7LU66uT+HhM2oaMV7mwTWm+vdOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930291; c=relaxed/simple;
	bh=wDLzDdZZ704bkHefOjWnFqj2Mw5ypEuIcmleZ1mU5VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKoMQrliGa7j1WvFynH2au344y4mwgYr3cMbesZeLLQvHHcD12k73yaoMXqxgBnIQszOoqHHsxuoOvk8afAG5XJqRwgbcsqW4JTxFuvUoG9h1Hty+VLKoVTevM0WCNxvb9QX1nK6TYtUjs503+pKAmGHndFCG3L8z+EM0/NFuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfAwVp4p; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eac018059so7468977e87.0;
        Wed, 14 Feb 2024 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707930288; x=1708535088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BQv+yEkFd4YaMBQAN/yo7pZoYI/R44xconYIai7ZSKw=;
        b=WfAwVp4p1kACH1OiJJnTxJFGu+QJDtbWq6okyGf+GUTcQvR0LRB76BJKdmfhAyp8wh
         8KO6IiDhgL3nwFWfd8AsVRootOHqvTTQwJZnSIpbRbItAvloZyxGec4VTBaMJx1Ewx7I
         +Q4ryCIP7K52qBKz30lnb92K3Nx4ZRCP8PRAytmEOr+Deg/wbJGkoE7xxzYH8xIjLYX2
         wE2MC4Jr+fIkQKyFpXm0eYsoQV3ASegSmAOzqcO9cdbS+oNSWQ38fvb5dySq9qPKhrGX
         vLJRIZhQJxmWzZcTq2Pe/4thpd1TUtHR4HuAq0OKo8WGecJvkfL0jiDdFV38DaSuKwOd
         8ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930288; x=1708535088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQv+yEkFd4YaMBQAN/yo7pZoYI/R44xconYIai7ZSKw=;
        b=pplkISHZIFf1C6/gWkxdhJEw7KP/EQIs3f4ARrKIepPurQOhk5x9IkkFSJWZsvxPcO
         7cERgEdgSmgM1FUsS/fdIEC8cKEuTmoA6v7O9mh7k8u5Y+QtiaSbmC+kHSLXSikTXpRI
         g/AzpA/bjXqxQiG4MFq17id2/xjDdrse5rnVVn51aj7nHcKy6hgJr/ILGL+x+H31b1m5
         YnsRk+/RCXaUawadZCmYhonkv6X7QDu3nmbFJgNLOhiXXpnaJ3I+0UUznmSvwaDEuQU0
         TkubE6WoEzu6zh8+vEm6nWN1EASCj+lUDsGkWgI+0PFjmwbnwhUjrFr2tVCTku+NiSxV
         4GwA==
X-Forwarded-Encrypted: i=1; AJvYcCUGo2kq6RFSaoCbvZVrPCPda/EI7RxSCnrQ86VzCVKbJy8WFQUO+7ozhyPTd65lkvBxjoQ0z8mj8QfIaFwXscqtdKEtfWeQksz6qaRf
X-Gm-Message-State: AOJu0YwJ2s6D/jaFHsGfQTBn87YeGJT4W3ix9HIHbWs9MCGtAv50qpdQ
	lnK2L5BCRbRBl7axtN9m7yIdknmlTugfZ32MY/UuAeYz5XO52FDp
X-Google-Smtp-Source: AGHT+IHMQhGQDQO4bdUKGe/EZAdIBRzntjh3YJglmCP9uR6Aop7HVTeRQPbDmPD2NxctavrMN/DOhw==
X-Received: by 2002:a19:2d45:0:b0:511:694b:245a with SMTP id t5-20020a192d45000000b00511694b245amr1988508lft.58.1707930287689;
        Wed, 14 Feb 2024 09:04:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7o2/k3thJMZZg2a3l+mbjOfW5FJMjF66tczVqZucZojMa0OOuukyskCD971AZ7xwR4V/13TR6/gNx4oC+zt083fisaN13EXHZ3OIuEJyG9QD/3Ml/z2jGFEbohfaTGM+zYZ81a6uuarmZp1T/iDmTMFig2eg1/RXbfizMv1e9KLnsZzYSZZsogyaqN+yjndM/gi4ZgRSOPlfwwliZJX+4qVt5anAgr979x1qdlsMdljV2sihRSqjiH8slI4W72B+l1OMzFwE7k05FBVYJOBBzwI8yDsAoVEtl6cRv8purK6m2npMQK+dEmj200jCg8ssXZFvMcY4xtVJJceMLW+bZpRo3EHbWAVlVUbm6l2tqCnSnaUFdHT8dQORSf0aK/Y7HggxjY6svZjQpqVVahhlyFq4MaujfmWbwOtrjNfGXk3lqCFFkeQjq6YoN5D/tJomNlqJwSQEZE8peuBRoboM=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id g24-20020a50ee18000000b0056310f10b76sm714520eds.6.2024.02.14.09.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:04:47 -0800 (PST)
Date: Wed, 14 Feb 2024 19:04:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/15] net: dsa: tag_sja1105: absorb entire
 sja1105_vlan_rcv() into dsa_8021q_rcv()
Message-ID: <20240214170444.sdfk4qfifafby4dh@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-10-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213220331.239031-10-paweldembicki@gmail.com>

Hi Paweł,

On Tue, Feb 13, 2024 at 11:03:22PM +0100, Pawel Dembicki wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> tag_sja1105 has a wrapper over dsa_8021q_rcv(): sja1105_vlan_rcv(),
> which determines whether the packet came from a bridge with
> vlan_filtering=1 (the case resolved via
> dsa_find_designated_bridge_port_by_vid()), or if it contains a tag_8021q
> header.
> 
> Looking at a new tagger implementation for vsc73xx, based also on
> tag_8021q, it is becoming clear that the logic is needed there as well.
> So instead of forcing each tagger to wrap around dsa_8021q_rcv(), let's
> merge the logic into the core.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

This needs your Signed-off-by tag as well. Multiple patches have this issue.

