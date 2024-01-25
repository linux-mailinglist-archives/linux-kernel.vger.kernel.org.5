Return-Path: <linux-kernel+bounces-38267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B480783BD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD97282CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30221CAAA;
	Thu, 25 Jan 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRVpUuTh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018320B27;
	Thu, 25 Jan 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174955; cv=none; b=bG3nL2Sj0cbSVnZ2Yh3t2MoGHx8CATt0UWMRLTxoKyet7EoPqhJ+IimjiQZIoVetZ/Jmw8ZrFg4IpqB6WAvr7ZZx+fALXxDnD+IaQ/GhNHvSF4qvoVwH2U4sPxlG1PoIcmTIrvdLIhWZNV/aPSzBe0nU2jtWGmZc5D1fD3EEuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174955; c=relaxed/simple;
	bh=f0WH8mYyehhGdFrch/FhoI1euWmA1llvn3BltzJk/c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3x+zxAkBTVaTjVIEYBJljnSlPwZJDz4UTvVPCpbv42EIXY1fgstRi/u6kE6O3aDMs4jGp3VhydzJo4ttUCU9LwTctGmYjO/NZghbTlfwpo1DgRGF6gjOGglfDP7FAGJ9l1J6uhAc0huSCmimZZ1TRwOjntW/5gdbgqG7A1A+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRVpUuTh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3150c9568bso126109466b.1;
        Thu, 25 Jan 2024 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706174952; x=1706779752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORIJE9f/z+ZprW7cvU+93rl1XYAcpcHTZAoKwb7UAN8=;
        b=VRVpUuThNJrDjTYgKf6vO22YIyZi+oNs8Y/jqx0xQf96QSswiUub3hJG63p06DlX8v
         EmvMHGvEB37jDTYF7PvQq+iikUD3QQw/DUltsUdnvu4cKBzPZ3gg6un1Lt7wvaqSegpA
         1CXgzBHQppJQliXm7jFV6+mhH9iAITVDftAahi07l6IgrGYPNVCUcrRqXlUIp9RS7OnW
         jcJ4GcXsxUMxJ2FhQxIv0MHQJ9g71D5HHHVo+IgsEM7+v2Pi13ctjhQbwqW8towHszzl
         kcq0a01w+HmCucr6pgiSfXKsaj0PmOYiFRXW5A7n5nagU3hMhvTcL/VuNEC0qbY2JRq3
         bNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174952; x=1706779752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORIJE9f/z+ZprW7cvU+93rl1XYAcpcHTZAoKwb7UAN8=;
        b=k+OjBXCswDRZ1Izo2FcLf9TCeO5gItTmFkoWCl8phLhbnECukWFma0wsgbuhOnaMOu
         88wNo0a0pyCPA1ZkNunXMxImx6YlWgunmQD13q5RnpzkNq56VDa7ooT/1O69NV/ti8nl
         31XGvUq5i4E0mz6Q0oKUi6AErFgq7bN4UjG0Yf+3Q3fpYaP3qFs3JvenVziYNnaeihfE
         aPl48C039RcrPoYR5TEKtfZiPKDXM5TvP4kXje6kQphlzMchQKWVfjuppC7v0ERbGpIy
         II+7MkWjLexzbBBToqw0NJ5/uEW7vzUhXIpqsuyLPbqJe1YkaJOoxI08yYAnDQMJbc5l
         Hfog==
X-Gm-Message-State: AOJu0YxqbCz0I5nJJm3Xezv/UDhqFnp2EsrEPEXaynA934L3N+uFTeli
	heoer0QctOz4SbOlxSt2qf0e7q0Tr3QbEfRQoKMvB5mMZmrjqOAl
X-Google-Smtp-Source: AGHT+IExWFNGCj8bFUwy2D2zj58GEhzyTbrPM9rW1Uu9Oo1+KTW3AUkCmUyW46u3+HQvCsrrPWXfSQ==
X-Received: by 2002:a17:907:9387:b0:a28:c8bd:fbfc with SMTP id cm7-20020a170907938700b00a28c8bdfbfcmr224236ejc.215.1706174951457;
        Thu, 25 Jan 2024 01:29:11 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090646d400b00a30e0f7b4f3sm822210ejs.31.2024.01.25.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:29:11 -0800 (PST)
Date: Thu, 25 Jan 2024 11:29:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: select MEDIATEK_GE_PHY for
 NET_DSA_MT7530_MDIO
Message-ID: <20240125092909.exaisdjkkgmc5fue@skbuf>
References: <20240122053451.8004-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122053451.8004-1-arinc.unal@arinc9.com>

On Mon, Jan 22, 2024 at 08:34:51AM +0300, Arınç ÜNAL wrote:
> Quoting from commit 4223f8651287 ("net: dsa: mt7530: make NET_DSA_MT7530
> select MEDIATEK_GE_PHY"):
> 
> Make MediaTek MT753x DSA driver enable MediaTek Gigabit PHYs driver to
> properly control MT7530 and MT7531 switch PHYs.
> 
> A noticeable change is that the behaviour of switchport interfaces going
> up-down-up-down is no longer there.
> 
> Now, the switch can be used without the PHYs but, at the moment, every
> hardware design out there that I have seen uses them. For that, it would
> make the most sense to force the selection of MEDIATEK_GE_PHY for the MDIO
> interface which currently controls the MT7530 and MT7531 switches.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

I see MEDIATEK_GE_PHY only depends on NETDEVICES && PHYLIB, so it should
have no problem being directly selected by a driver without breaking the
build by causing unmet dependencies.

I also see there is precedent with CONFIG_TXGBE selecting
MARVELL_10G_PHY, CONFIG_R8169 selecting REALTEK_PHY, and others.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

