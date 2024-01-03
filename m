Return-Path: <linux-kernel+bounces-15021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4763822647
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F0CB22C0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F9A56;
	Wed,  3 Jan 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbEJszu9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E1186B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbe78430946so1577332276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704243960; x=1704848760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NqaBZ5ZyGN0qCrSiZJqfeYkL63UJxOvdkYrMLygBVV8=;
        b=pbEJszu9TRnbuj2T0jlVUZNLpR2OYipzqOFra84fQPpbohcOChmrC2pJVriMkxP0O5
         eNiFkPTAwpeRJgmLRti7o4gRAXWfhpeAx9bVvV9U3+ZYfF9PAFlW08J69E3lwvS1zOQp
         3kTgF9JZU5ze6OJBYEvO8SEA8o2ABbp2V0HOsA/9bKiXNd/MOY34xjXThMU2a7d5j3VH
         bNWOJO9wVpxdlouFe3vALFk/EQcJc36i4aY7cpnz5yJ3Os7QyL7RJeEd/BNEIPRnqeoA
         sygnQOjfGaDoHtwRIIeDrb0MfhvBPbgQcqZtYNW9nvtOTlcSmYBWzIETeWMmKqyWjcUv
         yFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704243960; x=1704848760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqaBZ5ZyGN0qCrSiZJqfeYkL63UJxOvdkYrMLygBVV8=;
        b=IKZdJX0vUWFiFLpWeqmiyPzd/dYClURs879lq6Ksy4TdkmNhNd14SOc/GoYe9YSoUz
         yzu37naCsHK8bfl/KYRk9V9TPQHMEMkXAAxMwKyPA0EGxetJEgAav+E8M9mm0UAHi4xg
         av7LN9MfK8dk0lQMi5MBKJpgOd7GCSH7uVyaIQNf6UbZRb/IMB0tno58RRxqSm7tXDyb
         oXwrgX+A+fHSNKv9djoyLneoMMZgtbv2xjzHzc6JpFM+Mt6LuRXPgTPc9ZjixoO9JRJ8
         c+CfjZs9ekkOXG1LYXm+rzpXGsamqRSsZHyK1tXp3Lq9y8XkAq9PDonPU9MV8WaMNjYR
         o1qw==
X-Gm-Message-State: AOJu0YwKsBoEVCtth1uuXTxGYskwceTUx9MfM67V7IRfO+1dnmG6L3VU
	ERuZ0QM59xnfjTS4P2AEpbwLaK4zmm3YbCP7kjH0TsxJdleqrg==
X-Google-Smtp-Source: AGHT+IEKqzueSGjGhDnn8BV+aSPd2umkf783ItN/kV6MouEmUsL1oIPlhFngZH7krg63ypHVq2+c0Hm+iBfe/lsjcSM=
X-Received: by 2002:a81:99ce:0:b0:5ee:65b3:f3b3 with SMTP id
 q197-20020a8199ce000000b005ee65b3f3b3mr6655357ywg.9.1704243959966; Tue, 02
 Jan 2024 17:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org> <20240102-topic-gpu_cooling-v1-4-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-4-fda30c57e353@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jan 2024 03:05:49 +0200
Message-ID: <CAA8EJprb-vwuz-MBmJ3ThsidPS_P7NSxTnr+rM_Ld3xmKU0xxA@mail.gmail.com>
Subject: Re: [PATCH 04/12] arm64: dts: qcom: sdm845: Hook up GPU cooling device
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In order to allow for throttling the GPU, hook up the cooling device
> to the respective thermal zones.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

