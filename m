Return-Path: <linux-kernel+bounces-156499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FE8B0364
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548C31F22F86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555B158A15;
	Wed, 24 Apr 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiKB/SB3"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15715887F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944541; cv=none; b=UnlQxRjpOZq772Lqj/nPqZCTZCM298rFeyjg8/1Ctcdnv1jIW2llLcvoXbZYVev5v/HBS9qrdPUjw9nRJSNcFxYmvzCanrkYkoUnr2/JCPjUEARUXrOCCLPU6HkKJBKar0RVRgWDSXm5nDrxfwYP56yTGhmBLbTLnmZTwGfDQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944541; c=relaxed/simple;
	bh=TssNSTkU02ETewXf57xR48AQxgqalns/Ypi0mRbyXZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwgpLK+okdhFWRL8JfjOYiEE6n5Ho5QuDRzUxAB3WwLw/wVyWq94tbx+UZcvRlETjJDEFnZDR7Js9bbNiK/NFDkrywAWXHzYzCHuvu8BmD0q67Sm10pRgODadZyOsVXYKjcyCJQ/PQ3iBP+jg0JrLUmfUotcwJG/R9x4UY4HncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiKB/SB3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so581082276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713944538; x=1714549338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mRvWwbSTRSDRgquyaPNgxSn6K2zSKXHfiHyv/56g4k=;
        b=MiKB/SB3Mwv5nPYtT7f+Bs1S+U3tSVMkMh+EGAmpB8IWUPjW+r0VLmacU6e1lYXiBS
         TZ/Ca1s7dugjaEQuDXuYkgsfoHHXdVwHk7FGrXuZP9OdlZ+BQstx7BHfRbAswuO1rLeH
         uBXoT7GSjMDPJuR2iTLLuoo/CtGHxaf2/OBt+UIfFJZvp0fzLSTyw8gWcPtgS7Yrih8X
         J+4LfrHdyqIfMgT1eVvalyGQE+73bjtAQM+018WNS1RPXeCn1mhbxomCb9SwrwJI1UdW
         QySYNUT8xBzT+lCRyJ39/ZodrqDnD1dVcGGklgB9JaDgAYIBnUtLksy54q13wbMY7VVu
         io+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713944538; x=1714549338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mRvWwbSTRSDRgquyaPNgxSn6K2zSKXHfiHyv/56g4k=;
        b=ttElY6Ru4SAq8U2NnN3EQ+mh8inxZtZ/gTW6ok+aJmTxkvjcB3lIzoCwHZfcmPgHQ3
         yRUpil7OJkoPUI2cQIYTPm1K8eBERf8DdxsaBd2ZWINTuKW3IUcLX5DSc13LQeb/kaUR
         07xHsGgmX9/0Lol3UIyqy1lBQBNAF2gBh0YM9YJvSKc1MDd8H6nbvlrhAChMez25w+Iu
         T2PiBSdPL7/W24bf848OkvdMOUc6thyqjZDf2xGoU9EaUZYkYmCiJzio281piyXqXIRf
         lHHdrpiiGR6H5n6uCWhGqIkDjYZ4vwcG2+I+cDXhR63eNQL3v6JlI851dXAkyMBSjxu3
         Ftqw==
X-Forwarded-Encrypted: i=1; AJvYcCVURZniPLjiLpjHPbzFRPmzCS0Bi+ZQ+uJc/9/yriKxvWUYBEA+W/SEPSbFpu84+EXYVozkI/nfW2PU5QTp+BpHRbcZVmLbHAZ03MSr
X-Gm-Message-State: AOJu0YxmTe1U+tn1Z6QALyu3CYQMw287YQ89OHV+RaKJD/AJCJRUv9zW
	nv1ZFgLAeZfC/0nn/Av0TMvb72ZyxmXcukg9yZTNpb3HH3XRu5O68P80EykbljVvNvuyeOaLnBx
	JfNb5EzmbzZb9ANgvXp3Zol2zwApNFnV4Ksu+Gw==
X-Google-Smtp-Source: AGHT+IHuKrJVNbPoqLVP80XtcoLq178rizYtPSbNTv7J9WOJxPTl8IY09CYRGmbED2RPK3HREQNd2sXZrcy4rzMQj8I=
X-Received: by 2002:a25:ac63:0:b0:de0:cd0f:e9ac with SMTP id
 r35-20020a25ac63000000b00de0cd0fe9acmr4086794ybd.31.1713944538616; Wed, 24
 Apr 2024 00:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424054602.5731-1-quic_vdadhani@quicinc.com>
In-Reply-To: <20240424054602.5731-1-quic_vdadhani@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 10:42:07 +0300
Message-ID: <CAA8EJppoW9k835oRZxQ2q03-m3uVOc4QfjwLWvNvfjF-jiDavQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 08:46, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>
> Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
> buses usecase on RB3gen2.
>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>
> v1 -> v2:
> - Move gpi node to correct place.
> - Update commit log.
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

