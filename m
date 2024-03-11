Return-Path: <linux-kernel+bounces-99677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20A878BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDCC1C20F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5A59168;
	Mon, 11 Mar 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxKXPFTz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554514AECF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201392; cv=none; b=r7U6S4IXRvdVUL87r1a1agubW+kqSBeZvXalrjuSLKiTXIRrPKs5hseHpyWlW7MoWCfl0sE0CFRb2k05nYsx9dcOexFz1eIXsklMcckmR3WrZ3mypXRiEleUUTpwngoSX/bAqGb6CXA9njpR1dfjDYTM1qGOWhuCs5hjwKIflsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201392; c=relaxed/simple;
	bh=CBPmlQTNCV17qJCXDC9d5MglYstC2SN3Si9YTfgxNEQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=htHsZHdgg5GCe2bhWJTNmajDfanVhH9xtbBJLo/an5rOTmfY3MiQBVdg945zcYtfEkAGIYEPEPjr2dML2ZnuC1sG+YUSghfOq0whKmmBPvPX81KMB7+jJJ5hw235wWeq5Wmq6TH9rImNc3VfkQmOUFRt64fpHo2hcvTkJBGAWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxKXPFTz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512e39226efso4901770e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710201388; x=1710806188; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO//gFe/INRd1o2sp0jWYw78jrhLT9mVddc8MkRX8hs=;
        b=SxKXPFTzFq6OxECp8+ahFNFBoy19j6/3kuiuGFbwD+pPDUxZYNcmBlPJTsBf4Z3+ue
         cMgTKFpWL+64XzdFM3ut30N2X61fhtksJ4GWntymu1lh6BHoH4mMkSqFqiWOF3eLJNsT
         ixDBAMdGShiKG4OE2D4fLL4jM/yimyQWJ4vjeslpDVyYC2mEyOXLoc0wQ5SNa5IWbO/g
         SDiO6yom95WvIK/p1xwtc6UrXTImR3tZuATzF1Qcqok1/20eeP8TjTjB+R/TvTXKp/O6
         S5NZmSXP30fDq1jLaJbSQT4+Yzno6wDFJUlHHavR5DNCbuom8wF1a3q01OukARxk5OLw
         EEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201388; x=1710806188;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO//gFe/INRd1o2sp0jWYw78jrhLT9mVddc8MkRX8hs=;
        b=nRts7avZlivdzEeofUe/4X5mV8jFtMQHo8PZVE1yMrXhqIDiAvzORrZMwBPcCL85MB
         5GX5aZspOONjwkre2CpqZ6d+WXrynDSvRy9bXjLovmHeHi5lEJyysBrKWKryb7da0CpS
         ZVt66eP6EDaR48qR893/qy5hjBSR2rjFtuo4sIoAgSw0V2mUaDQeYizmBwExcX9GLe/x
         e9juXP0SLZDQKrIABjWJV3i00syh3du5PMdS3bDhvKiYndtS+nW0JqjVEXvxsSzkzqTt
         ErueLqN5BaQd0xpkNVX7ENak6u7QjCrSGjANam4XlYyQ3Dm7Mozn0bG8spW4tcG3X/4b
         CnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjaBWRKVGbpdwDr7bOU2TDr41ounBU1pxQ8/WcR/Z5ALlfbG3aL4hHDx5XvqeqanyqW9+o6Q8+HyZoBlDGgURlCNU/bBIp7D6QnS6l
X-Gm-Message-State: AOJu0YwCevxtJUOPY/1okTi4E2AWg8atfsbrrkcEzylsEhvhdnKAjH33
	ofDEj0nB100JZft/eZMgaOp11L8Naudw7IT/lveo3TRIBn0rXDuL
X-Google-Smtp-Source: AGHT+IHp0akq+d/VdfXLvprs6ddghMcWNrvehWL+cycGvWZaOdVnTS6lqgAiYgnhjUIGdYiVfHBuFw==
X-Received: by 2002:a05:6512:78f:b0:511:9008:7266 with SMTP id x15-20020a056512078f00b0051190087266mr4469758lfr.6.1710201387882;
        Mon, 11 Mar 2024 16:56:27 -0700 (PDT)
Received: from smtpclient.apple ([132.69.236.46])
        by smtp.gmail.com with ESMTPSA id jo20-20020a170906f6d400b00a44ce07ad77sm3272579ejb.166.2024.03.11.16.56.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2024 16:56:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com>
Date: Tue, 12 Mar 2024 01:56:11 +0200
Cc: Dave Hansen <dave.hansen@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 Christian Brauner <brauner@kernel.org>,
 bristot@redhat.com,
 Ben Segall <bsegall@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 dianders@chromium.org,
 dietmar.eggemann@arm.com,
 eric.devolder@oracle.com,
 hca@linux.ibm.com,
 "hch@infradead.org" <hch@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 jpoimboe@kernel.org,
 Joerg Roedel <jroedel@suse.de>,
 juri.lelli@redhat.com,
 Kent Overstreet <kent.overstreet@linux.dev>,
 kinseyho@google.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 lstoakes@gmail.com,
 mgorman@suse.de,
 mic@digikod.net,
 michael.christie@oracle.com,
 Ingo Molnar <mingo@redhat.com>,
 mjguzik@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>,
 vincent.guittot@linaro.org,
 vschneid@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
 <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com>
To: Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On 12 Mar 2024, at 1:41, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Mon, Mar 11, 2024, at 4:34 PM, Dave Hansen wrote:
>> On 3/11/24 15:17, Andy Lutomirski wrote:
>>> I *think* that all x86 implementations won't fill the TLB for a
>>> non-accessed page without also setting the accessed bit,
>>=20
>> That's my understanding as well.  The SDM is a little more obtuse =
about it:
>>=20
>>> Whenever the processor uses a paging-structure entry as part of
>>> linear-address translation, it sets the accessed flag in that entry
>>> (if it is not already set).
>>=20
>> but it's there.
>>=20
>> But if we start needing Accessed=3D1 to be accurate, clearing those =
PTEs
>> gets more expensive because it needs to be atomic to lock out the =
page
>> walker.  It basically needs to start getting treated similarly to =
what
>> is done for Dirty=3D1 on userspace PTEs.  Not the end of the world, =
of
>> course, but one more source of overhead.
>=20
> In my fantasy land where I understand the x86 paging machinery, =
suppose we're in finish_task_switch(), and suppose prev is Not Horribly =
Buggy (TM).  In particular, suppose that no other CPU is concurrently =
(non-speculatively!) accessing prev's stack.  Prev can't be running, =
because whatever magic lock prevents it from being migrated hasn't been =
released yet.  (I have no idea what lock this is, but it had darned well =
better exist so prev isn't migrated before switch_to() even returns.)
>=20
> So the current CPU is not accessing the memory, and no other CPU is =
accessing the memory, and BPF doesn't exist, so no one is being utterly =
daft and a kernel read probe, and perf isn't up to any funny business, =
etc.  And a CPU will never *speculatively* set the accessed bit (I told =
you it's fantasy land), so we just do it unlocked:
>=20
> if (!pte->accessed) {
>  *pte =3D 0;
>  reuse the memory;
> }
>=20
> What could possibly go wrong?
>=20
> I admit this is not the best idea I've ever had, and I will not waste =
anyone's time by trying very hard to defend it :)
>=20

Just a thought: you don=E2=80=99t care if someone only reads from the =
stack's page (you can just install another page later). IOW: you only =
care if someone writes.

So you can look on the dirty-bit, which is not being set speculatively =
and save yourself one problem.


