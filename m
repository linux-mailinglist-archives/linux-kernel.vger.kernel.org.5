Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A297A3A61
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbjIQUCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjIQUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:02:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1E813E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 13:01:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50307acd445so1581060e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694980911; x=1695585711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBYyotW/pdIWdI0cH7Z40wrfoq7zKPeFkckDRbW/Efs=;
        b=S9niMlIDaT3gee0gfHZnC1+YNW5hwbvDHyrzc8nVRKQL8hQYmH0Mn9BroZMkTwjtrg
         p0qcsYKR4I39Inqvw1pJaZHmz915nbWieWzWV23fP1eV6+gShnMV4BwA3CDpfoajHp1Z
         /lGwN5nQPvrJS50DkryCVkWQ/K1wfoYcfo4Vm8D2+tLH468qLnYchlX0fvWKD2vkIRah
         OT3M+blxdJkkbGRl3QqpTnGV/AOWO13xQkd1hvUSouKUFDzZvv09avsLbnnI5I4UjbKo
         n/V6s5IJSEr5ZxzSWVwA3Dg0VoqyGBYu9mBJwrLQFUZqZX+FrD7VR5Evh1/P7J49hAA8
         oMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694980911; x=1695585711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBYyotW/pdIWdI0cH7Z40wrfoq7zKPeFkckDRbW/Efs=;
        b=rDzvPZ+C+zqJAz3fPIQRbOb//FkhiopG8Srdlt0ySNgy2KHMXIjiRWNKEMC/EsMi3Y
         TrQ2gAdtTNCrKiO6hGAwxNhS9cbYU7xd0T2bDF+HY5JVwQ9mzYG65mJrxe0Lz2ZDVg6y
         zmG6sXhhcb9pke9cywueUCCsDyaRx1e//cGfQTz+CjHwYgbn5llSuj0kF/7ftbtW0t4Z
         ddASgyT69COcfUL8k/FJOr6EZt8ScMYCI+ybvBnOKrpK4ANzV3Ui5zTK5bd7wiyWMGFa
         bkf/J/LuLkTUYy+mw4ZlRjrhkp6hfcobOWMh8z5Ewy/2vZmOYIHqxMvTVsss0S1TJu6x
         bAVw==
X-Gm-Message-State: AOJu0Yy7dN7BMuIetVSUswRpUq/lhBVK7/V1vtkvxDfic49Rjf8T2fXs
        Hb7rtw7p6omqWbm1MzW4Fu3bC36yEzmBzePB
X-Google-Smtp-Source: AGHT+IETR6CvkBHbfEWd4EfCCD9JKVSO3/wNxkcelQ/OCb0FXFPYJydvmxxQ8XAqMfwqSMjBNYOYjw==
X-Received: by 2002:ac2:58f8:0:b0:500:bb99:69a9 with SMTP id v24-20020ac258f8000000b00500bb9969a9mr5279065lfo.64.1694980911019;
        Sun, 17 Sep 2023 13:01:51 -0700 (PDT)
Received: from HP-ENVY-Notebook (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.gmail.com with ESMTPSA id b26-20020a0565120b9a00b005031939dbe9sm70495lfv.77.2023.09.17.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 13:01:50 -0700 (PDT)
Date:   Sun, 17 Sep 2023 22:01:47 +0200
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: Replace strcpy with strscpy
Message-ID: <ZQdbK95P/GRNQo1F@HP-ENVY-Notebook>
References: <20230917154302.913956-1-bergh.jonathan@gmail.com>
 <2023091756-pastel-ipad-6cd7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023091756-pastel-ipad-6cd7@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 06:24:35PM +0200, Greg KH wrote:
> On Sun, Sep 17, 2023 at 05:43:02PM +0200, Jonathan Bergh wrote:
> > Replace strcpy with strscpy as preferred by checkpatch in vme_fake.c to
> > prevent warnings.
> > 
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_fake.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> > index 9bcb89a84d53..0cf5700e151f 100644
> > --- a/drivers/staging/vme_user/vme_fake.c
> > +++ b/drivers/staging/vme_user/vme_fake.c
> > @@ -1093,7 +1093,7 @@ static int __init fake_init(void)
> >  	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
> >  			(unsigned long) fake_bridge);
> >  
> > -	strcpy(fake_bridge->name, driver_name);
> > +	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name));
> 

Hi, thanks a lot for the review + comment.

> If it were this easy, we would have swept the tree and done so, right?
> Are you sure this is correct?  If so, please document exactly why it is
> correct in the changelog text when you resend this.

Thought it better to discuss before sending an updated patch
that might be wrong. 

I think it is correct since driver_name:
  * In: vme_fake.c:
	static const char driver_name[] = "vme_fake": 

will always fit into vme_bridge->name:
  * In: vme_bridge.h:
	...
	#define VMENAMSIZ 16
	...
	struct vme_bridge {
		...
		char name[VMENAMSIZ];
		...
	}

but I could have missed something. This is in the module __init
method and i dont see that name pointer being reassigned before
the strcpy call (which was changed).

Maybe its not worth changing, but (if it is correct) it would get
rid of the checkpatch warning and convert to the "preferred" API?

> 
> thanks,
> 
> greg k-h

FWIW Wouldnt it always be better to use the "safe" option since it 
at worst its going to truncate the destination string rather than 
write off the end of the array? 

thanks in advance
cheers
Jonathan
