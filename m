Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32507D38C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjJWOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjJWOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:02:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC23610C6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:02:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1caaaa873efso22547385ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698069768; x=1698674568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhW2ovogLAtdgY5SQJlkyUio4XiA8u6f7LVxFg6+xTw=;
        b=28jjL3dGmwdSUNGHPq9r6/PNDV2Zq8+g86rWh5kEdvzsDIjYDps+VbW8/Tp5T49rMy
         1vnL8QahM4PD4Og8ZeOHLxN73p3StEGHBQ0Ecwr+U7Bx9LtQNJTwdQmwD/i7VdXKTaP2
         5CSu1nOUYprg6GS1eyhXmdNlREK28ToDzDiOlqQ8yBWKPsVFzp+2mruCTVMrtXMYD6rv
         KEu0oGRC74EblJPRSHobwUgqdUjrJiwQc/dro6kUOygetsA4n5R7cqh1B+YsD1q8LAnE
         sl25Ggz0P1oNujddlAQZlCXW4QxZC4tU9Jd1w2p8z+QfLuRbtyeid9is/hICq/mdY54O
         VZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069768; x=1698674568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhW2ovogLAtdgY5SQJlkyUio4XiA8u6f7LVxFg6+xTw=;
        b=cgXiMPWBK3ob11ryVgMIarocba6CZKges4RdG5UQIrfpMrX7HyDV2pRU5AxnGk7Yoe
         XvTlD+v9ke0+3HvdWz9zmrde4JDHHQZM+FzKtjqt9EtZ6clicTc4AyF4mqn+UpCVRBRo
         V44k5WXGhMOSq9HzHanOKE8TJQHubLgpCSL9BMxbkN7IoacrtPyZSbAREnGfQT/BBZXb
         DLn5KzApqTw/nW8oTBhCY/ynfkiV8ztGzpH56ewQD75tfJDWJuUQgXcXwY0DeesWka/s
         iNNHLmuqI+IxBV2Rfetg9Fr/ItPxKJx0k8I7zNAYSCOZ6n2blt3PD+ejaOL810rlmZVz
         r3iA==
X-Gm-Message-State: AOJu0YycOEhls1PO/zQZpVSqPxblLwHnbsj5v/sHHR8TCIKNiGgkMnFH
        NvyE0i4z8sc2ajUuH/Ut+tiDvcp2VG4=
X-Google-Smtp-Source: AGHT+IGUuvbhHZfz3wZFORlHNhRdI0cdjVmY0n57bSPikZhKGOb7nYXCvw6ZXfanc1szj32IaalJvX01dDI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ab5a:b0:1c7:3462:ce8d with SMTP id
 ij26-20020a170902ab5a00b001c73462ce8dmr169614plb.10.1698069768169; Mon, 23
 Oct 2023 07:02:48 -0700 (PDT)
Date:   Mon, 23 Oct 2023 07:02:46 -0700
In-Reply-To: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
Mime-Version: 1.0
References: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
Message-ID: <ZTZ9Bk3-NrK_cVDu@google.com>
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and their sign-off
From:   Sean Christopherson <seanjc@google.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mateusz

On Mon, Oct 23, 2023, Przemek Kitszel wrote:
> Additional tags between Co-developed-by and corresponding Signed-off-by
> could include Reviewed-by tags collected by Submitter, which is also
> a Co-developer, but should sign-off at the very end of tags provided by
> the Submitter.

...

> Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.

Heh, there's a tag for that...

  Reported-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

And it's usually a good idea to Cc the reporter in case there are questions they
can help answer.

> @@ -509,16 +509,18 @@ Example of a patch submitted by the From: author::
>  	Signed-off-by: Second Co-Author <second@coauthor.example.org>
>  	Signed-off-by: From Author <from@author.example.org>
>  
> -Example of a patch submitted by a Co-developed-by: author::
> +Example of a patch submitted by a Co-developed-by: author, who also collected
> +a Reviewed-by: tag posted for earlier version::
>  
>  	From: From Author <from@author.example.org>
>  
>  	<changelog>
>  
>  	Co-developed-by: Random Co-Author <random@coauthor.example.org>
>  	Signed-off-by: Random Co-Author <random@coauthor.example.org>
>  	Signed-off-by: From Author <from@author.example.org>
>  	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
> +	Reviewed-by: Some Reviewer <srev@another.example.org>
>  	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>

This is silly.  Allowing tags in-between Co-developed-by with Signed-off-by
unnecessarily complicates things, e.g. people already miss/forget the rule about
tightly coupling Co-developed-by with Signed-off-by.

And if we're being super pedantic about chronological history, arguably the
Reviewed-by should come before the Co-developed-by as adding the Reviewed-by is
a (trivial) modification to the patch that was done by the submitter.
