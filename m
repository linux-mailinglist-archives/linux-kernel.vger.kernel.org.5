Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1797E46AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjKGRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKGRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4139B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699377607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BzU3dDdSH7oEfLk2Y642FIj/xbly1n4FfWSInGGOWQ=;
        b=DLAti/uzSJnwSc41TilXjGtHN7fvGa7OF2T2g/CzUvRuZF/HPzz1xViS3RuO3j4ltopjbH
        /FiNOvyZaSWT4KhXTaCV32TRlO/lEgl90h/qcApCLM5Cs3U3FdPFy05zf5aW+sSVxlDOJb
        KalxLX0g4d1FRAko+qFHKvZSgcoFDoU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-_6x60YteOhGR1CazdrIy5g-1; Tue, 07 Nov 2023 12:20:06 -0500
X-MC-Unique: _6x60YteOhGR1CazdrIy5g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cdce61dcbso73158271cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377605; x=1699982405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BzU3dDdSH7oEfLk2Y642FIj/xbly1n4FfWSInGGOWQ=;
        b=p5cXzQYgsS25FDw+LzMh3RckY57fXDs8aso0gafI1rbYAnYEdboG+oXFsvdeoeGgy1
         aKyAo1GtrAro2DqyqSGv8Y4PkY/8viO24b0nQPgF/3ZxWIRAuwSGjumKhk9iq/PIZv1E
         H2biDoVfdEW4ee3poPJgisH2NS3E+hHCXh1DEAkshkhOSuDKGcWdoQ9gibykouwgWOfX
         8iviInxND+uL729Gjj8e0/WbYzYFSyzRaSs+8AUe2sF+8sbwXkHorE6YZRQz98DCgkoT
         Gz6AhdX9z4TSn1S8DMA0K9AFOU77YeC7IIqrnJnnXI/nIgt9x2LAvctjupI87Z40cRZU
         b5Yw==
X-Gm-Message-State: AOJu0YyBDeBaUiwsQqni0+G3qwIY3N5LBU+gUknN2hPUlRhCxyNd3dMf
        lW4iYMhZWjHWm3hbne7KKOGwoLXmYT/BG0tK/ZKDS5tohYyOiX+pL6UP2B05koHmHt7GHd8rCJw
        Uu/I7YcdOF9n4pJMIDpUGK19i
X-Received: by 2002:ac8:7f0a:0:b0:419:4c21:d706 with SMTP id f10-20020ac87f0a000000b004194c21d706mr41838470qtk.23.1699377605716;
        Tue, 07 Nov 2023 09:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmk5NphBaKNBHbqE52Hw8MNilCJ0v2xrcEj47TC7u8ivcNr/mb5kCdrz4mKADOyy+M6i9epw==
X-Received: by 2002:ac8:7f0a:0:b0:419:4c21:d706 with SMTP id f10-20020ac87f0a000000b004194c21d706mr41838445qtk.23.1699377605471;
        Tue, 07 Nov 2023 09:20:05 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p25-20020ac84619000000b0041cbb7139a9sm81308qtn.65.2023.11.07.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:20:05 -0800 (PST)
Date:   Tue, 7 Nov 2023 10:20:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] tpm: Support TPM2 sized buffers (TPM2B)
Message-ID: <nwbyc2al5msr7d2wqvqcfdm75osrestjncuhjgxxigm773a6k5@bc7hjv5srjxv>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-5-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-5-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:15:22AM +0300, Jarkko Sakkinen wrote:
> Add boolean parameters @alloc and @sized to tpm_buf_init():
> 
> * If @alloc is set to false, buf->data is assumed to be pre-feeded and
>   owned by the caller.
> * If @sized is set to true, the buffer represents a sized buffer
>   (TPM2B).
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-buf.c                | 32 ++++++++++++++++-------
>  drivers/char/tpm/tpm-sysfs.c              |  2 +-
>  drivers/char/tpm/tpm1-cmd.c               | 14 +++++-----
>  drivers/char/tpm/tpm2-cmd.c               | 22 ++++++++--------
>  drivers/char/tpm/tpm2-space.c             |  4 +--
>  drivers/char/tpm/tpm_vtpm_proxy.c         |  2 +-
>  include/linux/tpm.h                       |  3 ++-
>  security/keys/trusted-keys/trusted_tpm1.c |  4 +--
>  security/keys/trusted-keys/trusted_tpm2.c |  6 ++---
>  9 files changed, 51 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index fa9a4c51157a..f1d92d7e758d 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -7,22 +7,32 @@
>  #include <linux/tpm.h>
>  
>  /**
> - * tpm_buf_init() - Initialize from the heap
> + * tpm_buf_init() - Initialize a TPM buffer
>   * @buf:	A @tpm_buf
> + * @sized:	Represent a sized buffer (TPM2B)
> + * @alloc:	Allocate from the heap
>   *
>   * Initialize all structure fields to zero, allocate a page from the heap, and

Depending on what the decision ends up being on the bools, flags,
separate functions, or wrappers possibly an "if needed" should be
tacked on to the end of "allocate a page from the heap" here.


Flags would be better when coming across calls to the routine in the
code than the bools, but I think switching to wrappers around
a __tpm_buf_init for the different types would be good.


>   * zero the bytes that the buffer headers will consume.
>   *

