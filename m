Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B7771D66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjHGJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHGJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113CAF4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691401717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mCbJj/vVAJbYyM13q10h5V9OXKZQO+l4vJHMyz5zA34=;
        b=c3FZxpwZd/4jMnHRfLn2OD3M5FeDsirYspIEsL6d3aDtQsIm45vbHmIZxIT2vZNcvvvtGc
        CLjrZNrm15aQKgqEyfD0U20CLGZqUUeYe6axZUJ0+iWUYnB9vF25RZe67SUGgLYZxPn7Nh
        gXLREYT1YGysbVPXS/7eX+vM9GJYkeE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-tPRH4S_9O9qMixjTX2NOpg-1; Mon, 07 Aug 2023 05:48:35 -0400
X-MC-Unique: tPRH4S_9O9qMixjTX2NOpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BBFA3C13922;
        Mon,  7 Aug 2023 09:48:34 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.226.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC1381121314;
        Mon,  7 Aug 2023 09:48:31 +0000 (UTC)
From:   Petr Oros <poros@redhat.com>
To:     netdev@vger.kernel.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Jacob.e.keller@intel.com,
        przemyslawx.patynowski@intel.com, kamil.maziarz@intel.com,
        dawidx.wesierski@intel.com, mateusz.palczewski@intel.com,
        slawomirx.laba@intel.com, norbertx.zulinski@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] Fix VF to VM attach detach
Date:   Mon,  7 Aug 2023 11:48:29 +0200
Message-ID: <20230807094831.696626-1-poros@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

