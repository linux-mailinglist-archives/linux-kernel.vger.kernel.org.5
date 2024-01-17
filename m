Return-Path: <linux-kernel+bounces-29245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66306830B88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4111C23159
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5D224FB;
	Wed, 17 Jan 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng0rHk/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961F1E536;
	Wed, 17 Jan 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510498; cv=none; b=OrAEoYLUZLCe6siX+IyFiBHB69UR/6GZlU+FYHviBYNrXv2J68y4LLOgtm6iKJPPUdbz29RFcdZsv/1iHNIRe1EzT+THc7MpGvgc+Untyu6zEpNWYTV+nIvq8Dfrm8IqqAQsAxmMWjxfGgpTZMaDATZShAASP1lUf4SnUkyQOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510498; c=relaxed/simple;
	bh=icda5nsBxvN2zQNuUU8kfCVX7lRfPCzR7ERj2A/6N3o=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=vDgAB+PuiWbsRINQpaX/ttIQCOO1pCQ9dZUJjdDdZ8a1rkP5aKoj9MCJaTzUoxK+MTYcfphRL785ps6H7OqHpP4yP24Rg/+UDUNghdy8+qrkVeG5bHltY5UZK5rXDvHla2ZFDDT5DWFnhNH9EiBr8A9ZQfsBtREzh2RFCyLeECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng0rHk/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0907AC4166C;
	Wed, 17 Jan 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705510498;
	bh=icda5nsBxvN2zQNuUU8kfCVX7lRfPCzR7ERj2A/6N3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ng0rHk/FO9y+GoC5HfzKWt5ufHH/DLDxWrPoHpgAcFWF5/iCRTSZt7xVQQWZasRus
	 GulmTUc+i93vLU+74N8grdUut/GsGniGLuH4yj4Xtn5l2fy6MvoxHoYXCANZ8Cy5TS
	 gpawaK9ILPMzdk3X6RVNmH4l5N3Oqv7oB6jFgSC8igtYAaem5xpUAXN31CBti6N9Xb
	 7Yvdi7dRY7U3F+vTq4iEHmvdLybn88m0xyP6zPCpsDZUNqeo97/JJrPw+3rYXW1/Z3
	 Nx8hfx/yWVXTpvKTXkfF8/KczEpmZdcYAqjwnE8lvXNx3w/ES2MQ5MYAvo9uCt/DLO
	 /TnXFUzGsus8w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so141483601fa.0;
        Wed, 17 Jan 2024 08:54:57 -0800 (PST)
X-Gm-Message-State: AOJu0YwrE5SQz3todD/Uaxsk86m0zAZonQIFfXF1lHZA3zRzpQhhXz3P
	MErzvuAQhGsWirefjFPbNGTbMp+5HM5Wpei26A==
X-Google-Smtp-Source: AGHT+IE1jgfkJTBfpZ+F4Qzd8uKAwaxoFhnJYLyCjbq9zXmhEnH+sTN071x2CqqdMwDg1wusyGKF4SkodcMKgVdt/Us=
X-Received: by 2002:a2e:bd02:0:b0:2cc:d864:1260 with SMTP id
 n2-20020a2ebd02000000b002ccd8641260mr5936076ljq.62.1705510496033; Wed, 17 Jan
 2024 08:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222193607.15474-1-graf@amazon.com> <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-2-graf@amazon.com> <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
 <c96203ba-a5b2-4765-9d30-0f4e66c82cd7@amazon.com>
In-Reply-To: <c96203ba-a5b2-4765-9d30-0f4e66c82cd7@amazon.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 17 Jan 2024 10:54:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK2WaH+vWd-hcrCSzycMGTztX4i2p1wpECseD_M3EY0tA@mail.gmail.com>
Message-ID: <CAL_JsqK2WaH+vWd-hcrCSzycMGTztX4i2p1wpECseD_M3EY0tA@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kexec: Add documentation for KHO
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, x86@kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	James Gowans <jgowans@amazon.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, 
	madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 8:02=E2=80=AFAM Alexander Graf <graf@amazon.com> wr=
