Return-Path: <linux-kernel+bounces-80024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F738629DA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C7F1F217EA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA087EAFA;
	Sun, 25 Feb 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8RcAZpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E3DF4E;
	Sun, 25 Feb 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852048; cv=none; b=M+VovOXvxg7jd3QymRR1EvBGrV/cDGvfnUnxRrUZW7avPqzaTLAQM/MVh29iCpiTHmQILpxWF+vP6j48meZkMNsFQqbu+yxxeMg9RavxV4xpCu5Sbi18EH4zz45epydfFlekmBCLSeJG54Fouvdo+kIH82pgwd3yLKs4yqVzDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852048; c=relaxed/simple;
	bh=PYK/d9GwUG1mPcQe3ZSvAjL+kdi6v41hYRadhrWMKaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHBfV5R0IPkw/l69zWSvFnoDTQflZITQWaXxvCrPemf3QJEhE7oxxheHALTJVVzMZ5qyfGkGTWGmr0tN24400fskDpInSDc8P5qf9DU+bmUBoR7juyzSFCVGUNjeitJQWxW064mlaIB7dfXnPoV6PQhWlj/vy4OHR+BG5A9hMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8RcAZpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C58FC43399;
	Sun, 25 Feb 2024 09:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852047;
	bh=PYK/d9GwUG1mPcQe3ZSvAjL+kdi6v41hYRadhrWMKaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j8RcAZpGwLd2HviVumLnMaaQdIBIvHfRd5kzSpeUrxoiYW+LzRTK4URuZBUSwhVM1
	 MyiUxu2S1bm/SQEXinZ7LLCbt5Hd8fk78FZBoFSGN0eq+nliIOnYv1q97aQtPdHZTT
	 YqBpaGj3VfarXuMHuYksR0jBRHuj8oYVmnlpYvaIppNpkhCUDJ/zwYbwallZNFKXgG
	 YwnywV2YnHSlV3QaDaN2F0DdLrjIIIg3gRMjXkN2YszFkovM7L+HRnwULp8sg9sxUM
	 Yu+LTmsZrj1dLcKBs+/KDgOQ5XEDtEov3aNu2WIRctomT25sEnDcXkTiQYE87jO3pY
	 YIMkoBz5+VtAw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so3063135e87.0;
        Sun, 25 Feb 2024 01:07:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDBprfBhsx6ZV4N6aPDzpUKKpLLpxDjQSxMul3HRQDRgA0HTiBAzcDWbZi5HkGWWjK+mxJuaKXI4BzqLmTtEZAvo6RK31L0iI6HugQsmLdrT0qBTX33K08B6TGBjlxTe1qJJkERS1jiaq9
X-Gm-Message-State: AOJu0YxxZqsIqiCLMSCeoysXJlDLRg2+Gg9101lBt4pq/rmF7HVFGcuf
	18hIEcZ9SiA2aTEHWI2+wTc243Kmi1KquJHbLIIlyiA9uRTz1JTrIKnQPQoKOCgQhWlUW81Bcf+
	U5hcWwhKKc5zHPbo8N0tXqlNO85A=
X-Google-Smtp-Source: AGHT+IFnlVAISkYxu41DDGpI/dXUNkSShlRW36T9wUCotoPmKbIAiJ4Zz699FS5RJkp9Ejt1UmH21RgWH6sSPcmdUTg=
X-Received: by 2002:a05:6512:40e:b0:512:ae0c:6a89 with SMTP id
 u14-20020a056512040e00b00512ae0c6a89mr2413785lfk.9.1708852045973; Sun, 25 Feb
 2024 01:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222133500.16991-1-petr.pavlu@suse.com>
In-Reply-To: <20240222133500.16991-1-petr.pavlu@suse.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 25 Feb 2024 18:06:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+p-4X-ns6XnsjA+UMhUOv7sZzd3oTVfZwPe1t_sSeFA@mail.gmail.com>
Message-ID: <CAK7LNAS+p-4X-ns6XnsjA+UMhUOv7sZzd3oTVfZwPe1t_sSeFA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Use -fmin-function-alignment when available
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, mark.rutland@arm.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:35=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> GCC recently added option -fmin-function-alignment, which should appear
> in GCC 14. Unlike -falign-functions, this option causes all functions to
> be aligned at the specified value, including the cold ones.
>
> In particular, when an arm64 kernel is built with
> DYNAMIC_FTRACE_WITH_CALL_OPS=3Dy, the 8-byte function alignment is
> required for correct functionality. This was done by -falign-functions=3D=
8
> and having workarounds in the kernel to force the compiler to follow
> this alignment. The new -fmin-function-alignment option directly
> guarantees it.
>
> Detect availability of -fmin-function-alignment and use it instead of
> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
> and enable __cold to work as expected when it is set.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---





Applied to linux-kbuild.
Thanks.



--=20
Best Regards
Masahiro Yamada

