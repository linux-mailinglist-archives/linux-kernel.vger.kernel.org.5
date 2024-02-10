Return-Path: <linux-kernel+bounces-60386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D485044A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B98D286EB9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D873D55A;
	Sat, 10 Feb 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neiCbBrU"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1933AC01
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707565891; cv=none; b=rECwoIUdww/+LYoADZGU9WPkoMuJJEB4N38C6E/pCzSr9B+MP8xoE2O3CuovjO998PigVrIyASqA3AYktIbRLyg0cpOtqyPvkq25MXsnAAu/hBFPDndHzZCZOOhHm/f+4IOd2mYqZkmSUwC3GghM9ON2J7G97fs558kv4WhgIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707565891; c=relaxed/simple;
	bh=d2bhTf4Z57WSx4lUzzEf8y7rKj3Hg0um3/bM2pKPVCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nud4QXaTB1GQwPRnZtzUFmO4JEcjblhJqfsAD7hk85XkxkDrqVSgF9IHwe+j4IwtEy1YX1Fjp17xcDIT2dh1zL8LCYbOSqApzx7jQUuYo8LOHXr5928EFLIHPcz3VD7Jemri5vUNU5mfnS/Uk5Iznsmqe3SMTMfMCQJfnLQyhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=neiCbBrU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74897bf61so1852722276.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707565887; x=1708170687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4hzqQK2jDc7gwYXhpJIcj9gdQgitPUMD4wx3zzHzg8=;
        b=neiCbBrUQyJQ/QNNTUBuVi5wH2JMVXcM8/83ZSn7a/lKETQnwkGvV9311cV6YkDMgZ
         7bzvkG3v19r1q4i+SsCqS27qL6RMMA+zQLLA4Ah7YpxIlBcxjO3VDyMJPAyIL5HvEbwd
         bN9RuzdeIlc/jSRNH59ixi72b3JEQ3lZsYsA2FWDDr/hAjpWDbtWPiaBDmUyKR335j+J
         /o4BfHbhI476O695g6wndimKRwS4Cz6Xe+oMg3ZUAUfapwrCe/SXrKFRkJo3qizC/BnQ
         a3QGEMXS3z3LC6nR7HBTayrqWLdp52z0yqQ7NdWcrzeUfVygnGRRiQLB58A4ZCQFWwAJ
         6OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707565887; x=1708170687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4hzqQK2jDc7gwYXhpJIcj9gdQgitPUMD4wx3zzHzg8=;
        b=cEr+RlkltOhvXMgjfPfVtO0paUZ4SS1cpAIf77Xs62rl67H+XnzbDtSyKzZWoMyRAm
         nkMTN+6QxBqay+D1UuvpgqlIUr66bP+VoOivheT2D0dOZ6MQRyxMaCM6wG3RCRTHH76+
         ZtDuL6mpGYi2g312wEzBXyNniE6nYIBXX0N2/KUnlorG22ubbgrifZz2j8wQrHbwTw4U
         cwDiMmQTyJDb+pdtU589xfqM2WSV8Ibcqt69xuxQL0XULs2NNUzVl94NkkWTHL/Ii2D2
         phylQpI+HiUjIndqpHr+rss4dm8/xisBqqHmhCW4l8rKu3RGUJbPkM+Ta+A2wQJmXGjy
         NfHQ==
X-Gm-Message-State: AOJu0Yx4Phjs18nwxscTxnCL+mdQzAMcJhLywa4uz0FlD4gKPxxYgPmA
	Nx15cJ4P1k6BoDcaqhoCKVdqcqJ26/dh+wLpyFyaq4gMkJWjQYLp4VU/dAGW4ICYTqfR5oF1ZpJ
	i0hTQCoFnoaLXWY5k0m8qJZgypTT1UpWAx5HV6g==
X-Google-Smtp-Source: AGHT+IHmuc9OItSNKtDEBBJS+z3L3A0n3p2TRNTXhKRlXEx8mZXeoTapnJ3NEc5+DGezVvje2FB644OYHRQtnMjnuYE=
X-Received: by 2002:a25:ab8f:0:b0:dc6:ebca:c2e8 with SMTP id
 v15-20020a25ab8f000000b00dc6ebcac2e8mr1458918ybi.5.1707565887676; Sat, 10 Feb
 2024 03:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-20-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-20-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 10 Feb 2024 13:51:16 +0200
Message-ID: <CAA8EJpp2wqK3vEkU7Y3BxUKsSn11B0-X7LNF-w+sJ91bPTAVhw@mail.gmail.com>
Subject: Re: [PATCH 19/22] arm64: dts: qcom: sc7180: quackingstick: Disable
 instead of delete usb_c1
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 09:16, Stephen Boyd <swboyd@chromium.org> wrote:
>
> It's simpler to reason about things if we disable nodes instead of
> deleting them. Disable the second usb type-c connector node on
> quackingstick instead of deleting it so that we can reason about ports
> more easily.
>
> Cc: <cros-qcom-dts-watchers@chromium.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

