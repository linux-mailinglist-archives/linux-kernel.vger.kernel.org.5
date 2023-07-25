Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE9760A61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGYGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGYGf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:35:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185810FA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:35:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75FDB1AB033;
        Tue, 25 Jul 2023 02:35:53 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        M4bcjTSuguIzt8VRc6ssYWZBjrp4kdLVW3B9gSrZzTc=; b=LfhAS+dDcHws6/a7
        IxwNSJA/w8wF3YzLo5TBa+1xmLu6MxWLpIbA18WbYXQgCsA+Ao3Mb0z/jblewRMX
        MK7fcGGVQLWbzNgwYhDASNEDs+pVcOsiC8nV7QbCdN3CM93JFDoTNtnk+qUz/x+I
        09+SIrVLQtpl4n+UXI+NWv1QhCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3461AB031;
        Tue, 25 Jul 2023 02:35:53 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=M4bcjTSuguIzt8VRc6ssYWZBjrp4kdLVW3B9gSrZzTc=;
 b=CReEI5WFSELWZG7nqXL6N8l0FlS2/mVzeGYJboXTlLsQ/rn7e1j9gmOTOvnDHpn5gJ9l/Egvz/zWDEB/rydz/dzN9MMKLpGxw4VT7JKShGqAub41GHzk8VjeQOCBrwQ4ckJDIhyuk3NZGZZCh3BNMf5QD4BCUPudXD0MdHDBfKs=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE6BE1AB030;
        Tue, 25 Jul 2023 02:35:51 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 24 Jul 2023 23:37:13 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Staging: rtl8192e: Function name cleanup series 1
Message-ID: <ZL9tmaSHxKh2JCau@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 804A52EA-2AB5-11EE-9D48-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename functions to fix checkpatch warning: Avoid CamelCase

Tree Davies (5):
  Staging: rtl8192e: Rename function ActivateBAEntry
  Staging: rtl8192e: Rename function DeActivateBAEntry
  Staging: rtl8192e: Rename function TxTsDeleteBA
  Staging: rtl8192e: Rename function RxTsDeleteBA
  Staging: rtl8192e: Rename function ResetBaEntry

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 44 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  6 ++--
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.41.0

