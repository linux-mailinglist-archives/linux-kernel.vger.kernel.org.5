Return-Path: <linux-kernel+bounces-61147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0DE850DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794EF1F23D49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCA79C6;
	Mon, 12 Feb 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnzy/GQp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197B5C9A;
	Mon, 12 Feb 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722462; cv=none; b=FzMssC1azvWAJ8z/NaLvZ9kh5W/PwYJ8GP1vP2TUjnEfB/s9h3yLWxNJaAnBd5la5UCH1+NP82Jk4JqJ+iB0JDdF3+FW1GhAFfEphyhScy9YGKxYcElYQ4O4Xlz7M0mL8cCt437u+VvY2iPtWkR6BM7FEfJVqn/xzE0jkGNEjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722462; c=relaxed/simple;
	bh=l0UtqZNPFjX5P1BaXNEatWC0qrVo/ZQak0ps1MZWojU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfNLSAR/60y5Gl63jQ9Daclz6iKucKLgBbP6Qt23JnyJM9JvYCh4GfLSZWmAW7Px+2ZLYkXyJOvzn8jvW9xDKBU/So8L7z1kHAvYvEQTfX+rIEYv0efBb3R2pJPNxnrxljw8yNdJ7d8oQa5ZkMsi0j0akxqeb1U/S7bImA03gVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnzy/GQp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so3640785a12.1;
        Sun, 11 Feb 2024 23:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707722459; x=1708327259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0UtqZNPFjX5P1BaXNEatWC0qrVo/ZQak0ps1MZWojU=;
        b=Bnzy/GQpAfEIfrtPMa4fceL79DsGAzqM0pnE2OOsa4RMkNVBFSh1MTpxOnIe39dxug
         IPbNfrVGvQ2S9DfZjtk9AK/TcCMfLXCLNk5mQWr3uIGyK73L65zQ9kxU1Do60fOX8crA
         avTVHdH0/Spyx9szwFKswuN8+5TCCzCUFM7qJ/V1p+camTIJ1nkKb8EpaMlchzRxcY4z
         3juRYoUpNIug2j4C8kYluaQEqST7j4jngDH/vBTHqW7i7afyafwtVJGtWDDsuqbiKFBL
         btMn8KTeit9pwh6CPoOSmUnIykaCn/8UGd7/9Hjg6zjBEU/d/GafCoBKdA7HGtDgUyxq
         zRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707722459; x=1708327259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0UtqZNPFjX5P1BaXNEatWC0qrVo/ZQak0ps1MZWojU=;
        b=BzXOdLhtErXedG77J/z7ux+ap9PsMfT4w+mEZRaGHGmGN9ntmuKFGo2l2MQZkHnCIk
         yadnwrxfJhxCao4VRvDzLdk4iD5A9KzsM3QXxM152X/libct+aBub3wdOi9xbd63vAOD
         ABiSFmVt7naXFvEcz+nF5r7+fMZOPZGCu9mI0x9X4+GMvNn8ubaMQ8v9fglbR1r7B4I8
         hqQdOOtLuPESNb6LJlmLkpWhGRnq0pUGq1tw683VGtDjwX0xj6FeC79FdKsGiuY5xIl4
         n3z5K5XxdFrAW+6MRYr1oYl/VGCayMMZe4LDpH+vnGbYr7FReoROlUDk2CrJAxt/+D4Q
         Xiag==
X-Forwarded-Encrypted: i=1; AJvYcCWFLixm5JJF7QlGMjBBZGqyTZE+Sesewk71uvQjHueFH69tQEV/Tq76jHeFU3MCQFw9K7OHhvEMrf45ePRXvcfRg1ggIphX5TKAfp/6BOSOzBBxWyTcUg3Fl7kVBSwdu+yBh/5llVDhNPXl0qrKF4Hc95bQpzt4rWFq453l/h/9MkvoPajEStKM
X-Gm-Message-State: AOJu0Yz896NpX4d28RoaiNAa4SRs75OEc1kvTO6GPDqqQZuUkdbaifKY
	LOOm8Pa+WFAmMAjTMm0mPvU3J+lXXpR3LoexM/0qfeTrbn0DLCaZ
X-Google-Smtp-Source: AGHT+IHZ2P8Ih/13lnHFKre2syYlUhl7pM3xyfyn9OnVJVxfYD8qQglAWIaM3WtjgQcZRldk2Ek2Xw==
X-Received: by 2002:a05:6402:517c:b0:55f:6a87:8033 with SMTP id d28-20020a056402517c00b0055f6a878033mr4566269ede.31.1707722459326;
        Sun, 11 Feb 2024 23:20:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8th3Enm1hx/qACLL9nXDW24Ejs3sf0lfpr4B4v4p0dcY6z8HEfmx0h3WICip9cK8EWIP7PnkPhm7qzURtKvZxrKHUmKyYTrv+cFzzSIUQXVlQFAfjH5AxXk/Wl9oMVoxYd/lpwH3ODSgG6zxkG9OnNGZYdJG9nAS/Vn/yZc0MMQTttFxfRCPo3C2KT9YpGm6WXjQDQqx2GSSZCc0sao0BN4HEG7GmtkxmREOMDCDHvz6TrpF+JAxCV3dVGSFNHc8IIu0rlGVvk5sJZ5+5Q3UHgv9odyjpPehWXRPEnpd7qgn4dDgzugeRnBuDU55GnXat/PeNjoPOusTmMVzxoPtxj8vhZ4ppQ/yJpz+nJAiAYOmuyWgpbbVFWC2TwfxPneJ1IT4TS5vFSae4PzK3ZilD/xO4crGyoJyDJAuGuoKbI35wWhnQ8vo7jr6Jaq8+AXHgdkNWomUZsq376eZKsuUDYJLvTAdy2Wf0HA45GcCAbkeSnTLpF8dmgGaF1C9PkogSSsJK0KMkSWAdQb2bWLli1AZxtaMZqmmraKRz9syCnmRqRmmZFlpYNij1hAPiihX2zmpzTd0gKvZSgxSDkFYvbxk+JE2YTF8=
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id h9-20020a0564020e0900b0056058f2603asm2525290edh.3.2024.02.11.23.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 23:20:58 -0800 (PST)
Message-ID: <03d80cad-b72b-44d7-b726-cd8e3d4f81a9@gmail.com>
Date: Mon, 12 Feb 2024 08:20:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: net: wireless: mt76: add interrupts
 description for MT7986
To: Peter Chiu <chui-hao.chiu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231221032648.641-1-chui-hao.chiu@mediatek.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20231221032648.641-1-chui-hao.chiu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.12.2023 04:26, Peter Chiu wrote:
> The mt7986 can support four interrupts to distribute the interrupts
> to different CPUs.

Can we have this patch picked up, please? Felix? Kalle?

