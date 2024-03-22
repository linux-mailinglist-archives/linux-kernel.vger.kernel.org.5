Return-Path: <linux-kernel+bounces-111592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFEB886E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC621F23394
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E547A6A;
	Fri, 22 Mar 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJYL418B"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8E46453;
	Fri, 22 Mar 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116984; cv=none; b=EbAeLogffZ2k0BFL7r7E4nu+bfNo7zu+6numwkO/PtiGY31tdLUiQM9B0xdP+LPQlIEqzEqoLmJoQAS+zW5cQObl1sIx6xmx/KPaVEdGsu0m4fFtXjIoDsQlX99OUtz5m2Ash/P+vNjNHXpbFve+eOMeaU9wDBllCDK1G4WTRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116984; c=relaxed/simple;
	bh=phfJNFUwcoMsIHQsKhH8XlWFMITiLSgKhBPTTxTE03k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFIXMnwsOVY+trgEWJVIUw9PEQhU+FS7ughWYRHmduy9IyKnx5fni1Dmy8pY0UiUMIcscarnpYLgHCOUCCd/oV2jU32gPcgMfNm6UwzunWS+fl6EqCqTkK/7YgJzeJGkvezQbcR9mlGsmpj0HxpNZ2GOhX4chvuxiz03btGLtfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJYL418B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0189323b4so14464675ad.1;
        Fri, 22 Mar 2024 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116982; x=1711721782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2KrFVSkasLEwSaFBHHLTFFybIGgLI9ihUKme+W+V2o=;
        b=TJYL418BjnTjnsnzdHaGZUHaVMK2KBSkgT+sJa0Uwqiv/hlEMPMM28OYKuqcpUeYc+
         uQheqVn4PP1G5x18z0fDkX/T4ACJN4lLwrQerUDVvt9VeIXdyLc3KholcyF6npwY94oZ
         gefEbJ8vxYF1dwdGvlUw+2J73oYwioKRFbb8wHkm98nAvdYPspCkG2G33dJQ522ovW51
         Cd8CMiY05/21BCbDdwe5i0pJVRf8zSCVfrMzT6ePZJDbRg6rI6vRR9NPI//1d+Ma3bm+
         9M9pQqTJoapwFKt6ThfFyVlTgoBmxacUk28gu9T+BNCWn7E1isRU0rl7jPHm2fKCWnJ5
         s/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116982; x=1711721782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2KrFVSkasLEwSaFBHHLTFFybIGgLI9ihUKme+W+V2o=;
        b=iFB/l4qvD6k5e4ZQL3bU5apDWleL5na8I1caN72b4vOpwXuBbRtxFmOw4ATpe3DDc4
         syyJHLr6T20Cf0Gujpqp+Kw7hLWfxS5n557HGIpBGdljE+89X0kn8HcLcoo73tscaLQ/
         +3H0biZLvMnmIv53LYJa43Tswpt7hvLpx9qRbj9c6JP/x2WqNFOamzXf04Wx5nZEZSre
         rxt+KT6IL7mGHfvlaTnuZf0d5t332L/xUo9srZkgTgT44fLmMoi78P8Z481QuESN7hwb
         +uJ6diWzs7q5fGgVyLBEWzlQo4Imrg2HFtLiafYVHWn4etZYP8TxIqHppHAMOUaoo3Z/
         FNGg==
X-Forwarded-Encrypted: i=1; AJvYcCXvimAJ6IZIK/kLsviESgr3YTpriez0jFZmO3oNSdf+8yROaGVD7lck3t4HbVJqKlh7aBS9SHwVJnkyUmC7btosT5EyxaVmI6dUB0xpY8ijAY8AIMwCV8Tf49smrrCMEQ1CFYhLSkFhtT1oy9zL2s+rt68EpfXMCKbkJdilBI1gHA==
X-Gm-Message-State: AOJu0YzSM1Q0cLwp8gAkLoXn31YxqaVSG1+uD3tIu5tHCgMh74x7eKA/
	zPsBgalPq9/jbolglixrvoOadSv+mVjjo1LmIBJoxIUyPRC6qQsxDiW41j/O
X-Google-Smtp-Source: AGHT+IGHKP6GHfaK0CJSsC1/8ul21i9Rgu7jfCypgVaXamxumA/1/NQ5qG+dab1GP9lDvCigP7RxPg==
X-Received: by 2002:a17:903:11c4:b0:1dd:a3d6:3af8 with SMTP id q4-20020a17090311c400b001dda3d63af8mr3422258plh.31.1711116981683;
        Fri, 22 Mar 2024 07:16:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001dde004b31bsm1946248plh.166.2024.03.22.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:16:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 07:16:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 1/4] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <4f606e50-865c-46f2-b89e-6c1dfe02f527@roeck-us.net>
References: <20240201233400.3394996-2-cleech@redhat.com>
 <20240205200137.138302-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205200137.138302-1-cleech@redhat.com>

On Mon, Feb 05, 2024 at 12:01:37PM -0800, Chris Leech wrote:
> Add a UIO memtype specifically for sharing dma_alloc_coherent
> memory with userspace, backed by dma_mmap_coherent.
> 
> This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
> are a few other uio drivers which map dma_alloc_coherent memory and will
> be converted to use dma_mmap_coherent as well.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---

Building i386:allyesconfig ... failed
--------------
Error log:
drivers/uio/uio.c: In function 'uio_mmap_dma_coherent':
drivers/uio/uio.c:795:16: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  795 |         addr = (void *)mem->addr;
      |                ^
cc1: all warnings being treated as errors
make[5]: [scripts/Makefile.build:244: drivers/uio/uio.o] Error 1 (ignored)
drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
drivers/uio/uio_dmem_genirq.c:63:39: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   63 |                 uiomem->addr = addr ? (phys_addr_t) addr : DMEM_MAP_ERROR;
      |                                       ^
drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
drivers/uio/uio_dmem_genirq.c:92:43: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   92 |                                           (void *) uiomem->addr,
      |                                           ^
cc1: all warnings being treated as errors
make[5]: [scripts/Makefile.build:244: drivers/uio/uio_dmem_genirq.o] Error 1 (ignored)
drivers/uio/uio_pruss.c: In function 'pruss_probe':
drivers/uio/uio_pruss.c:194:34: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  194 |                 p->mem[2].addr = (phys_addr_t) gdev->ddr_vaddr;
      |                                  ^
cc1: all warnings being treated as errors

Caused by this patch and "uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion" as well
as "uio_pruss: UIO_MEM_DMA_COHERENT conversion".

I'd suggest to make uio dependent on 64 bit if 32 bit is no longer supported
to prevent waste of test builds resources.

Guenter

