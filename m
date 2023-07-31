Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2BA76948B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGaLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGaLSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:18:12 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28764E52;
        Mon, 31 Jul 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690802292; x=1722338292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=87FJUSPLcNXOCb7lHfymEPJKHULKnzHi3EOabZ1gBGw=;
  b=PbRZrZDQV18A7KoxfUbO5ap13+ZUmfrFfuKSsI49ovs7gRLi12MFngVg
   dHkQwpWhpi7xCvAFdwv3D4sUlfGu/vPHQ5Ih6gaVTwmU+CghrTtbccO4l
   DUeQUBbAt1N/7pOUYo1ozrK83xRO4IcbZkugVROJwkO+A+dvdSTe7zQPR
   JnJD0FUEB7EiM6k7bg5xb2xI8D2md6MT+oIhfp3vCXk0tYDYq4I2RjNDv
   zMzrPLk9UCxJSCFmF/IKkwKvPilHWVA7t/U2sqLShcbS+JGPKCIjJIL9N
   DkJMSOrQCn/evYnay0pFmQfl/xkvIJQFXCqBorqXiOIp3/SFa9ynv9Him
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="399939020"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="399939020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 04:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871645957"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2023 04:14:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A981B1E8; Mon, 31 Jul 2023 14:14:15 +0300 (EEST)
Date:   Mon, 31 Jul 2023 14:14:15 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: set variable tmu_params storage class
 specifier to static
Message-ID: <20230731111415.GH14638@black.fi.intel.com>
References: <20230702190608.3441704-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230702190608.3441704-1-trix@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 03:06:08PM -0400, Tom Rix wrote:
> smatch reports
> drivers/thunderbolt/tmu.c:30:3: warning: symbol
>   'tmu_params' was not declared. Should it be static?
> 
> This variable is only used in its defining file so should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied, thanks!
