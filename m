Return-Path: <linux-kernel+bounces-8229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F1B81B403
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999101F24D11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8A76095;
	Thu, 21 Dec 2023 10:41:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE9745E9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5f4TZjz4xPc;
	Thu, 21 Dec 2023 21:40:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Naveen N Rao <naveen@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Florent Revest <revest@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
Subject: Re: (subset) [RFC PATCH 0/9] powerpc: ftrace updates
Message-Id: <170315510015.2192823.8374732857134504654.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 08 Dec 2023 22:00:39 +0530, Naveen N Rao wrote:
> Early RFC.
> 
> This series attempts to address couple of issues with the existing
> support for ftrace on powerpc, with a view towards improving performance
> when ftrace is not enabled. See patch 6 for more details.
> 
> Patches 7 and 8 implement support for ftrace direct calls, through
> adding support for DYNAMIC_FTRACE_WITH_CALL_OPS.
> 
> [...]

Patches 1, 3 and 4 applied to powerpc/next.

[1/9] powerpc/ftrace: Fix indentation in ftrace.h
      https://git.kernel.org/powerpc/c/2ec36570c3581285d15de672eaed10ce7e9218cd
[3/9] powerpc/ftrace: Remove nops after the call to ftrace_stub
      https://git.kernel.org/powerpc/c/ae24db43b3b427eb290b58d55179c32f0a7539d1
[4/9] powerpc/Kconfig: Select FUNCTION_ALIGNMENT_4B
      https://git.kernel.org/powerpc/c/b20f98e8b3deb50247603f0242ee2d1e38726635

cheers

