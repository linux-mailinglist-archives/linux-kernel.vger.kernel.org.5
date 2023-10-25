Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84C87D6D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjJYNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJYNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:32:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B011BC9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:31:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2d9ac9926so3687973b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698240703; x=1698845503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDeLJegtyrSMQs47LqN+x1DHWKzJbsn6ZNyTsWNzhD0=;
        b=poNHIo88GlChypeADbhU097d9YMRUhAnPbjgvnE0pGsjh/3EOZExa9cUNtqNkh74Re
         lzicw6lgi0zMEAVLLes+BairaaUKEL9pO5LM8OqVsOV6CyATcRCKfMHU3HvfKmyfMHjb
         ZDIJIOD6nvLC0HtFU/tYmiZT/+SCYqDOQVP4f078GMr5X94KUo7s9Di4tsQcMTTUAckc
         J6VfAAPDCJIvvzI0OzAaDhu3Hr8lkSjOJuQ1o3Cuvb7nlswXhpbFNkR9nWLQvV0ekQgs
         04dykbr7fGeESFkhwH7OupNg7jv9q2InCx5Gsei1iYyzxD03c4mNd8k/La7HczboVovX
         t0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240703; x=1698845503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDeLJegtyrSMQs47LqN+x1DHWKzJbsn6ZNyTsWNzhD0=;
        b=ilPw3k3t3a8pkkq49xjvW76afIu7hZ+pHpg/vr69D7oVIP9mON2LogsvqKeLaZi7Ox
         Ivi6ymycXZ83WzkgxfhOV7oMlMfDtFUFaOe07unAWMQy4q+cqKhZQ1CKj9M5UM53XnDh
         78lgqLZlQTp2wv7E+DdSgl3Bn/AMTAZB0pJEjKDkDscIHd8eomGqbf8fHgpnJ57/Pl4M
         SBR6yMTNQJEW/5q66qCIXRIxujo7/5mEsynna9Xl0dVraqIX/vfirWBIzy5vW/PeMz5A
         FqvQQI1UZhxFmRDHIcO7J0uJaH12Kg26YdSdRcXTXPNhweZi+ZbXY8vewb81rrSvT4Ip
         7s4g==
X-Gm-Message-State: AOJu0YwlZXDX8eg+De9sM7QLKUOEhbVqpcNUo0SasYTgcklMS02LctWU
        1BVFzx+deJIB/0u3uDomsSSYZeGvuUbwSfXLF1iTSYCGpT5HKAFX
X-Google-Smtp-Source: AGHT+IHvVVWmzAv/4OQ7DckVr1zNALKZ+0FxM3O1RwNGzG2CeTimbYZdVJ7078LCw5pcHLanhYVCEflo58qYF4oANWU=
X-Received: by 2002:a05:6808:aa3:b0:3ab:7f46:ecc5 with SMTP id
 r3-20020a0568080aa300b003ab7f46ecc5mr15434307oij.35.1698240703272; Wed, 25
 Oct 2023 06:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
In-Reply-To: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 25 Oct 2023 19:01:31 +0530
Message-ID: <CAFA6WYPKXFftMzqJ4GnXT-zqu21_Jzn8aKti_wU-pQ4KpEVNrA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared memory
To:     jeshwank <JESHWANTHKUMAR.NK@amd.com>
Cc:     thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jens.wiklander@linaro.org, jarkko.nikula@linux.intel.com,
        mario.limonciello@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeshwank,

On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> wrote:
>
> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>
> At present, the shared memory for TEE ring buffer, command buffer and
> data buffer is allocated using get_free_pages(). The driver shares the
> physical address of these buffers with PSP so that it can be mapped by
> the Trusted OS.
>
> In this patch series we have replaced get_free_pages() with
> dma_alloc_coherent() to allocate shared memory to cleanup the existing
> allocation method.

Thanks for putting this together but I can't find the reasoning behind
this change neither in this commit message and nor in the patch
descriptions. Care to explain why?

-Sumit

>
> Rijo Thomas (3):
>   crypto: ccp - Add function to allocate and free memory using DMA APIs
>   crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>   tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>
>  drivers/crypto/ccp/psp-dev.c        |   3 +
>  drivers/crypto/ccp/tee-dev.c        | 119 ++++++++++++++++++----------
>  drivers/crypto/ccp/tee-dev.h        |  11 +--
>  drivers/tee/amdtee/amdtee_private.h |  18 ++---
>  drivers/tee/amdtee/call.c           |  74 ++++++++---------
>  drivers/tee/amdtee/core.c           |  72 ++++++++++-------
>  drivers/tee/amdtee/shm_pool.c       |  21 ++---
>  include/linux/psp-tee.h             |  47 +++++++++++
>  8 files changed, 221 insertions(+), 144 deletions(-)
>
> --
> 2.25.1
>
