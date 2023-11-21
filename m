Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70507F33E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjKUQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjKUQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:36:10 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6882D4D;
        Tue, 21 Nov 2023 08:36:06 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5c9ea2ec8deso27201887b3.0;
        Tue, 21 Nov 2023 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700584566; x=1701189366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opRF3HI9iR1tOh502sQV3zy4KipFZOtaQ8YiI2ePgfU=;
        b=Bt8xfJCUqmJ4qDLUvdO/UVSLfvdODqyTAgSpdNyNMMiJqncTwaAelTLZcLEE3f5hoy
         zYhtkVjMEjNpn9+TF9x6EFusZH69B9jus4A3xEJh2Pf/nRUaolR3gPgyBrD1UhY+UfKQ
         Rwsy3l0FS7BbOa8Om5kaNqq8XdcfOOrS17DmRuYVwjuYYbO+cs363uIoXopsgWbd2UvM
         rScNYoyr3VYHucU9b7EEZ1dKIqIkKWFD/Crt7cCEfvc6bjfQprEhBXc1wPlcxV2JS8wV
         svH0tEXSmro7I1R/O3ewxsmpHxxjNKHMFzjXw7854eFWYgW1WqzS/uIEGh7tPIn1LUPd
         LI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700584566; x=1701189366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opRF3HI9iR1tOh502sQV3zy4KipFZOtaQ8YiI2ePgfU=;
        b=Kph3HJaB5izxU5D1tl42piTNu4MRQlFzLsaODvtCCdgKD32DGwdW4/ydGoxGIxWZTT
         xkFIX448FBZXRH26OyuSFXNEoWxafrJAUTXv5sl98+ldLejUTbbBsbjLvq0lHInGbhrZ
         leh+4pOpev59yrIUagGm8cAP0MWzHdOyX4JY/VK94uA+MgObwW4YFUAahZk5XbVvAWkg
         JthupfxnPz3k+4/Wq3P9CtR3iIYEZCGcy+UdnDOdoyS47F9BFoJ+raf0l9rPVwJK5YnB
         epFH1d0VSRie2Qk5sBdqQ3zFM3Yh6h9Jvvdpu4Ygto3WBoraLdfFozONyUBcqymdMPUb
         +wEg==
X-Gm-Message-State: AOJu0Yy7fzOdA0RObqVP/ESIftPEhn8151h2iOcvvMWvK8Ji4ziL7Sum
        F3sK0flX0Qv8ITgN1QmnD9I=
X-Google-Smtp-Source: AGHT+IFNHwwELprTDsHUGjfjGbs5039qmlFSUWH64MnHs1X/fR3tPVjej4du8LTpUEsFqN5XQNpe5A==
X-Received: by 2002:a05:690c:884:b0:5ca:e8a:adb1 with SMTP id cd4-20020a05690c088400b005ca0e8aadb1mr8158748ywb.1.1700584565985;
        Tue, 21 Nov 2023 08:36:05 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id y7-20020a0def07000000b005a247c18403sm3169406ywe.37.2023.11.21.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:36:05 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:36:04 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 12/34] wifi: intel: use atomic find_bit() API where
 appropriate
Message-ID: <ZVzcdKb1plk/Qose@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-13-yury.norov@gmail.com>
 <098e2983ac299cb3b33bd0a8e33aaab8d6235909.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e2983ac299cb3b33bd0a8e33aaab8d6235909.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 08:58:25PM +0100, Johannes Berg wrote:
> On Sat, 2023-11-18 at 07:50 -0800, Yury Norov wrote:
> > iwlegacy and iwlwifi code opencodes atomic bit allocation/traversing by
> > using loops. 
> 
> That's really just due to being lazy though, it could use a non-atomic
> __test_and_set_bit() would be just fine in all of this, there's always a
> mutex held around it that protects the data.

Ok, then I'll drop the patch.

> Not that it means that the helper is _wrong_, it's just unnecessary, and
> you don't have non-atomic versions of these, do you?

Not yet. If atomic find_bit() will get merged, and there will be a
set of potential users of non-atomic version, I may need to revisit
it and add those non-atomic functions.

Thanks,
        Yury
