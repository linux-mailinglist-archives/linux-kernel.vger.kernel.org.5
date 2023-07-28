Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063EC7673A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjG1RnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjG1RnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:43:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C813A81
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:43:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38c35975545so1905038b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566199; x=1691170999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+2oB4HmRgFIUjKdC4XEyzbsVfurztpStJ6AGUhKKug=;
        b=oZ67Qs8p+iXOD6+ENrdTy6XIVFAgUMpSvPg7Otw8pXHEWUHB5Tkr/9LkpsN+KEQEoJ
         t/nB/ObofnKO/bhr8jwhkqoH+96Szbm2h/R4znF/Bl7PgTeFiDFACzcbeg5A+cKR6vEz
         cVjfEuiTa/HkP4G7kHKrhDkUPbXlZVaMk/sqjAXD9UFk1HP5q/bhTh0IjqgDQV9p6iVs
         gRMOw3/ioIk1p4+Gf6aDywvJtdmStOkhh1SwNUQY+TrMFWNN5kpRXxXGUXYTiqciJfiD
         X1fxt5Ya511uFAghFaGRfqyl7Wp/pXSKXljvEIcl4gihZ+j2K1lvZ2MaitICJ4kh1WPY
         4f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566199; x=1691170999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+2oB4HmRgFIUjKdC4XEyzbsVfurztpStJ6AGUhKKug=;
        b=UEXMtUBls+1AqkaxNr/fg3HZ8DnyqUjD2Ru9WoNfCZE7i+p+x4km2dhIsHcyt+JH5C
         eagAGfWVPjSuf7lcHqzaDUsbZfp+pZNzxD2QW3BYpsspG6kNevZHED2LDIi31B9qpdEq
         syJ2DY8kwPCsYn+zzMgOX9fsjh7k89d/qLJrtHZRORf7ymLZNHeDk8dNUYhgt90cUAti
         evYs+BnEGUipYMhxWIpJ3v8rx8eaWTtJxIZBUjKNiuyx+GCrILGpal4A0vwuns4kvWKQ
         nmrMtyQvGYbaXZVjZ7PhVvwU1KGw9VOg/qnGlQNiQEGmzWq08c0sBaPEea1skBhbPC7n
         /tcQ==
X-Gm-Message-State: ABy/qLYnszmx0tjM2sqiFSJ++j/fPZynKWAFBBSv93BpxC+wblSQahBh
        Le0IRtaDMi9bwef7NDdfIVzyy9mME9w=
X-Google-Smtp-Source: APBJJlHB1KcYkskKlpURTWN08zgBkNYbIAwRbI0Q1obdriMspy/hpRMxImPRal9DZCAZwqSMngMkPw==
X-Received: by 2002:a05:6808:219a:b0:3a2:a96d:19c3 with SMTP id be26-20020a056808219a00b003a2a96d19c3mr4406619oib.41.1690566198690;
        Fri, 28 Jul 2023 10:43:18 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id e14-20020a056808148e00b003a1e38362b7sm27519oiw.25.2023.07.28.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:43:18 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:43:12 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZMP+MPdQ2IjJjFCE@alolivei-thinkpadt480s.gru.csb>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
 <2023072741-mankind-ethics-b95b@gregkh>
 <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
 <2023072752-stem-pupil-76ab@gregkh>
 <ZMKrcvpu3b15Hdif@alolivei-thinkpadt480s.gru.csb>
 <2354895b-c127-40eb-8f16-b19e4750e1d0@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2354895b-c127-40eb-8f16-b19e4750e1d0@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:24:56AM +0300, Dan Carpenter wrote:
> On Thu, Jul 27, 2023 at 02:37:54PM -0300, Alexon Oliveira wrote:
> > > 
> > > I would have thought you would get a "line is too long" warning, that
> > > didn't happen?
> > $ pwd
> > /home/alolivei/git/kernels/staging
> > $ perl scripts/checkpatch.pl --strict -f drivers/staging/vme_user/vme_bridge.h | grep -i parenthesis
> > $ 
> > Nope. I didn't get any of that. Check it out:
> 
> Heh.  The warning is there but you used grep to remove it.
> 

I only used grep so as not to pollute my answer with too long
output, but you can validate the full output by running the following:

curl -ks https://people.redhat.com/alolivei/kernel/evidence

You'll see there's no warning related to this patch.
As I mentioned, there are other warnings that were already there before
I submitted the patch, and I didn't touch them (yet).

> Speaking of long lines.  Could you fix your email client to line wrap at
> 75 characters.
> 

ACK. Done.

> regards,
> dan carpenter
> 

Thank you.

Alexon Oliveira
