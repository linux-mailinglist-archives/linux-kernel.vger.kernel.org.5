Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BD76598A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjG0RI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjG0RIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:08:24 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3018926BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:08:23 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bb2ce4f9f8so973972a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690477702; x=1691082502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+GGPSrur9KqSLM7ZwB/8NicxdLAYs9+BP1y58L8FFc=;
        b=ZV54F+aLOMgOJe/RdnJI2mWv/9zs0zntiydxD2W5I7v1ZE3dVzmPs6uHZjkAtXRQW2
         FTaR2pDZP1b5Bem3iXOz1+yEshPUipvg/s/AQaKYxhUJGL26Zey5jJeAZIY5Ia325hZO
         N+qy7Jvq5vE7MQ3d/qYBDcgUUK/95AOklaZyz+GYQHmIKJ4rSGKTRotZrgIbtdziZluw
         IPHpD9BiWV3XFJkgB9+PQ7tvxE8aUu99/ff4Ei+4sD+Otbm6KXQqV9aRjrtnB8qjpBpA
         qXPdhyirazjshQFE1rw4PvsQmSAt/WEMrOexxxICKM5xYBK8qLd4ZoyTcK6NGWu5L3vK
         jefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477702; x=1691082502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+GGPSrur9KqSLM7ZwB/8NicxdLAYs9+BP1y58L8FFc=;
        b=LJwcMr4r7h+TmK3hQFpNQ4PIVc3PNEC3AcPCnnISz5rlh12aBukqPNtmbWuAnSEwdB
         X9TP9YRyJxtzcvgIEXw8QQz/KgaTqJxFcbaCYjuw8Rj3ZzwZ7MSYBf9ZXBQ8U713VHqr
         wHpsmYoGrSFT5mdWshb2/RS4OVPkQWc5s74OUXKsAwPRxwNyvz8cmh5/VsJMm8nxsF+H
         5xqrp1TO6WhVqKatma6JHNx9juzP1TB8UUzMH/yegd6R886D4eGBFfkQMWqSSF4rd1a1
         zv9hD4W7HaM5cp8/0Jl6Xg4TFhjDKRIUn/nhpndsYufzKeD7klBNmbHb3J06AY0zLEjf
         zpAw==
X-Gm-Message-State: ABy/qLYxec/gdeFZDwqK2DV2Zb1RQGpP0rKn6ZnPDF05oiMrGCy2VEKO
        dV3gChZcdetnFk0SPYujwjM=
X-Google-Smtp-Source: APBJJlGLm6J11rduSvQ0rCWpbAKbN+Euv2dHL3xFfJI4uqvEZIVa97o2R/uxdb5GNd/oo0XnKlAshg==
X-Received: by 2002:a9d:7619:0:b0:6b9:ed45:a035 with SMTP id k25-20020a9d7619000000b006b9ed45a035mr5648705otl.20.1690477702256;
        Thu, 27 Jul 2023 10:08:22 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id i17-20020a9d6251000000b006b9f26b9b94sm816823otk.28.2023.07.27.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:08:21 -0700 (PDT)
Date:   Thu, 27 Jul 2023 14:08:16 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
 <2023072741-mankind-ethics-b95b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072741-mankind-ethics-b95b@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:05:03PM +0200, Greg KH wrote:
> On Thu, Jul 27, 2023 at 11:47:23AM -0300, Alexon Oliveira wrote:
> > On Thu, Jul 27, 2023 at 10:03:19AM +0200, Greg KH wrote:
> > > On Sat, Jul 08, 2023 at 12:55:11AM -0300, Alexon Oliveira wrote:
> > > > Adhere to Linux kernel coding style.
> > > > 
> > > > Reported by checkpatch:
> > > > 
> > > > CHECK: Alignment should match open parenthesis
> > > > 
> > > > #132: FILE: drivers/staging/vme_user/vme_bridge.h:132
> > > > #135: FILE: drivers/staging/vme_user/vme_bridge.h:135
> > > > #139: FILE: drivers/staging/vme_user/vme_bridge.h:139
> > > > #142: FILE: drivers/staging/vme_user/vme_bridge.h:142
> > > > #144: FILE: drivers/staging/vme_user/vme_bridge.h:144
> > > > #146: FILE: drivers/staging/vme_user/vme_bridge.h:146
> > > > #148: FILE: drivers/staging/vme_user/vme_bridge.h:148
> > > > #152: FILE: drivers/staging/vme_user/vme_bridge.h:152
> > > > #163: FILE: drivers/staging/vme_user/vme_bridge.h:163
> > > > #173: FILE: drivers/staging/vme_user/vme_bridge.h:173
> > > > #175: FILE: drivers/staging/vme_user/vme_bridge.h:175
> > > 
> > > We don't need all of these lines.
> > 
> > Hi Greg, I hope you're good and these messages find you well.
> > 
> > ACK. I thought it would be good to explain what I changed.
> > 
> > > 
> > > >     Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > > 
> > > Please don't indent your signed-off-by line, that should be to the left.
> > > 
> > 
> > ACK. I didn't indent. This was the output of "git format-patch" I copied and pasted. Next time I'll remove the indentation manually.
> > 
> > > > 
> > > > diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> > > > index 11df0a5e7f7b..a0d7a8db239d 100644
> > > > --- a/drivers/staging/vme_user/vme_bridge.h
> > > > +++ b/drivers/staging/vme_user/vme_bridge.h
> > > > @@ -128,28 +128,21 @@ struct vme_bridge {
> > > >  	struct mutex irq_mtx;
> > > > 
> > > >  	/* Slave Functions */
> > > > -	int (*slave_get)(struct vme_slave_resource *, int *,
> > > > -		unsigned long long *, unsigned long long *, dma_addr_t *,
> > > > -		u32 *, u32 *);
> > > > -	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
> > > > -		unsigned long long, dma_addr_t, u32, u32);
> > > > +	int (*slave_get)(struct vme_slave_resource *, int *, unsigned long long *,
> > > > +			 unsigned long long *, dma_addr_t *, u32 *, u32 *);
> > > > +	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long, unsigned long long, dma_addr_t, u32, u32);
> > > 
> > > Did you run your patch through checkpatch.pl after making this change?
> > 
> > Yes, I did it. No more checks about "Alignment should match open parenthesis".
> > 
> > > I think you just added more warnings...
> > 
> > I only focused to solve the checks related to the message above. Nevertheless, there are still other warnings and checks reported by checkpath.pl non-related to this patch (i.e. not caused by this patch) that need to be fixed, but I intend to help to fix them afterwards in a different patch, so I don't send patches with too many changes at once.  
> 
> You resolved one warning by replacing it with a different one, that's
> not good :(

Well, honestly, I couldn't spot any new issue caused by this patch. At least it was not reported by the checkpatch.pl. The ones that are still showing up were already there. But, to move on, if you think it's more productive, I can fix all warnings and checks reported by the checkpatch.pl and send them over in only one patch. Is it that feasible?

> 
> thanks,
> 
> greg k-h

Thank you again.

Alexon Oliveira.
