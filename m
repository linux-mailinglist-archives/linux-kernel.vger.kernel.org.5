Return-Path: <linux-kernel+bounces-24122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3B82B7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F101FB23C10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4758208;
	Thu, 11 Jan 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D5frV7y2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C257870
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e62e6e3b0so5501865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705014665; x=1705619465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAbAyrmMd20Q5seaAiCBRhxbgsJRjIg1DcHDB7xiO80=;
        b=D5frV7y205ulqpKaY4TmiBxJu/g7Xs2j0VD7bJLODUJ20ynPKkCsaSey4go7P19JuO
         wtheS31FcCBzAREnQFzKLv6v23D5x9P7RuwSDjcsMsd6FA2Pby3ku6CbrfwvU5FuLwet
         iP7MTkewJLtBDOoGOcExpi+3bLTSqnmNiTYrUN2zBmf4ZjXxp1MLVJzGBCaxKSHiwvmD
         q4ss04gqNQtxmQjIMxgAaGUC4NZqpsVw8JYSXY0WVy14oaAscJ8JQVjQ9/uzx8a5+E5B
         oWW0k6houo0uZRDRxIcCFeRS//JM1Ls1L/hnadiwripUw0wxkHD4BP4Vg52Qh7MKf8si
         0Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705014665; x=1705619465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAbAyrmMd20Q5seaAiCBRhxbgsJRjIg1DcHDB7xiO80=;
        b=ZgAo/NvOzn/EWjZCCSIBJLjoOCwzbpXXVoSPSzNQEfIVtT6Vm/mDa1FFpfj6dd5vWD
         0WHuVswyKaP5XksmS20rmPcrhTztDV5ecVLspsIszpMZIuwovXsf1laLzRLwn5QCkbKs
         4PevEh4qeqgqqT4l4CVvYN2iaIubpNUxr9w2uw6CbTYazs6i9ayN7fQDajKJfc/q0jpl
         4SSMxD5tioPwPmdzsioP+tQhA8EJY0Sf+SdaPyC2t2UkOr/i7J6BdK3g3X2KpgsvNGu2
         6bhEJdTs0A5QPv1qUR5BfwCzy+hCpVAYNks4JGJ9dNe1jlQ9nphi40+97V6o0QWK5Suk
         4wYw==
X-Gm-Message-State: AOJu0Yzibr38z3s+h9yM4SiP5OGi4KnXhSNZxb+YcBHQX0t5MEM1zp3l
	xk6OdTfaol/8EXw7aKhEEeTn5fC0/wxmvg==
X-Google-Smtp-Source: AGHT+IERYL9YzMokzGUekmbXWha1z4FNVQ4dPniuX9EM1HIgYCzFPnZ/YT5HubK1/jugeWnwEd2OKg==
X-Received: by 2002:a05:600c:6a0c:b0:40e:3b46:4a55 with SMTP id jj12-20020a05600c6a0c00b0040e3b464a55mr185662wmb.153.1705014665009;
        Thu, 11 Jan 2024 15:11:05 -0800 (PST)
Received: from ?IPV6:2a05:6e02:10a5:e010:a767:b543:4e1d:2ea8? ([2a05:6e02:10a5:e010:a767:b543:4e1d:2ea8])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b00333359b522dsm2243797wrp.77.2024.01.11.15.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 15:11:04 -0800 (PST)
Message-ID: <5d3f3db5-9010-469d-a142-53cee8c2bc58@baylibre.com>
Date: Fri, 12 Jan 2024 00:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT license along
 with GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Julien Panis <jpanis@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Roger Quadros <rogerq@kernel.org>,
 Ronald Wahl <ronald.wahl@raritan.com>, Sarah Walker
 <sarah.walker@imgtec.com>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-4-nm@ti.com>
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240110140903.4090946-4-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/01/2024 à 15:08, Nishanth Menon a écrit :
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
>
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).
>
> Cc: Guillaume La Roque <glaroque@baylibre.com>
> Cc: Julien Panis <jpanis@baylibre.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Sarah Walker <sarah.walker@imgtec.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Guillaume La Roque <glaroque@baylibre.com>

Guillaume


