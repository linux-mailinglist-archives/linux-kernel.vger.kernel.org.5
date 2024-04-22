Return-Path: <linux-kernel+bounces-152763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3098AC3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA001C2190C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FA18633;
	Mon, 22 Apr 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAtEGyp+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81418B09
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765334; cv=none; b=i+psqeIfquZMA28YkUmckl2mQo+cmCccAekCwN1xP4ltHOqMFMqdJFkrMmojtahZcPoaBCXuHR+WdU32r+ZsikLvh33V2f1dCbqOaNDCyj+grzgKmJBBWODakyw6mhp85jfg6WD48VPPt4uWNzFzDDzISSjcgiASPf/nMvwELfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765334; c=relaxed/simple;
	bh=AmsS7TeoR5lfEkPA/4hWMzBs7ZLo8pjbDxlnDnyGR5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR+QtRJ9a+SpvHhzRHgktr9T3sdfRDf2qrV835BscIaxZb9L5mS9Vwz5SVnO418vlsya/FYZMb+3/Suu68cD1Vi+BK4+jIbOw+M9asRHrrHbI+meQzbx45sF/4/b4hJRGJxTnrps/EU4W9aQyAH4NB1ee4w8NhgLoIRzqBdv7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAtEGyp+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3499f1bed15so2659926f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713765331; x=1714370131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmsS7TeoR5lfEkPA/4hWMzBs7ZLo8pjbDxlnDnyGR5I=;
        b=QAtEGyp+1tuDp3Ncr3ZDfortxei0wwaZEIk52j9NkugzvpQeontj6b+rsl9qJ/lbcH
         5pOgP3HqmGO0puDEW55YBgIlp/ZldaUYfbmi3Lu4YcMfeeS/jukaKh9ukl/2e80SHYi2
         Dj8ZHO+Mldwxb+nMhWP6wLG+MEPnOHmoDtgZE4MmBUE8/855qoW6IUrrfNEMOhKnL946
         Kb1oUpX0ZIOrZ3ZW88Ajtkky+7wJWGa5MUqxK2w3gGBkxjXtXUYoW1VCoYeLhlbPKPBo
         6/XSgvDSQ2VvlhVcSKHd+jVBAD2jIBQ6hFciyLNcE/ZQxHmrJCebk5pjQuh0gzAh79Tj
         0htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713765331; x=1714370131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmsS7TeoR5lfEkPA/4hWMzBs7ZLo8pjbDxlnDnyGR5I=;
        b=vratDtxAokx/pP+u2RTtA0UtUK1YXMWo6OqarW/iLS9p+RqS9Ih4rnmg4D+25pAKVe
         iA/tpYPuQZ8j7m+RkB74SOYk/7pdZr2Z+v3WYc7R5Je6YqbkL4L9p7pePs6nMF6qBpb8
         sMJm3EYtdoCGNZNhIDynnfqwyhQ/XWCoNsM57ERfQ+1mYjllsjV2PoVs4pa/W/Ckkepf
         LoGjb831R1nrsmPJXi6JhiVuUYljpGFWJMWWVqcE/tctXYyLWWfJGFkhrBMBp+TdrTJ0
         X7VeHZ9eJffi8j67fUatsCZFU0LDSrcErhG2mKuO0PtxQ4XI488qnoT5LCX7xfNd1fJ5
         OpZg==
X-Forwarded-Encrypted: i=1; AJvYcCVg7CJqxtpFwTsRWK24HlQVR0pFaLYpj2oD+lUA7aOGjOXLK3LcvfagfUH2S2U0s+OLuFHIrly8AzGsI44/flGhKjutC7G9Ii/b5UK6
X-Gm-Message-State: AOJu0YyGAiR+ZEplH+IXEas2b4UqdmgyMJu6Z8noj5hAXdbeeEL3c09g
	1baY/lh+8QppCokhJDb1S34fGa1qF2JTetsj1UmKrlM7ogJv8VApMKJY41m2qpk=
X-Google-Smtp-Source: AGHT+IFwehGoU4C7S7pThJD6H5xRO3FxOWtzO8AS1uALt/2FKe01ucEOx0N/yELDrpV+GVGYiGh5IA==
X-Received: by 2002:a5d:5706:0:b0:34a:4fa9:81cf with SMTP id a6-20020a5d5706000000b0034a4fa981cfmr6267897wrv.9.1713765331011;
        Sun, 21 Apr 2024 22:55:31 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe385000000b003455e5d2569sm11203602wrm.0.2024.04.21.22.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 22:55:30 -0700 (PDT)
Message-ID: <b6547140-0d2f-4e09-8897-5e557955e08c@linaro.org>
Date: Mon, 22 Apr 2024 06:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mtd: spi-nor: remove .setup() callback
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-4-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240419141249.609534-4-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

