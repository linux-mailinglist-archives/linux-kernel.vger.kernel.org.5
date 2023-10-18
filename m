Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D217CD47F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjJRGap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:30:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B34100
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:30:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3410570a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697610640; x=1698215440; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0Uk18GNbiJSbsmf1R3dcjXeGFJDfuJ+L1EqVZs7JXI=;
        b=U9ePWSKmql3AUteGs8qKvdZLvdI3O97QS1KqQRsMZFMDYEEkAFCpW9PJGi8uQTRp2Z
         S+BPbFbIhvjJxqFZHBZ4fpWaTHr20HgCkUT2/x9NV7Qdcma+d3b0tuStyZoa9spLQXcX
         0K4Rw2qyAYa7uDRO5Eyk/Za5kGimmdtyLMUmXV26p+RRXezvsH7G1XHqmSN6rXhyQ1w6
         1GQYR05U9obAc5i485CKFRKi0G5zrBhpWTNrND3jT22uVY2ORv2/i98M/LVIo++cbA88
         /Mdkh21Dqa1Q2xIUV0FYssFZSeyf/iTUOwKgeEkkd8ZN5EMd2mbQtRYYya6e8bpgBbfE
         KKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610640; x=1698215440;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0Uk18GNbiJSbsmf1R3dcjXeGFJDfuJ+L1EqVZs7JXI=;
        b=UFyZQO9PcmjNieU24dc9gPJkA6qCrBYXzKQ02y6id3/kZlxEtN3wLQkpNtGj/7DZ6P
         rnZkJOn2NDMt/oiassragDoL2l4aNkt0g8C3z95Qg1kOULKHAgNSb+yRTiL8vhl8TXvP
         9WviGU0ITxPJbZur/KJhntcFtkYNFQmfNrh7Qj2XrCpNGrNxuz27Wq4HLnmKgfuKbZTX
         lE8Dh978olBo/wHEhNnHDOUHit27tBFomYGhwBWf6rsp9geHL5HOhInApACb9cW7zTh4
         H3oZGHwIV5gxA5vKzZmcENVEVdqXIhKd3g+As8+FYPf+xJDYUnRMgZQQf4mwuG/uu3l8
         uunw==
X-Gm-Message-State: AOJu0YzWyg71orH58QsJsLqnt3q9KBXFMKjSJAJtIMyLRdkDcWCJUAY5
        aykqU+xiPBwDnrUHf5o9K5M=
X-Google-Smtp-Source: AGHT+IEHRTHxxYuWjQhGXO+rYJx/8C2/iPdkYvGp9CNXtxGuMUx3SrzTX1xMMwnovfBvViV1PlkFPg==
X-Received: by 2002:a17:90a:d494:b0:27d:669e:5a10 with SMTP id s20-20020a17090ad49400b0027d669e5a10mr4143180pju.13.1697610640267;
        Tue, 17 Oct 2023 23:30:40 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090a990200b002774d7e2fefsm546655pjp.36.2023.10.17.23.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:30:39 -0700 (PDT)
Date:   Tue, 17 Oct 2023 23:30:38 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <20231018063038.GB1868@Negi>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
 <19637f96-40bc-a46b-8e7a-fa59e5e9e16@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19637f96-40bc-a46b-8e7a-fa59e5e9e16@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Wed, Oct 18, 2023 at 07:47:29AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 17 Oct 2023, Soumya Negi wrote:
> 
> > vme.c uses printk() to log messages. To improve and standardize message
> > formatting, use logging mechanisms pr_err()/pr_warn() and
> > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > messages during replacement.
> 
> It's not possible to use the dev_ functions more often?  The pr_functions
> don't give context information, and the message don't seem to give much
> context information either.
> 
> julia
> 

Yes, I think there can be more dev_*() functions.

Most of the dev_ that can be added are error/warning messages where the bridge's
'struct device' instance is accessible & can be fed to dev_ fns. Although I went
through the VME subsystem docs, I wasn't sure if the bridge's context made sense
to be printed with those messages. So I wrote them as pr_ functions.

Should I add them and send a v2 for review? 

Regards,
Soumya

