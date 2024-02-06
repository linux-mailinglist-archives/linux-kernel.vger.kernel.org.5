Return-Path: <linux-kernel+bounces-54711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A89684B2C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520EE1F2270C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F22812880E;
	Tue,  6 Feb 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjSkPEda"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2B1EB31;
	Tue,  6 Feb 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216655; cv=none; b=Aa+8F01anDnmmDQn4W+/WqJyWwZrNttLBQCOz8B1RNpNAvKPU5C9ktqPK+/YUoa+uIDTcRQjBm+ONqq+HX48ZiLDCZmGX3aVCdG/LwZgVuHo3hCCM1slDkhXDp/fOGj3As7Bp7BxADqLpiKKdBHJD0Lzc4g10zChuLm/+7U/Y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216655; c=relaxed/simple;
	bh=GCu0VtJyZuEu7ZGNVEdEbLLuK7Sy1w6+vFnzALv1IlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJs0WPF9o4SHvs+6t3zm9A6WYQySKDLnlfvXTGX/oxVNjZIrqZ3DEtR10VejdZ0TGV0OGtTZjcGDKIm88Q+mCZkcQg1EadYvQcacf+Br3hzvice+E6H8fLxAY8PMFcPF2fKvkI45/GvNx3rd4CZGR2PvkyBuUgZxs0jOFBlAIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjSkPEda; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so751206866b.1;
        Tue, 06 Feb 2024 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707216652; x=1707821452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qnr+GJSNInkqH8X1ju6adNgWnWatfsE0zlg3RODTQs0=;
        b=OjSkPEda+DVp9HAxCaLfByNC5ZjSfvaGRZb0grHLBOZ4S8Q30VvXdHuU2fthZmncsF
         u8VLFsjbaSfxPIxAJnATnUkiGJNFMUIDLu781ttK8U36cDKh0kkYEE9t1DxuMb2OeUmV
         v9ylWTCxbczlbUvw/FRQI0VNEryg205vc0Y5mpRX8+RXavcI9WTS2dd6FUn52wPjgp1b
         rw9gHAOz+UZDgOSwyEtq0rEcQ3nWtfQA6njffMIEqP622XejyvewhE6TAmUjX6D4RHHk
         4sofs4GhQ0mh7lTD/tTst/1Jx3xJjzjWq7g9TgkkgLfMriTvb0M+O1y9Oaq+d7Tv6OX/
         WYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707216652; x=1707821452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnr+GJSNInkqH8X1ju6adNgWnWatfsE0zlg3RODTQs0=;
        b=JnKi+rwKlQpJ+85DFHWs0Os8Ru7EdOByDYXhaAnCxZAyWwfKr3CT8y7jJauY7QBcTE
         giCGetEkqQfY1A/gJ2EDMa9XpXNhLGKR2lpUOmaEv5hzVkCfhf1YI9Q08fTyNr72BP2q
         SLTfV2sXKiXDdLOSUqN649Nld6aXcpM+ByuYBhRfMr2pE8zVyItCSriAL+3bwoTnWAHo
         /Rx3lrQvDSj+1d/s+MmV1hbfLtYJsLWeRMWo0k7PPwTwrHbCdKPU+pVpYtTVp2exxWRV
         +UxPlqRUtyCVs6LvAAgb5tSgbA7zaqvHN7q9s3ZvceKY3QSvnah0s0cvwjzFzE4ytGJC
         ue7g==
X-Gm-Message-State: AOJu0YyyLT4oQ74gYOLKW/ojaE+YwuNKvHXwSFh1mbRQw7ojIKkbn9iG
	vzcOsQjJ9IgqoFFJMYPgRheJ1wQzYT5uo81g96DojZylIa02oTX3
X-Google-Smtp-Source: AGHT+IGlyLnVmMDl4xqY5qb83VRU3kc5wfWmjEfNRhqjThSnjCoW6EWAUgKBfbGftyvqOnAb7icUHA==
X-Received: by 2002:a17:906:31d2:b0:a38:187a:3281 with SMTP id f18-20020a17090631d200b00a38187a3281mr1130431ejf.70.1707216652035;
        Tue, 06 Feb 2024 02:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXg8riI/jLImZaU3s8trcrVtGeKUgOV3x8PYnmnuZhpOy+Hd0AOAwpieFrmC3OGwADCRqmEr7ERCoi+kXlaf2qldIFMJXukxFtSnOddFGeRjjmEdGRl+IgcCCq53JgCGQprcnVA3eZNtBIU42Q36O7PL/6OrwtcFZHVDcQIgw+8RupJec1zc9dr+SRB89pbGHqd3b1eh4EUCgJ36EAE2zbf9NpTxdrF0XF9AHnqzes+EbjTZKUMJDzfgkHZEhOASukiPHv8iqZBtLnVMlVexcvcK7XtIvmxJ1thctiBez3WP9Lv+EiruQaPFm5DUZhB83wi1h5+NYAYY//QpBjo7zfhDVQfJsjJexW7aUbLEfQLrW2rmoYA2xWFLwMUE6p3pa7Ewk4Oi0jJG5Sbozolp4e9/+ZOq60aIBpOX5OqVinAEyTQYjPymMlD2a7LZYKcMpqH/EJKAyqM1fbqdmGi01f1SRAN6ZXi2aWqSTHtHgrXEgq4ytZDVLXGe3sW1d/2uyHAXPqfhsajaoBOEDPh08XVXPjptuPhsmPi1g86VO7lX4eMbHGcWDsXQ0t/3LW+x6XjMU7Btp2jX7KPnE8NAIyQ2WOVfn8JDOSYO9DJYO55Yu++/FtfXY3CSySBshOnKw2yflJmuBeNJE3P4o950tm2rNo6IkH3XaXa1dXF5kSeTqdHEkOGLhC4D78RCI7lne1/VA==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a354a5d2c39sm1005649ejc.31.2024.02.06.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:50:51 -0800 (PST)
Date: Tue, 6 Feb 2024 12:50:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v5 3/7] net: dsa: mt7530: simplify
 mt7530_pad_clk_setup()
Message-ID: <20240206105049.rldesxnyjs4dungi@skbuf>
References: <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
 <20240206-for-netnext-mt7530-improvements-2-v5-3-d7d92a185cb1@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206-for-netnext-mt7530-improvements-2-v5-3-d7d92a185cb1@arinc9.com>

On Tue, Feb 06, 2024 at 01:08:04AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> This code is from before this driver was converted to phylink API. Phylink
> deals with the unsupported interface cases before mt7530_pad_clk_setup() is
> run. Therefore, the default case would never run. However, it must be
> defined nonetheless to handle all the remaining enumeration values, the
> phy-modes.
> 
> Switch to if statement for RGMII and return which simplifies the code and
> saves an indent.
> 
> Set P6_INTF_MODE, which is the three least significant bits of the
> MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
> after reset. This is to keep supporting dynamic reconfiguration of the port
> in the case the interface changes from TRGMII to RGMII.
> 
> Disable the TRGMII clocks for all cases. They will be enabled if TRGMII is
> being used.
> 
> Read XTAL after checking for RGMII as it's only needed for the TRGMII
> interface mode.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

