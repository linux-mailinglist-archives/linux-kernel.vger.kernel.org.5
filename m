Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C253E7A314D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjIPQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjIPQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:05:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5A6CEA;
        Sat, 16 Sep 2023 09:05:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B214CC433C8;
        Sat, 16 Sep 2023 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694880333;
        bh=S2qkbqJUN4xM/JqgxAIPcZ9QPqdw1x0qxbnAG6qi9SI=;
        h=From:Date:Subject:To:Cc:From;
        b=AWe8B/ueBK2t4UyYJddPWXmVuk9ze7vxupYeN2zuT+AI49rY0QZe9Yrz88KgFsbiW
         nsQ0bsj0JuVew2/V8lik3fscX9UKl6IOuWEsTpYJj1glg4Q3YiRDSaMBiH2lCswJVM
         /0LqUFW/VXal2PcqsZaRuu32A5RtlPSt3XpTyQMgLUyxysY3wbFF2Rdv6IFsRwuBBe
         nci3hFlACwWUDei4sruRZ8yFmViC42w+kKET1iNGRLbfkWzqfh8kg46dM2rcGrcJOF
         zI9I5H4KOU3/tV22VOBBKKzKogVMeZvllB4NWLYewJOYk2saZmGZSZBVaL5LddiNzC
         p1eE1p85fl8/w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1cca0a1b3c7so1875801fac.2;
        Sat, 16 Sep 2023 09:05:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzv1CP1sErJ+gK2BgyemJUuNyJqtGnpUpJA5zZHz0fnZocZTiJs
        M2aSiYVqmZwop48PfwJgHgNobwt1P4DDVFmdiL4=
X-Google-Smtp-Source: AGHT+IFcpWqM0FMulwBLx6nLMKbGzaLif3RRVnEQhzhZWUhK2fWkZwISYWXv5CtVXyWeS5Coolp8iG284TNHVQNxTzo=
X-Received: by 2002:a05:6870:58a5:b0:1be:d9cc:d902 with SMTP id
 be37-20020a05687058a500b001bed9ccd902mr5272238oab.57.1694880333068; Sat, 16
 Sep 2023 09:05:33 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 17 Sep 2023 01:04:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCV9WGKeDyR+ymZsq5QBbNVU3bqS_0U230BTpRLFcnBw@mail.gmail.com>
Message-ID: <CAK7LNATCV9WGKeDyR+ymZsq5QBbNVU3bqS_0U230BTpRLFcnBw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild fixes for v6.6-rc2.
Thank you.



The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.6

for you to fetch changes up to 552c5013f2bc648611395ea80df6250aa4fe28f6:

  kbuild: avoid long argument lists in make modules_install
(2023-09-15 02:39:24 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.6

 - Fix kernel-devel RPM and linux-headers Deb package

 - Fix too long argument list error in 'make modules_install'

----------------------------------------------------------------
Masahiro Yamada (1):
      kbuild: fix kernel-devel RPM package and linux-headers Deb package

Michal Kubecek (1):
      kbuild: avoid long argument lists in make modules_install

 scripts/Makefile.modinst             | 2 +-
 scripts/package/install-extmod-build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)




-- 
Best Regards
Masahiro Yamada
