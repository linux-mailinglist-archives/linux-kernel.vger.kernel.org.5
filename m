Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006B7D9AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbjJ0OQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJ0OQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:16:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE07C0;
        Fri, 27 Oct 2023 07:16:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE65FC433C7;
        Fri, 27 Oct 2023 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698416203;
        bh=rt6iDJRCHvBEr6OPA/0g+VB2YEYymvC+/8ZKBH0cI2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lwg9oMo88AJIPFjibSHk1yo11rAeMmAxNPLgZ1P3c6vDMHAE+JSG/AxkioM0jGEA7
         M/YnVpLjjs/xH+5e4HMEuJvytFmLg6LrCBfFU5TkSNw9iFlcXUbfVur0NRub5+IR9R
         DvBW3NqSwjoak/rQk4qVBMM2rCUZ/j40bgiT6DGg=
Date:   Fri, 27 Oct 2023 16:16:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     VAMSHI GAJJELA <vamshigajjela@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
Message-ID: <2023102753-headcount-fragrant-c532@gregkh>
References: <20231026135628.2800617-1-vamshigajjela@google.com>
 <2023102712-frolic-bush-3d67@gregkh>
 <CAMTSyjpzrwnbzcjm1nO9Zi7sn7yOGb8sxMjEJGgZoQLgDCx99g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMTSyjpzrwnbzcjm1nO9Zi7sn7yOGb8sxMjEJGgZoQLgDCx99g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:28:12PM +0530, VAMSHI GAJJELA wrote:
> On Fri, Oct 27, 2023 at 12:13 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> > > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > Please use lower case letters like I think you mean to?
> Sure, I will update.
> >
> > Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
> > without them as well.
> 1/3 is dropped:
> https://lore.kernel.org/lkml/CAMTSyjqc118-by6LRHaSN7k8fOcR6K0kmYXdthPD7rqJuYOaVw@mail.gmail.com/
> 2/3 is a clean up:
> https://lore.kernel.org/lkml/CAMTSyjpiz_LVtVAzaNpD-xThtp6sKNy-Uvkr+CaH9b10VRYD9A@mail.gmail.com/
> for 2/3 waiting on response from Ilpo Järvinen

But I see no threading of anything here, please submit things so that we
have a chance to know what is going on.  What would you do if you got a
patch that only said 3/3 to review?

thanks,

greg k-h
