Return-Path: <linux-kernel+bounces-103727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA787C3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5995A1F22A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEED757F5;
	Thu, 14 Mar 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="PYGKHaRk"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7A73518
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444229; cv=none; b=t4NZm1IHGy2qwrqU4UqFN8rPUzuyXT3fgVcAaM9IBqVIgSqLQf+1M1AKpTh9zP8gAtfAW/5eWvnaOyn3kOkFSR8wlPePZOw/Gixz1DQBn70pee6O9kULcJ3C/I6bkCOXNA75ZlaKv74hM9Il572Fx+rPxpH9M7OxZW8P9robMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444229; c=relaxed/simple;
	bh=+0NXYjMZ2LJxbuyhYKVxftPgOo9IRJftN8N4BfdKb9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chFZy9mzBL6erOS6mLNKsgw9MGNPY105sHCdbfFrKr8zSESG4qrlqg1xlEWCnG3hdMbPNL4PzztN92mTIr+f1LSaExvIKbGny03ZRllQe32ti0ueJ27vOiPOipm2IHSg3wy5QITzOUcrElYZi/6kbvIbzLxynv6W3F/KXxbaF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=PYGKHaRk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42efa84f7b5so17523511cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710444226; x=1711049026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0NXYjMZ2LJxbuyhYKVxftPgOo9IRJftN8N4BfdKb9g=;
        b=PYGKHaRkpmnq+odDctVQN5sfqxqaQB953L8igYjR8GwgD1hsYffkB8XS2+YBH4gjx/
         d8Qm2V8A/ToZR6JXvSBVz/msjlwSq4LW6kdpp9b4tY1cME4Qu3IUE6RRNWwGsvsT3wfW
         4b6CpLD/Zq28DGKekc7rVBGuca9Fw7UQoqI9SXC+SYskLn0PQuuWeJH4WX1XiMXNEPDZ
         +Fx7BhtUL6ag8LGsXDmo6xqZSdgkqe6Aggy4gkvNOkYmgBAtCwmKxN8i2gvrd4fZ6Ycf
         VkASw6hVcoCw38uR2JKuz21QCOFmt9XCUNKmCyahYvdh1WHsxmaV/sqUt+bTpGl9rhzY
         EUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444226; x=1711049026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0NXYjMZ2LJxbuyhYKVxftPgOo9IRJftN8N4BfdKb9g=;
        b=uZEqzN1ZcwVGYm+jK0mfsU1lmnCWQPbc0qIa30xHRv7Nut48zjAByXjCA/KKM7ZHxG
         OGnKaVh/DFXCyerbKuLtmD8+WmrD5ob+PwuTrmcXgyvE6bVRQY78ihjM5VGVZ7lr8UIp
         86mIT9xdl30MsZ5tZwnHD5Ly4/ZhYJKOs+XdVVOswUJeIRUoLtBLU7TzL4uG0lsSvV9R
         AT4/XzvkiQJcvmZav31qQgXaiqjoEIKAmswhG4lqClY60NWBiXR4lEkeMEW8NG3oNww+
         eXJvPctFzlqgaZMuTKY6CNwMm2bSMh4bqQDPzxNWfOO/2TeBpJ9HuN801ia+0dDxIhGH
         vBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDVy1vpGeN4+GcE6uDTgcc0llNur9oXdry1Ewq3Nitx75QYHp8EVR6ZKGivQqYlAhy1oGQaq4s5S20ZjgKOd2eZex4aCLncF9OiXij
X-Gm-Message-State: AOJu0Yx2qhBnM8ekbiE9dHPbZ4QnIgHj77udA255ZAmehDUqHH7MLBmk
	HdsASB7kE7YN60UCr9nJ1CcIQZffC8AlgGqnB2bCtGa1iY3ninZdYgF/kAsNCUX4hF3081tvw9a
	CCsILtd89h/EeGx7Lki0zHQ1d03JuMU4HREcM/g==
X-Google-Smtp-Source: AGHT+IGVDUByb7IqEG6qYmMGOmZZDzsWc47CuoUlbbNK7kFk82tGdc3EZIBCp//9t2WYX9m8I3kUxcxBPsy41NWuBbs=
X-Received: by 2002:ac8:7c50:0:b0:42f:201c:d4e3 with SMTP id
 o16-20020ac87c50000000b0042f201cd4e3mr4648051qtv.13.1710444226166; Thu, 14
 Mar 2024 12:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
 <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com> <fp6tyl6laseytepxpyidvwjo4dl357dtqegzumrc5ao6srm6we@afcl57kvjieb>
In-Reply-To: <fp6tyl6laseytepxpyidvwjo4dl357dtqegzumrc5ao6srm6we@afcl57kvjieb>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 15:23:08 -0400
Message-ID: <CA+CK2bA+ACXv955KXpP3ZW47n7tiZqzUMz9s09cJMUD7Cz2Log@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com, 
	jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

> >
> > My point is that what matters is total memory use, not just memory used in
> > the kernel. Amdahl's law.
>
> If userspace is running a few processes with many threads and the
> userspace stacks are small, kernel stacks could end up dominating.
>
> I'd like to see some numbers though.

The unused kernel stack pages occupy petabytes of memory across the fleet [1].

I also submitted a patch [2] that can help visualize the maximum stack
page access distribution.

[1] https://lore.kernel.org/all/CA+CK2bBYt9RAVqASB2eLyRQxYT5aiL0fGhUu3TumQCyJCNTWvw@mail.gmail.com
[2] https://lore.kernel.org/all/20240314145457.1106299-1-pasha.tatashin@soleen.com

