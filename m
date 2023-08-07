Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0756771989
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjHGFpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHGFpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:45:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CB1708
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:45:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 008BE1A0BD4;
        Mon,  7 Aug 2023 01:45:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=UinChLaUXH1xK11hEJ+w7bYhyWb0ufAj4sr25zSbsME=; b=ZY4x
        H63Gd1fm7y3CEuO3d4QIDqripJTN9ysdGaUmjTYE0I+wBLFqZP4AWNqu9IhJt5ij
        ahu2Ikh1y0FBWNcM8xVP1l2zjfkL97y/4+EDBwOhzUHSCgvyzsC8rY4hmAt5VNZs
        +JLh4razpdvwfoB/9rlo0xyGjxBfSIHnFaeOhL8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD0791A0BD2;
        Mon,  7 Aug 2023 01:45:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2019-09.pbsmtp; bh=98BUAZNgwnh1QBNdyw4hD6dVgs5FtbjzJUITJr09lkc=;
 b=ZNWfiJxHdhU/0xsO7uHidRsgr+wd3JFtQEnUXC+G/Wy8R3Bs97cZFmLKkIa3O01PmvL19Xty9DAPIauzvnDm4xRBJvSmwT9E3J43dZwuJq+Og+EZC+ldFTe7vInbMVyrSBLw7QqQUZKYaf5LoSih+TJTrHKKVbe/FA2OJDmWnjw=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61A741A0BD0;
        Mon,  7 Aug 2023 01:45:47 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/5] Staging: rtl8192e: Function name cleanup series 2
Date:   Sun,  6 Aug 2023 22:47:27 -0700
Message-ID: <20230807054732.1864827-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Pobox-Relay-ID: A8F0DB94-34E5-11EE-89BD-C65BE52EC81B-45285927!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series renames functions to avoid checkpatch warning:=20
Avoid CamelCase.

Thank you in advance to the reviewers.
~ Tree

Tree Davies (5):
  Staging: rtl8192e: Rename function TsInitAddBA
  Staging: rtl8192e: Rename function TsInitDelBA
  Staging: rtl8192e: Rename function BaSetupTimeOut
  Staging: rtl8192e: Rename function TxBaInactTimeout
  Staging: rtl8192e: Rename function RxBaInactTimeout

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 16 ++++++++--------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib.h         | 16 ++++++++--------
 3 files changed, 21 insertions(+), 21 deletions(-)

--=20
2.41.0

