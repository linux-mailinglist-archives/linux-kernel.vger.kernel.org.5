Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B47BF252
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442127AbjJJFjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378580AbjJJFjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:39:40 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2592;
        Mon,  9 Oct 2023 22:39:38 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c8a1541233so14094005ad.1;
        Mon, 09 Oct 2023 22:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916378; x=1697521178;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au6Nx9TnUJPD8zSiRBmFk2cposcSdk1o0pXT9wfYC5E=;
        b=hUBiMb0zSGQF75XqBybSe1Bca/uJMF8MBJi7HEYevEYCyFmQjZPAnjMG5Rm0nAq3Vj
         /Pi+76iWUKgV1R8nKU0J6fSc7ZMhyc1E8bnGs9KoL+hQKe2NxWUYFOdXBzaBPpaaOtC5
         C+s5k7JRrILU7RgpDWpUl3GloRr8+Dh9WIwGQFBTgkjvUgxZ+BIbfyQO4Gi/U8xexSvM
         etp6mNZi74gkRGAIfN4+n3AGFlZIlI+YyXwDFTE9RaUJXaekbHxZEzFSw28NvZtQrdiP
         7cRAE7tzayPk89dnSWsYggXRMV2ANcJDZrqc3U35DMvwTX2/51wk7MyHD0Gj7ohm3o9q
         Qocw==
X-Gm-Message-State: AOJu0YzGJMqqb2GvLiiRNOuejAQDgMfESGfW4nKgMc6HtzFm9lfWA9ed
        YMHYCwfADxrnwayuWL8+f2o=
X-Google-Smtp-Source: AGHT+IG+iTZxeF8sSqUxSo6CL6v/dyUbR6XlzP422btQibVNaZowGqHy9yXyfZowgqqXf8lgH3L41A==
X-Received: by 2002:a17:903:246:b0:1c0:b84d:3f73 with SMTP id j6-20020a170903024600b001c0b84d3f73mr16875833plh.53.1696916377478;
        Mon, 09 Oct 2023 22:39:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001c6052152fdsm10599982plf.50.2023.10.09.22.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:39:37 -0700 (PDT)
Date:   Tue, 10 Oct 2023 05:39:35 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 6.6-rc6
Message-ID: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231009

for you to fetch changes up to 42999c90461293233de9bb6e6c7d8a2db7281c1e:

  hv/hv_kvp_daemon:Support for keyfile based connection profile (2023-10-10 03:42:29 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.6-rc6
  - A few fixes for Hyper-V VTL code (Saurabh Sengar and Olaf Hering)
  - A fix for the hv_kvp_daemon to support keyfile based connection
    profile (Shradha Gupta)
----------------------------------------------------------------
Olaf Hering (1):
      hyperv: reduce size of ms_hyperv_info

Saurabh Sengar (3):
      x86/hyperv: Restrict get_vtl to only VTL platforms
      x86/hyperv: Remove hv_vtl_early_init initcall
      x86/hyperv: Add common print prefix "Hyper-V" in hv_init

Shradha Gupta (1):
      hv/hv_kvp_daemon:Support for keyfile based connection profile

 arch/x86/hyperv/hv_init.c       |  20 ++--
 arch/x86/hyperv/hv_vtl.c        |   3 +-
 arch/x86/include/asm/mshyperv.h |   2 +
 include/asm-generic/mshyperv.h  |   2 +-
 tools/hv/hv_kvp_daemon.c        | 233 ++++++++++++++++++++++++++++++++++------
 tools/hv/hv_set_ifconfig.sh     |  39 +++++--
 6 files changed, 253 insertions(+), 46 deletions(-)
