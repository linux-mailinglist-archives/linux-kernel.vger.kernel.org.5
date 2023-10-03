Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6167B73FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbjJCWLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbjJCWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:11:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF8AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:11:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5db4925f9so2439785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696371104; x=1696975904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWFdWcwaZ07tccmvOmfe9sVqfxtw17L6Xwy81VVH0tc=;
        b=KULZ7cLGteDPkuxigFdT95i/LoKzthIxuzXcbbAdMzXJut5/VzKT80yvgRwqAs5aFy
         hl/UbXQ8IMtw1OejP2Y0tudh29cUBUrobW7IUx+HLcNRsRno37/aWA7g4alZsUrGNIQX
         8/EoqFpSVvrKJB6n1mWhH16mYap4H+bfPmaJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696371104; x=1696975904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWFdWcwaZ07tccmvOmfe9sVqfxtw17L6Xwy81VVH0tc=;
        b=NIjMnTv5MwTgP9+ERe/goZ8tA8RGnQiVACn2qN/vuQWAYXD6U9MGT2yR3aCVFj53ZZ
         Z+rdEGJXgkNNG7tLjWqJ/9pfxzzpLxAPzHMyyiMGIiB4ok9ork734g2/f1l2uHGg55T0
         +G974lIB7AGD09SUV8qX06gqz6MuGm7HN7tMbMMfFo1L49ECgzeLmnuCPIO2FepQgtr9
         NoBl1blb/VKsvAjuishB849e2xB0h4WP3cdL8r0/bOROE1MmuwzzxhgekbRkXg9ZPYEf
         j8j4/CGUWrqVvqvkf4MROM+SXJAjyN0lWnCg1No2yXV2g0R1rGYHjuH9oJBukPQvEHfy
         Mb1w==
X-Gm-Message-State: AOJu0YxMxUhMLzGRxl13WfQq/bmFZ/ZdP5dDgFYHB0xUjDbL6nrEiCJ7
        d4Ghr6IvKHk3CSG9bH5f9uRMBlbDA3X0/awnwGY=
X-Google-Smtp-Source: AGHT+IEZRfFhNafHK4dA9rjQZdDnW9hSDlrDkVFEx78a8EOt5GKRH36xETfI5Lo6zDgzAm6lbjACVw==
X-Received: by 2002:a17:902:e80f:b0:1bd:d510:78fb with SMTP id u15-20020a170902e80f00b001bdd51078fbmr6299280plg.3.1696371103898;
        Tue, 03 Oct 2023 15:11:43 -0700 (PDT)
Received: from chromium.org (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id t10-20020a63b70a000000b005854f6a6ef7sm1675856pgf.23.2023.10.03.15.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 15:11:43 -0700 (PDT)
Date:   Tue, 3 Oct 2023 22:11:42 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 0/4] platform/chrome: Random driver cleanups
Message-ID: <ZRyRnq1B0Xcwc2RH@chromium.org>
References: <20231003003429.1378109-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for submitting the patch series.

On Oct 02 17:34, Stephen Boyd wrote:
> Here's some random chromeos driver cleanups that have been sitting in my
> tree. I've noticed them while browsing the code for something I'm
> working on.
> 
> Stephen Boyd (4):
>   platform/chrome: cros_ec_typec: Use semi-colons instead of commas
>   platform/chrome: cros_ec_typec: Use dev_err_probe() more
>   platform/chrome: cros_typec_vdm: Mark port_amode_ops const
>   platform/chrome: cros_ec_proto: Mark outdata as const

For the series:

Acked-by: Prashant Malani <pmalani@chromium.org>

BR,

-Prashant
