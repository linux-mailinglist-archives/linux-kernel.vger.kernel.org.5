Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8784677A25C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHLUO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHLUO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:14:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D8171F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:14:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C70741BE81;
        Sat, 12 Aug 2023 16:14:57 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=zjap4JiBXKeaqWiObStAojMoI/BaWSUHl0LckDs5Xq4=; b=j8Hh
        al5dO1sQz+73mlLK9h91c/3nVIEd8INX8NCsmjd1KuImWfATABiDbgVJAAKYe6TY
        lpqAz3Ztr+5xDMMI5MX+jZj+7KS1sjtZQNSYItJbJ0N6JuH02qoPyW6W/MIlRnXm
        c+57Q6GhsMe/1R/6vh1mN40vmk+0PYcxovgwz4E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFEC41BE80;
        Sat, 12 Aug 2023 16:14:57 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2019-09.pbsmtp; bh=le937RDH24979EENgWHF+2j7O3UOoz935an77qqt2kA=;
 b=Zd0ThBTr0cs76OGwwEWifacBwrC64ZtJOT6m34JBFEEJF4DE9OX/wqsjR/7RRDqw5RGLH5a3YO4kzlA2KbBSgJ0gEOUS2Mff9sRx56E6lsBU4sOBk/gJNBWYPnkqC/eEfwWwKpcZ2ZzsZKjsgblBjFJGGXf0mp/26DIQltB8VCA=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A68B1BE7E;
        Sat, 12 Aug 2023 16:14:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record references
Date:   Sat, 12 Aug 2023 13:16:46 -0700
Message-ID: <20230812201702.83421-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Pobox-Relay-ID: E68BE406-394C-11EE-B8EE-C2DA088D43B2-45285927!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes checkpatch warning Avoid CamelCase, for all refer=
ences
of struct rx_ts_record, and renames them to rx_ts for consistency and=20
readability. Each patch renames references for a single function.

Thank you in advance to the reviewers
~ Tree=20

Tree Davies (16):
  Staging: rtl8192e: Rename variable pBa in function rx_ts_delete_ba()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_rx_ADDBAReq()
  Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
  Staging: rtl8192e: Rename variable pRxTs in function
    rtllib_ts_init_del_ba()
  Staging: rtl8192e: Rename variable pRxTs in function
    rtllib_rx_ba_inact_timeout()
  Staging: rtl8192e: Rename variable pRxTs in function
    RxPktPendingTimeout()
  Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
  Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
  Staging: rtl8192e: Rename variable tmp in function GetTs()
  Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
  Staging: rtl8192e: Rename variable pTS in function prototype
    rtllib_FlushRxTsPendingPkts()
  Staging: rtl8192e: Rename variable pTS in function AddReorderEntry()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_indicate_packets()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_FlushRxTsPendingPkts()
  Staging: rtl8192e: Rename variable pRxTS in function
    rtllib_rx_check_duplicate()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_rx_InfraAdhoc()

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 36 ++++-----
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 72 ++++++++---------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 94 +++++++++++------------
 4 files changed, 102 insertions(+), 102 deletions(-)

--=20
2.41.0

