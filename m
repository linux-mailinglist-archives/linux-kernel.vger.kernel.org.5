Return-Path: <linux-kernel+bounces-18349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDAF825BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69381F246A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F52137D;
	Fri,  5 Jan 2024 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="v3DSC5bU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD220B36
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-336897b6bd6so1757793f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 12:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1704487379; x=1705092179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWUYD0+rz2aiov/xLWapi9mOqqQZpnKEd3A0jej/9rc=;
        b=v3DSC5bUtSzb1KAI+/SvS7ZVS4xVvWgaTe2ojl3yDBG5mfOLaRvavkcCRXAcGBJ/ic
         ng3eJAtRO+ZGR15rGfHlblJGWp21hvUDTavzsG6aGp/rzfllcNCB85qdIo4wecC9a2Oy
         WGq7EOVszhoQcj/BRer5p0xeJeU5DIRCmYsShbP5EbabhK0AQg4ZtrtoN/QyFRrJYglz
         YXX0coNAVNzmExs/7UWDDPSXEmODqZNHKb3CLCWXUsaaO9tdKKFDTdLkBWOPodiulxpf
         ps9uyu1TohNI5Dh8ZiQIY77ycKX7Fe9Znn3oTza8WijeaYfZqcpDTFBI3SY+0WPnEY7C
         PF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487379; x=1705092179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWUYD0+rz2aiov/xLWapi9mOqqQZpnKEd3A0jej/9rc=;
        b=OZw/5Hfbnt5uJF4gJRyuYspJnY6ZtwJwNKJAIFSQlUJ9JK6FdFj1LL8JgHKbs9eDxD
         3iGaKGqVh145UsQ5sqRlxd5DjjMiI7QlhMMfUZIO7UVZu37Nk3Nc4/xJ1FTBythVKy9I
         T9lIV6XDb7VwB0NC0MWRgh2UeH6Zt05tLOckkQmc+v97AH78HXAv6GbMjsUGI4sKsUJy
         C7prdp4xtAH7E6cglc6qvQ/lm91AZ5dAwI0DRny4O8HlG0cSDLlsJb2uxbLQetckJk2G
         7Bfa0CIRKfi/TV1uAkmfBMyh/zlCY5zYSH36gd6Jfd8EvC8cFNkX88/cuyTepL96fU1n
         yfCw==
X-Gm-Message-State: AOJu0YzdWdXWLvBzFVY0aW1Ge0hPACkX8Ypkghln6M33Ho79EJ470cLJ
	vq4p4MfHty0x2rJMzymmmAeFaRvZi20+7w==
X-Google-Smtp-Source: AGHT+IEGG0xE1de+XjBKFaSdmqM0NFDyksN9nTWagctfvhIj/Cdwfh2O91fuSyDJ5Gle4wDav74AKg==
X-Received: by 2002:a05:6000:111:b0:332:eaa7:56b0 with SMTP id o17-20020a056000011100b00332eaa756b0mr3670wrx.14.1704487378743;
        Fri, 05 Jan 2024 12:42:58 -0800 (PST)
Received: from [192.168.100.48] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id o15-20020adfca0f000000b0033666ec47b7sm2020937wrh.99.2024.01.05.12.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:42:58 -0800 (PST)
Message-ID: <6a66331f-4edf-4304-abf1-92d93ff28662@nexus-software.ie>
Date: Fri, 5 Jan 2024 20:42:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-0-7a57b8b07398@linaro.org>
 <20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-2-7a57b8b07398@linaro.org>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-2-7a57b8b07398@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


media: dt-bindings: media: camss

doh !

I've just noticed my own typo, please ignore.

---
bod

