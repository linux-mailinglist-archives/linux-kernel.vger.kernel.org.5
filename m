Return-Path: <linux-kernel+bounces-69198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F163E85859D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC9C1C23613
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A413958F;
	Fri, 16 Feb 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuck8IEB"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88013665E;
	Fri, 16 Feb 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109051; cv=none; b=gvNIhCBGJ/AaM9JFStzIPUDLxAmU10L/eZafBAO/Sjpc0/H07c3pv93fp7tIiZnwjgOthWS/bc95kmlmN125J9G5mo74GVONtGHZPKOldMoKk5AYmTzn+6JhJDqK5Fml2JKN4236oWKclPm/TzXoEJxxCXsP6bVKwNsA1/5Rves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109051; c=relaxed/simple;
	bh=UzH2ziWK18Hgi78B2VsuSx5ZjKtY+7dxcaPi9GP0qvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRbL3DeTxKVmQui1OpQmFvHPpzkzlGSop3+2oDFNnUcrycHkFDwRPjQrMtvlaSocvizZirD4t3pHrfvYBBfwpKwsuHd/XlgsD0tZl8oDBQWqashLG0dLfmOu/9T3TZEHyzz6SE+nd0w8qMP4z5wqzHLN41uhnpP4Mm/0BiVvFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuck8IEB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d911c2103aso16317125ad.0;
        Fri, 16 Feb 2024 10:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109050; x=1708713850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTbG7sAALF1qcLs3DoYS3kFw8j/rQUhwexU1xxdPJKI=;
        b=Wuck8IEBnEz8Y7DjE1ZsXH62lNJxMt4cAdn8B2CrVLXrjlATHdkgymWUZSA/A6DGq9
         WMEQ/2ivp7eDrk7L++RSkv0DR9wQtljRT03D/VDHKUECtMneVdaHVNsoGzcooUsDMTW1
         OxzefVe4S3BHgtGPS82vm3vTPaFEiET14Ut5Lu+5Oq9e0ABDj4uYfh018hGM7cldFrjp
         7vlbkCgrldZY07SuYmIa6IKF7hcssTfo6Wk38nQOQ55pns2+MJ1LWMWe0ABZHTSKQyai
         pICoCgM5wWj3FEHudtQyCTljpsFJVPGm51NvY6DN8nD2xGd6ccIxL4BqTkhPkpcrY2Gn
         o7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109050; x=1708713850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTbG7sAALF1qcLs3DoYS3kFw8j/rQUhwexU1xxdPJKI=;
        b=bt8HnGs80XkCEX27N2VRkMUhJFp24ond1s3k0iU5rxL4upT30G00+/q8YMgqfOcJ55
         Fg2GF3sSTT4Mt1M+H4EJWARyu7CE3fmIkBkpKpYxhUzeeRJ0BpD5IJSoRddiu9TR4q/B
         vwPKSpWAjgYOuMgIbv/SK82JdwQeZJ8/5h9AdkS96iXE/VaMUifzPS0X3Dmj1ekMKiQF
         DmkoXBhZNgYtt1rQwJ0ppfvAwwdugF4PfNixPR5dcHR1CD70P8WZycMxVm+Lz4+l/ul6
         z2t+U23WYGa9w0vlj6wYtAUADrrUItC84kQ44N/Jpx+HV2NArxY392dqSL09Oehl2cin
         wz1w==
X-Forwarded-Encrypted: i=1; AJvYcCXCeyex+h7FzzSgww4rp7V2FjffzP3lsUi3WL0nnDqA8wIdQm+ySNlXMn9YvMA/qxaSYIwuHUdwSjJ6EZFMqmySX8PB57WEnXlUF5YMrlEc4voXSJAJ3IjzGs4MNzXBIPwCZTEcGfsaMDncabBPx1a69o/ha3Cq+XYRdzwCH1cX
X-Gm-Message-State: AOJu0YyNuPnsgrmJsLui7ByCunZ/SkZ6PxLsjLDWsu4GtQN1TAmnbu1v
	qx7lIpLYX/w3quimaaA+DZxnF+hDCjyyOyNbcJPkPzN8f7F7qC+C
X-Google-Smtp-Source: AGHT+IEkfBAbPOgoa9zqyygyMJne+FLyK1YDIGq5WreKx7vSc2xACmjzE6tf1VPlQrxl2uVrqYEpvA==
X-Received: by 2002:a17:902:fc4b:b0:1db:be67:a932 with SMTP id me11-20020a170902fc4b00b001dbbe67a932mr1000954plb.36.1708109049787;
        Fri, 16 Feb 2024 10:44:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c20-20020a170902c1d400b001dbc3f2e7e8sm5586plc.98.2024.02.16.10.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:44:09 -0800 (PST)
Message-ID: <b9a5b052-cd4b-474e-a851-d1189b06e7c8@gmail.com>
Date: Fri, 16 Feb 2024 10:44:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v8 02/13] net: Make dev_get_hwtstamp_phylib
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
 <20240216-feature_ptp_netnext-v8-2-510f42f444fb@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-2-510f42f444fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 07:52, Kory Maincent wrote:
> Make the dev_get_hwtstamp_phylib function accessible in prevision to use
> it from ethtool to read the hwtstamp current configuration.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


