Return-Path: <linux-kernel+bounces-53979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24884A8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198D91F2DF69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073675812B;
	Mon,  5 Feb 2024 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj5cjt5c"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7158101;
	Mon,  5 Feb 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168727; cv=none; b=BwTUZvCY0IAUXz9PYhrhlubQOcXWlORTS6d8HqF2ara0q4qywpQEXfilrJApzMYjrMp+PDotb5VhhUL2VbW+9g3IBk2Y5lW9DMTsJYHcyFn58SJg9MFh4UGVHZrBoJ22TAVuiLYfmATAUSLQWhuQsEoTsVZ220LIwR04h4JG/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168727; c=relaxed/simple;
	bh=iZASGz5Z5rm1aG0lLGE6OGbes9D4mJXmBzxTO9ghwcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doXtefVuQFz846oKcKp1XtE2e5q1Uza2/C0DKZJtfngDjcX/cA0XxAkjpMf6co61q9Qfe6xFBWy64VKAHlYKq0CihnxHtq+o4dBtWyWu85lVtpxp0NbRhm45aJV7ukZEiAxDUsqVZJ0cFjjkjio/pGruQqkHQpn9qIP5i2AEFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj5cjt5c; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c02af52a21so639061e0c.3;
        Mon, 05 Feb 2024 13:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168724; x=1707773524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiHlMRBtTUoGCPlkucZ3M1GzAWqR70W8aj3H555n2D0=;
        b=Bj5cjt5chfrIpPpuwOEK8n4/k72U7Ow+OwF+DgCUE8srlAgwVJKHoFxXoONqCO3Aei
         IbQL6ZdWXY7XjsO3sbAYc+Osyveth0pHWIYBw0jM74AarRA1iiw+0ONsbxuECE1aFRlu
         PdCjjXLpRp2Hp0XDZG3bYyfhYdD6GE5Z7Bzpu4R0VQ2OCqV4+ebHD6ihMHsc8LXCCACo
         EPM+ptBejoIZGhttgLbykT4uddDpz4wTMFHk766Av2lHFTWLjRTEk7tsZeKYKGI0nxqZ
         jFP4pCZqfTr9xII9AMIAQOxVJOAQfBlPCV3I0qDiUY36x5TSgyKdpr8cXPw4Xfxb/C6e
         12ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168724; x=1707773524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiHlMRBtTUoGCPlkucZ3M1GzAWqR70W8aj3H555n2D0=;
        b=HfdIEfXPpN/Sdr9CX3PDpYU/DqV9Zz/iI96wc7RgNa1Zrs8PncShMTirA10hT/avQd
         b/pvms1pi+VpBIgEcdv5R7XV5Y/cipqnyxd3+9F2Ad3okKjCqNV0JcQBYfiLwY+KT9EB
         XO5PxNYOOjBWN1ES43Nt1il6qlgaNv+X5bHhr/SYMw/3sgEowwgyfBzzapeM9FOwWLLC
         wUlKEsLUv11ukcqNEbFZ4wWI/qbd3u2svSaN+1bzTqcXIQXABSWl/AzMuowxwBx/RyNs
         6egb0LWUYCiJkSanEsH7q7vrD/axmx/yyr509yHDiYhuWekoeTj3C6h1rmdS116q49Y0
         WcDg==
X-Gm-Message-State: AOJu0Yz8TLuRJo1miitj2ZfXI9B7MRHylEo6ZB/sOC3gIsCpj19XFP5U
	TvJDDtLPeZIlg8E1wFW5BzNAjSvNatMs4r3uHXUQJ/wKZnZ4pR6AcGO9gcJsonecYiWjwImZtbk
	s+yFi0byEU4FcL7ZR0KlfwPWmLqBv+D3HOdw=
X-Google-Smtp-Source: AGHT+IFAPAEBv4SxXrw9QXtxsPmPBONJ9K2vokDXIug8vw/xA6OukvoHu9dDYGWxR+zA6Klp4z162ZXW/vH/q0w/rbM=
X-Received: by 2002:a05:6122:16a4:b0:4c0:2af5:bb70 with SMTP id
 36-20020a05612216a400b004c02af5bb70mr209268vkl.4.1707168724324; Mon, 05 Feb
 2024 13:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <ZcACvVz83QFuSLR6@slm.duckdns.org>
 <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com> <ZcFPKaWwxJhgy8HQ@slm.duckdns.org>
In-Reply-To: <ZcFPKaWwxJhgy8HQ@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 5 Feb 2024 13:31:50 -0800
Message-ID: <CAOMdWSKQC4UWXp57qubcSOHmPj0E7wHZWWbCz+yCZqROhoPSGw@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Tejun,
> On Mon, Feb 05, 2024 at 12:50:28PM -0800, Allen wrote:
> > Thank you. I am basing my work on the branch you have
> > pushed.(or-6.9-bh-conversions)
> > https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/log/?h=for-6.9-bh-conversions
> >
> > In the order of priority, I have started converting drivers/media/*,
> > drivers/dma/* followed by drivers/net/*
> > which constitutes the majority. Putting my plan out here so that the
> > work is not duplicated.
> > I will write back in a day and share the branch for review.
>
> That's great. Thanks.
>
> > W.r.t the conversion, there are drivers which call
> > tasklet_[disable/enable](), which I suppose
> > can be ignored in the case of workqueues, I am not entirely sure if
> > this is the right approach.
> > Please correct me if I am wrong.
>
> I don't think we can ignore them. I was just looking at tasklet_kill() and
> thought we're good because that seemed to map well to cancel_work_sync().
> workqueue doesn't have the counterpart for tasklet_[disable/enable](). I'll
> look through them and think on it.
>

Okay, I will look into it too. I have these rough and completely untested
functions. All I am trying to do is to match what tasklets are currently doing.

static inline void workqueue_disable(struct work_struct *work)
{
     cancel_work_sync(work);
     flush_workqueue(system_bh_wq);
     smp_mb();
}

static inline void workqueue_enable(struct work_struct *work)
{
    smp_mb__before_atomic();
  //  atomic_inc(&work->data);
}

I have to figure out a better way to handle atomic_inc() in the enable
function.

Thanks.

      - Allen

