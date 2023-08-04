Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D17702A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHDOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHDOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:11:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FB198C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:11:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so20808115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691158292; x=1691763092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1UhfyzqErwyARy3ZjxeZMXBE+O3bFg49PiyTBLXTwM=;
        b=Kx7miEAt8gm9FawwLxEOOBc56ziZ68HltOiXkWyPjxbWNSxDfr7S5Z3pgjHIuhW8Nm
         yx4RKIg30GWdTw9iNDw9LdRAUc6BHUQh5Cw75kO8aX/kVlTf9nfdmxTNkbsodTlMxnco
         hDz+BDAv1HeA0vuR+IfxEqJOtfRk1EKmh5/J+0atqtktUMO8NnOjbfG75sfhJTj+Jxjk
         sYZ7jbALvR00MW1UoL/q+e29WrVlh5h1bI+20KYzXsqGLZQitIXttYlKXXQIH58nyGCO
         flCCBIopVEgoCU4Q3CuLyzGXPhrJIKwab77tBt4AcEscytZgEAqjlIokt4tqYFfFOdNW
         MLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158292; x=1691763092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1UhfyzqErwyARy3ZjxeZMXBE+O3bFg49PiyTBLXTwM=;
        b=gJuIYxxVQJOJ0Z8M66YnA7a+ccdAmGn4hZ/YH45iIIUXXX2m4j0iJ8XQ97q7GgN8jS
         v+MLIse+bO0srjTv5O/tLZkxTBRpJm5fGl/lVrYwSDaEMIAK5V75/ANF6X8Fc3mj/fA2
         fSyovokv7Rd7xc7ghylYCtHunXjDtDSak7jcCaUGnKQAb3xicOUcdGg+eMeSqaidkO3f
         MVOVjTBAXuHzFvMbdQAxVeq/sdR00lJlqMBLWho7NNsDbWD2ZdSoGK8P/gk47aZ+o2mo
         Xf27n4t2HMGIsDh6vhFc1j65VdpAZEOl3Q9iUTMjFB2TgDfCiBwwRZbMhtkkmo/lUQt7
         pBoQ==
X-Gm-Message-State: AOJu0YzaQAROGUzcPlz30JKTZm5fZfB81YJBlPR/3C3KyD+ZAopnnhR9
        IRovGROG1Cj8VQmGelKL/rrfHUsrBAgJCieTnoM=
X-Google-Smtp-Source: AGHT+IF3fRFhZpyu4dlAPamPT3WzVNrF3/XaynEFnkTut7pG66RAATJh94SMi92NKjec8QdzWVAr/g==
X-Received: by 2002:a7b:c453:0:b0:3fe:22a9:900 with SMTP id l19-20020a7bc453000000b003fe22a90900mr1687241wmi.3.1691158292165;
        Fri, 04 Aug 2023 07:11:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z22-20020a1c4c16000000b003fbb25da65bsm2467374wmf.30.2023.08.04.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:11:31 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:11:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <b051dc81-c863-4a82-bb60-2fe022d116cf@kadam.mountain>
References: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
 <2023080424-mantra-stagnant-a912@gregkh>
 <ZM0GKETT/sQjN3GH@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0GKETT/sQjN3GH@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:07:36AM -0300, Alexon Oliveira wrote:
> On Fri, Aug 04, 2023 at 03:23:17PM +0200, Greg KH wrote:
> > On Tue, Aug 01, 2023 at 01:17:07PM -0300, Alexon Oliveira wrote:
> > > First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
> > > but added new warnings in the process. This patch is intended to fixed them all,
> > > on lines 133, 142, 144, 145 and 173.
> > 
> > Patches are stand-alone, we have no idea what "First patch" is.
> >
> 
> That was just me being verbose and given more details related to the
> v1 of this patch. I apologize. Nevermind that. What is worth is below
> the ---
> 
> > Please look at the commit log for this file, or for all of
> > drivers/staging:
> > 	git log drivers/staging/
> > and get an idea of what changelog text should look like.
> > 
> 
> ACK. So the correct changelog should be:
> 
> staging: vme_user: fix check alignment should match open parenthesis
> 
> Fixed the following as reported by checkpatch to adhere to the
> Linux kernel coding-style guidelines.
> 
> Changes in v2:
> - Fixed CHECK: line length exceeds 100 columns, noted by Greg KH and Dan Carpenter
> - Fixed CHECK: Alignment should match open parenthesis
> - Fixed CHECK: Lines should not end with a '('

This v2 changelogs go under the --- cut off line under the Signed-off-by
section.

> 
> Changes in v1:
> - Fixed CHECK: Alignment should match open parenthesis

No one is going to NAK your patch for saying this but to talk about
changes in v1 doesn't make sense.

The new patch will be v3.

regards,
dan carpenter

