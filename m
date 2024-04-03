Return-Path: <linux-kernel+bounces-129926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B014189721A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CBE1F2AC54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CB3149C42;
	Wed,  3 Apr 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FsgdTNda"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C014900C;
	Wed,  3 Apr 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153643; cv=none; b=fs3RfVb6VvVorO1XSf3Kjw5Vzy5qRKbbaH/0lSCOncW8RroT6usF4Yu4mc2vqWjMQfF0Wqgn5uTmJu6dFJhSLE06AsJRUHC9yt8ThmDPBLWFrwu0Oz7UKMtWX0pkL2DecR5Kek+DX95O53fz7OVlZbarqVcYUOPv2s6ggd0ZL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153643; c=relaxed/simple;
	bh=DwlKSANN19zo2hxwH89sP0PAV6BFj/6aU1fv2ORo6Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pny23h5cV/Sd63GEkWj32LyZmtqacd325tqxZZTfAR+GAasMq2SoO6nNfT22M2PpLyZ0Vz0lVzHiv/86VbnnGKFGiCP69RUPB1k6zssrkxkbLoXuDMMWQ9BqgnetxVyCdCrZTaAXmfN1Ptkikb1b3OXh9sD+w+bKNq6KSLnVIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FsgdTNda; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=s2Hjna+7Gigv0uDBX5QjiFF/xA8CsPgyBJQvKbNatcs=; t=1712153641;
	x=1712585641; b=FsgdTNdap3z+fS9b1TDqtQ8umiugpRhQZ6NecB2dCrUzEfqtpfAkgtAQbTSnd
	Ns4SyFDNMdtTV/Kog1UpUz6DjBUQV4ahKqxpCjDftUQdfglfdbHy4Us9eUpYUpsOXAfheaNWkS3aP
	vNKbog4lim5PxQ5013JfA7iUuue+RMHXPySeY2oKFbHI8tDZ5XXBlTyNBlpK8ZvdxKq/lLccdQgyX
	9Sw0N6F619STqECYGBb+MSHW/hN7DQpU3qrv7M+s/Aaa6qJPSldaWMnUP/wZJDlc/qXwzXGaL75CU
	1zqB+JMt2fF+Q2QUkHvm07Nm1Xo6WBT3CQKwgZtRUU73A1F+Jg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rs1NC-0008IN-EQ; Wed, 03 Apr 2024 16:13:54 +0200
Message-ID: <3e53f18c-12aa-4bf8-b3f7-7945bbca6882@leemhuis.info>
Date: Wed, 3 Apr 2024 16:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: *-regressions.rst: unify quoting, add missing
 word
To: Karel Balej <balejk@matfyz.cz>, Jonathan Corbet <corbet@lwn.net>,
 regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
References: <20240328194342.11760-1-balejk@matfyz.cz>
 <20240328194342.11760-2-balejk@matfyz.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240328194342.11760-2-balejk@matfyz.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712153641;1673022d;
X-HE-SMSGID: 1rs1NC-0008IN-EQ

On 28.03.24 20:29, Karel Balej wrote:
> Quoting of the '"no regressions" rule' expression differs between
> occurrences, sometimes being presented as '"no regressions rule"'. Unify
> the quoting using the first form which seems semantically correct or is
> at least used dominantly, albeit marginally.
> 
> One of the occurrences is obviously missing the 'rule' part -- add it.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

Thx for this:

Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>

Ciao, Thorsten


> ---
>  Documentation/admin-guide/reporting-regressions.rst | 10 +++++-----
>  Documentation/process/handling-regressions.rst      |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-regressions.rst b/Documentation/admin-guide/reporting-regressions.rst
> index 76b246ecf21b..946518355a2c 100644
> --- a/Documentation/admin-guide/reporting-regressions.rst
> +++ b/Documentation/admin-guide/reporting-regressions.rst
> @@ -42,12 +42,12 @@ The important basics
>  --------------------
>  
>  
> -What is a "regression" and what is the "no regressions rule"?
> +What is a "regression" and what is the "no regressions" rule?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  It's a regression if some application or practical use case running fine with
>  one Linux kernel works worse or not at all with a newer version compiled using a
> -similar configuration. The "no regressions rule" forbids this to take place; if
> +similar configuration. The "no regressions" rule forbids this to take place; if
>  it happens by accident, developers that caused it are expected to quickly fix
>  the issue.
>  
> @@ -173,7 +173,7 @@ Additional details about regressions
>  ------------------------------------
>  
>  
> -What is the goal of the "no regressions rule"?
> +What is the goal of the "no regressions" rule?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Users should feel safe when updating kernel versions and not have to worry
> @@ -199,8 +199,8 @@ Exceptions to this rule are extremely rare; in the past developers almost always
>  turned out to be wrong when they assumed a particular situation was warranting
>  an exception.
>  
> -Who ensures the "no regressions" is actually followed?
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Who ensures the "no regressions" rule is actually followed?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The subsystem maintainers should take care of that, which are watched and
>  supported by the tree maintainers -- e.g. Linus Torvalds for mainline and
> diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
> index ce6753a674f3..49ba1410cfce 100644
> --- a/Documentation/process/handling-regressions.rst
> +++ b/Documentation/process/handling-regressions.rst
> @@ -284,7 +284,7 @@ What else is there to known about regressions?
>  Check out Documentation/admin-guide/reporting-regressions.rst, it covers a lot
>  of other aspects you want might want to be aware of:
>  
> - * the purpose of the "no regressions rule"
> + * the purpose of the "no regressions" rule
>  
>   * what issues actually qualify as regression
>  

