Return-Path: <linux-kernel+bounces-117779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFF88B5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1456B43CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60314A9D;
	Mon, 25 Mar 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDe9yiSQ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580418645;
	Mon, 25 Mar 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393956; cv=none; b=DORRLzNFLvT6PB4FLvUOJ1+kZqak9P4K5W5pNcYpLy7tdA6gVaXhlfDp1eb33WibiQYWGyubAHPStuR1SDOT17gOuZuFsT9P4a+v/IbHmjrCt6USbTF9iUi++opdua2miWZTg90RYfQ8NNyrOcXTjP/xjp/IPZ/BLuxFnlQXI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393956; c=relaxed/simple;
	bh=fZOe/tLK1cgFPvkLuZbT3YDA7D2x6EJoWMvIzRbFXsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWtVc+ElqD2HdDLFuAn4MOtRYWtgJ8s6WeBigUI3erRMk2SINa6hW3A/xA7avk/5TP9pVjoyskG5IgZuAKbeQ8oWLYF9aRSrjp0Z99jFp/PHcD4UKWuOGpXHVfIKFDREJkXgywtXmVSnKgQkg8wzNMJ31jTCh/ILzgsH1UrUBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDe9yiSQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c1a65275bso441087a12.1;
        Mon, 25 Mar 2024 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393953; x=1711998753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kky/1shDSavwXJhQDl5uOntgm8L39nVx0FH//gj7QE0=;
        b=QDe9yiSQ/yj+PFqN7VlI8roQJX7Ea3+ziFvknF/QrFSLFzrM+AsW9hPrqnFDXRVMZb
         3jL4GmQGwokcNcqAIWLK2kvMTm0a7nu/xVx56Ppe7Zx2BEIWXiHauriqXHj8Z/JVChvQ
         sei1kEmY4x4gj+dZtBONMJYvePxmX0+67wGUksvBos8IcDg33ScKF4Tg8z10PqzCzKoA
         qp+vTnOd9U+NBWWaMdB2eXavV3DIdlN7X59Yyut0iChdI3rjijOXIJedG9BlsijPTd1h
         Y8zGSOfzNWaOZEDfiLIZ2+0IOfyiRnMrH0dvcy5TlaqTQNEIMtKbAS578WZu0xPi0tGk
         WQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393953; x=1711998753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kky/1shDSavwXJhQDl5uOntgm8L39nVx0FH//gj7QE0=;
        b=bsEhzq/nYgWM55q/EzCt5SQvH78NWfU+EVG4YYx0jqZOm9f7iJi8C8cKiZf2hjkSrZ
         imLYyB0IZUmzQn46zkFWB1FnBatiPhQDu9WpSECQ3dZm/I+y+1fLx56Q4s495ia5DE3k
         WBO+DS/neCKn1Wxfz8rhCMzwBZlCDkKAOBFJXzpYt/mAFH6tcRvokgqnZRJkvtm/XaSe
         OVcI0s8Gfeg5vHbokgscIosF+AvR3JAM7C8kfyA9PfwPkLzBPWAqr/K4LltjzYBkAOyu
         +6Tc+1eWEjxY5XOycR+grcHSVUM/Nk6e9fBzOFr4CiqOmD0gd/PHiMU+XUOjsLII2X/k
         YYLw==
X-Forwarded-Encrypted: i=1; AJvYcCV5QBcvLob8MhYzEZ13Vktl9/fxXejWEvApvYkVTOsavDd+DL86UsTjnVVKe3dfZikH84xM8lAZWoWLNb7kTZYjOhtVPOjFjMDg8ypr6pEkiLYmpa5RIEWVzrCR7X0XR4PpOy3w01G4alsiPon+hiGcqePS/8DdEyhMRE0gQkQrVL9qGg==
X-Gm-Message-State: AOJu0YzRTn05niJxikKV5/b4a7AvAZn+y/sIQ8DjGetSmFj7b8tMjPu4
	NFa7+1LpL7ll5aRgiPfbwAuDG9mhFm5Y+BKvf2Kqaqx5ovgfyK8V
X-Google-Smtp-Source: AGHT+IEAfipoBfQy1s/urIUropfZNXPJtkD+58dQ3dDa+IhcHkXqWHjDGD0L+DA1yrW0WEZgt6vXFg==
X-Received: by 2002:a50:a6d0:0:b0:56c:18b4:d2ab with SMTP id f16-20020a50a6d0000000b0056c18b4d2abmr1882154edc.42.1711393952984;
        Mon, 25 Mar 2024 12:12:32 -0700 (PDT)
Received: from jonhaslam-mbp ([2620:10d:c092:500::7:3fad])
        by smtp.gmail.com with ESMTPSA id et10-20020a056402378a00b0056bed786b9csm3223717edb.17.2024.03.25.12.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:12:32 -0700 (PDT)
Date: Mon, 25 Mar 2024 19:12:29 +0000
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org, 
	bpf@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <syviklbpdblcwr3l2seuwyzfrg2hy2shx5f6ho6yf4s4ce63tc@nbo4by247y6z>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <Zf+d9twfyIDosINf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf+d9twfyIDosINf@gmail.com>

Hi Ingo,

> > This change has been tested against production workloads that exhibit
> > significant contention on the spinlock and an almost order of magnitude
> > reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs).
> 
> Have you considered/measured per-CPU RW semaphores?

No I hadn't but thanks hugely for suggesting it! In initial measurements
it seems to be between 20-100% faster than the RW spinlocks! Apologies for
all the exclamation marks but I'm very excited. I'll do some more testing
tomorrow but so far it's looking very good.

Thanks again for the input.

Jon.

