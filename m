Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD47B5937
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjJBRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjJBRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:40:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A09E9;
        Mon,  2 Oct 2023 10:40:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565e395e7a6so9245318a12.0;
        Mon, 02 Oct 2023 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696268413; x=1696873213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G85KjuFiBO73o7Wzp/yJK1STnMsGHZl8ZA4ohW5rdb0=;
        b=mHG2XujWpv5aY+ZT+hK4Qg1TPrVrbZadveA8ZLZwQ3TmYJZA1VNSYTprhRCgdX3L3s
         jPU6cWcAG3hAdHDn8qh1SgzomplyUCaEUZPXh9N7LdkXdym3VKLgqjwr+z53dEDTT0yZ
         OAyvPUNZQUlmNxEkQ5WIkLUtns2qYu2grgX3TJnrEsMwaUKKTa1uELp5eIVTAa5SF8lC
         twNQG8ure3IQWvbeb0l70v31EPszoSea5woBQg43VFMTyTT6/5CQJy8n9DpW4hLNij1U
         mNj4dMzh5uN4GVhuChLnQDOOQ79i+QOPLnCEd2+TsyTXBUPL4muAjztlVziJXcm78meW
         dgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268413; x=1696873213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G85KjuFiBO73o7Wzp/yJK1STnMsGHZl8ZA4ohW5rdb0=;
        b=qQ1w7DUTgQ0CKE2FG4YejtuWpnu4WqsRRLSTv+W1F5gZf5C/9VHvI2A5MKWDq0npni
         n+bj8SWUeaHmR0ZgYOOaivkgtYIIG1BJDMVIJiQG0XJuxeVfh279jv+IHNQVybO54bRp
         S3PiwMV8XhQLypSMoAZI3TK6odNDhQxYza+n5UacZMk7DR5mHOXuVqxDyMzH4mNubRm/
         RdKNuYzrr/7/e1fDOkXP8PXes44NFqzPVjWrPu5Y8yKI+hkzUU9X6h80q7i+/QaqC5WH
         7b5Gm5/idVOfnsiboRry/d/TgHjuEK3BDxVKG4qlR1RTHjAOHVhkmQ6NkD88gpaZ6/KH
         Jx5Q==
X-Gm-Message-State: AOJu0YxDs4Aguoqw0foRQmEhQS8GMiFFNRz0q7QBqjpLcGCDJ4imi/cl
        aXsvRSHV1QeLH7Wf9STeJ3fSI5o91pbENsTz
X-Google-Smtp-Source: AGHT+IFfnemkqgLkLIaFXsRgXJMqG3C9Cw5R8Sr91ipeEIpNMozmNWbJAPPEYNXlIB6+I8ZpFUwICg==
X-Received: by 2002:a05:6a20:4292:b0:157:b453:dbb9 with SMTP id o18-20020a056a20429200b00157b453dbb9mr12165018pzj.6.1696268412767;
        Mon, 02 Oct 2023 10:40:12 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b006932657075bsm58122pfn.82.2023.10.02.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:40:12 -0700 (PDT)
Date:   Mon, 2 Oct 2023 23:10:06 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, q@swarup-virtual-machine
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] usb: fix kernel-doc warning
Message-ID: <ZRsAdi/LOEFPY6j1@swarup-virtual-machine>
References: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
 <2023100253-aide-authentic-5aa1@gregkh>
 <ZRrkbkjoHgEnuy/m@swarup-virtual-machine>
 <2023100207-unmoved-arbitrary-2c33@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100207-unmoved-arbitrary-2c33@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esOn Mon, Oct 02, 2023 at 05:46:49PM +0200, Greg KH wrote:
> On Mon, Oct 02, 2023 at 09:10:30PM +0530, swarup wrote:
> > On Mon, Oct 02, 2023 at 04:42:03PM +0200, Greg KH wrote:
> > > On Tue, Sep 19, 2023 at 01:05:05AM +0530, Swarup Laxman Kotiaklapudi wrote:
> > > > Fix kernel-doc warnings discovered in usb driver.
> > > > Fixes this warning:
> > > > warning: Function parameter or member 'gfladj_refclk_lpm_sel'
> > > >          not described in 'dwc3'
> > > > 
> > > > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> > > > ---
> > > >  drivers/usb/dwc3/core.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > 
> > > What commit id does this fix?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hi Greg,
> > Please find the commit id as mentioned below,
> > next time onwards i will mention it:
> > 
> > Fixes: 5cd07f96c0c6 ("usb: fix kernel-doc warning")
> 
> That is not a valid commit id in Linus's tree, are you sure it is
> correct?
> 
> And please resend the patch with that information in it.
> 
> thanks,
> 
> greg k-h

Hi Greg,
  I send patch V2, with the Fixes tag being mentioned.
  Please check the email.
Thanks,
Swarup
