Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7967F78E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKXQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKXQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2108199A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700843305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DMuuKTowyPDws4BIecBU/jtUc+x5ojc5dQmrhzizeMw=;
        b=FSH2Yt/QHemrNiZRNZqNgP0VFvcAE3d3rTap3v/GJjRCTZsHLOLP8gcPUQ7pV9fCO/36Tv
        UwTRyYWW9/AwHy42Zi7xwcLzNZztd57r7TiU7TEAaRhsYBHQ2V4IO/SN5/cmpDfd7+GTOk
        xShlFqvMgsG3KKGXm61gQwF0J6tzycI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-kpQDLaTYP0-0JD5fR2mc-Q-1; Fri, 24 Nov 2023 11:28:24 -0500
X-MC-Unique: kpQDLaTYP0-0JD5fR2mc-Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77d55e875aaso228314185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843304; x=1701448104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMuuKTowyPDws4BIecBU/jtUc+x5ojc5dQmrhzizeMw=;
        b=sAiiSjAVgGd2XeymANqaFgS9eu2im5NYoMtZtlslSm5plE77QkSZlBIKsnO35Jch1Z
         nxRffodpLM8K3hl+KNZJ8sev3zNb11YnbARjxJBJ5sqXa6nv12w/o4d5RublhlQr0WqE
         zlkAW9buC0hMLbA8wW7aQ3uZ3bVjBpS/fgZyMGhyjI7wLmdfgu89bSUeYGU3OX+kTLBl
         SL4inJgVer09pYM/GmegvCrNSweySQIzHAW+l4dBahXAilXzFV4ZQJbNO905cvZCvuUd
         /X3U3F2kpZLgiK1vyGh+OSt+YAXxLQ9YUEb5RlkABf+zUMr9LSZ1zvwYXFDaF0CgUzJm
         eRvQ==
X-Gm-Message-State: AOJu0YzyLhHDCcH9kpvVOqBUTgteOYe2gv1ifOq7fKtm99CsGjPLbTg3
        CaD63daXTmmLGKTH6YUNgHp0Q3wfijlCth4tlPusiuNMl2KgR4AxtCO+lXl0+TkRrE3RVtrIFVV
        +dF9p3A7kufs/RaVO47L17bg=
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr2960045qkn.14.1700843304038;
        Fri, 24 Nov 2023 08:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENvtRHrxOOH3LXMpZWWpNvzpDXaRq7vmDCk78z2mTT02BXioTGM6LwGddIXH2SrlpwvsPj9g==
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr2960030qkn.14.1700843303833;
        Fri, 24 Nov 2023 08:28:23 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id rk4-20020a05620a900400b007676f3859fasm1327608qkn.30.2023.11.24.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:28:23 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 0/2] fpga: improve protection against low-level modules unloading
Date:   Fri, 24 Nov 2023 17:28:05 +0100
Message-ID: <20231124162807.238724-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC proposes a possible solution to keep protecting the fpga
manager against the sudden unloading of low-level control modules while
addressing the limitations of the current implementation. Currently, the
code assumes that the low-level module registers a platform driver for
the parent device, which can later be used by the fpga manager (through
the parent device pointer) to take the low-level module's refcount. This
proposal removes this limitation by adding a module owner field to the
fpga_manager and fpga_manager_ops structs. Low-level control modules can
statically set the owner field to THIS_MODULE. Later, the fpga manager
can use the owner field to take the module's refcount.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

v2:
- Fixed protection against races during module removal

Marco Pagani (2):
  fpga: add a module owner field to fpga_manager and fpga_manager_ops
  fpga: set owner of fpga_manager_ops for existing low-level modules

 drivers/fpga/altera-cvp.c             |  1 +
 drivers/fpga/altera-pr-ip-core.c      |  1 +
 drivers/fpga/altera-ps-spi.c          |  1 +
 drivers/fpga/dfl-fme-mgr.c            |  1 +
 drivers/fpga/fpga-mgr.c               | 56 +++++++++++++++++++--------
 drivers/fpga/ice40-spi.c              |  1 +
 drivers/fpga/lattice-sysconfig.c      |  1 +
 drivers/fpga/machxo2-spi.c            |  1 +
 drivers/fpga/microchip-spi.c          |  1 +
 drivers/fpga/socfpga-a10.c            |  1 +
 drivers/fpga/socfpga.c                |  1 +
 drivers/fpga/stratix10-soc.c          |  1 +
 drivers/fpga/tests/fpga-mgr-test.c    |  1 +
 drivers/fpga/tests/fpga-region-test.c |  1 +
 drivers/fpga/ts73xx-fpga.c            |  1 +
 drivers/fpga/versal-fpga.c            |  1 +
 drivers/fpga/xilinx-spi.c             |  1 +
 drivers/fpga/zynq-fpga.c              |  1 +
 drivers/fpga/zynqmp-fpga.c            |  1 +
 include/linux/fpga/fpga-mgr.h         |  4 ++
 20 files changed, 62 insertions(+), 16 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.42.0

