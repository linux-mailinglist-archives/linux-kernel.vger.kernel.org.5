Return-Path: <linux-kernel+bounces-85286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAB86B37B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448A11F2BCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E115E5AA;
	Wed, 28 Feb 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X44IyKpN"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA515DBC1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134899; cv=none; b=N+WF3b0ZfrPl5ZJMwJVf5XT9+AcW247FTaBEuo9zGJjS9zULQp95Uc5d6vz8LCVhXEkvc3bdEynvirZSyEm+uIQi4OFVMnx3AAIt0Ht14MrDKb0biQRQ4uNQYWE+mAibMO0eqjmbrmYFhvWFTxQC6LkEwxE8gTUpGqSFlG3PmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134899; c=relaxed/simple;
	bh=Y3CqL3ZtH8qv+iuGi9/RE7DcS3/Oa1WDQHkXAOzWuWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDVt031R/rq1sIgDvQzvKf+UWXE0/NAqPXJ//nuFiq8se6JTyRTJIaNeviAwDjyylxlUjnJm8r88eMQGImqFnPGc/y8K326QxGj2yADQQaELMU82c61RVZtlMERJYgze0NMAd0xYQO/2S0HIYTcNLnXAZ4SmTiOxBRiRcgfr/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X44IyKpN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7278688a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709134896; x=1709739696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUg2H32plNGlq0vHABZiW3cHIK6mnZ+TaVaS2PgJthI=;
        b=X44IyKpN0Jq1Oy/R7g+eEGcAj+NhfzZPl7T4kDdMZUrmnZ9B1rJb32z4g0XrLsZmZr
         ApupvEm0tYxPfqjAhjmJehr5lI/u3whZWNwdUSWJP55BuGxA6VHyUONIjphNeBAPOBmO
         GcAeOlR8yaXlLq2s5dQ6oZ7PjYR8oUyObDFl8jcwCeMDr0Nt2nO2aYTbq9c+OY8SNfAh
         NdqDs8XQMMOSUOYd30gT3hJuatcB6oYaErgizeeD7NX31dzXFWh0Gg/D5XQRzW2W9Qpb
         wBuTwJOJwrbkkDK0bBJV6DulGhoqPLIlwWkgwkK9GFbGkP0JItjRhVz8zfF6U5PHPaJU
         7rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134896; x=1709739696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUg2H32plNGlq0vHABZiW3cHIK6mnZ+TaVaS2PgJthI=;
        b=SW7LsNVqrjRc5ZbwhYYuhMB7cQUyD9RQMFxPAkmCMYxrF6DXjSh7zCgvE43EJmWUsj
         TXsegmXbvCiCIo0MhnuF1ZNXSPQzhEzuJEult5KvDkZb60DvCTqk2f/u0uBzPCjoYo8E
         cwqdCHm7Cx2c9xhYtdDwOElbNXWGe2eyT9sNV3EuGB6EPwcQ0vY6LYC5lVvNugXuDxKR
         5f1IgrBC0JGetkTDVmyI84bHeBnHAM88fhYV22gFtDtBlxifXeMKkVwSyj594e08UEa+
         I3w2N0Zhlb3D8vIH15xSMwgiH+Y1GdtlifiBLUI9UwIF73RBSdFfNxwSmnqE7XPZcKdL
         8bMA==
X-Forwarded-Encrypted: i=1; AJvYcCXUaU1pg9jiEUsu8njbuYP87nWD6LYw/LdZMoE3ABSbD4jAVKKJQbg0em3nrkVyQAOMCB8wd8o9e83+Ke8Tu2aleQk2V8LtD7CJS/f8
X-Gm-Message-State: AOJu0YzBGaKFzDZlCzYYf1P8F7NCIDCT//E5OLLLI0/uJG4PH1UQmC6B
	cS7KuEbkjQw+2kfntXJ8WOLEEGHM98P0gcjLhQBHDhqLRl4eeuSuMRkGg6NTsyqd9fwvzcngcsZ
	q7iFMo6rRltdEIXtpQUgoBPzfSB8/grCmm7NWpw==
X-Google-Smtp-Source: AGHT+IEdoGphs4qV9yXffW2xSbebK1gxJ1XCt7GmQTsCwVCc1R6Uk48iHbYCDQmdSAdkDcUcqwe5iX6aNn0qqtrYjDA=
X-Received: by 2002:a05:6402:556:b0:565:cbba:b79a with SMTP id
 i22-20020a056402055600b00565cbbab79amr7175525edx.13.1709134895902; Wed, 28
 Feb 2024 07:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com> <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 16:40:59 +0100
Message-ID: <CAPDyKFoBmZ1CW1OrT5WW64jKHnRMw2P7DCc8bRxR18PJhmUMig@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: psci: Update init level to core_initcall()
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_lsrao@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 14:57, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Clients like regulators, interconnects and clocks depend on rpmh-rsc to
> vote on resources and rpmh-rsc depends on psci power-domains to complete
> probe. All of them are in core_initcall().
>
> Change psci domain init level to core_initcall() to avoid probe defer from
> all of the above.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b88af1262f1a..3e5b1150f75b 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -200,4 +200,4 @@ static int __init psci_idle_init_domains(void)
>  {
>         return platform_driver_register(&psci_cpuidle_domain_driver);
>  }
> -subsys_initcall(psci_idle_init_domains);
> +core_initcall(psci_idle_init_domains);
>
> --
> 2.22.0
>

