Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E317A0A93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjINQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjINQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:15:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71341BE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694708150; x=1726244150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7cPotS7qBVHdUySEK4zHsKbwDfm1ctKyZV4GD1fx6Sk=;
  b=W4fwqgRWaPtmKmaBkClYihbNymFwuhs45ss2vsNWgCv2ClfkPkuTYtkk
   47f7X7fdpMK4MQVZjpgh5fvnv/MfAeHT4NZ6X3hXBF3ih+RLfMdWWWvu4
   hfc3EO243RlQkBvT5sQVTMYp9nqqhcPsECXnWRqV9jKDR9JclIdQ5XyxC
   wc/zNNgbJpDdyPVs3FBKzB97eohshjiCdKajbcVgbPnpsXZ6OrQrxLjx3
   5t1PSWuTOWbm1PT7U7QRmPVYNvT/cJKwcOJR+MSdXzDvISJ6EYLGKQVno
   qVcYLW6GuIdj2mxzCkfPowsFH/4XDPRkYQKxSjALlU9fSbu072pOZjNpG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364046115"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364046115"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075445165"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="1075445165"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:09:24 -0700
Message-ID: <f2642936-75b7-6c64-f3d6-ef3bf7fd8a31@intel.com>
Date:   Thu, 14 Sep 2023 09:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/3] Kconfig: Add dependencies of POWER_RESET for x86
Content-Language: en-US
To:     Yuan Tan <tanyuan@tinylab.org>, tglx@linutronix.de,
        mingo@redhat.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, falcon@tinylab.org,
        w@1wt.eu, linux@weissschuh.net
References: <cover.1694687048.git.tanyuan@tinylab.org>
 <0f2cbd3026357a3936c0853057ed41b63db83d59.1694687048.git.tanyuan@tinylab.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <0f2cbd3026357a3936c0853057ed41b63db83d59.1694687048.git.tanyuan@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 03:36, Yuan Tan wrote:
> x86 and x86_64's power off depends on ACPI and PCI to work. Enable them
> when POWER_RESET is set for convenience.

I'm a bit confused by this.

Which code is this referring to, exactly?  Are you saying that no x86
system can power off or reset unless it supports ACPI or PCI?
