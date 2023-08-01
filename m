Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370E76AA16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHAHfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjHAHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B31BC8;
        Tue,  1 Aug 2023 00:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C265614B0;
        Tue,  1 Aug 2023 07:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DEAC433C7;
        Tue,  1 Aug 2023 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690875301;
        bh=nDYOW8cnkgStxoV8umgfFMfJVIByEnVT4YWAkNqEMRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yd3DVh+SKvwX2t6iV31hhZGku6kDP5Yua0oqViHooDkKT1/yKCbxG8TgWFEG8ckYl
         dXBIBObQIhBPBbSYLmfipN2n5JiwRwpE6kGBkaTbJtYSb9E8j0O1vDOJl/bWzHGsDx
         kxP0n5QLsdFm2JWhxUM3WX4fECIh6TIebTFxZzvU=
Date:   Tue, 1 Aug 2023 09:34:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chengdong zhou <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <2023080152-bakeshop-shanty-2033@gregkh>
References: <20230801045449.156348-1-zhouscd@gmail.com>
 <2023080159-uncorrupt-chamber-7de0@gregkh>
 <CAN4mUXNNM-25oCx1jjVqqoPpX1P8Z4zkjh84Azprz52O4_AMNw@mail.gmail.com>
 <2023080108-resilient-citation-9a34@gregkh>
 <CAN4mUXNZomVDfve1p_2D6G38MXd=gWLdg3=eSUMnFcWhcyb2EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4mUXNZomVDfve1p_2D6G38MXd=gWLdg3=eSUMnFcWhcyb2EA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:27:04PM +0800, chengdong zhou wrote:
> Thank you for your patient response.
> 
> On Tue, Aug 1, 2023 at 2:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> >
> > Please document this in the changelog text.
> 
> But I can't find the changelog text anywhere.

That is what you are writing here for the commit.  Please read the
kernel documentation for how to submit a patch, it will explain this.

> > But you changed the name:
> >
> > > > > -     ss->function.name = "source/sink";
> > > > > +     ss->function.name = "sourcesink";
> >
> > isn't that visable to userspace?
> 
> Yes, I removed the "/". Because the macro definition
> DECLARE_USB_FUNCTION_INIT does not support "/".
> Should I stick with the original "SourceSink"? I think using the
> Linux-style "sourcesink" is better. By the way, due to the current
> bug, no one should be able to use "source/sink" in userspace.

But doesn't the '/' mean that you have a subdirectory here?  What did
userspace look like before this, and what does it look like now?

thanks,

greg k-h
