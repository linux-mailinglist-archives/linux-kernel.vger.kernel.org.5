Return-Path: <linux-kernel+bounces-106965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEE87F61A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F271F2287A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F67BB12;
	Tue, 19 Mar 2024 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaxrcT7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A880657A9;
	Tue, 19 Mar 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819472; cv=none; b=FywetHd60b8je637klfH2bEM0jDRE/SBRda//jU+IolLtQi8aw5rLD9N4wjFmG7N+ZTr/k01rGnGX1Z8sejO/bkVO2XREgv2jM2p/FC8IS33VvzGK57RWDXhkJZ0uj7DkQE6bFPuwJiIyGTMb3heDcyEbnkU4+9GApAosb48YhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819472; c=relaxed/simple;
	bh=VebSyVF5bHPrPRjmNRIpWZO5EROr4cyAn3m11V+qwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtZnBFf8keMcyXzn81yZNL2DcvFgt6X0vp/xfMbQIQH/WKmvjHNBN9GWs3M/1YxGfZLW+6Z3rlWgmZSyrc0ys22hFXpB+H4zNuieZA5m7+W61G/9Yw70XK5lZ+PHjYnyNheYwq1REEliSqUOFwIVjHnGwBtVnPbE7lXv4M5j/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaxrcT7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FA8C433F1;
	Tue, 19 Mar 2024 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710819471;
	bh=VebSyVF5bHPrPRjmNRIpWZO5EROr4cyAn3m11V+qwRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eaxrcT7no+9PDOYRe21156WwnGaYAKx1nj7+f47W+Rb6taX7Xpn/0D5OmVonT1FY8
	 c8SqFNBOM2kMltEOe2PAUzSH6qY3BZZf0ljF6epCaOSbCyfX/p05Nr6fDX+lGoqRED
	 b9HeD4Vh90uJC2LhEaWXcCCmGwiBRm9y5oMoJlyFe8woGhYv420N1jK1/gwlMqdQk4
	 rw/im6Q7h2r9KjabYQ/vHyoF0cGOsLrCvOM0lRa1jSUEh5vAX3EZl7pM+TwKJi4SkH
	 +vrf924R64pr3WVzAiPaAm6wqXT0ala6mqgoGu7WF8BfR3+7UOzh72I/mlxQKxSKNJ
	 hp5lXNyLBC05w==
Date: Mon, 18 Mar 2024 22:37:49 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: cmd-db: replace deprecated strncpy with
 strtomem
Message-ID: <ag7oslzfcuiyuehxq5n5jth4adrhel4xafby5whxsvyybbm6dc@6rtwaolbmm45>
References: <20240318-strncpy-drivers-soc-qcom-cmd-db-c-v2-1-8f6ebf1bd891@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-soc-qcom-cmd-db-c-v2-1-8f6ebf1bd891@google.com>

On Mon, Mar 18, 2024 at 10:49:23PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 

I don't mind changing the strncpy() in this function, but I don't think
this problem description adequately describes the problem you're
solving.

If the motivation is that we want 0 users of strncpy() in the kernel,
then say so.

> @query is already marked as __nonstring and doesn't need to be
> NUL-terminated.

You're not wrong, but in the event that strlen(id) < sizeof(ent->id) the
destination should be NUL-padded - exactly one of the well known,
normally unwanted, effects of strncpy(). strtomem() does explicitly not
do this.

> Since @id is a string, we can use the self-describing
> string API strtomem().

"self-describing"?

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use strtomem instead of memcpy (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/soc/qcom/cmd-db.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed..d05f35d175bd 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -141,18 +141,13 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
>  	const struct rsc_hdr *rsc_hdr;
>  	const struct entry_header *ent;
>  	int ret, i, j;
> -	u8 query[sizeof(ent->id)] __nonstring;
> +	u8 query[sizeof(ent->id)] __nonstring = { 0 };
>  
>  	ret = cmd_db_ready();
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Pad out query string to same length as in DB. NOTE: the output
> -	 * query string is not necessarily '\0' terminated if it bumps up
> -	 * against the max size. That's OK and expected.
> -	 */
> -	strncpy(query, id, sizeof(query));
> +	strtomem(query, id);

query needs to be NUL-padded to sizeof(ent->id) bytes (like strncpy
does), something you recognized by adding the zero-initialization above.
But why split this requirement across two non-adjacent lines? Isn't this
what strtomem_pad() is supposed to do?

Regards,
Bjorn

>  
>  	for (i = 0; i < MAX_SLV_ID; i++) {
>  		rsc_hdr = &cmd_db_header->header[i];
> 
> ---
> base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
> change-id: 20240314-strncpy-drivers-soc-qcom-cmd-db-c-284f3abaabb8
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

