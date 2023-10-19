Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1A7CFD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbjJSOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346150AbjJSOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:53:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641FA115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:53:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F034BC433C7;
        Thu, 19 Oct 2023 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697727187;
        bh=kBw5yTeJarKCISF0Rqzgf+ypJyJ4QRiNA8nAAPFGzCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OK//eEapTh5eNeFHxQbmJgNee9YgTFHgf422G1w0ZnjUZSSVsVSriOS95OuBnHG7W
         knLX2GtD6ult2ptxUfDKQ2CeM2h9UWpep4GTRtz7Sz8mitiooEqVe0fGlLgfu71LsH
         6+58xZz1vardBoIRMz3gi6MCr03xwSDFq3T1ezlRJNgSSgAG8dWkfF8l2dlqt+cgMW
         MFIJz3ag/7aG2zRwZa2JbQ+ZUDNHIKFM2BS+pcisHiyai2dEMvgpuQ3+FiCVcJiAFA
         mN6Y6LmG7jg//SaM9mMbl4p/8x9iPalEdnoNGCNgzhbo7tmoRxOiI4eo0ZgvOaT3H/
         0BlEAv4fNKJ4g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtUOc-0004RH-1r;
        Thu, 19 Oct 2023 16:53:10 +0200
Date:   Thu, 19 Oct 2023 16:53:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.6-rc7
Message-ID: <ZTFC1jhZ0m5PIMRE@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.6-rc7

for you to fetch changes up to 52480e1f1a259c93d749ba3961af0bffedfe7a7a:

  USB: serial: option: add Fibocom to DELL custom modem FM101R-GL (2023-10-16 10:40:30 +0200)

----------------------------------------------------------------
USB-serial device ids for 6.6-rc7

Here are some new modem device ids, including an entry needed for Sierra
EM9191 which stopped working with recent firmware.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Benoît Monin (1):
      USB: serial: option: add entry for Sierra EM9191 with new firmware

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

 drivers/usb/serial/option.c | 7 +++++++
 1 file changed, 7 insertions(+)
