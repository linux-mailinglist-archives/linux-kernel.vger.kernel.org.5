Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA987F343C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjKUQwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKUQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:52:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110F6113;
        Tue, 21 Nov 2023 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700585547; x=1732121547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41VcV/B0w8wkuOgL+XuhISw4ipqehSYvx8qXQr3tmgQ=;
  b=mhlnC+A2H26xcfPcRG/rhMcbKXs/Xy5FgXZojSVt6dIbhGWpdNd/J9Eb
   Q/qdUaiFLpFaBv27tSG82hv69rPz+uCi7PYAisz+lBFJUIjmZ3gU85UxJ
   d6Pn1EX72a0ZK+NDVZi/+dg0dWt4ssiE0unfdgIftzyB9t5YrpRr1ozvO
   jEZlEFQRoyXHuHTun3IevsfMmWtyerODJ1UmJUssdaMkCiTpJMI1s5gm9
   MO/DBwSGbHLtD8OCNsbiskETkuH5LxEh5BuiNn+9nJftvm2mkaupW3pJz
   EvmdW6b0+HLLFVZiqELQSZsWEHmCZ99qXtuEAi1sJcpunsZxpu02w+3uV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="376913262"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="376913262"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766700066"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="766700066"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2023 08:52:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2695313A; Tue, 21 Nov 2023 18:52:18 +0200 (EET)
Date:   Tue, 21 Nov 2023 18:52:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to
 support multiple types
Message-ID: <20231121165218.GR1074920@black.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-4-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121103829.10027-4-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:08:26PM +0530, Raag Jadav wrote:
> Now that we have _UID matching support for both integer and string types,
> we can support them into acpi_dev_hid_uid_match() helper as well.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
