Return-Path: <linux-kernel+bounces-73729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B7685C9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221C7284962
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F27151CF3;
	Tue, 20 Feb 2024 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOXSfEeK"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3F14F9C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465112; cv=none; b=PuaCO7OEs7SJgeV3Gmh1uU+bs7B+p+8sHFV0CDuNnHm4/pXYZRaI0eKIEbtmOsZLThUVl1bMQHhe6kqHZX27X0RczG6dmX7GP77cK53jyV4kMu+SwrtHKKmMJVS5sQ7U7/LK6u1C9dyFj8Vpfi4hPMCb29HL8WklHmgWz2q5ai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465112; c=relaxed/simple;
	bh=kqwF4QTM+JZ8tCni5ODpFIlA6wwELi/K4/kGpy42nWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugAvpLkw5zXQDlqzo8Mk95SEJ2+Ud2ec1FTwDsv8TXeRXmN5Sqtyjec38tXuAt5vkc4GqHyi/TQO+1RcR8NUT8GY89HG8Ec2KD7/YvS6BHanCKV/j9/6aApbSTI9qnBPUxf4owbOyFQRIzWsFtAuTR6R+xkKjgVql1DFMmkapgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOXSfEeK; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47048ea1b17so520073137.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708465110; x=1709069910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y3usL8YXXGszB6/eCDU1TUD8CN5mmjpGpnlhM8AZpb8=;
        b=AOXSfEeKsUq96bkJi3qAWecNspEbcDtMqoRif77f/j5pJ1WhsnsQn+so77BPmi4EV+
         bih3f4zTBQZDZuBFHGNDvsKWzVHbjh4Ve7RIDKgyNY96dAtEZ/J/1Sj/eAgFFBpvM96W
         ALnVawI851/B5ntFbCnIu/foWBWorsUEMpp82MiQUTVymhODpVQWrq0Q/x1L0IXZV9l4
         sPlZ1JOpcyHOf89YR+HZyTDe3im9pCsdQiKB8BRhkL3gfqQtoCYe4pL7q3CWbQoX9zZb
         OfYA4vOI/7tU6Oy0ETaDYUuV+dR5DR5k01VD/urWrWlKJv6wX4zOinOreSlsaszQdSjW
         LuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465110; x=1709069910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3usL8YXXGszB6/eCDU1TUD8CN5mmjpGpnlhM8AZpb8=;
        b=Hi2s7+U1o2QIPVENlYmiwZ09IK7ABji/zg2HayXWrcwMbTpV7jIeeVqRtT3ADSUzw0
         ht1hKKRaBz6+TPdN+NFwpbw1d1JxxFTdSHHB3977Su9B0bdbWYj3cLich3OWyEuAc1uA
         68XDfDbiRU1BCbKztPWR44f0ovIYZqmYsQoamMY6Utf8gqImpm59styBLa4GhwNzStkA
         m8808EVoASYntTYyMoco64bYZMzn8budPXxiih9j1AknBqeH0ZOmZ5jackXbSDTzxTZe
         GUFJBuioq40yktmfgobthGKnNrUsjx+tPLSGSBhybDUk/3SHs0Vi5S3GnZI6gJm0EtrK
         H1RA==
X-Forwarded-Encrypted: i=1; AJvYcCVdQ/9DF+CIMeLwAhjgBJxTENB8aTMwqtu3wmhHfE6eNXSE4l7Idc+1T7a6VQgtaOs0f6aCq+u1pr1dSrBjZWi4ry8LBVctZWzm9Np5
X-Gm-Message-State: AOJu0YxX0PRMb10ZoBEaPe+l0zocFrX60yOK0oGBZlXT+XwQ56ORrCFJ
	0CNyV4hymo/EcPPgUK5hSa+oGh9Sf2U3kKo+u84EtkPrDnV9b8oSdMHOv2kg4laEe+v83oPZYy2
	DgBvfgaHGbH/ZjUShKBBsEhYcv+jIBUzj9FA=
X-Google-Smtp-Source: AGHT+IE4BWlX+GUz29noqvwbBelWl1zUek2W7pXjmxVeC43wKI309TRZOpxrARYdfSuT8CXyWUM2p4m9Dx5w9ffdWZ0=
X-Received: by 2002:a67:be09:0:b0:470:543d:ddca with SMTP id
 x9-20020a67be09000000b00470543dddcamr6667554vsq.11.1708465109713; Tue, 20 Feb
 2024 13:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
In-Reply-To: <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 20 Feb 2024 13:38:18 -0800
Message-ID: <CAOMdWSKrcRFUsFc3a0+2Js5hOA92xeQSkS06oL9VgSyZpDrO8g@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Tejun

> >  0001-workqueue-Cosmetic-changes.patch
> >  0002-workqueue-Use-rcu_read_lock_any_held-instead-of-rcu_.patch
> >  0003-workqueue-Rename-__cancel_work_timer-to-__cancel_tim.patch
> >  0004-workqueue-Reorganize-flush-and-cancel-_sync-function.patch
> >  0005-workqueue-Use-variable-name-irq_flags-for-saving-loc.patch
> >  0006-workqueue-Introduce-work_cancel_flags.patch
> >  0007-workqueue-Clean-up-enum-work_bits-and-related-consta.patch
> >  0008-workqueue-Factor-out-work_grab_pending-from-__cancel.patch
> >  0009-workqueue-Remove-clear_work_data.patch
> >  0010-workqueue-Make-flags-handling-consistent-across-set_.patch
> >  0011-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
> >  0012-workqueue-Implement-disable-enable-for-delayed-work-.patch
> >  0013-workqueue-Remove-WORK_OFFQ_CANCELING.patch
> >  0014-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
> >  0015-workqueue-Update-how-start_flush_work-is-called.patch
> >  0016-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
> >  0017-r8152-Convert-from-tasklet-to-BH-workqueue.patch
> >
> > 0001-0010 are cleanup and prep patches with the only functional change being
> > the use of rcu_read_lock_any_held() instead of rcu_read_lock() in 0002. I'll
> > apply them to wq/for-6.9 unless there are objections. I thought about making
> > these a separate patch series but the cleanups make more sense as a part of
> > this series.
>
> Lai, would you mind reviewing patches 0001-00010? If you're okay, I'll apply
> them to wq/for-6.9 and then post the v2 patchset with the rest of the
> patches updated to reflect your reviews.
>

 In addition to the above features, would it make sense to introduce a "count"
variable in struct work_struct?(I am not an expert with workqueue
internals). Or perhaps
we could use the existing "data" variable.

struct tasklet_struct has a variable count, which is referenced in
several drivers, Ex:

from drivers/gpu/drm/i915/i915_tasklet.h
 28 static inline bool __tasklet_is_enabled(const struct tasklet_struct *t)
 29 {
 30         return !atomic_read(&t->count);
 31 }

Also, there are several helper functions that use the "state"
variable, tasklet_lock() which calls tasklet_trylock().
I was thinking of adding/introducing these helper functions. Do let me
know if it makes sense.

Thanks.

