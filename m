Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CC7B3675
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjI2POj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjI2POh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:14:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88447DE;
        Fri, 29 Sep 2023 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696000475; x=1727536475;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TmUeSZUPyMHccEiShLmcm+05xYs7/Bfm4Un5nwDfgzM=;
  b=h+Ef1Fak23NwCJNR8KEJQJ4YR6DfcBjSiM89EfQXqd8fjgn18tjCnlKU
   B//4Aqlq660o98DR/D2z0KZVpi8f84ZNAUABaG5huuBGMtCGneUV8h5Qk
   iyVIgsFLEfdOXGGvihzMilcd1eEigb3wC1qQPS4+I6kTDGKZqFgzHl9oG
   4yJTDI2/Z3LBS2EhfTUPIZepfWwruiEvUm0MovZLhAaIMicjSJCBM5F65
   gc+LgveuSyjOJ3biyRRrZzuJPaP08XTDpFTEipFLLCL+2Zn3HepLiRr7p
   vmYmgmW5b1pXjV2e0136Y8bFOl/17XVoWU4qC3AsH5v7kgiEQ2geklWxr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468601563"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="468601563"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="996959944"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="996959944"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:14:26 -0700
Date:   Fri, 29 Sep 2023 18:14:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v10 03/10] x86/resctrl: Rename rftype flags for
 consistency
In-Reply-To: <20230915224227.1336967-4-babu.moger@amd.com>
Message-ID: <4e1cc390-345-b79f-59d6-d96bcea7b1cc@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-4-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1167976742-1696000474=:1989"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1167976742-1696000474=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> resctrl associates rftype flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change the prefix to RFTYPE_ for all these flags to be consistent.
> 
> Also add the flag RFTYPE_MON_BASE, which contains the files required for
> MON group only.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


--8323329-1167976742-1696000474=:1989--
