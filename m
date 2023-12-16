Return-Path: <linux-kernel+bounces-1999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC08156D5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8312281F6D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC41525C;
	Sat, 16 Dec 2023 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIFSSaBi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A4DDDB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so1242982b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702697402; x=1703302202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEQ/QfzWe41WSMz22CzSA9GVF90SoiyHigHSMZ63aNY=;
        b=qIFSSaBiVlGzzW+MAdxf0MggRhjZuUQFJBAm6M58NqiakE2F8ytOoaUfCloR7YICi+
         q9Vh/AiPjCNgOXf2NmiRUqS0huaepZCEh/GBbYoG99Iz4nVdRU6r/DJrZ7S8fCNQkUJu
         WgZxDyYMBAtAlmRWSRwndyhDEFWzqb4j73Hqks8tN1jaOhJaTrbnp3KotYS05kTv+wCe
         aMJxHq+6CUBEUUJnlxtEw8A+/mu2QOX3eC9McpTOVWcEREI/dkJ80wkEtu2Ge0aifDOz
         FFKFSqpthYXsplK6RGq4hG8VWOJPhAjrQH8rZ6P0NuCecYc3asVXZW7tosWBSibH4tFK
         Hmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702697402; x=1703302202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEQ/QfzWe41WSMz22CzSA9GVF90SoiyHigHSMZ63aNY=;
        b=cDZbkj/D/Fht+i+Jz/qC/pzB/O4TZWUltaLGyHHWlPm/n1eICd7G9IzvjtPSLqPMHZ
         XuW4b4KtbX2vOecXcrTncFivTKESBBPK2A9U08zfiNw1E298HkPqE+LLixEGUkXdYiG9
         22EzoYinkjJwxG2C6kSeDSU1dHInRI+Cn011/zy3SLEHFcEjlyQNrUQ5ePnP84hnQfrl
         HvRr3bLvotRjT12mY5Tod4Fwc2OxTYX6QvlZ7CVe658yfYDZvHB4MMrLHC49NYRfQj+Y
         9hmC7Fqsu0WJ1MirnDSJrSqSkE7fZW1p76dNfeglyQWJRf9euJvOuYXH7iodA7gFbAkU
         SidQ==
X-Gm-Message-State: AOJu0YwNA2DdQTUYbACK/Ql9BOr+/JNMux4+QWH7VhmxDVCZUREY+O8F
	JlQccNOLrMho+IBbt8KiEvdc4rC0LyIDV7S7BbQECw==
X-Google-Smtp-Source: AGHT+IEl2J7pM1Qh9sp6NPxUr5WaJa3P0C78F3ejomKp1x8C9xuYtUsi/ZiqYLm1IKDdbio3BaCGxA==
X-Received: by 2002:a05:6a20:b2a3:b0:193:fc0b:deb4 with SMTP id ei35-20020a056a20b2a300b00193fc0bdeb4mr1239813pzb.32.1702697401801;
        Fri, 15 Dec 2023 19:30:01 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id t20-20020a056a00139400b006cd88728572sm14165680pfg.211.2023.12.15.19.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 19:30:01 -0800 (PST)
Date: Sat, 16 Dec 2023 11:29:52 +0800
From: Leo Yan <leo.yan@linaro.org>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
	james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 0/7] Clean up perf mem
Message-ID: <20231216032952.GI86143@leoy-huanghe.lan>
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213195154.1085945-1-kan.liang@linux.intel.com>

On Wed, Dec 13, 2023 at 11:51:47AM -0800, kan.liang@linux.intel.com wrote:

[...]

> Introduce generic functions perf_mem_events__ptr(),
> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> ARCH specific ones.
> Simplify the perf_mem_event__supported().
> 
> Only keeps the ARCH-specific perf_mem_events array in the corresponding
> mem-events.c for each ARCH.
> 
> There is no functional change.
> 
> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> etc. But I can only test it on two Intel platforms.
> Please give it try, if you have machines with other ARCHs.

This patch series is fine for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

I only compiled successfully it on my Arm64 machine but don't test
it due to I have no chance to access a machine with Arm SPE.

James, could you test it?  Thanks a lot!

> Here are the test results:
> Intel hybrid machine:
> 
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
> 
> $perf mem record -v
> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
> 
> 
> Intel SPR:
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
> 
> $perf mem record -v
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu/mem-stores/P

