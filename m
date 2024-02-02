Return-Path: <linux-kernel+bounces-50160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5E847516
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0A31F2C9BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E0148310;
	Fri,  2 Feb 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLdvH4a6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72E1487D2;
	Fri,  2 Feb 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892039; cv=none; b=EiEJ1pHApLAB5lbdHW4PnV6NwIItVKAbk21M9fdrb+SpovT1DJHCPh5OfChTQdPxnFyGMtv2fnIyWOCecCraLhRhiaS/+U1S3jmNVQIim8D0ROhxt46z+J+PabJ8fvC5KM3H6l6ESUdlx/xtCgSuv8v9WOeN27pUZldgzfTO1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892039; c=relaxed/simple;
	bh=EJdVqZHyaeVBVbZsCT5wHRQ9Y9xPWRSxktB1QQunJrc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR9swqsK2PDrroeNX8rfY9cMAYuQRlnC6RAGfIUfndsA1pEdFo8igGmqELL59QKClIyjaJFsfP6/UunB0mIGKlawjzg7dZs6kxj0V0cBNb+rpDONfY342bz8zPtMcrWyH9lo/YjDYMOvBWBNTLf3eWnSh7npg046w3DV5/8Eqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLdvH4a6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b1d7f7366so664476f8f.0;
        Fri, 02 Feb 2024 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706892026; x=1707496826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pZFlhhe4zWx6ExPhhw+BtDG2clo9J0u43UJS10RBEnc=;
        b=mLdvH4a6iJ5Flj3ZP/GAeA+ckSWOfs6GEdYUx4LUyYFjHEoqtb8Ht1eMyW7zQkj1tQ
         iPcxSj9cmwrkZHVo8Eez56qLYWytygVjMt4A5/fMeOmb3RgiWkBZ5JLvJuUWXWcsOLtL
         uFIskSsb54PEh1ykxHbq34kLEv5V3KVG85+vm6DxSfwLoESkFozzlCdkZ1zOao9PkJmf
         SOIJUjyPDmr3hZJjnWtrEgTnj255qGkdsqxAn0CyAV3hOZBQ6upB0EIbFDQYtqAndJnI
         bf5ZW9bXgdCL644sJ6yXFL2qv8QDTaAVsfN8/Taue5Sxs5xNfVzSNxHHabO9X4gge9l+
         mB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706892026; x=1707496826;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZFlhhe4zWx6ExPhhw+BtDG2clo9J0u43UJS10RBEnc=;
        b=ZzoF9LxYMb64svuTXFIkxzq1zjJdWS2BnkmsaGt6ShoDLZjhuDCqXYVlIBKa/cV8lm
         oIwXRPyoXSpSnQwFHanF+n/FehUPGuOJ4H/hKQezWEXODZWekZkRT9a03LlfD0hCr1Yn
         LYumk+5c+3fiI6BHAz1E2xlpGfnIEdhG/0Y0+CtYxk5/BrPTAIADqD70sUSOYCvxBvN9
         W7i6LOArFlFbBi4PA0g7DALsFDc0HpJcegUaOKoHikMa//SCMz0eg4ql2pAu59zmxhRO
         1/lw6GJWbvFV4rNsvg4ubTZX90k1Q0p/9zFg6xngwvT5mg+Op/02Ui7TckXs2yn4UQkI
         TMsA==
X-Gm-Message-State: AOJu0Yzyb8WdAgu+jJ90urA2ee/OgNlMbn3DpvdSBY51bdreEwLh5SUG
	okUcGOAuZx11xykenFIAcm5BUxSGe25S5qE0xhNw/V5bcOmEQ+2p
X-Google-Smtp-Source: AGHT+IEIV5cn9QUrhx512SeB6+0y2Nelj2xPF8vogvWzw5yusgq5oO9kJQTZk4Ba2sBTgWl//LXuQg==
X-Received: by 2002:adf:8bd3:0:b0:33b:1466:581c with SMTP id w19-20020adf8bd3000000b0033b1466581cmr1617831wra.21.1706892025530;
        Fri, 02 Feb 2024 08:40:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUUVXLCOUkodwKl0dXXZMcKoqboi0fVyaNgS3xcTPO4B8kvFzUy2bbDWtPhkz/aDKFYdFngsdoU6paBVlhD3v9NB6lIzYkOpzfTaLoLf11MO1qDWG9EAYtZLh54waE4XjXJa9EyreqnAdSBUI7j8UfRv8xvyl8k4e3Yohofe0ONjdAbo8zh9FkYa7TYwShP8M5KZ56bpROIhG6W+Oh+3JxO2TxnhDYiTGouxsp3s+vUFduOrrEzf/9JEqyUWof2iIH2LEXrwc8ivEaEjq6lM0MHLAjitP/LW9e7BOZxyK7fzpDH1SragBvjO3a54ipT1td1VCvAweQTsUcxtjuXC6wqraO4zEaCA2+JiPnMYchwNkdJotUu/sk6Ni4Hnpc+PglAk/3WmejdaWHE8mn7RbIz5ihILuScFFD3RMY5T+RJv55XHMEg4ftLKPOJLWFfFAbZbF0YvLEVe4K3UCbG+ITrcuAOUnSavZgoGIx5ZTv/q2BkGk+gtyhaZnN4AgB2prZEE6yBm+aylCrxbQEN9VzLkR2hM7EqalKdJUi7DylXmToOTUEyVKZWN6ryHRYGU/pxjA==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p13-20020adfcc8d000000b0033ae4ba8ca0sm2251324wrj.82.2024.02.02.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:40:25 -0800 (PST)
Message-ID: <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
X-Google-Original-Message-ID: <Zb0a9a1XfRJmtGlN@Ansuel-xps.>
Date: Fri, 2 Feb 2024 17:40:21 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 9/9] net: phy: qca807x: add support for
 configurable LED
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
 <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>

On Fri, Feb 02, 2024 at 02:43:37AM +0100, Andrew Lunn wrote:
> > +
> > +			phydev->drv->led_brightness_set = NULL;
> > +			phydev->drv->led_blink_set = NULL;
> > +			phydev->drv->led_hw_is_supported = NULL;
> > +			phydev->drv->led_hw_control_set = NULL;
> > +			phydev->drv->led_hw_control_get = NULL;
> 
> I don't see how that works. You have multiple PHYs using this
> driver. Some might have LEDs, some might have GPOs. But if you modify
> the driver structure like this, you prevent all PHYs from having LEDs,
> and maybe cause a Opps if a PHY device has already registered its
> LEDs?
>

God you are right! Off-topic but given the effects this may cause, why
the thing is not const? I assume it wouldn't make sense to add OPS based
on the detected feature since it would have side effect on other PHYs
that use the same driver.

-- 
	Ansuel

