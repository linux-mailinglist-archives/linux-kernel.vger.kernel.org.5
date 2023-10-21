Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0A7D1D42
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJUNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 09:35:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF635E7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 06:35:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9bca1d96cso12108365ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697895332; x=1698500132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsKAD0VhAPmzCctVVdKp45X+1iQVX0c5X8MLMjRCHgY=;
        b=BrysBMenvLDCyW6/kLl3sOFfzzJZsKTQRGJwsJZaNo4evt/cZ0k2ZVt9qPakD4VBv6
         myTc3BYKFV1t8XFJ8qu5ThNDyRdZ7XhksH6i5LG7dLQ5NVHfllZqLw/bESOjN5acurNS
         xvstAiROJR/BnqBjUvhbp41INkouUs8kL4qAQy+vR+0YBsGUxijBBU13lIdu/SQ6wGFU
         2bTxTh6B+0/SoHd/OqJA+lKW2FCKJ8zYB0D6Ady+jq5JTesAX66Yk2dbNbNMwqt1g43/
         VwlqZRb+zO7l7EcEMlA4klWyS/Smbl+mXXwS+ExZ6gP+LpoE4YAIkZHrERuubjZzSFCJ
         Bh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697895332; x=1698500132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsKAD0VhAPmzCctVVdKp45X+1iQVX0c5X8MLMjRCHgY=;
        b=uuHmi9eJI4q1UJZ8UTVviXHHge3HhlcKcl92BZp6UPxeyyZ+x25qu6cyBA0MhUBcs/
         Z7JsFwUtr7QkSWNPT4NprSehoJcnxS2vhLvEORJJd+MEJ23T6ycETFXmO+zm1Wo+b8Hl
         YHc9tzKdsjnChWj/mEPH4hcCOHxohDJ/FMpbFh8CcYN0zitdbaVRLkAoeImLlUwQV2Dy
         XeHSdM2OY1au6vhF2/w8ipHlFCBqXYfU9KQQ5mfNmJchNW6Vjsc07I0j7NRmnUo8IaNH
         4s+aKQS5Mcw54pPWgT55NJP2il7CoyFWzVcCzFI85lTIM86NbeBHcntp7b+BD+9oQOS/
         vpgw==
X-Gm-Message-State: AOJu0YwydLrhTp3KLrRrlbMq5XNMr8tQYb3XOOInlp6EVLYw7288SyxM
        +XcwMPx16Ij2skv0DGKHfmzR3ytXcnYtFw==
X-Google-Smtp-Source: AGHT+IG7/tbMEfdamoXp/VmbamxwRPF/ONl8l/tI/NBlmfVZMDJBEwW89HUUGTHoMHhSas3xIs2Njw==
X-Received: by 2002:a17:902:e744:b0:1c9:d3ce:e7d3 with SMTP id p4-20020a170902e74400b001c9d3cee7d3mr4144528plf.4.1697895331941;
        Sat, 21 Oct 2023 06:35:31 -0700 (PDT)
Received: from ubuntu ([122.167.9.184])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090311cd00b001ca773d674bsm3175577plh.278.2023.10.21.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 06:35:31 -0700 (PDT)
Date:   Sat, 21 Oct 2023 06:35:27 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Message-ID: <20231021133527.GB12776@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Bcc: 
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Reply-To: 
In-Reply-To: <2023102131-slacker-lily-28ff@gregkh>

On Sat, Oct 21, 2023 at 11:48:32AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 02:39:49PM -0700, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > CHECK: Alignment should match open parenthesis
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > ---
> >  drivers/staging/greybus/camera.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > index cdbb42cd413b..405c8e78aa72 100644
> > --- a/drivers/staging/greybus/camera.c
> > +++ b/drivers/staging/greybus/camera.c
> > @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> >  }
> >  
> >  static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > -		struct gb_camera_configure_streams_response *resp)
> > +				      struct gb_camera_configure_streams_response *resp)
> >  {
> >  	unsigned int max_pkt_size = 0;
> >  	unsigned int i;
> > @@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> >   * Validate the stream configuration response verifying padding is correctly
> >   * set and the returned number of streams is supported
> >   */
> > -static const int gb_camera_configure_streams_validate_response(
> > -		struct gb_camera *gcam,
> > +static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,
> 
> Why change this line?
>
did these Code change to fix CHECK: Lines should not end with a '(' reported by
checkpatch.pl

> It's fine, but then:
> 
> >  		struct gb_camera_configure_streams_response *resp,
> >  		unsigned int nstreams)
> 
> These lines are not fixed up?
> 
> thanks,
> 
> greg k-h

Fixing these lines results in another checkpatch check(CHECK: line length 
of 113 exceeds 100 columns) so didn't added any change

Thanks,
Nandha Kumar
