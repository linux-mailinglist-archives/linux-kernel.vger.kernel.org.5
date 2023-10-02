Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55F7B5741
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbjJBPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjJBPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:40:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E15CBD;
        Mon,  2 Oct 2023 08:40:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c723f1c80fso55177575ad.1;
        Mon, 02 Oct 2023 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696261235; x=1696866035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wiIjPxGS9I1xRfBewNetTUwkZeGUFLTkeOYKIQyLkg=;
        b=GL2VvNKj50vCwZmzR8P9pCycp9QD3HOzUV3U5hRlV9Bf3fnubMqEXQTOKHQ8Jak02T
         XoH8w27u4NwmHf7SHTQ8opZ8LFwf/aghia+4kN8D3d1sGUJz93GtbH/VmZgHsF+T16z/
         pg9/TFtSc4MBbzSCVq9dnitVjybEKvdp1U2G4pLYVou6qflWS7g2sYa+EFe8E/0Cba1b
         DEoP3Sv4hxH84M2MJr7a4YQ27nzDK9abe3SWPlG7gc+Zxz+Mqhp+Tc3KZDa6MsLB04C4
         mBnj2GA288OUdzFsaeZaUNnyr3W93ZS0PdiccJmHQEF11ZMKupdeQR1/j+BLAgo1SATK
         3nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261235; x=1696866035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wiIjPxGS9I1xRfBewNetTUwkZeGUFLTkeOYKIQyLkg=;
        b=YZqMmwyG2zE7zp+kPkCVyiaG8CvNPhegToJh6J+NxKnmTTX7adkv/s1lSjN29qa6wC
         4JTZtpPkDeO/GU5TzHI+lhTznRwDMLwCCplC3pvXHyjemSc0TxorHwJWgdDk+g31qfNv
         SDGhYdFRzAerZOizXKyKR1mF1Ll8H/O7L5ZVh4agkAl1ZaKJfPLb+20X7cXMaZs6rAf0
         eDgVPLyLnB/fr5RnKHmWWJ7KpXl35Z1bP0o3sTjresG5WbnQctOG8znadw8hIj3e6lFD
         /3IEqoltLgv0G+7W30roI1nXjxPZFaIMtsM2fdqTWDFyMbW9qzuXmDss4NBgO/01ev83
         NcLQ==
X-Gm-Message-State: AOJu0Yxgwq4kDdqSeDhpckA1BFO201Dw2vSwr8UTJgbcJaoTp5Kf7X0a
        ssUAF+AsABGBMQ+Xy5kZAixQv0OvCqUB3eFR
X-Google-Smtp-Source: AGHT+IEqZ3v/v//a1wYhJ9s8uuhb7EVgVzeNPvmzBmt8w0G6QXiks6v052V2OBcI6S1rLh8zi7i+rQ==
X-Received: by 2002:a17:902:ecc8:b0:1c7:41ed:199 with SMTP id a8-20020a170902ecc800b001c741ed0199mr10742839plh.66.1696261235536;
        Mon, 02 Oct 2023 08:40:35 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b001b54d064a4bsm3524178plo.259.2023.10.02.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:40:35 -0700 (PDT)
Date:   Mon, 2 Oct 2023 21:10:30 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] usb: fix kernel-doc warning
Message-ID: <ZRrkbkjoHgEnuy/m@swarup-virtual-machine>
References: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
 <2023100253-aide-authentic-5aa1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100253-aide-authentic-5aa1@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:42:03PM +0200, Greg KH wrote:
> On Tue, Sep 19, 2023 at 01:05:05AM +0530, Swarup Laxman Kotiaklapudi wrote:
> > Fix kernel-doc warnings discovered in usb driver.
> > Fixes this warning:
> > warning: Function parameter or member 'gfladj_refclk_lpm_sel'
> >          not described in 'dwc3'
> > 
> > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.h | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> What commit id does this fix?
> 
> thanks,
> 
> greg k-h

Hi Greg,
Please find the commit id as mentioned below,
next time onwards i will mention it:

Fixes: 5cd07f96c0c6 ("usb: fix kernel-doc warning")

Thanks,
Swarup

