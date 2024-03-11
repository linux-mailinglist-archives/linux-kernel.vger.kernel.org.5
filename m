Return-Path: <linux-kernel+bounces-98548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43144877BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F7F281AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72D125B4;
	Mon, 11 Mar 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfsGcWzt"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840210A12;
	Mon, 11 Mar 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146637; cv=none; b=d8SVhVpSa0oDdv0sEdl/yB0z/p1fJVtNzrHoYOGQTb4nnQ5JqoQr5X1rWLIeOU29tIp5kK/lDeSl9aArpdKQciz8p1k/SAGAWdUvzUivCVmQXwwpiE4UrxNgpXuZuCeYU4Znjf1dhnlGIr64IFI72mpIpaLB0a2vm7egYr7naDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146637; c=relaxed/simple;
	bh=DMSj5cmuBsoKykw6uGUbaLkFBI1jgIF1SZ9SEDJ21W8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cnh+/HH6RulqX3ER8f7uOE2X2vmopTlxbniBtJVKVhjQF3X3fEAmWOnu0D9xnezVNNBqoqSBAXn5jYT5NlDju8If/ZONzbfPtf5HjB8ni81MyH+3UTp64v6UueytxhTiy4egvhbdP+HlTMiRnOBKhyNWrd/p9wj2V9ybFQE1QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfsGcWzt; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a461e09ddddso97639766b.2;
        Mon, 11 Mar 2024 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710146634; x=1710751434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dj5dpR54wcm5Sr4YbGN4BuKlmyJ25gDgOaHgZt2KJyQ=;
        b=UfsGcWztyuzkBedEXNK8RhmqWdipZIu8w9RDiN5XBsT08QPBAaYAZJ4iXcYxBM3kER
         kJRPduofgXzHepxs5yznfKkz5QSiWrD3AeSWh4vQpVo2xvsDihoFo0TNVCGhNgWP/wKQ
         qEPNrkRC4JrcLenUOn9XRHMYrtjHUNU6kmO/le7b8W5E4Us2AAP/GwoYWX4m0ZDPM986
         rRoWpPWtbnymBRXdOcxm9bk7TfHvRsHKgPoZO7GDtRuM0AUfngmvb/aWmLh+IRc4sgM6
         ng+EpmzT7NitMr0GLUFumSxAUBXFMGBFk3Ghl4sbujtCauTSi5RNvNgvfigX1KuPhtm0
         F/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710146634; x=1710751434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj5dpR54wcm5Sr4YbGN4BuKlmyJ25gDgOaHgZt2KJyQ=;
        b=TjSQkEWeEQjTj7h7C2Aoknv0fGNaIrRg6bODlWJh17NSOoD6OuchRaj5Sf1fl4UoiM
         XzOaQzTwk1VZJt+epPCKUYUquovHNXTtwuoN1uBxAV/TCr5s5j6B0WHXv3E/ymlt/h8y
         N9/Sb4H8XfF324S5q2eab35Vn0wdRADmY/Hvp9NrzPhOjqXj6NgcV+a97riYdDLhWF7m
         Dc9lTPeDn82jsuXNoBrOoZ9lfgFMBKjULiHmPCsYhWlXlX3swwvuTGZJmO2XPBdlAL/b
         Iq5mhD+opXfmWoz1pKdl0odMBuhMHd0rvpH5Cc4mVMhS4a95LZdPdpsGDa22YUXWAz+W
         obdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxtHZtLviDJhQ/LAZjdH6IZyBx2s9liVIiF/Hp/+P7LZaoAFQpT9GcxLr/hDt7EZ9kNX6hXpLecW/FlgeX37bGeOlOI3M2ALJ8JRoRZUpzDfXAHDSpy9H13FXV+4Zgd6hf
X-Gm-Message-State: AOJu0YzvVvWVoCooixsFK3CUdKlVKZLY1eg5T6MXCMAcFLR2U600LUBD
	WgYi1bKd3jIPphIFRv/y067RAz4ZT+nfuL+0HIpuOXPmlZxehCP97iIBJW3h0WU=
X-Google-Smtp-Source: AGHT+IGD0DwBnS5yBvanRv04hkOi2OU4yWio6L2mkhYQ8klNqN8cchsvZzI6ow2yjst+nfoYCZa0pw==
X-Received: by 2002:a17:906:3b88:b0:a3f:9f38:ded with SMTP id u8-20020a1709063b8800b00a3f9f380dedmr3231779ejf.69.1710146634360;
        Mon, 11 Mar 2024 01:43:54 -0700 (PDT)
Received: from pc636 (host-87-9-234-71.retail.telecomitalia.it. [87.9.234.71])
        by smtp.gmail.com with ESMTPSA id qx1-20020a170906fcc100b00a4597bbe213sm2638750ejb.164.2024.03.11.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:43:53 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Mar 2024 09:43:51 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)
Message-ID: <Ze7ER232fPpvGssC@pc636>
References: <20240308173409.335345-1-urezki@gmail.com>
 <63e54cb9-fd08-43c3-9f42-3627198634e8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e54cb9-fd08-43c3-9f42-3627198634e8@paulmck-laptop>

On Fri, Mar 08, 2024 at 01:51:29PM -0800, Paul E. McKenney wrote:
> On Fri, Mar 08, 2024 at 06:34:03PM +0100, Uladzislau Rezki (Sony) wrote:
> > This is v6. It is based on the Paul's "dev" branch:
> > 
> > HEAD: f1bfe538c7970283040a7188a291aca9f18f0c42
> > 
> > please note, that patches should be applied from scratch,
> > i.e. the v5 has to be dropped from the "dev".
> > 
> > v5 -> v6:
> >  - Fix a race due to realising a wait-head from the gp-kthread;
> >  - Use our own private workqueue with WQ_MEM_RECLAIM to have
> >    at least one execution context.
> > 
> > v5: https://lore.kernel.org/lkml/20240220183115.74124-1-urezki@gmail.com/
> > v4: https://lore.kernel.org/lkml/ZZ2bi5iPwXLgjB-f@google.com/T/
> > v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
> > v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
> > v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/
> 
> Queued in place of your earlier series, thank you!
> 
Thank you!

>
> Not urgent, but which rcutorture scenario should be pressed into service
> testing this?
> 
I tested with setting '5*TREE01 5*TREE02 5*TREE03 5*TREE04' apart of that
i used some private test cases. The rcutree.rcu_normal_wake_from_gp=1 has
to be passed also.

Also, "rcuscale" can be used to stress the "cur_ops->sync()" path:

<snip>
#! /usr/bin/env bash

LOOPS=1

for (( i=0; i<$LOOPS; i++ )); do
        tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale \
    --allcpus \
      --kconfig CONFIG_NR_CPUS=64 \
      --kconfig CONFIG_RCU_NOCB_CPU=y \
      --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
      --kconfig CONFIG_RCU_LAZY=n \
      --bootargs "rcuscale.nwriters=200 rcuscale.nreaders=220 rcuscale.minruntime=50000 \
                         torture.disable_onoff_at_boot rcutree.rcu_normal_wake_from_gp=1" --trust-make
        echo "Done $i"
done
<snip>

--
Uladzislau Rezki

