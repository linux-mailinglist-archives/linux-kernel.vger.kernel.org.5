Return-Path: <linux-kernel+bounces-10659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D743B81D857
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C218282817
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BC1858;
	Sun, 24 Dec 2023 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whq0B/BM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98451ED2;
	Sun, 24 Dec 2023 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dbaf12c866so2451390a34.3;
        Sun, 24 Dec 2023 00:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703406674; x=1704011474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7vRR4si7E//0jIMoSyRPsJ7pOTnjAoMpD8DGfwijuw=;
        b=Whq0B/BMZw5xcM8oE31+WvLfF9UwA7Ap3dKY9JbLsJanzrvHzGGqmmxCDMC1kJz3vE
         A1XdPpvKRrxzCMkoo/q8XTampCaCVZO87UGpWrBz7FYXth/IEgymePxFZ7V3cvGceYsl
         2xbGSRmp2KcWMeJRbrfvHL1Ucm1sJYKl7OSbh5STP4+Ty08pwE8grJBhZcwEeQAX6o1l
         bk7cgEyddW9MaFp7tJi2PmVsLgGmpOLUv3UlNwTvomwEUdUc+5zU37awCH22ONUC8Vxv
         7yMRtV2GxgZyDvEbvDz0yXN64Nx+y8fiwicELRWFBCZPZuavKa7urVnK7W53e+FlGLnR
         eBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703406674; x=1704011474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7vRR4si7E//0jIMoSyRPsJ7pOTnjAoMpD8DGfwijuw=;
        b=fywswENLhDEMxeTdWnYpVzOmcibHUbMdaZ2X+0QAOlGsYt33FP9eRR4Ii7oSAMsJmd
         Xi+LZfJJUbtyhpNzvPi+XgFn0AtDSj6HcocSl/jn8aPbh54025yZfspfq/IG76gyzcyF
         NfOcPJqzRCITfjJvYc9E6DdWKqWngBJIFBORqIB1Cl+F3uGPn6PBm/gbPO2r83d58gki
         QXtwMK1ONteTgphDgbXJvJVu4UBNMqQwT7HXR8NVyaNYQldZw9XwRrbe6Nqez+5tQiyc
         bgbQWKs7j1W888Vm/O/id9/RfXqKxXyzASIXIQ+VT4XUP/qQ9OU4GfjBIU3pqKXHcfvg
         7ELg==
X-Gm-Message-State: AOJu0Yz9Mrzc2v8tGj+yWngy7kZ0ASHNHwBSFC+FUbTYOLUiKxdjKqOG
	9gwla6iwbIx2B0QjO+mSSv8=
X-Google-Smtp-Source: AGHT+IEiSfA6ELIfKEa0uToqVD5htaRTLuaCHPE1CPxbweKeTZHHAHxT6z18t+NqYE/7fjZpcAxt7A==
X-Received: by 2002:a05:6808:2383:b0:3b9:defc:a171 with SMTP id bp3-20020a056808238300b003b9defca171mr5724565oib.5.1703406674458;
        Sun, 24 Dec 2023 00:31:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:765c:936e:ea43:6046])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78710000000b006d9b2694b0csm708865pfo.200.2023.12.24.00.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 00:31:13 -0800 (PST)
Date: Sun, 24 Dec 2023 00:31:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	rydberg@bitmath.org, linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com, u.kleine-koenig@pengutronix.de,
	heiko@sntech.de, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: touchscreen: convert neonode,zforce
 to json-schema
Message-ID: <ZYfsTsS8G8SdhFTn@google.com>
References: <20231223221213.774868-1-andreas@kemnade.info>
 <20231223221213.774868-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223221213.774868-2-andreas@kemnade.info>

On Sat, Dec 23, 2023 at 11:12:10PM +0100, Andreas Kemnade wrote:
> Convert Neonode infrared touchscreen controller binding to DT schema.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry

