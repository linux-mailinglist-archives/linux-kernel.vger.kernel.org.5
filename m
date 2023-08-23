Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949B978500E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjHWFpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHWFps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:45:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA937CEC;
        Tue, 22 Aug 2023 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692769546; x=1724305546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2TL6b1MYDr/wlMkuqOdkcsygBWR2VrvBGwVxB879fs=;
  b=iuqN0ghhPQewif9IaXWQLbaR/DWroA9OOqOjMMMPKBuJ6cX0X8JYJURy
   zwV7MJ2+wjUiSMRNVUDFmvjSaqcLnDtOxfM09NxEk6b9wXh4iSaYs3492
   WjOoFSATwwLw/Hya1ueXllWEcOowCLtwBK8C+Et9TogtdwdzHvyzjF6gO
   LAzx5gVwO956vXNMTlEyibQd1bcjIuHscQE8HWjFQ7oVvMEMuz50DmwYW
   tOauFXD3Sbg0F1+YFIE8KRhDqxml5DqDWQh+MttcDOKmPY3BRR1JmzbCr
   4hF62MaLJqWLFEtt29mqfp8sLtuzj0g5e52kcOmVDxZsARgEgSGc2IfPb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372962266"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="372962266"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713435761"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713435761"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2023 22:45:41 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     kuba@kernel.org
Cc:     alexandre.torgue@foss.st.com, conor+dt@kernel.org,
        conor.dooley@microchip.com, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        fancer.lancer@gmail.com, joabreu@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com, robh+dt@kernel.org,
        rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues with coe
Date:   Wed, 23 Aug 2023 13:45:37 +0800
Message-Id: <20230823054537.23328-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20230822171525.692bd2df@kernel.org>
References: <20230822171525.692bd2df@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 10:31:31 +0800 Rohan G Thomas wrote:
>> +      snps,tx-queues-with-coe:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: number of TX queues that support TX checksum 
>> + offloading
>
>Is it going to be obvious that if not present all queues support checksum offload? I think we should document the default.

Agreed. Will add this in the next version.

BR,
Rohan
