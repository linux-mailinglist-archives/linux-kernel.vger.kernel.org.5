Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7112F77A528
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjHMGsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:48:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108BFE54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:48:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5D251A3DD6;
        Sun, 13 Aug 2023 02:48:39 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=h2CYEgnZQGmeKqmIwvu66ppbIxC+2xnpke2iTtrWt/U=; b=JApj
        tjV4bMNO4hTq1ijY2j9iT70jSRC3z0jurIR9d6VB0AiUfp0pq04+s9BUKVOWcWgb
        hDq8Rh9CVAGYJbhp8iPQRWLNzgbkVAcb7zdy7vWm9QdyiQFBa6BeTtVbBukFyZMV
        dcHsfYGnaEvqAFjKNXF/5NqLLyMY0JwMVIAfklY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF4821A3DD4;
        Sun, 13 Aug 2023 02:48:39 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2019-09.pbsmtp; bh=4hH4GnN52Ew2njXLFcQf4AOAhJQplZSDAmP0WBw66a0=;
 b=e3puG9xZz86xTYz3qjpQz+x4nMT/x1eRdYnD+hKIQAVkIEwCIX+Ylypqml2ifNIvVF+8u5+P9QSbMgOPJtnXmWr5kYjtQqBMJxdDvP7ujd/jAqumxQLHKn3OAZXW4SVFD9sx8n52Cq97i6mj6854wMvn4+RkXJpAbPqbHQbxT4E=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68C0B1A3DD1;
        Sun, 13 Aug 2023 02:48:38 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/6] Staging: rtl8192e: Series-A Rename struct rx_ts_record references
Date:   Sat, 12 Aug 2023 23:50:29 -0700
Message-ID: <20230813065035.95157-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 6F0C10BE-39A5-11EE-9303-307A8E0A682E-45285927!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the First series, Series-A, of a 3 part patch-series, which shoul=
d be=20
applied in the order of A, B and then C.=20

This 3 part patch series fixes checkpatch warning Avoid CamelCase, for=20
all references of struct rx_ts_record, and renames them to rx_ts for=20
consistency and readability. Each patch renames references for a single=20
function.

These 6 patches were previously sent as patches 1 through 6,
of 16, on 8/12/2023 - 16:15:06 EST, but the email submission process
was interupted/throttled - thus why this is a 3 part series. Although
patches are the same, they are marked v2.

Thank you in advance to the reviewers
~ Tree=20


Tree Davies (6):
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

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 36 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 32 ++++++++++----------
 2 files changed, 34 insertions(+), 34 deletions(-)

--=20
2.41.0

