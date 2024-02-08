Return-Path: <linux-kernel+bounces-58731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5484EAC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE24B2E105
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838124F202;
	Thu,  8 Feb 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkMetZTO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5CD3D68;
	Thu,  8 Feb 2024 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428347; cv=none; b=RwrsQQ8732KuglKm6Cxv8Ns4s3aX0gU5DOAGB6Z6XKr+omxcnog8snFYYvuVYLkRr5zIDsFtt/+cGexN9pHuU7XjiTVHJ2gRNgdiz9OsdVHyTALuzBGWk5yz5D4xjU78wZNc1ZzkoK8SvIGYPta8eBNXoBff44QL5tPN7/toGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428347; c=relaxed/simple;
	bh=N4ZSH8YQHF3QwjMf6bNmvtPYxG+3ZsvjUv89YpXUFkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB3s+YRyE9oGwm5Kr8LqACz9Jm6h4U1YKEtAqlR55s+PhuHrY2frkpBoAj/nvmEhhkad0ut4nm0AMLE3NkXG/ED1aW+MWAMLjC/isVnLhou6eMfH8sWFCEz6oJsX67JyDYgQqTzwrX1XlemBjDTRSfofU/Iw3a9NPyV6Z98iHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkMetZTO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9KnTk0Elz+30SMcvKWJqnKHQjJlrhF1+VavfjqyrA/s=; b=qkMetZTOnKqbu2PjT3mwt5sY+P
	taPCFaW7CCGvL/aDMvDRuuYHwuDDMoz/yg3citqCzdmDIpZw1j80LuodAzWPvNCGZiVenU/o1uGKB
	+p14xCLGF1LNsysEdH7CVRIix1u8XSq8UaMPfdxAJ/n4M+aCl2pMw350JMrHfFHCzGAlPa/9iDv66
	7QafAEtX0EQHAsxmMz05H3bevUSRhK0AvWiCPqKk1L466iH5B9RqEzeUKrvulIC+m6B+QaKhe5BzM
	DduAXQeg1gXa1lDNVPVZYQUE1r3Dh8eOH1HgTqe3VtPnC/ko96WmSR6eyt6nOHOiWx0Z9xz7v60Bu
	AyVrgXiw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYC6o-0000000F2ZZ-22E4;
	Thu, 08 Feb 2024 21:39:02 +0000
Message-ID: <e447348b-97ae-4833-ae83-2d0c2ca78ad4@infradead.org>
Date: Thu, 8 Feb 2024 13:38:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dev-tools: checkpatch.rst: Fix grammar
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208152039.65293-1-thorsten.blum@toblux.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240208152039.65293-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/24 07:20, Thorsten Blum wrote:
> - s/exists/exist/
> - s/maybe/may be/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/dev-tools/checkpatch.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index c3389c6f3838..127968995847 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -168,7 +168,7 @@ Available options:
>  
>   - --fix
>  
> -   This is an EXPERIMENTAL feature.  If correctable errors exists, a file
> +   This is an EXPERIMENTAL feature.  If correctable errors exist, a file
>     <inputfile>.EXPERIMENTAL-checkpatch-fixes is created which has the
>     automatically fixable errors corrected.
>  
> @@ -181,7 +181,7 @@ Available options:
>  
>   - --ignore-perl-version
>  
> -   Override checking of perl version.  Runtime errors maybe encountered after
> +   Override checking of perl version.  Runtime errors may be encountered after
>     enabling this flag if the perl version does not meet the minimum specified.
>  
>   - --codespell

-- 
#Randy

