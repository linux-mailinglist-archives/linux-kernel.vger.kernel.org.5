Return-Path: <linux-kernel+bounces-28509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D683C82FF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7993B1F24CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A785247;
	Wed, 17 Jan 2024 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcB/351I"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB254439
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463818; cv=none; b=KFu1mZzfZW6rO2vR5x/Dq/Ru+DK3m3F1UYygwl03XO+0Lz8Zs8EfX2qv3Kue7q0iMr3bIhQVZ4XbVipVP0EK100oUAUhVNdHpIgyILad07tq6C9nCXuNGjANWdgLUQdc9djh0GZmbE4WagKbEPPLVh7tvSRLWqvabpFliyjzTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463818; c=relaxed/simple;
	bh=oXegu66AdRVLgWJHkNyNpZ1OF5DX13G4QVPtI4stWg4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=bqz3AaSTfgmmE5IznlP5LJTpR1p4dZTCBjNj5ZMKgm322+xdn1SjV7+MU7IqCgOckv8P1g8yGs+aR1VeP3FM2hEmpMKFevaNcvH3khIci/p51NJBJdAq4vMTzCNmXwwv0/oyDO9ora4UZhLYAGtQLPTpXJTaXvxI9YKgGhAABI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcB/351I; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831aacdaffso1025711885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705463816; x=1706068616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBkgC3Na2JY82eSWGD2Dsn8JMBtSuCOs/lSiN46PYx4=;
        b=EcB/351IFpZt4aO/6c+AC6EeMoCO+jd21RvBSLLM9eD/oqR9MwUk722XBD+w6NdmlU
         /7++ymEBKZynMJH8OyldNvRSbwf7/vG5+Rmp6YRS/VUfGmIZd8gGuhLzTuOYwnaNSsjo
         oDHUe5xSIwWiw/jr9ibFu8mXucpnQra7cgsVqwHbt/CDVvr3C3B84qWrDfz1jTEwVE7Y
         I2wwLuTUP/RgoTQhwDzfTO6Qt9Y0GC9uV8iNjgjUK01qnA/67gu8L2EN4W7Y3KQ0i8UY
         bA+1FeN+jvdKmt1oAYS9nrqMxMomu22sGYu+qJZ1JxS7XcPJMLN7WreL7eumb6009W5Y
         acpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705463816; x=1706068616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBkgC3Na2JY82eSWGD2Dsn8JMBtSuCOs/lSiN46PYx4=;
        b=NWWJ9zlTuN3WW2QudM8BMAZUmaRPJqz3ooweO8Ei7GQfnSIAFohCzutfIiWKiI+9RJ
         1kcPJSr+NdLWz1v4spUwRcKcCqybY/xO/pEFo8YmzeJDB1vxe1d72BZjtwGYQq6zslqx
         QQqTV/MfID7yJd94nXlkcPWsvAeaoIZLW6UL1dJyt1rPUtNjxOVpPM5JNxeP8XW8siBz
         1vbjqtuGeOsZL5qvcwGZuUjQT1wgZ1dVGC0ZsYbCgiFEEtek9TDNRpAU3O4qWt5HWtkY
         ypPNGJogDoPu34aLbhALN2DxcM4fpRZUZgQDE/8/1fkP95+o0l95P64FgWObVFBA2YdN
         P6EA==
X-Gm-Message-State: AOJu0Yy4QiGiuPs2Nhtlq+Fs/SkQQAudnt/IEDVi1a09nU30OGwoD+Db
	fVr8X9o+2h1egzzfAbPiSFrQ5Ipt6SKaadJ0EwM=
X-Google-Smtp-Source: AGHT+IFeRjXGq3SUHet8hFr2HSOvDK9r+uVDUM/4ZwvtFDjMdO+UDi4aONvZA6SAmSvc8xthOuwwdVqBaEanTb9JsmM=
X-Received: by 2002:a05:620a:a41:b0:783:63be:684f with SMTP id
 j1-20020a05620a0a4100b0078363be684fmr3493651qka.0.1705463816332; Tue, 16 Jan
 2024 19:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116161929.232885-1-juri.lelli@redhat.com> <20240116161929.232885-5-juri.lelli@redhat.com>
In-Reply-To: <20240116161929.232885-5-juri.lelli@redhat.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 17 Jan 2024 11:56:44 +0800
Message-ID: <CAJhGHyBuf02mh=ezoua33UNu5QTpwP=qf-WP_C2qVyx_HEtMDg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] kernel/workqueue: Let rescuers follow unbound wq
 cpumask changes
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Juri

On Wed, Jan 17, 2024 at 12:20=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com>=
 wrote:

> +       /* rescuer needs to respect wq cpumask changes */
> +       if (ctx->wq->rescuer) {
> +               set_cpus_allowed_ptr(ctx->wq->rescuer->task, ctx->attrs->=
cpumask);
> +               wake_up_process(ctx->wq->rescuer->task);
> +       }
> +

What's the reason to wake up the rescuer?

I support this patch except for the wakeup:
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks

Lai

