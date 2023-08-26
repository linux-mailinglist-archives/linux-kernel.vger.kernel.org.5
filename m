Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7275D7898DF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjHZUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjHZT74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:59:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEAAD8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:59:53 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca857accbso1552581a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693079992; x=1693684792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjb+U+WE049mgp+WRei7ubvTkYgIbSGu0eAZ4UCcyDs=;
        b=GCBerMg8wyznFGaX2LoIAXYKyU4/DX/MnlV8FPxlkGcaneu6meRLNGD4cgvDDZ9o1Y
         AJ/0rUF2c2ZfH9KXL/oslOf3gjET5/06XVCCVl0jQ604YU/qTSiYn1l690PbLSPkxFBM
         pt7Kpl+isAKjX7khXHVmYQQp+axLtzWI2HVykEJfQ6UVMZ0UMinLpIDJfQ73QJdAS8hj
         5/PSqT2XV/Iytypxli14ToXUB5WiMTX8qd/ZZolTw+4M8P7ZmUEZzIedEP7BjF4chWuZ
         Un6RFiZKADYEcSPFn8rfU+/RsgLaowmRd5kz/HvmAzH5wQAMkTFfOoQy5Ww3fBNk6ZYE
         o9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693079992; x=1693684792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjb+U+WE049mgp+WRei7ubvTkYgIbSGu0eAZ4UCcyDs=;
        b=PXskz+AKOJuAjb2Ao+luDw7XR1WFOW+FTa3i3g56uuevTzjQ7AhPsQu4AimA2zSktc
         P4POT31sD23OaLNYEJ0uO7owzyvsiQgOzsOmodyFfJfIffyX2aqYQQu9ATJZSJ0Y1dxZ
         f8QxezXvEz/v44tc0+ALZ5Pt3vpmjpF4ZfIBzn9H1KuwpH2aGHKiDL6d7ztntwFAe8eI
         4WB2NpQd3m8x4xQ3bWbbxZAOBkb4r+6Qaxp+mr1jXxtGbi2WrmZyRQOQ2dFw6ESVmUOO
         jtT4lyVkHg/WZXr3xzFjFEp0GdLUg6rr7biyUcO/XvLVbjXyxuIv2+HfVfKIGOR/mN7m
         FQxg==
X-Gm-Message-State: AOJu0YzK4EW5CbVDeXRkWRuF/qEPc/B/v1QfnHT8KdDTzAokNo/sOm6j
        Dygx6NDKsRySvJxNtPAqbdU=
X-Google-Smtp-Source: AGHT+IE/N4S9vPY/r+DhxtCrSo04/7zVTKcdDHA5wSvVchVpH2uKztqqHpdRzDU8P4SPybC3ZOiX1Q==
X-Received: by 2002:a05:6870:80ca:b0:1c8:c803:c28c with SMTP id r10-20020a05687080ca00b001c8c803c28cmr6906087oab.34.1693079992520;
        Sat, 26 Aug 2023 12:59:52 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id u38-20020a056870702600b001cd0f7aeee7sm1788421oae.2.2023.08.26.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 12:59:52 -0700 (PDT)
Date:   Sat, 26 Aug 2023 16:59:47 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment to match open
 parenthesis in vme_fake.c
Message-ID: <ZOpZs0/ate0wHt1t@alolivei-thinkpadt480s.gru.csb>
References: <ZOlCJ6uqBf+8HBa7@alolivei-thinkpadt480s.gru.csb>
 <2023082632-crumpled-crease-4b7a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082632-crumpled-crease-4b7a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 09:32:53AM +0200, Greg KH wrote:
> On Fri, Aug 25, 2023 at 09:07:03PM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Alignment should match open parenthesis
> > as reported by checkpatch to adhere to the Linux kernel
> > coding-style guidelines.
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_fake.c | 65 +++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 32 deletions(-)
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You sent multiple patches, yet no indication of which ones should be
>   applied in which order.  Greg could just guess, but if you are
>   receiving this email, he guessed wrong and the patches didn't apply.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for a
>   description of how to do this so that Greg has a chance to apply these
>   correctly.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

ACK. I'm fixing it now.

Thank you.

Alexon Oliveira
