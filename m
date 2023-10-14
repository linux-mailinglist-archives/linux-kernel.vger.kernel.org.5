Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7B7C95F1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjJNS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjJNS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C3BF;
        Sat, 14 Oct 2023 11:29:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA2C433C8;
        Sat, 14 Oct 2023 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697308141;
        bh=P55dAfEs/20Vf0fIuHNJBIzfdHgwpTlHxlsWxHeJ+ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYyuF2C99XfL9TrmzG/Q4fy3L6hu/njrAD2ce6hlCcqMLsWHmzENT4ZSbnGLRkYxt
         A0hlqxTd38QZXhK4929QpyxdeGAM8R3BAiza9PBq5vOoZQZuMys3PDkaznv7c3L4vw
         /OfWXEjuzRU9Fs2Kad3cKBluDTbSn4C/g4Z42BQk=
Date:   Sat, 14 Oct 2023 20:28:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/7] tty: 8250: Fix IS-200 PCI ID comment
Message-ID: <2023101411-disarray-olive-afc3@gregkh>
References: <DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <2023101431-online-sharpness-84d1@gregkh>
 <DU0PR02MB7899E040B68084B59972EC66C4D1A@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899E040B68084B59972EC66C4D1A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 12:56:31PM +0100, Cameron Williams wrote:
> On Sat, Oct 14, 2023 at 10:28:33AM +0200, Greg KH wrote:
> > On Fri, Oct 13, 2023 at 11:11:09PM +0100, Cameron Williams wrote:
> > > Fix the PCI comment for the IS-200 card
> > 
> > "Fix" it how?  What was wrong with it, and what is now right with it?
> >
> I should have specified better, my mistake. The PCI ID comment (135a.0811)
> is incorrect, the card ID itself is 0x0d80 and the definition used
> (PCI_DEVICE_ID_INTASHIELD_IS200) is indeed 0x0d80. It's just a cosmetic change
> as the rest of the IS range of cards are also being added in this series and their
> IDs are all 0x0020 offset from each other (though the IS-300, 0x0da0 is in a
> parport_serial patch). Makes no functional difference.

Please put that info in the changelog text when you send your next
version.

> > > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> > > ---
> > > This is a resubmission series for the patch series below. That series
> > > was lots of changes sent to lots of maintainers, this series is just for
> > > the tty/serial/8250 subsystem.
> > 
> > Your patches here are not threaded at all, was that intentional?  Our
> > tools will not pick them up properly, and so I would have to do it by
> > hand, slowing things down and making me dread handling them.  Any reason
> > you didn't just use 'git send-email' to send it?
> > 
> This was not intentional, no. I had problems getting git send-email set up,
> somthing to do with TLS issues and since Mutt was already set up for general
> email, I chose to use that instead for convenience. I can look into getting
> git send-email working and re-sending this series as v3 if you want the
> series threading properly.

You can use mutt to thread things, you need to do it "by hand" with
mutt, that's what I used to do all the time before git send-email was
created (it's based on some old scripts of mine.)  But I would recommend
setting up git send-email if you want to send lots of patches over time.

thanks,

greg k-h
