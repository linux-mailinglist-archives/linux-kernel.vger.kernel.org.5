Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE8761AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGYOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGYOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:00:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B1BB0;
        Tue, 25 Jul 2023 07:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD1A661731;
        Tue, 25 Jul 2023 14:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1F5C433C7;
        Tue, 25 Jul 2023 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690293647;
        bh=KxdroIHSsGYEX4N3u3daebwShXgD0pgJCElrR/YHdj8=;
        h=Date:From:To:Cc:Subject:From;
        b=I6f14DS8zaBAQUUQ1Fu8L+7+xvK/XKduZjNgpOVAiAzK1pkeL/YjzUSrPPFIQi6Xq
         s+L7qOqBv8hqDFTU9Xb7KhhvHS5gRownkuWP82xCtNT/c2NtLiAMODrY+H8WM27WAK
         W2gX0L9FnR4khVhsS5rth8BXumGPt/yQX5/KeZ1mz8LE45cRj2b0mXO03C3qUazmn4
         GeIo/S2lgzLA2iOqPF6tmEmPSJt7PwOQyAi7jsL3tXGVg7g8448FhXysOwNoOCJ/MF
         9vPYNykHsI6cNV4qUPTvVIOoO996yuwYUCyTnb6YeI6JqI3RqqDvO77QqbujA38INY
         oCoerpCVOEynA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOIaz-00018A-13;
        Tue, 25 Jul 2023 16:01:01 +0200
Date:   Tue, 25 Jul 2023 16:01:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.5-rc4
Message-ID: <ZL_VnZUGvlOlLKAy@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.5-rc4

for you to fetch changes up to d245aedc00775c4d7265a9f4522cc4e1fd34d102:

  USB: serial: simple: sort driver entries (2023-07-20 15:59:25 +0200)

----------------------------------------------------------------
USB-serial device ids for 6.5-rc4

Here are some new modem device ids and a new "simple" driver for a CAN
bus device.

Included is also a patch sorting the "simple" driver entries in order to
make it more obvious where new ones should be added.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Johan Hovold (1):
      USB: serial: simple: sort driver entries

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Oliver Neukum (1):
      USB: serial: simple: add Kaufmann RKS+CAN VCP

 drivers/usb/serial/option.c            |  6 +++
 drivers/usb/serial/usb-serial-simple.c | 73 +++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 33 deletions(-)
