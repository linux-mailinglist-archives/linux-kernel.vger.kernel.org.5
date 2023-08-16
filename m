Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BA77E79F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbjHPRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbjHPRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:31:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304062700
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=2aIfNWqGrHWnhM
        MgxVsjILSSvZ1QVSgRc/A4riP0ths=; b=UKyqp2yc+MHTlWG14rkt0wtdd8CUoR
        cHsgEX8zYh7fz5H9c8pIr/S0gx3eQ3kKuBpatTFz54RJlHBire+g5lktN4lS8M3i
        k3Fq/H5crjuNUV7qkFW/1bxm6FatM3eRtwXI9CTXwh3NS7VPKRYzhQNODDssigDG
        EXi/kb6ZQ0BGH8ywQwwz8EoAZm1iRa+H9LmC6lsEqIJJKSlcFm25TNMQzEQqlWxC
        HKQhEdNbcWjkwHF5WTSvUoCk3LeLxIXWFOebroweP49zRdKlHj693MpfVLWQd5F6
        Tnw7qlo8uABu1b0Pf2FGo7hGuimGV9GbKjNGVYhn/bqgoEi4rNxFmeRA==
Received: (qmail 219392 invoked from network); 16 Aug 2023 19:31:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 19:31:25 +0200
X-UD-Smtp-Session: l3s3148p1@pBkEqg0DtrpehhtV
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] gnss: ubx: updates to support the Renesas KingFisher board
Date:   Wed, 16 Aug 2023 19:31:12 +0200
Message-Id: <20230816173116.1176-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For that, we need "reset-gpio" support (patches 2+3). But first,
simplify regulator handling with a new helper (patch 1).

For changes, see the patches.

Wolfram Sang (3):
  gnss: ubx: use new helper to remove open coded regulator handling
  dt-bindings: gnss: u-blox: add "reset-gpios" binding
  gnss: ubx: add support for the reset gpio

 .../bindings/gnss/u-blox,neo-6m.yaml          |  5 +++
 drivers/gnss/ubx.c                            | 35 ++++++++-----------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.35.1

