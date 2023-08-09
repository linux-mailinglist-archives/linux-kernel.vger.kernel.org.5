Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77989776386
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjHIPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHIPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED4D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691594136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ByiVqdXmSCalgud7Z24F8Ynz17kP0hKEcv57t3Zsk6s=;
        b=iz8xQcnlfDopwYE8VJrz4UiE9sZk7BtaLwKtuNFCPLbo1ox11g40BrOwVfTqFxDcI0gu/f
        uwG9+7sSIGTIIdziJ68mju8c2ZA/UTy7ogJ+4tAF01hv5yLthzZj/oKyl7s1fNDmera79y
        nSF6EqK2cco9cUDLS6w+zYBrGNkqwSY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-18Dl6cEXPQyMvO52VygV8A-1; Wed, 09 Aug 2023 11:15:34 -0400
X-MC-Unique: 18Dl6cEXPQyMvO52VygV8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2021885CBE2;
        Wed,  9 Aug 2023 15:15:33 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.226.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B0CE2026D4B;
        Wed,  9 Aug 2023 15:15:30 +0000 (UTC)
From:   Petr Oros <poros@redhat.com>
To:     netdev@vger.kernel.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Jacob.e.keller@intel.com,
        przemyslawx.patynowski@intel.com, kamil.maziarz@intel.com,
        dawidx.wesierski@intel.com, mateusz.palczewski@intel.com,
        slawomirx.laba@intel.com, norbertx.zulinski@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com, horms@kernel.org
Subject: [PATCH net v2 0/2] Fix VF to VM attach detach
Date:   Wed,  9 Aug 2023 17:15:27 +0200
Message-ID: <20230809151529.842798-1-poros@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: fixed typos in the description of the second patch

v1: https://lore.kernel.org/netdev/20230807094831.696626-1-poros@redhat.com/

Petr Oros (2):
  Revert "ice: Fix ice VF reset during iavf initialization"
  ice: Fix NULL pointer deref during VF reset

 drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 34 +++++--------------
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
 4 files changed, 12 insertions(+), 32 deletions(-)

-- 
2.41.0

