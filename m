Return-Path: <linux-kernel+bounces-117822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B688AFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253851F3F996
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C88199B4;
	Mon, 25 Mar 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0jZTIix"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721418645;
	Mon, 25 Mar 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394994; cv=none; b=BEN5F4gV4y7510qsrP2i4WZLYBPfJGQxIGbXhIY5M/sLb1oQ8hShlAcrbeuLsMSfcUeozLxoJ5VNVj7B2RSjLDLEnwJyvDb404Upem/LwOG0yZc3zInwk6VHUvv1nnS4y7nyxZ9PWwbBYXUBGPM8sBpaQNrh6KN/SlDkRG/+OH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394994; c=relaxed/simple;
	bh=t2HprRa2B2t5YmXHJgyVl/WrmR/Vf6vSPJfY9UUtXHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQy8ok3j5cFNm1D6m8bvZbYt+qxcNrh6Hi7S5cjwnJo3cySOy1EgV8tFQKBxdV2g9DmzLdGpVatw8nnJ0WW8ZOt02I286Qsji5mrZnJOdFm/fye67dBjKEzq488fBOBp2ALf1roVkdO7eG+n67QcEDElg6kc0BM5wbSq1gyLnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0jZTIix; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3325074a12.1;
        Mon, 25 Mar 2024 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394992; x=1711999792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JzHvz1vTFg5px0RsXOPwrY1sy3X4aM34u9RnZMcwC0=;
        b=G0jZTIixe39nKHl+nBvGX1qj3JGmWiKkZSAYmFpy7jj+wzDbHl5n21d7gPxUNyJ7nk
         pXP54UQhIjOFHb4jUcpfE3a875HPSaY/TGWox4Ham9rTqCAe9xIhLOkiM04m1LwdjA47
         o9yQpgPn5hWCW+7z88hb5aAFwEJwjwY+o3Sp88GCuKh0ngQ3Dsv0lEtedezKJEicEdBV
         u9JXdPMgyBbVxsziZJOD9t9nR1DHcMvnTeBEdRPyYsMHLRQdPGCc2lItKAP71H7aSto/
         9IE6Uw2T38lTxL0OkGXVwpfUVuCumQSZdIoqHEs6qHE8ljRxA8W6IOA5Os8TPWa7JvyQ
         lxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394992; x=1711999792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JzHvz1vTFg5px0RsXOPwrY1sy3X4aM34u9RnZMcwC0=;
        b=DCx4W+CYahsCs4EAw/t2BBD6HjIlIYXKVxqSMkcUOIHangf6VxeeGcxIhMfyCkb+XN
         E+kHGhSAATFXaWSjL3RkEnKDG1olithwOs8BDxH+XC5k7uAxO91QGtitEHkGEyenuwae
         xJzpG7S60HFlvHEK9LFiMrZZw2VosHG2BfaPTmltvg0SbJw/bZc5Q/sHcnOHV4kWWDtT
         xxGEctCfGVDY2fBivNYgBSpVGXuN8WWnOGKHbcNS3EP5q2HQzOs2u+RwySae7kvkL2KA
         c/87bVGbPOpTrczYQBLvQEoHj5Wrva02Uk3K+JHSgEE+6C3uN+NEdjOqwYkZFywCrabe
         OU5g==
X-Forwarded-Encrypted: i=1; AJvYcCXDjz1DBMxysKBKqolbggQ5RIAZrH2WtSOqyK+mRYYAi6kERjljLeW5aBsgTVg4jUlaLXcsFjo/c4dB+BGpTP/p+XAsBkJyjqDDtI7x4Sgacf5rpN5hPd00AaggUIiuVtUCXH4v79R7iVEzwwWbGmu/
X-Gm-Message-State: AOJu0YyNWUhQvqC28CjZwByfzoablAReQ+OommpLlNicUiOcoe1Q5pVg
	xuyAn/3+InJ1CD24Wph3dnNmxmOCM6LPMKSz161/owM8fWgoPxt2
X-Google-Smtp-Source: AGHT+IHrRxMlqu/mW8f/g5Kg/anRmyz5qD9ZlaLAWCYg7mFYOm7otlce5JDjU8cGc9IA1fnA+MNb6w==
X-Received: by 2002:a05:6a21:6d84:b0:1a3:bd7e:c42c with SMTP id wl4-20020a056a216d8400b001a3bd7ec42cmr932225pzb.8.1711394992130;
        Mon, 25 Mar 2024 12:29:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b001def777afc5sm5067765ple.77.2024.03.25.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:29:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 09:29:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Kassey Li <quic_yingangl@quicinc.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: add function in event of
 workqueue_activate_work
Message-ID: <ZgHQrtqIr8CYu7yf@slm.duckdns.org>
References: <20240308021818.2306176-1-quic_yingangl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308021818.2306176-1-quic_yingangl@quicinc.com>

On Fri, Mar 08, 2024 at 10:18:18AM +0800, Kassey Li wrote:
> The trace event "workqueue_activate_work" only print work struct.
> However, function is the region of interest in a full sequence of work.
> Current workqueue_activate_work trace event output:
> 
>     workqueue_activate_work: work struct ffffff88b4a0f450
> 
> With this change, workqueue_activate_work will print the function name,
> align with workqueue_queue_work/execute_start/execute_end event.
> 
>     workqueue_activate_work: work struct ffffff80413a78b8 function=vmstat_update
> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>

Applied to wq/for-6.10.

Thanks.

-- 
tejun

