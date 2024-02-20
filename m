Return-Path: <linux-kernel+bounces-73450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B585C2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7529C281DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297376C9B;
	Tue, 20 Feb 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwTlbKwt"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C9768FF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450402; cv=none; b=dkCg2iTcSAIm1JinNZDV3Bb9MENN8JjNAS07aAXIIZunUOcIKR72Hrb5JMNQPkT9Qa4VYM0Z1w35hcYuvkDMs79bfQxU43pLFnFz/AkUVwcc8C/JfQRRf6Ca1rH2yjVpDDsBJ9u3ABNfEWodFLlE9evUZrhrbe31GPYA/hRV3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450402; c=relaxed/simple;
	bh=aWV8nO1ssqwifgL9RAqnHVIi4aRvckzBJY2B3QGPy8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az2h/TFGJfFH07FclGoT97VwzIrBYis/LGIaMn6f6nFIxtUn3Kj7nIb4nkkYO75U+NbMDk9tfMXkb/+YRnyslzkVaynkRc1RkUkoDDJaz58c9NtkQBYR+xvv+eapcMb29qErUNcp3l6IJJiQrORpEoGeLI9iGXzBKg75FxFmvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwTlbKwt; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c15b7b36bbso1238372b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450400; x=1709055200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQMTniPUOF8fs0cEWFbKnLM2+BvLQQJ0sz9oPQX9dPo=;
        b=TwTlbKwt+KBZZZ44dsiLrOP8Vjk7lQsBLU5fKiEJUuya2ombd1F0c5ErTwU7fwcDQY
         dAE56oSVbs6ZuQqKhFKjs7FMgL+GdVsKI+5TpZsf6YeBEWddpJ5c3xrQC9kj3fKdrjoV
         FMVkAzhXuoQpnL51k2C0hM8rUpWmBtayHaNmLTbwKEJw/1fcYItCqZ1iwURUCPSA3yom
         bVWxWqJih3HhZvoQfo6Wz2w1sTmjO9mpEht9RXVT+4RknjcOEalj5ZDYnv8AaWXfV3Yd
         OYgNO4qwCoKs66+hrCrOydrLsFEc6A7VKPpWkoqVj/oWoP1J3rYPpZTNVt/8g8Hr3V2S
         ZR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450400; x=1709055200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQMTniPUOF8fs0cEWFbKnLM2+BvLQQJ0sz9oPQX9dPo=;
        b=ZRrTakLf/44D1E4loLyfjK79RrzQw4PUwh+gS6N5Vu4fla7e4/kgBWqIYeaFqsHjUT
         GAt7zMamuhaHBIvuDiBxSN8+OnwLYH/JUWWxcx9yI0NxjjY1A/lG+9ClGam0AgP70qWb
         QtPJQA7ZVu83wHQ9N8Z57XxtZp91lmpNi8/5ceqHW+vtDrm9v01Tb0Q5+kEJtiRaiJcA
         nA8gPzy7Na07WBqrVk2MR4nsjBX6uNDiB64kM9AGHmUvmtCzrfeeOmazSQSqQFfCW8RQ
         frTzqN2yVsK+lpcWJXss9dVPezhE4k3+Ag4v3B+dtN+vuZ1gze5gejcPRgFD7e2m3v9w
         zvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAYr3KVjU3SMn7iSe+GhyLsDdYyrQj4bqS6L3QFjjWzk2WuvQfS5v6QeokKji6mq6ngMJiPaARVzJwMIPNOcMvtt7d5DoaXiAvPlIX
X-Gm-Message-State: AOJu0YxwF9I/Y7v/gjODAMXtxbU19/cyb1dWtlg+kZiJmiuVulqJX0fn
	MCQjaeglW7bgq+2pk90fHqYpMZEdZECDdlGz7wnj00Hf6grAbgYK+sKETU54nUb+031dfOWDnFj
	Te7wu0J+Jy2ec8dlX/F4LadPAUjQ=
X-Google-Smtp-Source: AGHT+IHc1SoWYqPV+Ulrq7k2VGRBkUpv3QnURrWV/8lctfqKtS30qesn8L4tAKXNjIzLUUSrGOXQhooyxrs+h7n5W3k=
X-Received: by 2002:a05:6808:1703:b0:3c0:3746:1b36 with SMTP id
 bc3-20020a056808170300b003c037461b36mr21424721oib.22.1708450399823; Tue, 20
 Feb 2024 09:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org>
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 20 Feb 2024 09:33:08 -0800
Message-ID: <CAOMdWS+pkf_HeZ2+xcsZvFb0Jwrdd2NyfMNFOje2AcHySei0yA@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

