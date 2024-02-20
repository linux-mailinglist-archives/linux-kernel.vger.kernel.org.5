Return-Path: <linux-kernel+bounces-72351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265685B254
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8B61F2292F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FF856B8A;
	Tue, 20 Feb 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUogoZLC"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84291288CF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407436; cv=none; b=e4SOBMo3QhiNRJB/J5K4ae7TK+yeWjGdYycP9duZe7Z+tymgY+657vcFOWxPd5womcmK5qhP1YWKrBuNMqd+OB0E1UK8sW3zNMJrXHwyreQV//n7A3sFzy8ZlMYeZvaWKor6CyxFuw72vbOikQ2Es8NYBNn2RYCrmsvQCdgBWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407436; c=relaxed/simple;
	bh=epXJvx8kfZs2UPFVQeXKxt1knSk8Sbs7nYpVog557AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aawJ/jbTOM6oea9hJurpeU4InF30pvtULX8uPtGF9C4Za/Ijsbzr/AG/3ZwsYNJrjdjD/mDzYS+OKh2PHKTnImY4UHN2d9utKnos0DAkXnP/LN1KuqPcpvYQS4kxPy9ebFd7TVL6uGWQhxkj3gTSEpY5GT1S4L3D1h5x4DjH0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUogoZLC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42c78fde6b7so10591551cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708407434; x=1709012234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epXJvx8kfZs2UPFVQeXKxt1knSk8Sbs7nYpVog557AQ=;
        b=gUogoZLC4TicirnHsmXLUBPVjsSZGuvSNQOUV5HtK4RqeUdr0vc2cb+ZP1p7srT7td
         nCLpZWLzAxRKs9CJ38yB7ihwtbgrwNoQWs9j9foM5cwh6xtveq3r/2PfClRgTzA2mWUS
         6CxQ372rVCTgy9EpwSF3hBQxmtcypXVr6mjLadfdLmtOKwN/zzYcRt7XfD7Fo+PWG/gv
         kUvHDTJXFUzMpRG5QXPW0qy5kTlbWGV1QE4BjSEDNonZS08QU+ZtQtsUJPwSDzC/4Uiv
         cmZMEpfW5+eOHJEL+HfuPVP8n25u9LCzcGnDhn29ZCZv6PBBR/R1PGNYkjXJAlasGC60
         voIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407434; x=1709012234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epXJvx8kfZs2UPFVQeXKxt1knSk8Sbs7nYpVog557AQ=;
        b=vLTcjuq/96Y+r+PuthP7t30nt+LxwFSpmETs9xX180BNo1dMe8GeWoai0n7KPzAY5h
         Cv+AOFzJoFw/u4WDkM1bMmEcQQl+yuiu/IksA6LYwX9MbxuBQ4JfXcdgO6Mk1WUl7wq0
         DOklTXyE1Elu7jllQ4ff/8GsW6OAA2IK8L5ap3uljQU2RcB3/JQag1AmQ9wcTM1VmB7f
         Sy8I7z9nkqo5rE9OOCQnViMqOSfzhDNQg2/vdBsl9keX7hKHwnSP4ygFeGreQvOrRGeH
         5vZVojOFZxIq8wuSG02i6PunkM+ZYbJZVzDwIvWO+tcbNzbdPPZ2D1p6pZcPMNb+OOtP
         4rSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiEHkIF3N/d3kFehOfEbDOA1GUWlxHzDGz+OaeorjiD9VperZ5Rjfuj6/5opbAMrWy6GKCpq+JRLhvVTQaGpN3Azg0VixWgwSrj4NP
X-Gm-Message-State: AOJu0Ywr6Yog0WmD1brtLRPZLd6A/ZYadCL7e9crHIfwaCDbs9s+7wBd
	tSvordszJbpMplwZXbkr7Y+hn7Rn20CmBhIwGZ4fXz2UNF/6lygNxZ5gX94qvdbWJ/6n+C7uDEg
	5Q7IvDF6LXzx6xXwwb6UaxnZyy0Q=
X-Google-Smtp-Source: AGHT+IEe2jpmd965ui46HLwhcYpCV2L2Px1RMFhjlZyyejdbPv/Fe0FEZunPbKvsPzz7zkB5Qthphx/sI15XsVOQNRo=
X-Received: by 2002:a05:6214:628:b0:68d:14b3:917c with SMTP id
 a8-20020a056214062800b0068d14b3917cmr12929445qvx.0.1708407434260; Mon, 19 Feb
 2024 21:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
 <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
 <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
 <CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com>
 <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
 <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
 <CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
 <91c50335-e7b6-4ae1-9dad-a0c990b52021@suse.cz> <20240219152836.11d36709c594e66fe3037f2d@linux-foundation.org>
 <7e31accb-db01-486f-afb8-18a3f5402d00@suse.cz>
In-Reply-To: <7e31accb-db01-486f-afb8-18a3f5402d00@suse.cz>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 20 Feb 2024 10:37:03 +0500
Message-ID: <CABXGCsOHswLa5rd_Q7kHDHESb=BtqB+F=LV7Wvv+qoRxrqCboA@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:50=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> >
> > I'm all confused.
> >
> > 4434a56ec209 ("stackdepot: make fast paths lock-less again") was
> > mainlined for v6.8-rc3.
>
> Uh sorry, I just trusted the info that it's not merged and didn't verify
> it myself. Yeah, I can see it is there.
>

Wait, I am talk about these two patches which is not merged yet:
[PATCH v2 1/2] stackdepot: use variable size records for non-evictable entr=
ies
[PATCH v2 2/2] kasan: revert eviction of stack traces in generic mode
https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.com/

--
Best Regards,
Mike Gavrilov.

