Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94177BA9B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJETGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjJETGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:06:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DDEE5;
        Thu,  5 Oct 2023 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532793; x=1728068793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uzxlgwZ8x82LLBnZJSRnVgezJ3VH2Oj0pq6ma9njLKg=;
  b=M6QeXN2BAP3+PlLzrPkQADIWKOqpGL5h9tKExZ5pZvoLuF0dDtVrcnrM
   t5DwyEqYcAYhjNkGL5zvP/oC+Qp1psE40YAG8mzhOLA7GVDsiwCahKpHU
   uhFIIO/aHEDp/YB4RjdPuv1xlwDiPB2ch9x2uJif0OvAJzz0ayTvZHK66
   Y+l3wABxr4haUmOCNJyLk5GvPu+wlgWtfnRzjVFYY5R9P6eSyeCKtnRhG
   M3zbv7XFddQhXfB/MXLm7LWlk8cxvmJGzChqR5fPcgndm8mMBmSt3Z1S+
   Y1NISb5YLksLr8s5q6H7DhUC6VDZp2Kjf0gvDGm2uv25L/QMP31axzae4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488218"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488218"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999055066"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999055066"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/5] perf intel-pt: Use of get_unaligned_le16() etc
Date:   Thu,  5 Oct 2023 22:04:46 +0300
Message-Id: <20231005190451.175568-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
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

Hi

Ian sent a patch for this, but using get_unaligned_le16() etc seems nicer.


Adrian Hunter (5):
      perf tools: Add get_unaligned_leNN()
      perf intel-pt: Simplify intel_pt_get_vmcs()
      perf intel-pt: Use existing definitions of le16_to_cpu() etc
      perf intel-pt: Use of get_unaligned_le16() etc
      perf intel-pt: Prefer get_unaligned_le64 to memcpy_le64

 tools/include/asm-generic/unaligned.h              | 20 ++++++++++
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 43 +++++++++-------------
 2 files changed, 37 insertions(+), 26 deletions(-)


Regards
Adrian
