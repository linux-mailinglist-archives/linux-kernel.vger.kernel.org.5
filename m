Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6819779D151
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjILMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjILMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:45:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3E9F;
        Tue, 12 Sep 2023 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522719; x=1726058719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9xeT2qID5bS6853+91laC5cChL3kKSaLf8+yh4putk=;
  b=Ea06EPCkd57mAflbx5YQwAFWWK6O69mZ9v/14U59+ksaGNWO52gTLTpI
   LdNrLOQpMhl5Ha+r5OnRrE892r58bJYyv13iiDRvflL5fKlZiqLv7cZNS
   LXPMexlwtE/IW7sG63Q/kDUDzx9Ch/BabzBMDfSrG8zl/2QAQipMGg5Ff
   1Jayc8U0JOq49p2fN9RWA8uQ89QxkZ82FGPvNmCft5UfDt/0xkOBeiMDZ
   UE+9oGIAjxaz8gOCrkhmxabR8wljHmsEdymhpUOJsIL2g6Xlf2TJZ03VT
   HZveX9n01NM74BQfljDybxZBFzLlKTxbPWX5Qc3V4DfiwHaMs1c+QyLKa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358638814"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358638814"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867352738"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867352738"
Received: from srosalim-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.217.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:14 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     x86@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     irogers@google.com, mark.rutland@arm.com,
        linux-perf-users@vger.kernel.org, hpa@zytor.com, mingo@redhat.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, namhyung@kernel.org, jolsa@kernel.org
Subject: [RESEND PATCH 0/2] perf/x86: Package residency counter improvements
Date:   Tue, 12 Sep 2023 15:44:30 +0300
Message-Id: <20230912124432.3616761-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

No changes on this, just resending as 6.6-rc1 is out, and the first post
got no feedback.

Original cover letter with more details here [1].

-Tero

[1] https://lore.kernel.org/bpf/20230823055653.2964237-1-tero.kristo@linux.intel.com/T/#mdaea2388b76abc33ebccac3d0a6ccc0ac0def20b


