Return-Path: <linux-kernel+bounces-8629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B381BA60
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7876F1F24E52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF54B15B;
	Thu, 21 Dec 2023 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI1zAhr8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159B52F60;
	Thu, 21 Dec 2023 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso991371a12.3;
        Thu, 21 Dec 2023 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703171773; x=1703776573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TqbYPdC+pzdSRXmHEIhagjUyGTTzN7gMcr6zGrguEvA=;
        b=LI1zAhr8VGz2Vn3/49osDKl/ZycprmJFaqEfF5QZOFI8mfOZPnX4WspxID/24bwMgZ
         kX46tVh0ztM+78kdV3Uw/Mev+8EaFCbTT9RKk0mgsRKW5YfAcgx0cH2/rseg3rqeQWa+
         9mT9/2S3BN7CEdNw8XMuigfKxcV/1Y3538bZvpCbsYt6hjC4tn9w924ooAt5kqcd8/MZ
         RwTi96RgB0FYrrFLFBBWLt5dV9/5fcSWYXyJFiX6g5tqRcmz2wGcVOIiqlFLqEN/9dgT
         TeWNLk91HnFXDxCxcp5scKAe8iaV2R206hS/wV9yRmkQrYN3UOyLS/5G1hxeO8SPsh7D
         Qc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703171773; x=1703776573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqbYPdC+pzdSRXmHEIhagjUyGTTzN7gMcr6zGrguEvA=;
        b=AwNcWYJn/iQnW4k5guMXgEmUmNxwlbap6pRuKRBTwhUHTnQAAuH2z9MifwL84ojSOD
         8KoXPmLFGYEFReeYjPchBZ7QvBxEcDSOcUwfSk/eX07mSlwSG2JMAPLF/2cDs3XYzLbC
         aLlKQcyTKpDkoqKrepN3LhSCp9rtuBKtp6CZIcDHaJ0FCrYKY8AEB/HZ3YuC4i4bW4gV
         0F4SznGQst1x+CA6dz3kMs+fpo9k7jkY+si44SNBG8TzN4GtGWFPktgsj9ctnqRkO3mg
         jfoxlSC/JlBmsDOJWiT+MAX0Ahagaky7cPgydNpP7mvs5kwMM6lRDomCMabdu+qOewic
         Ltyw==
X-Gm-Message-State: AOJu0Yw8fZfE9dyvZphzuv4qH5xLfP8rXwRki5vVj9JP94UOtKa+Peac
	FJddze2ilRu2aj28tgEtd48=
X-Google-Smtp-Source: AGHT+IHJjhFl8aucUSYY9VqO85+850iDGfZwpNYK/Qur+Y7lQw4rO6QDuDU6rtJXE5crDceVW8fznQ==
X-Received: by 2002:a50:cdcf:0:b0:553:d641:a662 with SMTP id h15-20020a50cdcf000000b00553d641a662mr1897345edj.16.1703171772730;
        Thu, 21 Dec 2023 07:16:12 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7d3cf000000b00553a094dd5csm1273484edr.32.2023.12.21.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:16:10 -0800 (PST)
Date: Thu, 21 Dec 2023 17:16:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
Message-ID: <20231221151607.ujobhh4aet4obxdz@skbuf>
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>

On Wed, Dec 20, 2023 at 07:35:39PM +0200, Arınç ÜNAL wrote:
> From: David Bauer <mail@david-bauer.net>
> 
> The MT753x switches provide a switch-internal MDIO bus for the embedded
> PHYs.
> 
> Register a OF sub-node on the switch OF-node for this internal MDIO bus.
> This allows to configure the embedded PHYs using device-tree.
> 
> Signed-off-by: David Bauer <mail@david-bauer.net>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Can you please not assign "bus" to ds->user_mii_bus unless there is no
"mdio" OF node? We don't need ds->user_mii_bus populated when it is
described in device tree.

