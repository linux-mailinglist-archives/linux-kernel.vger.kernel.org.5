Return-Path: <linux-kernel+bounces-21652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F031B829266
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD42288C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B51870;
	Wed, 10 Jan 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="IZvpS5rb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQj9qlMX"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6B17C6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 837823200ADA;
	Tue,  9 Jan 2024 21:21:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 09 Jan 2024 21:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704853288;
	 x=1704939688; bh=+EPYgfAmtFY42lGNnY07XOeiD5ZtD7yHEq0BdfanLnY=; b=
	IZvpS5rbsMV7m6VAvFsfpOeHPlCMEVUvtgGeXM4opGKmVYvXehQd6zXiMunzAbBu
	FZBuUx0TK3VTYkk/sqvWag8qM0sxTgwd4zNFQV32V3vAeC4j2zONn7Mg4kuXhMCt
	iGd4S0gLUlaUBbHYl8ckCl1cn0eoKWN2W+WWQrauZTVq89f+POWTBXYKaHzfcTEE
	w++b611gwJW+qyu1VIyBnfuSrBHkMDZyQwckgmg0Cl08hQo3cntpw0R9IbZXm5J7
	5c/9KM2WSupLGr+apZhB5o972y333c3rrC3D8zWlg19Z2VmU2S0k5saTKnag31E4
	ZaHF3GkvuaUfxv/l4TIdlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704853288; x=1704939688; bh=+EPYgfAmtFY42lGNnY07XOeiD5Zt
	D7yHEq0BdfanLnY=; b=lQj9qlMXrRILtujM/EurCRX6rSUm+eMPqjd0pCHdPPir
	1kA2WIS2eT3eAWq/m8Wsr31H0vzvBpndxrTyp3DuWoubJQC3FYC5mvxCJrNc6WRr
	+dAnFYC3lkLwnEDWNflyp5f547ZfaASf1GmZR+rFcyYQi2ItPCG1EfT+nPSjHVLp
	CDFroTHX67jXqczFveLR6RY1kEL85f2tbnCfY/SnCY9hRJ1cSQaMk0TcS2A9g0dH
	jVaJm+GArb5iVgZJHJ6ZtrnfcMJbpyRjbhIPBFc5eFHJZu0jAcIiAcMUU0Oiom9x
	EXO2qy6Kux+xIA7MZcfBa2TEpkIB0CFntqPXnPO7HA==
X-ME-Sender: <xms:J_-dZacK69KUD8_D_ft_9KzCsPF2zvXyepfenhEbIvU9mMqSvzUJWw>
    <xme:J_-dZUOvj-U4eLJ52Lh95tW95vwX08aRvqoNMhelUtzPyWiXj_TG9xqTPYI0w4nj_
    D0Oc0IzcQNSiSDF98s>
X-ME-Received: <xmr:J_-dZbgpyHgrqJEvfPx9dy8POFhQG6ZW5kJvBngRhARv4WLZr9e91KTETA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesmhdtreertddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtffffvdeuleeifeevleeltddtueffheelffdvveetjeevueff
    fffhgeettefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:J_-dZX9_OI3LlBxWzTlkYUIRX1g4UGDRCsII4A9BmR5ZqMJXPjjCyA>
    <xmx:J_-dZWsn8somVRMYKdyKaHj-SkK3telWllcbEMHE-3h4caaBc48Grw>
    <xmx:J_-dZeGGD5pHMsPD5lR2CHvXy-HiyGTWGfjUzg7WaG0PcNaTFfqdGQ>
    <xmx:KP-dZaKH86N9nXlyosxGXQbJk_gy_cIUfX8x_nq3evlViEq1wylDgQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 21:21:27 -0500 (EST)
Date: Tue, 9 Jan 2024 18:21:26 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
Message-ID: <ZZ3_Jmb1sb2wQWO_@localhost>
References: <202401081028.0E908F9E0A@keescook>
 <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
 <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8ZxgmFvOhzj0HYkM"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>


--8ZxgmFvOhzj0HYkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm not going to spend a lot of time and energy attempting to argue that
spawnbench is a representative benchmark, or that scheduling overhead is
a relevant part of program launch.

Instead, here are some numbers from Linus's suggested benchmark
(modified to use execvpe, and to count down rather than up so it doesn't
need two arguments; modified version and benchmark driver script
attached; compiled with `musl-gcc -Wall -O3 -s -static`):


With no patch (for-next/execve before the top two patches,
21ca59b365c091d583f36ac753eaa8baf947be6f):

=== With only PATH ===
0.32user 4.08system 0:04.55elapsed 96%CPU (0avgtext+0avgdata 1280maxresident)k
0inputs+0outputs (0major+1294599minor)pagefaults 0swaps

=== With 64 extra environment variables ===
0.29user 5.33system 0:05.76elapsed 97%CPU (0avgtext+0avgdata 1280maxresident)k
0inputs+0outputs (0major+1312477minor)pagefaults 0swaps


With my fastpath patch (for-next/execve,
0a8a952a75f2c5c140939c1616423e240677666c):

=== With only PATH ===
0.27user 2.40system 0:02.73elapsed 98%CPU (0avgtext+0avgdata 1152maxresident)k
0inputs+0outputs (0major+695002minor)pagefaults 0swaps

=== With 64 extra environment variables ===
0.29user 2.59system 0:02.94elapsed 98%CPU (0avgtext+0avgdata 1152maxresident)k
0inputs+0outputs (0major+712606minor)pagefaults 0swaps


With Linus's fastpath patch ("no patch" with Linus's applied, and the
followup -ENOMEM fix applied):

=== With only PATH ===
0.28user 2.44system 0:02.80elapsed 97%CPU (0avgtext+0avgdata 1152maxresident)k
0inputs+0outputs (0major+694706minor)pagefaults 0swaps

=== With 64 extra environment variables ===
0.29user 2.68system 0:03.06elapsed 97%CPU (0avgtext+0avgdata 1152maxresident)k
0inputs+0outputs (0major+712431minor)pagefaults 0swaps


I can reliably reproduce the differences between these three kernels;
the differences are well outside the noise. Both fastpaths are *much*
faster than the baseline, but the double-lookup version is still
consistently faster than the single-lookup version.

I'm sure it's *possible* to create a benchmark in which the
single-lookup version is faster. But in this benchmark of *just*
execvpe, it's still the case that double-lookup is faster, for *some*
reason.

I agree that it *shouldn't* be, and yet.

--8ZxgmFvOhzj0HYkM
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="t-linus-modified.c"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv, char **envp)
{
	char buffer[12];
	int n;

	if (argc != 2)
		return 1;
	n = atoi(argv[1]);
	if (n <= 0)
		return 0;
	snprintf(buffer, sizeof(buffer), "%d", n-1);
	argv[1] = buffer;
	execvpe("t", argv, envp);
	return 3;
}

--8ZxgmFvOhzj0HYkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bench

#!/bin/sh

echo === With only PATH ===
/usr/bin/time env -i PATH=/home/josh/.local/bin:/usr/lib/ccache:/sbin:/bin:/usr/sbin:/usr/bin:. t 100000

echo
echo === With 64 extra environment variables ===
/usr/bin/time env -i $(seq 1 64 | sed 's/.*/x&=&/') PATH=/home/josh/.local/bin:/usr/lib/ccache:/sbin:/bin:/usr/sbin:/usr/bin:. t 100000

--8ZxgmFvOhzj0HYkM--

