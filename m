Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FCB7D1D90
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjJUOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjJUOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:45:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB6D65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:45:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCCC433C8;
        Sat, 21 Oct 2023 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697899550;
        bh=CMHx6vpJK1A9SfM1ishkO5D8JuHrp8FLmjMYTmtAGJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xd/Y37OOKMmkC3ADllgJhPbvwtQV1DosWbWSAnZPL+0bXGX7KyzWi0T5nvz83nBsb
         XkaeNt8MWUKkNE35m207msxkKHaD9xEEz3tLvfXYnncqMn16FnvQYsp3utf5+n62t8
         tbSWzbjoVIJtYr56FrhHdBUioroBHUC0azCzDqNk=
Date:   Sat, 21 Oct 2023 16:45:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Message-ID: <2023102147-educator-worry-06f4@gregkh>
References: <20231021133527.GB12776@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021133527.GB12776@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 06:35:27AM -0700, Nandha Kumar Singaram wrote:
> greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
> linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
> Bcc: 
> Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
> Reply-To: 
> In-Reply-To: <2023102131-slacker-lily-28ff@gregkh>
> 
> On Sat, Oct 21, 2023 at 11:48:32AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 19, 2023 at 02:39:49PM -0700, Nandha Kumar Singaram wrote:
> > > Adhere to linux coding style. Reported by checkpatch.pl:
> > > CHECK: Alignment should match open parenthesis
> > > 
> > > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > > ---
> > >  drivers/staging/greybus/camera.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > > index cdbb42cd413b..405c8e78aa72 100644
> > > --- a/drivers/staging/greybus/camera.c
> > > +++ b/drivers/staging/greybus/camera.c
> > > @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> > >  }
> > >  
> > >  static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > > -		struct gb_camera_configure_streams_response *resp)
> > > +				      struct gb_camera_configure_streams_response *resp)
> > >  {
> > >  	unsigned int max_pkt_size = 0;
> > >  	unsigned int i;
> > > @@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > >   * Validate the stream configuration response verifying padding is correctly
> > >   * set and the returned number of streams is supported
> > >   */
> > > -static const int gb_camera_configure_streams_validate_response(
> > > -		struct gb_camera *gcam,
> > > +static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,
> > 
> > Why change this line?
> >
> did these Code change to fix CHECK: Lines should not end with a '(' reported by
> checkpatch.pl

That's great, but you didn't say that in your changelog text, so it
looks wrong here :(

thanks,

greg k-h
