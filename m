Return-Path: <linux-kernel+bounces-69199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E998585A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4357D1C2347C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06713B2BC;
	Fri, 16 Feb 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMXp6Z7l"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28C13B291;
	Fri, 16 Feb 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109063; cv=none; b=pFlVkuWnrieO9GHN4PLoCqKXN4py/hahiyZwMtP+fUwbWfkoKD06jalwjASuMQqp2UWbMVU532EVD4yaftxZkdAJk12cQSRGBgiO7HW3rACIvSbE1ld2FIKuKfg4f3NTYSMVYWQlb7uiD1ShseVTB9ZuWSxNruLsQMG8H4tDlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109063; c=relaxed/simple;
	bh=rQJ9yGcOerFYeIUKIrA67jwMFOH9tKo2s2yrBJL41rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFCR+edUi6uwJlbU71UT2S74UeiJ+EMPZGLfnp1XFhZ2Vi/6Nm+lUcimra8qnUTXGQ2UM30wE3XfKZwUh5KoUDuGgTTOOagJW5QD684PEc/qKLDjzmRODMXOgTsiHg/kSmN1dsMMvrbp0U/7K/VgNbWkdm+884L7ifhLryJV9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMXp6Z7l; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0fc87fc2dso1513053b3a.3;
        Fri, 16 Feb 2024 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109061; x=1708713861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdvHdhs5HWjtp6zPVbusqBE9tw93+ZSMA0vMObsFyvs=;
        b=EMXp6Z7lVz1OXzbPl8iJl46SJlh7JQSqEl4c0u9BgUzKdLGw/vofRMRJGgXIpowRjV
         NNHhlt0+HR9XSy3GbawOIZQj3504Oq71IxstGKzX0TEmYQOecVVjFOKY6tZbyZyhE2/N
         xU7Hrg62nyopV4MB7/T14qtJArOCS2eE8P1hmmyChrCxn6kyIe9ZZiL5fdCswq/iA0T/
         y60pnFDCphV7nI5yxkxSkjNGrZ56qjUBnXxVsAG/VuE/QQmmuZ/GRZQoDuQqJOkdBONy
         EOBFShJfJKS2xHVYUjvxAOA/WGgUZIYyprVG00H3R4zZ+P8cky7syOTuv47fsyV8zc/x
         K26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109061; x=1708713861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdvHdhs5HWjtp6zPVbusqBE9tw93+ZSMA0vMObsFyvs=;
        b=Nfpmn94L/i2S4OayjoZXP3uQEySFLwiUO1prZi/e6bPiAizgliY+9kiiYCkeqZVW1i
         phRqbvnX1FBTCNp9z0cARkeHn97QRveCbHAzrstPOFEt++f8fZ2iaHkr3JrxpHaRmo5s
         e5EDl8mAsBaPVprgawCCGdk9kcOCqzH4rLPeUF9etredm54OOswIBM6vT4BZl3e5gWew
         2dshvvGHRS6vnzOjbUA2bdY+3M2ajWeIrPrUn04EJcNPSig2mc1NAAKCsjlMsxR3uJQv
         3GjY8cHelxg7nB15wrp+rJEu1odAs292Fz8PN83AwJxsbvDFWbvwWVmPei1AXEDVgofh
         b8rA==
X-Forwarded-Encrypted: i=1; AJvYcCUe3iQkPMPjLuvkxEWdG1LQ53uNAWgC0dwIvMHws5b4YCihWfjeHvy5cFefZjGPU4RinULaYv1iKuTW2cXu4OZGjtjFYUyGOyIDNylCnK8W1Gn+VTTYxHklc92kXIsLAhkoRQusQmfto/Kkq609mmIfqluWDlzH+lrPIdgxD1SI
X-Gm-Message-State: AOJu0YycWelBkp1tntVZt9hDPyBb4VbqqtRo0jO+FjKneG1cnsyTOQcS
	GJcQKaMBFjqjQQgv7NWCOT59TrczAjzb/B1CKhoIJpN0gp54TT4T
X-Google-Smtp-Source: AGHT+IHS6krIzakMCH+NkmCv2HXoz/o823TFey7e3p2Coi5EOWHNMENhjMR6x7XjaaDS9i3xNnUvpQ==
X-Received: by 2002:a17:902:d2c1:b0:1db:92e1:2e54 with SMTP id n1-20020a170902d2c100b001db92e12e54mr6638958plc.33.1708109061469;
        Fri, 16 Feb 2024 10:44:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c20-20020a170902c1d400b001dbc3f2e7e8sm5586plc.98.2024.02.16.10.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:44:21 -0800 (PST)
Message-ID: <7afce107-0c78-490f-a0de-9c205f6d589d@gmail.com>
Date: Fri, 16 Feb 2024 10:44:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v8 03/13] net: Make net_hwtstamp_validate
 accessible
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-3-510f42f444fb@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-3-510f42f444fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 07:52, Kory Maincent wrote:
> Make the net_hwtstamp_validate function accessible in prevision to use
> it from ethtool to validate the hwtstamp configuration before setting it.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


