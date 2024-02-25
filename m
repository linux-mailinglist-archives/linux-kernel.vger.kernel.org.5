Return-Path: <linux-kernel+bounces-80288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8451D862CED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F0F1F2241D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D0A1B951;
	Sun, 25 Feb 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsvVq1pD"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA641B94D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894037; cv=none; b=jOdZlRfoVyfRN5zHOWNhg6UQILgxgzUxywoUZqMZ0uYjroSjJ+Ede0u63IQpEOEgNeVxsnKzsP7yqob9gE8DjWJR70SW8LFIOG3BLhS6ZfTG5SV2VldMGsQUXW200WpxvC3fQP2VqfixGvrm5VNbJsnDb+tMs7rxlv14scc1OWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894037; c=relaxed/simple;
	bh=orWtM2LUxedNHJGeLMiagIv7Wxt7W0zqoM/kf6ZlpTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDdLQAnaHbFQHZMbwmIP8e7WUt4HIuO3CQRigfModWiXrTmzqfZIQ+XCqDB4t9CUjgPWViHvkpClCpYIpOK333JTI8Ul/fmPkaM9NqcEM2TTYtQSZl4vzOzi0vCTYf6MtCwD8vi+gBLaKfK+l/AQlSPhWsFNxlu79jBH+G9EVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nsvVq1pD; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so2463657276.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894035; x=1709498835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d77eu/FHVZi6zJ1GDoPzIaF8g+AKSzhW0pKJcjrEGhg=;
        b=nsvVq1pDa/F9T/4CYMxDS08Zg4m0Bnwg1WppeYEkOxmQJlBVA0MJE/FhmFypef5Xxi
         XD5ckNBQMftUUPa9qgvL92lOShxxDsouHzhvm1cGifRUuFoBH1Eio3sdMQAsLd53silH
         kfWz2toP/UWA/FEJGBf70GIEDZLzXXEzNoOab2MdPbh07a3GiDvUaQkq0nFFK5grOEAl
         oD5ppdN4CycebhrcJlPN968kY3+nCa7qfdmLMlOpb97JsNJnkyhnhK5gINF7g+gBol2h
         ymlDKz71d+KO6FGO1DSqONx9+soTsBDdug36kwiU9FbvgtrRekbPuORHI0uR3OHpPmOA
         R2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894035; x=1709498835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d77eu/FHVZi6zJ1GDoPzIaF8g+AKSzhW0pKJcjrEGhg=;
        b=f0ECQP+bN3MjgQINCczObSjQ/akgD2LkyCHL0w+wNkALu709J04LUwMJmOFUrEczRO
         RuOqZOizX4tY8NTlZXxNXNLGTsYRPevVdlYP44IMppeEDDLfHDa/E9cucAi0fcfHzPM9
         Caq4yHJhOcfsQLvcIsG6cekfbNjcyPaLi2nb2YhDFScjSOBvaEFE+fKkB323MxViKb8/
         j4MpbOe5xtGZCKz/tMLGkw+oT2u+ZvIwraRbPBBBIaoPfEngU+Tk/Nmzvid5ghjTsZol
         MGs1+wfeCz6GEN0QxS0VZEv9PpeYKNXAmfFV1YfOwve/RXynb1fX76RNtSCxWYiqkdwJ
         HMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSdZkCnBmQ38NXR6t4xWXqmPqrkpHmw7Vqc74KIrNELvIc9qBYYgL9r2K6gnlwOLvScOTcYbRzfZKI06KL4yCFvH9T135+6MF1FHmk
X-Gm-Message-State: AOJu0Yw+VaWYmfpaXe2Pp16cGO+r051VohjHzlu2L1Dsfbr4zqJEHHT5
	Ttd6f+i8AOuY6NXGbYR0LI8a2V5zF1hSQvjsKgfeWwcfh7CEVVvepJwXdfKsoDa2Dre4KQbsPd8
	8YCjjjRZvmKSaMGux4dfzYhDbrGPP3ZguOnP6Rg==
X-Google-Smtp-Source: AGHT+IHTnUYcauY35oVfOaINpJ+/FyG5PANCFBjjE7zzg2RMkicpeC2FUdwaReaUnviNUVeuuUM34JGalg5D0RwPxwg=
X-Received: by 2002:a25:8d05:0:b0:dcc:b719:4e4f with SMTP id
 n5-20020a258d05000000b00dccb7194e4fmr2970999ybl.53.1708894035178; Sun, 25 Feb
 2024 12:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225202545.59113-1-krzysztof.kozlowski@linaro.org> <20240225202545.59113-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240225202545.59113-2-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 22:47:04 +0200
Message-ID: <CAA8EJppZrmCTR6tdJQzv-bOBi=BFtZZE7ZBDFDPo49DQOk1_TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: aoss: add missing kerneldoc for qmp members
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chris Lew <quic_clew@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 22:26, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add missing kerneldoc to silence:
>
>   qcom_aoss.c:93: warning: Function parameter or struct member 'debugfs_root' not described in 'qmp'
>   qcom_aoss.c:93: warning: Function parameter or struct member 'debugfs_files' not described in 'qmp'
>
> Fixes: d51d984c5525 ("soc: qcom: aoss: Add debugfs interface for sending messages")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

