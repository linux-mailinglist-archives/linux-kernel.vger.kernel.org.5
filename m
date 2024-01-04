Return-Path: <linux-kernel+bounces-17340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801EC824BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7538E1C222EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3C2D619;
	Thu,  4 Jan 2024 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anfkpvDO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D702D604;
	Thu,  4 Jan 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28bc870c540so812126a91.2;
        Thu, 04 Jan 2024 15:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704412244; x=1705017044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXXgiy5l7dsn5zZazPKFMICjA/EobvOaiGmtDGKooKU=;
        b=anfkpvDO73qthMmAFTfJpTklWgeY3B7fajBXY3cHWP9+HM8EOw3r6K+EGjAIbh3ubO
         m8yS4njQbuk1LRdhafExcTFvJwpB5saVK/CptqkR8vxW73T6A2EBS3BXZ/puW8ZEjsBU
         3iXyDftyYC2L8ZRTWm1iA/t/4hylZFEZpvr4+zunOj1jgq7H8sDREpjhnuQX8s5XpQXs
         zNnCtvZPaKDbULOQO0u10c8vaRzwsFGuBwZW+plpPR2+czRHvP6ojS2a49k7fYPNZ8bn
         e1X0IWZ70UFwNElUwRrMnk0j+bIRwu4ZKLTJJzApccems0zOB06WUuAvduxhGIiW0i4v
         4PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704412244; x=1705017044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXXgiy5l7dsn5zZazPKFMICjA/EobvOaiGmtDGKooKU=;
        b=KHtXXzlfb1Tp5YbSBkIiUD89/OJ79lMCNgOupB8iUHy/MY7mRjmVPNLLWvbAtXSy8L
         OOVLLWwz4BHePScILtRwg6cPEMtB4Kr3z4PkuiHVdqRAztc8bfXWJ9ehQJUgHaaJI36b
         fzC2E35fX1B0i5tp8OYN/nPQRzK6308wKtADiIU/5ZDRjStR0Lu1CxNbWa1ITnQZSoOQ
         d7SKTg0pVOSZ0zqf4F2sZrZuVXAvinERPM8lUP931odnlHFSOu6KmpeR64EZJEVP3es9
         983ps84iJY1h23hPozUBRberMn3dwrIeDel180xJESM3ZUkrMeybcIgRdTgjTMX7K/DO
         Eczg==
X-Gm-Message-State: AOJu0YyDqvFZy0SLgbJv79ltIMevCyoIqWeHrdCrkDBMGJc970toGAXd
	v1fMMRrltoD8+1/HXHkKFTc=
X-Google-Smtp-Source: AGHT+IERz007exQ7MK7uKHw9u+YJxijfySORJ+qKi5+CbhkSrIwGM/eYRQLHVEQvj7f1JAdo7Fuidg==
X-Received: by 2002:a17:90a:fb94:b0:28c:5391:7683 with SMTP id cp20-20020a17090afb9400b0028c53917683mr1207245pjb.65.1704412243933;
        Thu, 04 Jan 2024 15:50:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f2-20020a17090ab94200b0028afd8b1e0bsm4222012pjw.57.2024.01.04.15.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 15:50:42 -0800 (PST)
Message-ID: <1447ce09-f90e-4ba2-a6f7-e5cb23bf724f@gmail.com>
Date: Thu, 4 Jan 2024 15:50:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and link_topology
 tracking
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, corbet@lwn.net, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
 <170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
 <ZZP6FV5sXEf+xd58@shell.armlinux.org.uk> <20240102105125.77751812@kernel.org>
 <20240103153336.424dcfe3@device-28.home> <20240104154721.192694a8@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240104154721.192694a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 15:47, Jakub Kicinski wrote:
> On Wed, 3 Jan 2024 15:33:36 +0100 Maxime Chevallier wrote:
>> I think this could help in reviewing the overall design and identifying
>> any glaring issue with this.
> 
> The netlink handling looks a bit wobbly to me.
> I commented best I could in the 20min I had to look at this code :(
> I think it'd be best to revert, if you don't mind, because reviewing
> incremental fixes will get even harder.

+1
-- 
Florian


