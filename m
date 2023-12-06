Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D577807B99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbjLFWme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjLFWmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:42:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12063D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:42:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733F9C433C7;
        Wed,  6 Dec 2023 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701902558;
        bh=AslNTUin8A7oCwTbelMTlAy+9pa9TfyKW5/4wcsAbRw=;
        h=From:To:Cc:Subject:Date:From;
        b=IhTQWFdf1AXHLSIWjF8+LMVdOY/5SERFx7VHdptcjqC5f3sD9K8qN+kR3vE7GcFgG
         gEBVlOIO7gMo4k7JDoUCuW8I9sOv0gLMn01oGMlG1VPeKc+pg0t7UwDaRewoWRqZyC
         O3kx/NF9hOlB254Ym2oAJvxF6ET38tC2rVnGFWMBbMzBtx8NfLUJBZSBAbf+DRq9qm
         mzE9fi6SsMhhlmsLgGJ0dznNA8Ar+5yTYo8hgdG4mSZDQ3Ee1qACRaOmyggBByEu3d
         86VrMNRTNBp4kfuavMKXyzcuGrocPZVocOyVXu/0r+rwTU+wDy1buiwv6DhcOlk2ko
         CPbeQ6AVLgrww==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/AER: Clean up logging
Date:   Wed,  6 Dec 2023 16:42:28 -0600
Message-Id: <20231206224231.732765-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up some minor AER logging issues:

  - Log as "Correctable errors", not "Corrected errors"

  - Decode the Requester ID when we couldn't find detail error info

Bjorn Helgaas (3):
  PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
  PCI/AER: Decode Requester ID when no error info found
  PCI/AER: Use explicit register sizes for struct members

 drivers/pci/pcie/aer.c | 19 ++++++++++++-------
 include/linux/aer.h    |  8 ++++----
 2 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.34.1

