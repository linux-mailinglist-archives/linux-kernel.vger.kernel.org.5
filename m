Return-Path: <linux-kernel+bounces-127967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD98953C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C2BB22CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5697A140;
	Tue,  2 Apr 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw+vdo68"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03378285;
	Tue,  2 Apr 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061994; cv=none; b=hWAmrzrQ2dvXWA6fW6iyMcRsibAR5fvG0jKSa3eoh3cUiHLybywA+yCouRI4lGb0kGdx+QphaQFoUT0Vv0LpALl5+OnGzBeVRecijSBg6HaiPfhguC5LcftnNItYFlviYVaB9qGSBFhonSPrw/4ilLnvnpsnDmgdGLXCvux7l1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061994; c=relaxed/simple;
	bh=0vaw1GFhhhzPHB1+ERUheM/ykQ5WliXyfzQBmILS9ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V4qBBl1oBsx17uwDgdNwTpEMlES6UCvSmU0Y8I18ajIyxnIAnckb0lz4DqEtKpzL3bizCsNo01g4VWmFkf7X6jAiBfpxtkRKdgxikZgWEla7dWyxlFcwi3BJGpYUWqCw/XUqd0hfkKDfrhIJ/9qXh2w8E92fsFUJXld379Vw5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw+vdo68; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2707998a12.0;
        Tue, 02 Apr 2024 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061991; x=1712666791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KmxO8jkSPJDfReP4Gy4yPtubDgLo4IL5/YODqwlo3d8=;
        b=Sw+vdo68m+Ozz3a703W/AoF5VLybS1zm1fpSfLFg1UQb3eZy6+KGyK1tsOhyD8bYXf
         xtam7tmxC+f7atfKJkrgTQDDcxNEtehdluQ8k+94slcJw77tPAGo7wiptXVsEk5sQX2f
         9oS6HXHzT+YS08PNTVzxGGGMGdfZxhgH4c+EcPYrSTWSOiv4o0JxdrEfsq2z1ASi5aHD
         uK59PTNq8IGuKKax2epepnO1DsMkQu3p4HYW87shnxC8hvQbSvpayPIa32hZGp4tUmhm
         fHoJeukPq5+FZ/Sp5eyuNcJOm9XZol15RurhouWUWOPk2UEKtOz11UIPktTtpMzjrP/4
         +87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061991; x=1712666791;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmxO8jkSPJDfReP4Gy4yPtubDgLo4IL5/YODqwlo3d8=;
        b=KEmx9BlurzvN/5geH2oiqXKGP910HNjX2+J/bR91fAPsFweNXUr07N7ht+z2DZ+VCn
         Q/eww+RaRS+J9H6Bzj0R3OIiS2S1vZYKHFD4x57cWJfDMFCyGP/bx9LqtfIrCkvsgBN5
         E8rOpUCtdTi6MQyrOh9/mpngIlkgvzdEMih2WzfHmz1qVUeLXbW1JDO4/uOs0KPLgjAj
         gLarkMHuPCmgw0BMTNNygeNXvuBdoXr3TSRW9anlhGeUxAJTUvQxszd/3dDU4pcwsKLo
         D3dqtE9tcAoOvX8moXdvlIqXrAG2JrpXc9pcIVGebhtN/MgmmQlmfx80Rp+vm+suCJCs
         g4ng==
X-Forwarded-Encrypted: i=1; AJvYcCUIyK4UMSnJVDU23R6WgRR0uwdwjSuM5u4//rYi/ZEbPyKdA06UcKwW2mTEBRQZZjgGMpbys5PlBhLgBKYG/cJgBzJL4xQE/ljzgHlWhpZ5qAx+xIshKFJlOvgySJ4Yz5gyMF59
X-Gm-Message-State: AOJu0YyDd1DsJquS6A+7lt3IfzZfTAPrKPd8i2tYdkAe0d4ZAJ9kntN7
	6yNKK6ub7KVcgWVpMLp4YlzsdJBNeIBOJnfUUgaNVWntTYiOGC+g
X-Google-Smtp-Source: AGHT+IESdEXmJWbPQCuiTKYZJca4pPyiJo+KKkqHalopozYwKfN092bDOvrEi4xs4YhFw9PjcKki9A==
X-Received: by 2002:a17:903:249:b0:1e0:b1a7:473e with SMTP id j9-20020a170903024900b001e0b1a7473emr12249059plh.67.1712061991253;
        Tue, 02 Apr 2024 05:46:31 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:283f:ce3e:1cbd:c25b? ([2600:8802:b00:ba1:283f:ce3e:1cbd:c25b])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b001dddaa7d046sm10971016plh.29.2024.04.02.05.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 05:46:30 -0700 (PDT)
Message-ID: <ec92cc10-b4b9-4ced-ac1a-721e5acccdfe@gmail.com>
Date: Tue, 2 Apr 2024 05:46:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner
 assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
 <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/2024 2:10 PM, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

