Return-Path: <linux-kernel+bounces-286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0237813EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC561C22089
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D8650;
	Fri, 15 Dec 2023 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HyzXi8PA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24920F7;
	Fri, 15 Dec 2023 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JFWfhbeTwDASZ337P19lefmMmN0AmzjVJlFATdWyObU=; b=HyzXi8PAmRO/+DNsjoC+lMtqvO
	t6IjeWDC1uIlZiahXutT4wahuT599cofu+3DjUOHEYAeh4I+LAJX0pB5i+617GTXO/JnhytUibKFI
	jFLQWgSXU+sEgUl4koCW8Ob3Yne36UmElcfypDwQ5JGjrHKosvrs+7ku6SllMPiwIofi+cHxzFrQa
	EzTXADwZVNUmHpoCjdTubcu7F0cCJ86eJFV0n9LgyN59kZ1I4KlhSsmkHzyjLK1Ok0hkfXIWcYinV
	E4k88qMn0m/awPz96EV+DbMoPNzFQoL3t97Vxr8uw6DBSAhwyqMBjDQxBt/r7BkveUKZsdsoR6xIe
	/v/IrbHg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDw0k-001dLv-23;
	Fri, 15 Dec 2023 00:25:02 +0000
Message-ID: <a65e9a7a-b5f1-4397-a953-cafb79a10fba@infradead.org>
Date: Thu, 14 Dec 2023 16:25:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: conf.py: Ignore __counted_by attribute
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231215001347.work.151-kees@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215001347.work.151-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/23 16:13, Kees Cook wrote:
> It seems that Sphinx is confused by the __counted_by attribute on struct
> members. Add it to the list of known attributes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150614.kOx8xUkr-lkp@intel.com/
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/conf.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index d4fdf6a3875a..5898c74b96fb 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -106,6 +106,7 @@ if major >= 3:
>              "__weak",
>              "noinline",
>              "__fix_address",
> +            "__counted_by",
>  
>              # include/linux/memblock.h:
>              "__init_memblock",

If Sphinx needs to know about that, then fine. OTOH, for scripts/kernel-doc,
a similar change could have been made to dump_struct(), along with these
others:

	# strip attributes
	$members =~ s/\s*$attribute/ /gi;
	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
	$members =~ s/\s*__packed\s*/ /gos;
	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
	$members =~ s/\s*____cacheline_aligned/ /gos;


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

