Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2A75378C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjGNKKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjGNKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:10:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D51989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:10:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso16975905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689329438; x=1691921438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFWHPsarbAE5FM1drwTioIbYAwpqVOcGLX+OiTOraMA=;
        b=C6UTowscgaC03hoB1biFZGdDzAmjE564AEcUAjvuMxX0PZlLZu2T5rMD2GZJWXh2We
         KGJKx0i2CbFWExPIbuVTN3jlWVp51B1YlwswbHi21ESQLtxfPw068T130OpokD8Ud/jx
         x3xg9yidt7PXReJXEYnm0QMqO57cEHJjR6TzJlx3ZFLyF++Y1C3NTxOId2aFUvSGzSLm
         fFlMbL5qwVYRSM4XQuj16hnmgeGZPXpFfbIi8t/AYeBZuFUmIKywl4nh0oEx7VIN2H9T
         ntUiM2HL0LDgjrhpyvOfEQxcVAeq0LlKISAkL39VifoYc1KWIFrj9qS8TW//IsxN634X
         ojwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329438; x=1691921438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFWHPsarbAE5FM1drwTioIbYAwpqVOcGLX+OiTOraMA=;
        b=bgZO6CvNU6zprnxRw6xaj0O3AnXKp/cv/ZIl9qyA1vudijbXA9aOVBDeGNc5FCXPZm
         vn/TYOa4GZWXV9V61y+ef6zROVb9w+ebsvU8eWocJOzzDqdk2qke+G5MySxpXxs9Ke6W
         dxr8q61EwjaOfsL0lTNmWc/nbuhTG7GQbKNXCf/oH2MJQM1UgMRCrUwCPgJWwtLCe9tK
         cz9l8Hb7G0ohTB4BUnAiLGgvfWj4d5XvKS/ZxN7ZiWcYf1X7J9ayPurMMKOJAUA+1ts6
         3XB6S1BD4NqEqIiYQNtwbD8ETdqinCFXrP2CS8EyYtcu8AW5k2lAUBKechNVi2GZ0bX4
         YmDw==
X-Gm-Message-State: ABy/qLaygUHFh2FJLffSJ1jQLMmpkybIdtdbtSJbPgd710dTNMRTYmr7
        IpMA79tTmukNIa8ZDgxH5xDsMg==
X-Google-Smtp-Source: APBJJlH2uXC8tVM47KU/TINzaEMuifZhGUg/YVBem70u7gBASp8AdDhtewR2bY4voQZ5bQC2qFHOuQ==
X-Received: by 2002:a05:600c:20c4:b0:3fb:e054:903f with SMTP id y4-20020a05600c20c400b003fbe054903fmr3717641wmm.36.1689329438056;
        Fri, 14 Jul 2023 03:10:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c22d200b003fbca05faa9sm1065054wmg.24.2023.07.14.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:10:35 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:10:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        gregkh@linuxfoundation.org, anjan@momi.ca, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] Staging: rtl8192e: Rename variable pBA
Message-ID: <4867720d-bc9e-4560-b8cb-50c8a0422e97@kadam.mountain>
References: <ZK84sYjc9uHIWZcr@basil>
 <724b252e-0c72-6c77-4817-aee8d87a99cb@gmail.com>
 <ZLC3w4tjw16LwuEa@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLC3w4tjw16LwuEa@basil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:49:39PM -0700, Tree Davies wrote:
> On Thu, Jul 13, 2023 at 11:54:40PM +0200, Philipp Hortmann wrote:
> > On 7/13/23 01:35, Tree Davies wrote:
> > > Rename variable pBA to pba in order to Fix checkpatch
> > > warning: Avoid CamelCase
> > > 
> > > Signed-off-by: Tree Davies<tdavies@darkphysics.net>
> > > ---
> > >   drivers/staging/rtl8192e/rtl819x_BAProc.c | 106 +++++++++++-----------
> > >   drivers/staging/rtl8192e/rtllib.h         |   2 +-
> > >   2 files changed, 54 insertions(+), 54 deletions(-)
> > 
> > 
> > Hi Tree,
> > the p is typically for pointer. This is not wanted when you change the name.
> > But ba is is in use....
> > 
> > Bye Philipp
> 
> Thanks Philipp,                                                      
>                                                                      
> A few thoughts...                                                    
> Looking at occurances of pBA, they all appear as local variable      
> declarations of struct ba_record, mostly as function params.         

I'm reading my inbox in the wrong order so I already sent an email
with the same advice that Philipp sent.  Philipp is correct.  "p" is
not allowed.

>                                                                      
> I also see what you mentioned, as BA being already taken in          
> rtl819x_BAProc.c:394 and line 292, but I don't 'think' that renaming them
> both to ba will result negatively(?).

Thanks for noticing this.  Figure out a solution.

> 
> Agreed, let's wait on Greg.

Heh.  Greg is not going to fix these minor issues and neither am I.  We
trust you to find a solution.  You can do it!  I believe in you!

regards,
dan carpenter

