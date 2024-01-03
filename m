Return-Path: <linux-kernel+bounces-15029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E182265E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC25EB2254E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2715BD;
	Wed,  3 Jan 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwC8abFT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEBED5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e734d6cbe4so78106547b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704244101; x=1704848901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQZx6mFOYirIUAArcj6mBKkjCVrYW4c3EknIHib0Ab4=;
        b=qwC8abFTqjtWgxswQDXrJb8BziM9tRW3dKZyQ/eENex7LDu0L4eHrKH3xjil9F/aAD
         8yExgZQeKmAc/I2gbOEJowKI5k9QxxxvPwQoLCmykI5z9U3jYUC9/DkfBI8vN3aY8pHj
         MLHTYFgLa0KZdBwxiuDedG2wJRLYC0I9HO9SpsmlRfpU6kIwQB1zTk+WDAtjmcTQdFdx
         sfZlkRqADcFyPguZKNI/omknfuZBhJnD0ZkF2F2WdQikH2p4n3y+hib6fFaHiM/qM0ar
         IfdfWcZQBQa2UQNWVFuYPo3a7ELrNyWOkmMBwpKYSUVQDVDk0U9J3Gchz3TGhpiW6QK3
         FoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704244101; x=1704848901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQZx6mFOYirIUAArcj6mBKkjCVrYW4c3EknIHib0Ab4=;
        b=ilBQ+f06saxGSszk5TdPn2IgVybCCIzFazy1Ub6zcJrqqNoyquqQWY8DPvBv9d6ghe
         ovIz7UPKnId+We+jgnhQ3NupdC5cqrcO5GDJe+LPlRThW22oILLCDdx3OWWgi9QJS4uo
         oeyw/vqPcd2XYBMgTpbXdG3SLqe7s22NfQQgF+2u+/FjgfrFet4nlF1mKOVn5eO5apdc
         L7rwQDN4o+slG3609XdvZXFHEFTW0PHEjv9ppK/cvgCli9n8zNftkVB0G6C4uzw96zFr
         fFIwhrLAawm7eLKQHYo0/SvP+YD8G4t3K0UaX5KA7S6K8UcQ77sPvedfP4AnJEoLjX/m
         k/yQ==
X-Gm-Message-State: AOJu0YwR93pEJfx+gxWxS9IMdGBWF+fnUUZ8des46x3lNplzqfsSIgOl
	oFwhEV9QMTv6fB+3CyNWL8Rp7ftH2qGgIWTBRU3f+jZUbeuLDw==
X-Google-Smtp-Source: AGHT+IFLvYmlISArL8/w0L24/AWKtV7noKnDHAvcx8j6L6HiRiGyB5/Lo6NZnVbibRNZru4dx8wEQgiFkgLuIiFLimA=
X-Received: by 2002:a0d:e60f:0:b0:5e7:731f:cbfd with SMTP id
 p15-20020a0de60f000000b005e7731fcbfdmr12950767ywe.42.1704244100985; Tue, 02
 Jan 2024 17:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org> <20240102-topic-gpu_cooling-v1-11-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-11-fda30c57e353@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jan 2024 03:08:10 +0200
Message-ID: <CAA8EJpoZkAExZmhxOpYy7E5s_iu_N_eA0ZkXQx8_s7B+kmivZA@mail.gmail.com>
Subject: Re: [PATCH 11/12] arm64: dts: qcom: sm8550: Hook up GPU cooling device
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 15:38, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In order to allow for throttling the GPU, hook up the cooling device
> to the respective thermal zones. Also, unify the naming scheme of the
> thermal zones across the tree while at it.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 57 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

