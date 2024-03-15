Return-Path: <linux-kernel+bounces-104723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFD87D2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AC3281121
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670F524BC;
	Fri, 15 Mar 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar5rYbNw"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16D4F1FE;
	Fri, 15 Mar 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523606; cv=none; b=OELYjUkBJyglt8EplrtQggg7soOy0QWQaCYk42w4iWK0HglOkAQxiPNwT37mLhaMIRkP1RtNlMWMrwDziTCqGejADZMEV5ZD64Av73r1wYWB5r2/rkLOtVDhBobsEsKnaymNdodSWhFOsUK/jwR9tZBHhtAxCSuc1fmDZLnyDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523606; c=relaxed/simple;
	bh=EQA2djWLQXyJSOIGBXwtzlxj242KSY9IKWiQtTkyAk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1CocVxusd6Tl9zdi+ZvAuPm3Djvl09jzyEvOpmz7MENAFWwUS65A4PQPPbrCDisAS7UCdX0ndpq6/DIECQHHFVYKIOFDFxBBgykE3o69bqsurTfoOYbJgAWS85YHKCvF+HPtv5fh3qAc/x3pAwVV9em24y0DPMCVWmXj+DyDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar5rYbNw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso1105027b3a.0;
        Fri, 15 Mar 2024 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710523604; x=1711128404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sFjzuy7J8+w4dLV9YzHH2z7RTnEErpYFzircSGu8BM=;
        b=ar5rYbNwMsOMpZeZZjJXrVJNhUSKhY9475vVrLg0j7u8nvbbaq544729SCj8uQxFCw
         IpHzMWlw4MojAX8qQI0XLHppyVeC05ImIHSnh+dBLMIhd4mH6KTQi8/Gu9Jd+XhlOuco
         /WYpCw69mjdrlPwrtmT9nIosebyXRw8K2oxDuanWLviqZh8FzWbOJRaOfdNuoXOR7Ppq
         U/zY3L+/W1XDapNk3CTyDOWFcFYtIGZMOO97+grujVWwFl8eGCDc5q4vNfQMRVe4q6h6
         xZaaCVRj8y4yS8eZdN0APZ+ZxOrB6agyUM+88Y7rNUd/sKFvJSSm3eHcin7AmHFALX+W
         M45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523604; x=1711128404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sFjzuy7J8+w4dLV9YzHH2z7RTnEErpYFzircSGu8BM=;
        b=snTm15Za/y4t7ve9PhZHVeMve4KRkH44agDJ2tMD6KakRMcbRje2QCNfuRZhXcp/Cp
         kBrVTCY+hbt9emA/L5LE29BmijtqDKLW5Fb1z2qLwtchC6ohXrtCJlfiWhua9jhEOsTr
         9kg8S4RbHbf3mJMldxQb7gFDQZPHQwpK+ntQM0HUeXwqfES69FmpM2cuByzzfze6zs+j
         NwVCAXY2fWEX2XcUMr5zyseyLKtJl1QgCeTe7v7IKfTdL1DcYx7FJcdQTHsKw4IO1olF
         DlIG3b+acR2GShsi/sSRgESV+oOIXmxfX8P55W2Phw/dpkjqHTT523G2zC8IH16BrZBL
         bAWw==
X-Forwarded-Encrypted: i=1; AJvYcCVXZarGd0mWcodxgF/vw6bGqWFPEG4ya3GFZuRbLMr618wJfmqTcFbq0uMf8Azo7vYmR8b3eCYwjDFsLeNXtFfImp0zEljD2PXYuw1Pt2FnqM22B0ivuEeUXW3e9Ic28Y8oaYx0tTkcZQ==
X-Gm-Message-State: AOJu0YwjV7B3GsiFRk61EAvlNpgCTA0UopkdFbxED8RoiRjtlKzxLzq4
	WHXDg21Qls2mKLRjtt3zE0CXMP/wb3nw80s07LkEfPqdZzSiHNhql6e8yakEBDk=
X-Google-Smtp-Source: AGHT+IHx/Wktm2Eb4y94uYXrvycgK5Kv6k+ctHSA/s0OkYBbqKkOFZouLwcUIzdhckigvdF9YUlN0w==
X-Received: by 2002:a05:6a20:e10c:b0:1a1:847f:8fa0 with SMTP id kr12-20020a056a20e10c00b001a1847f8fa0mr7087522pzb.15.1710523604178;
        Fri, 15 Mar 2024 10:26:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t188-20020a625fc5000000b006e6f8e9ab6asm1706458pfb.15.2024.03.15.10.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:26:43 -0700 (PDT)
Message-ID: <94e3d09a-e6a4-4808-bc29-3f494b65e170@gmail.com>
Date: Fri, 15 Mar 2024 10:26:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt7622: set PHY address of
 MT7531 switch to 0x1f
Content-Language: en-US
To: arinc.unal@arinc9.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
 <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/24 05:20, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
> findings that support this. There's no bootstrapping option to change the
> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
> address of the switch. So the reg property on the device tree is currently
> ignored by the Linux driver.
> 
> Therefore, describe the correct PHY address on boards that have this
> switch.

Can we call it a pseudo PHY to use a similar terminology as what is done 
through drivers/net/dsa/{bcm_sf2,b53}*?

This is not a real PHY as in it has no actual transceiver/digital signal 
processing logic, this is a piece of logic that snoops for MDIO 
transactions at that specific address and lets you access the switch's 
internal register as if it was a MDIO device.

LGTM otherwise!
-- 
Florian


