Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6D7B78AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbjJDHZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjJDHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:24:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3FF98;
        Wed,  4 Oct 2023 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696404295; x=1727940295;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J45APvEWw0Qw6avaptNiCzbHSD2QuFuV6PHhzGyCKcM=;
  b=BQ7vlZDZdGA0lJZAaUa3dVp6p+dlLrAHbNfNVS2te34FtiORUUjYDKvp
   2CfXJ3rfafyF6ecb0jMHXsqmpwhrJ3PpZoO8ESDrAHEuvsMj6OszU8B5Q
   W4J/ey/PJJetih0FW2DxO78wF1nG+MuCUy0dEZbpJOhi8L4JzgewBIyxA
   ofSxiVQ8lJpN1NC+xsAb7qMqTMhS0DLWxe9OMPdixMZh+G2iblVeW6C1L
   XbaW0V1ML/D/S5jhnZj10w1WY7qcAFKHlVxGff3YGtnr0+LMa/1IaV9U3
   v7ndLLjBNPzEnUqPk4OgqanBl4oGNRQbsItLVUW8HnlZVjCfBdZupgaq7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447259904"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="447259904"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="924978119"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="924978119"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:24:53 -0700
Date:   Wed, 4 Oct 2023 10:24:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V2 01/13] platform/x86/intel/vsec: Move structures to
 header
In-Reply-To: <20231004020222.193445-2-david.e.box@linux.intel.com>
Message-ID: <ac9ee86a-43d5-f72c-ca6b-e73e6c30f6f3@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com> <20231004020222.193445-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-78298424-1696404295=:1931"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-78298424-1696404295=:1931
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 3 Oct 2023, David E. Box wrote:

> In preparation for exporting an API to register Intel Vendor Specific
> Extended Capabilities (VSEC) from other drivers, move needed structures to
> the header file.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V2 - New patch splitting previous PATCH 1

Thanks, so much easier to review in this form! :-)

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-78298424-1696404295=:1931--
