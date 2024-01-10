Return-Path: <linux-kernel+bounces-22802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31482A313
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C0B22E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1BF4F89A;
	Wed, 10 Jan 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS0ZlHjD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DA4F890;
	Wed, 10 Jan 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5bfa260bso2105205e9.3;
        Wed, 10 Jan 2024 13:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704920898; x=1705525698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sdBkJKGeqx2Ib1rMQ4cwKys6z0bi0e5Co8yXswFscM4=;
        b=RS0ZlHjDmeI80QME631SJYtxj3ugLmwodMaExE2j6P1lWWywJmdWQ/kaGTUd4XCWt1
         BR6/c6JO+22xGx221PqdXglMj1ZWSVBPDZf7hRnH23agHb7Mdxmk5tWrxKbmVIi7NWp3
         vX07jTAvu1PBYr9h60oqbDUWCn86Y97L15T0JcNiXkynUbQNvNPVMDhwWkCTzFyDDDNA
         gBK3NteEtrK2icBWv0+BAB7DqvruOfezNHoM996/lgVh96IK1lUZ5hMxhRNgGGmfg2cq
         pN7EKfp0jz8sO7z82v4Ff3CVzW2PHV2AxJ0312Ud3uGbav8hxjGz/GuMabA5CxQlEIjF
         ThkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704920898; x=1705525698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdBkJKGeqx2Ib1rMQ4cwKys6z0bi0e5Co8yXswFscM4=;
        b=ttDmxUJivrtmUoXbwcyV0lpIRBdySvDoB1ZIKdfQ+afEoNpRIur/HvX7pJbBteNLp5
         JZ5AvWQiFo19ql2FaS8WywcCpuG/AKU2RqT1mbUP+M5BoyU2nsrF49oCU2MgFR1DHBXU
         9IIwWfkNp6gFM1tiVrrEiIPKnWjmurOdZmaVamr0xFMw6O1IKQyq0b1CaRdXBxb8D5bG
         SGCmv50PUOqeVW61eDmqarIt4Z/cKIGJm1AibSHg87UF7N49cDRkmIiyYWoRNWhfGSmX
         QWgegERqYpDGHKKewclPcb6vsNlrk6OHS+uygp2XOGcKPAGjrRHXMjUbfkKNFmmHC4Hn
         VRJA==
X-Gm-Message-State: AOJu0YwC/hcwqPR42ZpBOSmChpKN92IJSUoVszA6geT7J1NsBW7fqE6d
	zQKl1TYptpOv0cwmS/EIjJM=
X-Google-Smtp-Source: AGHT+IEnV73X93ipcA+KqaG2Dc/CRaCkLE83o8sdCdrKdhcEffrQDt94qGVTchMbAPVOs4q40slv7g==
X-Received: by 2002:a05:600c:2246:b0:40e:455f:fdbb with SMTP id a6-20020a05600c224600b0040e455ffdbbmr9115wmm.280.1704920897638;
        Wed, 10 Jan 2024 13:08:17 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id w10-20020a5d680a000000b003376af392e5sm5670428wru.38.2024.01.10.13.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 13:08:17 -0800 (PST)
Date: Wed, 10 Jan 2024 22:08:15 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: narmstrong@baylibre.com, neil.armstrong@linaro.org, clabbe@baylibre.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	artin.blumenstingl@googlemail.com, linux-crypto@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v1 00/24] Support more Amlogic SoC families in crypto
 driver
Message-ID: <ZZ8HP7dJgVaZLMw5@Red>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110201216.18016-1-avromanov@salutedevices.com>

Le Wed, Jan 10, 2024 at 11:11:16PM +0300, Alexey Romanov a écrit :
> Hello!
> 
> This patchset expand the funcionality of the Amlogic
> crypto driver by adding support for more SoC families: 
> AXG, G12A, G12B, SM1, A1, S4.
> 
> Also specify and enable crypto node in device tree
> for reference Amlogic devices.
> 
> Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> custom tests and trcypt module.

Hello

Thanks for your patch series.
Unfortunatly, I fail to apply it for testing on top of linux-next.
On top of which tree did you have tested ?
According to patch 01, you used a tree based before "crypto: amlogic - Use new crypto_engine_op interface" so too old.

Regards

