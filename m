Return-Path: <linux-kernel+bounces-34-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FCD813B04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341D0283BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D4697BD;
	Thu, 14 Dec 2023 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCefnvKK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C25697A4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3364a657564so804263f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702583475; x=1703188275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f33MOLhgSxj0L7stEkHGOZ/2ZSoJY4toq105HJFrUUg=;
        b=yCefnvKKaD7oix7HzSTJS+tybbk8cukASMJdE3/b7koXi+K0g5bMW4Y2402SRtCdak
         pE8fLHRx7Ndc9Wu1TAGCquC+BNJkRmVDxrhJXnv+UmGRmdne3FtVwxYQzFe8rNAKNdif
         jcVQk+ybsD0sXGpqW1qOLQVUE+bBAHTcpoXRvq5urX1xfoxaDIp5jU7lTkggeMUAYHyA
         2iG7R5Yu3mY2bDVzW4VHJD16oieses8hnK7KlBXbIYIwq/U0ZfugEXSRaRLDZ8E2PU3Q
         3GL3VoXFZzWvoVmGBUvTYoZ1WDokVp3Dr+YLNq26o0UaVm9faI2KapFyvyWVe80LpIQ7
         tfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583475; x=1703188275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f33MOLhgSxj0L7stEkHGOZ/2ZSoJY4toq105HJFrUUg=;
        b=BJZE/Adt0b3BYQl4TnjZtNp8VEUk9h/y+VDiOYsxyVdzOn3qp/bd/yc4C+ZagCAYaA
         vrZ/1uxv+MTABgab84qVdnPqS8AFWq3yNiJk/yP/IsY5eNvECMrVgpVOQGMWCl+1KumB
         Pl31+rQaLC1GxX/bsI9ErVhtWMw2wl7QxYvzhIRLSKl1B3qAINXpA5jGhDpPeX/fmYhX
         myjSv5XcwpXaKV0DiMRnoTGyWhSxnar+j77dNn6hqjk1bUiCKlnYgiPzyURSx0u95JAi
         yFWBPpXZS3V5hGT6gMkzg8nKI8qo3M5PRjtRt9bzcGzxxCNwTxTNoUOyCnmpxYZh3zsX
         cBQg==
X-Gm-Message-State: AOJu0Yy7aRHGO6timVzd1CmBSRJUbwJCTxzFwF0NiWvyT3sbc4+syAUC
	1tqF3SKxpbfOYXh/4Xu95321IgsFhwKOby6u5Nc=
X-Google-Smtp-Source: AGHT+IEkkYiApiWausYKn5Xv/P4LEe9lTaxkqYf+El1g0RB2qW1Zv4b7Nd1+0MpoiuA5B/BcTkQJYQ==
X-Received: by 2002:a1c:4b10:0:b0:40c:32d5:18df with SMTP id y16-20020a1c4b10000000b0040c32d518dfmr5188548wma.182.1702583474711;
        Thu, 14 Dec 2023 11:51:14 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id mm19-20020a1709077a9300b00a18c2737203sm9913085ejc.109.2023.12.14.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:51:14 -0800 (PST)
Date: Thu, 14 Dec 2023 21:51:13 +0200
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
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: Fix supplies for some
 LDOs in PM8550
Message-ID: <ZXtcsfbxl++KO0HM@linaro.org>
References: <20231214-x1e80100-dts-fix-pm8550-regulators-supplies-v1-1-6b5830dc337e@linaro.org>
 <b578a34a-0e7f-4175-8051-3d2340861700@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b578a34a-0e7f-4175-8051-3d2340861700@linaro.org>

On 23-12-14 20:31:46, Konrad Dybcio wrote:
> 
> 
> On 12/14/23 20:24, Abel Vesa wrote:
> > The LDOs 1, 4 and 10 from PM8550 share the same supply, the SMPS 4
> > from PM8550ve. This needs to be done through shared supply approach
> > otherwise the bindings check fails.
> Not only that, but Linux also doesn't parse it :D

Good thing they are not used by any consumer (yet) then. ;)

> > 
> > Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks!

> 
> Konrad

