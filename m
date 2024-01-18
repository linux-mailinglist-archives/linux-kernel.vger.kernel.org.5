Return-Path: <linux-kernel+bounces-30427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0303831E81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EF2282F99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB72D054;
	Thu, 18 Jan 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYIZixZ6"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605692C6BE;
	Thu, 18 Jan 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599381; cv=none; b=JpmUBe5wp7q/4PvCZxerPpBdhhSrOD86w51SEcr1qeLBTd3aRKdZtGvjTNE1pgIHzpEZ5ti3w9RFzJyK0ZslkvRY7CYbGmoVULQ/vyyEeqTuZKFWS4C0hNV3ub4v4nyg6q5jMMhs3qe8OS2A/fl99QwZdetNKpG/U3fZXfGSv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599381; c=relaxed/simple;
	bh=4WFBD5HhbGwU8vRctSL7dhXyQ/b7Rp0JfOUk7JeiZCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type; b=bR7DGB9gEErcyPTzwGOihTxXav+iby14t6KeSbqmS1JHTCjBtoqtS7t+FUSOmQdBIczDHhqjjc1lmEke5OpseY2z5nGh8RpExaXsY6BTHP2i7QOnt3F7f10JI3ARiYcSFGpjB8jF+70fCROWzs4iTBXZHXA1fuo453Esg7YdwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYIZixZ6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so14776159e87.3;
        Thu, 18 Jan 2024 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705599377; x=1706204177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3UVTNpp1vYpsDn8498+yqKGdCxkhhTVd8uNrjyYcDSU=;
        b=lYIZixZ6aQRWGvzYlXeGofr/RcXlm9Q5tLMk2dOd7daHw570uMw7sCqqxxgXzhPhqM
         uuwQyWI9k7JDz6sP2db/7pLda2mmjQn1bUlJWngVGxyn8e8Dl1rEKvk+ulGZLGXenepA
         YHvj20uHN10pCXL76PZlM887Z9zV9wcpZ50RB/OtHGWjUOFBeJraVd5Yg5SQVVCWrGF6
         mz9ImO0whJtK/uxCw2AUXKJrUtf0N2PIwn0aOclSjZZkYZMV4qLU3RYChJALnAz6k6kD
         jO+QM/g0K6MVr/wcPmzFO7PMBItYSelnacimUBG6odk3w0HVrm4Gf9xj7mG9UoK5BQDu
         WBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599377; x=1706204177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UVTNpp1vYpsDn8498+yqKGdCxkhhTVd8uNrjyYcDSU=;
        b=TiDZ0GmMh2vd424pb9wNfSsi2JgJdr7IVtLpFKxn2Tmi8wF0NZPG5e4ZgVNxdTYbLx
         FxARAw3KwZg4Mj4OT0z6c5KpezVsfOVVk8VOpqrASSfiQVJy72pvrP361mcdLmQSMbBb
         klaIYKV1jrL7J2wI6NGySwJxRlmX2hZ9H0f6yqXaQHgSOkwM7nHSTyiO8pFBfDOx9bIJ
         b/j5aIhde89z+BokSmEnThgLmV613kfVBlZTCmPLZHzlqYFLgxVIAgF5Ig36ViDJzWYk
         bnODiBGFYbsgQmLFHtKpNAnhL4BNghsv4DebyBE2Nk5uhz5n4og5StStKQ9nNayUZv49
         zpQA==
X-Gm-Message-State: AOJu0Yx7ityvpaKsBZ1u/5/wUmvvjrv3VRweBeonLXMJH+vNZWszYpiM
	t/kOaadoPOR+Vcd69ZhARC6HV6qmNLodgi8FfhDBWgShMBRQJ1nq
X-Google-Smtp-Source: AGHT+IHr4VD8pSPylUUoqB9EX7IuFH/UL/iXrti/3+QWqWMmMvwN5hQiVlE9VzIHzXLsW/Vy/I3hJQ==
X-Received: by 2002:ac2:43d6:0:b0:50e:7a9d:bd21 with SMTP id u22-20020ac243d6000000b0050e7a9dbd21mr435833lfl.191.1705599376967;
        Thu, 18 Jan 2024 09:36:16 -0800 (PST)
Received: from ?IPV6:2a01:c22:7bf1:7700:512:7071:c9dd:e8d5? (dynamic-2a01-0c22-7bf1-7700-0512-7071-c9dd-e8d5.c22.pool.telefonica.de. [2a01:c22:7bf1:7700:512:7071:c9dd:e8d5])
        by smtp.googlemail.com with ESMTPSA id th7-20020a1709078e0700b00a2f48a43c3esm378895ejc.7.2024.01.18.09.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:36:16 -0800 (PST)
Message-ID: <727d83ab-3315-4b5c-84da-25f8ffd6aca5@gmail.com>
Date: Thu, 18 Jan 2024 18:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
To: Andrew Lunn <andrew@lunn.ch>,
 Andre Werner <andre.werner@systec-electronic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
 <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.01.2024 17:53, Andrew Lunn wrote:
> On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
>> If using ADIN1100 as an external phy, e.g. in combination with
>> "smsc95xx", we ran into nullptr exception by creating a link.
>>
>> In our case the "smsc95xx" does not check for an available interrupt handler
>> on external phy driver to use poll instead of interrupts if no handler is
>> available. So we decide to implement a small handler in the phy driver
>> to support other MACs as well.
>>
>> I update the driver to add an interrupt handler because libphy
>> does not check if their is a interrupt handler available either.
>>
>> There are several interrupts maskable at the phy, but only link change interrupts
>> are handled by the driver yet.
>>
>> We tested the combination "smsc95xx" and "adin1100" with Linux Kernel 6.6.9
>> and Linux Kernel 6.1.0, respectively.
> 
> Hi Andre
> 
> A few different things....
> 
> Please could you give more details of the null pointer
> exception. phylib should test if the needed methods have been
> implemented in the PHY driver, and not tried to use interrupts when
> they are missing. It should of polled the PHY. So i would like to
> understand what went wrong. Maybe we have a phylib core bug we should
> be fixing. Or a bug in the smsc95xx driver.
> 
Seems to be a bug in smsc95xx. The following is the relevant code piece.

ret = mdiobus_register(pdata->mdiobus);
	if (ret) {
		netdev_err(dev->net, "Could not register MDIO bus\n");
		goto free_mdio;
	}

	pdata->phydev = phy_find_first(pdata->mdiobus);
	if (!pdata->phydev) {
		netdev_err(dev->net, "no PHY found\n");
		ret = -ENODEV;
		goto unregister_mdio;
	}

	pdata->phydev->irq = phy_irq;

The interrupt is set too late, after phy_probe(), where we have this:

if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

So we would have two steps:
1. Fix the smsc95xx bug (as the same issue could occur with another PHY type)
2. Add interrupt support to adin1100 as an improvement

> Please take a read of
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> Patches like this should be against net-next, not 6.6.9 etc. Also,
> net-next is currently closed due to the merge window being open. Its
> fine to post patches, but please mark them RFC until the merge window
> is over.
> 
> The patch itself looks O.K, but i would make the commit message more
> formal. You can add additional comments under the --- which will not
> become part of the git history.
> 
>        Andrew


