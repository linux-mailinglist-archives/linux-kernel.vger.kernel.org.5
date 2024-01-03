Return-Path: <linux-kernel+bounces-15881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9218234EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEAE1F2568C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CE91CAA2;
	Wed,  3 Jan 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWx1LZ2P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EC1CA8E;
	Wed,  3 Jan 2024 18:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50E0C433AD;
	Wed,  3 Jan 2024 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704307752;
	bh=RMZCoyni1dg/u5PWGXOjNR0UmnG/FzeuF8AtWgpE53o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QWx1LZ2PIbiMG1XZqGmr22SPfJH41Dy22FvwvzfIv4KyUPRrF5q8WzXYnLQd9rs86
	 yL9ePwqcN1S1rRlB/biKp0ukhEFgmop2NIjmL5EOxem1NomAWFjolJWxrSQqZzWr8x
	 ELxW+cJ9NFuIupoCwP1JzeF0+Ju7CBhcyieXXWz28QBbjF+H9pFE7wpQi6sKHyGWLo
	 L2y3ySPb30L7oKKU6Z2zM2pPhlsfPKq1GXfNqbTtfspFz63rKyw/qVLr48k/p6PbfD
	 eF9JrBEGat+1z6GrQFq5ndH7z1VnyfJDiHgpQPidNftQNKdMLg38oO/rYLRh2LwOOF
	 4/LJj9oAZ5qwg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so48208721fa.2;
        Wed, 03 Jan 2024 10:49:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yxry7RhlAyi3fdK7SDpv6n48GBSCsU4ayGm2xpaF+igwcPDfVUi
	TX5ZCiYsCQBjcoEl/p0TGZQqRF4zrw9Klh/yVA==
X-Google-Smtp-Source: AGHT+IFb3zTv3w6i/eFBsPe9r0iuXmmX/2JiP7xGNWZZFBabGYb5yb23iDV40OA8jh6BzQ1/gm/DPrOco/LCOyYOSFg=
X-Received: by 2002:a05:651c:168f:b0:2cc:6dff:9383 with SMTP id
 bd15-20020a05651c168f00b002cc6dff9383mr5104245ljb.83.1704307750860; Wed, 03
 Jan 2024 10:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222193607.15474-1-graf@amazon.com> <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-2-graf@amazon.com>
In-Reply-To: <20231222195144.24532-2-graf@amazon.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 11:48:58 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
Message-ID: <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
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

On Fri, Dec 22, 2023 at 12:52=E2=80=AFPM Alexander Graf <graf@amazon.com> w=
rote:
>
> With KHO in place, let's add documentation that describes what it is and
> how to use it.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  Documentation/kho/concepts.rst   | 88 ++++++++++++++++++++++++++++++++
>  Documentation/kho/index.rst      | 19 +++++++
>  Documentation/kho/usage.rst      | 57 +++++++++++++++++++++
>  Documentation/subsystem-apis.rst |  1 +
>  4 files changed, 165 insertions(+)
>  create mode 100644 Documentation/kho/concepts.rst
>  create mode 100644 Documentation/kho/index.rst
>  create mode 100644 Documentation/kho/usage.rst
>
> diff --git a/Documentation/kho/concepts.rst b/Documentation/kho/concepts.=
rst
> new file mode 100644
> index 000000000000..8e4fe8c57865
> --- /dev/null
> +++ b/Documentation/kho/concepts.rst
> @@ -0,0 +1,88 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kexec Handover Concepts
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state =
-
> +arbitrary properties as well as memory locations - across kexec.
> +
> +It introduces multiple concepts:
> +
> +KHO Device Tree
> +---------------
> +
> +Every KHO kexec carries a KHO specific flattened device tree blob that
> +describes the state of the system. Device drivers can register to KHO to
> +serialize their state before kexec. After KHO, device drivers can read
> +the device tree and extract previous state.

How does this work with kexec when there is also the FDT for the h/w?
The h/w FDT has a /chosen property pointing to this FDT blob?

> +
> +KHO only uses the fdt container format and libfdt library, but does not
> +adhere to the same property semantics that normal device trees do: Prope=
rties
> +are passed in native endianness and standardized properties like ``regs`=
` and
> +``ranges`` do not exist, hence there are no ``#...-cells`` properties.

I think native endianness is asking for trouble. libfdt would need
different swap functions here than elsewhere in the kernel for example
which wouldn't even work. So you are just crossing your fingers that
you aren't using any libfdt functions that swap. And when I sync
dtc/libfdt and that changes, I might break you.

Also, if you want to dump the FDT and do a dtc DTB->DTS pass, it is
not going to be too readable given that outputs swapped 32-bit values
for anything that's a 4 byte multiple.

> +
> +KHO introduces a new concept to its device tree: ``mem`` properties. A
> +``mem`` property can inside any subnode in the device tree. When present=
,
> +it contains an array of physical memory ranges that the new kernel must =
mark
> +as reserved on boot. It is recommended, but not required, to make these =
ranges
> +as physically contiguous as possible to reduce the number of array eleme=
nts ::
> +
> +    struct kho_mem {
> +            __u64 addr;
> +            __u64 len;
> +    };
> +
> +After boot, drivers can call the kho subsystem to transfer ownership of =
memory
> +that was reserved via a ``mem`` property to themselves to continue using=
 memory
> +from the previous execution.
> +
> +The KHO device tree follows the in-Linux schema requirements. Any elemen=
t in
> +the device tree is documented via device tree schema yamls that explain =
what
> +data gets transferred.

If this is all separate, then I think the schemas should be too. And
then from my (DT maintainer) perspective, you can do whatever you want
here (like FIT images). The dtschema tools are pretty much only geared
for "normal" DTs. A couple of problems come to mind. You can't exclude
or change standard properties. The decoding of the DTB to run
validation assumes big endian. We could probably split things up a
bit, but you may be better off just using jsonschema directly. I'm not
even sure running validation here would that valuable. You have 1
source of code generating the DT and 1 consumer. Yes, there's
different kernel versions to deal with, but it's not 100s of people
creating 1000s of DTs with 100s of nodes.

You might look at the netlink stuff which is using its own yaml syntax
to generate code and jsonschema is used to validate the yaml.

Rob

