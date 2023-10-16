Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745397CB334
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJPTLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjJPTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:11:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20EAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:11:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973E2C433C7;
        Mon, 16 Oct 2023 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697483484;
        bh=qIFRNM4cDuT1Q1eOEvtfGUbW7G3DmFKEOJnyvV3javM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOdW3m9WTHj4jWlN4nz4nH6CxEPO3VmO5JITIf2hPdwaH0WDnwXfsIhUDh7Mtzon/
         0Z7FmAl104+/tdVG3jLEL4zOLbPDU9dFhD4MjlP/nsp9bFmkFW1rQnJXcRRvc04FNC
         jpo3iqI7JCifW97dNtAUaH4ahhl9BQfv+7f7bKW0=
Date:   Mon, 16 Oct 2023 21:11:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: patch "misc/pvpanic: deduplicate comomn code" added to
 char-misc-testing
Message-ID: <2023101646-armoire-thing-64e4@gregkh>
References: <2023101657-charcoal-snowy-21be@gregkh>
 <19f56fba-7ed5-4bc3-9ba5-37f4ab6e1857@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19f56fba-7ed5-4bc3-9ba5-37f4ab6e1857@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:06:39PM +0200, Thomas Weißschuh wrote:
> Hi Greg,
> 
> On 2023-10-16 20:57:57+0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     misc/pvpanic: deduplicate comomn code
> 
> It seems I managed to inject a typo into the commit subject:
> 
> s/comomn/common/
> 
> In case it's still possible and worth it, could you fix it up?

Nah, it's not worth rewriting history because of it.  Unless the 0-day
bot finds problems with the tree, I'll just leave it as is.

thanks,

greg k-h
