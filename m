Return-Path: <linux-kernel+bounces-69384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606785884B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57A928C4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBB148304;
	Fri, 16 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUFbtcGA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F951420B8;
	Fri, 16 Feb 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120817; cv=none; b=jg7mfvUzp4Acx1CEG6ZelhanXwep0cJFElDAoy+XJeY9ntIlIV7jSbxQyeXjEMTZGc6KgbC9aVRHgctU31LZZqXlhbvqfszJlOo7mGLhUK/wGlIfKxAL5mEZ9uIknrnc1HkEV8e0V1LNNq6AOPmOen6WXvYG5c1qmu1zI5H/WFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120817; c=relaxed/simple;
	bh=s1PztsoaAS6bKzE1vI/kpR473yyf1hFs5q2agrpurKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef8NCcfN9fbg8XkiSkDyzm4+McQpVaqOSToWNGu11+MNHS0LlcYdR7jh/55JZ5n/uGNzzjkhwd0VcLV0r5yhcivLl6CTVxS5N1XVPey/gJrqGKo3rjuUd/bnFHqruSYJvq5AA471PCuCCOrj/WDgTCC5iuSphbAFi0WZnJjnzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UUFbtcGA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IbOOvyf/VtBQOm/QRF/nFNwrg7I56H1FVAmWCAbZCNs=; b=UUFbtcGAsv+Y1MpwPwG2BZfN98
	bSSzq+3uVyfXTDozqup1yhsIYazbFi5EPD5d4DgYA0phIcoCO2gLGy7cPIkdhhQTl8FDFtN1/+aVG
	kKq0Q/7ImdK2kTCYa6iq9fdP3ONMRbOg/odsfe0bXU1AhIG/LkbVAakwX//Tc7DteLzhjAabnAvCt
	O39ZdtUo8mW245V/6n2eRYUTYKkcEmA6VD5LAMLGmKgJGiAIRlyRe6pD/e8cTLdbOBXM2su1GnfdN
	qVffC1ocBtUi50Dc2vbB8mpgSeefOeyT0uAZoh1lR0Q5NlYpgtuy9TNEJtZGHj9I4+0rlBTCmb3tF
	OmZIPXyA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb6Fi-00000003rsI-1uaB;
	Fri, 16 Feb 2024 22:00:14 +0000
Message-ID: <e53c52fb-c413-4192-9e41-53ace873839e@infradead.org>
Date: Fri, 16 Feb 2024 14:00:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Writing the first patch correcting the spelling mistake.
Content-Language: en-US
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>, skhan@linuxfoundation.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240216194126.13336-1-pvkumar5749404@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240216194126.13336-1-pvkumar5749404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/16/24 11:41, Prabhav Kumar Vaish wrote:
> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>  Documentation/bpf/verifier.rst               | 10 +++++-----
>  Documentation/process/submitting-patches.rst | 12 ++++++------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 66029999b587..34a68836aa60 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -5,7 +5,7 @@ Submitting patches: the essential guide to getting your code into the kernel
>  
>  For a person or company who wishes to submit a change to the Linux
>  kernel, the process can sometimes be daunting if you're not familiar
> -with "the system."  This text is a collection of suggestions which

The original (above) is correct punctuation.

> +with "the system". This text is a collection of suggestions which
>  can greatly increase the chances of your change being accepted.
>  

-- 
#Randy

