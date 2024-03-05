Return-Path: <linux-kernel+bounces-91694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B987154D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CAF2834BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC604C637;
	Tue,  5 Mar 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpKSGbLW"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735745BE1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616873; cv=none; b=Jq9OD/PYbvbCrgQXkpTYIqec5CuBxjG7klio9Y0xZ4d5mtyvbi6nNLd3cES7XjMBfGxw9Qu2Fs/8ShNUA5Uerq7ziPbFuUP+tr98hEEB8BYmYuYrMsftXwfP+tC29IvyWQ0RTxOKieOzWRrZj+kRf9CIRIVOqOD+p0g25nA5QSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616873; c=relaxed/simple;
	bh=BWyP3ZiJl//c4sCDB62Ke5dXVqc2HOc/4/gYCNh4cxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXEfaOee9hsXBBd//ypJEKEmZ4JHVX2/EalaDOW4i8JJakSCzQSt3cffM8UqNG5/LeZOKTACsSNS/AvW/GCOPOo8YGwXvap96zqLQsKNSCqVIwb5iJNp6BJ3KbEkKQBWrf0cOQvuBPw2rhCwz1O3z+imNwS6mPz+vTj3KV6VZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XpKSGbLW; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7da763255b7so1934986241.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709616870; x=1710221670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiQO/RxAuC9qRBH2upguRHveqR66bc4QXGr9EN8Ghi0=;
        b=XpKSGbLW0GSpVnTEZ3PoqrdXv1IwtF9txYy+tCGbjnpbao6EEVWD4oubTGVAU0WPrV
         0TjlsO/XpoobMEh36tV+CxxIUUBhM28aSPg6mNsIlC75DpoInRW/lf50V+hlT01m+dOq
         RmjslpECoavTvc/XFTSCl+g45/Hx1vHriBFvCXtJmw+TIu4G/CLEt/OtrbdVAlces/Ah
         BfoCcvvI/AsUZsOuTod3phjDqwqR0P6AqKFbJXh8L1bu0/OGmdvp19r1ik4fk4NK0gqk
         BqXAw4UwGvL7Hh5hhfyTx6Pl+NPBT31OyVuMitM3lO4xCKmoxCZcRIQnSoeNCtEVQNhB
         +yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709616870; x=1710221670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiQO/RxAuC9qRBH2upguRHveqR66bc4QXGr9EN8Ghi0=;
        b=VaJA75k14wAKuSJULX2MtbAEK3KfW9vUn3XHpmnXFxDLDxWNSXUzLvUTC4X6Jizf+Y
         hd4eVJlA0Ge6JUwV2cs7YeQzncNXs6863hdTNjLuw9JNc6ZZMouuYBW3pL5qnkaMCYoc
         zMSuwnOZf5bnm8fhjqV/M+UZFqGeUOfY+odhKZgqQqVmCQBAtIsoyTRFHk6/gKDboh1b
         LYLEc54psW7tfVKVe3+9Mnm1/yCt7m6AEwoQOE4EG/jZd/u1HptAvymWh5RcwtvCyt0i
         xfYlrm41z5j5FNsKbCgK5rP7/0wUA+UL/I6rvB7mJLCahlKqKN2D+hU1odVKoMQNOc1I
         4/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUCJnVcVoyQia03cuRb+CsbmBD4GuTaVOqjSZ4SozUi1ftuh3A1cYf1dwOKvZqS0FXttfnpEuJh3Kjyl3n0wDl1GI7t8DVVF8YV1Jho
X-Gm-Message-State: AOJu0YwM+KuZGgaZZzKX8o9Nz9Q1YeTKw0a1Ij0ib9eTDsQjNM4ufVqw
	zwKUDsZpnUPjTOY18YYItYsanUnq3gi65+Ox6GWooodIBXg60FfCVhs87UgUmUv9+zrZvTjdtqq
	Y7tJ+dtzRo/NZbix8DYVI/y63ADUumDVNbVrFMQ==
X-Google-Smtp-Source: AGHT+IG4hbbCymssTEntZQDnPHryRIK17OJT6rKJrg61BKfg6ZtC5P1oebB0sMSPA7+WGr6xZEvXtaLOYgIPG0NubuE=
X-Received: by 2002:a05:6102:cd4:b0:470:5d0a:6b29 with SMTP id
 g20-20020a0561020cd400b004705d0a6b29mr951020vst.5.1709616870285; Mon, 04 Mar
 2024 21:34:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301143731.3494455-1-sumit.garg@linaro.org>
 <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com> <f539dd73-96bd-41e7-8227-fbf1ffba068b@app.fastmail.com>
In-Reply-To: <f539dd73-96bd-41e7-8227-fbf1ffba068b@app.fastmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 11:04:19 +0530
Message-ID: <CAFA6WYORMkAmoSqxA3NSfTgfdebnVt1VjJp7i23yt8L8OquWGg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, op-tee@lists.trustedfirmware.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, jerome.forissier@linaro.org, 
	linux-kernel@vger.kernel.org, mikko.rapeli@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 22:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 4, 2024, at 06:45, Sumit Garg wrote:
> > + Arnd
> >
> > On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> The error path while failing to register devices on the TEE bus has a
> >> bug leading to kernel panic as follows:
> >>
> >> [   15.398930] Unable to handle kernel paging request at virtual address ffff07ed00626d7c
> >> [   15.406913] Mem abort info:
> >> [   15.409722]   ESR = 0x0000000096000005
> >> [   15.413490]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> [   15.418814]   SET = 0, FnV = 0
> >> [   15.421878]   EA = 0, S1PTW = 0
> >> [   15.425031]   FSC = 0x05: level 1 translation fault
> >> [   15.429922] Data abort info:
> >> [   15.432813]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> >> [   15.438310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >> [   15.443372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >> [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9e3e000
> >> [   15.455413] [ffff07ed00626d7c] pgd=1800000bffdf9003, p4d=1800000bffdf9003, pud=0000000000000000
> >> [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> >>
> >> Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> >> lead to the introduction of this bug. So fix it appropriately.
> >>
> >> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218542
> >> Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  drivers/tee/optee/device.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >
> > Jens, Arnd,
> >
> > Is there any chance for this fix to make it into v6.8 release?
>
> I merged the pull request into my arm/fixes branch now, will
> send the branch on once it passes CI.

Thanks.

-Sumit

>
>      Arnd

