Return-Path: <linux-kernel+bounces-120179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1088D3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B42A2C773F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111801CD3B;
	Wed, 27 Mar 2024 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNzvh2g5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43020323;
	Wed, 27 Mar 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503392; cv=none; b=C5cp8VO+fCLXMGqkheHTBDWX84BXjOhvdVQW8cTp1G0colh40QMKzxpiHczBf6TUIr+8l2rYYdlEaUMwKNbMMRCQW/7LaqG89jYha2zo470aAi39bdETAhuiRA3PTVV+lpnzAPHLK6LowmmK55rY2wHiXLusRevWZK2h5IhMzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503392; c=relaxed/simple;
	bh=G5CnkT5QVDuAxX6bjBrkXtiKlaXMp79BcaVPmAi2WQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8lDb4FaxxX6AsL7dn89nKOJgWZM678nFfsL0aNdEC7gnvJISZadcVq4RQbyU9VPmlUOrCTYK0QR84p1oTAPEYKQ5sCy2gABEAUyh+wrwLZMf/pmPtNespn3e3y/Pm6kJ3EcctGq/x/HMR0S1vZXqxDxw3dacvB4qe6doRIdnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNzvh2g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289CAC433C7;
	Wed, 27 Mar 2024 01:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711503391;
	bh=G5CnkT5QVDuAxX6bjBrkXtiKlaXMp79BcaVPmAi2WQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PNzvh2g5NC3x8OmCPQmNFGAXaVUpQVkEa8BeyO11NScvIdjLTpTGry+Ww3O/SeT7/
	 5Ym80jU058K3n7+BoSOm0FCC7j3dtwpF63ff0X4xsojFcVNPa82YpDLNFlXOvEAOTX
	 zpSZLIIyFpGkLleRylvT1mc6AnXj/UmG1b6OiyT2Mz9ACnlAhSwCLUY1aVNuhfbUQp
	 3t4TgXcgTsdi8AuGf3p+mXGJ3ryHRd/qdIMUrCJDX7bqg40OsYLuQCADxmCVP/Qo3l
	 Uqpc/E26crc48fh4sequ3zRbAZIqvVAcuG8zc9CWwN5kpAsQG3lkYniq9KHHsPTYEl
	 b/1AUvahum7lg==
Message-ID: <d7fd5998-8813-4f29-a8d2-b82adbdec11c@kernel.org>
Date: Wed, 27 Mar 2024 10:36:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] sata: sx4: fix pdc20621_get_from_dimm() on 64-bit
To: Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Nathan Chancellor
 <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145348.3318887-1-arnd@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240326145348.3318887-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 23:53, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about a memcpy() with overlapping pointers because of an
> incorrect size calculation:
> 
> In file included from include/linux/string.h:369,
>                  from drivers/ata/sata_sx4.c:66:
> In function 'memcpy_fromio',
>     inlined from 'pdc20621_get_from_dimm.constprop' at drivers/ata/sata_sx4.c:962:2:
> include/linux/fortify-string.h:97:33: error: '__builtin_memcpy' accessing 4294934464 bytes at offsets 0 and [16, 16400] overlaps 6442385281 bytes at offset -2147450817 [-Werror=restrict]
>    97 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:620:9: note: in expansion of macro '__underlying_memcpy'
>   620 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:665:26: note: in expansion of macro '__fortify_memcpy_chk'
>   665 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> include/asm-generic/io.h:1184:9: note: in expansion of macro 'memcpy'
>  1184 |         memcpy(buffer, __io_virt(addr), size);
>       |         ^~~~~~
> 
> The problem here is the overflow of an unsigned 32-bit number to a
> negative that gets converted into a signed 'long', keeping a large
> positive number.
> 
> Replace the complex calculation with a more readable min() variant
> that avoids the warning.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

That is old :)

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me. I can take the patch through libata tree, unless you prefer
taking the whole series ?

In case it is the latter:

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


