Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821287F906F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZAOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKZAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:13:59 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A62E4;
        Sat, 25 Nov 2023 16:14:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc34b6890so1047595ad.1;
        Sat, 25 Nov 2023 16:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700957645; x=1701562445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FL56cXoUtmBrEdcA0tYY4TzRDBeIrF1a5avi6GDovCo=;
        b=kSNlldhu2tfVHBZm2/lPfA1X9Cd+OV6vtDS3NDVA3nYQCMH6gRctHcyQLYNKhPghUt
         ypU8VdjwDmm4556CmoFWZAK3p03goZcvc6+99UOXwR50QZoVtP8MddZcOGEbF6jyD7dp
         vUtA/y1l4+Y/FnRwz6d7ujYrkO9aHGMwCi0kfSH3xAq4tizt/PWda5GIm2hMbBy37hOm
         iXl1F5bF1vPFcaiV8G5+lUnHIowi4Z4ea/hcfExSbAFfLehfio4Z+X+pCQ26wLHyh4ic
         M5EaTXLTm3pewV2TR7m5XON4W5i16rM8Q8b+xrP4ffrrHHbQ574jvT85IqL1WdF83Ev6
         kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700957645; x=1701562445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL56cXoUtmBrEdcA0tYY4TzRDBeIrF1a5avi6GDovCo=;
        b=R8LbE+Dl6fCyg+V8iRQnkd2+zfL6Rbkthv08qd5O+9UtawBFUz2Y33exIhaaVpr0oq
         YVk6XV+3FCEViHce9uAXHBhppNfrCKrBJ6p7duq2I2/Ggx/xyeRsm06Gpg/29zOUuh/C
         qgK2xcCq6YYJkAgWzZc/kuYOfJeVSllZVa0U2MmmG24uxbtUQE5KV/g7gm1yB5nFR1Tm
         KPMEAi3XCZafoPcdE5cmWD0uRZsjTG6CKJ35Wt53SPrd0wvsgIWHT/v07mu0RgbL/RLn
         elwcYiKjpnC/lzylHbqenN/Vv+zBQAQbyg86wRA7yOE8REL+HrG6HMlFeXvkZbWZ0/rt
         OiaA==
X-Gm-Message-State: AOJu0YwNRsDujcBipmHE1VOO/7IuPYC2lqKXAUQQN0EdHr8MNdn7UwPb
        +hyJZOh/a1Xnyi2DTvAlds9O3OlyN0E=
X-Google-Smtp-Source: AGHT+IE6hIyrn7SuOB+PtaBBbmfSGH6N8PVhToqZf8dodFhLNxYBGDFIwRXxXXAYpvglB1NhL968xQ==
X-Received: by 2002:a17:902:eccd:b0:1cc:52b5:8df8 with SMTP id a13-20020a170902eccd00b001cc52b58df8mr15199466plh.26.1700957645533;
        Sat, 25 Nov 2023 16:14:05 -0800 (PST)
Received: from rigel ([118.209.207.221])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001cfba9dac6esm1233886plb.115.2023.11.25.16.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:14:05 -0800 (PST)
Date:   Sun, 26 Nov 2023 08:14:00 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Drop cargo-culted comment
Message-ID: <ZWKNyFOU65IHND1k@rigel>
References: <20231125-dropcomment-v1-1-15800415aae0@linaro.org>
 <ZWFepm7ufLdl115j@rigel>
 <CACRpkdZvwePEaRVQLafD8KmiOENgEGFFDBXGPqS5_WLzNi2_yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZvwePEaRVQLafD8KmiOENgEGFFDBXGPqS5_WLzNi2_yA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 12:05:08AM +0100, Linus Walleij wrote:
> On Sat, Nov 25, 2023 at 3:40 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Sat, Nov 25, 2023 at 12:25:47AM +0100, Linus Walleij wrote:
>
> > > -/* gpio_lock prevents conflicts during gpio_desc[] table updates.
> > > - * While any GPIO is requested, its gpio_chip is not removable;
> > > - * each GPIO's "requested" flag serves as a lock and refcount.
> > > - */
> >
> > Perhaps provide a comment as to what the gpio_lock DOES cover?
>
> Normally yes, but Bartosz just said he is going to replace this spinlock
> with a mutex so it's better if he adds it then.
>

If that is happening soon then leave it to Bart to change both the
comment and lock.

If not, then we now have an undocumented lock.  If the coverage of the
spinlock and proposed mutex are the same why not describe what the lock
covers now?  Then Bart wont have to update the comment.

Cheers,
Kent.

