Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468697B393E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjI2R6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjI2R6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:58:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CFBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:58:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27777b778bfso5886838a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010328; x=1696615128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fRXdathML3bYGsncvTXhzykCOBsh2UnNLFrC9MynRo=;
        b=AmT6e5uuYM5lVl19zpwhB0iia610yHQr2PM3DysBa9bLYQOtpdYNWimqzvwijzgs9b
         0kN93qDS9pi/hs/i10+TIv9cGpkjpuBccGuYiHpveyS7UzeRdTQRuYw6IgFVjM2+6p4R
         qCDHdDHuwPNT6YiTlD5IOpJsbCpfpwEGOouSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010328; x=1696615128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fRXdathML3bYGsncvTXhzykCOBsh2UnNLFrC9MynRo=;
        b=LRHe4yqbuzILYHeyGYzQtVtmlXpCvqWjuhzZtR+mTDkoIeh+aG6ds0OZJG75RP0Y3w
         sKA0BMP8EoYEqW1nWvB8WzYKW3oy8gDRrj4WnLgxJcLV2/WXPqU91qX5szFMEDczE5K5
         DrvAbqiP4Rm5hprkRtYwEbVTEqfXjznkJrcCZmNuQVqp0f5YU+UqY2XM8xWQ7iJXlpbJ
         pmK4Dd3XY5ptYUfYBAZhId/uFpisBCoGvtB89aqGRMbEASBsviPlCORzTD1oW+1p2yhd
         9sdPSorXpyQ6+cc1zxrbk4IFOYjfh6PJwqWWd54I9AGrj/EWxNJvGwLURZJzwRVXfXNM
         8wTw==
X-Gm-Message-State: AOJu0YwHb78vINVkaUdSjXMiFIEHqPW+wJOeAFukgk6tg0d+63KZuJvS
        9bY/ZIVKMracXJyOkb0j/UTYhg==
X-Google-Smtp-Source: AGHT+IFWxq15KNyr+KAGXrqBfg7EjnMU3yh7JX/yF2ZRfFH9VCutKUHvZvdmN/YOyDHMYHAhrc+UfQ==
X-Received: by 2002:a17:90b:4c8e:b0:276:a310:2be3 with SMTP id my14-20020a17090b4c8e00b00276a3102be3mr4615896pjb.19.1696010328112;
        Fri, 29 Sep 2023 10:58:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bj16-20020a17090b089000b00276a58e37c1sm1767242pjb.38.2023.09.29.10.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:58:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, palmer@rivosinc.com,
        ebiederm@xmission.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_elf_fdpic: clean up debug warnings
Date:   Fri, 29 Sep 2023 10:58:42 -0700
Message-Id: <169601032029.3005029.10504001720993389780.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927132933.3290734-1-gerg@kernel.org>
References: <20230927132933.3290734-1-gerg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 23:29:33 +1000, Greg Ungerer wrote:
> The binfmt_elf_fdpic loader has some debug trace that can be enabled at
> build time. The recent 64-bit additions cause some warnings if that
> debug is enabled, such as:
> 
>     fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file’:
>     fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘Elf64_Addr’ {aka ‘long long unsigned int’} [-Wformat=]
>        46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
>           |                                 ^~~~~~~~
>     ./include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
>       427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>           |                         ^~~~
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt_elf_fdpic: clean up debug warnings
      https://git.kernel.org/kees/c/35bcdcf3d50c

Take care,

-- 
Kees Cook

