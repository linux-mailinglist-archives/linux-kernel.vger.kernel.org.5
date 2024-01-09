Return-Path: <linux-kernel+bounces-20597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD782822C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E00287D53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663A3A1BF;
	Tue,  9 Jan 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqcWRicl"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64283A1B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccec119587so30652751fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704789273; x=1705394073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUpTr3R5MAHNNKDnjs1Yne2ZKlcaDZ/3tdujoDIERYg=;
        b=SqcWRiclRiBkC/RW2OFDQijcFevna8H+7WFNbbUMcA+YI5GrZM3m3jM4YlwU5Beno9
         abSPRqHC29GNJUFolWBi0PbYYROchmvo4u2fuXtMmQufNp22ll/kyrayG0kfgwyUy8zD
         otErltidGHyuyjIF2+dP1sMyE+ut6DwzdzAK/SvNIFjyOkj8keGUyBFQkgeaQeulAR52
         RcQfHrI8+I/+TUmHQaw2Sip2UoFZs6FWp2Jn0/X8bLCg5nmeeF0oEoeLrwM/Wb3ho95K
         Z8oFT2LNwuyxfslniYhn26xqFsJ+g+wTQ5a3OnUSkUM04bdWxmN54KaP8ibOXm2YMNcQ
         Q1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704789273; x=1705394073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUpTr3R5MAHNNKDnjs1Yne2ZKlcaDZ/3tdujoDIERYg=;
        b=Ny1XK9MpLV/MFqpxch61KHXgZxYJU4+s50eNd3r68AxP08i2uDPXdjte4ij6j6M8PD
         hRD9Twx6+MgEwec0pAu2wWXnSp7ng5DrpCt0cpICiaxVYLz6mukYelQFolY65bLSc+yO
         8mNw9IkasDpLTMdGAdFAgeWOSv0PWv/uOZFvuD0sGipfmWij++brnA7ok+oZdliIG32i
         Ag/DLNbDY6+j5w2aLIr2Q49hRjCErTbj/7wvYBlcRQQsVMLlhYI9ogyVkcjhrwC1zDlB
         C29qDMeNHhdyDmjAPuECbVxSMDxPSfEEPPosSmPA52FdfNkxRDLzDHIt/SV+U667txeS
         XeSw==
X-Gm-Message-State: AOJu0YwFCfTEM84Pt9Oy8REljXTVf3ZvBW/J3ceMQ7hCaGuHdyAOUsvQ
	jaJgzeBpGedzgu09mCJpnbA=
X-Google-Smtp-Source: AGHT+IEBMXm+Y+nh7c57OWq8AVAId90ai3MvS4YNZQIaDOdiG/jNmRTVXsvhgPxi3Y/elylt+J/IkQ==
X-Received: by 2002:a2e:9919:0:b0:2cc:eaf4:4f82 with SMTP id v25-20020a2e9919000000b002cceaf44f82mr2095105lji.26.1704789272453;
        Tue, 09 Jan 2024 00:34:32 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7dd49000000b0055761a78be2sm690530edw.43.2024.01.09.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:34:31 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Jan 2024 09:34:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] x86/mm changes for v6.8
Message-ID: <ZZ0FFWqSFthvi03V@gmail.com>
References: <ZZvd5KZKVXAtM1+F@gmail.com>
 <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>
 <CAHk-=wiOJOOyWvZOUsKppD068H3D=5dzQOJv5j2DU4rDPsJBBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiOJOOyWvZOUsKppD068H3D=5dzQOJv5j2DU4rDPsJBBg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 8 Jan 2024 at 18:06, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This does not even compile for me.
> >
> >   arch/x86/include/asm/uaccess_64.h: In function ‘__untagged_addr’:
> >   arch/x86/include/asm/uaccess_64.h:25:28: error: implicit declaration
> > of function ‘__my_cpu_var’; did you mean ‘put_cpu_var’?
> > [-Werror=implicit-function-declaration]
> 
> Side note: the whole __my_cpu_var() reminds me of the attached patch
> that I have in my testing tree, and have been carrying along for a
> number of months now.
> 
> I definitely think it's the right thing to do, so here it is again,

Yeah, that's a good patch I have queued up in tip:x86/percpu:

  24b8a23638cb ("x86/fpu: Clean up FPU switching in the middle of task switching")

Merged it shortly after you sent it:

  commit 24b8a23638cbf92449c353f828b1d309548c78f4
  Author:     Linus Torvalds <torvalds@linux-foundation.org>
  AuthorDate: Wed Oct 18 20:41:58 2023 +0200
  Commit:     Ingo Molnar <mingo@kernel.org>
  CommitDate: Fri Oct 20 11:24:22 2023 +0200

I planned to send an RFC pull request for these bits in this merge window, 
after all the other x86 trees.

Thanks,

	Ingo

