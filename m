Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159577C9375
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjJNI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:28:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71CB7;
        Sat, 14 Oct 2023 01:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E0C433C8;
        Sat, 14 Oct 2023 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697272115;
        bh=73iGjLxlWpP3HizUIyxcvqRRSy4ifHBtDf4+f51kmbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBOEzDkg3Q+8/XFxLYOxBtKIAqKKVoObBjXhJJz2/uf/6ATvFiiBraMIWCqoeSykD
         XmH24fs6DzcyZO/eSESYyfQuuNpDQm3Z0IFZAetkgIz2N22AbypCk1vFjuIEhXJLRW
         3Q9HxfJQGdt/rpElZpZnt1D3NhOtzi2EGR66K4cQ=
Date:   Sat, 14 Oct 2023 10:28:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/7] tty: 8250: Fix IS-200 PCI ID comment
Message-ID: <2023101431-online-sharpness-84d1@gregkh>
References: <DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 11:11:09PM +0100, Cameron Williams wrote:
> Fix the PCI comment for the IS-200 card

"Fix" it how?  What was wrong with it, and what is now right with it?

> 
> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> ---
> This is a resubmission series for the patch series below. That series
> was lots of changes sent to lots of maintainers, this series is just for
> the tty/serial/8250 subsystem.

Your patches here are not threaded at all, was that intentional?  Our
tools will not pick them up properly, and so I would have to do it by
hand, slowing things down and making me dread handling them.  Any reason
you didn't just use 'git send-email' to send it?

thanks,

greg k-h
