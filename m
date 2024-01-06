Return-Path: <linux-kernel+bounces-18555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B6825F4A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB51A1C214CE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2476FAD;
	Sat,  6 Jan 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AePQdTEl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C696AA4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-427f5cc49afso4159371cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 02:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704538152; x=1705142952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ4vjnaD4z5NZlJmQvwi02ozljKuQZLjHFWLktX0LKY=;
        b=AePQdTEliwaN+/oKhdjmACdpC+tttHBrmniqHyYXa5B+jX6kfYeO4Bxop7XA9zUdly
         GLn5VMOYpk/efkNZgieMMUc3o5i2f3XJ9DoUouIem64yvg1ek8d16EK5pv0GLTbHN9Kr
         6w7dCMCs3ypzCApdZJq2O/SZnZtfptFNj1hQBzg9jxvu/yk01V4E3X2ssVDxMjIjUCTu
         fJCkUOnRZv6qMsn92v+T4gguecdmR1/eprGN3G5ts0M0Gg4Qst1mzDHRXAoumeMw5B+R
         O2o/9RcX6P0fuyJzxx7h6Np4V9kyw7UsBlWuyOAIg4KnVF8CFU+rLjfa4fvce5KlIbxI
         RSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704538152; x=1705142952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ4vjnaD4z5NZlJmQvwi02ozljKuQZLjHFWLktX0LKY=;
        b=PF4HSOlRd4zN9CNogNFU/XwWsvMQIkjOSyHgmQrctd6uW6u9x7A8CC1pvR1A4LoXRZ
         DUgtTjF5rXUUXJqPfV6RzgQGwILKRNtY+5Edmh5wPndHBY+fSTMPkzsrF+fk8I0QS9s5
         YOtqMOys1o7CWwe7BehWGX1qZdLPIjmXxNoYykJ3YoCGcE/0lleBMmhOBTyCTDtQjB5H
         UYerD2GVrkSyC4BxrhYGT0ufAOiB8CGac52h0os5RsmhPidgwdLiVqF0GfMah0XYvoje
         JKGisUNxLIgBXXmHrKeC9pQ6kQEy6QdUzP3e1mFvgqUypm1PfFDcBgGNRozmDXNmZuyT
         8ArA==
X-Gm-Message-State: AOJu0YxKyuouH+von11kloZyWqNgn0N/01mdHWOTYBYTCyVf2rtLCEhW
	A0e/WIeMGQjjUJTSu3jXsyxUKVS7uejq/A==
X-Google-Smtp-Source: AGHT+IHicQhMr6weKF9THMnWJyEvLQy7U8b9IyxJb5yOjwnU7WjONraGjFX3PHYA7T7/8Og5D4UjIA==
X-Received: by 2002:ac8:5fcc:0:b0:427:a58d:6a0e with SMTP id k12-20020ac85fcc000000b00427a58d6a0emr1002417qta.17.1704538152269;
        Sat, 06 Jan 2024 02:49:12 -0800 (PST)
Received: from leoy-huanghe ([98.98.115.250])
        by smtp.gmail.com with ESMTPSA id nk4-20020a17090b194400b0028ac1112124sm2811627pjb.30.2024.01.06.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 02:49:11 -0800 (PST)
Date: Sat, 6 Jan 2024 18:48:56 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] perf doc: Document ring buffer mechanism
Message-ID: <20240106104856.GA172473@leoy-huanghe>
References: <20230803114613.1786849-1-leo.yan@linaro.org>
 <ZRvda2QwdFYCp1F1@gmail.com>
 <ZRvjTW4PACGaU2h+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRvjTW4PACGaU2h+@gmail.com>

Hi Ingo,

On Tue, Oct 03, 2023 at 11:47:57AM +0200, Ingo Molnar wrote:

[...]

> > >  tools/perf/Documentation/perf-ring-buffer.txt | 762 ++++++++++++++++++
> > >  1 file changed, 762 insertions(+)
> > >  create mode 100644 tools/perf/Documentation/perf-ring-buffer.txt
> > 
> > Nice addition!
> > 
> > If it hasn't been picked up yet:
> > 
> >   Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> Note that my ack is conditional on the conversion to RST and moving to 
> Documentation/ - this documents an important aspect of the primary perf 
> ABI, it deserves to be on the kernel side.

I sent patch v8 on the LKML [1], patch v8 has converted the doc to RST
format and with other amending, this is why I didn't add your Acked tag
in it.

Anyway, thanks for review and sorry for my long delayed response.

Leo

[1] https://lore.kernel.org/lkml/20240102085001.228815-1-leo.yan@linaro.org/

