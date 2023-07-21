Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E075CE11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjGUQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGUQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:17:14 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40749D9;
        Fri, 21 Jul 2023 09:16:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso86015739f.3;
        Fri, 21 Jul 2023 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956166; x=1690560966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/l8OpS8ap0ng9Sg4kCrHOpVy2d8hstaLnlMyOeunQs=;
        b=LLCq4O3f0NKmWdPchHTY/a+Q4bAnwUoU1rDob9wpbm0rgJvHe9BPx7F6LQfaOvGUUF
         urwn95Itpe1mUGl6Q82O4psp/dM93Clnj/Jb4VN9FFznJKqNNH0I9C2eiY07NNY4kooe
         ebBt48Yn3xBnpnukJNHSm4agCJ3TCysswYQfeCQF5SuQlDMwVXNRCGLnnSeI2bNuhgDB
         Dy1pVy9zCAIgooMRBQrwCDz0m5f2wBl0lLWOhb/2r/K0KDLlfaDN0411sHU3IOcQq7Pn
         /gvKuEVbx0wszowvTlyQ54ROD9il+pfaqBN+VJIzWsEd2VMLb1bY8Qxs0tns4umep3/M
         AiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956166; x=1690560966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/l8OpS8ap0ng9Sg4kCrHOpVy2d8hstaLnlMyOeunQs=;
        b=LQcwcb7XqRtnGzbeXreqcbBNg1JaG5j+SA5KvpDd78ujf9v53aRjFQOhglknwckaWx
         vpEBwnJ8nboQ4kD0E9JVV+vR1DzX+EwXhMm7Xoy9juqt8klezVPNum+P7DCqkbQA93zW
         XRc3am2ntnipa5HnI2489YN51I35hjTqe1xMIMgpc9QD42euOIAwqLKYkDev/39bFpzh
         f/K6l7JqPPAxtQD25BPV1EZ5Q4XsggPsRaeYVz8ffiUg4HjuedcdBEfQusyNzXPrsAC/
         7A1l7hVXlBvI4yFdA794koiZJ0ZXeT7ydUqjeV+SNhogL7LLPj02azNJymsNuh9RdzqA
         D+Lg==
X-Gm-Message-State: ABy/qLau15w4VtAw9CxauRp6au5KyyRcsw1z+5sWiWfFvN1OSwj+AX8u
        luiikx04PJxDi7M47OJeWZE=
X-Google-Smtp-Source: APBJJlEbtU/eaqk2P4pSha+vWyE/alULVBQK5VUa2Se8E5kEwTys/VlS7+apdqlxWfZt5z7YBOLO0A==
X-Received: by 2002:a05:6602:2206:b0:785:d4f5:2225 with SMTP id n6-20020a056602220600b00785d4f52225mr451309ion.19.1689956165895;
        Fri, 21 Jul 2023 09:16:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a02c044000000b0042b534e9f52sm1109126jam.59.2023.07.21.09.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:16:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jul 2023 09:16:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
Message-ID: <6d36f9be-5236-45c0-9af1-7004c2604d86@roeck-us.net>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:09:31AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here's a small series to address the lockdep warning we have when
> running the clk kunit tests with lockdep enabled.
> 
> For the record, it can be tested with:
> 
> $ ./tools/testing/kunit/kunit.py run \
>     --kunitconfig=drivers/clk \
>     --cross_compile aarch64-linux-gnu- --arch arm64 \
>     --kconfig_add CONFIG_DEBUG_KERNEL=y \
>     --kconfig_add CONFIG_PROVE_LOCKING=y
> 
> Let me know what you think,

The series fixes the problem for me. I sent Tested-by: tags for
both patches individually.

Thanks,
Guenter

> Maxime
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Maxime Ripard (2):
>       clk: Introduce kunit wrapper around clk_hw_init_rate_request
>       clk: Introduce kunit wrapper around __clk_determine_rate
> 
>  drivers/clk/clk.c            | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk_test.c       |  4 ++--
>  include/linux/clk-provider.h | 21 ++++++++++++++++++
>  3 files changed, 74 insertions(+), 2 deletions(-)
> ---
> base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
> change-id: 20230721-clk-fix-kunit-lockdep-c5e62b221118
> 
> Best regards,
> -- 
> Maxime Ripard <mripard@kernel.org>
> 
