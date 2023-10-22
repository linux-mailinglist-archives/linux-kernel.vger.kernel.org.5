Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B956D7D26F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjJVXX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 19:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 19:23:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17899E6;
        Sun, 22 Oct 2023 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698017031; x=1729553031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1uG4PliELumxFv3Iv5PWFscUIM/AN45SAGtoLhl2+Q=;
  b=L8pIaMHbn52tF0woLOM/4Xccb9UR+PDtxdNyRmTrix0UY8FCnOSSghjK
   KgjBF0bKY4DSxbuHv7+KnMh+xfrqFhDX45iDH5FhP9Ftzuzno+KCnDwon
   Xq1f2ujdidQT83NYJFsptAbRvBfQImpyH2dAsaRYjnDXTbpUUbOle65ln
   hNgQcCEwZXPbxsvoa1KLuFpbY1ZkNr+MJVpWpkupWkAcsbL6ERDa4toWZ
   dvV4RQOoVPrrxKhjxLIrIpHObxrMffc/zxHkAHYJQDv3FDY+wlttiDtjC
   AP2RRjc4LsjkSNHoSjZcYLjUH4f98JOzh1fHzpAzQfRhNyOynV3z6zfGr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="389585843"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389585843"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 16:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1005129771"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1005129771"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 16:23:50 -0700
Date:   Sun, 22 Oct 2023 16:23:48 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: Add inline-account tool
Message-ID: <ZTWvBN71k3QSxZqB@tassilo>
References: <20231020161217.255765-1-ak@linux.intel.com>
 <CAK7LNAR4Z3O+qZwhc6w7MGEbJsd6B8QZtz1p4_F7OO3jK+aigA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR4Z3O+qZwhc6w7MGEbJsd6B8QZtz1p4_F7OO3jK+aigA@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How to use this tool?
> 
> I did not get any output?

Hmm, perhaps you need CONFIG_DEBUG_INFO=y ?

> I do not think this patch is mature enough
> regarding the coding style.
> 
> Please polish the code.

Don't follow. It's standard python code style, and the 
other python scripts in scripts/ use the same.

-Andi