ote:
>
>
> On 03.01.24 19:48, Rob Herring wrote:
> >
> > On Fri, Dec 22, 2023 at 12:52=E2=80=AFPM Alexander Graf <graf@amazon.co=
m> wrote:
> >> With KHO in place, let's add documentation that describes what it is a=
nd
> >> how to use it.
> >>
> >> Signed-off-by: Alexander Graf <graf@amazon.com>
> >> ---
> >>   Documentation/kho/concepts.rst   | 88 ++++++++++++++++++++++++++++++=
++
> >>   Documentation/kho/index.rst      | 19 +++++++
> >>   Documentation/kho/usage.rst      | 57 +++++++++++++++++++++
> >>   Documentation/subsystem-apis.rst |  1 +
> >>   4 files changed, 165 insertions(+)
> >>   create mode 100644 Documentation/kho/concepts.rst
> >>   create mode 100644 Documentation/kho/index.rst
> >>   create mode 100644 Documentation/kho/usage.rst
> >>
> >> diff --git a/Documentation/kho/concepts.rst b/Documentation/kho/concep=
ts.rst
> >> new file mode 100644
> >> index 000000000000..8e4fe8c57865
> >> --- /dev/null
> >> +++ b/Documentation/kho/concepts.rst
> >> @@ -0,0 +1,88 @@
> >> +.. SPDX-License-Identifier: GPL-2.0-or-later
> >> +
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +Kexec Handover Concepts
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve sta=
te -
> >> +arbitrary properties as well as memory locations - across kexec.
> >> +
> >> +It introduces multiple concepts:
> >> +
> >> +KHO Device Tree
> >> +---------------
> >> +
> >> +Every KHO kexec carries a KHO specific flattened device tree blob tha=
t
> >> +describes the state of the system. Device drivers can register to KHO=
 to
> >> +serialize their state before kexec. After KHO, device drivers can rea=
d
> >> +the device tree and extract previous state.

Can you avoid calling anything "device tree" as much as possible. We
can't avoid the format is FDT/DTB, but otherwise none of this is
Devicetree as most folks know it. Sure, there can be trees of devices
which are not Devicetree, but this is neither. You could have used
BSON or any hierarchical key-value pair serialization format just as
easily (if we already had a parser in the kernel).

> > How does this work with kexec when there is also the FDT for the h/w?
> > The h/w FDT has a /chosen property pointing to this FDT blob?
>
>
> Yep, exactly.

Those properties need to be documented here[1].

[...]

> >> +KHO introduces a new concept to its device tree: ``mem`` properties. =
A
> >> +``mem`` property can inside any subnode in the device tree. When pres=
ent,
> >> +it contains an array of physical memory ranges that the new kernel mu=
st mark
> >> +as reserved on boot. It is recommended, but not required, to make the=
se ranges
> >> +as physically contiguous as possible to reduce the number of array el=
ements ::
> >> +
> >> +    struct kho_mem {
> >> +            __u64 addr;
> >> +            __u64 len;
> >> +    };
> >> +
> >> +After boot, drivers can call the kho subsystem to transfer ownership =
of memory
> >> +that was reserved via a ``mem`` property to themselves to continue us=
ing memory
> >> +from the previous execution.
> >> +
> >> +The KHO device tree follows the in-Linux schema requirements. Any ele=
ment in
> >> +the device tree is documented via device tree schema yamls that expla=
in what
> >> +data gets transferred.
> > If this is all separate, then I think the schemas should be too. And
> > then from my (DT maintainer) perspective, you can do whatever you want
> > here (like FIT images). The dtschema tools are pretty much only geared
> > for "normal" DTs. A couple of problems come to mind. You can't exclude
> > or change standard properties. The decoding of the DTB to run
> > validation assumes big endian. We could probably split things up a
> > bit, but you may be better off just using jsonschema directly. I'm not
> > even sure running validation here would that valuable. You have 1
> > source of code generating the DT and 1 consumer. Yes, there's
> > different kernel versions to deal with, but it's not 100s of people
> > creating 1000s of DTs with 100s of nodes.
> >
> > You might look at the netlink stuff which is using its own yaml syntax
> > to generate code and jsonschema is used to validate the yaml.
>
>
> I'm currently a lot more interested in the documentation aspect than in
> the validation, yeah. So I think for v3, I'll just throw the schemas
> into the Documentation/kho directory without any validation. We can
> worry about that later :)

I'll regret that when I get patches fixing them, but okay.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
chosen.yaml

