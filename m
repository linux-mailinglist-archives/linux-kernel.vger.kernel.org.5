Return-Path: <linux-kernel+bounces-62995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8378528A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CDB1F22ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327412E59;
	Tue, 13 Feb 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkRlrIVt"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0616171A1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804850; cv=none; b=j8bfK5LXS7tvdgcVyqXVCb/KvJ8r4aTZR7TIo4x3+nMd2LUrjUSMHlZENoZo19dpJzOdsdWNd5FxWznlh5HimjWVd2XXeWNc22aKE/X2JJ4SrZjZXdkhP/izjqeSX1Qv3lRxvg4ShPyN0QxEbJk6tz/BNPww7wKJQtAfe7atqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804850; c=relaxed/simple;
	bh=WSI8jGoehl7pEfJRdnqy5FfnvloMDdkYnJeeNSAa+7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwAmUd5y1+bDYmrD9Lfb4I3XkTVxxFx3n4cgxmNoyalhEkL8PgtvZmgLO0iQTovWeAbeawdt/WZEzbtHlMXx1ZyzGM54rW58utug+kYBHnfktq8Jb9K1ZHBrucCAKls28z26gDi4Cp2M/YbbakU8qhsaDv/XmBAxFhFQTU9H97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkRlrIVt; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2880993b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707804848; x=1708409648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur4VuvuIiaAwMddxcZFRFhOdWSxGyrzbMVOGTTJmylk=;
        b=RkRlrIVtvFWaV6M3Zrjmr2Yqi+eA3QjqrqIDa5SzepyDiu8svTjWicqxRhrGTfdrA0
         kAgqBAYLe3ZgD09cgCkZ2BX/N3c7r12KzBTPhH/cQ4THfetcozNILefdVh/aAiTQXg4d
         hsAm9eDx98G4nd3Em1WaRefzJlB3doq/vrSwQ4X40+xWa2F2A2SYaWMFqBAI8fsIvtz1
         InTlagq/GOtAUe5gGrOK0XMnPn6NdaEF9FAri3tfyPkDzb0TolPA6KTUtHbene5ONIBp
         X/6k5JZPH6t71SoY0Nw0nUVn+45WVt+QG7HKv24AFlTE0M3b+V+Vv0pzhGKvDHn0F1/u
         gugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707804848; x=1708409648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ur4VuvuIiaAwMddxcZFRFhOdWSxGyrzbMVOGTTJmylk=;
        b=DnzGT+d86hM3P/Saswktac5vtX50mWELqfIELslXrCmhxdlfQ6XbCiICQtdtwr6LHz
         MYIPpZu5whZe8FylLPTVkYnIoIE4bJpKPPi4P1zcj8wLFAHB1eWEwatUu6GqQblcUVTH
         EV1PaWrr3lkkElCxeU+Qbp+HUPox2j6oyqHFVvCnqPPkYE5hjsK56VN3ERCjN+nH3XhH
         HMZ3DwAR2vp6R9K7RQCA8s8CHGqOmLQCOx+yqidMVPawW8dUHRXzJDtmsQ18CXsMrhsn
         9QYLScIBFr7dcNflY4JxyQ9G6v54SVInAvbYQu5puEf1iPyFFm1q3BpmvEzjU7iCV0XD
         ECMg==
X-Forwarded-Encrypted: i=1; AJvYcCXQaSJ/vF/Tm7MQ66rajUtpQS/ULSMx5CZi1qLceDgb4gX1TlZMJMb/ym2r3oe6XarR5Q/D/ag4ffBpqLwsSqon9leYYq3F7hPVuz9W
X-Gm-Message-State: AOJu0YyxBHXFcwAgTOyK9SX02v48ibPcv1zTwpsJ8tCZA4X3h/DlI6Fv
	nKo3U0+9hXBEviNd7qKgGKg30L3tEZr8q+iZrBv5d4kix5p8fY/aaYLhgbGv99Q=
X-Google-Smtp-Source: AGHT+IEGOmUGwnD8hUfKM+YyablrKp+JD65rIInkFFmTHlzSJeYRJ9LrnF0X/VGLS3YQf1mZMIo1eg==
X-Received: by 2002:a05:6808:1642:b0:3bf:f547:dc80 with SMTP id az2-20020a056808164200b003bff547dc80mr8593440oib.21.1707804847757;
        Mon, 12 Feb 2024 22:14:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzzeuHzK+n1FavnH8wYNScOfOgLIWwbXOsVQE7ANP8BrcNTf11Q+pyalY0v/Oty8c6ah34H8wUDPjZfrjBH4eSlhaElW7Sov+6egABvS0m/18JR4xAx7R2638x6XniDFKNR2EtX36qwlS6fRMPXSbRL/ZYm9RnIonaKf8FiwkLK6181n+Uof1teKm7pyhuDtasyWDl+XbVJ4rF55SLQdYmIocszKHZ2HZfFEZjy9ZK9RyQFeZpPHOsQxDhxbe3dgpsiLdOockOnNmPdHeyeBSjg1GwEVdWDdurEeC6UPaeyRLxyWyy6o7P8bFTTo6Vjd7EbUHx+XPu3Ek+OYOtSpePxQZdjO84f4vSfZB8s+AGbJr0BmZLtwk4Sd5XAUgo6EcMz3MFdaB+Rb456LGnCvou4Cbc8WXaRmfA7j1zFViZ+wMn3IUBqY1p80ogkg8=
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006ddcf5d5b0bsm6521173pfb.153.2024.02.12.22.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:14:07 -0800 (PST)
Date: Tue, 13 Feb 2024 11:44:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v1 -next 2/3] cpufreq: Move CPPC configs to common
 Kconfig and add RISC-V
Message-ID: <20240213061405.ictoxql2oh5jtg5b@vireshk-i7>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <20240208034414.22579-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208034414.22579-3-sunilvl@ventanamicro.com>

On 08-02-24, 09:14, Sunil V L wrote:
> CPPC related config options are currently defined only in ARM specific
> file. However, they are required for RISC-V as well. Instead of creating
> a new Kconfig.riscv file and duplicating them, move them to the common
> Kconfig file and enable RISC-V too.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/cpufreq/Kconfig     | 29 +++++++++++++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm | 26 --------------------------
>  2 files changed, 29 insertions(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

