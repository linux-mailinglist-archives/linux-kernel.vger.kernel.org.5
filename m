Return-Path: <linux-kernel+bounces-13391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6182047E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83286282258
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651B7487;
	Sat, 30 Dec 2023 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDiDAdS1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8163A1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d4a222818so33196915e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703934564; x=1704539364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IV2BKMSLhIOyXxbde9JcIy67hYaYu6fjXIgvjqlaklk=;
        b=IDiDAdS1liIqfpIUEipNKpEdOoFODWfdBlGKC3I+I5z+Ku/0RiGKaVNjFZmfMiOv0C
         iV1qLTE4z7XFsGAXVD/i4XwVs1znJUb0rzpOf9rGX35X1rdqwE0ofwHTpSDu+aPrG5IJ
         RsAzP8fXTOOGTKsLiMgn7g4AqUGlSnckwCfkf0mKeDVvN9VoXi8+B1LMkjEkX1ZW7AXr
         ziphKbeRdTcVx5kGm2mAYoigm4wz5DpK+gtPTN61CwvP3H7bffjLR2tTtDQQ28pVimzE
         Q87ae0bre+PW5EQFdqovZ+ZIc269EWwKFtNbP2K09Z6P0NuBpF0xQdPe3IJSPFJK3R+6
         1Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703934564; x=1704539364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IV2BKMSLhIOyXxbde9JcIy67hYaYu6fjXIgvjqlaklk=;
        b=rI8YIPkT29ip5yFcPgXFe2oBbvAu20/7yRDBFgRfT3vgLC4ude/A+Y5tSMd82wlcdE
         cXYoPmvaPuj+HBY7s642BEYpkByA4ZTuQO7ytJJa4/oLyY1ohkOqFs6frDH45tE1LYXy
         OcyM0jnXHcSZNNSHSEn0g3oKuUMxN//YkCtlnYvdRFgbhBV+Y2KklA6wNiBKueLuTZR9
         eMS1uv2yaVLNvwUsRRzgVSlXoiWQLpaKZlcrpScnA1Ln0n0geMafKDVljst7EQ+jwq6c
         LuwdXY/enJCGowM61rHTGoKcUyT4CJPlmINYWBysxzS/ZLMzthwIOLb1lQ1yCQoCi/yy
         LxAg==
X-Gm-Message-State: AOJu0Yzr9Yi7T0tPTm1T7x7ZCCqFH9dGE9AmGbRk7uT0cpIR9I0uejxd
	qKgTTjYVv7OifFyD7WqkVpA=
X-Google-Smtp-Source: AGHT+IHuqKd2XEDM9fpOy8gKESWCWJV0+bgGNvMKM9jUh8XBjrtBgKsh/lXXCzQqVstiQ9x3o0vSyQ==
X-Received: by 2002:a05:600c:5398:b0:40d:418f:a66 with SMTP id hg24-20020a05600c539800b0040d418f0a66mr6147250wmb.7.1703934563783;
        Sat, 30 Dec 2023 03:09:23 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id p7-20020adfe607000000b00336843ae919sm21033294wrm.49.2023.12.30.03.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 03:09:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Dec 2023 12:09:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: David Laight <David.Laight@aculab.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Message-ID: <ZY/6YCNJ7tSCmiGo@gmail.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>


* Waiman Long <longman@redhat.com> wrote:

> On 12/29/23 15:57, David Laight wrote:
> > this_cpu_ptr() is rather more expensive than raw_cpu_read() since
> > the latter can use an 'offset from register' (%gs for x86-84).
> > 
> > Add a 'self' field to 'struct optimistic_spin_node' that can be
> > read with raw_cpu_read(), initialise on first call.
> > 
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > ---
> >   kernel/locking/osq_lock.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > index 9bb3a077ba92..b60b0add0161 100644
> > --- a/kernel/locking/osq_lock.c
> > +++ b/kernel/locking/osq_lock.c
> > @@ -13,7 +13,7 @@
> >    */
> >   struct optimistic_spin_node {
> > -	struct optimistic_spin_node *next, *prev;
> > +	struct optimistic_spin_node *self, *next, *prev;
> >   	int locked; /* 1 if lock acquired */
> >   	int cpu; /* encoded CPU # + 1 value */
> >   };
> > @@ -93,12 +93,16 @@ osq_wait_next(struct optimistic_spin_queue *lock,
> >   bool osq_lock(struct optimistic_spin_queue *lock)
> >   {
> > -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> > +	struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);
> 
> My gcc 11 compiler produces the following x86-64 code:
> 
> 92        struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>    0x0000000000000029 <+25>:    mov    %rcx,%rdx
>    0x000000000000002c <+28>:    add %gs:0x0(%rip),%rdx        # 0x34
> <osq_lock+36>
> 
> Which looks pretty optimized for me. Maybe older compiler may generate more
> complex code. However, I do have some doubt as to the benefit of this patch
> at the expense of making the code a bit more complex.

GCC-11 is plenty of a look-back window in terms of compiler efficiency: 
latest enterprise distros use GCC-11 or newer, while recent desktop 
distros use GCC-13. Anything older won't matter, because no major 
distribution is going to use new kernels with old compilers.

Thanks,

	Ingo

