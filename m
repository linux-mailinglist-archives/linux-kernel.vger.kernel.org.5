Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B907D1D33
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjJUNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjJUNFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 09:05:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE9D67
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 06:05:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so1037878a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697893540; x=1698498340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5f1f0vQfSjdVi/REtt5j0YQgF8soTdJTFMLk1PEhnc=;
        b=ULVlNpNRXtYfnzcqDaNCStHMVOUjItdbiSDG8nxhcKE14iQycXLHGySneOVMxMCRdt
         v613SHVVDFyR/J2/Eu1gfuzwI7bHfDH/lzXkfEDVEphyKFI8peK5Bi5vsYL9dBpxdkzp
         PVgjPVwSpzxHImeD2qWSYTXjELQ0bIIgbMCpzRZECc6sOiEhzN/aqtFfefjaYA6dJBOK
         TWGa6HTwlG7+Gnhzlk2aPfS0iS67MttUCpSv9ZymeLXH7o27xXgkoCeZZBwiB5nt+ofk
         ytx3uUehKSivTjXSkDm8zSogFXZbzwu0c+w0QuXleg8utu6MwUxNLN69K46+VFYOnZeY
         DMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697893540; x=1698498340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5f1f0vQfSjdVi/REtt5j0YQgF8soTdJTFMLk1PEhnc=;
        b=Jkz1ewrMFip7794Yixh/QpGTVyLOQhZ8Dz4RQ6XROUUZEriEGh9O/2UV7uJNd1QJ2a
         bQ7veioHZH8vbNzyECVfzbm1cGT1Qe158vj4Z3LMOzH21VfsX7LbKaBQ7vZpNwJj1MW7
         UHMBQFGpg2rQZYiBst2QAf1ksJOhr0VeXP9mc4OZP6htJ8h+aKgp3RRi1eNLTYQUu9nk
         JomiZ6q7OWWJCAdurovG9i2gbD4ttmn7MF718iykYiraPRZCufAR8mjzlGErV/9bF5Ar
         D9Tzc8E4xPYIiKGNtPkyyIRlzRQccZEwo3jZSF2eu01N50zAEzqFBDZbT0HTvzp73f0R
         hqUw==
X-Gm-Message-State: AOJu0YwD5Eid0RQif2NUDQ5M/rRo0Evbj74wux1Kif/Vrao2iN+cv1Qg
        v0nAbMz7Ihc5Sg4V1XaJyss=
X-Google-Smtp-Source: AGHT+IFHYGt3bF0G2tCnQmvxBHxEud8YIBJqmnRa57y5tilld1MEtDW8BNCG6blbLAEA1bLsnbhCeQ==
X-Received: by 2002:a17:903:2012:b0:1c5:bea4:8537 with SMTP id s18-20020a170903201200b001c5bea48537mr2867431pla.15.1697893540382;
        Sat, 21 Oct 2023 06:05:40 -0700 (PDT)
Received: from ubuntu ([122.167.9.184])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001c9c8d761a3sm3130187plx.131.2023.10.21.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 06:05:40 -0700 (PDT)
Date:   Sat, 21 Oct 2023 06:05:35 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Message-ID: <20231021130535.GA12776@ubuntu>
References: <20231019213949.GA2922@ubuntu>
 <e24e41be-b2c4-4bda-8a34-a628c55c4061@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e24e41be-b2c4-4bda-8a34-a628c55c4061@ieee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:15:37PM -0500, Alex Elder wrote:
> On 10/19/23 4:39 PM, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > CHECK: Alignment should match open parenthesis
> 
> Sometimes checkpatch.pl warns about things that are not
> really that important.  One class of this type of issue
> is white space errors.
> 
> Yes, consistency is good, but the kernel simply doesn't
> have universally consistent conventions, and I doubt
> it ever will.  There might be times where a source file
> consistently follows a white space convention that
> differs from what checkpatch wants.  Suggesting a
> wholesale change to that file to "fix" that typically
> wouldn't be welcome.
> 
> Unfortunately without some experience it's hard to know
> which checkpatch warnings can be safely ignored.  I would
> place white space warnings at a lower priority for fixing
> than some others.  For example, this is also a pretty
> trivial warning:
>   CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid precedence
> issues
> And it is most likely not a problem in this case, but fixing
> this type of warning is probably more constructive than
> just adjusting white space.
> 
> I have no objection to your patch, and it's a fine way to
> get some experience with the patch process, but I don't
> think this particular change is necessary.
> 
> 					-Alex
> 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > ---
> >   drivers/staging/greybus/camera.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > index cdbb42cd413b..405c8e78aa72 100644
> > --- a/drivers/staging/greybus/camera.c
> > +++ b/drivers/staging/greybus/camera.c
> > @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> >   }
> >   static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > -		struct gb_camera_configure_streams_response *resp)
> > +				      struct gb_camera_configure_streams_response *resp)
> >   {
> >   	unsigned int max_pkt_size = 0;
> >   	unsigned int i;
> > @@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> >    * Validate the stream configuration response verifying padding is correctly
> >    * set and the returned number of streams is supported
> >    */
> > -static const int gb_camera_configure_streams_validate_response(
> > -		struct gb_camera *gcam,
> > +static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,
> >   		struct gb_camera_configure_streams_response *resp,
> >   		unsigned int nstreams)
> >   {
> > @@ -378,8 +377,8 @@ struct ap_csi_config_request {
> >   #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
> >   static int gb_camera_setup_data_connection(struct gb_camera *gcam,
> > -		struct gb_camera_configure_streams_response *resp,
> > -		struct gb_camera_csi_params *csi_params)
> > +					   struct gb_camera_configure_streams_response *resp,
> > +					   struct gb_camera_csi_params *csi_params)
> >   {
> >   	struct ap_csi_config_request csi_cfg;
> >   	struct gb_connection *conn;
> > @@ -783,8 +782,9 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
> >   }
> >   static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
> > -		unsigned int *flags, struct gb_camera_stream *streams,
> > -		struct gb_camera_csi_params *csi_params)
> > +					  unsigned int *flags,
> > +					  struct gb_camera_stream *streams,
> > +					  struct gb_camera_csi_params *csi_params)
> >   {
> >   	struct gb_camera *gcam = priv;
> >   	struct gb_camera_stream_config *gb_streams;
> 

Thanks Alex for the review and feedback.

Regards,
Nandha Kumar
