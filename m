Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45F773FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjHHQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjHHQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:50:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034365B82
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:57:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686bc261111so4146634b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510236; x=1692115036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgLj5lJm/YlQTDQrMQmu7EQz+g/56XiBYKu9c5USBBQ=;
        b=l9FLOcGyyragSw5CavQBI9HwVzTfvBjosjXxXTk+2HaIFvpWTQlaIfbojPGXmt39zm
         jc7vlTgizdQDe7rZmUoSXn6onz0oXMRHaH/tNle/fUI+4CeKI+ASg3rnNX+2cgRpl7HJ
         WRYB4yCrcwU+rKBHugOI7qZmR78fj6pj5dqBwgkNlYRMXs4Kznb48SB71m4mzdKW7RGr
         UnH3RNfKBaIK0SMUtjizpCcSRw329cR+kjXCThfa4LL2spgfBnrcCuDLAQr+Dx9pB3/y
         4N+S7JvO9cgk6U5h2m/TCtpxlhie7ed4u9RY5oZ2eIM7JofplyE5yzf3GoUUtlA5UA+K
         8glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510236; x=1692115036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgLj5lJm/YlQTDQrMQmu7EQz+g/56XiBYKu9c5USBBQ=;
        b=kIWOozHhInU+18FqPW4i7G1eAShUzmjHXfcP0ZeJfWt5Q5FWhMdkMCNIhznDNDaSVV
         qwolYvMnoG1vgLwzwGhHxV3PY/p9yX3iph+N7kQf/QYGLSQkRdq0EjSwqYh9QRQLO1W0
         r8Ex7Nj084VT1ub9nZ0s10zfMttleorVjxM+sRWhfs2Jh1vcoHxfboi9iKc1eQ6i6MWk
         ob18yP23iz7eJ1o4zhZcCn9ExNN0P65yaqaTYSWZC9s5f+VsD+M9QKZVr56GinBJbE1p
         5mahsyao6dAyH4cxWrN8ElLEPEyRRwfSvlynQeN8TdSAHt2CRWGeSlfUasgu7uK74SNT
         xzxQ==
X-Gm-Message-State: AOJu0Yw9sFPraDsYsFWeAmEpkH3szMhCRxErR+3LiU1i8zPF7aOUQWVL
        b9ATaUOP/Enre72Pzwn3o8dxwhUxDDo=
X-Google-Smtp-Source: AGHT+IHavzgGepi9NgzaLKaMkuJ49G6QrqbYLK5SHsTYIkHV/oIL1YFNYDPD5wNeoFg4EzLxcMdVGg==
X-Received: by 2002:a05:6870:e410:b0:1bf:1c49:7453 with SMTP id n16-20020a056870e41000b001bf1c497453mr13036985oag.51.1691499918964;
        Tue, 08 Aug 2023 06:05:18 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id eb18-20020a056870a89200b001bf3942ea12sm6067502oab.1.2023.08.08.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:05:18 -0700 (PDT)
Date:   Tue, 8 Aug 2023 10:05:12 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <ZNI9iGbPjgHLUaGG@alolivei-thinkpadt480s.gru.csb>
References: <ZNFXMrtqSWvZv+rl@alolivei-thinkpadt480s.gru.csb>
 <2023080840-passenger-sierra-55ef@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080840-passenger-sierra-55ef@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:33:07AM +0200, Greg KH wrote:
> On Mon, Aug 07, 2023 at 05:42:26PM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Alignment should match open parenthesis
> > and deleted the trailing whitespaces as reported by
> > checkpatch to adhere to the Linux kernel coding-style
> > guidelines.
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
> > 
> > Changes in v2:
> > - Fixed changelog, noted by Greg KH
> > 
> >  drivers/staging/vme_user/vme.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > index 977c81e2f3c7..741593d75a63 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -563,7 +563,7 @@ EXPORT_SYMBOL(vme_master_request);
> >   *         returned.
> >   */
> >  int vme_master_set(struct vme_resource *resource, int enabled,
> > -		   unsigned long long vme_base, unsigned long long size, 
> > +		   unsigned long long vme_base, unsigned long long size,
> >  		   u32 aspace, u32 cycle, u32 dwidth)
> 
> I think the confusion here is that my tree does NOT look like your tree
> at all right now.  If I try to apply this patch, I get:
> 
> 	checking file drivers/staging/vme_user/vme.c
> 	Hunk #1 FAILED at 563.
> 	Hunk #2 FAILED at 614.
> 	Hunk #3 FAILED at 1045.
> 	Hunk #4 FAILED at 1841.
> 	4 out of 4 hunks FAILED
> 
> So please, rebase your tree against my staging.git on git.kernel.org
> tree, the staging-next branch, and then resend the patches from that.
> 

Hmm, ACK. I always rebase before commit a new patch, but doing like
this:

$ git fetch origin
$ git rebase -i origin/staging-testing

I'll do it as you instructed.

> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
