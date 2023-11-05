Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86377E11E1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjKEBMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 21:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKEBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 21:12:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF3CF;
        Sat,  4 Nov 2023 18:12:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so3372400276.2;
        Sat, 04 Nov 2023 18:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699146760; x=1699751560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqokHnVOovxHPccg3EnJbsWLXVdBMtrOcttvVjZa8Xk=;
        b=FWfQeNbU2jRq8m6HCAF/lBIebgrg/eNDPH2u8h+36Y/V7YAQZw4AyrCluEO9NppG1D
         D1BUWxqDnGBgETDH2Hq7s2ulgLKuDWF1XyqnQpwZ6NvYGSJtjfkGZt11MBzwJdkHJqjG
         sAQkGb5PF76yCYliccJ/zUuH3zoXQ4h7N3senpCyFqMXDZpyy/7TlaXs5Pf2SQQJoiVH
         QGd/5xNd9mg89JV4p/iDbWP5Bw0aoS6ovpPhI3RGoUmCrm04sckY6sR/AUgaoo4/v1BF
         4CsSa0VRo2HBeRY9ybacRiV0nrTP3o1A7bDfxHWldnCTvyUCtW5+pAVRjN81O4mJTxnK
         KtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699146760; x=1699751560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqokHnVOovxHPccg3EnJbsWLXVdBMtrOcttvVjZa8Xk=;
        b=havwziU0iMRdC1VinaqJOtc/t6phkwx+b9jQ/mFr7CIUw+s1jNj+EfjYAjLjmNTnOu
         8dqe+yX+6IxX2GN6A2Jdeu+gefaAsZwkLoJgyA7CXo+TxartQczMfdowJn9QMN9jY7zT
         CreIrX55mnI5YmgwfL97PiC0sKde8PzYVZmwbHPMIr270uUrAMe1LKSCmTb84WWYSUZ0
         w/SCeoZMx+uR3WkN9VmclghGIn0tfHQjHQ+opYDIPlOzrpp7Q8WnRb34jf8rMNkqoI+7
         uEKzwb2gcUZemebKbiOgNJjNCLodBMaE6i6G72Ewp/gPsCcSagdNlIQWnnzzRBhhwYOx
         z8CQ==
X-Gm-Message-State: AOJu0Yw1vrMHlTLDzha+EVuKqUWZ/XMKys4F+sUwtCU8jELthW9OMo+I
        AgZi/zExba3h1UUUUhMFmJOtXn5sBKo=
X-Google-Smtp-Source: AGHT+IFFSL0FGhTUR3U7JwC9HaQTZ8r1kTTgwWSqmi7cTsJYnS2gTLddXW+YVrhOYLm3DkxUHmtwwg==
X-Received: by 2002:a25:d748:0:b0:da0:86e8:aea4 with SMTP id o69-20020a25d748000000b00da086e8aea4mr24628179ybg.57.1699146759909;
        Sat, 04 Nov 2023 18:12:39 -0700 (PDT)
Received: from rigel (60-241-128-164.tpgi.com.au. [60.241.128.164])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b001ca86a9caccsm3571580plk.228.2023.11.04.18.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 18:12:39 -0700 (PDT)
Date:   Sun, 5 Nov 2023 09:12:34 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Do not enable the v1 uAPI by default
Message-ID: <ZUbsAhXyk-d4R2M9@rigel>
References: <20231104-no-y-uapi1-default-v1-1-f60d318b6fbe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-no-y-uapi1-default-v1-1-f60d318b6fbe@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:54:40PM +0100, Linus Walleij wrote:
> It's been two years since we introduced the v2 uAPI and
> the major consumer libgpiod is at v2.1.
>

Believe it or not, it is nearly three years.  But libgpiod support for
it, added in v2.x, is less than one year old, and migrating from libgpiod
v1 to v2 is non-trivial as their APIs are very different.
So I would not be surprised to find that the major consumer of the uAPI
remains users of libgpiod v1.x - which requires the old uAPI.

> What about discouraging the old uAPI?
>

If you want to provide the end user with two years to migrate, and given
that libgpiod is the major consumer, you might want to hold off for
another year.

OTOH, if distros/users want to continue including/using libgpiod v1 they
can always re-enable GPIO_CDEV_V1, so I'm not completely against the idea
- just be aware that it may be more disruptive than you might expect.

Cheers,
Kent.
