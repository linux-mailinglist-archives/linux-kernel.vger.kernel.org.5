Return-Path: <linux-kernel+bounces-112564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14155887B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A791F219D3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8046A2;
	Sun, 24 Mar 2024 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxp8dy49"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892961A38DE;
	Sun, 24 Mar 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711250941; cv=none; b=flAPVYt8JMZ/omHGYb1wJDyjAFYdHyPtw09X0Z6SyUE7MWcQhkPSSUrOM66J+LHzZ/DYgx7NYtrgYnWW4dnSSuPsT+Z5vIGCJ8ph/91Xa85ruPmxyEFob49KYhf/xrAvt9fno73gcYax7p09kxsECB2gOHAj0CWoK1Nn5bPuXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711250941; c=relaxed/simple;
	bh=p/DG45cfaW8SBZRy9Pe2lFJhbWEPNRh2Wm9whP/pLtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3nUIq1pOtyNvJJPp28saU8UcpsQxL0KoitSURGh3gWwDdRyRWeru8SeAQqXScUX7KwJ9Ys6g6/neoShokOQWl6/XA2S1Gzs5dVbd98CyPrp9kFh+lke6yuEzMJ2WpsDIOyEIqfnDC5QH/r+SFZztOnJsKXBY+2ukZwHMTdgBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxp8dy49; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a450bedffdfso384451066b.3;
        Sat, 23 Mar 2024 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711250938; x=1711855738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PydOQ1bmmSNTs+e+O2bAUybHfmosF+9k+V6RWawPtKc=;
        b=jxp8dy49SfyG6ag9wCvfzZqyPWSCIetUKySrBJo0YJ4Zxv7kR3TFojC32FVWKi4qIK
         hPn7zhEgDp2ZQco+110VCEJUwCHqRcGQtWgX2c2aLWMTiyreX7a7UtW46nkdFHtxBhDy
         qglsS4HoaQU23Hb0pdeN8372kdhji+dVDWjyt1/+1A4F/y/+iyQ7NfGtj1uTyBMhdXBi
         44/DFMl0ojEbgpDKEK2/nP4HOMoH1fF2yBTMUtsM5nOo9jS1GpdJm+T05D+Ch7+oZxyt
         lxhTpp6EU8ixNBpsSPdFzT4YhLmfBVRuQzmTnGmHNTTH9xtWRe4HqCXMUAssVMtcukst
         vV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711250938; x=1711855738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PydOQ1bmmSNTs+e+O2bAUybHfmosF+9k+V6RWawPtKc=;
        b=XfyrkSmvoltaSrnqqjmOj2CxojvxKZ+ZJebNVzEwDDNH2hUATZBKLoqF0c1RELyBxV
         pdOJbySSrRu0pTyymvwboBetjQjhLBOULGWL5tUgrRwK8jH0iHihaD3HL1cXxlJM0Oyr
         qGpFtnBn/RnQw5rFrgZhzj9Ydu9aLczwVIklevg1l9Fdxzz9LlepQcBBAEqdnAunobFq
         nEX3YnNUej2uzpzDQVY8TFRLSY9Sqa8fvU0qkzQFbfw0oUGLCHQEchF44DaqpL5xMu4R
         rwWFpRnCG/u5hCmGa43izCDm49yf+q/ZVHf4aa4++a69D0wFY2hqBVMVH50alucK5PFP
         Splw==
X-Forwarded-Encrypted: i=1; AJvYcCV3cQHZnq10WI4g9dGlPC9yowgjhygnrKppkAvwCto+gETmh1DdK9pF7WW4x339vAzrrTftwTllhn0Jsh4i1zkBirsfSIDiirckk/fnAcmetdAcLAxsrGeo9A+BptWNL1m883MeCyNvPutT3OKHJM5fnhVhaVj3GKkb9TG3QQeWpnBcxQ==
X-Gm-Message-State: AOJu0YzfaG5tAB8Fdosnb2y7P3efyUt+TMDFMrDvk30lm46K7KIiBYfg
	ukfZB51EEHBinuNExuHmqx+YJ+LnqakEo+TyC7rsxZYKRVpeZql2
X-Google-Smtp-Source: AGHT+IFYFSWVv9IbQXjyThKPy1Mf+JJKlcuWw9dw4i0KwdZYpMQbYV1jMgqIe6gUkzqi38r666YnYw==
X-Received: by 2002:a17:906:f2da:b0:a47:2f8c:7614 with SMTP id gz26-20020a170906f2da00b00a472f8c7614mr2228259ejb.43.1711250937491;
        Sat, 23 Mar 2024 20:28:57 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id hg24-20020a1709072cd800b00a4750705a07sm413706ejc.190.2024.03.23.20.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 20:28:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 04:28:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jonathan Haslam <jonathan.haslam@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org,
	bpf@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <Zf+d9twfyIDosINf@gmail.com>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321145736.2373846-1-jonathan.haslam@gmail.com>


* Jonathan Haslam <jonathan.haslam@gmail.com> wrote:

> Active uprobes are stored in an RB tree and accesses to this tree are
> dominated by read operations. Currently these accesses are serialized by
> a spinlock but this leads to enormous contention when large numbers of
> threads are executing active probes.
> 
> This patch converts the spinlock used to serialize access to the
> uprobes_tree RB tree into a reader-writer spinlock. This lock type
> aligns naturally with the overwhelmingly read-only nature of the tree
> usage here. Although the addition of reader-writer spinlocks are
> discouraged [0], this fix is proposed as an interim solution while an
> RCU based approach is implemented (that work is in a nascent form). This
> fix also has the benefit of being trivial, self contained and therefore
> simple to backport.
> 
> This change has been tested against production workloads that exhibit
> significant contention on the spinlock and an almost order of magnitude
> reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs).

Have you considered/measured per-CPU RW semaphores?

Thanks,

	Ingo

