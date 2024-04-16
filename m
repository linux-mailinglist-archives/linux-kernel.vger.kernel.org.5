Return-Path: <linux-kernel+bounces-146717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCEB8A69CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517141C21486
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD16129E76;
	Tue, 16 Apr 2024 11:41:06 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2AB129A73;
	Tue, 16 Apr 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267665; cv=none; b=DnmurTIRLFaZXwzvOfEAPox9GZnZLaFPZ5eXyda9YqfhgkkBeZPs7UBboh1H1qYOpmazTTVmqOkitka/m/HTtWRSr/NdcxWspngv+T28sXnxiZ/+1nf/QAxRvtbS+U7eIp8QUqyPC8uL/OsCEA67cj75bRBX1cvhSgH+zWOj1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267665; c=relaxed/simple;
	bh=kNJU8Ltay0OqFj6q8sYh4jLmXUE3xZPHeMman0C8bLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGwAhZhM6k4OkMiU2U6KspbcIi90FVxthTWFGP2to8cGVvDt3rHlYSibcUHY06QkOSeRplBOisDLuzOLmC/nuaT166IsJknk3xi9aCM+goh6HrvJ4pSXCO3VhHQg/x2NpcVRvD4LxXEz8MM/WNEBj+yDmeK9O1nV7CK7V1JQXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 43GAcL6I005112;
	Tue, 16 Apr 2024 05:38:21 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 43GAcJln005111;
	Tue, 16 Apr 2024 05:38:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 16 Apr 2024 05:38:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Message-ID: <20240416103819.GQ19790@gate.crashing.org>
References: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i

On Tue, Apr 16, 2024 at 03:02:52PM +0530, Naresh Kamboju wrote:
> In file included from arch/powerpc/include/asm/io.h:672:
> arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
> arithmetic on a null pointer has undefined behavior
> [-Werror,-Wnull-pointer-arithmetic]

It is not UB, but just undefined: the program is meaningless.

It is not a null pointer but even a null pointer constant here.  It
matters in places, including here.

It would help if the warnings were more correct :-(


Segher

