Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0275D12F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGUSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGUSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:17:21 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E7E68;
        Fri, 21 Jul 2023 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689963437; x=1721499437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TmtF3GFzs9OKVl3bOHgAhFBE6wjBFDuvzZ/HQeN7+FQ=;
  b=PgwF96YGSRsryXqpZzsZmuR5rMgazsGo6gf6y5DTGVqwE2g65dXzMobz
   isVnhtqdoyi3GsFnSkF23glg76AJEmEepJA/vX5v0Qc4QqsQwMTGq1m5w
   RBP1SCfAGqpvS7Yj8DcSEI1bmmTxeiObZL/EluzEgIHJ4z6eGMkG/joMN
   4=;
X-IronPort-AV: E=Sophos;i="6.01,222,1684800000"; 
   d="scan'208";a="661286278"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 18:17:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 1A5D080543;
        Fri, 21 Jul 2023 18:17:15 +0000 (UTC)
Received: from EX19D002UWA001.ant.amazon.com (10.13.138.247) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 18:17:14 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002UWA001.ant.amazon.com (10.13.138.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 18:17:14 +0000
Received: from dev-dsk-alisaidi-1e-5e886d10.us-east-1.amazon.com
 (10.200.156.102) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1118.30 via Frontend Transport; Fri, 21 Jul 2023 18:17:14
 +0000
Received: by dev-dsk-alisaidi-1e-5e886d10.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 3B5AD21AD; Fri, 21 Jul 2023 18:17:14 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <acme@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <scott@os.amperecomputing.com>,
        <maz@kernel.org>, <anshuman.khandual@arm.com>,
        <german.gomez@arm.com>, <alisaidi@amazon.com>,
        <renyu.zj@linux.alibaba.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <fissure2010@gmail.com>
Subject: Re: [PATCH v1 0/3] arm64: Support Cortex-X4 CPU for Perf Arm SPE
Date:   Fri, 21 Jul 2023 18:16:53 +0000
Message-ID: <20230721181653.22398-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717054327.79815-1-leo.yan@linaro.org>
References: <20230717054327.79815-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Mon, 17 Jul 2023 05:43:24 +0000, Leo Yan wrote:
> This series support Cortex-X4 CPU in Perf Arm SPE.
> 
> The Arm64 and tools both include the header cputype.h for CPU part and
> MIDR definitions, to de-couple between the tools and the kernel, the
> tools doesn't directly use the kernel's header, alternatively, the tools
> maintain a copy and sync with kernel's header.
> 
> To keep the exact same content between kernel and tools' headers, this
> series firstly adds Cortex-X4 CPU part and MIDR definitions in the
> kernel header; then the second patch syncs the change into the tools'
> header.  The first patch is to support the Cortex-X4 in perf Arm SPE
> with the new CPU definitions.
> 
> I don't have Cortex-X4 machine in hand, so just verified with
> compilation perf tool.

This looks good to me, but can we add the other cores that operate the
same way now too? Flipping through the TRMs A78, X3, V2, X1, A715,
A720, and A78C all have the same encodings. 

Reviewed-by: Ali Saidi <alisaidi@amazon.com>

Thanks!
Ali



