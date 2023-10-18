Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F667CEB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJRWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:41:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F425114;
        Wed, 18 Oct 2023 15:41:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d11401516so4914961a91.2;
        Wed, 18 Oct 2023 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697668888; x=1698273688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKa6JWtcPiC4zAx7oaeBnwEnkEeAK8IrNKWLYxgQr3w=;
        b=apJF+qyfY7TuIpH/2IBFM9c0wloiFosCwRPLz8QQVAG2+4Fu1x91ruhogwwalKVP17
         pnpvD1Zfzrta4Ki2v4M9n59vHtsGccRK/uwzRgdaLbyvxKwTSvP7zNcb+GG1jr6Rrp7C
         w7fVYK2JQbctjiJn2QNMr3h7tDswLLLjiODSHMFM7GybIBRVIz0mb6lNwDJdKNo+sIGz
         dvyq8BUGLny8vGwBjcXqw92poQakzSskJMF9gbutagREtZJ7JDFOSoMc9D7M+ZaBDZPJ
         Nawt0SCax3JrxpbhPVIg9JRJE98aLxJAKzDiDPLTFSTySm18gpmRaqYcz/sf60lLpbcb
         Hzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668888; x=1698273688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKa6JWtcPiC4zAx7oaeBnwEnkEeAK8IrNKWLYxgQr3w=;
        b=msHdT6odvXquYeMoRihPfu2d7qTWunp2ckAkL63SV17sK+3tyGBnxEwt39lM+87kKU
         a6Sc9ofHJpYqCJ/NVx/fKy9Xp0XNbhPsH7ps8s31XgsZ8XUaEcl/LAuZhYLUvJDt0zBA
         bRv2nJDMdew4pX4MjCLj8bOxY21nQ5o0t4lL7FRATvMcB9z+DnBLyzgwGoIPEd7zqrwK
         Qj14OC8qQAPhEJtK83fZgShj9GEFC5XTFk6sVVo1+kqpjctLcv+6BpaFp6rQQEg9Hr9q
         sQ4nrBxC92kxi7wq22Aecb+LWyDz+vefNkozdbUJV1bQ9F8K6fpdlFkhjJV3kWA0FYla
         deCA==
X-Gm-Message-State: AOJu0Yxfd7FqXBSdIBNchtSPN22+BpwFXhaj1wyc8uDJ+m0nuRjuGz70
        j7y0mDiKa2SpTgjx5oRfanp2L4UVE78=
X-Google-Smtp-Source: AGHT+IFHcZ7gaE/rCiyv/fbBc5fVKTK17v1bK6uCXT3LwwmAwQpzROz0PtOxmiupmBLwnyeB+rJykQ==
X-Received: by 2002:a17:90b:2dcd:b0:27d:bbee:578b with SMTP id sk13-20020a17090b2dcd00b0027dbbee578bmr560004pjb.7.1697668887719;
        Wed, 18 Oct 2023 15:41:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c4c4:bbd9:2220:727f])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090aa38100b0026f90d7947csm354611pjp.34.2023.10.18.15.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:41:27 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:41:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZTBfFIyCsl2gkp6f@google.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com>
 <ZS7_5VGvRnw99gzd@google.com>
 <ZS9mo4/jnRNoTE+v@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS9mo4/jnRNoTE+v@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:01:23AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 02:43:01PM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 17, 2023 at 10:45:39PM +0300, Andy Shevchenko wrote:
> 
> Thanks for your response.
> 
> ...
> 
> > I wonder, could you please post entire dmesg for your system?
> 
> Working, non-working or both?

Non working, especially if you also enable debug logs in
drivers/mmc/host/sdhci-pci-core.c.

What I do not quite understand is that I think we should not be hitting
the case where pinctrl is already created for the device, which is the
code path my patch was changing. IIUIC we should be mostly executing the
"pinctrl not found" path and that did not really change. Maybe you could
also put some more annotations to show how/at what exact point the probe
order changed? Maybe log find_pinctrl() calls and compare?

Linus, BTW, I think there are more problems there with pinctrl lookup,
because, if we assume there are concurrent accesses to pinctrl_get(),
the fact that we did not find an instance while scanning the list does
not mean we will not find it when we go to insert a newly created one.

Another problem, as far as I can see, that there is not really a defined
owner of pinctrl structure, it is created on demand, and destroyed when
last user is gone. So if we execute last pintctrl_put() and there is
another pinctrl_get() running simultaneously, we may get and bump up the
refcount, and then release (pinctrl_free) will acquire the mutex, and
zap the structure.

Given that there are more issues in that code, maybe we should revert
the patch for now so Andy has a chance to convert to UUID/LABEL booting?

> 
> ...
> 
> > I think the right answer is "fix the userspace" really in this case. We
> > could also try extend of_alias_get_id() to see if we could pass some
> > preferred numbering on x86. But this will again be fragile if the
> > knowledge resides in the driver and is not tied to a particular board
> > (as it is in DT case): there could be multiple controllers, things will
> > be shifting board to board...
> 
> Any suggestion how should it be properly done in the minimum shell environment?
> (Busybox uses mdev with static tables IIRC and there is no fancy udev or so)

I'm not sure, so you have something like blkid running? You just need to
locate the device and chroot there. This assumes you do have initramfs.

Thanks.

-- 
Dmitry
