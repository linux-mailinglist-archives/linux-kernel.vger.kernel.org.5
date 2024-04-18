Return-Path: <linux-kernel+bounces-150512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634408AA059
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EF61C21F98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72B17164F;
	Thu, 18 Apr 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUY9ASaY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CC16EC02;
	Thu, 18 Apr 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459034; cv=none; b=bluiPUY8IVcX4jZjFHzy7CWk7rg4LeNH0IAWYkfK9bJr+vpNHuWVas5OJ1KBFfZVPETWRTZCw+NBRLbkr9saC/Wv89qbjlFdhEymcCYmV08b4nLqYEU0GO+UMVaw8fuscp11Puo66PqioHOHlHrEaq84KtVQTU4YMcR74NtxFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459034; c=relaxed/simple;
	bh=gA7kr3P8rammQuVG8J+GOuRW2Trrize3tToG0qF1s44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nP5aO6KdlUsujVQyFM725TTCIiEfo0pXrXEcUnFx5eh6PRwNxtm8M6TG3M00AYtNanPlvNyjyettbadHe/5adD5p57kdNVMvEdSBAEgPjyj92H5bp7TOmD0Z2XQPLneeUaWpBwY6XWMN7fvfhpuZujhkUJG6TMPMYXlly6BQkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUY9ASaY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418c1920313so9301055e9.1;
        Thu, 18 Apr 2024 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713459031; x=1714063831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gA7kr3P8rammQuVG8J+GOuRW2Trrize3tToG0qF1s44=;
        b=iUY9ASaYi1OjXSdCHzq/+uPyCutSh1oIn7jNO4wtf8hmBqN1OSW3gvzSSE+UFqMd42
         yMne/Fz7Oa0jJDa8rgNxVwzv4Ls2gVcRCgHe0+DGTSYfeEilJGfJ+jn9N2fld6SZF5y8
         ckFNxEyEZ9eWMmqE93yC9HlTh+Vdt91SXMBpt/A+k2+OSbjHAAcDeapK+Lne4cz+3vUv
         4r+D4xQbBYsICEC/iaStA0wXmLd6P7ITd6ftOI3sM/OW+ec7nqA8gKROUVSp6reVt8Oe
         txN14lkpd1h1AKxBQPVo/77rQ61ixRK4p7J3WPaOKZuFOtHnKVHkBPTRlm1MVZ+1tQ/9
         9XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713459031; x=1714063831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gA7kr3P8rammQuVG8J+GOuRW2Trrize3tToG0qF1s44=;
        b=axz0NWSrpYkcGgsTC6H6pJsDg2ze5g5Uq70pb0Ltkv+afuAL2cPKKcSER2aPlLpdYT
         5Ujf9Kg3DEtebHC5F1ilY3lPNA1FZo7erj8bEuk1ramRWdyfOUZWMu5basujpT45gERC
         3/0uh1+4rRgkW0VdhFgnI3Uh+L1dVqJH+u6zROYQoOG1OgO401cUlhV76uC+0JOiUoKy
         /DRBlqq5vqZlFV6f03IvVdq9onUUizTHcRBYBhP1TmF2LUITTPK/vnl0C1aagNC4aLPP
         0S76/SI65xYxS0XlHgUkfEOmE+8S+UHqVcD1LKYDmwljhTF6EH2xgTq0VaSHJIbIpGUD
         oC7g==
X-Forwarded-Encrypted: i=1; AJvYcCVHB+511C1iQsayb8qEPiaTn9NKmRHsHw/sa4tJqC+zdLfp1tozw7OJQ8amKnv1qTEz5/j1QlglTPtI/6FRU1XIf7EClPPGLQQ4b5U14wtSIFJC2zyJtAGTNCtn/opJQFgdutu/DEwkiruTy+hhnrF7YpC2BARPHyU9fco8VShBzBo8x+4IGmBprz0YZI5qfgxvQ3BLip0r4yp3Qf+Dv2g=
X-Gm-Message-State: AOJu0YxGxMX3sYSMf7J27WJqB/4YccK1b66qgj0Gj0AhTS3nulCi7b8N
	dT+Zd7M5ouCh8+0qsIsumajm5Ie3yUx0IhBBrPSsnSt7yg94tD4K
X-Google-Smtp-Source: AGHT+IHMfj38JoZUDpClMWDwQ5C3bc7yi/tNoR0G8uDumFXmFP2ZjAKxHbWtJ3fy5o0rdm/ner2vrg==
X-Received: by 2002:a5d:4082:0:b0:346:305c:b0eb with SMTP id o2-20020a5d4082000000b00346305cb0ebmr2404081wrp.22.1713459030879;
        Thu, 18 Apr 2024 09:50:30 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:cffe:40a8:31d4:2e61? ([2001:8a0:e622:f700:cffe:40a8:31d4:2e61])
        by smtp.gmail.com with ESMTPSA id cg3-20020a5d5cc3000000b00349bd105089sm2223076wrb.47.2024.04.18.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:50:30 -0700 (PDT)
Message-ID: <e6b42e27b3fd4a0970904224d7bd32c52159a788.camel@gmail.com>
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
From: Vitor Soares <ivitro@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, Vitor Soares
 <vitor.soares@toradex.com>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, 
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, LKML
 <linux-kernel@vger.kernel.org>,  stable@vger.kernel.org
Date: Thu, 18 Apr 2024 17:50:29 +0100
In-Reply-To: <29e1a687-99f5-4e9f-a8c5-50154312cac4@web.de>
References: <20240418155151.355133-1-ivitro@gmail.com>
	 <29e1a687-99f5-4e9f-a8c5-50154312cac4@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTWFya3VzLAoKCk9uIFRodSwgMjAyNC0wNC0xOCBhdCAxODoyNCArMDIwMCwgTWFya3VzIEVs
ZnJpbmcgd3JvdGU6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg4oCmLCBhZGQgYSBkZXZpY2Ug
bGluayBiZXR3ZWVtCj4gPiBibGtfY3RybCBhbmQgZ2VucGQgcG93ZXJfZGV2LiDigKYKPiAKPiBJ
IGhvcGUgdGhhdCBhIHR5cG8gd2lsbCBiZSBhdm9pZGVkIGluIHRoaXMgY2hhbmdlIGRlc2NyaXB0
aW9uIGZvciB0aGUgZmluYWwgY29tbWl0Lgo+IAoKVGhhbmtzIGZvciB5b3UgZmVlZGJhY2suCkkg
d2lsbCBmaXggaXQgbmV4dCB2ZXJzaW9uLgoKQmVzdCByZWdhcmRzLApWaXRvciBTb2FyZXMKCj4g
UmVnYXJkcywKPiBNYXJrdXMKCg==


