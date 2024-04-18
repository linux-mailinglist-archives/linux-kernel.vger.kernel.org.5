Return-Path: <linux-kernel+bounces-150189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8D8A9B81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEED128383B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC6161331;
	Thu, 18 Apr 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAMMwApP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BA15FD0D;
	Thu, 18 Apr 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447820; cv=none; b=osYolH8Y79zZhM5Md18KpUwsOfYoShC0Xw57tbi7Ut0dI0oxz1VHs4LB7iuA1SDnOhVZxMdLF8XhfoB+Rr9JomNjgUm+5H7E5Uz3Hldsbd8Iukk0IQGl/Ypix/6I26ZdcsySbSNDHIDrJao90Fv7MG6nyHdTQVSAxh8PfoTUNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447820; c=relaxed/simple;
	bh=QDNb5ClnywQly+K1RFM4EfM2oAMTBQMt3LKpDKIflW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBGYd4gr9kN50LHUajqyYZroexTDYxabu3JC97pxfBPvImR/Y0aO9B+7NWRCbwYrwXdxauUSvqDtWTpfchD7Al2+Oz8QKmFRmnU0vowjehLdwhZp9t6E5V+eUF5OWc6riQ1NpqTSYuG+l18IPb6+IkLCJFtRqmcSiCZ7nN8/MXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAMMwApP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06F6C113CC;
	Thu, 18 Apr 2024 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713447820;
	bh=QDNb5ClnywQly+K1RFM4EfM2oAMTBQMt3LKpDKIflW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAMMwApPNUzbwsqK6TgvCLdC58a8ukIeCu9cVFLZYP450Bt2YDgLOz0r4n8i5SwW2
	 sMTaRE26R/F49MSG3j8sb4VQ7awXQ6kussQ4y2fpE+gmDelAGpqwLeJ7vbrzoDbSDe
	 u11vr0z11ZqXFsLn3Wsh7L8cKHWDIVdblkIFVFyHOpNej8h07xz7IZKf/b8fN2O8PD
	 qXuW/YrggmMqmc8xWL5AAIRjonC5Fab+2sNBpIuiQzUrrtDyJPxI1owSva9SbQtX1v
	 gBscqDmn9JDFk9v3wlJY4Yqwg8eaI6sWeD5osHqLEBr5zM9w+epQnSopwkUjTOOFzJ
	 IUj575s4ua/7Q==
Date: Thu, 18 Apr 2024 08:43:37 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for
 source directory
Message-ID: <20240418134337.GA1174228-robh@kernel.org>
References: <20240416121838.95427-1-masahiroy@kernel.org>
 <20240416121838.95427-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121838.95427-5-masahiroy@kernel.org>

On Tue, Apr 16, 2024 at 09:18:38PM +0900, Masahiro Yamada wrote:
> Kbuild conventionally uses $(obj)/ for generated files, and $(src)/ for
> checked-in source files. It is merely a convention without any functional
> difference. In fact, $(obj) and $(src) are exactly the same, as defined
> in scripts/Makefile.build:
> 
>     src := $(obj)
> 
> When the kernel is built in a separate output directory, $(src) does
> not match the directory in the source tree. It still works because the
> top Makefile sets VPATH to $(srctree). However, VPATH does not cover
> all cases. There are many places where the exact path to the source
> directory is needed. For example, when adding a header search path for
> local headers, it is typical to pass -I$(srctree)/$(src) to the compiler.
> 
> However, it introduces inconsistency between upstream Makefiles and
> downstream Makefiles; when the source directory path is needed,
> $(srctree)/$(src) is used in the upstream kernel, while $(src) is used
> in external modules.
> 
> To resolve the distortion, this commit changes the semantics of $(src)
> so that it always points to the directory in the source tree.
> 
> Going forward, the variables used in Makefiles will work as follows:
> 
>   $(obj)     - directory in the object tree
>   $(src)     - directory in the source tree  (changed by this commit!)
>   $(objtree) - the top of the kernel object tree
>   $(srctree) - the top of the kernel source tree
> 
> This is a tweewide Makefile conversion for replacing $(srctree)/$(src)
> with $(src).
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Documentation/Makefile                             |  8 ++++----
>  Documentation/devicetree/bindings/Makefile         | 10 +++++-----

Acked-by: Rob Herring (Arm) <robh@kernel.org>

However, this is going to conflict with my series here[1]. Can you pick 
it up?

Rob

[1] https://lore.kernel.org/all/20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org/


