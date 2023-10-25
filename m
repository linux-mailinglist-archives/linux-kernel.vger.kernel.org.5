Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4FB7D65D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJYIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjJYIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F884184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393AEC433C8;
        Wed, 25 Oct 2023 08:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698224018;
        bh=1F/+JADXLQs6GEIGMuABpZC3o11ZczlIZOgu1f4c3cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbsTAWw2dme6UTqc2lTOQKNtjvWw1Abk33aVmv5VY2f7ZNzWz1sNVIWqVzBTiusbi
         /M0aQsRzW/if9ZhX1BC5y+TQJfEP/Je9C5sk09j/Emj2468W0twkCwNHywBSmh5FzZ
         XffE8rhpfhhxIJq3gTym+iAIdMF8ERKXaV0u+/jc=
Date:   Wed, 25 Oct 2023 10:53:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] misc: phantom: make phantom_class constant
Message-ID: <2023102516-issue-status-60e9@gregkh>
References: <2023102434-font-feast-98e3@gregkh>
 <77bf1ff4-86ca-4fa1-a590-9860a5dcf04f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bf1ff4-86ca-4fa1-a590-9860a5dcf04f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:46:26AM +0200, Jiri Slaby wrote:
> On 24. 10. 23, 13:49, Greg Kroah-Hartman wrote:
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> > 
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> The code:
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> > igned-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> But I am missing ^S here.

Ick, cut-and-paste error, odd.  I'll fix this up when applying it.

thanks for the review,

greg k-h
