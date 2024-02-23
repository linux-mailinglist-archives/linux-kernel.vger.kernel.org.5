Return-Path: <linux-kernel+bounces-77767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E848609FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298861F22233
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118911701;
	Fri, 23 Feb 2024 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aObkpeWi"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FFC8DE;
	Fri, 23 Feb 2024 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663690; cv=none; b=dhWVeQBM86Be3RTSijxomInP5dlZql2RGFmmFBBNwn/9RpHJTSvaa2JvXWYSEC15oMM+nS2ugytnWLtL6iHQTO4Ns1TX3qo9h/nBw6A03orahuILe6V7ODCGLh7skaWBvDO3i9uHiaTW78Kzv7kenj2Qz+/JtZsHXBQJvcwWZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663690; c=relaxed/simple;
	bh=7bhHjyonMe9PX18yfWiX0QvGsbyBCiFCSTsTEciJaNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfe6k5Pssq4mYB84wRhdt98oI+L+7DaI6Iyl7dURPpiCGz89y6/b0UF13Ayq5rEjDIjWWnPZXksoqkUxYmhNoiIv8gyKOPoed60Zf0OHMP+xfrmPJo1L9o4YK9N1zlrocsQes4zcKBdAtJW96XFa4gHTpvx4/cS7OBOsuIfpKlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aObkpeWi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78725b62cf2so22612385a.1;
        Thu, 22 Feb 2024 20:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708663682; x=1709268482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXcNF0qh6SMAktBO6OSfev2SM0LlhBJpb+/xBaQxmkQ=;
        b=aObkpeWi69a8HeaYT5lG+dFh46lx/4/Meh8OGxAFQo4mUxwuQSUcWyRh6XJUCyhe2T
         sz3akP5pTpDeaeP4nZrLixuL5hx2Y2+eRSxQ7LalN8hbwjti92ODHuSxKKkCtCXX0j09
         4epbq5qvHGaUHhNifQGR/SivYjmW0lZZLkZ4flbahzx1X/anF8PwYdQjhYAYoQEJjWXc
         u+3Rs6pWJbnp2nb84TPzaXGsvnJT5t+sdwzrfhGT9ltK/wXFt5OcjVDzDFXsKmxRP0y6
         sOLT+hanL4M5weex59Aq6f3LL9Q+msT+IDAn0/6I0e8hIyRiOxNWGVS/gOyBuZhCpX+f
         tG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663682; x=1709268482;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXcNF0qh6SMAktBO6OSfev2SM0LlhBJpb+/xBaQxmkQ=;
        b=aYdC7eBNv2OI0zFyPDuSguVU/OaVWkUuvmE0J8rMChSD3GiySD/Io+CL1Ix1j1e7zK
         oDphDI+An0v2/I3nPMBqIvWieyczFiovUUhpvsQ0rEt888sHF8EzHaAK20Fku3PVgyP+
         lTxz62VCqFFkSFRydYLGpgSZDctWpuP5jATnNlYbGzilFNHYC8CGVrqV4UeHcE5UMKwZ
         Y4iqEBPK9yFtiJHLylw4B5zNptZTPlh8K4r9py5QdOKUmYmt8Kf56w/1wmkiC5ILY+TO
         /ACk0VvQQJspl2ndX99gqAD3254PYzpTz+4Raqe8FsuXyGlXH7QrVGeAiWBAYPPuBAO7
         0gxA==
X-Forwarded-Encrypted: i=1; AJvYcCXg+3xwm3lv7MdS6weFq/wToTuiiYr97FUAQUJ3nmVTyj9dC1/jhdbWRIXQx92LPyw/ndfjZUijkeKN3tKvAHUb1oFollNMrzD8wWCiS5yYGUSkT+oA5HhG0mi87sYAOPexar4q
X-Gm-Message-State: AOJu0YyL4aZc43qknu+i/PtVR9eS6GFo/f89fPnDpa7qWO2om3U6vJ9g
	963Jzcc1sMTiAGr0zve1o5qBKDIsicZCwnx82gN4KHCT1yOY9Kfa
X-Google-Smtp-Source: AGHT+IEr9LJsAdtjO3uDMVI9Y3zXO57Z3pKxLBU4SKWH4MEnyi2n9nDdx4mYTEBYRD38szVt8QgTLw==
X-Received: by 2002:ad4:5ba6:0:b0:68e:fb17:e14b with SMTP id 6-20020ad45ba6000000b0068efb17e14bmr1396417qvq.1.1708663681845;
        Thu, 22 Feb 2024 20:48:01 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068f85706ecfsm4744800qvb.104.2024.02.22.20.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 20:48:01 -0800 (PST)
Message-ID: <572300ab-3475-4ea6-b6c9-9206f237171f@gmail.com>
Date: Thu, 22 Feb 2024 20:47:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/8] net: phy: Add helper to set EEE Clock
 stop enable bit
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-4-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240221062107.778661-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The MAC driver can request that the PHY stops the clock during EEE
> LPI. This has normally been does as part of phy_init_eee(), however
> that function is overly complex and often wrongly used. Add a
> standalone helper, to aid removing phy_init_eee().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

It would be useful to also read whether the PHY is capable of stopping 
its clock, this has IMHO always been missing. Clause 45 IEEE PCS Status 
1 Register (3.1) bit 6 reflects whether the PHY is capable of stopping 
its clock.
-- 
Florian

