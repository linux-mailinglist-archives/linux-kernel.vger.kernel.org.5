Return-Path: <linux-kernel+bounces-125981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4AC892ED3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976F81F21734
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3AAD56;
	Sun, 31 Mar 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4uT5r3j"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE822AD21
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711869962; cv=none; b=VBr4RHm0fPSkV9hqqmVI0c4vea4ochgTh14IBv5tVevLmsjaU0Ctc4UoktkoA8sRYLB+iFDFri3l9DEXPnpSa/EpmqpajgTcn8mBL5gkNXX4e6MudI8Vc0DP20tj/w/iGgJpetZMhByhBeRzB+sOQcHYU0+YAcYGkK0sX4AcPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711869962; c=relaxed/simple;
	bh=O5qMOERjJkF26oZmpXKDxHHil9u6CcZDypIn6GX6ExA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk/zHxczYV5Z2duTHqbVCrg6/0O8rnkntzPs+EgS1J/9MXzip8+rFyuWA6LYqWqfmrT6EYxCUostHZye2MzCs9ArUNRiV4FGTCKq0oAOi4E4qWNPyMUbXPMGQKttha0ZbltC82EOiZemz74FURnyw4mYJ78+xmKs3QEs54E+7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4uT5r3j; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a97846b5so3284896e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711869959; x=1712474759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyvW0v7GdyXYv81f2ln2/akmbd0PUrhVO3HMD0YyDWg=;
        b=C4uT5r3j7E8KG0Lhfjv2J4/s2kvD0Fd7PgHfSbdnR8TwfEPL/Nfp2ZRgr6JbY9SVDE
         9SZFauudydEILQin6N+2+oe6sD/bXXaVSdV+mbp0qYnOHkwHAexgUQ0LYohdl6vu25ms
         37hUBcTw7Emv9iePwb/pccHk8BIM5cymwtpz6Dionj6xoISZlrRNg/kSo67Z1YaRdVnq
         8IRhvQXMn7q+HlNCChnDxM6umskHWMni9Iii7saPeUYLsPf3nDwlbv6SEQRlLVnDmDO8
         EpZuR02K5VIIpAeJQR8mL697/r7gzMbtuR7ItESr79EFIJTr7Y1Gau8x4tog0HwwWd5S
         Ib0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711869959; x=1712474759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyvW0v7GdyXYv81f2ln2/akmbd0PUrhVO3HMD0YyDWg=;
        b=a1WCIZomwkq2sxKtY4Z4z4GcSJKpq1KmUdt6xGhGn4ol3/hyyaHKVu8iVDe9Yqjm6m
         DmcE520Fm5lP48QgX2C+EhP0pkCI9Izgb8CSO9OdFZ68P6nUN+64O3ohrsCPFuEteGJa
         /iY94uCU/8k8nUKhUZpYlTp57ezT9Xq2uSB7TV2+AGX4CF7lIYIG+oFzvdN6QRrIN8eZ
         EztrJpny1O4RpIyzHUAA4F5kf0d76xG+Dwx9U4jP113f2xUN5PTW421zJ+HNbDGlk32L
         PiqDHTSbEZqJAKbIXBClXufK9p7p/OYSo95fYA97u9mpljsz/S8Y8hjaNPwYEAfCGCT8
         /B4g==
X-Forwarded-Encrypted: i=1; AJvYcCW/e6rEepnQ3qObzJX+PtS3/oOj8ibJwtHmzE/uqed9l/U6J22kWht9ZTCgrxFneynGYjUGXkV57IB+ZDRbVFBS/UPi2BtedCVrtn0y
X-Gm-Message-State: AOJu0YwbVWS226IkIdgbpxsbbIk2hoRINHz0I8DWO693b19I/6o211qo
	cslWWGHLPrGSQ+qWUG3YYVm8nrO+9w1voFcE/bG1H8v9oZuitDNH
X-Google-Smtp-Source: AGHT+IHpum9qE+4rol1jhVGIFFbzrWbR7kcuxntXfHxdx+PBDY1Yspgb8IxYwIaVm1CUd3skM3HIfQ==
X-Received: by 2002:ac2:5f1a:0:b0:513:a05d:7e9a with SMTP id 26-20020ac25f1a000000b00513a05d7e9amr3787002lfq.45.1711869958645;
        Sun, 31 Mar 2024 00:25:58 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id d8-20020ac241c8000000b00515fc468f45sm390542lfi.31.2024.03.31.00.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 00:25:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 31 Mar 2024 09:25:56 +0200
To: Hillf Danton <hdanton@sina.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Message-ID: <ZgkQBA-Lsk9mxZJ3@pc636>
References: <000000000000f2f0c0061494e610@google.com>
 <20240331062314.3394-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331062314.3394-1-hdanton@sina.com>

On Sun, Mar 31, 2024 at 02:23:14PM +0800, Hillf Danton wrote:
> On Sat, 30 Mar 2024 18:55:41 +0100 Uladzislau Rezki <urezki@gmail.com>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d9642dd06c25..8867aac3668c 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3467,19 +3467,19 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >  	 */
> >  	kmemleak_ignore(ptr);
> >  
> > -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> > -		schedule_delayed_monitor_work(krcp);
> > -
> 
> This is not enough at least WRT run_page_cache_worker() [1]
> 
> [1] https://lore.kernel.org/lkml/0000000000007a44120614e27cb7@google.com/
> 
page-cache-worker should be move out of the krcp-lock also. I will
update the patch.

--
Uladzislau Rezki

