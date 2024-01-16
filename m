Return-Path: <linux-kernel+bounces-28350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F882FD27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD111F29A52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDD249F0;
	Tue, 16 Jan 2024 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX0kyKBr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C422030B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444062; cv=none; b=aUDYNXWFW3yMm0dtpcCY4e1UCV/HO5eABAuZpLEZ2DV/phA3Sl4SAA+HC4jgqMFdaI0KzDfQDJDSCO1whs8skSLAmfVs46wNNNhxmd1jmuDLFXnmbfVZBcu0iYqY6TTIvgMU2IjVluAVeoTh86K/pDOz21M2UwZtc2lHgs1ex3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444062; c=relaxed/simple;
	bh=zI0jbX+WO4M4NfPXietR8OsFyCiuEocjZhcffxu17a0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ru7V6GdpKOOWUhQg9IAt2S3Lvnp4IfmpUGwxCjS5cyOB7VwGIKXLlxtFQGX9Eyho5mQ83bWnndgAkWMxx7Poenb2UDL8Yi2vX5uYNkm2qT80hAyuuf8P8E2c09KadYWQ+pPljLkk++rgwrpHL+L4MP3SBrsAtLTul8BpX0jzai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX0kyKBr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3376ead25e1so8194377f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705444059; x=1706048859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euua8TbFvT7bIKUoXXmmlR4cAfJPgJdRjAqKppqIecE=;
        b=CX0kyKBrhQLQHd5Z0GsSjSJGfOHZFbjuQGmrSEs4P1GukYr14Xz7JwRFAUBPuui26I
         A1ciPzWPUqpw9wowFWNjFNcuxXXmrFMLCRs3ERvWbbF8Htdh9Dm7Z0277KfP23P5Hli0
         Zcj9PDNS0jV5fXK80XaCaMpubRQ14YSU5QNEKvGcAr+vmoQmWopNc97tqrW74aZJmPmr
         r8RBvPFcnZ0ju2pqCCofaBX7ReAuoIU8Rvra0MRw1pKN+Lj18SJnfoDO4PVWFoATS1qT
         taUoQ2nXFmOhEqjBwoEEB1EW9EIUEAiTFXsUZp/czp2Tobm6GpL066+Qh/ppGo9hUJtq
         SaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705444059; x=1706048859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euua8TbFvT7bIKUoXXmmlR4cAfJPgJdRjAqKppqIecE=;
        b=tEzqqQbo4A7qHOOmftYhRnTGCRQTwDWc/0c6k7k4WqkTB7Ppuy5qziGunk6vlsKTxp
         tDxVIt8mE4LcnW8MSyOmTH5MoaWcj43d9xOcO6idHkjqdQ3uz/HLrXjZkTYaAYw0wrBF
         RGBfk1Fu5a3fxgF884Wy7XAEtKOqpdh0lVikfsioXu676QAH8F/X2uKsn/hOCNK+U3d7
         fEyRWmcPB2pfG0wZaf2O2trWIRfFdzpCcMeJYxiEb8qi63hcU8+HOLOzA7h/petE1+cH
         7+ma4ShRXEYkYrOH9n/Oxcx+ywkKw7weMIYAX/xh2PgwY7e2mdd/iqFr5wmYN2cHW/i2
         FmUQ==
X-Gm-Message-State: AOJu0YzTbE2XP6xXssyJ5yyVFQobhNpMFmXYjwwZpvWnMAruGy/+CYhD
	17ncIhH7UFzZz3AjO/3bdbU=
X-Google-Smtp-Source: AGHT+IHLupeptjw4yqd6axr42EBhj0iaxFvFsIK4145/Se22Wb3HqJ2VWqhCjtlJeVESOfCuFf1t4w==
X-Received: by 2002:adf:e94a:0:b0:336:6837:efd0 with SMTP id m10-20020adfe94a000000b003366837efd0mr4073622wrn.142.1705444058565;
        Tue, 16 Jan 2024 14:27:38 -0800 (PST)
Received: from localhost (host86-162-136-255.range86-162.btcentralplus.com. [86.162.136.255])
        by smtp.gmail.com with ESMTPSA id i2-20020adff302000000b0033788e357e1sm145538wro.108.2024.01.16.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:27:37 -0800 (PST)
Date: Tue, 16 Jan 2024 22:25:23 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix a warning in the
 crash_save_vmcoreinfo_init()
Message-ID: <2fcf0acd-f451-4e8d-a769-81e1cee16ade@lucifer.local>
References: <20240111192329.449189-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111192329.449189-1-urezki@gmail.com>

On Thu, Jan 11, 2024 at 08:23:29PM +0100, Uladzislau Rezki (Sony) wrote:
> The vmcoreinfo_append_str() function expects "long unsigned int"
> type as a second argument(0x%lx) to print a beginning of vmalloc
> start address which is defined as a VMALLOC_START macro.
>
> For some architectures it can be considered as "int" type, for
> example m68 generates a compile warning message. To fix it cast
> a second argument to "unsigned long".

Ugh dear Lord. Insert grumble about maintenance costs surrounding hobbyist
architectures. I agree with Christoph the correct fix is within m68 (and
any others with inconsistent typing).

But for now we do need to work around this.

>
> Fixes: 9bdb180b2d ("mm/vmalloc: remove vmap_area_list")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401120218.y469Puyf-lkp@intel.com/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b60de490c1fc..49b31e59d3cc 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -748,7 +748,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
>  #endif
>  	VMCOREINFO_SYMBOL(_stext);
> -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", (unsigned long) VMALLOC_START);
>
>  #ifndef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(mem_map);
> --
> 2.39.2
>

We definitely need to get this sorted for the bots, though moving forward
we should patch this problem correctly in the right arch. However for the
purposes of the fix feel free to add:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

