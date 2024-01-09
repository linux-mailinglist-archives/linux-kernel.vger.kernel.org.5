Return-Path: <linux-kernel+bounces-20426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B1827EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C07B23741
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B163B9;
	Tue,  9 Jan 2024 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfRDI+0z"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A99442;
	Tue,  9 Jan 2024 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557f4fd1278so376238a12.3;
        Mon, 08 Jan 2024 22:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704780758; x=1705385558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svUThaQL4O0jeqe+j6zcJnwnFNsK7pUnz6sFOsPzHXs=;
        b=hfRDI+0zQwUvjQhSAqAEjziRLpZNCA94TdTO/NsEGHn13ySfj0Hs/pRBuKUu1zD8U/
         /k6/xrHRRe+haVvJ5fE5/TJkpZEM3VkeuJjYp2gQEQU9kynKxdanwawCfpz80aV+WDXI
         NpeB1kvCdEdbseaJdlSOej1enE0V4LDgUL0cWiYxLzP5G3ZaCp27ZxABBKXi8XCL3xT1
         wrakKSgreYbDXxM0a2oE7S4GZIWET5eDR32R9PfQVgl+FP2lpBN+2IYK5ouvclOYI4ad
         uWWpViDLi7mGdE0/PwEEDDq8mzu5EEWlU+6EW+RbmS5drzfX1yycHM2cxjQr8nyZ94tr
         +pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780758; x=1705385558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svUThaQL4O0jeqe+j6zcJnwnFNsK7pUnz6sFOsPzHXs=;
        b=h7H/1YAmyfzvq51GlM9If8fnqViWuw7vslD3Q8AeWpyaOcyc2hFUrN1Uj/OarwPSVZ
         RgKyAiWX9H8t8fpV0OfZPi+V5l2onG7VD/IaoEcoq+J5xtxJlxWNnB7CVz0Vxlt70iZG
         NcNk7B+eSZCoSzrfrp1OCFGEu9qhgru20388CheKUWDr8jH131yb9nCiewjqdnUGYOeC
         46OlJxtosWILkotYfupVFjHFbqQ3DRKL7pEar8LNYakXGACRIw5znnMzv/rgJOXEPHGu
         FKcBkCvrW1+EMAkZVD6DSjBAhqe8xv/e/2R9UMhSpI8uMgaUfvlvGfCugXub0mpCox9K
         SHVQ==
X-Gm-Message-State: AOJu0YzYE91DYVzl2Nf84uJHEcP7+jrmFKPduP/vNh78cnqwsPGMEB8p
	yCAruQbN3GyVIpIUAn28Qmg=
X-Google-Smtp-Source: AGHT+IH9t82biNC1XX+mwqw0X/XMIj5bvFu3P/kSaeV39cU5H2Ey1ialTC3tFvNcWbBMYps99l3iSA==
X-Received: by 2002:a50:9f2b:0:b0:555:11da:d813 with SMTP id b40-20020a509f2b000000b0055511dad813mr3250528edf.83.1704780757994;
        Mon, 08 Jan 2024 22:12:37 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id t4-20020a056402020400b0055773fb50fbsm572037edv.15.2024.01.08.22.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 22:12:37 -0800 (PST)
Message-ID: <1a9d7f5b-4a00-4026-81b8-7af3031c6656@gmail.com>
Date: Tue, 9 Jan 2024 07:12:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
To: Conor Dooley <conor@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240102205941.29654-1-zajec5@gmail.com>
 <20240108-helium-retriever-043ed3e1dbe0@spud>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240108-helium-retriever-043ed3e1dbe0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,

On 8.01.2024 18:38, Conor Dooley wrote:
> On Tue, Jan 02, 2024 at 09:59:40PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> MT7988A is another MediaTek's SoC with just 1 device available right
>> now: Banana Pi BPI-R4.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I sent V2 meanwhile, could you reply to below PATCH instead, please?

[PATCH V2 1/3] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4

