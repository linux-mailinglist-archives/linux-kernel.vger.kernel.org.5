Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7C7B02CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjI0LZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjI0LZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:25:40 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA50180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:38 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-5041ea5abb6so15482450e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813936; x=1696418736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mpo8HY1lxvqmx97jvOfRTD6LY/4QndhKsDHjqUrtCfE=;
        b=MkJaiaJbBLYotnvrRbk6Rjo9stHVueN71k5Xcwazk/ZA7ZdUukTgpZ/QsiZIEhs1ec
         UsIt8iIipJ+FdzDw1FANyDEp+BsYqy60m0Q7IybsXnVY4Z5wjO1CY5WY++vjFUT7lmIh
         Bh7N/0GBnG5vsl6qHYZNTHpk6SAEhGKykTXtA1O2GBpDFSufpOoV2qII7bj6mBtsJrxY
         LKHl8oHjdG4QQ9zCt1xOJsqcclsWqDoaERfkvDTKWEn1nSZrK367y6afkEhw7GR4VFhc
         UG4l1AUZqfcLLtyzlgNicfJd8lhgZpBRewUPsebgg+Lk8jjs9U0HZYKb0Rb+m5ZCl9zr
         GnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813936; x=1696418736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpo8HY1lxvqmx97jvOfRTD6LY/4QndhKsDHjqUrtCfE=;
        b=AhVT6l0yS0dcPUsSkl4c9hG9YnnhVGuvQWkPntwfSAbeNEcqTHlaJVcZS95L8ckmKa
         B7aZz+prlHv8BpD13hV0i2rDsbhTYLf/VFFfAlH9fN5toucvp+yv1tm1vAFqrGonF9Iy
         N0UlwUXEPLjnajogPjBe8BQ2yc5YTIGCMHtdSNsfuxCfEM3wHb60zc306tWqjEoOAxQN
         h/4p+/Q7Z7NU7qbCRJ3n5GAS+h8cdKiJkSHkfc/O7PbKcWcf6btFPBeVPCqyToUa8vsM
         OcizjSLDD1IrL2ncxzmS3GWg5kzDZFzsZwcbQ4E44oEx8i98V2UPPFoPnHuP+NNsA/ol
         UIjg==
X-Gm-Message-State: AOJu0YyTLHqgn6P914qDE6qvl8ob9lPdx2Kz636nB/BLqLBy6zlxgJjm
        63h7Wo3N4DGykAd7Mrh+FZrWfWlvhZ+xtee3xt3jcb7v7ZM0MT4LnBR3UEun8Nx1aKu2SrM0GwB
        XnIbzIbQMJPbIk2AqXKU003kndyBocfzSARJycFHXeYQ5MbkDqBRK7cK+kayMS+qM80GG25JcTN
        GQoOr/dekbIw==
X-Google-Smtp-Source: AGHT+IFCUMvOU6dYI7YYyHaY/WEp0nWoX3WyuXi5Z2T0yXYcioBKy8ZbRRee8GmPhfluop6EzBNS1H/MZoTk2+oKrbU=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:ac2:43b5:0:b0:503:2e24:5692 with SMTP
 id t21-20020ac243b5000000b005032e245692mr8242lfl.5.1695813936285; Wed, 27 Sep
 2023 04:25:36 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-1-sebastianene@google.com>
Subject: [PATCH 00/11] arm64: ptdump: View the host stage-2 page-tables
From:   Sebastian Ene <sebastianene@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, will@kernel.org, ryan.roberts@arm.com,
        mark.rutland@arm.com, maz@kernel.org, vdonnefort@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This can be used as a debugging tool for dumping the host stage-2
page-tables under pKVM envinronment.

When CONFIG_NVHE_EL2_PTDUMP_DEBUGFS is enabled, ptdump registers the
'host_stage2_kernel_page_tables' entry with debugfs and this allows us
to dump the host stage-2 page-tables with the following command:
cat /sys/kernel/debug/host_stage2_kernel_page_tables

The output is showing the entries in the following format:
<IPA range> <size> <descriptor type> <access permissions> <mem_attributes>

The tool interprets the pKVM ownership annotation stored in the invalid
entries and dumps to the console the ownership information. To be able
to access the host stage-2 page-tables from the kernel, a new hypervisor
call was introduced which allows us to snapshot the page-tables in a host
provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
as this should be used under debugging environment.

I verified this series with Qemu and Pixel 6 both using kvm-arm.mode=protected.

Thanks,

Sebastian Ene (11):
  KVM: arm64: Add snap shooting the host stage-2 pagetables
  arm64: ptdump: Use the mask from the state structure
  arm64: ptdump: Add the walker function to the ptdump info structure
  KVM: arm64: Move pagetable definitions to common header
  arm64: ptdump: Introduce stage-2 pagetables format description
  arm64: ptdump: Register a debugfs entry for the host stage-2
    page-tables
  arm64: ptdump: Snapshot the host stage-2 pagetables
  arm64: ptdump: Parse the host stage-2 page-tables from the snapshot
  arm64: ptdump: Interpret memory attributes based on runtime
    configuration
  arm64: ptdump: Interpret pKVM ownership annotations
  arm64: ptdump: Fix format output during stage-2 pagetable dumping

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_pgtable.h          |  85 ++++
 arch/arm64/include/asm/ptdump.h               |   6 +
 arch/arm64/kvm/Kconfig                        |  12 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  18 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 103 +++++
 arch/arm64/kvm/hyp/pgtable.c                  |  98 +++--
 arch/arm64/mm/ptdump.c                        | 405 +++++++++++++++++-
 arch/arm64/mm/ptdump_debugfs.c                |  37 +-
 10 files changed, 716 insertions(+), 57 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

