Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C77028E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHDOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHDOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:07:48 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7203CC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:07:42 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bb717ece50so1484168fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691158062; x=1691762862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=183beCR+QhoazEWP1khM41A9Kq9EXTnSY3U7AVlzCrM=;
        b=V/AY7ilbkC+kIuK5m1Mo0EJUZBOnyhmfJAXYww+2vcMS+RxU12F67qCrA3gg6UyxMV
         LNhyUwX2l1IooVVAfle3wIJFZBPYxklFsiL7dPHduJ4i0Uz7FD0PZ8/3DzpjkfpmwF/9
         vq1mzc3oJddna9V7PIMO6jBuXB/8VubtzhIPRNLhS/lDq5pjbsttq3mnKv+eN5Ts0XUz
         QH3FlYemiLII4eac5dzWZ53kO2xKS1fI3vn/LkNRAYoqlXCpiZSRez5Ag8aTUHb4gAn7
         Otq+mj+cVIGyY3gkvg0Pm/8D3bg/Giisrdr9F3NuvMyGFwIXpl1l0T8ojdYRzxqfZ5B4
         NI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158062; x=1691762862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=183beCR+QhoazEWP1khM41A9Kq9EXTnSY3U7AVlzCrM=;
        b=FyNSkyxMxt2g/vsuiHylFynxY8ntXWRcnIy8VguEnX+Kpf8cCtxU2JXarjNe1Fjf5m
         MKFZEkvxRoFSltDkPkh7kBaLqqrk8Pw0BlS6Ak/EFvD97a2W+pq6e+8IVeeuTjlTh8pF
         velyUL6DSgenJpC63oSUrZarPfw7C3ktKfO8el6jAfMfFxPSfBxqK0nqs8pjYgLvzkVL
         cR52lcmPOeOk624iZRCmRVcerKL4XdmlZK/x9i5ri68Ay82zLJWBDjLfu8HGvu4jyrNI
         WG0kijt/CfTt/vGtYwGNBdONE6uC+p4OhkFG2dgI/9VitnBR+hjd/lViB2G7tF3wkgWF
         fDNA==
X-Gm-Message-State: AOJu0YzrjSzJ7EtmTSegCejUBN6d5I9hEL3nw0JlaDgDjy6ArMVBfuUv
        bzl7ttD89wOyxAM2wY48xEEyMn6oXj0=
X-Google-Smtp-Source: AGHT+IFzo5TyINdNhbwoaY7Aj8ha22r8ltYciXHIKJjh8WXFRCsMACwSEQOy74s4GRqDlVIOs0F2XQ==
X-Received: by 2002:a05:6870:560f:b0:1b0:3821:f09e with SMTP id m15-20020a056870560f00b001b03821f09emr1785601oao.18.1691158062047;
        Fri, 04 Aug 2023 07:07:42 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id s4-20020a05687090c400b001bb9d01fe3dsm1130988oab.5.2023.08.04.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:07:41 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:07:36 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@linaro.org
Subject: Re: [PATCH v2] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <ZM0GKETT/sQjN3GH@alolivei-thinkpadt480s.gru.csb>
References: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
 <2023080424-mantra-stagnant-a912@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080424-mantra-stagnant-a912@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:23:17PM +0200, Greg KH wrote:
> On Tue, Aug 01, 2023 at 01:17:07PM -0300, Alexon Oliveira wrote:
> > First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
> > but added new warnings in the process. This patch is intended to fixed them all,
> > on lines 133, 142, 144, 145 and 173.
> 
> Patches are stand-alone, we have no idea what "First patch" is.
>

That was just me being verbose and given more details related to the
v1 of this patch. I apologize. Nevermind that. What is worth is below
the ---

> Please look at the commit log for this file, or for all of
> drivers/staging:
> 	git log drivers/staging/
> and get an idea of what changelog text should look like.
> 

ACK. So the correct changelog should be:

staging: vme_user: fix check alignment should match open parenthesis

Fixed the following as reported by checkpatch to adhere to the
Linux kernel coding-style guidelines.

Changes in v2:
- Fixed CHECK: line length exceeds 100 columns, noted by Greg KH and Dan Carpenter
- Fixed CHECK: Alignment should match open parenthesis
- Fixed CHECK: Lines should not end with a '('

Changes in v1:
- Fixed CHECK: Alignment should match open parenthesis

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>

> 
> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
