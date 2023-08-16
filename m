Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2152077D931
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjHPDnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbjHPDnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:43:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCED106;
        Tue, 15 Aug 2023 20:43:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b2884bec8so3256363a91.0;
        Tue, 15 Aug 2023 20:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692157401; x=1692762201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MG/LBLNC/1jL+k5aZb0NuJseJ3XI84wzhjQpnVkoLg=;
        b=VibyU1Vcjg0kPPMn4/ped/KjnfhOwlVJC1qeW70G9tEUPErBv65Ji5UPiPW1xJ/Oup
         84PR44d7K0uFULM/5WJG7VOWElYxYWsUxuP5vMCV39ubOoO8pfYiottuAdbLVWrbiTeq
         ac3XmKzweo8rlX95YTgy0WaGm8lGgj7qqGPOKT0IldOehBMPyNXINzq7jnUDUVxFoSEJ
         WfsKXuxtyQ/Dyd3TDTjeypKsfNIh3N+/OLFzqni7tZdsP7pCTF+bo0haqhZqivfTxwSi
         ykCcA9YEtsdL2tAfrpVAfLkpg630YTQrXRyqFN9dV7JeUAlediyuu99Dd0CrJ6RT5bzN
         DywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692157401; x=1692762201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MG/LBLNC/1jL+k5aZb0NuJseJ3XI84wzhjQpnVkoLg=;
        b=Bo3wcPeWic8SiYnauAB/LVpRkZETdin7u0/20t0UOMW5JkhR2qElTvSS8EWpPuXSg9
         apVNEeHv//I71ubTkLI3ZjUTpCNlFs/kqIZuvLb6tLuotoPw2KhNvY/QwVqr0XhXmMoo
         j1pMOdD1Ltc8Ymu8MX/ma5QG18liOcYMqAK08AKgahh19YcNAQFGMoC5fvxanENFBnk8
         UJ7WX1Jzl9FSPdeeEHMPDCc622E8cWbxSSJBfgauyWf1/qXAvp4Xiaa8TIRDHd3zPtX6
         7Fr64A7zsXbjsc0Qcra7l7o1TDFWotbJJtK7ENamNayrGrZSfRMoldZaQswSFFMi5qoy
         mr0w==
X-Gm-Message-State: AOJu0YxylsaFkAdFPcnVNOdSFZEfFVN3CN9aVr+Z26WM7OY+10ebgLZ2
        GF1mItx4f8dG+ofF7RHE7PE=
X-Google-Smtp-Source: AGHT+IGFv8x8MzsU1NkdJe3UFhKVzn9SwPupCmDsTd9ooLwptPiJUbA88CqN/bk3B7yKSs3SxzW09g==
X-Received: by 2002:a17:90b:1013:b0:269:46d7:f1db with SMTP id gm19-20020a17090b101300b0026946d7f1dbmr466664pjb.32.1692157401277;
        Tue, 15 Aug 2023 20:43:21 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:83df:3d7d:2a60:5498])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a005700b00268b9862343sm12941311pjb.24.2023.08.15.20.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:43:20 -0700 (PDT)
Date:   Wed, 16 Aug 2023 09:13:13 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     richard.leitner@linux.dev, wsa+renesas@sang-engineering.com,
        mhocko@suse.com, surenb@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] drivers: usb: Removes use of assignment in if
 condition
Message-ID: <20230816034313.GA57824@atom0118>
References: <20230815204141.51972-1-atulpant.linux@gmail.com>
 <2023081550-absurd-sprint-65e5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081550-absurd-sprint-65e5@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:07:02PM +0200, Greg KH wrote:
> On Wed, Aug 16, 2023 at 02:11:41AM +0530, Atul Kumar Pant wrote:
> > This patch fixes following checkpatch.pl issue:
> > ERROR: do not use assignment in if condition
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  drivers/usb/core/devio.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > index e501a03d6c70..56899fed6bd4 100644
> > --- a/drivers/usb/core/devio.c
> > +++ b/drivers/usb/core/devio.c
> > @@ -2333,9 +2333,10 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
> >  		}
> >  	}
> >  
> > +	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
> >  	if (ps->dev->state != USB_STATE_CONFIGURED)
> >  		retval = -EHOSTUNREACH;
> > -	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
> > +	else if (!intf)
> 
> Did you mean to change the logic here by doing the calculation always?
> Does that change functionality?
> 
	Now the calculation of interface will be done always, which can be
	redundant. But this would not change the functionality.

> The existing code is fine, running checkpatch on code outside of
> drivers/staging/ or on new patches you are writing, is generally
> discouraged as the code usually is older than checkpatch is :)
> 
> thanks,
> 
> greg k-h
