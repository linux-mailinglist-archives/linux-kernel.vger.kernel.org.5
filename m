Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6E77D24B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbjHOSpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbjHOSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:45:12 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F50B2112;
        Tue, 15 Aug 2023 11:44:35 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-447abb2f228so2077237137.0;
        Tue, 15 Aug 2023 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692125074; x=1692729874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mr89f7jlVGVNCiS1wFJrPscC+n1hf6qGfxlXNpoD46A=;
        b=WMAQvCeiTFAjlOFLgFleqIQX7ucLCx4JlbR26BMfSLYqCBaYnmPSnQHOS5g9Rpq4fX
         MOkachJJHldDF4XpEiJ34S3tPw8N61k4csG52/sWSTNVNOex7xc5jiOcHhjmX3j46d17
         KDbZWz6dbZR3H0gpKxTc5naXTvIYiy14eLzi9g/eFBxJy16zvjMVaaEWW5O9GujFqRwW
         A/A6WaYPW7QK9labOqQ5/jLSbsIQcsl8KKniP5Kz1p3kI+GqLs7leXzD0m909vK0bogb
         wNaga3fvdYMqbim9NcMkMcrrbzCtVXDgA6uo18ZaCvQgs0dBd3xRzwC361OPcyacgOZN
         GRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125074; x=1692729874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr89f7jlVGVNCiS1wFJrPscC+n1hf6qGfxlXNpoD46A=;
        b=N9uIk9pQSIwAqNRi5YptQGBM+U5Fsjo8t80evGcvCjl33w1AClozO2Yhp7i4s7qUgW
         GSTjXjJcWqPFdf2qXIwcGkloQrxuJtSg2zhJQOlRf5BhSkjOxX+TsuibrJDw/0G4MOZJ
         s3CfQR0KF/QcmEFGgq7ROQYXnyJIOEsyZzXMHr8oEEVtMetUNfOk3+tQhEzhN4edcsdc
         4A622/kW7+R6IOPvke6c3MWxnU90sC0/V25HGyEB6hob1GPWkFDFde0SFjVZDAbj/tGA
         90+K9Qq5+1y6eiNvqxFePeqVVk+QrIOFjbSLDLLh+FQtlw7r/X4DRHmd51KvZvmbCwX0
         YvvA==
X-Gm-Message-State: AOJu0YzN70pJ3pgthgbIbIBXD0UAlD6KaljkJiHJoRe67B6KjSWEOwmL
        ePTCsQwyjOGB/Bn8a8Ib0vEl/qujoyp0Vg==
X-Google-Smtp-Source: AGHT+IGQDjfmkVlbrf2M9Fn/0we+GLd6kPwKwgcfcbJC9Id9MA/LoYhbuwY+Z1gF2f/sQh6DXh93aw==
X-Received: by 2002:a67:fc94:0:b0:445:872:67ea with SMTP id x20-20020a67fc94000000b00445087267eamr13341344vsp.34.1692125074023;
        Tue, 15 Aug 2023 11:44:34 -0700 (PDT)
Received: from abdel (bras-base-ktnron0692w-grc-13-174-95-13-129.dsl.bell.ca. [174.95.13.129])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cd983000000b0063d152e5d9asm2186570qvj.120.2023.08.15.11.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:44:33 -0700 (PDT)
Date:   Tue, 15 Aug 2023 14:44:29 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix sii164InitChip function name
Message-ID: <ZNvHjUlGnWqUVSNe@abdel>
References: <20230815043759.404423-1-alkuor@gmail.com>
 <ZNsOv7F1B9AnlUVG@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNsOv7F1B9AnlUVG@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 07:35:59AM +0200, Nam Cao wrote:
> On Tue, Aug 15, 2023 at 12:37:59AM -0400, Abdel Alkuor wrote:
> > Adhere to Linux Kernel coding style. Found by checkpatch.
> > 
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
> >  drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
> >  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> > index e0c7ff3352bf..8b81e8642f9e 100644
> > --- a/drivers/staging/sm750fb/ddk750_dvi.c
> > +++ b/drivers/staging/sm750fb/ddk750_dvi.c
> > @@ -14,7 +14,7 @@
> >  static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
> >  #ifdef DVI_CTRL_SII164
> >  	{
> > -		.init = sii164InitChip,
> > +		.init = sii164_init_chip,
> >  		.get_vendor_id = sii164_get_vendor_id,
> >  		.get_device_id = sii164GetDeviceID,
> >  #ifdef SII164_FULL_FUNCTIONS
> > diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> > index 3da1796cd7aa..d162e1a16584 100644
> > --- a/drivers/staging/sm750fb/ddk750_sii164.c
> > +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> > @@ -72,7 +72,7 @@ unsigned short sii164GetDeviceID(void)
> >   */
> >  
> >  /*
> > - *  sii164InitChip
> > + *  sii164_init_chip
> >   *      This function initialize and detect the DVI controller chip.
> >   *
> >   *  Input:
> > @@ -118,7 +118,7 @@ unsigned short sii164GetDeviceID(void)
> >   *      0   - Success
> >   *     -1   - Fail.
> >   */
> > -long sii164InitChip(unsigned char edge_select,
> > +long sii164_init_chip(unsigned char edge_select,
> >  		    unsigned char bus_select,
> >  		    unsigned char dual_edge_clk_select,
> >  		    unsigned char hsync_enable,
> 
> I think you introduce new checkpatch warnings here.
> 
> > diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
> > index ca330f6a43e2..13420bcc282c 100644
> > --- a/drivers/staging/sm750fb/ddk750_sii164.h
> > +++ b/drivers/staging/sm750fb/ddk750_sii164.h
> > @@ -16,7 +16,7 @@ enum sii164_hot_plug_mode {
> >  };
> >  
> >  /* Silicon Image SiI164 chip prototype */
> > -long sii164InitChip(unsigned char edgeSelect,
> > +long sii164_init_chip(unsigned char edgeSelect,
> >  		    unsigned char busSelect,
> >  		    unsigned char dualEdgeClkSelect,
> >  		    unsigned char hsyncEnable,
> 
> Also here.
> 
> Best regards,
> Nam
> > 

Hi Nam,

Thanks for the review. I will update the indentation in V2.

Abdel
