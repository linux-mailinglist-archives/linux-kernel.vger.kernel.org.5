Return-Path: <linux-kernel+bounces-36995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2A83A9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE9F1C21A38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A860DEB;
	Wed, 24 Jan 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td/2QOCl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CEBE74
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099883; cv=none; b=cwe5NhRVdMHZDRYcyy835t8W5et6GTeJgUWGwaojIWoaFbdNDsokxocfYpY/NKM7YXagtg+o1OwbAjiUm4ZU4Vkp5fZmcvD+0Ksu5RUJuSB+e+DiRWRdxFrLgEgtOU/A0jYbeAg2e7vwQiXoiFRNoS1wTpf1igJm5iWdpVNdBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099883; c=relaxed/simple;
	bh=7CarhI71VUD1zKHMgASvmvAH19o4krLlyNn9Bb24P2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABH8zqmtQ+Se4tCwUPFmogU8VB9WdwimHlTyOnkiY8d4nmAsKB+al/LC7dkfOQnX0TGhsMPPC+syPBrRuWo312WrrCDYpUs5iqFQiPT6dgCSy1a9bJ+achaim75Ku1WRhpHx2d7hoRSBaAJBzLF+wIN92n13HSB8WT9ZwtkLFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Td/2QOCl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a30e445602cso210264666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099880; x=1706704680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOF3NoLpgCBI1PndLI5a5LAEUzAbeXf4T/xw5vWVsC8=;
        b=Td/2QOClgn1QdniGt+/axJkDJ6grPUoQKjo3DBWnTz3/6ocRsbXvj5UGtAkQjq7WJq
         eaaUXwwG7FwCuCm57QF1GjZUa64zcYutUiF0Q30xIXFsfXg5TVYczBoT30EWjXdEXMh+
         jplMWqi8rMfHu+zIL6YNlxIsXCxzwRf4lpzEB4Rb6UVwNHZ+nyINiCknNbFZXJz6Kr4M
         KTi22Tb7LQasGEi3DMsrP3oRMZS8HnsNmsNZs/K0Hx9dxpbC1GdGWMEPvqQyD3QA3nuO
         mW27EAd/5ye34NRzAqr64nlrPflNa6Q0owucSIKxIAEpDWu0icWkJ96Gw7/BTJYKP0k9
         6zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099880; x=1706704680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOF3NoLpgCBI1PndLI5a5LAEUzAbeXf4T/xw5vWVsC8=;
        b=blgOpgo92tIWyZZStVw6mQpX429NpnJ7rP03E2DHMx2mt5FHmXeUXNE509I/xYC1gT
         +u9n5dpR50BnTMOEo1bz5YTj23z9/I4IP9QOVjssh/k9/+vOBZTM0cOlXKefmkifvd6J
         wX55zeCBKvlj2e4GaF1781seJIXnrPt/AEybaBsgdwuQYwi3bP2rbsQzMZhsplhPjo7p
         ZtRl9Lo0BYARnXG73BJcFR7nx2jBYE4CCcX7otKWkOpoE8iBsYYr9XXaywqJcXN6xEuB
         /ipDeLhcE/+mmv8dePa+g9l1mA/zVsTioShJEtueih9aVSTFzbscgzxpFCy+wtLXFJGO
         oKBw==
X-Gm-Message-State: AOJu0YxfeViJEnNnjVmfdzlX7lpgNvd4CzhnrPQV4RebKO10r2Vor1d4
	Vp0dR/R4KPc7IAb2ni2gnUJJpExyM/34RgepCjib2m7W930R0PWbdF5eq8IH4ME=
X-Google-Smtp-Source: AGHT+IGq9JzPGv4Fh9W1QWnPuQcV5i2Pysemez2A+1m9vVG390zE0ZZYQ29psjZ0hm6Eo33fa6uHlQ==
X-Received: by 2002:a17:906:594a:b0:a31:3164:8569 with SMTP id g10-20020a170906594a00b00a3131648569mr577123ejr.76.1706099880319;
        Wed, 24 Jan 2024 04:38:00 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tk10-20020a170907c28a00b00a2d60194466sm12593625ejc.52.2024.01.24.04.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:37:59 -0800 (PST)
Date: Wed, 24 Jan 2024 14:37:58 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/11] arm64: dts: qcom: x1e80100: Add ADSP/CDSP
 remoteproc nodes
Message-ID: <ZbEEppK80NpwqUT7@linaro.org>
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-4-072dc2f5c153@linaro.org>
 <e1313275-ca10-49be-ae68-ce783c3262b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1313275-ca10-49be-ae68-ce783c3262b1@linaro.org>

On 24-01-23 19:22:35, Konrad Dybcio wrote:
> 
> 
> On 1/23/24 12:01, Abel Vesa wrote:
> > From: Sibi Sankar <quic_sibis@quicinc.com>
> > 
> > Add ADSP and CDSP remoteproc nodes on X1E80100 platforms.
> > 
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> [...]
> 
> > +		remoteproc_cdsp: remoteproc@32300000 {
> > +			compatible = "qcom,x1e80100-cdsp-pas";
> > +			reg = <0 0x32300000 0 0x1400000>;
> > +
> > +			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
> 
> Is there no PDC mapping for this one?
> 

Nope.

> Konrad

