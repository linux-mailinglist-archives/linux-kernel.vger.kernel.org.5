Return-Path: <linux-kernel+bounces-96764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADA87611B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A182829C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789D0535CA;
	Fri,  8 Mar 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTTumhS5"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD526296;
	Fri,  8 Mar 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890967; cv=none; b=SB07GdZ8GgxblaHUS7roqTk7KJSNkxJLU1GVcmCiquWeS81lpeKrakpOde0XxGDijJOMRuSk9pjO4akZa9f5bRhlXyl/+Dk8HFib6fhAT43NQORRnNazw3ockr9S57M6+Fuy514OXtmbJLVLcnsxb27l/m5qx05uspQlljhAbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890967; c=relaxed/simple;
	bh=2XguDX+eb+E30OJtbj6YkSePzXzPfNL6xC0lRsdkrPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCgXGk1nUgYQwPSGkr0Syi9No9HWRsmaiWa9Om54cbnduXPGbrFEfQcUYAYWqhr33tqKVWn1gfsWMm04t8jmJGntMoK0OoRdsJuNDSwifKEW3IEhTaAgP/i3TBZNMZkfWDfDP7WjP3ATuASc0h17/CnORppuVz+amFrOMZWg0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTTumhS5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so2234006a12.3;
        Fri, 08 Mar 2024 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890964; x=1710495764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9SPiC0VKHbOOYDIw53rfq3rdbB1slUM7uRNpzQd19Q=;
        b=LTTumhS5fMjkdQyV5GfLmnnF0TaBLwU0WnrKuJ97FSXKvighwAj8EVaciInmUkru3a
         Z7xBMQzGupdWiKrCzqK33Ii7L3MMJkLZXUsb7kWNqzQgDTmiinRSOPIxueRpWMEfRq6M
         kRhUaoc4TELgQyAiu2myofHd4reDUlrKVrJF/tqBL8tJ+y7htrS8HUBNOSOZzeY9+tSb
         u3f53rBU7mnAdGzSe0cNZm3ZHT20+Jq51FwwqA0Ecw/VGB1B+8N24VNvhfzMYGS8/FmW
         WO/on7Udc4LvE9YdnhRaVMM9d2XW0u23ZIcSdOB3FbGrQNqa49POa1X1JjtoUsk6+oQz
         PxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890964; x=1710495764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9SPiC0VKHbOOYDIw53rfq3rdbB1slUM7uRNpzQd19Q=;
        b=r8+W4TM0xlavUnoGeoKQfygK6Qe+noHpklSgB+1d21qveuLTwWWgbg7vpiLUl/CQj8
         5q/grS43GkEiT7Dqre9sLMFLpfPbMHj2XoRbqFiZ7zby6Ca1AaAuFeu4w1+BOVxRxryx
         3Lb6vZ696AEjajcoyBhKYdlVQE9sek2FfFzW1mX1fXK1TU1N95mzeJDdZeN4kdbg2Rlv
         VantXuIAKeKU+naPs84Uccucoz7GKBdXIlEUojkx78KWeX4inEu+M3vuW2Uy9dZBRFIv
         YDHpObBByvX6YXP+tLL70GA9vb3p51SwJkRN4AOsg2WpU6kUoH30yyIfbQ/l+ky/lxtm
         IFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaKhJTMlf5+NFFMqQdJvOy43OrKfJ8f9qffg4cVcnmlxKM0GvMci9zIgcQimyAxsMAUhYxaOvY50qIxQDlXNqXlwB1I/WvjZ4tTbfX
X-Gm-Message-State: AOJu0Yycyb24S1cra2zelbGsx92302IA0MeSAJCwqKjXnicQbXeIRiUe
	ARWrGPcEnuS6caqa3HEAqlZUMBljXtCARYzlYjec3gaOxyRWZOZXAdBPFGRFeXM=
X-Google-Smtp-Source: AGHT+IGqmQtiUOVbCzz6Ijy9EOu1jg+tri2C4oDCVMGUviDKy3RMOoO3jD+njEvnhPRCg1S0Lsusbg==
X-Received: by 2002:a50:870b:0:b0:567:a37a:4c95 with SMTP id i11-20020a50870b000000b00567a37a4c95mr1291318edb.42.1709890964331;
        Fri, 08 Mar 2024 01:42:44 -0800 (PST)
Received: from skbuf ([2a02:2f04:d207:f600::b2c])
        by smtp.gmail.com with ESMTPSA id q20-20020a056402041400b00567f6310010sm2462069edv.59.2024.03.08.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:42:43 -0800 (PST)
Date: Fri, 8 Mar 2024 11:42:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 16/16] net: dsa: vsc73xx: start treating the
 BR_LEARNING flag
Message-ID: <20240308094241.iobnxcesoadzuo7w@skbuf>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-17-paweldembicki@gmail.com>
 <20240301221641.159542-17-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301221641.159542-17-paweldembicki@gmail.com>
 <20240301221641.159542-17-paweldembicki@gmail.com>

On Fri, Mar 01, 2024 at 11:16:38PM +0100, Pawel Dembicki wrote:
> This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
> which are required for properly treating the BR_LEARNING flag. Also,
> .port_stp_state_set() is tweaked and now disables learning for standalone
> ports.
> 
> Disabling learning for standalone ports is required to avoid situations
> where one port sees traffic originating from another, which could cause
> invalid operations.

"invalid operations" -> packet drops

> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

