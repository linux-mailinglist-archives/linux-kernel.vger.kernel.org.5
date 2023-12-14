Return-Path: <linux-kernel+bounces-55-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE0813B57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F50B1F223A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB96A350;
	Thu, 14 Dec 2023 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3uXO53yS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A776A03D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so8400577a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702584816; x=1703189616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6UuF2I+ksa0nRBkfH8g4L0LiVSfO6AHAS12VBA0d84=;
        b=3uXO53yS0xx9GMoa+komR8PI861qPpzCKzKGgx56phJ8Hs2Bgv1uJfdXktZ1DtAf+h
         LMpt+mcZiChHv4qbuyM9LI+CGrJNAriiPtatLimiZp9Y41osIH4nu3+QaYQa9ylrtp9c
         5XFOnAdGlNNMZmSwqtIBU87d/AbBuy+Zx0egjOtZmvDQZuot3Y92Q/+KUbJ4NWxR31Ci
         TY1i5HPd93n+XrZ9a+LE2NPhE1cX9lYO0t+sHD/vPL0IxZus8SjQF/u/RkJCZZfEzpgP
         Sl25R2eTWqEldgUPSw2vtHsi792+1hzII1t1YpSE4U10WnU/KUCMqeRZhMckVE/88TC4
         +8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584816; x=1703189616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6UuF2I+ksa0nRBkfH8g4L0LiVSfO6AHAS12VBA0d84=;
        b=N3gi6UlUBFpMMZtnxNtSNtz5fEYSSFSlePDQcwO1/ZwofjxzzJqnu/hn/waC9ky1uv
         lfClYBfkH6MtSgEm6RmMcQ9Ehh2qWqX7OJMRzvUiSooQjZ909yToddYEQjrNW2f0HjSF
         pwzkLgjafT/qnW/0HR+cgWIn7kGgp3vBD4uk32vbnRXA45WhJ6JlhobWB336PSf1MXEv
         mnwRzR7B8uOaSA5MOajhruHeCLTVl7/JUk6VXXpYVNUOuSIlCvD69Q7cJkDreitF5kzq
         ENo5ec+7bwoqUCWc9NMrckoLF5BHsuaMNPKGTbbkjKJMjJ11Zeot85EsQjdWjHwOTyt5
         cTsQ==
X-Gm-Message-State: AOJu0Yw8v2GVEKiszD1uUfdAW4gapAeKI+Me7AKetpwfmWFejG7v/74Q
	adSsK4U7ZGeFCj7IbrgjKuLvJN07P4U=
X-Google-Smtp-Source: AGHT+IGEiwa1cSoRDflydMN7++Q6taulTF4HV3L/RNxde17wAejKqSXkzjYYxVXM2/0619dGhrSppCrZiaM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b18f:b0:1d0:9b2d:5651 with SMTP id
 s15-20020a170902b18f00b001d09b2d5651mr1570045plr.1.1702584816052; Thu, 14 Dec
 2023 12:13:36 -0800 (PST)
Date: Thu, 14 Dec 2023 12:13:34 -0800
In-Reply-To: <CAO7JXPihjjko6qe8tr6e6UE=L7uSR6AACq1Zwg+7n95s5A-yoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
 <ZXsvl7mabUuNkWcY@google.com> <CAO7JXPihjjko6qe8tr6e6UE=L7uSR6AACq1Zwg+7n95s5A-yoQ@mail.gmail.com>
Message-ID: <ZXth7hu7jaHbJZnj@google.com>
Subject: Re: [RFC PATCH 0/8] Dynamic vcpu priority management in kvm
From: Sean Christopherson <seanjc@google.com>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Suleiman Souhlal <suleiman@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, David Vernet <dvernet@meta.com>, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023, Vineeth Remanan Pillai wrote:
> On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> Now when I think about it, the implementation seems to
> suggest that we are putting policies in kvm. Ideally, the goal is:
> - guest scheduler communicates the priority requirements of the workload
> - kvm applies the priority to the vcpu task.

Why?  Tasks are tasks, why does KVM need to get involved?  E.g. if the prob=
lem
is that userspace doesn't have the right knobs to adjust the priority of a =
task
quickly and efficiently, then wouldn't it be better to solve that problem i=
n a
generic way?

> - Now that vcpu is appropriately prioritized, host scheduler can make
> the right choice of picking the next best task.
>=20
> We have an exception of proactive boosting for interrupts/nmis. I
> don't expect these proactive boosting cases to grow. And I think this
> also to be controlled by the guest where the guest can say what
> scenarios would it like to be proactive boosted.
>=20
> That would make kvm just a medium to communicate the scheduler
> requirements from guest to host and not house any policies.  What do
> you think?

...
=20
> > Pushing the scheduling policies to host userspace would allow for far m=
ore control
> > and flexibility.  E.g. a heavily paravirtualized environment where host=
 userspace
> > knows *exactly* what workloads are being run could have wildly differen=
t policies
> > than an environment where the guest is a fairly vanilla Linux VM that h=
as received
> > a small amount of enlightment.
> >
> > Lastly, if the concern/argument is that userspace doesn't have the righ=
t knobs
> > to (quickly) boost vCPU tasks, then the proposed sched_ext functionalit=
y seems
> > tailor made for the problems you are trying to solve.
> >
> > https://lkml.kernel.org/r/20231111024835.2164816-1-tj%40kernel.org
> >
> You are right, sched_ext is a good choice to have policies
> implemented. In our case, we would need a communication mechanism as
> well and hence we thought kvm would work best to be a medium between
> the guest and the host.

Making KVM be the medium may be convenient and the quickest way to get a Po=
C
out the door, but effectively making KVM a middle-man is going to be a huge=
 net
negative in the long term.  Userspace can communicate with the guest just a=
s
easily as KVM, and if you make KVM the middle-man, then you effectively *mu=
st*
define a relatively rigid guest/host ABI.

If instead the contract is between host userspace and the guest, the ABI ca=
n be
much more fluid, e.g. if you (or any setup) can control at least some amoun=
t of
code that runs in the guest, then the contract between the guest and host d=
oesn't
even need to be formally defined, it could simply be a matter of bundling h=
ost
and guest code appropriately.

If you want to land support for a given contract in upstream repositories, =
e.g.
to broadly enable paravirt scheduling support across a variety of usersepac=
e VMMs
and/or guests, then yeah, you'll need a formal ABI.  But that's still not a=
 good
reason to have KVM define the ABI.  Doing it in KVM might be a wee bit easi=
er because
it's largely just a matter of writing code, and LKML provides a centralized=
 channel
for getting buyin from all parties.  But defining an ABI that's independent=
 of the
kernel is absolutely doable, e.g. see the many virtio specs.

I'm not saying KVM can't help, e.g. if there is information that is known o=
nly
to KVM, but the vast majority of the contract doesn't need to be defined by=
 KVM.

