Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEDC7BA5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjJEQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjJEQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE147101BE;
        Thu,  5 Oct 2023 07:17:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0442CC3277E;
        Thu,  5 Oct 2023 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696502444;
        bh=zG4Uy0wbVjgN17aTIqGgXL6FFxktGI57Cl5UBJTqWsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdyW1v9SF2VgC9a4TmbOmocRzolbrpxmNVkrE9kfIn+MQ5QJdbLKT21p1AnOscccW
         Z9TDm3eRJfphN5+Ivz9zfR4cUetq8CHk/PfFUVEqD9rrzlBep1u/TkG5Oc/6YOg3Hx
         qbGyY9/pl/m+BpEW6XreGIHUIo7gzyDWuPPMTsuE=
Date:   Thu, 5 Oct 2023 12:40:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Florian Eckert <fe@dev.tdt.de>, Jiri Slaby <jirislaby@kernel.org>,
        Eckert.Florian@googlemail.com, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
Message-ID: <2023100524-liftoff-obnoxious-ec1e@gregkh>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de>
 <20231002140559.GB8453@google.com>
 <acda5dc4-e6d3-4870-929f-fb91636b5649@kernel.org>
 <59cc4073a94edbdec5d77f8457ed4f73@dev.tdt.de>
 <05b03f3e-5863-4d33-8c70-03be7d7e972f@kernel.org>
 <d59855493baa936485a2b00aa29d0449@dev.tdt.de>
 <2023100508-prelaunch-marbled-3a93@gregkh>
 <20231005101307.GE83257@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005101307.GE83257@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:13:07AM +0100, Lee Jones wrote:
> On Thu, 05 Oct 2023, Greg KH wrote:
> 
> > On Wed, Oct 04, 2023 at 10:36:09AM +0200, Florian Eckert wrote:
> > > 
> > > 
> > > > > I decided to move the variable definition with a separate commit
> > > > > to the top of the function, to make the build robot happy. After that
> > > > > I made my changes for v2 to the ledtrig-tty to add the feature.
> > > > > 
> > > > > > Ah, lkp, then also the Closes: line as it suggests.
> > > > > 
> > > > > Sorry I do not understand your statement
> > > > 
> > > > The link you pasted above states:
> > > > =======
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new
> > > > version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
> > > > =======
> > > > 
> > > > So please follow that suggestion ;).
> > > 
> > > Ok, I understand, thanks will to this on a v3 patchset.
> > > I will now wait for the comments of my changes in ledtrig-tty from the led
> > > subsystem.
> > > And then I will send a new patch set with the requested changes.
> > > 
> > > Sorry for the silly question. But do I have to send this patch again for a
> > > v3?
> > > https://lore.kernel.org/linux-leds/f41dc1e1-6d34-48b2-97dd-ba67df6003c6@kernel.org/T/#u
> > > It was already marked by you with a `Reviewed-by:` from you?
> 
> Yes please.  I will pick this up as a set once it's ready.
> 
> > This series is long gone from my review queue, so a v3 will be needed at
> > the very least.
> 
> Nothing for Greg to worry about here (unless you *want* to review).

Yes, I want to ensure that the tty change is correct, last round I
didn't think it was...

thanks,

greg k-h
