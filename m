Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15806776590
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjHIQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjHIQwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:52:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684A26A0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691599904; x=1723135904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aoFne1pAw3kXuSG8g/9ufy7FABQ/5KM6WvVu/TzXZ5A=;
  b=ONbe3D3jiQYs/d0juh8tPdQfHBcPEhHWBQiNW02gfRodhzrVqvC9Ui6q
   SljTMprvnN2WJeu/JuakqCOCKnTjm3LI4MCNg9ig1AKMEmYQoPLpwJ+1n
   64t0OhaeULlWV9W9X9QD5BNq78qOUpBDwGB4CoQNMmZtWOu+b6ajHpm8W
   GinnlHAM5t0mnPYlQSV1VN1YBOuLdN7Ca8UUi8Oa9OIN0oumgdTvcGaxm
   0eHQZ+qjVUU/UQyTNY5a/wse29Sv68NKTKSjPnfNQTK9tClNAnhFVeh55
   i5H9gMHEzxhyGwsJKkA5AUttgLNV7K0nA7dMTuyIqJ0Gc6kfD28EjBw0R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368633261"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="368633261"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875333111"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:50:33 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     sohil.mehta@intel.com
Cc:     andrew.cooper3@citrix.com, andy@infradead.org,
        arjan@linux.intel.com, dimitri.sivanich@hpe.com,
        feng.tang@intel.com, jgross@suse.com, kan.liang@linux.intel.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, paulmck@kernel.org, peterz@infradead.org,
        ray.huang@amd.com, rui.zhang@intel.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch 00/53] x86/topology: The final installment
Date:   Thu, 10 Aug 2023 00:50:19 +0800
Message-Id: <20230809165019.85611-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
References: <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sohil,

> From: Sohil Mehta <sohil.mehta@intel.com>
> ...
> Subject: Re: [patch 00/53] x86/topology: The final installment
> ...
> Debugfs
> -------
> # cat /sys/kernel/debug/x86/topo/cpus/39
> online:              1
> initial_apicid:      39
> apicid:              39
> ...

Did you convert the output formats of 'initial_apicid' and 'apicid'
from hexadecimal to decimal in your testing? It was really coincidental
that if the output values were '39' in hexadecimal for the CPU '39'
in decimal :-).

I noticed they were represented in hexadecimal format in
arch/x86/kernel/cpu/debugfs.c:

    seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
    seq_printf(m, "apicid:              %x\n", c->topo.apicid);

Thanks!
-Qiuxu
