Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04FA7F2A94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjKUKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjKUKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01F8E8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F5C433C7;
        Tue, 21 Nov 2023 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700562991;
        bh=sIbap2v6n7AnOArLzInMJWDsw+j8c2DedoVdXpTAOBo=;
        h=From:To:Cc:Subject:Date:From;
        b=WGgROp8YyAU8VjOcziWDJ9PgEKudRrshNB0U9vgQLwNky5JObsTBdsV7jQzxwZ7dL
         9sDkTbL7anK1QBj56V3XFSKbAdU9P7qUHyFos/IQzYHJRArCkHjmwWDRwlNeSfIJkW
         pLX0kzth4DMtudIGSfK1WmvY7ToLMFTYlsANbRDLdOOkL9YkMUhFwGd/L6v+Fkn/AH
         pumf6LHi9DvI8aVUrtuHMo/UZm1occPSDAUcTj9SdeMCc2YQDR4ktmVHemNsFHsUdg
         45FHog4C2FQ9zU4dM/LZFtlQEAR408BAI/Bmcz0C1SNWxWH8cCqxDavix3ubfS+HMR
         BnC7wI/mD33bQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 0/6] tty: remove unused structure members
Date:   Tue, 21 Nov 2023 11:36:20 +0100
Message-ID: <20231121103626.17772-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a little indexer at https://github.com/jirislaby/clang-struct.
And it found there are few unused structure members inside tty. This
series removes them.

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-s390@vger.kernel.org
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>

Jiri Slaby (SUSE) (6):
  tty: con3215: drop raw3215_info::ubuffer
  tty: ipwireless: remove unused ipw_dev::attribute_memory
  tty: jsm: remove unused members from struct board_ops
  tty: jsm: remove unused struct jsm_board members
  tty: rp2: remove unused rp2_uart_port::ignore_rx
  tty: serial_cs: remove unused struct serial_cfg_mem

 drivers/s390/char/con3215.c         |  1 -
 drivers/tty/ipwireless/main.h       |  3 ---
 drivers/tty/serial/8250/serial_cs.c |  6 -----
 drivers/tty/serial/jsm/jsm.h        |  5 ----
 drivers/tty/serial/jsm/jsm_cls.c    | 36 --------------------------
 drivers/tty/serial/jsm/jsm_neo.c    | 40 -----------------------------
 drivers/tty/serial/rp2.c            |  1 -
 7 files changed, 92 deletions(-)

-- 
2.42.1

