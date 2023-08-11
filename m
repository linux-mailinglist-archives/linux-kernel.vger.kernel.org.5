Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC07788D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjHKIP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHKIPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:15:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95F26B2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:15:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-986d8332f50so242419566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691741751; x=1692346551;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oDkmG8AMB0PZhsRk/AuWjuYW0JcUlr7WxFGqyn/0xRo=;
        b=lpdPjcw/XCC/jltBBnwx21a9Fuf4Jjnq786RWgtwE07b7FCGsA2re+72vTWl6fdoOL
         QFaZIagiA4KbedL/1C2nwZh31x5pysQBgMr+89fYOYomPhzalVlE5yqxEeFEEgx1FrHR
         oc6HXfqot42ihv7dcJjNE84ICveulqUy5davo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691741751; x=1692346551;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDkmG8AMB0PZhsRk/AuWjuYW0JcUlr7WxFGqyn/0xRo=;
        b=A1vKOoFFffmndSDmaXg1WNAloWAjYAKr/wiib9q+EqUm4lopZltEQDNfACowSiJDSc
         uOxI/wyrER1Z0HRVFZzgjC4VlyfUHSzdN+FMV+a+ftfVY+33kp1mS86JklZWjqd+xW8v
         PJZrrPxGhgBRgbrxKfjQJ3E3BCzhXT2Cf2phymiPIuVwtiu+5Mmn9KPfOQuQ6NiYRAiS
         XUxZ/2J3+wku6ZwkDw1/5BNGypmsIgszi+FB/rqZQl+IwpbkaUUcrJruXIO62JqV9G3w
         ZsmH+B/FaVLWyRhvd6aUO/+7Gb+2WunqAynRK+SbdjAKtSjq8k7PcNjQLP6DP9YFJz15
         XWWg==
X-Gm-Message-State: AOJu0YxQ8TOHQd5NeDuU+AFMhb5y4eEWgLjTnyEDIRRoCFcXlz+Ij6He
        K5xMI/ZXWC4Dr4BsEuT9GeiBGKMY7+PobVRCng4/XIAe5XA=
X-Google-Smtp-Source: AGHT+IEUNOgrIw7iuo7wj7/1tA3rrMDtxZLcgMV5bBG+Dg3420g0khsXBKbLj8Nsn06LMjgOKtkxUniw6VgBwNYPDSs=
X-Received: by 2002:a17:906:291:b0:994:1844:caec with SMTP id
 17-20020a170906029100b009941844caecmr1018799ejf.77.1691741751287; Fri, 11 Aug
 2023 01:15:51 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Aug 2023 08:15:39 +0000
Message-ID: <CACPK8XfqHtYnzKy_beXRXTuK5MNzu2Fp2K8mr2fUBBD5VgsKaA@mail.gmail.com>
Subject: [GIT PULL] FSI changes for v6.6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these FSI changes for v6.6.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.6

for you to fetch changes up to f04d61a379d65794d5d85168b84dcdf01d426f7c:

  fsi: fix some spelling mistakes in comment (2023-08-11 13:32:15 +0930)

----------------------------------------------------------------
FSI changes for v6.6

 * New drivers for the I2C Responder master and SCOM device

 * Misc janitor fixes

----------------------------------------------------------------
Eddie James (15):
      fsi: Move fsi_slave structure definition to header
      fsi: Add aliased device numbering
      fsi: Use of_match_table for bus matching if specified
      fsi: sbefifo: Don't check status during probe
      fsi: sbefifo: Add configurable in-command timeout
      fsi: sbefifo: Remove limits on user-specified read timeout
      fsi: aspeed: Reset master errors after CFAM reset
      fsi: core: Add trace events for scan and unregister
      fsi: core: Fix legacy minor numbering
      fsi: core: Switch to ida_alloc/free
      fsi: Improve master indexing
      fsi: Lock mutex for master device registration
      dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
      fsi: Add IBM I2C Responder virtual FSI master
      fsi: Add I2C Responder SCOM driver

Juerg Haefliger (1):
      fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Randy Dunlap (1):
      docs: ABI: fix spelling/grammar in SBEFIFO timeout interface

Rob Herring (2):
      fsi: Explicitly include correct DT includes
      fsi: Use of_property_read_reg() to parse "reg"

Yu Zhe (1):
      fsi: fix some spelling mistakes in comment

 drivers/fsi/fsi-master-i2cr.h                      |  33 +++
 drivers/fsi/fsi-master.h                           |   2 +-
 drivers/fsi/fsi-slave.h                            |  28 ++
 include/trace/events/fsi.h                         |  31 ++
 include/trace/events/fsi_master_i2cr.h             | 107 +++++++
 include/uapi/linux/fsi.h                           |  10 +
 drivers/fsi/fsi-core.c                             | 154 +++++-----
 drivers/fsi/fsi-master-aspeed.c                    |   4 +-
 drivers/fsi/fsi-master-ast-cf.c                    |   5 +-
 drivers/fsi/fsi-master-gpio.c                      |   2 +-
 drivers/fsi/fsi-master-hub.c                       |   2 +-
 drivers/fsi/fsi-master-i2cr.c                      | 316 +++++++++++++++++++++
 drivers/fsi/fsi-occ.c                              |   2 +-
 drivers/fsi/fsi-sbefifo.c                          |  53 ++--
 drivers/fsi/fsi-scom.c                             |   8 +
 drivers/fsi/i2cr-scom.c                            | 154 ++++++++++
 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo      |   6 +-
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml          |  41 +++
 drivers/fsi/Kconfig                                |  17 ++
 drivers/fsi/Makefile                               |   2 +
 20 files changed, 878 insertions(+), 99 deletions(-)
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 drivers/fsi/fsi-slave.h
 create mode 100644 include/trace/events/fsi_master_i2cr.h
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/i2cr-scom.c
 create mode 100644
Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
