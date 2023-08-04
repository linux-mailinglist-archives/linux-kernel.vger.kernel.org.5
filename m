Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3C7702BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjHDONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHDONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:13:44 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F711B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:13:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a5ad44dc5aso1657410b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691158422; x=1691763222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFUStZjB96altHs1v2dAdA1hEXJW8jJtlfRmt7xhkqU=;
        b=pWEPeiNTNAqQ7lZPPS1zsGsYNIyidcdFW5BMtltCgrU/iQ2Dxmjdj7IqRyElsCki9b
         0vzdliM3ckXVNWpliWxCFUlFyoEvWtYfRGoIgNohlYgQY4J3RRsP9nbCC8/FsfJvCWWB
         OSPH0vzuo7Nt183Ny1MmaHCTk21ONz4CmV5Oe+3wmY/E2IgdY/bJxTvTMQaaB3QQb8Os
         bY9kqvn7EHiPO+m8voX5oN7i4botozjbHETLqAJ+flePUQCGPQtGiVwZCN3i4ru3wpb1
         5aMUzUmsR7Wd+TV+Rqv6+dtqxHEPACwfYkzJs0ckqzqfcsbHC1iRPyrBucTQmeACCjbB
         PWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158422; x=1691763222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFUStZjB96altHs1v2dAdA1hEXJW8jJtlfRmt7xhkqU=;
        b=Ytc9Wof+U+w/P09ZjxjhgrlLCBBjtxjhnMuoHONZvqhxbSasc8j1wpSPAccyreB12S
         8RQ68BtG9HD2GouxiMRK/kjyPGQthHqIlB888T7gcsgSuJPRKpHynE1S6F/8t4Hfpd/7
         dGf3sfdxrVHUaQp6DA22BdH2s2vTumro2z0hGbLnsASNsr5Cfib85n5vOBDaIWaNTwq6
         3sCM+upfNXKQypesMleZLEifxvfKVyrHNGzFRLaw2A3TbhI8/Kf/w7h6Phq87s7HHoia
         JFCNagACbyyjRTPfsvJT3CU6BeZfpdLjfiDGknif9Qnz9thPLdGGLwg2gGQU2Hf9NaHN
         M4Dg==
X-Gm-Message-State: AOJu0Yz+B4bVHgRGIDOHGm/CbMtZsXnPV0fEZytUdMDERc1fIJJMsUcO
        QPO88L58g/OxegeN0B4yh1+5FotHvUA=
X-Google-Smtp-Source: AGHT+IFGknPsjQiDdxkcUwuM1qS5DIQ+RYZh7VqheLYGqNza0ciLpZF4q0DO3qfbfZQk3gs6LskZaw==
X-Received: by 2002:a54:4617:0:b0:3a4:38fa:2e08 with SMTP id p23-20020a544617000000b003a438fa2e08mr1748130oip.7.1691158422482;
        Fri, 04 Aug 2023 07:13:42 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id a4-20020a05680804c400b003a4243d034dsm1016829oie.17.2023.08.04.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:13:42 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:13:36 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <ZM0HkHIQWWMZ9uLf@alolivei-thinkpadt480s.gru.csb>
References: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
 <7159231c-9e87-4a3b-bc0d-a6ade6c04c65@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7159231c-9e87-4a3b-bc0d-a6ade6c04c65@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:46:00PM +0300, Dan Carpenter wrote:
> On Tue, Aug 01, 2023 at 01:17:07PM -0300, Alexon Oliveira wrote:
> > First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
> > but added new warnings in the process. This patch is intended to fixed them all,
> > on lines 133, 142, 144, 145 and 173.
> > 
> 
> Since you're going to be re-writing the commit message anyway, please
> leave off the line numbers.  Line numbers are not really useful.  Just
> say:
> 
>     Fix the checkpatch warnings which complain about "CHECK: Alignment
>     should match open parenthesis".
> 

ACK. I was doing exactly that (in the previous message I just sent)
before I saw your message. I'm on my way to a new commit in a few
minutes with this update.

> regards,
> dan carpenter
> 

Thank you.

Alexon Oliveira.
