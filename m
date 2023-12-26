Return-Path: <linux-kernel+bounces-11352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D957481E506
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820381F22665
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD54B153;
	Tue, 26 Dec 2023 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOaTTgEY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C74AF9F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20389f2780fso3492800fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703568756; x=1704173556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/yCtDNlZbkApsOPbotq0miDNKgFHHdTcJH5FR2SEXc=;
        b=hOaTTgEYTZFUhkKPe/tTr0A+O6ry+8aqpDGvL/7WcXFQ7tS3Ab0jCSQCYdb6eRKrK/
         4iRonRTjOkLVIo4YpNwMgoZudk/eFIjWkTR60TuExCXEML8k2skp5hbuvvdEm/qIhoI7
         p4GniBdX+jC/4rK1BpShCgq8CqrU9tXrI1isW+Zq0wht+vRb4EifiSzDg1ZB6hfuy1Fg
         ve7tA+DwFpYmUFkPXkEU/EJkxH0MSIMrK1Xvaxr1OkNOkL8QeZde4fglr0g7+o0MCjhv
         GxniQzdRK/cxrWKqbfZp12yMNrJh9iX8I0sfkOxF8RiQ9gBMtMOktU5pyOptq1NB14Mz
         Fi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703568756; x=1704173556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/yCtDNlZbkApsOPbotq0miDNKgFHHdTcJH5FR2SEXc=;
        b=lf+IvSwPBZW4t5ncZcITMvK5eRIJfkCelOw8YcH4tP1wpeuCm2XZl+nb5SCG/46G9D
         eYjd79vcAtRP0ZfjFiJEwy9ddDb1ooRqttSdmIXDXyC4ZN1yFqSG/LQ/ldE3Rrs1oQ8X
         OTtP6Bpn8rXj8bq0/m/buVKOT1H9Vw9JEaRRmBlVdERCjS7InM47TdDpJgDvd/6Dd77m
         bTUwaxcR9v1LgVGAGybI85kkeBPjwQZZBixj2bYL+fgTLWnDYtAumXJQCU4/oE6GYbTK
         9doO3Fer35ty3fQnYFfB0cAr9pbY+OCKRBmqbutnQ64okq1SyrFu2Y57zutPKbWw4FYP
         0UMQ==
X-Gm-Message-State: AOJu0Yxayp/tThlsJMYgAz7u655za6Ofz4gzk5R/VI7pnSf/GJgo4UQA
	z3tCzp8KHkay/k0sxSaTRVBKYLIt4Tif3g==
X-Google-Smtp-Source: AGHT+IHsV2cCLwDgQ+aRxdEBipW52bolZPopgXkwJdwS+zecDa1ZDPFsMRrh5GOgq3Hk9laWbArYnw==
X-Received: by 2002:a05:6870:858a:b0:1fb:31a0:619c with SMTP id f10-20020a056870858a00b001fb31a0619cmr8333158oal.47.1703568755795;
        Mon, 25 Dec 2023 21:32:35 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id u18-20020a63f652000000b005cd821a01d4sm8703700pgj.28.2023.12.25.21.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 21:32:35 -0800 (PST)
Date: Tue, 26 Dec 2023 11:02:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
	rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
	rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] thermal/cpufreq: Remove
 arch_update_thermal_pressure()
Message-ID: <20231226053233.gtvuflyonkcifa4x@vireshk-i7>
References: <20231221152407.436177-1-vincent.guittot@linaro.org>
 <20231221152407.436177-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221152407.436177-4-vincent.guittot@linaro.org>

On 21-12-23, 16:24, Vincent Guittot wrote:
> arch_update_thermal_pressure() aims to update fast changing signal which
> should be averaged using PELT filtering before being provided to the
> scheduler which can't make smart use of fast changing signal.
> cpufreq now provides the maximum freq_qos pressure on the capacity to the
> scheduler, which includes cpufreq cooling device. Remove the call to
> arch_update_thermal_pressure() in cpufreq cooling device as this is
> handled by cpufreq_get_pressure().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

