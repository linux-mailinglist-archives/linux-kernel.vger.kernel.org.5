Return-Path: <linux-kernel+bounces-140519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CC38A15B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DC1B20A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3F14B088;
	Thu, 11 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh7MeBPB"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFA28FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842569; cv=none; b=AF+LUkwYptOfEMvzA4PCOV2sxuhkA3ZmUfiRDl9gq7nDIpFpU4mbjJ6rHoRBCfsyanij6lAIHnPN259DHHxKIbtfoijw3WKOSf4OTCoB4joH9LgW6Fi/eefYeucBfgx7Ln68I3w+XhTAgmlHqRuXI0RHw8v+l37jj52g5+C6mNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842569; c=relaxed/simple;
	bh=J65q02IkBAMdMPztaOg8GyYPL9bgzAS2+QnkXHoH76Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJmoDsQtWjPQmQZpUOnO5P2WxWmyJg/sEq1XcLysnGvzepb3vNE3LAdV7okNsRoDdt3b2RKzlQi27ngk6F9/eq0Mjb4av/2IbhZnaLZGhRFuaC4P+CHB5oWJBgTa8XHAk+d4JU6q4R/fJgqcbjPlygm6+sTGLcS5LV/UlY/WfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh7MeBPB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so93269251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842566; x=1713447366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUilBbtANZfZu2KLsNEzIHaWmD7NhSLDebUqumoPb74=;
        b=nh7MeBPBOSA6eIdZIDOP01AP1MvzNez3lP9YFiDj826j1Qmwh7SezlHzur8T7dON/a
         JWJykVjGYKoQ3K9gXABlmTh6+yxXicwc2IsbEHvT4MFICgbrrksKSlCrWi+h6c1qWdRl
         6hoeKox+wDN2Cv5bmukJupqhzWlFnxMlY9P8Z441cTXW2Q9gUhJXqQsxk9zfuzvNgUzq
         rsspD9I+/lgvJKukOkDkDhfnxrwi8CPPowzGNXTzUqYMt/n2CQ7GczSWKv6JhMo63J0E
         hP+uC+uW4fe28ipjcNbjxX8oR1wVS5DZY+/4vvJkw3wCV4aUD+0lghT6jWwPEbU7dA6F
         4HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842566; x=1713447366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUilBbtANZfZu2KLsNEzIHaWmD7NhSLDebUqumoPb74=;
        b=w8KEA1kUklsR7ZqDNYQ7c90iBjMvmv7+jOvQdMgvIO19UmJK3KQF1BNUX2R+LiwjRD
         eRe+RXSsLYLwB2wO1h2eymwm2rMVv47YryPk2zl3bfO4p42pCkkJRkPaJqVny99n9quu
         tj+3CSnDO3LPSRZTX6DbjRPspHR0YIuBL+o2w3FHk5k1MBoXlwUQrlRLh6QzC97YI89s
         THHl0qqPPiwa0JfiW+kXs8NGMltxYCjWvW0J8L3Ng0nTUTni+wPdfz41gbH04GQnxiSx
         DI57z80+bGZ6FwrYcBNSfa9295YC7eDWbVWysxYsSf9CYLDsEyyJDDc1WYmOmQncJsK6
         f+uw==
X-Gm-Message-State: AOJu0Ywp+tNjE07kXZ7DTKgxLv/EWhzKocpZxxWKpb2MH1R7t/9Ps4+Y
	6Oj97crKmAh0038rvBmrZQxrsctTfpMecaiCamwfkFLntIjjdZ0orILBp3tV4lb8THxXNXIu4mN
	LWV1wwbkr5GIALbV7X2JXSEI8Jqk=
X-Google-Smtp-Source: AGHT+IEFgzJAg19O/si136GZ5Lpj6LX+9iA9ZW3wLkS+KGNu4LWhlnzYi1S2xU3L7Cybris0eoouVGEDeZDpGyGTISk=
X-Received: by 2002:a2e:8757:0:b0:2d9:e54d:81eb with SMTP id
 q23-20020a2e8757000000b002d9e54d81ebmr1087996ljj.12.1712842565802; Thu, 11
 Apr 2024 06:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325140943.815051-1-ubizjak@gmail.com> <20240325140943.815051-2-ubizjak@gmail.com>
 <Zhfkinpp92Ja6Orl@gmail.com>
In-Reply-To: <Zhfkinpp92Ja6Orl@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 11 Apr 2024 15:35:54 +0200
Message-ID: <CAFULd4ZhJonzsP1GexJOy1PTx4PCTZoU1ukQrpmaNusumU2FTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:24=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > -     locked =3D cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
> > -     if (likely(locked =3D=3D _Q_LOCKED_VAL))
> > +     if (try_cmpxchg_release(&lock->locked, &locked, 0);
> >               return;                                   ^------------ ?=
??
>
> This doesn't appear to be a particularly well-tested patch. ;-)

Ouch, embarrassing... oh it is a generic function, conditionally compiled w=
ith

#ifndef __pv_queued_spin_lock
#endif

and x86 defines its own function ...

I concentrated on different settings of _Q_PENDING_BITS and the above
slipped through.

Thanks,
Uros.

