Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769277AF08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 02:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHNAkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjHNAjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 20:39:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85951E6D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 17:39:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a76d882052so3126884b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691973591; x=1692578391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYIXa/4ylUUpYx/1rlc0LXopMiAhyWvXhlK8g4TW8nY=;
        b=X2XC+9IWo5/dkEl68tmG13tVr0Wecv/qo2jcAbmXEEOrtuBHVB4W5e39AcdFBhg3a0
         JDBP8+FOA6krReSgLZHtDQ6K4e1EfgDZm8GpkeLBt1md4A5hNhpt1s1pzlmzd0lVR2gE
         f1k3AhUdXw9u99yIQ7vuxSRKAnN5Y4sjgwdo7bc6FHG9QjnPeajFVDLzCID2nBEOS1fJ
         EY61PSzp4h7mKZP6nVMj2XUcrIykve9uAHsUpNdG1CXLwL1gFYVyk7o+EbOzPesjzmtP
         wfazPy2RyibXU4E65V5rRFzLH5qjSwfcX9ptgZRvwnwfBykKM3Rg/IriffLbr/RsgtrJ
         YeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691973591; x=1692578391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYIXa/4ylUUpYx/1rlc0LXopMiAhyWvXhlK8g4TW8nY=;
        b=bfOt4CtrszKEIc2jPNb+6wznmyNAOgCFBAa3cbVnvEIC/k3fyKyeY2a4WI8/EcIDD/
         ukeINV2lo9IsDmKFI7M2OCaXnpo6lNHz2MJUJix7h/YHIkkVMXrJNMrBDa++9ZDIGTeh
         RuQJQlYLyJsWx4y9Ff78mgy6gEZX8ABFCxNeIIOrx1/kURJmdHhByOAL48Dk1PXjNQhC
         /ez8kVaGnREiHNg3ormIDVbv4FkZGyUVnyrhs5TNSKLXuF9nIrm2DIpcOREKUq5K8yYX
         8hmbRDktX1yflujwfQwsBlEOVg4E8cTC5kcmnYYfBb9+8XI6ou6iV/JBYRWxReM0NSuG
         1jGA==
X-Gm-Message-State: AOJu0YzeZJpNmngZAcwtx5fpZNZJsr8V7x3Df3hVi5yPR+X5DDSDojNR
        G2mXlnZeeSUcbircyrHmdepdsyO1jxk=
X-Google-Smtp-Source: AGHT+IFRnD8Da3749X9jIq1Tuc7Cfkbm6bsEjNGKM9E5qF3GR5XikrLoS8aY8LodhL1RibPPWIcGRA==
X-Received: by 2002:a54:4781:0:b0:3a7:458e:3df4 with SMTP id o1-20020a544781000000b003a7458e3df4mr6953651oic.56.1691973590711;
        Sun, 13 Aug 2023 17:39:50 -0700 (PDT)
Received: from localhost (rrcs-108-176-112-203.nys.biz.rr.com. [108.176.112.203])
        by smtp.gmail.com with ESMTPSA id j10-20020a0cf50a000000b006300ff90e71sm2973529qvm.122.2023.08.13.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 17:39:50 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:39:47 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Message-ID: <ZNl30xC1VFPWl9Ml@yury-ThinkPad>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-3-yury.norov@gmail.com>
 <25deb65e-a8f3-957b-9e4f-759604111d50@rasmusvillemoes.dk>
 <ZNYv4pt4HBUBZA60@yury-ThinkPad>
 <d81ee557-74b1-6ed9-e806-d8e0865e40f0@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81ee557-74b1-6ed9-e806-d8e0865e40f0@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:31:01PM +0200, Rasmus Villemoes wrote:
> On 11/08/2023 14.56, Yury Norov wrote:
> > On Fri, Aug 11, 2023 at 08:21:33AM +0200, Rasmus Villemoes wrote:
> >> On 11/08/2023 02.57, Yury Norov wrote:
> >>> _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.
> >>>
> >>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >>> ---
> >>>  lib/bitmap.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/lib/bitmap.c b/lib/bitmap.c
> >>> index 3a589016f5e0..c9afe704fe4b 100644
> >>> --- a/lib/bitmap.c
> >>> +++ b/lib/bitmap.c
> >>> @@ -1352,9 +1352,12 @@ EXPORT_SYMBOL(bitmap_release_region);
> >>>   */
> >>>  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
> >>>  {
> >>> +	unsigned int nbits = pos + BIT(order);
> >>> +
> >>
> >> That really doesn't sound right. Have you added self-tests for these
> >> functions first and then used those to catch regressions?
> > 
> > When bitmap_allocate_region() is broken, almost every arch build fails
> > to boot. Can you explain what exactly looks wrong to you?
> 
> The number of bits we are about to set should not be [position in bitmap
> to start from] + [2^order]. The second half of that patch was
> 
> -	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
> +	bitmap_set(bitmap, pos, nbits);
> +	return 0;
> 
> so instead of setting 1<<nbits starting at pos, you're now setting
> pos+(1<<nbits) starting at pos. How is that correct?

You're right. Bad on me. :/

I'll send v3 with all the discussed cleared shortly.

Thanks,
YUry
