Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76DF7CE8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjJRUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjJRUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:30:50 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC11720
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:30:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so4522132fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661021; x=1698265821; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AX+jXCX/sPDxF7eIN3hXNqqmKISqpfgFkbu0UzHWvY=;
        b=MovoK15UbxRKOwvxyyOdO3zwKso4CgVi1sbJvwy3dHL8srGhRwyW3WPoZSkzoBsa7H
         sH0Z+1tk7J7FIxtFefhPUcG7FoGGYHr93tyt4aCDmdnKEU38FHgtWRzoU4uptim9xJJq
         qtjUkTZkrRwUyvArJqtSkzr3Tj2XLQFVHIfxUuY60Y74pXM32dDUn5jT52ZcdKFb07Kc
         fZ4ZDrgl0MQACOY9ilAr05MpNbFyq3OQd3muHX4vp6QZQwzyb0eveEwWBxcIGRrqdCX9
         TkxWcAt75DrCgExW6t1W6HZ8eUyuEUve6Ik+mfnaVLioEyBp/iJavDk4X4ZJ54z/JVw5
         jScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661021; x=1698265821;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AX+jXCX/sPDxF7eIN3hXNqqmKISqpfgFkbu0UzHWvY=;
        b=CJV8yhlUndxxSCbYsqECOm/QnVtwraWx5pvUbIrcd4bfnlzfgps+MmAKA0CFWy7H7k
         RPFLXqvqNnskYMKe8+cEvNmbsBPqP5wvuWPhc4OVE7WcDlUL40Y5HjtizZdRwrhfWG6i
         GiEAcRXoJaRt7+Lrukv5LfQw6il+sOylS9o+tcWVzY16kAdVYdQaJxB1NUHqmVdqCwlH
         iLXJ1MXY2+5tuwUOtg1S1eOmpjak9d3RUWjEbSIEyhNBxK63FjtH94hm5LmwnMUumO/k
         Djpz3AnzLJIKzs3Lm53+ejSoemb9jeIiwLth8oNf4wj8heK86yvAtR1PEt2nZZ9WiaRc
         FZAA==
X-Gm-Message-State: AOJu0YycknOoiamUYeeRDlxbpMcQBDepotbisszlRZPECNaPgtIcMWQc
        SMA5TYQmImY728FjEnrcoQVTZDojKveD2A==
X-Google-Smtp-Source: AGHT+IEwy9FFN3CUiVgFe/Gif5Jy9x5zebDzdKvB1lg1Qpt6LU1AMHxmCdKbpxOrHgSbgT94V8MCsg==
X-Received: by 2002:a05:6870:b1b:b0:1ea:8645:6354 with SMTP id lh27-20020a0568700b1b00b001ea86456354mr645758oab.0.1697661021393;
        Wed, 18 Oct 2023 13:30:21 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id r27-20020aa79edb000000b006be055ab117sm3812438pfq.92.2023.10.18.13.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:30:21 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:30:20 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: vme_user: Use __func__ instead of function
 name
Message-ID: <20231018203020.GB32553@Negi>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <c553e5901f16b78681e74b2d77796f8fc102b602.1697601942.git.soumya.negi97@gmail.com>
 <ZS+6sTNNZ5KUzpd4@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+6sTNNZ5KUzpd4@ashyti-mobl2.lan>
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

Hi Andi,

On Wed, Oct 18, 2023 at 01:00:01PM +0200, Andi Shyti wrote:
> Hi Soumya,
> 
> On Tue, Oct 17, 2023 at 09:36:33PM -0700, Soumya Negi wrote:
> > Replace function names in message strings with __func__ to fix
> > all checkpatch warnings like:
> > 
> >     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
> >              this function's name, in a string
> > 
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > index e8c2c1e77b7d..11c1df12b657 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -422,7 +422,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
> >  	image = list_entry(resource->entry, struct vme_slave_resource, list);
> >  
> >  	if (!bridge->slave_get) {
> > -		dev_err(bridge->parent, "vme_slave_get not supported\n");
> > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -572,7 +572,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
> >  	image = list_entry(resource->entry, struct vme_master_resource, list);
> >  
> >  	if (!bridge->master_set) {
> > -		dev_warn(bridge->parent, "vme_master_set not supported\n");
> > +		dev_warn(bridge->parent, "%s not supported\n", __func__);
> 
> I wouldn't disagree if you made this dev_err() instead of
> dev_warn(). The reasoning behind is that if it's a warning you
> should not fail. But beacuse you are returning -EINVAL it means
> that you are failing, therefore you should use dev_err().
> 
> Others might object that the change I'm suggesting sohuld go in a
> different patch, which is also OK.
> 
> >  		return -EINVAL;
> 
> ... or, if you want to keep the dev_warn(), whou can consider
> removing the "return -EINVAL;". But this is an evaluation you
> should make in a different patch and mainly evaluate if it's
> OK to remove the error here.

I think it should be dev_err() too. The driver has inconsistently used
warn and err log levels in similar functions as well. But I was planning
to tackle those in a standalone patch after the printk's are gone. Or do
you think it should be part of this patchset?

> >  	if (!bridge->slot_get) {
> > -		dev_warn(bridge->parent, "vme_slot_num not supported\n");
> > +		dev_warn(bridge->parent, "%s not supported\n", __func__);
> >  		return -EINVAL;
> >  	}
> 
> Nothing wrong with the patch itself. But imagine if we end up in
> one of those printouts and, as a user, you read something like:
> 
>    ... vme_slot_num not supported
> 
> The message itself doesn't say much to the user. The perfect fix
> would be to re-write all these error messages with a proper
> meaningful sentence, like, e.g.:
> 
>    Can't retrieve the CS/CSR slot id
>
> (don't even know if it's fully correct). Anyway, I understand
> you don't have much time for such fine changes, so whatever you
> decide to do:

Got it. Thanks for the patch suggestion. Although yes, since I still have project
starter tasks pending for my outreachy application(will have to prioritize                           
them) I'm not sure if I will be able to get this done right away. Will try to
though.

> Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 
> 
> Andi

Thanks for the ack. Since I'll have to revise and resend this patch as v2, 
should I not add your ack tag as the patch will be reviewed again? Just 
wondering what the etiquette is.

Though normally are patches supposed to be resent as new versions when adding
ack tags?

Regards,
Soumya
