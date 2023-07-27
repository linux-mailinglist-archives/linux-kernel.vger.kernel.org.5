Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AF76565C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjG0OsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjG0Orw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:47:52 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AFC35B5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:47:30 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56597d949b1so782148eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690469248; x=1691074048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEBZ7nwX4+WR2daHw/62cQtqGndXRWYqeJ5n2EmpQVM=;
        b=U/fb6tSdoJaxcPPyIPZgdIbUDEYxHVdXnlI3CIPKnhNm3gd4UDJx0Ke/ipTtfATzkh
         wZVgFrcq36MHCttbksmYYwBLo2fUXW50HwE+/5t7aCN2p3q49Taav0+f7PgTnHwcvV+9
         1pdtYljEnxNs+qNNQ9Ajvh5NOa/JqWDCB2mNOV1eLQztOV6V/O/wHMj5J4ybY1+FFGRR
         fflZkjvmdoUazcb3SqS7G7eh6GjQWpkN6VRbaWItUGWBcH1D5B9e2XEvAOhREPRKBC1S
         NNrOwRUl2gUT1dqF5AlZjrkLxkYJc+lofx8Udl8ONP+IEcQkaeIeYpmchFjbZ28/0Tr3
         tYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469248; x=1691074048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEBZ7nwX4+WR2daHw/62cQtqGndXRWYqeJ5n2EmpQVM=;
        b=TPopGYbk6rkW9z40Ca0k4K1dc4nvqkl2tuKP+Q80EuQS7qmxrKIJnWIbgSbN7LQpik
         cBjW9KLAT/QXjz28V92ulcacLvclpeF1LDAGPvbg2QfMWd+4WTTmwdhTsIYoR0B1QmZW
         vJ6MbdD9R2ttJ9hJXXnnjdfqXWMbXgsQTXsq2/NiU32erKI1CW9FEFsYblLW7WT65Pk4
         FcGJDq8XQGL4H3INDMC4V1VgTiQ3h7w3a2Nsu1JCaHynkClgZ4Atq3e66bpDXe9g2jVI
         PDWKoNHlFtYwAXr9tJ6op5izGW0gU+JbFigRf5si9ZuP7G+DJiqgE+ZkAswHDwC7DYLr
         xP9A==
X-Gm-Message-State: ABy/qLbTokij3U3TZEUqw2erZ6JbJgxsx0K3ylscQkRaO5sa4ZWzY0wJ
        7BsutV41ARjdYnLdJrsSW7QRtAWD35U=
X-Google-Smtp-Source: APBJJlETIdaCivoWnFSWgxCwrzogg7siQ7AcgYK7CiG04fzEKEGFJdF4+wNPgWvRUVF10oLYfhOYnw==
X-Received: by 2002:a05:6870:e38d:b0:1bb:509a:824f with SMTP id x13-20020a056870e38d00b001bb509a824fmr3382598oad.55.1690469248485;
        Thu, 27 Jul 2023 07:47:28 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b001bb86ab4325sm746748oal.48.2023.07.27.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:47:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:47:23 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072729-sensitive-spyglass-ec96@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:03:19AM +0200, Greg KH wrote:
> On Sat, Jul 08, 2023 at 12:55:11AM -0300, Alexon Oliveira wrote:
> > Adhere to Linux kernel coding style.
> > 
> > Reported by checkpatch:
> > 
> > CHECK: Alignment should match open parenthesis
> > 
> > #132: FILE: drivers/staging/vme_user/vme_bridge.h:132
> > #135: FILE: drivers/staging/vme_user/vme_bridge.h:135
> > #139: FILE: drivers/staging/vme_user/vme_bridge.h:139
> > #142: FILE: drivers/staging/vme_user/vme_bridge.h:142
> > #144: FILE: drivers/staging/vme_user/vme_bridge.h:144
> > #146: FILE: drivers/staging/vme_user/vme_bridge.h:146
> > #148: FILE: drivers/staging/vme_user/vme_bridge.h:148
> > #152: FILE: drivers/staging/vme_user/vme_bridge.h:152
> > #163: FILE: drivers/staging/vme_user/vme_bridge.h:163
> > #173: FILE: drivers/staging/vme_user/vme_bridge.h:173
> > #175: FILE: drivers/staging/vme_user/vme_bridge.h:175
> 
> We don't need all of these lines.

Hi Greg, I hope you're good and these messages find you well.

ACK. I thought it would be good to explain what I changed.

> 
> >     Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> 
> Please don't indent your signed-off-by line, that should be to the left.
> 

ACK. I didn't indent. This was the output of "git format-patch" I copied and pasted. Next time I'll remove the indentation manually.

> > 
> > diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> > index 11df0a5e7f7b..a0d7a8db239d 100644
> > --- a/drivers/staging/vme_user/vme_bridge.h
> > +++ b/drivers/staging/vme_user/vme_bridge.h
> > @@ -128,28 +128,21 @@ struct vme_bridge {
> >  	struct mutex irq_mtx;
> > 
> >  	/* Slave Functions */
> > -	int (*slave_get)(struct vme_slave_resource *, int *,
> > -		unsigned long long *, unsigned long long *, dma_addr_t *,
> > -		u32 *, u32 *);
> > -	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
> > -		unsigned long long, dma_addr_t, u32, u32);
> > +	int (*slave_get)(struct vme_slave_resource *, int *, unsigned long long *,
> > +			 unsigned long long *, dma_addr_t *, u32 *, u32 *);
> > +	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long, unsigned long long, dma_addr_t, u32, u32);
> 
> Did you run your patch through checkpatch.pl after making this change?

Yes, I did it. No more checks about "Alignment should match open parenthesis".

> I think you just added more warnings...

I only focused to solve the checks related to the message above. Nevertheless, there are still other warnings and checks reported by checkpath.pl non-related to this patch (i.e. not caused by this patch) that need to be fixed, but I intend to help to fix them afterwards in a different patch, so I don't send patches with too many changes at once.  

> 
> thanks,
> 
> greg k-h

I appreciate your feedback and if there's any other question or request, pleaset let me know.

Thank you.

Alexon Oliveira
