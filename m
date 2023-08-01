Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12E76B925
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjHAPxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:53:38 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFF90
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:53:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bc93523162so2806236a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690905216; x=1691510016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNZZO+M2ilGMua+yECx7F0GoXyqlpIpo3cCpiOFYJF0=;
        b=lc7ryDlbZMcuE9Tv4GPzMVq67D5FcbVAukV1lesQ3snjhCCapGTi5lO5BIib5sfoqH
         sBD0Skd1DBlaMo83Gt8MUoZ2a8t1namIxdlWcN7K+VgbBsCiH0o8ClRM2FTxtRXsNgaQ
         kcmRAaGQdgHTXuDvEyAW+Wk3wPsWdfRprf6DCmqla6Moq36PhChfbW5mOCbqE7pvfuAN
         ky7uYxvnDgMKks4d/g5KwYmepLIM7T38neiGoMih1gO0gDzLcO8UxmCKDAZygxLDyX0Z
         4q146hw89zu7OoYYUBTY6zokA+veX3IQI+ccnVU1Usz1CVZaeCtsblTK1BKfG2VmD2rD
         owwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905216; x=1691510016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNZZO+M2ilGMua+yECx7F0GoXyqlpIpo3cCpiOFYJF0=;
        b=UXWWbmvAaGCMmUcbHO26JjLSIpPDn5IJQklSg+Q234hTKeas7CE70chaKiVAVZkMeL
         F06QF/KMZWpaM0nTyS4rcBgUVxmUCEqCyskBoY4o/TlhJojSu14ffQsLjLJTEDiwRByK
         Ouj0EcU3Ucu6cl2ulCr/IUUZZsPKOnyxh4Tp75QXmdMfDBsaU6SImykvP6JQrtQI2GVG
         aa1pxziDZxoCmEGZVpGLA0/IH5sPtr/prKqQDb4gpgXeFV6Ashj77bXNRsVo/M4WwZkg
         pLxHvMiYJGORGO/1f5pdRdE3P2d+nHRFL4B1gOgj74DYaucqoA6R/k8mAxBRwdhTkZ8o
         JD7g==
X-Gm-Message-State: ABy/qLaQ9jDy607R14QR4dWSADv/10tjz3AGbKm5PS0JwWdBbWBY8BCd
        x787KkHczTzw8Af6OpBQU5o=
X-Google-Smtp-Source: APBJJlHFrdSGgyIzG5m0VzcBpcvPcIVA2Ds9TuoBgyBxH0kFBg7GQkasXzbgi+bADT4ewpGbzioHSg==
X-Received: by 2002:a05:6870:2198:b0:1bb:fdb7:d979 with SMTP id l24-20020a056870219800b001bbfdb7d979mr13829634oae.11.1690905215934;
        Tue, 01 Aug 2023 08:53:35 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id n25-20020a9d6f19000000b006b9742a7575sm5116675otq.63.2023.08.01.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:53:35 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:53:30 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZMkqetuQgbVQKvU6@alolivei-thinkpadt480s.gru.csb>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
 <2023072741-mankind-ethics-b95b@gregkh>
 <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
 <2023072752-stem-pupil-76ab@gregkh>
 <ZMKrcvpu3b15Hdif@alolivei-thinkpadt480s.gru.csb>
 <2354895b-c127-40eb-8f16-b19e4750e1d0@kadam.mountain>
 <ZMP+MPdQ2IjJjFCE@alolivei-thinkpadt480s.gru.csb>
 <5be80f9a-7dc9-4f56-9b8c-467321321d48@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be80f9a-7dc9-4f56-9b8c-467321321d48@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:59:12PM +0300, Dan Carpenter wrote:
> On Fri, Jul 28, 2023 at 02:43:12PM -0300, Alexon Oliveira wrote:
> > On Fri, Jul 28, 2023 at 08:24:56AM +0300, Dan Carpenter wrote:
> > > On Thu, Jul 27, 2023 at 02:37:54PM -0300, Alexon Oliveira wrote:
> > > > > 
> > > > > I would have thought you would get a "line is too long" warning, that
> > > > > didn't happen?
> > > > $ pwd
> > > > /home/alolivei/git/kernels/staging
> > > > $ perl scripts/checkpatch.pl --strict -f drivers/staging/vme_user/vme_bridge.h | grep -i parenthesis
> > > > $ 
> > > > Nope. I didn't get any of that. Check it out:
> > > 
> > > Heh.  The warning is there but you used grep to remove it.
> > > 
> > 
> > I only used grep so as not to pollute my answer with too long
> > output, but you can validate the full output by running the following:
> > 
> > curl -ks https://people.redhat.com/alolivei/kernel/evidence
> > 
> > You'll see there's no warning related to this patch.
> 
> I checked before I emailed you...  The warning is there in your URL as
> well.
> 
> CHECK: line length of 121 exceeds 100 columns
> #133: FILE: drivers/staging/vme_user/vme_bridge.h:133:
> +	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long, unsigned long long, dma_addr_t, u32, u32);
> 

It took me some time to finally understand your observation and now I
get it. I was able to identify these same new warnings. Thank you for
your patience in explaining that out to me.

> > As I mentioned, there are other warnings that were already there before
> > I submitted the patch, and I didn't touch them (yet).
> 
> No, these warnings are new.  Here are the relevant lines from the diff.
> Originally it was short and now it's a bajillion characters long.
> 
> -       int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
> -               unsigned long long, dma_addr_t, u32, u32);
> +       int (*slave_set)(struct vme_slave_resource *, int, unsigned long long, unsigned long long, dma_addr_t, u32, u32);
> 

You're correct (as so Greg). I've already applied the necessary fixes to
that and I'm submitting a v2 patch with these changes. Again, thank you
for your feedback and help.

> regards,
> dan carpenter
> 

Thank you.

Alexon Oliveira
