Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92FA7D78BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJYXki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:40:37 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C68181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:40:34 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3b3e82429edso360456b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277234; x=1698882034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ax/nU1ZFqft8oVl1VFeTyrFHvNYL9G6jLEqvbbsuZrc=;
        b=NmMxsQ5GzeRKJWkJBxrvU19M2uiKWMwBZb6QsHF3qCL+TaTYI2ErHdJ1TpBPXm8EV3
         sV/v3UPI8Vcdj/Va8l80QY5oR174EKVYqBmjI3OyKp79KdeXkjezPf0bICgHhRKHSeE/
         983jJcTHfzQBUSq4IitnOIYUCngp+O+J8kyTq31q9LrGpPCBqjWU7DeZDw6+c/nt1r6C
         RhV3V0w9LrPq57o75T6aQMJJUeINh6MDWrPdVRad+bn5JK0FnDlFiMxBZ87wOPymRqmy
         7ZJGawZ2M0d3dI1rRCc28K7nhSYMz1Z9hL27UnTd3oOowyMvxGlKHfxAnMbkUDRNXwVz
         dOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277234; x=1698882034;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ax/nU1ZFqft8oVl1VFeTyrFHvNYL9G6jLEqvbbsuZrc=;
        b=dLmRovfq0oWofKQqybo0ZldjdQpcrvG5umnHrYdqnDwAqTje0roDnM4nePrtjYjE7x
         2x0avsbIAyRPF9UFx05fnTxJwYt963vRFWi1zm9sfR41zfojyLPFBXEHZATEsMcNCDo6
         MLBdrVrHhwi0ekri/f6BjF5vfrzJQolw+ncYp0iXI6a7LVq58ZkjBjBtgq19T2P1XFh+
         LqbNAlExo9x5a7+x5g8rgr7G8AxtPaqfKLFK0Oa/SXZ6N1UbM2PH2qSa2LJ8K6Jcs4C/
         1m/Od61MQ4KrA+bPAVC+nn/FSIcqAf1k/QdaTzfyn2nA/TE2EnQNH/ZL2mvxFCVjCD1X
         DZRQ==
X-Gm-Message-State: AOJu0YxWBvh1IVZXEafFEbb64YwEbmDRczNqmTva9Gvg+RI5nPWZ6nEb
        ep5sD2m0VuZkHvzc9Gj+Kk1sMpCH+cCwJdPayA==
X-Google-Smtp-Source: AGHT+IHw/k5Q9J8vO1CuX5M/j0RoZQarFU1nkp8HN+n7tSv4SkiAOjOO7FMq1mjjWL8SudfGtRgbLzDKikkpHA3p+w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:aca:211a:0:b0:3a7:45f6:4b3f with SMTP
 id 26-20020aca211a000000b003a745f64b3fmr5446803oiz.3.1698277233982; Wed, 25
 Oct 2023 16:40:33 -0700 (PDT)
Date:   Wed, 25 Oct 2023 23:40:31 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG+nOWUC/x3MQQqAIBBA0avErBPUiqirREjZWAOVohZBePek5
 Vv8/0JATxigL17weFMge2aIsgC9TeeKjJZskFxWgsuGYdyitbtyVwyKDrezSdRtZ8ysW+SQO+f R0PM/hzGlD3eMzaxjAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698277232; l=3351;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=UeXhj1yUBRkd9WratOksK7CyAy5xMK0mPYfyx10bxZQ=; b=0w8LuFAfNlkvjcs5D4bU1gmw4mc0Z8LGR5Gx0Qu+E7eSP/aJ0ejYYmvSor7LgEkb5foJS31Xr
 L/Z9/AOw7F9DSBIfksjjQWnDSVIKPwwS5pRG348fL+1FujQZ1dqzFFE
X-Mailer: b4 0.12.3
Message-ID: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
Subject: [PATCH 0/3] ethtool: Add ethtool_puts()
From:   Justin Stitt <justinstitt@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to implement ethtool_puts() and send out a wave 1 of
conversions from ethtool_sprintf(). There's also a checkpatch patch
included to check for the cases listed below.

This was sparked from recent discussion here [1]

The conversions are used in cases where ethtool_sprintf() was being used
with just two arguments:
|       ethtool_sprintf(&data, buffer[i].name);
or when it's used with format string: "%s"
|       ethtool_sprintf(&data, "%s", buffer[i].name);
which both now become:
|       ethtool_puts(&data, buffer[i].name);

The first case commonly triggers a -Wformat-security warning with Clang
due to potential problems with format flags present in the strings [3].

The second is just a bit weird with a plain-ol' "%s".

Note that I have some outstanding patches [2] (some picked up) that use
the second case of ethtool_sprintf(). I went with this approach to clean
up some strncpy() uses and avoid -Wformat-security warnings before
discussion about implementing ...puts() arose. I will probably let the
ones that have been picked up land but send new versions for others.

Wave 1 changes found with Cocci [4] and grep [5].

[1]: https://lore.kernel.org/all/202310141935.B326C9E@keescook/
[2]: https://lore.kernel.org/all/?q=dfb%3Aethtool_sprintf+AND+f%3Ajustinstitt
[3]: https://lore.kernel.org/all/202310101528.9496539BE@keescook/
[4]: (script authored by Kees)
@replace_2_args@
identifier BUF;
expression VAR;
@@

-       ethtool_sprintf
+       ethtool_puts
        (&BUF, VAR)

@replace_3_args@
identifier BUF;
expression VAR;
@@

-       ethtool_sprintf(&BUF, "%s", VAR)
+       ethtool_puts(&BUF, VAR)
[5]: $ rg "ethtool_sprintf\(\s*[^,)]+\s*,\s*[^,)]+\s*\)"

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Justin Stitt (3):
      ethtool: Implement ethtool_puts()
      treewide: Convert some ethtool_sprintf() to ethtool_puts()
      checkpatch: add ethtool_sprintf rules

 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 66 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       | 10 ++--
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
 drivers/net/hyperv/netvsc_drv.c                    |  4 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
 include/linux/ethtool.h                            | 13 +++++
 net/ethtool/ioctl.c                                |  7 +++
 scripts/checkpatch.pl                              | 13 +++++
 18 files changed, 120 insertions(+), 90 deletions(-)
---
base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
change-id: 20231025-ethtool_puts_impl-a1479ffbc7e0

Best regards,
--
Justin Stitt <justinstitt@google.com>

