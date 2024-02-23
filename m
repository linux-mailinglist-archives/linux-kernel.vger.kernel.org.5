Return-Path: <linux-kernel+bounces-77772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4E860A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E211F24FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1911CAD;
	Fri, 23 Feb 2024 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIaFtiti"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953ADF9EB;
	Fri, 23 Feb 2024 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708664005; cv=none; b=FRFOFyolSWceSGETSx8cSGb54ZDwRQ+Keg8GrkeGzwTyg9666CtVi6SPvQNSarDT8qKMYsC5j2/ULOWVWIAVitC+a8pInnrtUf2ZtEgEGjGxjoR3qWikQZS4BKzvoNs6SeFc6GTHhnv32jRC4ETz28xXt9Ici2LqCeeM3vRvc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708664005; c=relaxed/simple;
	bh=Wz69nJustR8qAYVNI9oXbi1iPomxDU38qEYqSvolah0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6E+buzjzuDfUR/KAtViSX9DD9X9JLIo/AaU5Hc1f0XpxoM7IarjGwla/+tZQz/+raO18WsEPES19fUAsOLZuvDFcem97qomO2oFTNOeKxxer5D5r2G1zavOF60o7sGKkgDreaQOLhc1XfLIptMKG5NuBBVB9NlYJQpQlvqGJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIaFtiti; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68fb3a3f1c5so3427056d6.3;
        Thu, 22 Feb 2024 20:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708664002; x=1709268802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ3BptRYQaEKv4neOaGLcF1kQOsftaDXevonNaVBevU=;
        b=iIaFtitiO7IJDsyrmuRpTli2wNa69ktCv6xXPV2nz48ItJD/XZDlA7SnLd4rt71efX
         bH7UQ8EyVtfTqkjAbGke/zKQunJEtoKdpvYOlmwe1cRJQE3rw3Pw7Yvdo4lu96Ej/sS1
         waNvtyYPMgKqKUDdm74AHKURmGFSWcVebX7IOwCQyrjXggVhdB7z5mDMODiRnRxftnBG
         qiM/XYtinEaaKmulAseJkqSTB+RaPXcNSxF8duReciOZsh4/9T1mZoQ7BOEAo0n0EPJW
         TsbM/Sbo5wQacGo+82x09LWZuUeolyVAIgckWueGO2TsE8ivwwQxqatrvXP6dNNJ2C9a
         tbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708664002; x=1709268802;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ3BptRYQaEKv4neOaGLcF1kQOsftaDXevonNaVBevU=;
        b=DTpwxfg4Hy4400I3EY35ZjZYmCrsKXrO8m5q9SdAn7XmL5LQXZyanAqECy2kX/uDEj
         TfVGqHuSqLqqhBVuyaG9K0xaOZoIgTG8oqPDXWcwplfPdymj/Oyrciyu3t94mrYjhwoj
         mxwrkzygSbS0RqNzBEuX9L2NF8/QLo4z4wyvJx17VjxzQEnMtOMCtx6LsZcmFU5W4eyi
         4fywXHFRUiWQIPPtsUjytpSaDhVcJEbLTmv59d57taV/G/HtIgI867DQOkKpMkCTRYmh
         FgeFtN4JKR9r7Z3zIcophL5ZVPdR1VriNU/hDY08bAtbQ1xemxRH3Ao9btjdUqOqWHpv
         plXw==
X-Forwarded-Encrypted: i=1; AJvYcCX/hzfzchXy7QM+HF494dmvP4CfIvKOQpdf/BjtaxrrpfDBdMlQh7ZhdcYrofx4CT7vfhxmieksiqkD6zVYyfX+RTmNtpSNIuzHPhk0XYuRzNqLmV45VMUMsa6CX7hfcrclX9lQ
X-Gm-Message-State: AOJu0YzX+ei6vO0zO3NfdOGnWMK6LFfWfTQikzMu2IgXK4lSpZAEc0Mx
	eNr5ehbL1fmsJsbKhi0MzB2sAa4wFZAU0QBImqwoTUmqxJQyKrmQ
X-Google-Smtp-Source: AGHT+IE1SoDFWsW/RE6p9qED1fJAhLxb7hPl9LOeG7uWKZpCl6ol7uSO2OhyMCWE7ljc1TSxQ3YP5w==
X-Received: by 2002:a05:6214:e65:b0:68f:1bd9:f6d5 with SMTP id jz5-20020a0562140e6500b0068f1bd9f6d5mr1241555qvb.16.1708664002554;
        Thu, 22 Feb 2024 20:53:22 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id ol10-20020a0562143d0a00b0068f0ff36defsm3192165qvb.47.2024.02.22.20.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 20:53:22 -0800 (PST)
Message-ID: <3c15bf65-5702-4991-beb9-6e86e8afcfce@gmail.com>
Date: Thu, 22 Feb 2024 20:53:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/8] net: add helpers for EEE configuration
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-2-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240221062107.778661-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add helpers that phylib and phylink can use to manage EEE configuration
> and determine whether the MAC should be permitted to use LPI based on
> that configuration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

