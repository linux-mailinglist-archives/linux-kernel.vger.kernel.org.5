Return-Path: <linux-kernel+bounces-53919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477584A803
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E10285517
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE61DA4D;
	Mon,  5 Feb 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS1z3dSr"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7610A13;
	Mon,  5 Feb 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165028; cv=none; b=fL9XPz0ChPSu8iT7blJdLGob6iRmEydC9pooyBrFanGNUWb2QYA9Gtp31MJKIPR6ILcpfhQGO8vRmCu/UaWNsd+QoVor/rmq4aWWtSgZ8GXakl00/mkOXogkMFkDn2XEaYqlDJW55qpm9IZ4w9QEESQpwzpeGosyHX/bEHnktwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165028; c=relaxed/simple;
	bh=PR7kJfznAqKyyLfJ4TzyQlXG360gkSoUuEsYbizxlMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/aIIZqmwQx/j5/Wbc07r0fMPSAGll4vqgd8zOsmxlmp0D8HqH7SaXJytKMK2/UiSfyIX9OJBuAzM7gWMfBVc5s+DASHbnGsTRw4Yl6Aamg64aRl+QPj/Ns6JD1FtclS8OMAbXWVH+LoODxRliCPWb2xFyQ1s/PbnzVdh+q7CHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS1z3dSr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8ef977f1eso36727925ad.0;
        Mon, 05 Feb 2024 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707165026; x=1707769826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nEYDnwbfwp2CbCbKu5LPjt6G/RAlxD+k28eQnqBHLg=;
        b=IS1z3dSrDgGF/iy9x70TNt2B5WhR5N96GGMOJCAmIVeanhON41aqm3CO+xe4BWj5/c
         w5nBeEVE7YZ0bUc0QQn+vnEIy19u9Xio8I8ZoRqw6Qw8IBfvPR5aJUe9qZO4mqpqRwi8
         uhsVK41ZS53xt26q9BjhShr1bHO8WigUDkrDLJeWOtlM5x4rF3BQWNVsWEmic4SuCTWn
         p1qQgXRaiTFnRxtOwAXHMYCrfi7r52HsBVu9LxRRLUBqeq0mp33uR37RyumyuTQRijDS
         AdJEb9KDDxKVqUHmT+TjGWX/Aa+n7AmAaxr3l94zx3/+3KOSzKyhc8Gvg3heLLCSUqb9
         THnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165026; x=1707769826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nEYDnwbfwp2CbCbKu5LPjt6G/RAlxD+k28eQnqBHLg=;
        b=n2jZzs9n7gkdLKZEZGaNL6ByQ0ht7S94YJvut5l9Jbm089ppZJaETY9573cAL7GolV
         KsdMR7+AibKadmDWDr5Fxav8U0VzHlfuruUh6qVOpHH4EjcSkFzdB079YEAWxYgT1iPC
         3CAbN6m2X3qyFTHG3LidjDjD2KP6rtWGdiaAebqXEbbbLMrUstI18+PmaO1RHUMm2EQL
         A4HEQtr0BR5OiQiG8rH3Jd7/dPOY/yEUvSdRL4k466Hn0zjRCT9Dudk9vUynQfxVFMh1
         1WOp83fid+MbyFm6vBrMqrsmuj0TeYAh/bO57R6TqY4dvILUN9oVbUYrp7tf89aKjIAD
         miFQ==
X-Gm-Message-State: AOJu0YxRZE38B8v08JBz7L8P8EoPaNe2rgRy59lotHJgwD0gLmq3g6Wx
	swbtv+o7NNpknxg8Z6QbiowzJvZGuhafjkUTLXK76uNWEH/5W7Vy
X-Google-Smtp-Source: AGHT+IEQrRGIS8PLHZ7DpDSiIe169gLYWkACM8+b2FINHkIonG4cUNMZ84Wc2yxFr7gZSseHHH4Zog==
X-Received: by 2002:a17:902:c24d:b0:1d8:fcac:efe5 with SMTP id 13-20020a170902c24d00b001d8fcacefe5mr186130plg.17.1707165026508;
        Mon, 05 Feb 2024 12:30:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUARuTq2hArpiK63USZDpJyZn0citnrcJA7Y/hW00unWOvkeu6Y6fuFbjL4YEfCX+unDts2lQeqEr4k70el0MJp4EgjLikZ5g0xpc2YuQGLlJCzPJDQV14NHur8DLjLmgbdTZhMJeUnVnl/rfoSSp5hZDjXYcGIB+v5azQR8P4ugbmO+jp3LyT1w5oTzxQHvnOgf1qm4oD3RJszTEcBbrU7La+cxSKj6AfKMDdRIEaqg3ZywH3q0SZ03WmSEHAU8OWJQWgTAzoDs9rAAGtqEbUGLO7vUJ74QC8dpQpm30bO0y68UZJsniSF57CMt7WDhWooE1HFRe3saRTAu8f2bD/CvEyD1H4=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id kj14-20020a17090306ce00b001d8e04de78asm282354plb.132.2024.02.05.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:30:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 10:30:25 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <ZcFFYR-JOrfp7kvn@slm.duckdns.org>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
 <ZcDdlRzpofn2cAuO@alley>
 <20240205132515.GF69174@google.com>
 <a6762ad5-62f2-41d4-bba7-c2d9dcb12498@paulmck-laptop>
 <ZcEfCM160K5cnzHx@slm.duckdns.org>
 <a8386e9d-39f6-4bd5-8329-30550fb2745a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8386e9d-39f6-4bd5-8329-30550fb2745a@paulmck-laptop>

Hello,

On Mon, Feb 05, 2024 at 11:41:10AM -0800, Paul E. McKenney wrote:
> [    0.316453] ==================================================================
> [    0.317646] BUG: KASAN: use-after-free in wq_update_node_max_active+0x123/0x810
> [    0.318851] Read of size 8 at addr ffff88802109d788 by task swapper/0/0

Ah, that one is fixed by 15930da42f89 ("workqueue: Don't call
cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()"). I have a
hard time imagining that having anything to do with console being quiet tho.
It's a cpumask bit test targeting cpu -1 and the result gets overwritten
later during boot.

Thanks.

-- 
tejun

