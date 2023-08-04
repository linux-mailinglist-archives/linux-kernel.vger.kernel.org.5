Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30577702C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHDOQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjHDOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:16:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794419A4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:16:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso706797a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691158575; x=1691763375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lLUU1T0uoHqGolc81tHD/pjmtqyTHJJRjElymsdnq4=;
        b=hvoLusLzwB/D+BqCeL/7hT02TY04C9T44wMDHJCADi5DvcEwFwu58OktRv7Ma9LqRY
         x9DvWPZ1XX3pC4O2oTSq3eHSk6RL8caGskIyY180XFzfM5hJe0u0EdS7AkfhUrSYnPCG
         AAwoWsv5YfcIW+R8SX8bMc5vudzrVXEvInh3PB+hCzdEMXOm0lM7phBvWVt2qWX7hgpy
         c5+SZd4uWH/NwCPYh+xWg92evtVGNAs6YaQT043AA0i5IwzqA+bNH+y0Uof932HUI0ws
         07AIgvah4eppoYsBm4I4v4ImsVdt5kHVL+nN/lxgWIAliur/3A9wB6KNWo6Vix9o4jPW
         hzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158575; x=1691763375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lLUU1T0uoHqGolc81tHD/pjmtqyTHJJRjElymsdnq4=;
        b=AQAHGRFi0VTQk5auaVbzslMy2+Z55MIrvwKL/NzUgy1kPmWQpMj+IYAnaNkQwAUVxE
         fL2+LYsJnmCYq3MIuQ/Sp4W+RGt9S3yitQjmtGbWCWQEjO0sdzr5BRx7UiCmWCZzSDO9
         kGQN4XVr3BNyOKg65Q5Av8+pgvai+DLsdPfgIREz9ZogxS6M1foPrQy9WNaLf4fL4eIE
         x6+mxSPguNAuDNxSw3cleZaY5PdN+J5MERm86b+SBNJ9mEukv0YriNdFB0XjryYgzjG5
         ufH0bC74B/PcxoOrKM1f0//v+HEnU6GqCjjV4/+kFqFadRqGtE9pgwbAV5e4RisVSbaI
         Eerg==
X-Gm-Message-State: AOJu0Yz/k1CyZwa2ANx0rexq841KvCvaLEnyVy02Bq+O9Qqc4bSqXUaA
        eI4zD7o2fujBzYB1ACjb9ns=
X-Google-Smtp-Source: AGHT+IHOiCQogIUGea1ukDtrwuTqbyGTDjFI5cGcI/JC5bWPTPcmbdc6XB1qkeCZw+OgA51NRsYRfg==
X-Received: by 2002:a05:6830:1e86:b0:6b1:604f:3f22 with SMTP id n6-20020a0568301e8600b006b1604f3f22mr2522112otr.2.1691158574778;
        Fri, 04 Aug 2023 07:16:14 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id c18-20020a9d6852000000b006b8a2cd44adsm1129724oto.72.2023.08.04.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:16:14 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:16:09 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <ZM0IKe4S/awAI1Jk@alolivei-thinkpadt480s.gru.csb>
References: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
 <2023080424-mantra-stagnant-a912@gregkh>
 <ZM0GKETT/sQjN3GH@alolivei-thinkpadt480s.gru.csb>
 <b051dc81-c863-4a82-bb60-2fe022d116cf@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b051dc81-c863-4a82-bb60-2fe022d116cf@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:11:29PM +0300, Dan Carpenter wrote:
> On Fri, Aug 04, 2023 at 11:07:36AM -0300, Alexon Oliveira wrote:
> > On Fri, Aug 04, 2023 at 03:23:17PM +0200, Greg KH wrote:
> > > On Tue, Aug 01, 2023 at 01:17:07PM -0300, Alexon Oliveira wrote:
> > > > First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
> > > > but added new warnings in the process. This patch is intended to fixed them all,
> > > > on lines 133, 142, 144, 145 and 173.
> > > 
> > > Patches are stand-alone, we have no idea what "First patch" is.
> > >
> > 
> > That was just me being verbose and given more details related to the
> > v1 of this patch. I apologize. Nevermind that. What is worth is below
> > the ---
> > 
> > > Please look at the commit log for this file, or for all of
> > > drivers/staging:
> > > 	git log drivers/staging/
> > > and get an idea of what changelog text should look like.
> > > 
> > 
> > ACK. So the correct changelog should be:
> > 
> > staging: vme_user: fix check alignment should match open parenthesis
> > 
> > Fixed the following as reported by checkpatch to adhere to the
> > Linux kernel coding-style guidelines.
> > 
> > Changes in v2:
> > - Fixed CHECK: line length exceeds 100 columns, noted by Greg KH and Dan Carpenter
> > - Fixed CHECK: Alignment should match open parenthesis
> > - Fixed CHECK: Lines should not end with a '('
> 
> This v2 changelogs go under the --- cut off line under the Signed-off-by
> section.
> 
> > 
> > Changes in v1:
> > - Fixed CHECK: Alignment should match open parenthesis
> 
> No one is going to NAK your patch for saying this but to talk about
> changes in v1 doesn't make sense.
> 
> The new patch will be v3.
> 

ACK. Thank you for the heads up. Writing the v3 now.

> regards,
> dan carpenter
> 

Thank you.

Alexon Oliveira
