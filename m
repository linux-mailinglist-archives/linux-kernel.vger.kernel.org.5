Return-Path: <linux-kernel+bounces-10509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4581D53F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7280B220D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF9125A9;
	Sat, 23 Dec 2023 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aj0VebDr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1312E47;
	Sat, 23 Dec 2023 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CQQESp8gFfmcpFTEZcuFObTGZOcaKuZ6kDi9nty6UKk=; b=Aj0VebDrk8KINg0Lb3DQB1oWPe
	79C7rbLO1NpGez1/qG0MeL9s4UR60ffiZZeAUSKJzKLcXeFv1uoDx/ruLsnnXEfTHjPLohg0yoOjU
	9jvbrJGPjhPaYh2vkOKGXf7n/IFC3MvT1zvyzXXlFEzKS4+EBrL1lQkzuhEDzk1YfDJ/vwdRPwOn9
	+IWXBOtGqIySSJ6uAiZxNjhPsPkioxJsyoZJ7JxsurBpUHvNqqDo9E99bt7KRg9cDiF0n1nbJZ/O7
	lTBiEFeJ7sr0VFipDYnPkmFb+g0P365YyBb+r9NzVPjMf3Fs9F88yXQFmMRaTSIdsUVan/S0RuBUx
	GYSCLxYQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH5ke-008DSF-2M;
	Sat, 23 Dec 2023 17:25:28 +0000
Message-ID: <ddadc844-4f30-453d-87cc-1ecd67fd2f37@infradead.org>
Date: Sat, 23 Dec 2023 09:25:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: media: atomisp: pci: Fix spelling mistake in
 ia_css_acc_types.h
Content-Language: en-US
To: Dipendra Khadka <kdipendra88@gmail.com>, hdegoede@redhat.com,
 mchehab@kernel.org, sakari.ailus@linux.intel.com,
 gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223141157.95501-1-kdipendra88@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223141157.95501-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/23/23 06:11, Dipendra Khadka wrote:
> codespell reported spelling mistakes in
> ia_css_acc_types.h as below:
> 
> '''
> ia_css_acc_types.h:87: cummulative ==> cumulative
> ia_css_acc_types.h:411: descibes ==> describes
> '''
> 
> This patch fixes these spelling mistakes.
> Word "cummulative" is changed to "accumulation"
> and "descibes" to "describes".
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v3:
>  - Changed "cummulative" to "accumulation" as suggested by Randy.
> v2: https://lore.kernel.org/lkml/20231223051108.74711-1-kdipendra88@gmail.com/
>  - Previously only corrected spelling  mistake reported by checkpatch.pl.
>  - All spelling mistakes reported by codespell are fixed.
> v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/
> 
>  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> index d6e52b4971d6..f6838a8fc9d5 100644
> --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> @@ -84,7 +84,7 @@ struct ia_css_blob_info {
>  		memory_offsets;  /** offset wrt hdr in bytes */
>  	u32 prog_name_offset;  /** offset wrt hdr in bytes */
>  	u32 size;			/** Size of blob */
> -	u32 padding_size;	/** total cummulative of bytes added due to section alignment */
> +	u32 padding_size;	/** total accumulation of bytes added due to section alignment */
>  	u32 icache_source;	/** Position of icache in blob */
>  	u32 icache_size;	/** Size of icache section */
>  	u32 icache_padding;/** bytes added due to icache section alignment */
> @@ -408,7 +408,7 @@ struct ia_css_acc_sp {
>  };
>  
>  /* Acceleration firmware descriptor.
> -  * This descriptor descibes either SP code (stand-alone), or
> +  * This descriptor describes either SP code (stand-alone), or
>    * ISP code (a separate pipeline stage).
>    */
>  struct ia_css_acc_fw_hdr {

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

