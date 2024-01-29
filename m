Return-Path: <linux-kernel+bounces-42734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D478405BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A645283B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1D1634EA;
	Mon, 29 Jan 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8q0z7j8"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DD629E1;
	Mon, 29 Jan 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532767; cv=none; b=OrnvjJiTqRc55rcezKpy95NTimPaa9LIUERrk2gBc/T52CiFWLdeZFDef5ZO46yswbe4dCcTONmC9WDwc+EzgqBHbxUaOLtWiVgncpX8sqMu9S8TsBe4BJVpfDqWthQ18OHfSINBg2SJa9IMSt09ew+AKM99NvVNFHWQHk7RJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532767; c=relaxed/simple;
	bh=km4zzHCmyYIUYlVLRRXqA6v9RwUyR2+jwg1Lubr/1JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFscUW1ZX1ozxPpg1gIuEjPydikynIFmfZk61v0rLgs7yXaxa04gHPHq6jO2EmyXGmRsTuXm6RoMe/oXnONsTFQJDDJcxdnaKohQuhwHjzeN1vK7yJ9uKdLnq0yY0NOs5SJCADuIegnXrRM53+p1z1a3wcbGQ4fIsnOv6jlbNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8q0z7j8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so2541491a12.1;
        Mon, 29 Jan 2024 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706532764; x=1707137564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wh5PJX6dWm7kSDwjmqjlz8KtwMMRblZ6e8LLH/QNoIo=;
        b=U8q0z7j8v0vckkUhC998/pQCZV0bzqSqvCjV5h0T9NMzYELaft5Gn7CSXVitvYKM4B
         PhKZAfSjMYJOwT7qzy0buPNqP2DAbhzgqaO3j3QjpALHl0DxU6opQn5LL1ZLEAOhViK3
         yEf3hBvyfzViR8qiqgSF5UqMHYhiMTH/trKPL9YBLIMtncBV5Tw8NO1DqTGOkAmilWnH
         WnP4XUNArbm6L3cF7wq41A6Dews83WtMjqlCsH1ep5xKCbmDH86KqVJ+VEiii1fCvgb2
         8OYZdkKK0zbU2O3fIzD4TGazXbINyUpUpCGFa8PuxPfPk+gXAni+byqRPKpNwSR+jdkH
         GfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532764; x=1707137564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh5PJX6dWm7kSDwjmqjlz8KtwMMRblZ6e8LLH/QNoIo=;
        b=erMyaywMoHHCcTTxGdbC0qz48WQfRd/FOWDGaRdkd8zJgNV948CVenT9AQLXUfpojh
         12pEV54aoZPQrGsN4qPeY/15wcdQkEKmB7UZOL+VsYepDiPB/1v+2STxEfcO7M5NbOHx
         I/MmnJ+baS0TlTy8H+sc+drAf+YoJG2lqnV3saF3lLIOmIUNmW9Hp1ltMP9+roYmDJru
         Zx4iU7kUmjAh8c11mM45KhfaV2Nx94STbtoiukkOcS1c00CyU43Mbs5e54V7n1F+G2qV
         nKPGpx7FpfB7KtwPXIKxIh2iF9qGs7WS3ikHNVIvsnFM6swsATlPvmHffNVgjscTCIsd
         iGSg==
X-Gm-Message-State: AOJu0YxW+zk8YCaKtRsxirTAvL0x48ZvkV9bUGgLO4EOVxyEg8Xp+Fkg
	7DiSrjF9xrcnEp6agepXHNVRYVSEyJH4kPDNzDXdSOgaCzQWxLMfJ4LqXKFg8dA=
X-Google-Smtp-Source: AGHT+IGbC5F/QL2xZapUcYogbDNebCDs/L/gjri3hScnNm/4bpqmoUfd2F93xmirprhA8WNJe/FXiA==
X-Received: by 2002:a17:906:a45:b0:a28:fec2:ca17 with SMTP id x5-20020a1709060a4500b00a28fec2ca17mr3525460ejf.0.1706532764054;
        Mon, 29 Jan 2024 04:52:44 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a27a32e6502sm3847552ejd.117.2024.01.29.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:52:43 -0800 (PST)
Date: Mon, 29 Jan 2024 14:52:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
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
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240129125241.gu4srgufad6hpwor@skbuf>
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>

On Mon, Jan 22, 2024 at 08:35:57AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Running mt7530_setup_port5() from mt7530_setup() used to handle all cases
> of configuring port 5, including phylink.
> 
> Setting priv->p5_interface under mt7530_setup_port5() makes sure that
> mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.
> 
> The commit ("net: dsa: mt7530: improve code path for setting up port 5")
> makes so that mt7530_setup_port5() from mt7530_setup() runs only on
> non-phylink cases.
> 
> Get rid of unnecessarily setting priv->p5_interface under
> mt7530_setup_port5() as port 5 phylink configuration will be done by
> running mt7530_setup_port5() from mt753x_phylink_mac_config() now.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I hope this moves the patch set out of the 'deferred' state.

---
pw-bot: under-review

