Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726257D8462
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjJZOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:20:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C31A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:20:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7DFC433C7;
        Thu, 26 Oct 2023 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698330011;
        bh=plzq0iTgpVGSsuDMHpwHXaaGd5ArZ98NU9kGZQVCjrc=;
        h=Date:From:Subject:To:Cc:From;
        b=lLi2EyZ6VEcSZ5x6yQPdyNo6HOS+elY6oNk4HDNhdcZUuG6jzYmQ6HkpSYv5Ungnz
         maU6MyewJH4g15EudxiT+Bgyl3mxF+Kd6aVnEG7s0zR6AxHzkAm23ZV1hd1RWR7QJ4
         NAWLd1FkKm4Vo+FLLwL+B9OjlcnHJ9yHgMoLlIenTUf6uP2FH24osGblILNaPOOCUT
         UBF5Ti+T7ftrSiQbiIY9G13X7lPM7sIcYHM7ZNxeSES0h/kHC0xpFWHDhopANwlOLV
         aPYi51+dhzM/SZ/clMzY3t/OiH52/qnbb5dLZeDX3ODVk49SCMRroZI0RgxBuXsMRV
         pCzs2XgnvEnFw==
Message-ID: <461139be-c11a-41c4-b09a-f8f1b7c61ec0@kernel.org>
Date:   Thu, 26 Oct 2023 23:20:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
Subject: [GIT PULL] extcon next for 6.7
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v6.7. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.7

for you to fetch changes up to b3edc3463d64bc469162138a6bec6913fbeef931:

  extcon: realtek: add the error handler for nvmem_cell_read (2023-10-17 17:38:57 +0900)

----------------------------------------------------------------
Update extcon next for v6.7

Detailed description for this pull request:
- Add new Realtek DHC(Digital Home Hub) RTD SoC external connector driver
: Detect USB Type C cable detection for USB and USB_HOST cable
  and support USB Type-C connector class. The extcon-rtk-type-c.c driver
  supports the following Realtek RTD SoC:
  - realtek,rtd1295-type-c
  - realtek,rtd1312c-type-c
  - realtek,rtd1315e-type-c
  - realtek,rtd1319-type-c
  - realtek,rtd1319d-type-c
  - realtek,rtd1395-type-c
  - realtek,rtd1619-type-c
  - realtek,rtd1619b-type-c

- Add device-tree compatible string for extcon-max77693 and extcon-77843.c.
----------------------------------------------------------------
Marek Szyprowski (2):
      extcon: max77693: add device-tree compatible string
      extcon: max77843: add device-tree compatible string

Stanley Chang (3):
      extcon: add Realtek DHC RTD SoC Type-C driver
      dt-bindings: usb: Add Realtek DHC RTD SoC Type-C
      extcon: realtek: add the error handler for nvmem_cell_read

 .../bindings/usb/realtek,rtd-type-c.yaml           |   82 +
 drivers/extcon/Kconfig                             |   11 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-max77693.c                   |    7 +
 drivers/extcon/extcon-max77843.c                   |    7 +
 drivers/extcon/extcon-rtk-type-c.c                 | 1794 ++++++++++++++++++++
 6 files changed, 1902 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-type-c.yaml
 create mode 100644 drivers/extcon/extcon-rtk-type-c.c
