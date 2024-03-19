Return-Path: <linux-kernel+bounces-107310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1887FADD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90370B2170F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB67C6CC;
	Tue, 19 Mar 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ur5sHkaH"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F87CF27
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840999; cv=none; b=BOIUZc5Bwd0nZN8aU3HjdbNu6upU478sdyCh8OOpIJ894xxZWa2v3pJbzJwLV8DSTSWfN11NwSWcbZTAJVBzhPbXQGTDChUHu0kl1ZflCSdlI16QLDf0yPEWj2rWmlwQXwe1pytKqn6/paIIZua3KjSUQME9LKSy8Q4eBwDnxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840999; c=relaxed/simple;
	bh=V0KFxvnAtrXSOfjvHQg7knauss62x8U+7KogQn+yF7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbvDl+TO9Z9IKTX28zlGw2MsH1kAOMQApWqi0rVWTlte7jx59/AO9xrs5T68w+Kqa9CuOMwwawNKMzfUjJvuaDAGKVh2bdtFFOIWXKDmUFrzULKO4o7t5gk3r/aLnnw1ijpZ40MlssnGKRy8mGQo+OUG0D2VZAeOXvlJjMUhjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ur5sHkaH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a0599f6e5so49355407b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710840997; x=1711445797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0tE4rTRpsmTL16kdGX+KFzRwJVG6ZUmpKExRxozggI=;
        b=ur5sHkaH1WBCooEn4kzGlfv0xfwUj1BPKByU96pD+V7cV8qLZbf9SqY0QcIRcB4pD3
         JygIk8+g0480VCiYNj6AF4Pf3B87qxYmjy8RDRfTfV6tEDpkZvr2WWr7KcI+q6ti0ZX/
         qvUjiFsTdy+FL9C0wJNNd5+lwg09/AlZFgZSb4oVdlB2rfCjhfN7S0T5m54c3G4F5vMG
         corZjYM0KyWV9MBkcxZlVURwDXu6VbNsyHS4d1/6KrLhBj2LQlJPLhaR/iD8FXkljMzz
         xR8jJmHA7VBLhyplUjzZ3KaLz6G1/H3oOm6WThqrrV7MjdZh2Y9OKPHEcr+gpV4RA4rv
         m+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840997; x=1711445797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0tE4rTRpsmTL16kdGX+KFzRwJVG6ZUmpKExRxozggI=;
        b=gHMYwJvzFMa0H03Ybh1olJFu/vv8xZXNnF40BM/S3/P7YSEMZrZcQ4UUylWLpf6tyI
         GdXgiS3j0wwiXCIYaV0PXbN/c+i+3Tw7Opo7J+jTs7D22wdszn0+wmUm4Fz/Tms5EYUy
         vTGSaKt4Vf2RK6Aut8zyKBGkoSH7j7Os54DZej5qgBGvowFl7sn8qDRizbEOqauDb71d
         0eMr4qxXxMHoF/EI+kfFFdJUUAGSs9DhAKHKjPEZT8yWzRIoeuSLnUYfCSgnKKUIcCOG
         VPAq0nfACvPZ1Hcwxe63mIzGtOynZs+aBJI2d3naSnLoSXJMrPIaY2FDvET1oouUmuqM
         9tBA==
X-Forwarded-Encrypted: i=1; AJvYcCXCOx7DMasWNefiQ1EpzNQkIlsx2ekt94MmA7l5Ck2akqgzVWIGRNdLLkd0llEhoUuJx9DG+YMRLAg9CXDt9AW83P0P9JuBJUfAxUDg
X-Gm-Message-State: AOJu0YwjxWAqayQCF7+PM4dnNKtrBDiGENhG8buR2Y97A2738o/eE3Co
	ezLkS6NiL0a9XtDuxnL/ZJzyVrUWeouojImoIYqZlh5pALx2jTXu2Os6PGHATE9MoAJqvWzU70z
	whJRhmfTuykuo7BHwo7zZZFOFNdAsV0O1C+T1Uw==
X-Google-Smtp-Source: AGHT+IFuWQSJLHTIN+PSrx6VRbyj8bCDJjySSc07ahzVtGH46dRpslwe/Jo5mgbf3sHZSjSGNrfPeFwn5DSGSqdzqaY=
X-Received: by 2002:a0d:ef07:0:b0:610:968f:c8d2 with SMTP id
 y7-20020a0def07000000b00610968fc8d2mr8021450ywe.39.1710840997353; Tue, 19 Mar
 2024 02:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319090729.14674-1-quic_kbajaj@quicinc.com> <20240319090729.14674-5-quic_kbajaj@quicinc.com>
In-Reply-To: <20240319090729.14674-5-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 11:36:26 +0200
Message-ID: <CAA8EJpqgFcBetRRFPQbG1WKHpxqO3tVQ-Yn0k7a+GVx=WN9AWQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amrit Anand <quic_amrianan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 11:09, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add QDU1000/QRU1000 specific register layout and table configs.
>
> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

