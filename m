Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE07656DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjG0PFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjG0PFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AAA106
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2125961EAD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD27C433C8;
        Thu, 27 Jul 2023 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690470307;
        bh=S4gMs7l9BbfVoMDxJHoDIv85l19923iR5lO0JZs5P2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zy8GVxtna31kMtQX2zBoFrOOx5bpfLu2qmX9iy4hnBpGqO0AKtrOmp9CzoUDA2Sw4
         6KSJjETRNILOuMsLmoe7Sl2YRnFHIQp+QLdrjARDsUEb0EwZyM832OPnlclBRGbEWp
         1NnDqTl6aPoeCaOfEeARpHH0uFSupNdAtNVZEAB0=
Date:   Thu, 27 Jul 2023 17:05:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <2023072741-mankind-ethics-b95b@gregkh>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:47:23AM -0300, Alexon Oliveira wrote:
> On Thu, Jul 27, 2023 at 10:03:19AM +0200, Greg KH wrote:
> > On Sat, Jul 08, 2023 at 12:55:11AM -0300, Alexon Oliveira wrote:
> > > Adhere to Linux kernel coding style.
> > > 
> > > Reported by checkpatch:
> > > 
> > > CHECK: Alignment should match open parenthesis
> > > 
> > > #132: FILE: drivers/staging/vme_user/vme_bridge.h:132
> > > #135: FILE: drivers/staging/vme_user/vme_bridge.h:135
> > > #139: FILE: drivers/staging/vme_user/vme_bridge.h:139
> > > #142: FILE: drivers/staging/vme_user/vme_bridge.h:142
> > > #144: FILE: drivers/staging/vme_user/vme_bridge.h:144
> > > #146: FILE: drivers/staging/vme_user/vme_bridge.h:146
> > > #148: FILE: drivers/staging/vme_user/vme_bridge.h:148
> > > #152: FILE: drivers/staging/vme_user/vme_bridge.h:152
> > > #163: FILE: drivers/staging/vme_user/vme_bridge.h:163
> > > #173: FILE: drivers/staging/vme_user/vme_bridge.h:173
> > > #175: FILE: drivers/staging/vme_user/vme_bridge.h:175
> > 
> > We don't need all of these lines.
> 
> Hi Greg, I hope you're good and these messages find you well.
> 
> ACK. I thought it would be good to explain what I changed.
> 
> > 
> > >     Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > 
> > Please don't indent your signed-off-by line, that should be to the left.
> > 
> 
> ACK. I didn't indent. This was the output of "git format-patch" I copied and pasted. Next time I'll remove the indentation manually.
> 
> > > 
> > > diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> > > index 11df0a5e7f7b..a0d7a8db239d 100644
> > > --- a/drivers/staging/vme_user/vme_bridge.h
> > > +++ b/drivers/staging/vme_user/vme_bridge.h
> > > @@ -128,28 +128,21 @@ struct vme_bridge {
> > >  	struct mutex irq_mtx;
> > > 
> > >  	/* Slave Functions */
> > > -	int (*slave_get)(struct vme_slave_resource *, int *,
> > > -		unsigned long long *, unsigned long long *, dma_addr_t *,
> > > -		u32 *, u32 *);
> > > -	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
> > > -		unsigned long long, dma_addr_t, u32, u32);
> > > +	int (*slave_get)(struct vme_slave_resource *, int *, unsigned long long *,
> > > +			 unsigned long long *, dma_addr_t *, u32 *, u32 *);
> > > +	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long, unsigned long long, dma_addr_t, u32, u32);
> > 
> > Did you run your patch through checkpatch.pl after making this change?
> 
> Yes, I did it. No more checks about "Alignment should match open parenthesis".
> 
> > I think you just added more warnings...
> 
> I only focused to solve the checks related to the message above. Nevertheless, there are still other warnings and checks reported by checkpath.pl non-related to this patch (i.e. not caused by this patch) that need to be fixed, but I intend to help to fix them afterwards in a different patch, so I don't send patches with too many changes at once.  

You resolved one warning by replacing it with a different one, that's
not good :(

thanks,

greg k-h
