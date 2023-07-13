Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF029751CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjGMJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjGMJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:07:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08841BDA;
        Thu, 13 Jul 2023 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689239269; x=1720775269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4FbaeI4tBhOKW8/Jmri85jlOT3p1bcaXOdawC1bIvcs=;
  b=lf98nuVMnt7wwC1UgYjPAde9JzqTRktpPQ1o2DmvHuap4/hbmAtr//ht
   0BCGevC7CgncaamV/CyqW+z/w94gbcOgKWLKoKygJ7/x74SXO4A6lj/PG
   RaG/9PqlKzbJAb6qGCXAG0DS3KJz+khc/trBpAcF8rjXXeC+2FKerM+qO
   4v1xVM+knhNv7/2G4vfwqjSVpkNuZWgJ/iYLx3fcfpOFr+sYMGnODqv1J
   KmZsmaRThP2KfhEkDxc6TIi5Z6/iwTUfrU74M0gC4UjtpduM/nKIrCfAm
   Nk1i7XdFeqAp81AroadQnCyoeMpMuQOMN1yo/iEX6j3jrS4ww0OZhF5gx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367760118"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367760118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 02:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866481051"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866481051"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2023 02:07:46 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, chuck.lever@oracle.com
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next 0/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date:   Thu, 13 Jul 2023 11:05:48 +0200
Message-Id: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the issues with parsing enums in ynl.py script.

v1->v2:
Initially this was one patch, but review shown there is need to fix also
leftover issues with indexing in _decode_enum(..) function
("tools: ynl-gen: fix enum index in _decode_enum(..)").

Arkadiusz Kubalewski (2):
  tools: ynl-gen: fix enum index in _decode_enum(..)
  tools: ynl-gen: fix parse multi-attr enum attribute

 tools/net/ynl/lib/ynl.py | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.37.3

