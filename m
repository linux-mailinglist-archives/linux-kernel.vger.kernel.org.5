Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57A97F48FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjKVOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7419E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700663581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=if0lTIQhFuWRokgwIBfp5g8FVKKy/4t3RxOoc3DJYVs=;
        b=gk1ilWA5LbM9XhSDOKnA/LEwYStHGxY18hT3mHTEUwYjfl4WbFxAFqYYyQUPOEQmH1wlLx
        ftk/s1dtzi0fAKFVdMNLd7B7izA2z69onAKjz90U/xLdmIcRrOJWATduixkn15Hfc2G61Y
        dKx43slSZEmdH+BgpNYQBhVPxlECojk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-cMU-XK46M72rFBFc-61wIg-1; Wed, 22 Nov 2023 09:33:00 -0500
X-MC-Unique: cMU-XK46M72rFBFc-61wIg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-421ad98a611so94653711cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663579; x=1701268379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if0lTIQhFuWRokgwIBfp5g8FVKKy/4t3RxOoc3DJYVs=;
        b=rlsN+lWGIr48SwUKGB64n7mD0HOSGtSXx1lxBOsHTg+ARvb+9Pe7g5BQh0KKbx88Wx
         QfPlHYVvSgK8EWQizGNahPt9+5+DOSh1sTm1/Lck9MBr51jZTF1sa5XCYqf27HNvT6dm
         iID4qe+pBIA6f9+CxmN61KvrWXmUFwNH/tcVJe4AJN96VwgBJgvoxltubrb0N1Bwzoie
         CNuspwldW2RBmiBC3hHU9kiJvkrQCHmWT6h4YLy4K0FgtZ1CThpynbb3cS2z5XNHJGD6
         oZg/IGfcnwfQW7mK1XsVaDtuXC1fA3z9rH4kk0mOkyabLRgCA6zap8pnweLYONBnw/re
         30BQ==
X-Gm-Message-State: AOJu0YzXSovF3UE9BcVi/4TEbOPNTt/jS1cgRYBFitte3ED0hCte3TmA
        0oBPbEDboZwhxHqV1CFHeBskqvf3Ktqvmh8lEVIEsfYIy7PLV654ZgdPqp2ufbLpi8lc8x42tJF
        QeuAerUImHDe+OgOPci43t8lNejGyTuY=
X-Received: by 2002:a05:622a:120e:b0:421:c3a9:1e52 with SMTP id y14-20020a05622a120e00b00421c3a91e52mr2696729qtx.31.1700663579317;
        Wed, 22 Nov 2023 06:32:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxPsf924/xjwAZvoG0CEZ1YKtPUQiLpYymPo32gafiI5TVBLwkn6DBRalXtRx2dAlFoLJdYA==
X-Received: by 2002:a05:622a:120e:b0:421:c3a9:1e52 with SMTP id y14-20020a05622a120e00b00421c3a91e52mr2696697qtx.31.1700663578935;
        Wed, 22 Nov 2023 06:32:58 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id v7-20020ac87487000000b0041950c7f6d8sm4430101qtq.60.2023.11.22.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:32:58 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/2] fpga: improve protection against low-level modules unloading
Date:   Wed, 22 Nov 2023 15:32:50 +0100
Message-ID: <20231122143252.181680-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC proposes a possible solution to keep protecting the fpga
manager against the unexpected unloading of low-level control modules
while addressing the limitations of the current implementation. The
current implementation assumes that the low-level module registers a
platform driver for the parent device, which can later be used by the
fpga manager (through the parent device pointer) to take the low-level
module's refcount. This proposal removes this limitation by adding a
module owner field to the fpga_manager and fpga_manager_ops structs.
Low-level control modules can statically set the owner field to
THIS_MODULE. Later, the fpga manager can use the owner field to take
the module's refcount.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

Signed-off-by: Marco Pagani <marpagan@redhat.com>

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

