Return-Path: <linux-kernel+bounces-53928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516084A823
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961761F2BFA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA61386B8;
	Mon,  5 Feb 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqC2Q/ew"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4071DA4C;
	Mon,  5 Feb 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166245; cv=none; b=aB859X2l+2WFH5rYJKdQNa+7VuhorryrZCHguqCb0EFJpl3AEOA00whs3qhpip1V3AtzBlxpcAjKSJBkUUcqvCTz3QDGPUmm8ur9yGlINt29Ke+lZIKlv1yfWJUOHwpO6OnMDWFcX+3QlF1+cYcIZvCtjfhWRgEp3nh5FRKk3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166245; c=relaxed/simple;
	bh=lUkPMd5XHACLufFZ79Zzokj1SM1sqqtoROpSlvJd930=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TInkNa7y8NTeMqx/Y1/KWeIsfZ8NcmVLy71zNHKdiZpuYkqjN/o0ma6DtnhcC4ZE09uWSmvzh7u760xrqpYTEsNKFlUd+uiOLLw1duExAciOVvHSgGgK8bNVrMKUI5ARk1duM/8EDxdXVekD6QScLKWFRly7o1qfCyJHwVyNvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqC2Q/ew; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4bd45397c17so1561367e0c.2;
        Mon, 05 Feb 2024 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166242; x=1707771042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5yztHDEz5ryVDr2lFRitQEpPkarGvjyutYElBOoSfQ=;
        b=iqC2Q/ewPlc5feiRZ1yFiF6RMOnfW4T4Nol1fLtn5A4E1KIRrImGSrmHC+aFVRl9aO
         mzORzC3/NgHzM9u84/X3N/Mg6UAvcn7+c1Zr6cF6uyu3zxKBQunbWBf3cY0X1x9Zk27q
         utY9iRKFuvSN1HKWQFKoG1kXIoDEYV+iDLsP79qx3TVPmi7tQSTAc3MmFoO9nkx2ObId
         gPKB3sltqJEE0wrc9q7oyfACGfiGfB31UTILHOe3AQJ/shwenD10L7LaIIodC4oonG8j
         58Xrkpy46Wa++Jnl2cwa83ioYhY1DblmiriwNOVnRrLOV5BGAH0xRQzPWfF50yPTMNfG
         +LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166242; x=1707771042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5yztHDEz5ryVDr2lFRitQEpPkarGvjyutYElBOoSfQ=;
        b=fToNGZTmuBaNWdt8ihUr9hH++WUru1WZ9XQ+Rcf2vRsY1vF6IBVebckaeBGEjds1KM
         D9RF8U2GE560zYsW+odCAbqcxFxqQUTpzuG5+Kws1rntLiOJPhRlP4uingyoWIHOZkhU
         A4vUaIBbc+PnxPFVOjYIPa9/BCd4JidbhhHmUXzvI/B5IzpmiyN8D3GlUT/A+rfQ87B3
         rohAi8wN5cFXK2nwT+ZGTRFZIAX3AMF+zNyMsD2JVm1IoJ64Pf1M2o8/+Snku9dW4GzW
         6sLSNLYNP48UTF4tmDOPB07i4wGJhuaUXK55d7zfCKPKor9wyaT7+CWmNuVsqvZ2fts7
         3Thw==
X-Gm-Message-State: AOJu0YwmjylEEvxhSLjAvkzovECKNzQr2K7Cc0DEnQu/hpK1yQtfFomg
	MyngRHi9J51v/5re9O/PFKQ43wKMlV/i27aT0Zs9OPdsKR+P2kzZ0006ABf7MpbPmeqx9GXcumd
	X18yi6wBLaFN/TtlFLfqv1uXn2mI=
X-Google-Smtp-Source: AGHT+IGcTxkm6GLg4DTYAnRBYG+ywiXp6c9pDzORkTwj5jst1Jo0ekpU2xdI4zbfCGteDDo0jOxw5hTKH+089BOk2LE=
X-Received: by 2002:ac5:cf11:0:b0:4c0:3545:285 with SMTP id
 y17-20020ac5cf11000000b004c035450285mr657728vke.5.1707166242440; Mon, 05 Feb
 2024 12:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <ZcACvVz83QFuSLR6@slm.duckdns.org>
In-Reply-To: <ZcACvVz83QFuSLR6@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 5 Feb 2024 12:50:28 -0800
Message-ID: <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

> On Mon, Jan 29, 2024 at 11:11:47PM -1000, Tejun Heo wrote:
> >  0001-workqueue-Update-lock-debugging-code.patch
> >  0002-workqueue-Factor-out-init_cpu_worker_pool.patch
> >  0003-workqueue-Implement-BH-workqueues-to-eventually-repl.patch
> >  0004-backtracetest-Convert-from-tasklet-to-BH-workqueue.patch
> >  0005-usb-core-hcd-Convert-from-tasklet-to-BH-workqueue.patch
> >  0006-net-tcp-tsq-Convert-from-tasklet-to-BH-workqueue.patch
> >  0007-dm-crypt-Convert-from-tasklet-to-BH-workqueue.patch
> >  0008-dm-verity-Convert-from-tasklet-to-BH-workqueue.patch
>
> Applied 0001-0003 to wq/for-6.9. Applied 0004-0005 to
> wq/for-6.9-bh-conversions. Will proceed on 0006 and other conversions after
> more perf testing.
>
> Thanks.
>

Thank you. I am basing my work on the branch you have
pushed.(or-6.9-bh-conversions)
https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/log/?h=for-6.9-bh-conversions

In the order of priority, I have started converting drivers/media/*,
drivers/dma/* followed by drivers/net/*
which constitutes the majority. Putting my plan out here so that the
work is not duplicated.
I will write back in a day and share the branch for review.

W.r.t the conversion, there are drivers which call
tasklet_[disable/enable](), which I suppose
can be ignored in the case of workqueues, I am not entirely sure if
this is the right approach.
Please correct me if I am wrong.


Thanks,

  - Allen

