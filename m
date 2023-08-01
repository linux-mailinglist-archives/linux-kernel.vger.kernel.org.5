Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB576A5F5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHABFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHABFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:05:52 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733EE67;
        Mon, 31 Jul 2023 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690851951; x=1722387951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FICTb653hGovszk2ZCogn8s97PB2ERvjcbdzCvjfVMY=;
  b=N0nMZftP+P47/rkU624R56NSln3D3M0B75BTTx7pPTSytyVQ+iHOORAw
   a399ESE06i3E4AY+A7PFu0XoFSS+1zTpJkheLfMFbtXNZuTceESqRI75b
   KsqjpMlOQ8U+fbb1N2uvCTyIq/3irmRxEsIErr49UoWM6/aFkFahb1jHK
   49mf3jS0yd/UVAMkR7F4/Va6ZQvd8IhhZH0Ze9o9q6M4GUJwktAqyl4GY
   6QOnkYWtd3tOPzfpewdBpl1iQVmJ2QMe6VbMBH1MsEvhPTiKZQzPpJcYS
   j6jeyhPO4t2iUBeFmpLBU9Wy+zPOQ79gnoykYO1MNWtfTnvGXyex4mHu0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372788025"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372788025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818587475"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="818587475"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2023 18:03:55 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com
Subject: [PATCH v2 1/5] dt-bindings: intel: Add Intel Agilex5 compatible
Date:   Tue,  1 Aug 2023 09:02:30 +0800
Message-Id: <20230801010234.792557-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Agilex5 is a new SoCFPGA in Intel Agilex SoCFPGA Family,
include compatible string for Agilex5 SoCFPGA board.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 4b4dcf551eb6..2ee0c740eb56 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -21,6 +21,11 @@ properties:
               - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
+      - description: Agilex5 boards
+        items:
+          - enum:
+              - intel,socfpga-agilex5-socdk
+          - const: intel,socfpga-agilex5
 
 additionalProperties: true
 
-- 
2.25.1

