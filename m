Return-Path: <linux-kernel+bounces-102527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A761287B35F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6EF1F24F57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F22535CE;
	Wed, 13 Mar 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAhN7WSN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3E1A38DB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364799; cv=none; b=CEeoBrekdl6s/zcrAoE1cqR7MQYC3LkwJscXU55VDHHzbieNQaq5XVFhQyGYE2YJu0YP+n+ECEwAZjqMrVHbHK6QJaRZe7UIrJPHApjY3QkAtkjeO2AlkKupLnjo1QhVycw27AuMNcKgS0JxqBMwPbQ2R/I3wZbbmC6LiyqBEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364799; c=relaxed/simple;
	bh=ExciNH5X+kk4orPhRSSvW0B8ZWGqB21yx8Z4yIRF81E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuYVqphz8BekAwAXaHKhACfqpr5+lte0Vjrv2sDLsJo5ZFP4XDHsXTGmQz2d3lZs8eq7s7J/ywfKMhxm8pDaA8F7IEPcTTOrScE3Beg0C6ZS7ntfCPEvfL1J4AI3IOP06GI6q+HUykHdXLkc1HDUNczYGdqLowBUT4IVJub6YyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAhN7WSN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513c1a82b30so459899e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710364793; x=1710969593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJm+oFCt0SeOuEiNDVrxR6SrOyoH1GSMua58050UQ2s=;
        b=cAhN7WSNZcAbHzNgtsWSowUK9cpvq2IRfR5L/iULZ3fpOOHzA1FFGV8WBFwY33X0Rh
         cVhLhl2fwkvAb2O7qwh1SUfWQ8PfAw+lX6g5HWk/W3DbF9ly/Txt2LJuKGOScDIR54Eg
         TT8LtRhlSWBdSwlzWUME+JrU5JCsHV+RGDaN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364793; x=1710969593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJm+oFCt0SeOuEiNDVrxR6SrOyoH1GSMua58050UQ2s=;
        b=hUZ72oRTW2XIiHC8aTxbTLu//5yUQANFXf8jLnQxm7ORD3b0KZ7TN33Y2rGR7EA4Vm
         7YYaXxFL7SpS5Orxk1qKTFGdEM8H0hPh+PViHyRgcf75oIi7+7X/A3BCPvfUNV3fN8Tn
         Fx7tjpnEp1Bt/J1VFPg3ftt5AXzP6f3/uDQRbpUfYB8Luw6VSu3ZJ9MjT38MfdNr4esx
         wzndJ8Xo9sX2iOkmhMECnf+knukdktNTK+Ju/HycF3Ror9C5ZAwvUuzNCmTuU/M59igG
         gFCEx9c9Tsbe5FcR1LkavA0j3tNRpz/NFUU/IzDtF/8W9+66ZP5D4Gyg4m4voLzEG/Hb
         7G5g==
X-Forwarded-Encrypted: i=1; AJvYcCWOAKuOvRhqEYgjFDKabb1rmmTO1UOzWqoR/A74GqNYWMKSD6iWjbb/sxqRDnwFqQ0/sU+z3VWQZ989zQNGmuSk2M/I0x6aqdKZo1Qb
X-Gm-Message-State: AOJu0Yw/NY03IfZgXYZDVqBzkSpl44y0wDlIbU2mniwON72cj2b+QG4Z
	3pyzQiyNwj1OT9qqfedTp/EtFOYc89xP4r0xMSv3M9/UfQTvduTIolzalnl4ra2GKrXEnHPPp3g
	0sscNYw==
X-Google-Smtp-Source: AGHT+IEt5vBT23+8b6UBpFBhVgxATQMqhW/Z0xOQ2KUVS8w2f/NOQeEbJTYcE81DZdbZCje+Cef1bA==
X-Received: by 2002:a05:6512:14a:b0:513:bc95:50c3 with SMTP id m10-20020a056512014a00b00513bc9550c3mr3853435lfo.12.1710364793589;
        Wed, 13 Mar 2024 14:19:53 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id v7-20020aa7d807000000b005673e29cc0fsm21373edq.54.2024.03.13.14.19.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:19:53 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5689ebef670so19896a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:19:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL62Ok1SWqY8k9/gVvNXl8D2C5dM5kSTaafassxW3znpGEbKte36/KAATKCirTuDwqOa60hVCKAYBgRSyCkJUOSHHuCpKS4eE8XHVO
X-Received: by 2002:a17:907:a0d5:b0:a46:69ea:262 with SMTP id
 hw21-20020a170907a0d500b00a4669ea0262mr868828ejc.29.1710364791227; Wed, 13
 Mar 2024 14:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com> <20240313205622.2179659-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240313205622.2179659-2-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 13 Mar 2024 14:19:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5rEZFvaLgs-ZtsCX9++mFNYKox21SBfF8vrSQG4WbPA@mail.gmail.com>
Message-ID: <CAHk-=wj5rEZFvaLgs-ZtsCX9++mFNYKox21SBfF8vrSQG4WbPA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] smp: Implement serialized smp_call_function APIs
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, 
	Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 13:56, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Introduce serialized smp_call_function APIs to limit the number of
> concurrent smp_call_function IPIs which can be sent to a given CPU to a
> maximum of two: one broadcast and one specifically targeting the CPU.

So  honestly, with only one user, I think the serialization code
should be solidly in that one user, not in kernel/smp.c.

Also, this kind of extra complexity does require numbers to argue for it.

             Linus

