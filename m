Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B880CF81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjLKP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjLKP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:27:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB0EDC;
        Mon, 11 Dec 2023 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702308482; x=1733844482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bggHoXiU68cBQ7oYAKkT9kMUxOTajjceV/9v3ldJhH0=;
  b=LqtbuDcL5MwUCHzpQxD8papxZI0Pjjr5Ysk7sKRTGndDuqctKngp2fWw
   Hjp2qGiO75zcaYV3Ez0g6fN+eLEBcFLbwp5gsYqLqfquO6d3pR1X1OhtR
   fwdO1xC1p+bNhNIdIrTXW68g7vx6BPUJr73B0Fg/ofd5XwYXZB2IgqCVb
   IJr0J7WkaiZOL/BbOUjYa8f3Evq+fo6pgfl91RkccFT6HC6QJB86PKCdc
   YKj7/R11XjamsVYzG8Rg/tGuvmsU6Sr77ZtI3uFqYzxxDffN7BZv/1U4o
   58k2hmBGTFh04l47/ypCpGxdXHYLzM5l/iflwRUgrj+F0aj8IcbBilnIU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461141946"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="461141946"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="891175897"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="891175897"
Received: from pasangle-nuc10i7fnh.iind.intel.com ([10.223.107.83])
  by fmsmga002.fm.intel.com with ESMTP; 11 Dec 2023 07:28:00 -0800
From:   Parshuram Sangle <parshuram.sangle@intel.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, jaishankar.rajendran@intel.com,
        parshuram.sangle@intel.com
Subject: Re: [PATCH 0/2] KVM: enable halt poll shrink parameter
Date:   Mon, 11 Dec 2023 20:58:42 +0530
Message-Id: <20231211152842.22777-1-parshuram.sangle@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102154628.2120-1-parshuram.sangle@intel.com>
References: <20231102154628.2120-1-parshuram.sangle@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft reminder for patch review
