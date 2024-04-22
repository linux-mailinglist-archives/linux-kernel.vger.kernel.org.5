Return-Path: <linux-kernel+bounces-152703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33D8AC322
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFE728124D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D5F9EB;
	Mon, 22 Apr 2024 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IV/CTnq0"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDEDDC3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757276; cv=none; b=acGnSeqRF5mqcaYPZraXEGXMDn2w4MIDrJfubOFxz+vVNJFyHEEOqzvO6+gMpGZ6zFXRIfk2LfcIFu0yLGdaz2brVVaXK1xJcfYgmD5A413vINZV2zADiIZ8vSgbsKEaNkQweCxJl8TY8lqKNT0IgrtjzBUEy8e+RKdcLgPxPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757276; c=relaxed/simple;
	bh=QXCwamK07MsvJLUBrAceuoynnr5As4trjRDujWCt1Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvIRe7kvRnoAT69T++HFgGNOR/Pn06ouHlgTHjSE8eoDVlWi1MDUTMF3LahmCrUVMfxRP1Nw3TyfZgn5LomDZ/XQ42inwheLVOhmNRBBYWjF/jY59Nesu8W1eJTsM96APtcD0xKQ+k1RI9HqlGw7nqHBUwvwgnjzjQznNsGmMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IV/CTnq0; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa22ebd048so2799787eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713757274; x=1714362074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl5iDmcU+vdD5ORuT+ZmSbv78xBtfXPu+m5CHFPkBDg=;
        b=IV/CTnq02p8E+rxmZsk7j3TeJFn70+D8eqC94FwvQvZ8njDwlVJA9YJA8NYolygcin
         oQIFidoML+OLg9zbmEtyGrv/PVkeDU2AMy/Pg2fuBioT8B+90d08UHLiN71ssuqTGOQi
         iwFQ8I3Bl8bJ8qFCReZbnO2Sw7gwQpqJLrdQ3ZZk5nzGebiU4tlkZEvCyRyPrxeVPcCa
         UH0bxoK89e1HD9+fXLwigcKk4TDEG+mucWRGTYLvhnaEUjKa/TKFyHZVR3NFYKNZ0jeA
         pKmDInEXayjHPIYqiWfTdxvKLdAVqzXP6CuG97axr0iitWbLKoA9bTL2SvbkDZEspCrZ
         ag6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713757274; x=1714362074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl5iDmcU+vdD5ORuT+ZmSbv78xBtfXPu+m5CHFPkBDg=;
        b=OMZFnVq58U+x8lqEnj7JJyEUgX+NlyWuWVMB/5SL+4bXNRw0B8Nj23hkW/Qs8IJ4nI
         4JXoocWUdhn6QuE4JkVWDuvLy5N1MxPNzRqZWIR6h8nnHEM1cBv+tBsDaKKCzolR5OvF
         ryOIyC44IuK6F1gc9vrD+LRPU66M710BOOe9g0yCnupPRlZpp2Zj4Lpqr/2QcdzFhele
         zcIMV1l7vtDAF0iDN3FAp8sx2j81Ud7ymox66CW8KEIcMP3Jb4qvSpqG+Rt3tCEJQDPF
         Xv+LiOnMo7d27cD5vL5EvGnX+nXSXukhyn8vJ6LyhchY/sSGfOs1dNaF/NC0Yfc5ZTYj
         JdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLUZHjsKy8g+Fx7piIzpi9E+DxRZy9wm5Jv14RCI+ENK7SQfzCsaQ3uJWxlte/U5kHVuE3BoTnnJg2Zmh1QXvAswScSF0WY9JR7FHo
X-Gm-Message-State: AOJu0Yy4MgCOTxNWZfoUXSx2GqnusRn7hZEQtZz84N7U10pL6guzLquv
	qyh90bqyyN9avxChSD+xR3ad3SOUWhiaS2rT3mD3MeOo3LG4RC6afOrgrOnQuko=
X-Google-Smtp-Source: AGHT+IGk4VpEttqtX7wmUP0DjSs0Hnai1BKypHYXOPdM34VHuqvCdINyqmTAuf5HKKeFHylZBh137A==
X-Received: by 2002:a05:6870:c352:b0:222:99cb:2215 with SMTP id e18-20020a056870c35200b0022299cb2215mr10754338oak.28.1713757274492;
        Sun, 21 Apr 2024 20:41:14 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e697bd5285sm6803551pfa.203.2024.04.21.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:41:13 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:11:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Add support for MT7988A
Message-ID: <20240422034112.rugixkqrbeyq44zq@vireshk-i7>
References: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>

On 19-04-24, 17:59, Daniel Golle wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This add cpufreq support for mediatek MT7988A SoC.
> 
> The platform data of MT7988A is different from previous MediaTek SoCs,
> so we add a new compatible and platform data for it.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied. Thanks.

-- 
viresh

