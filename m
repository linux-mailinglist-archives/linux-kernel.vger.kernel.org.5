Return-Path: <linux-kernel+bounces-17357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C3824C38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C535B1C21ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224091FC4;
	Fri,  5 Jan 2024 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMwET7i9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921D185B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so6134a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704415479; x=1705020279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq7vNTMud1h9RSq/r7FFlbSWd3EFsZcYUti+eAsDyuM=;
        b=kMwET7i9RRTGq3MSZ2Ii45sH7JlIk9tNlMVxKRtYXhyz8ulYeSEn/h8PDuODlRJLa7
         d8mHsPcnPweq6FOS2p+FsvlHrMmOa6CHC3Kx3W3uHuSkUYQDQX+lJUad71eBbLNelcge
         7CiXQj65BHOg0uB3uY03M7GyM2FncM2ntG//aFlBfOFBlGQHb6dg8PgmS2gsjaNCQXtU
         tLNhN7b8Y0e2gNC0YPzjetG3/xPfJr9wjNNgC0kzK6wSR92Kspas7NQ7LcJDGh5EYIWN
         izKpnltWEwHbjdsJZCcAVqWMWDMSoI5fv30ZgK3Qb4So1pq7d/THIOVNZ2qFddKnuHpt
         7ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704415479; x=1705020279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq7vNTMud1h9RSq/r7FFlbSWd3EFsZcYUti+eAsDyuM=;
        b=MUlD6wKonfkriCsilb++Z/QQfo24IfGkLOYmaI9xuPcJv7eeJwj/BDr2tXTwx6v/F/
         JU6qwHttVSsEz27W/DNa39aBgmxBxFvw9ZGDaPCQvwBdiDu6mLNLkWr8KCukig2chNcD
         tj1UffnvNRgN2smevMCg0ufIVEy4I8B4Gbv8Ai9chtut+z9wJs3WlYBIciKwg1OB4f4K
         UGtELdLR5AZ7eG42Hv+VLEp2K+JbbGlY4phSkQj3HmlvZNPpSqS8pYljJoZ/gEg1Vn85
         pRKOcV2e99PK8JXXUe3hV9FSWH1A5pMbTZceaVp7UZZpNAh2O09f5tn+OdGm1VuV5zZ9
         lYUw==
X-Gm-Message-State: AOJu0YyivHU/yexR1f5UhAonPepunVpLTwbd042QRfSIkJKbB/hb/Pgl
	0W/LQDIy8idxs/TJfXPuk48Tp1zBJhfjsVaARncizytzhC8+
X-Google-Smtp-Source: AGHT+IHaH6RdihC6ZJbGTG+oXKNf/j1jUOm6DjlSElJHRBYtIWhPklx90tLH/LSXG5H7zHVDItrojMtyZBh0XomeBCQ=
X-Received: by 2002:a50:d78c:0:b0:553:773b:b7b2 with SMTP id
 w12-20020a50d78c000000b00553773bb7b2mr74526edi.6.1704415479108; Thu, 04 Jan
 2024 16:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221140239.4349-1-weijiang.yang@intel.com>
 <93f118670137933980e9ed263d01afdb532010ed.camel@intel.com>
 <5f57ce03-9568-4739-b02d-e9fac6ed381a@intel.com> <6179ddcb25c683bd178e74e7e2455cee63ba74de.camel@intel.com>
 <ZZdLG5W5u19PsnTo@google.com> <a2344e2143ef2b9eca0d153c86091e58e596709d.camel@intel.com>
In-Reply-To: <a2344e2143ef2b9eca0d153c86091e58e596709d.camel@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 4 Jan 2024 16:44:24 -0800
Message-ID: <CALMp9eRB9JwnB22wLsef6HvDQP35HWvNrf0f44undomjYEX=Qw@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] Enable CET Virtualization
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"Yang, Weijiang" <weijiang.yang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "john.allen@amd.com" <john.allen@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:34=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2024-01-04 at 16:22 -0800, Sean Christopherson wrote:
> > No, the days of KVM making shit up from are done.  IIUC, you're
> > advocating that
> > it's ok for KVM to induce a #CP that architecturally should not
> > happen.  That is
> > not acceptable, full stop.
>
> Nope, not advocating that at all. I'm noticing that in this series KVM
> has special emulator behavior that doesn't match the HW when CET is
> enabled. That it *skips* emitting #CPs (and other CET behaviors SW
> depends on), and wondering if it is a problem.
>
> I'm worried that there is some way attackers will induce the host to
> emulate an instruction and skip CET enforcement that the HW would
> normally do.
>
> >
> > Retrying the instruction in the guest, exiting to userspace, and even
> > terminating
> > the VM are all perfectly acceptable behaviors if KVM encounters
> > something it can't
> > *correctly* emulate.  But clobbering the shadow stack or not
> > detecting a CFI
> > violation, even if the guest is misbehaving, is not ok.
> >
> [snip]
> > Yeah, I don't even know what the TRACKER bit does (I don't feel like
> > reading the
> > SDM right now), let alone if what KVM does or doesn't do in response
> > is remotely
> > correct.
> >
> > For CALL/RET (and presumably any branch instructions with IBT?) other
> > instructions
> > that are directly affected by CET, the simplest thing would probably
> > be to disable
> > those in KVM's emulator if shadow stacks and/or IBT are enabled, and
> > let KVM's
> > failure paths take it from there.
>
> Right, that is what I was wondering might be the normal solution for
> situations like this.

On AMD CPUs and on Intel CPUs with "unrestricted guest," I don't think
there is any need to emulate an instruction that doesn't either (a)
cause a VM-exit by opcode (e.g. CPUID) or (b) access memory.  I think
we should probably disable emulation of anything else, for both
security and sanity.

> >
> > Then, *if* a use case comes along where the guest is utilizing CET
> > and "needs"
> > KVM to emulate affected instructions, we can add the necessary
> > support the emulator.
> >
> > Alternatively, if teaching KVM's emulator to play nice with shadow
> > stacks and IBT
> > is easy-ish, just do that.
>
> I think it will not be very easy.

