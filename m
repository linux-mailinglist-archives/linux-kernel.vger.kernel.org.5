Return-Path: <linux-kernel+bounces-93085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0361872AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C39FB25E85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E012D218;
	Tue,  5 Mar 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcPZRpyu"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714B12D201;
	Tue,  5 Mar 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680582; cv=none; b=dnOvJFiePH0319tPJ0FRAz6AnAMwfqLK5S34StmS6/LRKdBfC2cWzMliSn5Eo0Aee6UgvHrhswDrn/B4bDlcwR7esqcTfyVyF8lZ4a3WKuanExXiE0LpVz/xdTFNogNd3Y1yJypGZ+bWO+DmvLaHU/FZaSCq3T6X3TtRYK2Qwuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680582; c=relaxed/simple;
	bh=YBkuLwRnIipNd2XOrW0AAO6oTduOdDYR3kwRCSH3cQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q19Fl/Gshi9Wk0sOfsxTln8PADKS0AhQ81lhBBsKdQQ2HXFJn8r12BzrpOgXjJQQ3Ric1631/Cko4ziS0VjaHA+2/p5YeMQA6Ij11a/Y3Xk/sIJO09x5hoeuEHwC/woFFbWlr+BZzPIe0tA4k68rdFaahQIMCdoi7f5F33Omf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcPZRpyu; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22002fbbd6bso2510123fac.3;
        Tue, 05 Mar 2024 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709680580; x=1710285380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0RjFAgSKJAEr2wt6OK2NUbYDGgrd95M2hCjxS/J6Uc=;
        b=PcPZRpyuTUXcj3a4jaJorM++XnrKrdJ1zmtI18A+AMxDHvfx0c8Nef+ZPB6dr3ZUDv
         pc+DbWooSgPf/+Ari8A9mQrp3Dvw5j7/xDGF+F1WBP4rAYsknlng6i6TD0DYaoO3WWiY
         XgZ2IOaNBv2+5VQ8P2n8S8n3jTh+Cz0E43gukhbjK07W0/JE41UZQtrA/WgTicE81Aow
         bma9j25fpt1I9cX/CM4k7tWQ3LnL7cb/bILyg/dGXUba9wk3CvhQGBZ95WOizG81oj7e
         5k1npMoa1Mh58Kr9yAdv2ho21qoAjfoaPORD0Yhlqf0x3O9i6jGewot1RF+mvOs4LkPd
         ArZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680580; x=1710285380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0RjFAgSKJAEr2wt6OK2NUbYDGgrd95M2hCjxS/J6Uc=;
        b=kDodEW5bkCP1gY8gLLByeVwQ2+PeuaCJc8jmi68IHo/X5lI9NqMK64sWKCoPSAelWJ
         WkG6grcT9bNRwmjH2NgHRZn9c+O5sPi+Duz12lq9CJLr91qyiLlKNvmMSzZO6y0kehpi
         LfDw7gPAsivCSugUWDC2QVEljHK5LJ+DYY0olRKZrQ7Jmoc88C4OccgXqEsk6fzwzhEz
         02kI3bM5sTXB5nEJtQbPNaREmmIzNp8L12SQuohfpMjR17tatzFoq9VO1fTHVNjGiwxb
         Rb/pVvprjKudADniNp3TxooeWNBr80V0+e81ZL5AcD5OpRKFHsKCRd6EgLpBdW9BA1sr
         rbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXySW40L12yUfxzaV2BaUBRyIfTymjSDrPUOxSvWGRTqJnJsIXBS1ldUNEkDKppQjRwk8D3Ythvs8Np+U7INz+Be8nfNKEXBrCddmoAdJ5ZY3njwSSnsRsdT9KLM3pOlPN/S3Jn
X-Gm-Message-State: AOJu0Ywhp2dbXMyCKY0wBHszt9GVpOD3tpRLXcAU2Dtdr+D3Ecv4CTws
	aPd/AywSzD4QhGiMLXYRlhHprlhcnq6B2KUmlFshZMpiq0iDZZ1q
X-Google-Smtp-Source: AGHT+IHVywbyf4pTQSTxBN2zit7UXwnt06IxUPF23aqGjzVC6jMBsCZQ9/paCsZIP/Q56qIaHVo4RQ==
X-Received: by 2002:a05:6871:5389:b0:21f:d862:2ad7 with SMTP id hy9-20020a056871538900b0021fd8622ad7mr3338606oac.5.1709680580587;
        Tue, 05 Mar 2024 15:16:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c24-20020ae9e218000000b00788349c0098sm1178824qkc.50.2024.03.05.15.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:16:16 -0800 (PST)
Message-ID: <14a8938d-dcc4-4a98-94af-df269b0ae54e@gmail.com>
Date: Tue, 5 Mar 2024 15:16:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/16] net: dsa: vsc73xx: Add define for max
 num of ports
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-5-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-5-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
> 
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


