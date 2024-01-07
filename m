Return-Path: <linux-kernel+bounces-18995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBA826643
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A399B20EE3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194011CB2;
	Sun,  7 Jan 2024 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCfsx6x6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B411720;
	Sun,  7 Jan 2024 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso15061685e9.1;
        Sun, 07 Jan 2024 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704664631; x=1705269431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLoq6sRizyRcu59pZvOPlzI1kGMqU5IkWECCp6ikVIE=;
        b=XCfsx6x6uHZ9cd4muPOYB2daqahxYUCqlN321uO8FbGfqy1GgE7Lhz0GRlVbORV9VJ
         6+RvVzCHg3PqxnhT0pmMw78vYY8pUGim0/PTo35VxHVBuHBstEI7Rfopv/qP3cMdVqHp
         3LOzrCFFQYYqyEAJM+GiAvPETh5STsp2Yal3OrrVv5jbwZt/6a340USi6b+dtJmVBv0t
         XRmS3R6S1+E7u1dkF2wGcWFJGabAcStEQMb1B2sqdHDDzGz369ErB4bKDcw6aqiVGeti
         0VgRmgHMeRgFSGGW3g3imIl5neY1O3AlsxGFurLKbz6pZfMagrHON/TN4Te0iY1VoP5Y
         fqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704664631; x=1705269431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLoq6sRizyRcu59pZvOPlzI1kGMqU5IkWECCp6ikVIE=;
        b=xHWMf/QexX4vfB5oISkNvu2pFzhhHLHn8WZfxBX6MU3iBMPZmT+HP4Dtxol05bg0Xg
         LESswUBwx6hOHmqOgH9cJ39xj+8TEAArLb1et2mS/qPTMWjuLd9YUYP8o1x6pEDqkPhj
         7nwIg8mf7+qdqNI7uF0i/Y3irWq1VKZn5yEcqL3hWTWp2R16a9uI3aHdWyqRrfLnFFMM
         Tx/T5q9fzWDBdJLWUICNOb8OB2XnCYdNLM7NUvFAJ5wECuirRtyNixr4G6Dy5v4lEeJ+
         CuFmyNipQXZXlSkAlBJGonSb/9l9gBFlkGR0RKFdVDQj+v8NpbX5jASLTnmWjw35rPKE
         K1vA==
X-Gm-Message-State: AOJu0Yyp4OXgTSFdN3Ka3PWhNs/ROXc9Ut+6RDjwxbdUPHvlq2Qcau2I
	fZ4C9k8DxDN0LaqYfucAwbo=
X-Google-Smtp-Source: AGHT+IEd0lL/Mt0NfyWGqJx54tynb9F8fZq+SWpqy1QGZIeI1Gw7htPTuqOT6F3XFFxGCTT/RNBHDg==
X-Received: by 2002:a05:600c:13c3:b0:40d:5b11:50cd with SMTP id e3-20020a05600c13c300b0040d5b1150cdmr1385720wmg.160.1704664630744;
        Sun, 07 Jan 2024 13:57:10 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d558b000000b003367bb8898dsm6137213wrv.66.2024.01.07.13.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 13:57:10 -0800 (PST)
Message-ID: <86755f4d-3cae-41c4-8090-09ae83ea7af9@gmail.com>
Date: Sun, 7 Jan 2024 23:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Luo Jie <quic_luoj@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <659aedb1.df0a0220.35691.1853@mx.google.com>
 <a6a155ab-0852-4f08-b49b-952ac74124a8@lunn.ch>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <a6a155ab-0852-4f08-b49b-952ac74124a8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 07.01.2024 20:44, Andrew Lunn wrote:
>> Honestly I would postpone untile we have a clear idea of what is
>> actually part of the PHY and what can be handled externally... Example
>> setting the clock in gcc, writing a specific driver...
> 
> That is really core of the problem here. We have no reliable
> description of the hardware. The datasheet often starts with a block
> diagram of the PHY package. Sometimes there is a product brief with
> the same diagram. We need that published. I'm not asking for the full
> data sheet, just the introductory text which gives a high level
> overview of what the hardware actually is. Then we can sketch out a
> high level Linux architecture for the PHY package.

True. I am with you on this. Can we put these words over a mailing list 
entrance door? It will save tons of time for both maintainers and 
submitters.

--
Sergey

