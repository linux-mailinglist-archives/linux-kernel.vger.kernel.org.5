Return-Path: <linux-kernel+bounces-120610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9066088DA36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4967329E3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB5374EF;
	Wed, 27 Mar 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7mYawG3"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB628DDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531428; cv=none; b=L+34asOXHuc5+BbtxnYH00M3IWx6W6143P7JE5LuYvF2WX6aeK2crTxzGqjwCRqNYgPw1M1x5vAObz3YmiO9GW1InFUupMMAV34OV752PRVWy7tHjE+2n0nOnaKisdIdcJ5bC8dTXwHG0dexQZrrYlRIJvFme//ctigm6AXNWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531428; c=relaxed/simple;
	bh=uFPeaEcw4g/8JynEDPRpxLUD284cz5rdKcvYR3gatNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmN278vbKpJV03PkXlmFsKt3zntAFUw3Inwr7piIAhk9V9pkXjXQfQ2f9pqjwV5fdmR6Ua37STju6VbuFf/ZTW+bAVRS7LdP+guIclg0+GhEpMpx1cU6bPQooMO9YaG9p/Qoyc6gXOSHLm2nc5RrK158dzKz+BxCGXJT4iH/5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y7mYawG3; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a492093073so295806eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711531426; x=1712136226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WL0cVu7jMB0Wq9iW91+oOn4zqSh5t8E2HFEwQ1OI5w=;
        b=Y7mYawG3c7vV3T3CsK2vL6clatXGAW46OWTTTeNpWmrXnora5UX26LZLbulGupBDcB
         axejEdEbnZRG2axqoN/644B4++/ZNS+Cg39Y2AAGaOMncDS05sMz+XNqQkxIeaYX17ZW
         VFdMYRRo66zaEviwi4zeg9vu+fZFrI+cxlU3HjPbQbc5Zo/cSDNyhVozHVHn0qpXnyLB
         7CegS926+l30t7M7nPRD4OytXkzajDV4AUOnZ15FHSVxNDAXFyzkL9B+errhAZ8/2mK4
         g/Vp5KjaocYjJPbkTXJ32ncdEpW7qvThdFWKpZwOmCuHp9e2jTzvjstWwXZV5F9K5jtj
         UpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711531426; x=1712136226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WL0cVu7jMB0Wq9iW91+oOn4zqSh5t8E2HFEwQ1OI5w=;
        b=oFzSgAW50kYgZ/yXmwE1xqMuxnH7GPdKsoPW8v9pmBPxzs25hocBO3kUmV7SyY4kRN
         cuVkzcIjp3+JB0NWdoSxnCt/45sZ8y2SA1ExLnbYKXh791M5TgNT8oHfv9ZbHl5G6ZAF
         FoEi2RqGYCZ9r6ExLFfXRufxpsNnvlKu2ADJYprp8PCdg+G6b+qY9d3XxU5pvkOXlFBl
         v2R443JP7c2FYQKq2j/thNel+h7cTt881r6ffLwpGw5Hn7AGR+zUlcSHYJm01HK/TXrC
         /ROadupdM8QYHeEfBK+6bY4gldifR+IhNfIBIVjpomy4H9xVYX9kT7LR/XVAriLTup5d
         6R8A==
X-Gm-Message-State: AOJu0Yw8MRkzIh9qkQWoL56eYjloAvV1Ypr3QtGX0je0E/3WFCH4Vbye
	v5fK+n3E68RKMVPDy6Hf9tSjw+073CvIEsIcxVTTPID7+ABqJ8EBrH7AnFD96iGq58byQpKiOQG
	6EPJMyd0BOD2OpNe0tAYnAF8HqLwr/cgS/maQBgo884l5bMfLc7E=
X-Google-Smtp-Source: AGHT+IF9npVwLifdeT4+xaYL12RWuvRUE3pQfir+GjllvL4HF4Io/mnKtrOovxKsEmfkjXLyrX9yHpelXiQJF7ayKfI=
X-Received: by 2002:a05:6870:b49f:b0:221:9495:4ee9 with SMTP id
 y31-20020a056870b49f00b0022194954ee9mr1724715oap.22.1711531425879; Wed, 27
 Mar 2024 02:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325081335.2326979-1-jens.wiklander@linaro.org> <ZgLrQ7FtDy3INX8F@bogus>
In-Reply-To: <ZgLrQ7FtDy3INX8F@bogus>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 27 Mar 2024 10:23:35 +0100
Message-ID: <CAHUa44HuuPE_cs3i4XEvHpSV+T0koCqBPo66uOmYyQ1=Rx=NWw@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: arm_ffa: support running as a guest in a vm
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Marc Bonnici <marc.bonnici@arm.com>, Olivier Deprez <Olivier.Deprez@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Bertrand Marquis <Bertrand.Marquis@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 4:35=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Mon, Mar 25, 2024 at 09:13:35AM +0100, Jens Wiklander wrote:
> > Add support for running the driver in a guest to a hypervisor. The main
> > difference is introducing notification pending interrupt and that
> > FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
> >
> > The guest may need to use a notification pending interrupt instead of o=
r
> > in addition to the schedule receiver interrupt.
>
> The above statement makes me worry a bit that we are still not on the sam=
e
> page about NPI vs SRI. NPI need not exist in addition to SRI. And in v1
> you did mention you have SRI in the guest as well. Then why do we need
> NPI in addition to that. As part of SRI, the callback  ffa_self_notif_han=
dle
> gets registered and will be called as part of SRI handling. What you
> do in  notif_pend_irq_handler(), exactly what ffa_self_notif_handle()
> already does.

That's my understanding of what an NPI handler should do to be able to
receive per-vCPU notifications.

>
> I am still struggling to understand the usecase here. If you just have
> NPI and no SRI when running the driver in the VM, then it aligns with
> my understanding of possible use-case(not the one you mentioned in v1:
> where FF-A driver in VM will have SRI as OPTEE is the secondary scheduler=
)

OP-TEE is not a secondary scheduler. OP-TEE (the SP) is scheduled as
usual by the normal world using direct request. OP-TEE doesn't receive
FF-A notifications and I'm not sure it will ever be needed.

>
> If we are supporting NPI or SRI, I think we can see if we can further
> simplify this change, but I want to get to an agreement with usage model
> before we dig into implementation details in this patch.

The spec doesn't as far as I know explicitly make NPI and SRI mutually
exclusive, it doesn't make sense to use both in all configurations.
I'm trying to be as dynamic as possible when configuring the NPI and
SRI handlers.

If the kernel is a physical endpoint, it's easy, it only uses SRI and
the SPMC will not give an NPI when asked.

If the kernel is a virtual endpoint it might be more complicated since
a VM may need to act as a secondary scheduler. That's not fully
supported in this patch, since it can only schedule itself. SRI is not
used in my current configuration. If a hypervisor injects an SRI I
expect it to filter what's returned by FFA_NOTIFICATION_INFO_GET for
this VM so it doesn't interfere with notifications for other VMs.

In my current configuration, the hypervisor uses NPI to signal pending
notifications to the guest. I do not need a secondary scheduler since
OP-TEE doesn't receive notifications. At a later time, we may have SPs
that need to be scheduled, but that's not a problem I'm trying to
solve here.

Thanks,
Jens

