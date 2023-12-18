Return-Path: <linux-kernel+bounces-3027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A681664A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B457A1C21FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721C6FA8;
	Mon, 18 Dec 2023 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLP9wyXs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D289F9D8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d389fb3f64so7875515ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702879793; x=1703484593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fv33Fm98eoYxsFhCy3k/IYwg8anoZGWSZZeryLa0Lk=;
        b=rLP9wyXsWxAlAXC2WbW9KVDY0fNJ7Cez6j4C+8W8AMgxz0R5jYWXyjyst+wPu4gd40
         Vi3m16LjxYZiD8yPyctnuETvNXDCMQrQzl+OAjm96lpb7Gn+jG0vrCyAYnLqNgZnnKdo
         dyo6Bs0Agklm7puOB6BF/nbjOZvFxFjEpkdKMRPS825L1A/E4TPQz3FXjH2uoNtrF8Gu
         X2FDJ8TO7R6RX6K/uj0iDb9N8sXgI/haPruHbEDlCtcDKI/vwnto6XWZOXk4kfcxmEy7
         f6pxhUCCosmln19t0ohxqnRx3SgjgCn47si0diVNleAc2ycONeDS5s5d92Xj/2W40OmN
         QOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702879793; x=1703484593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fv33Fm98eoYxsFhCy3k/IYwg8anoZGWSZZeryLa0Lk=;
        b=Rad7JOB8rqS6hPQlx8bHyNZ+vQ9fQONGrCh4DMflhJIAuOA6DoBh6UIY/k3a8OOtfA
         35hVQ/QuKAoPtUiZyKn2F68V81RIi6HFRWVuzrgG42TILD7ZgJmTmL/9pJGAn3W+gheS
         XnNRDjtp74obCuGDM+zo31tPxoM97FrBNXsGchryE2E4SYCZ6E0BeSgMVgt6mg785gnh
         CxBF1PKDkpQ8THj1c3asIAMtjsPDYZ2s0juJFdE8tendAqrIqdfPJgxGMNIchSgJSyn+
         oCYKrkqQYze24iGvma8026otqFj3kLtD7jsmojpRGW/7/idVhrwQI7Qjr7vcxa3LXUc/
         p4IQ==
X-Gm-Message-State: AOJu0Yxx5YovuLFOviXmv6u1LTgV6LIZcZCgcNSX0DDJLqzbJpyzOAQG
	RmFRu8SxHbwqaVKeoQMTnnQxCznjWfvLeFy3fq0=
X-Google-Smtp-Source: AGHT+IHO/9Xk10TyLpqn8u0P4FpfNwnhyw1y6P9qlEWj/EdN4sfd0o4DUGEMCVK2HXlQ7b1MpZUXAA==
X-Received: by 2002:a17:903:2446:b0:1d0:6ffd:6e6e with SMTP id l6-20020a170903244600b001d06ffd6e6emr8491684pls.102.1702879793608;
        Sun, 17 Dec 2023 22:09:53 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001d058ad8770sm18245931plh.306.2023.12.17.22.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 22:09:53 -0800 (PST)
Date: Mon, 18 Dec 2023 11:39:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>, aou@eecs.berkeley.edu,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev, palmer@dabbelt.com,
	paul.walmsley@sifive.com, rafael@kernel.org, robh+dt@kernel.org,
	tiny.windzz@gmail.com, wens@csie.org
Subject: Re: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency
 scaling drivers
Message-ID: <20231218060951.yhhyini4neyusyxv@vireshk-i7>
References: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
 <20231215151723.46409-1-fusibrandon13@gmail.com>
 <11b5aea1-7c6e-4be5-ae01-9c4c869dc98c@sholland.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b5aea1-7c6e-4be5-ae01-9c4c869dc98c@sholland.org>

On 15-12-23, 15:09, Samuel Holland wrote:
> Move the option to the main drivers/cpufreq/Kconfig, like QORIQ_CPUFREQ,
> which is also used with multiple architectures (PowerPC and ARM, in that
> case). We don't want two options for the same driver.

+1

-- 
viresh

