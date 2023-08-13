Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56FD77A52F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjHMGwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMGwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:52:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266FE54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:52:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9058B311F9;
        Sun, 13 Aug 2023 02:52:39 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=kue6Q46w73jzsNU++Dc/jKGRQF8pCSsBB+mQ6LgULaI=; b=OjND
        cy18YfYmSyW9Bk7bLz9tjMsOJeHKtsRpmuwHPncEleum5jqRWerCvZabri1otwmY
        FfBZG740JosTZGv2IS9+S8bs4oCF79PSZAQgHBPiYIxB6KD1BbOyQ/jMw9ZL0fjn
        ef80NoOTaM248jamOwgsl2wn3xIP17bPJBmgAgU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89011311F8;
        Sun, 13 Aug 2023 02:52:39 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2019-09.pbsmtp; bh=/9CZ3kBN2cbhC5zjzOkoFvp3dRA8ti1xkB115mT2bQk=;
 b=Y8o7ZWPDRlwI9pLLSzFnrbMFrK7EPhJnx3hCqmLNgtydQff+FBRMidW3yAMxyhMLj4unByxp91R9ew8xId1ER4UoSbu5XGk8QZI4uy58V7hNDAT0WbNPbOnL7Q8hm+qdhkMetg6vZrxgcqcc2lM6n9qi1j+9zEJvLYvnXl43Bjc=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5BB3311F6;
        Sun, 13 Aug 2023 02:52:35 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/5] Staging: rtl8192e: Series-B Rename struct rx_ts_record references
Date:   Sat, 12 Aug 2023 23:54:40 -0700
Message-ID: <20230813065445.95205-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Pobox-Relay-ID: FC2BF450-39A5-11EE-B1C6-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Second series, Series-B, of a 3 part patch-series, which shou=
ld be=20
applied in the order of A, B and then C.=20

This 3 part patch series fixes checkpatch warning Avoid CamelCase, for=20
all references of struct rx_ts_record, and renames them to rx_ts for=20
consistency and readability. Each patch renames references for a single=20
function.

Thank you in advance to the reviewers
~ Tree=20

Tree Davies (5):
  Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
  Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
  Staging: rtl8192e: Rename variable tmp in function GetTs()
  Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
  Staging: rtl8192e: Rename variable pTS in function prototype
    rtllib_FlushRxTsPendingPkts()

 drivers/staging/rtl8192e/rtl819x_TSProc.c | 40 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

--=20
2.41.0

