Return-Path: <linux-kernel+bounces-133787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C989A8AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6DB1C20EEC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725D15EA2;
	Sat,  6 Apr 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUtJQrSK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4294748A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712374100; cv=none; b=Y1hCPz2l43VmMc2ovjTiLSZklDwIDEtabsiD0m4fD2TC0bv6LCiu16BJeqY9IMDiFRGLoxqD+3MJqMgZ8paiwLSJGGEdeuadc+2QAZfuCC7T7TW1/FDI5R+27o7tybWTO7Z1HFszewIWo7ghoJ3h9d9caAeRCFGGqtd/RlYlZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712374100; c=relaxed/simple;
	bh=fAFJor+9nJNmD/ci6us7lxxXXzZRDsJIO9AJ6zvVSk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNTuxFWq+qAdRWw5/j6D6PgIefK60EwWZsd1X1qX7rWGk6UfjFqXxskgbTPlBviNF/5wB4Rm7/P6owOcnqlCYFin/o+fjU2Xd/no6aAt44E+fmS4USal7xlWCSZT88nnNeB+bsbeIbv/0gbM1Ul6ibqVMSe06c6VHTdSpHkZcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUtJQrSK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so32876431fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 20:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712374097; x=1712978897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfuelYCmVaPnXJqTFgO1Iq+D/XgR90NTWOrZt+9baK0=;
        b=uUtJQrSKjh78/k+ml6qiSoZU+5hzkIuaUYcZkip5yLwQOSc2zBQxslOKOxFTK2ud90
         BEZzcHC24R/HAnr2t2KJfFMtctNhVtCgzwahjFZYyOEMaHeI4hbC+3pJLcUv/SONQFfA
         5UiFIlF88jMTZgPYH5FSu0yMyeypODjdBL+yLWpfxc2GZpx9WocufBa9u09oRS22RYeY
         GVOXqTEDYMCwxJCiG4TTIWU/tucM9YEWTHNelSu83Fj1THGEgtFRZ1dgvlJCbUEhja7b
         7odYC0cbVegykaDVbpztmrjZuBI/p9ty+WkMfjAsUg00dEy6SCsYxD0ZOTDWfdkWvq9H
         Pyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712374097; x=1712978897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfuelYCmVaPnXJqTFgO1Iq+D/XgR90NTWOrZt+9baK0=;
        b=E6foTEIvNyjsa+wnOzhvwK2RmAO+mDSpeIlVy2ZcLbrFVuQxYIJo0YxdLzToLXGX6e
         c8UTzy0GcTRFwwaadbTeQI3hSHlqYcOv9TCpd8IexMbCU7SkZvKSjgur6cW+tUPfeF1H
         S/o5OlLrEQatsaz0nxnjJ2clYCkB32hm5r6vwHEIUd7wouRwW7i/lCkNkP+0bu8IqvNg
         FO5+KvnzecMcSI6ODGjS8J1jeW5nkqnxDkATG/WeQEjQOhMKEEbMi+6hUaX/Ek4JcjNz
         8kOd5n56IGdNIq7aHr+SWilR07w2jefi3FdU1fWxjTwnml3hgNEncceVzgMSpPM32Dga
         jEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWAHtoQJCNg6K65B38Z2qfBPq9JPnjLqEXJ6T7Lpr7HLbbRSVe/3NtN/01hn3+V9ROoMcCRfMe/ZN4DuvxgjQHXLYY27gS+BtIYMHx
X-Gm-Message-State: AOJu0YzaPp0+Dj070D75Bj8Rm4XdSrNU1N7eT8/dBAtK4wy4fizIEgC2
	6nKmWhg2CB8uSm0l4sLOfERxVLNBFnh4oegMnIuJ3qdxq4dNDO/JmnXi57V8820=
X-Google-Smtp-Source: AGHT+IF3i8+vhLbIjnsL8VphQV1PmaT5a3qc5xWE3KaLEQtmXPGg+H4Zi7mDhaos0rILE6f8KYcCbg==
X-Received: by 2002:a2e:8704:0:b0:2d4:1fa4:9eb8 with SMTP id m4-20020a2e8704000000b002d41fa49eb8mr1830431lji.40.1712374097096;
        Fri, 05 Apr 2024 20:28:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id n6-20020a2eb786000000b002d0acb57c89sm333260ljo.64.2024.04.05.20.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 20:28:16 -0700 (PDT)
Date: Sat, 6 Apr 2024 06:28:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] Add SMEM-based speedbin matching
Message-ID: <wrvndv7ybn5dcnd6n7d62luwbogmjjsvqh6i3ow5exc3emqexk@n6b4bkydy5n7>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>

On Fri, Apr 05, 2024 at 10:41:28AM +0200, Konrad Dybcio wrote:
> Newer (SM8550+) SoCs don't seem to have a nice speedbin fuse anymore,
> but instead rely on a set of combinations of "feature code" (FC) and
> "product code" (PC) identifiers to match the bins. This series adds
> support for that.
> 
> I suppose a qcom/for-soc immutable branch would be in order if we want
> to land this in the upcoming cycle.
> 
> FWIW I preferred the fuses myself..
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (5):
>       soc: qcom: Move some socinfo defines to the header, expand them
>       soc: qcom: smem: Add pcode/fcode getters
>       drm/msm/adreno: Implement SMEM-based speed bin
>       drm/msm/adreno: Add speedbin data for SM8550 / A740
>       arm64: dts: qcom: sm8550: Wire up GPU speed bin & more OPPs
> 
> Neil Armstrong (1):
>       drm/msm/adreno: Allow specifying default speedbin value

Generic comment: as you are reworking speed bins implementaiton, could
you please take a broader look. A5xx just reads nvmem manually. A6xx
uses adreno_read_speedbin(). And then we call adreno_read_speedbin
second time from from adreno_gpu_init(). Can we get to the point where
the function is called only once for all the platforms which implements
speed binning?

-- 
With best wishes
Dmitry

