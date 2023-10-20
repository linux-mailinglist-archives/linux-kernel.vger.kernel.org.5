Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1907D0B35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376609AbjJTJMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376611AbjJTJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:11:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DDD5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:11:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53db2f8d193so175350a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697793112; x=1698397912; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1zeu3U6ivsj2jxn3sF6BbQfaUq01JlO672pQGV3FBXQ=;
        b=nl0VoGqJe1wuYvGecJsbrqUZdltLRtrEaw3XWiTJTOK4wzqNHuK8MaaK6sctoEhofl
         c97AWVmwaQBCOtzR+u9uqMXmVR408nO1Eqv6uQa2lYC00IedYEUBY1vWDrDW+cQ+H/1s
         DkTTIeZ7zlnjCo+W5iHZEw5PxlYHStf4yir4XkEwNVt5U3TEZem92UfJcpTbjRYXA2rW
         0J0ZN9wOVwK9L9vwjZs0AoI9hiQSFeVU39IF8MTa7l3oVwft45+PwgNZQB6lthR/jwhC
         AgN62oG2qVMB8seeE2GjDvvyzb2fucVVGkn9i3yl6nbGa7zFxS7Q8PezHEd6ODu6JxW0
         Q4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793112; x=1698397912;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zeu3U6ivsj2jxn3sF6BbQfaUq01JlO672pQGV3FBXQ=;
        b=KbBwDfh3Lf2ztuCeVLjkHmT+XXQkfbtLpK3u0G3BtEsLNQjSUOFP/ZyNvC4dlbVNra
         myEFOVQzly9yyVB2ijm4YljVeQ786nG79GNW8SAYb9FFCQB3lmrPMJqRBu0SDvMM+S+g
         +cReBRtsR9hACg2FzbwLxYi1sXmqa1YtMVWjQH3QBUDr285xolTxBxmqfrQkpIgP3YoD
         dGR2bAW4JJTCEoVeeHv1vOsIyW7t3PQQo7QQBZxB9WxsGKYFBpy2ih2IdkSxH18Vvd5u
         LScErPQR7cJwqnQ9cpyNUdNvW9t+sm7MWyjB6jDqUgDsQjPjBQ+/AMMjV6TFXZtrVKXY
         +0aA==
X-Gm-Message-State: AOJu0YzX1cYdxLTF5kSr73FeR37aLJQOQCsJAt7TbQEuobJyUMLPticc
        S44iZprmZjOaFlw2PjGerUJP4S0Gg4xATg==
X-Google-Smtp-Source: AGHT+IF4KBbAiFc7sTwB2gifxGfQbLIX7LgETQ9qcZIQtqzDp/bxnHTb46teaPMrBuLXI46hTT+P3A==
X-Received: by 2002:a17:906:cb:b0:9b2:bf2d:6b66 with SMTP id 11-20020a17090600cb00b009b2bf2d6b66mr629924eji.7.1697793112038;
        Fri, 20 Oct 2023 02:11:52 -0700 (PDT)
Received: from ariel (dynamic-2a01-0c22-358a-4300-dabb-c1ff-fe05-d863.c22.pool.telefonica.de. [2a01:c22:358a:4300:dabb:c1ff:fe05:d863])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906011a00b009ae587ce128sm1066830eje.216.2023.10.20.02.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:11:51 -0700 (PDT)
Sender: Emanuele Rocca <emarocca@gmail.com>
Date:   Fri, 20 Oct 2023 11:14:43 +0200
From:   Emanuele Rocca <ema@debian.org>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>
Subject: Runtime overhead of PREEMPT_DYNAMIC
Message-ID: <ZTJFA_Ac6nWawIHb@ariel>
Reply-To: ema@debian.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the Kconfig help for PREEMPT_DYNAMIC states the following:

  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enabled
  but if runtime patching is not available for the specific architecture
  then the potential overhead should be considered.

I've tried evaluating the practical runtime overhead of PREEMPT_DYNAMIC
on my Ryzen 7 x86 workstation and it does actually seem quite
significant, for certain workloads.

I tried four different workloads: the first two are userspace-heavy (ie: the
CPU spends most of its time executing at the user level, as reported by sar
%user). There is *no* significant performance difference between a kernel with
PREEMPT_DYNAMIC=y and a kernel with PREEMPT_DYNAMIC=n for those:

1) compressing data with `xz -T 0` (less than 1% system)
   dd if=/dev/urandom of=/dev/stdout bs=1M count=1024 | xz --stdout -T 0 > /dev/null
2) building a kernel (10% system) 

The third and fourth benchmarks are kernel-heavy (ie: most of the CPU time is
at the system level, as reported by sar %system). The performance difference
between PREEMPT_DYNAMIC=y and PREEMPT_DYNAMIC=n is quite visible for those:

3) load testing nginx (35% system)
4) tbench (90% system)
   see https://www.samba.org/ftp/tridge/dbench/README

Details of the nginx benchmark:

- 'hey' (https://github.com/rakyll/hey) HTTP load generator version 0.1.4-2
- nginx 1.24.0 serving the default 'Welcome to nginx!' page
- logging to disk disabled with `access_log off` in nginx.conf
- hey -n 2000000 http://localhost/ | grep Requests

Results of the nginx benchmark:

- PREEMPT_DYNAMIC=n 102K rps
- PREEMPT_DYNAMIC=y 96K  rps
- 5% performance degradation with PREEMPT_DYNAMIC

Details of the tbench benchmark:

- tbench version 4.0 https://www.samba.org/ftp/tridge/dbench/
- Run /usr/bin/tbench_srv in a window
- Run /usr/bin/tbench `nproc` in another window

Results of the tbench benchmark:

- PREEMPT_DYNAMIC=n Throughput 3831.82 MB/sec
- PREEMPT_DYNAMIC=y Throughput 3006.54 MB/sec
- 20% performance degradation with PREEMPT_DYNAMIC

All the tests above were performed using Linux 6.5.6 on a AMD Ryzen 7 3700X
8-Core CPU.

Could someone please confirm whether the approach above seems sane and perhaps
try and reproduce the results?

Thanks,
  Emanuele
