Return-Path: <linux-kernel+bounces-132817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B7899AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CFE1C215A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940861649C8;
	Fri,  5 Apr 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="p8wGCgW6"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BE161902;
	Fri,  5 Apr 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312578; cv=none; b=kdGfLICJh0IjlS/rq3KN7WYDwyHHa7qPJGTY+ZRj4sAs//KlG5yyPLhf6eeyzrPaRLhV5FkzMO7JJQcH5CbApu2j7Wgau9HbcLgZiHGNGk02z7f6vyzik163SKVLPflJnvDb901Bg6sv/vP+E1aU/jfNF5fc42r8khTMezSqdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312578; c=relaxed/simple;
	bh=20WIFlqzXv8bEsaIHY6yoNZA6nIiAZntm4F/ctnVrUg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h3Gr3dxCwS8uF/zycaJ507FB7FkdJYLTpwSJkqCRZFWTY5ofHUJvDeRSrBkR4x7boa8DlgNGZABLtyjWPtNhtFfLuEhuJReDhJ3kOUSpn72k0kngN2nAGU3H6KwA4cNK8j0GiTaEEfRhGjMMoFeQcygTF58CJeFWSPSjdONon0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=p8wGCgW6; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=CBcb0HqkxR3k46bsLAYeHj2Pxqw1LMgdMN4SvfAtuUo=;
	t=1712312576; x=1712744576; b=p8wGCgW6veaEPLnuFcloMunOMkOFF/yhV1+DqXtM6eyZZE/
	AWlmqN0X7+2w+bkSDuOwmvrW8qHr79ptMmK2mnKDWjA2fnBvTeHXv1/LjTjovuqsciRrztEpc2rcO
	sb5goXnA3ti6qdw1WMdLXkhbWjXxyZW2TRSnivAdnDAmHtJF74yip6+lVQBzBEY5/+/olycGkdO1/
	50qD8gqGoAlmmCuSVE81rIDyry06si3hcWn81eu82DM8afVdKHN9JylTHjoh7sMOmk1lXFjvrEH+N
	uSkOfTxCTBL6MKMX1TWzgW/W4BOLlVZRjBKwQTMJSrRie3bDLLmRSZwVbzKQRreg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rsgih-0007ZM-8N; Fri, 05 Apr 2024 12:22:51 +0200
Message-ID: <96059b4b-f58c-49f9-8fdf-ccdcfdde6abc@leemhuis.info>
Date: Fri, 5 Apr 2024 12:22:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] docs: verify/bisect: fine tuning, testing fixes,
 and using a build host
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <cover.1711963460.git.linux@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <cover.1711963460.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712312576;f029586c;
X-HE-SMSGID: 1rsgih-0007ZM-8N

On 01.04.24 11:29, Thorsten Leemhuis wrote:
> A quick series with various improvements for
> Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.

Feel free to ignore this series, I found another problem and will post a
v2 within a few days. Will likely also use that occasion to split the
first patch into two, it does a bit too much.

Ciao, Thorsten

> * The first patch contains various fixes and some fine tuning.
> 
> * The second adds a few instructions for later testing of reverts,
>   fixes, or newer versions. This was already hinted at; but during some
>   early work on Documentation/admin-guide/reporting-issues.rst to better
>   reconcile the two it seemed wise to cover this properly here.
> 
> * The third patch briefly outlines how to build kernels on a different
>   host; it came into being after a second user within one week asked for
>   this. That also allowed the text to briefly cover cross-compilation.
> ---
> 
> Hi! While at it let me mention one more thing unrelated to the changes
> where I'm unsure if the current approach by the text was a wise choice:
> 
> * Should the document tell users to avoid mainline during merge windows?
> 
> Some input from the community on this would be splendid.
> 
> Ciao, Thorsten
> 
> P.S.: Not totally sure, but I think this should go into 6.9 as this is
> a new document; but I can split this up if the two latter patches better
> should go into -next.
> 
> Thorsten Leemhuis (3):
>   docs: verify/bisect: git switch; proper headlines; various fixes;
>   docs: verify/bisect: explain testing reverts, patches and newer code
>   docs: verify/bisect: describe how to use a build host
> 
>  .../verify-bugs-and-bisect-regressions.rst    | 469 +++++++++++++-----
>  1 file changed, 344 insertions(+), 125 deletions(-)
> 
> 
> base-commit: b8cfda5c9065cd619a97c17da081cbfab3b1e756

