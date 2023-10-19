Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C727D0252
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbjJSTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjJSTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:14:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481FCA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:14:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-58e119bb28eso896067a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697742869; x=1698347669; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0c2Ykg+NSYzL507uf61vrkxf/qCgVQVxVY+6Rum2lE=;
        b=TurgLWkPUb9gIECPeFFa0pII8zJMpuzwADD7G42HEEv6AfHOkUoVAKbT32onR25b5L
         0/wkjMxp0TNbfsLTpdWVtta7vv1wrTcsOjuvUP6+JBww7wVoIoHuPUfsN5Qu763gwXsQ
         8iiack/2SSY2cNgVowSrJYHvuAwtwfVUxC/kOFn9bOY+Zw+RvCpCKTA19vLZ6GY825Vr
         Iq4BAJ/T7LlWPPo6f6XZkV+H2dSwDr3WJhEbBY9C3xu6AeV20tEGVnqC4+uCiROteFBc
         TGiApH6OiY8pKYK67RtuydovOwazHsomM2Ee6fddzfP5HMBgs6zQl2ETPRugLx/71b56
         dGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697742869; x=1698347669;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0c2Ykg+NSYzL507uf61vrkxf/qCgVQVxVY+6Rum2lE=;
        b=nEFWOtytYLi4J34BeeTQ8tboaELFFZcQSZ+hlWn5LUlcpJ2wjiBArmpeO0XU6U/KrA
         oFvKTii293e9+eMNLU3zzeNuBH9m2NCHuxJ8ANO5Ow8HnVEKOiW/QyjjuSgebw5caO4u
         r1bqhMEwXRLN/nB5JbUkrj+2oi3Sk2xOBN+lNfxWIj69FLGCB/lDB46O921xh9TiGXO1
         vkxczUGjyhyr7Qn5kSJZjVmKHl1WAGVYIaBViMCJ+V82gZjN0heMSLMDvMTFSsA/iCaa
         qeoGFQEn+3w5vBNQObPWfNic5lkD4jW7zvfjSYSCkGX4AHJhmrbC3AvWuxhw3KSHFxwp
         Zqqg==
X-Gm-Message-State: AOJu0Yyt5eZWm6o2uXzaBnh8h8LcWv6bPkY3k/LYewpKFnqgmn/KQK9n
        pWPtHbpiJKEUDepH0hjk9Dc=
X-Google-Smtp-Source: AGHT+IEAg0sopFfjPaXNffNo+Co1dZ3z90JYHckrKJv95HTWg1k/kLDXOPsZU++MoPY7CSEZUgh6mA==
X-Received: by 2002:a17:90b:23d6:b0:277:3565:30cf with SMTP id md22-20020a17090b23d600b00277356530cfmr4267350pjb.6.1697742869255;
        Thu, 19 Oct 2023 12:14:29 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a4d8800b002791491f811sm124789pjh.8.2023.10.19.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:14:28 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:14:28 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: vme_user: Use __func__ instead of
 function name
Message-ID: <20231019191428.GA32717@Negi>
References: <cover.1697696951.git.soumya.negi97@gmail.com>
 <996c9f92e7fd288f67c02dfb0ba524ab7c5fe421.1697696951.git.soumya.negi97@gmail.com>
 <ZTFOGIu5U+ZUodXW@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFOGIu5U+ZUodXW@ashyti-mobl2.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:41:12PM +0200, Andi Shyti wrote:
> Hi Soumya,
> 
> On Thu, Oct 19, 2023 at 12:20:10AM -0700, Soumya Negi wrote:
> > Replace function names in message strings with __func__ to fix
> > all checkpatch warnings like:
> > 
> >     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
> >              this function's name, in a string
> > 
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> 
> you forgot my ack here:
> 
> Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 
> 
> Andi

Sorry I forgot the tag Andi. I'll add the tags in v3(Greg has suggested
more changes). There will be some new patches, so I'll leave the tags out in 
those as you may want to review them first.

Regards,
Soumya
> 
> > ---
> > Changes in v2:
> > * None
> > 
> >  drivers/staging/vme_user/vme.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > index 640b2dda3ac6..e533cce8e54e 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -424,7 +424,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
> >  	image = list_entry(resource->entry, struct vme_slave_resource, list);
> >  
> >  	if (!bridge->slave_get) {
> > -		dev_err(bridge->parent, "vme_slave_get not supported\n");
> > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -576,7 +576,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
> >  	image = list_entry(resource->entry, struct vme_master_resource, list);
> >  
> >  	if (!bridge->master_set) {
> > -		dev_warn(bridge->parent, "vme_master_set not supported\n");
> > +		dev_warn(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1576,7 +1576,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
> >  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
> >  
> >  	if (!bridge->lm_set) {
> > -		dev_err(bridge->parent, "vme_lm_set not supported\n");
> > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1612,7 +1612,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
> >  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
> >  
> >  	if (!bridge->lm_get) {
> > -		dev_err(bridge->parent, "vme_lm_get not supported\n");
> > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1649,7 +1649,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
> >  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
> >  
> >  	if (!bridge->lm_attach) {
> > -		dev_err(bridge->parent, "vme_lm_attach not supported\n");
> > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1682,7 +1682,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
> >  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
> >  
> >  	if (!bridge->lm_detach) {
> > -		dev_err(bridge->parent, "vme_lm_detach not supported\n");
> > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1750,7 +1750,7 @@ int vme_slot_num(struct vme_dev *vdev)
> >  	}
> >  
> >  	if (!bridge->slot_get) {
> > -		dev_warn(bridge->parent, "vme_slot_num not supported\n");
> > +		dev_warn(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > -- 
> > 2.42.0
