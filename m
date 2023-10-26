Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE037D7F43
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjJZJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:04:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C50128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:04:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-408382da7f0so5092185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698311044; x=1698915844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4l+2Rs7C7x9u0N7SLFEtVHo7I01QW3h5/pshwo3pB28=;
        b=BRjTfjNXTHK1C8LkfCGW0ykS2ONoB0nN3Ft8hei9cUQAnmJax9dN4ppJ4YS12ezckb
         60zAqAr6TQYV9Vzh513jOXhQDWTxUsasTDjt/gHDL8Hnl1n1LjJwD843O5OytLrKW17+
         NEjIAcZN84L/iwTI41Yf7c8OkDZUQ00v+mYoOIqJPcW0CdKvNXU6W1hxEaJTq5cBY4jD
         RVKDnMOVmi3gfKZgOwsqeS93YeDuVzO7zvXVJEHUPx63FWXzzZOZBTLRoS+uu2wpuuMm
         DaHSxIzbbBvQJM21ma2USTszgQ56N2bHzmq64WCgaJsPwm1qANSRipFXkxSWqyhHnmLN
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698311044; x=1698915844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4l+2Rs7C7x9u0N7SLFEtVHo7I01QW3h5/pshwo3pB28=;
        b=SCd/GAuyUEa1YIrNm7gQV1m869Rg59gT04qbwwtVzjhTL1dTjpZFBcwvWXQ6fC7h+k
         ZPKMmPZ0plsZK6yEJz/IkYxzdDaEZI8U/c0lQ0Cd7U6Z/TzZD9u5d+OhhGkVF+4sXdMy
         qXbmJ733nRTpAiDYsI5k+Ra4zpqzzHalIFDit2vHv20Wb8/R4n5ZRI+lP2TtEmES/Rta
         FkENxmGy4ImABP2TMoK2Dhn0ucrDmaxDvNWOUW7ED9OOOZf4npnOFtajBTGsC1HNFXrf
         l81Nn8RnVyzXUJDeQhundjtF8k4VNstZV9c+p+oCXSl29irbs2SkOlBXOrQ7TLXZxz+l
         M/MA==
X-Gm-Message-State: AOJu0Yy/7y3NbVChPueG/pjXsYSqDxScbF5scZm0biN7LxnmJvoPwOK2
        wcmfpJRvd6JIcncPbNkMNUDVQg==
X-Google-Smtp-Source: AGHT+IG8hSkFGo9COVTu/+5Jxw+21cZ8QP5ccxewFjEgxFfeOWN7uvJ1RwUqTZdRpeNw0xm000OrMA==
X-Received: by 2002:a05:600c:3b0f:b0:406:44e6:c00d with SMTP id m15-20020a05600c3b0f00b0040644e6c00dmr14858423wms.2.1698311044570;
        Thu, 26 Oct 2023 02:04:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f21-20020a05600c43d500b00401bbfb9b2bsm990772wmn.0.2023.10.26.02.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:04:04 -0700 (PDT)
Date:   Thu, 26 Oct 2023 12:04:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     lukas@wunner.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, tiwai@suse.de, Jim.Qu@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vga_switcheroo: Fix impossible judgment condition
Message-ID: <06e868cb-f96e-46af-9484-a613de0baaaf@kadam.mountain>
References: <4ec2b80b-f042-4abf-b799-0a9ef364f0fa@kadam.mountain>
 <54d21280-6e1e-780c-372d-d630630a4fe9@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54d21280-6e1e-780c-372d-d630630a4fe9@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 04:46:29PM +0800, Su Hui wrote:
> On 2023/10/26 12:44, Dan Carpenter wrote:
> > On Thu, Oct 26, 2023 at 10:10:57AM +0800, Su Hui wrote:
> > > 'id' is enum type like unsigned int, so it will never be less than zero.
> > > 
> > > Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
> > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > ---
> > >   drivers/gpu/vga/vga_switcheroo.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> > > index 365e6ddbe90f..d3064466fd3a 100644
> > > --- a/drivers/gpu/vga/vga_switcheroo.c
> > > +++ b/drivers/gpu/vga/vga_switcheroo.c
> > > @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
> > >   	mutex_lock(&vgasr_mutex);
> > >   	if (vgasr_priv.active) {
> > >   		id = vgasr_priv.handler->get_client_id(vga_dev);
> > > -		if (id < 0) {
> > > +		if ((int)id < 0) {
> > Hi,
> > 
> > I feel like you're using Smatch?  Which is great!  Fantastic!
> Yep, Smatch helps me  a lot to find these bugs! I really like this excellent
> tool!
> > 
> > Have you built the cross function database?  If you have there is a
> > command that's useful.
> Not yet, bu I want to build this.

Yeah.  It's super useful for kernel development.  It helps to understand
how functions are called and where variables are set etc.  The smatch
documentation is crap, I know.  But I did write a short blog about the
cross function DB.

https://staticthinking.wordpress.com/2023/05/02/the-cross-function-db/

It's simple to build, but it takes a long time.  Just run
smatch_scripts/build_kernel_data.sh

regards,
dan carpenter

