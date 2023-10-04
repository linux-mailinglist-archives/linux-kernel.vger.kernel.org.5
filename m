Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027757B770B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjJDEQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJDEQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:16:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41071AC;
        Tue,  3 Oct 2023 21:16:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-694f75deb1aso404980b3a.0;
        Tue, 03 Oct 2023 21:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696392984; x=1696997784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1nxELRefWgX/plBQJdhjQvCak5wttkBwSg7H4d2bgsw=;
        b=ZhJHid3vfNqq9UAEirwWnFzrHk55WUotgAdZP8n+cZGYSJBUQn5ksyeERXCKsiEglD
         9zzuWQrPPEzhC07mtwNCakoJgz7LkiCE6M9zyUxLwXaXf+HV3i24kY0qZWeSRYloflZs
         oItLUrmxv1N0ZWJChQJJpcxoJwPwwKgGzd6E6ZIXZgHl/9yvwB/nqsDT9g9VmWnlqcon
         qbUwaGF1JcK4LBgB90e0ollY/al8S1RtuFliXGl/xLOZe75Lwx/xVhW1xPG82SmKnpW+
         x9eXrAoYXUJdIJ7GGk4nj3hF0sVBZVROyC+1Lo0SMig2RE0DOO1RV0gON+q2ejCHJMwI
         FkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696392984; x=1696997784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nxELRefWgX/plBQJdhjQvCak5wttkBwSg7H4d2bgsw=;
        b=qLyGOYRIfZCWbGQPx7Xa7FdYrm0NdtDIzXGV+oYBTDcTb5QV8NEttFdZM9qCy0EWp1
         1D7uxWe75dyldFYqhRxk2T374/5ohLOfNveLs86YebZ5PaBxZSJSHJwCV/NCaGKUfzQx
         NkBIE5MN1WRFqlHTZCPGZyvlwmFyt0eo768k+iDI6xFXc/F374PQjE8UOof+XaKqbIWI
         7Sm0ex8shxS0vdtj2o5qSHtxEorHz8KRltd8SJ0/KDZrpWb/pa9v9J5Es80GW+Rat84Q
         wbs2oGvk7C+8b/X0IjrBXxa9j1lbGr1FKMeRXKpjyC42Ybb7TU7BMZ/Sj+n5/0Y0yr0Q
         dosw==
X-Gm-Message-State: AOJu0Yx1EmyV52gnGPeePDUvZ8da2M1P+vDO4KxHO/8SmBwj1wlWIWNs
        0H+Es3+dR17OePKRsad1Zaw=
X-Google-Smtp-Source: AGHT+IEWil4HiZnBdsQgjIYMpOS1vKdwrrYpkePsXs1ruscZvmuboArlCn3in3cy61I5LVeDIefsVQ==
X-Received: by 2002:a05:6a21:1a3:b0:134:73f6:5832 with SMTP id le35-20020a056a2101a300b0013473f65832mr2023860pzb.16.1696392983587;
        Tue, 03 Oct 2023 21:16:23 -0700 (PDT)
Received: from sol (14-200-166-90.static.tpgi.com.au. [14.200.166.90])
        by smtp.gmail.com with ESMTPSA id n3-20020a6546c3000000b005706b9813afsm1959884pgr.90.2023.10.03.21.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:16:23 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:16:17 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Message-ID: <ZRznEe2tKmVcVlwr@sol>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-5-brgl@bgdev.pl>
 <ZRwtEG1DamMLZC/3@sol>
 <CAHp75VdSDart2b+_d6_9E204JYa2zyFKdh_Pey6Wb4MZ-Z-L0Q@mail.gmail.com>
 <ZRwyG80u6nIf7PGU@sol>
 <CAMRc=McbWU+bPph7f6treqNmqJvakj8nLzNEJPjgb8tbG_pWxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McbWU+bPph7f6treqNmqJvakj8nLzNEJPjgb8tbG_pWxQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:07:05PM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 3, 2023 at 5:24 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Tue, Oct 03, 2023 at 06:17:27PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 3, 2023 at 6:02 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > > On Tue, Oct 03, 2023 at 04:50:42PM +0200, Bartosz Golaszewski wrote:
> > >
> > > ...
> > >
> > > > I agree with the change in principle, just not comfortable with the naming.
> > >
> > > +1 here. I proposed some names, have you seen my comment(s)?
> > >
> >
> > I have now - any of those work for me.
> > Whichever is consistent with what we are using for gpiochip functions in
> > gpiolib would make most sense to me.
> >
> 
> Does it really matter? It's not here to stay, it's temporary and
> exists only until the whole series is applied - which given that it's
> limited to gpio and pinctrl, shouldn't take more than one release
> cycle.
> 
> There are plenty of examples of this naming convention for temporary
> symbols - there's even an ongoing effort to replace all .remove()
> callbacks with .remove_new() which will then be changed back to
> .remove() treewide.
> 

This was the only patch that I was included into, so I didn't realise
there was a treewide rename at the end.
Even so, using _new suffix for that purpose is poor (well
pinctrl_gpio_free_new() did draw a laugh, but other than that...).
Perhaps use something specific to the patch series so it is clear what
its purpose is?

Cheers,
Kent.

