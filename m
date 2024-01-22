Return-Path: <linux-kernel+bounces-33588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B7836BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA5285EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5965C5EF;
	Mon, 22 Jan 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="tcY4AH31"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DF45C1D;
	Mon, 22 Jan 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937224; cv=none; b=dgnI1KXLKI+78ZxlkUQTRtkEg/rbUf2FPP+rdQ0LjxXb3/JZbNT3RJ29+tmHsSoPg8qSCFne4alIEPpCFbbcR7rf337ifbIPSLT+4LhphUZlGwwnZ1gUYvEF1uqmxqY6cBJPIWKpQKaf+RSh4h6CQ7hIxkG4kH4LgW1EqBLulrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937224; c=relaxed/simple;
	bh=so6w8jo3TAjooF3TquLIvs/Q6XZUZG2iMmO/hGMBKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq9MR8OJLId/udDzf/HuGQxTq1BOpSjLIc1lh30VGVn7aXaLqyPv3o7UdiYrN6T8zB1+79mQ05CGn2iuR+Mnl71je3Un+lt9+hCHcEFSgUGqr32VzGRB+7p/ltNLsycrWEE8xBYH1KZwJg9TZBukpN3qVHiQCBXcj/W/CP26cwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=tcY4AH31; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1705936857; bh=so6w8jo3TAjooF3TquLIvs/Q6XZUZG2iMmO/hGMBKUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcY4AH31dZ4FSmLf9HHI6c+fAFLcKFbMqSUMF4ER9ItFtCVn3k+Je7AMIu1ogUkFR
	 YzKaaRWu5JhgFtUFCY0VagtU4yBZ2L6Yz0rZjC19zs2al9IeYIoVUDVYzJl8GROWAN
	 PNdqZMu9t+0h1k+szjvUg3TOEGEUpEU4lfrZfuhE=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 22 Jan 2024 16:20:57 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id DD5F38029A;
	Mon, 22 Jan 2024 16:20:56 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id D185A180D58; Mon, 22 Jan 2024 16:20:56 +0100 (CET)
Date: Mon, 22 Jan 2024 16:20:56 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: fix W= flags in the help message
Message-ID: <Za6H2NfODGU419hX@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
References: <20240120083255.2757978-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240120083255.2757978-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1705936857-38F2AF3F-4CD55A5D/0/0
X-purgate-type: clean
X-purgate-size: 952
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Sat, Jan 20, 2024 at 05:32:55PM +0900, Masahiro Yamada wrote:
> W=c and W=e are supported.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index f288eb2dc8fd..8c6a935c62e6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1653,7 +1653,7 @@ help:
>  	@echo  '                       (sparse by default)'
>  	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
>  	@echo  '  make RECORDMCOUNT_WARN=1 [targets] Warn about ignored mcount sections'
> -	@echo  '  make W=n   [targets] Enable extra build checks, n=1,2,3 where'
> +	@echo  '  make W=n   [targets] Enable extra build checks, n=1,2,3,c,e where'

In the top of scripts/Makefile.extrawarn we have kind of a duplication
of this description.  Might you want to update that too?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

