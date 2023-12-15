Return-Path: <linux-kernel+bounces-1200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58A814B97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0815A284036
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415723C460;
	Fri, 15 Dec 2023 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmPp4Fl7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBF3C46D;
	Fri, 15 Dec 2023 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c4846847eso8355715e9.1;
        Fri, 15 Dec 2023 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702653461; x=1703258261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxtTXwrG/DoJdGtWMfu6YqqiGt2u0eh0tzIyDazjR9w=;
        b=MmPp4Fl74hIz18FfUpdp3OhT0l+KEMnzkv99Bzj//wovrsgBkJJwWk20GMK9PftQk1
         gbbYj7VizJv423aeYIXk6Kjlt00Ve1TFJy9+p+u5XoemiIjYylaxE7kSZzJR6SMOk7J/
         IYxK4WROIAjMlEL+TZbw3IETlNbYoQKrwncrnzbLB1iz9GwSTscOaW5a6oRECxYYTFDf
         IAsmgwiZJlF5pMZXxszWLCkkJ+UTGwg7b4HAtOhfuiGXFb9pcpOL5UdwtneczM8nuV5s
         TRadSa6ih1iDYOqmBVwb/dJLdAllkUFhLnd4+4thNhEmdnDhcqpnXZhPABDMUF/loB1h
         eGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653461; x=1703258261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxtTXwrG/DoJdGtWMfu6YqqiGt2u0eh0tzIyDazjR9w=;
        b=r9bc9KYSYwHCPlps8Fle5QU7s9T5Zz1Ye9Op5xHmm/q41NGJTyjNUwC2PpAxeX+xrO
         HDA8trrHK2OcqdIujolO1ysubYWG4rzCHqEMnjMwXDMKhxiLoc1tVr8zkZUanehYAYYt
         7ck/ei64V8cvDP9fnehFFulqiDfbGRdcqUGpZxth3Yxy4a1OtuixAZ8/ODasHdBG8XTN
         QY0Mil8zyueraPLL8TkHdNASQNM/X7ZT3tGinE7bd8vR8xy1E6tNnvVNQcGmNMJh0848
         rqgPILb/7Kj3eQ2+9g2MPugi80oBNMTNjIuOhacuCwQdtkRnudHXuI01NwVhsD0weQcR
         oBGg==
X-Gm-Message-State: AOJu0YwOzXYvsSR/yWwnwlzrQaUAKdAKhvvaHv35SwUEYQeyIdhcWtUN
	xVBX3DF17sR9b55R1qhl+7fG+TOIwdCt3w==
X-Google-Smtp-Source: AGHT+IHCy5Jt0sNRcFT4XvhtCQgRzgiDR2kGcZzEPbaBUD2KhamdV5ExRXFs+HFRp/3YOnpYtX+4hQ==
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f117 with SMTP id h18-20020a05600c30d200b0040c4378f117mr5479693wmn.76.1702653460855;
        Fri, 15 Dec 2023 07:17:40 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.212])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm29806121wmb.8.2023.12.15.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:17:40 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: viresh.kumar@linaro.org
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	fusibrandon13@gmail.com,
	jernej.skrabec@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	rafael@kernel.org,
	robh+dt@kernel.org,
	samuel@sholland.org,
	tiny.windzz@gmail.com,
	wens@csie.org
Subject: Re: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency scaling drivers
Date: Fri, 15 Dec 2023 16:17:23 +0100
Message-Id: <20231215151723.46409-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
References: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 14, 2023 at 12:17 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> > Add Kconfig file for cpufreq scaling drivers that can handle RISC-V
> > CPUs. An entry is included for the Allwinner H6 cpufreq driver that
> > works with D1.
> >
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  drivers/cpufreq/Kconfig       |  4 ++++
> >  drivers/cpufreq/Kconfig.riscv | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >  create mode 100644 drivers/cpufreq/Kconfig.riscv
>
> We don't have a separate kconfig file for each architecture. Only if
> there are too many entries for an architecture, we add a new file.
>
> --
> viresh

The sun50i cpufreq driver is currently only available when CONFIG_ARM or
CONFIG_ARM64 is selected, so this was the only decent way I could think
of making it accessible on either one of CONFIG_(ARM | ARM64 | RISC-V).
Any suggestions for a better workaround ?

Also I think future cpufreq drivers for RISC-V are going to happen, so we
might as well have the Kconfig file.

Kind Regards,
Brandon.

