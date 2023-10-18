Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208327CD97D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJRKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjJRKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:44:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98CDB0;
        Wed, 18 Oct 2023 03:44:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c603e2354fso357846966b.1;
        Wed, 18 Oct 2023 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697625850; x=1698230650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXa0w19CJ/VQqHzFWA2tc2T/dfIr2XV9jMvebHQyLxQ=;
        b=BnuKIIh6ghlxzQOJ2ivbbwy6FYgLFZ6IsGVK8eOojvdoWWw5dIdTs669Xztl3gnxCz
         s8sHIZnUG3JdFScSdiUyBej+sBuhjrnPHZBHolGY3/oYciMqX+kP6iTjaP9DNf+7PN7B
         KWtKpKi7wiZJySN+btEMiq+bk3ow8JR+KXTC0W+u4LlPKnyG+TFoO70IUGQhO+ZvHH76
         2I5tjS3mHBTzZSa1U0HRDJpikn8vOpT9I8PbCdWUCFAfHt3k08DcOifqB0Pg2GBjCGxf
         fCh3o/FGgsuy9cSXFeOnZOWJQhmFQzD3eGqU44wt0dGxhI2ImyQvebcrpgCTZ/rZBxjb
         RR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625850; x=1698230650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXa0w19CJ/VQqHzFWA2tc2T/dfIr2XV9jMvebHQyLxQ=;
        b=jNeueJ3cSu60i9Jq9y1Q0488p+YvngkSVxbNc0Hyj0qnnqL0SF+HOuAQrrKjUVq9JG
         2LqL1pMlMKg/eM+nhH5B+ZRD87jRevPNkGTX/g18OE7tVTnmWgPmUNLSEQ5p8aSY+4Pz
         STsIDJy2WSCYLfWzL07vULpX6Bw+0GqkyVxnfJBU5YCC8yAUMM93hU4ShzLjAq0CgILp
         InKlnHtbj3AidxclwOUb9Hb9Qh99F1d4f/80zVlw69o8iZi8UJR6xGQ034Yz4IvPZQ2m
         7i9r2wDDeGVDxy5ziBqxws9TdAsuRmkuuj5LheGNMZO0a152v18tQY+BR3YM1j1qrVKm
         sHkQ==
X-Gm-Message-State: AOJu0YyPzovbBlu2uNzAEJEZAVdV8V00Mx5QsvBhmk60xrak8Exx4gAU
        EJuaMqeCNEUWUyNILJ0IMoI=
X-Google-Smtp-Source: AGHT+IGNZH9jo1npqFWKU44BNx59z2V6g/+y+ovaKmNRKwCMUqZe9pS9IdFCbWX+NTMoqi14QA6khQ==
X-Received: by 2002:a17:907:7f10:b0:9c5:7f5d:42dc with SMTP id qf16-20020a1709077f1000b009c57f5d42dcmr4012014ejc.33.1697625850273;
        Wed, 18 Oct 2023 03:44:10 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id mc8-20020a170906eb4800b0098d2d219649sm1423791ejb.174.2023.10.18.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:44:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 12:44:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kselftest tree
Message-ID: <ZS+29xXwA3Nxqd1Y@gmail.com>
References: <20231017150325.4a89ab71@canb.auug.org.au>
 <8f07e202-fe60-4e7e-adde-e39a95f7fb22@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f07e202-fe60-4e7e-adde-e39a95f7fb22@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 10/16/23 22:03, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the tip tree as a different commit
> > (but the same patch):
> > 
> >    197964fc3274 ("selftests/x86/lam: Zero out buffer for readlink()")
> > 
> > This is commit
> > 
> >    29060633411a ("selftests/x86/lam: Zero out buffer for readlink()")
> > 
> > in the tip tree.
> > 
> Thank you. I will go drop it from ksefltest next now.

Thank you!

	Ingo
