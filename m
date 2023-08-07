Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B1773053
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHGUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:30:27 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7710D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:30:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d4b5890a0so34823326d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440220; x=1692045020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr2i5qxkhGjfmILz+uvOF1tjyrYgdGxHdOcxcXBJNWA=;
        b=e682w2ePBOffmfaYz1w3+u2PwZXBa0YID7tktFUK+ssSjtvFDZmQ8dfRCkR5U4hwxL
         7detsLe4bUDQ5EYA4XacQ+q+KTxCrDbV7Oh7TN7XR9nkA2NtB639UfKubxv6Zv1gc3La
         LBfI0o/2y5svx7pPO310H7Bq6t6bkJmruFitD8dRafZEJ/eS8mwCNEyNmaRvxVK+3HtQ
         5HQc7ggl12Cq97KM7SZMgrI5BcLrCuUCKdARWaXte7snGfyqVu9YYqaABdFeUMuH5IlN
         cmCIgvlaL6AewM0kprEarb0ggzVwsgCZ+o30yWarG0CISt+Tn+RDOvkWP8qFBFXfAMVK
         CTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440220; x=1692045020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr2i5qxkhGjfmILz+uvOF1tjyrYgdGxHdOcxcXBJNWA=;
        b=kCz3MmaZaiQAeU6uKG94bj4r+hCye8EbiD28jpVgIOkGfIODpW5zdGybCBWGd2rFuJ
         JmeFFmIRrQ1Zbl8lHBzFLvM5cWzhcBQR8y4awJZ+0QGVxLlDsCRkglcgZq4dmqlBqqfI
         7JnDGwjKa/choOh4boIsVP6BVvFR/MT2TAIpwa8uCrLo1HKNrgZvWhcbDH4f0sWY5JAv
         dSKqc5p130skSEtp49XdJgZxHVriMglLx0zUYD/MoXEB4WXp13a2soKgpG7Wgz6YAYga
         AaK5GArEBywCh7iGdmE4UGyCGlpmjbuyPvBYbGjFElBim4jDclqzP53nTaeTrjOvo4xJ
         vNOQ==
X-Gm-Message-State: AOJu0YxVKj7EqRyaluyYqxu8bPzwdOYlzbe2WAQLVOqYRMChM+6P6S3n
        QQhtxvJf8UrCMSUG5syrCkE=
X-Google-Smtp-Source: AGHT+IEokm+HBFcmGmD+MkPfzaJHTJspxUNh1wJnk3t/yGb4NQBXo9Tv+Bt2w/sfT0u9NgedSXQ3nA==
X-Received: by 2002:ad4:4e83:0:b0:63d:3bea:f663 with SMTP id dy3-20020ad44e83000000b0063d3beaf663mr9037192qvb.47.1691440220156;
        Mon, 07 Aug 2023 13:30:20 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a000500b0076cbcf8ad3bsm2808618qki.55.2023.08.07.13.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 13:30:19 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:30:15 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZNFUV2M7eX6xb+1x@alolivei-thinkpadt480s.gru.csb>
References: <ZM1rsu0M22HHtjfl@alolivei-thinkpadt480s.gru.csb>
 <2023080510-vacation-support-7afe@gregkh>
 <ZNEKJH3mEoOwV6eF@alolivei-thinkpadt480s.gru.csb>
 <2023080746-consonant-employed-030d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080746-consonant-employed-030d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:26:04PM +0200, Greg KH wrote:
> On Mon, Aug 07, 2023 at 12:13:40PM -0300, Alexon Oliveira wrote:
> > On Sat, Aug 05, 2023 at 08:14:33AM +0200, Greg KH wrote:
> > > On Fri, Aug 04, 2023 at 06:20:50PM -0300, Alexon Oliveira wrote:
> > > > Fixed all CHECK: Alignment should match open parenthesis
> > > > as reported by checkpatch to adhere to the Linux kernel
> > > > coding-style guidelines.
> > > 
> > > This does not describe the changes you actually made in this patch :(
> > > 
> > Hi Greg,
> > 
> > Thank you for your feedback. Don't get me wrong, please, I'm just trying
> > to understand it now, but honestly I don't know what is wrong with
> > it this time. I described exactly what I did in the code: ran the
> > checkpatch, which identified a lot of "CHECK: Alignment should match
> > open parenthesis" messages, fixed them all according to the coding-style
> > guidelines and comitted it.
> 
> But you did not change the alignment of the open parenthesis, right?
> You deleted the trailing whitespace.
> 

Hmm, I did both, but the last one I did right before commit, due a final
check. But you're right, I forgot to mention it in the changelog as
well. I'm going to submit a new patch with the correct description.
Thank you for the explanation.

> > 
> > This is the same thing I did previously for the file
> > drivers/staging/vme_user/vme_bridge.h in the commit
> > 7d5ce25fb4c3cc91d16e27163dc141de0eba213b, but now is the file
> > drivers/staging/vme_user/vme.c and commit
> > a1f0b0a8ba9a496504c2e3d4b37cee388e78f0ea. Different files,
> > different commits, similar fixes for the same warnings,
> > and same description.
> > 
> > The only thing I found strange is because instead of starting a new
> > email thread it ended up in the same email thread as the previous
> > patch. Would that be the problem?
> 
> That would be a problem, and it seems you used the same subject line as
> previous patches that were different?
> 

Yep, used same subject line. I'm going to change it slightly to not
extend this thread, since it's a commit for a different file.

> Anyway, my comment was about the trailing whitespace change.
> 

ACK

> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
