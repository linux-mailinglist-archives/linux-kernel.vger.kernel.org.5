Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A37D1EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjJUSGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:06:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5132BCF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:06:42 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2f5aed39cso1330518b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697911601; x=1698516401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUzqqyc66JMYlS7ayqT1z7znMFxZmcvmwm8m+LXNCLI=;
        b=fw7LVCbq7C2nrPK+hz99B3pVMBUhNI8uxT8Ww5fIFodMrilQnrxoj9Boir5J8JjREq
         RnX1CjH/PrsViVva1//rxXi7+wB8pEcREpfLIhAUQMIzGDQPr9BmaGOolRFqdsaGcuoj
         SnqV2syHsLlhMecJfChatvCcQ6vvQk3Wgv7jMsP6PGFfP2NNeSeu17Yb1hjWDASd5a6a
         JBP7+56WAdP/Aj+nElW25dtVz9Ks1I2w0GivbMB4/eBOQBGkAB+716DZWHKLpbW+1pY2
         TxQvEX1U2sxPi/74+MPaD9db/qPJIRCbRCe20CR12l/BIaPyOY+3NRTRbOb4H8lPsz6E
         cy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697911601; x=1698516401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUzqqyc66JMYlS7ayqT1z7znMFxZmcvmwm8m+LXNCLI=;
        b=FfP0aHSZ5JVOLAM/8QPJpt26Ec4ewd+TsJpGcbOcPzeCHk9vNJ9ttRpfGFKcQsn9V2
         3CDQNimUbVmNJ5NNHdUWyq5jHEsdulP/pvaV6EmlTorhYhr3zFe9QaFR6uvgHYufZbfh
         DMth7gyIvVFA4IDW6rWXthFtkHlpfn1JA9rkZsR87xVeyBUTSlKZ6U/T2WFlXXQJblXK
         tyMApYrx8Qub+BrAtiP5Qm/6A+TWqBri7KQxC9L3iTxA+PK8618cM6qevwVYQu5oPwsB
         +Ogt0xH7+mhW4RZxsTD6t8jv71nmCuHHT0yJnhMYjwv09+O+fnwXl1xCiDt6+fkuP56B
         T66w==
X-Gm-Message-State: AOJu0YzjgarsWi4dX82umWvP8ue0Qk3Wfl+pJgJZFE4tazrXizu3jeIi
        SXARi9oxutrLuNohvcW0F6s=
X-Google-Smtp-Source: AGHT+IFV9OUT+QBGHAwcURd/bz/8xcbxn3EgnWhtBo6XXAGKsF9WmQhMZLZtFmiSxwIPRFhIHC4ByA==
X-Received: by 2002:a05:6808:222a:b0:3b2:e9ab:68e6 with SMTP id bd42-20020a056808222a00b003b2e9ab68e6mr7246790oib.0.1697911601268;
        Sat, 21 Oct 2023 11:06:41 -0700 (PDT)
Received: from ubuntu ([122.167.9.184])
        by smtp.gmail.com with ESMTPSA id d15-20020a65620f000000b0057e7ae47893sm2945165pgv.47.2023.10.21.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 11:06:40 -0700 (PDT)
Date:   Sat, 21 Oct 2023 11:06:34 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Message-ID: <20231021180634.GA17039@ubuntu>
References: <20231021133527.GB12776@ubuntu>
 <2023102147-educator-worry-06f4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102147-educator-worry-06f4@gregkh>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 04:45:46PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 21, 2023 at 06:35:27AM -0700, Nandha Kumar Singaram wrote:
> > greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
> > linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
> > Bcc: 
> > Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
> > Reply-To: 
> > In-Reply-To: <2023102131-slacker-lily-28ff@gregkh>
> > 
> > On Sat, Oct 21, 2023 at 11:48:32AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 19, 2023 at 02:39:49PM -0700, Nandha Kumar Singaram wrote:
> > > > Adhere to linux coding style. Reported by checkpatch.pl:
> > > > CHECK: Alignment should match open parenthesis
> > > > 
> > > > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > > > ---
> > > >  drivers/staging/greybus/camera.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > > > index cdbb42cd413b..405c8e78aa72 100644
> > > > --- a/drivers/staging/greybus/camera.c
> > > > +++ b/drivers/staging/greybus/camera.c
> > > > @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> > > >  }
> > > >  
> > > >  static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > > > -		struct gb_camera_configure_streams_response *resp)
> > > > +				      struct gb_camera_configure_streams_response *resp)
> > > >  {
> > > >  	unsigned int max_pkt_size = 0;
> > > >  	unsigned int i;
> > > > @@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > > >   * Validate the stream configuration response verifying padding is correctly
> > > >   * set and the returned number of streams is supported
> > > >   */
> > > > -static const int gb_camera_configure_streams_validate_response(
> > > > -		struct gb_camera *gcam,
> > > > +static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,
> > > 
> > > Why change this line?
> > >
> > did these Code change to fix CHECK: Lines should not end with a '(' reported by
> > checkpatch.pl
> 
> That's great, but you didn't say that in your changelog text, so it
> looks wrong here :(
> 
> thanks,
> 
> greg k-h

Sorry for missing that, will add and send the updated patch.

Regards,
Nandha Kumar
