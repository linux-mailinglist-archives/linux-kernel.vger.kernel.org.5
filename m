Return-Path: <linux-kernel+bounces-1303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16028814D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F47288C30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071223EA6C;
	Fri, 15 Dec 2023 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="m/GBrl5i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E43EA80;
	Fri, 15 Dec 2023 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3A20B46A;
	Fri, 15 Dec 2023 16:32:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3A20B46A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702657963; bh=KjM0uDHwoedhIhQVgnSasUQJXO8rGVyBZqDNKz1WErA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m/GBrl5i2R05TWh1mwjks7R8qBSB+XZhb7G4JkGOjRe8NAPT11IcuDBd2hib+SeMz
	 b6TvYlQiveUH5Tvr9Foikreg5HBivWZFkqf/o1hLwm8++z4RTfp0wUi/B2iHmI94f2
	 Hl0dCZClKvqk4UjgGVIdhoqzuIL8UipVttkBYN3YcU/PhpdnzbaA8eZd7dSzMUcKd/
	 YaQWV5hNL8vjkxvHKKBCpu8PhbVh1uFO04m1iu8zRqHgBCx8bspsQkCoW5xNv8gqun
	 Lwq+9IC9+Yzaaq3klVIR0BLyT5urKtxFux1EBomdKsonlWPXkmhLYM5f3NpGQUanxx
	 kr2p0nMECY2xw==
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <keescook@chromium.org>
Cc: Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Clarify missing struct member
 description
In-Reply-To: <20231215001513.work.563-kees@kernel.org>
References: <20231215001513.work.563-kees@kernel.org>
Date: Fri, 15 Dec 2023 09:32:42 -0700
Message-ID: <87sf43pgt1.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> The output "or member" should be more specific, instead saying "struct
> member".
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 39e730ee1fef..41f838042364 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1613,7 +1613,7 @@ sub push_parameter($$$$$) {
>  		$parameterdescs{$param} = $undescribed;
>  
>  	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
> -			emit_warning("${file}:$.", "Function parameter or member '$param' not described in '$declaration_name'\n");
> +			emit_warning("${file}:$.", "Function parameter or struct member '$param' not described in '$declaration_name'\n");
>  		}

Applied, thanks.

jon

