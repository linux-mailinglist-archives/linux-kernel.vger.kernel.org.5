Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E344798EFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjIHTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIHTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:23:07 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCAE8E;
        Fri,  8 Sep 2023 12:23:03 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a9e49495ddso223866b6e.1;
        Fri, 08 Sep 2023 12:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694200983; x=1694805783;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZi2Mn8GwGKnO8jOWu/zfKZD0wdZxOrxOlLwDCTPsow=;
        b=tDak8cxqpVYdXcVI82IWuTSX9s33zyizxRaOqXcnSk9WKBlA1jMWalb2eL+YYeqbyZ
         VuioGJPLgwyfolqEftaGgd+w089/FFTkNFKL8mTPM6269hbiREIY5S85nfjQAJfjbHnY
         7al9WpqLvTCQA2h/vc1kkYJYhPjvxdgg+p3EDcpEWrL7jtlqDk7pZSsjJr58DwPP9MRh
         rJi9jo7DsOcxwAATCzRYn+fynk0h4zRHi9DbHZYMnqnSHH6ePXwWxGRfyXEoDSfM5423
         lASWI9c1UJh/DgAZSHlaeIYxIxlw8R8iiuVG15SlWJsTMySSKSfwHpomAP988vNX72Uc
         c4Aw==
X-Gm-Message-State: AOJu0YzpacXPoCSIcLwgTA7F7eCjFidY/6HVGRwrOyiaLPwbxIC8CvOe
        OTqOL+LBRymZlDq7NVa6kSnQjXeICwDz3Ehyx8u3msUmaU0=
X-Google-Smtp-Source: AGHT+IFmWmqzNJSTIQ8RzgDMWEoqBFjHs/v5KpgPLj12HcjBY8L1Gn3OYmdFoA0E+G92H45hEDHA0gcA+wZBxU7+5S4=
X-Received: by 2002:a05:6808:198e:b0:3a9:bb6f:1ac0 with SMTP id
 bj14-20020a056808198e00b003a9bb6f1ac0mr3636975oib.2.1694200983157; Fri, 08
 Sep 2023 12:23:03 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Sep 2023 21:22:52 +0200
Message-ID: <CAJZ5v0gOBBqyhwbi+FyQDgdwW3_EbtA0DgJYsH9kNxNMR=LCbQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.6-rc1-3

with top-most commit 081690e941188acfad41b8dbde2112029a2aa206

 powercap: intel_rapl: Fix invalid setting of Power Limit 4

on top of commit ea4f9c37f75271d8256a326c938c95733e1fec35

 Merge tag 'pm-6.6-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive a power management fix for 6.6-rc1.

This fixes an Intel RAPL power capping driver regression introduced
during the 6.5 development cycle (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      powercap: intel_rapl: Fix invalid setting of Power Limit 4

---------------

 drivers/powercap/intel_rapl_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
