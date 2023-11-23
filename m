Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C77F5A85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjKWIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:51:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4CA3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:52:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8895BC433C7;
        Thu, 23 Nov 2023 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700729526;
        bh=DBtWK3+4bTYvqhR6xwdSm2zuTXXKyTcaPF4a3vAo4Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJMrc7/dELHegU6ys8Q9xNaHPwau7uBCLn6rsF+qCD+JTomT6cSouvQ5Lk2OamqAF
         s5YDFYEvpMJgFwTo7i9tx8F8ZknIk6vZK4F2a9BsDAqa8UcELizInMXzMByX5uAXR5
         79bPHk+oJqaxd3H1FVY5Y9mnEPbYnDy3Xk9kRLZY=
Date:   Thu, 23 Nov 2023 08:52:02 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roy Luo <royluo@google.com>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] USB: gadget: core: adjust uevent timing on gadget
 unbind
Message-ID: <2023112339-deeply-curve-034f@gregkh>
References: <20231122220001.539770-1-royluo@google.com>
 <2023112253-fresh-blazing-baae@gregkh>
 <CA+zupgzWqhOhAR0_ybxTQVL928dgAqbm5eqJ6gd-0qrNK7VZng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+zupgzWqhOhAR0_ybxTQVL928dgAqbm5eqJ6gd-0qrNK7VZng@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Nov 22, 2023 at 03:13:20PM -0800, Roy Luo wrote:
> The logic is there since day 1 of udc in Commit
> 2ccea03a8f7ec93641791f2760d7cdc6cab6205f (usb: gadget: introduce UDC
> Class). Do you still want me to put on a fix tag?

Yes please, and do you want this backported to all older stable kernels?

thanks,

greg k-h