>
> 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace
> tasklets") implemented workqueues that execute work items in the BH context
> with the goal of eventually replacing tasklet.
>
> While the existing workqueue API covers the basic queueing and canceling
> operations, tasklet also has tasklet_disable*() which blocks the execution
> of the tasklet until it's re-enabled with tasklet_enable(). The interface if
> fairly widely used and workqueue currently doesn't have a counterpart.
>
> This patchset implements disable/enable_work() and the delayed_work
> counterparts to address the gap. The ability to block future executions is
> something which some users asked for in the past, and, while not essential
> as the caller can and often has to shutdown the queuer anyway, it's a nice
> convenience to have. Also, timer grew a similar feature recently with
> timer_shutdown().
>
> - tasklet_disable() keeps disable depth so that a tasklet can be disabled
>   and re-enabled by multiple parties at the same time. Workqueue is updated
>   to carry 16bit disable count in work->data while the work item is not
>   queued. When non-zero, attempts to queue the work item fail.
>
> - The cancel_work_sync() path used WORK_OFFQ_CANCELING to synchronize
>   multiple cancel_sync attempts. This added a completely separate wait
>   mechanism which wasn't very congruent with the rest of workqueue. This was
>   because the canceling state was carried in a way which couldn't
>   accommodate multiple concurrent uses. This mechanism is replaced by
>   disable - cancel_sync now simply disables the work item, flushes and
>   re-enables it.
>
> - There is a wart in how tasklet_disable/enable() works. When a tasklet is
>   disabled, if the tasklet is queued, it keeps the softirq constantly raised
>   until the tasklet is re-enabled and executed. This makes disabling
>   unnecessarily expensive and brittle. The only busy looping workqueue's
>   implementation does is on the party that's trying to cancel_sync or
>   disable_sync to wait for the completion of the currently executing
>   instance, which should be safe as long as it's from process and BH
>   contexts.
>
> - A disabled tasklet remembers whether it was queued while disabled and
>   starts executing when re-enabled. It turns out doing this with work items
>   is challenging as there are a lot more to remember and the synchronization
>   becomes more complicated too. Looking at the use cases and given the
>   continuity from how cancel_work_sync() works, it seems better to just
>   ignore queueings which happen while a work item is disabled and require
>   the users to explicitly queue the work item after re-enabling as
>   necessary. Most users should be able to re-enqueue unconditionally after
>   enabling.
>
> This patchset is on top of wq/for-6.9 and contains the following 17 patches:
>
>  0001-workqueue-Cosmetic-changes.patch
>  0002-workqueue-Use-rcu_read_lock_any_held-instead-of-rcu_.patch
>  0003-workqueue-Rename-__cancel_work_timer-to-__cancel_tim.patch
>  0004-workqueue-Reorganize-flush-and-cancel-_sync-function.patch
>  0005-workqueue-Use-variable-name-irq_flags-for-saving-loc.patch
>  0006-workqueue-Introduce-work_cancel_flags.patch
>  0007-workqueue-Clean-up-enum-work_bits-and-related-consta.patch
>  0008-workqueue-Factor-out-work_grab_pending-from-__cancel.patch
>  0009-workqueue-Remove-clear_work_data.patch
>  0010-workqueue-Make-flags-handling-consistent-across-set_.patch
>  0011-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
>  0012-workqueue-Implement-disable-enable-for-delayed-work-.patch
>  0013-workqueue-Remove-WORK_OFFQ_CANCELING.patch
>  0014-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
>  0015-workqueue-Update-how-start_flush_work-is-called.patch
>  0016-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
>  0017-r8152-Convert-from-tasklet-to-BH-workqueue.patch
>
> 0001-0010 are cleanup and prep patches with the only functional change being
> the use of rcu_read_lock_any_held() instead of rcu_read_lock() in 0002. I'll
> apply them to wq/for-6.9 unless there are objections. I thought about making
> these a separate patch series but the cleanups make more sense as a part of
> this series.
>
> For the rest of the series, given how many invasive workqueue changes are
> already queued for v6.9 and the subtle nature of these patches, I think it'd
> be best to defer them to the one after that so that we can use v6.9 as an
> intermediate verification point.
>
> 0011-0012 implement disable_work() and enable_work(). At this stage, all
> disable[_sync]_work and enable_work operations might_sleep(). disable_work()
> and enable_work() due to CANCELING synchronization described above.
> disable_work_sync() also needs to wait for the in-flight work item to finish
> which requires blocking.
>
> 0013 replaces CANCELING with internal use of disble/enable. This removes one
> ugliness from workqueue code and allows disable_work() and enable_work() to
> be used from atomic contexts.
>
> 0014-0016 implement busy-wait for BH work items when they're being canceled
> thus allowing cancel_work_sync() and disable_work_sync() to be called from
> atomic contexts for them. This makes workqueue interface a superset of
> tasklet and also makes BH workqueues easier to live with.
>
> 0017 converts drivers/net/r8152.c from tasklet to BH workqueue as a
> demonstration. It seems to work fine.
>
> The patchset is on top of wq/for-6.9 fd0a68a2337b ("workqueue, irq_work:
> Build fix for !CONFIG_IRQ_WORK") and also available in the following git
> branch:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v1
>

 Thank you. Rebasing all the conversion patches on top of these changes.
I should have the entire set going out in a day or two for review.

- Allen
> diffstat follows. Thanks.
>
>  drivers/net/usb/r8152.c   |   44 ++--
>  include/linux/workqueue.h |   69 ++++---
>  kernel/workqueue.c        |  623 ++++++++++++++++++++++++++++++++++++++++----------------------------
>  3 files changed, 441 insertions(+), 295 deletions(-)
>
> --
> tejun



-- 
       - Allen

