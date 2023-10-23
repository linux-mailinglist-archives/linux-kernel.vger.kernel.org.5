Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9C7D4289
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjJWWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjJWWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:04:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343383
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698098682; x=1729634682;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=MqyemEmCCo8/gZeC6kbwvDHCFwfdIhjprp0ACYcLCWM=;
  b=CZ5koS6tN5ECz3nAcRIWM92vHEyzV2YBVtVexlow2SEmXhZwIM5VI/Al
   ORmFs0LQrx676ord8yhFGb3AB68JSdD/Pv0gAVxGfsSoF+tjeb0eDQOX3
   FbcNTDs32SPOudOlga+KyjFUC3ZQzffOB74WrAzxiWmQqD+/AumFXMvYW
   9PBkLrGh43x/znccpsbYtIEFSHMapI2EgHnFCDpET2QmYZZy2v5WlIUXy
   NCv2iqRUoo1wXyqf5Ib1S6NiueyKBo2wUyU4mIAwXbv3byfVhFsmRzYfM
   sSFQ143o10uH+RkB1MWn96LBHCwDBFZeQqHDFdWlqKI/0a4pUZOKs/mC0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5564861"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5564861"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 15:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828590920"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="828590920"
Received: from dahansge-mobl.amr.corp.intel.com (HELO [10.212.208.196]) ([10.212.208.196])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 15:04:40 -0700
Message-ID: <a13b3481-ec35-446d-ac7d-9581ce87646f@intel.com>
Date:   Mon, 23 Oct 2023 15:04:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Subject: 2023 Technical Advisory Board election info and call for nominees
To:     linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2023 election for membership on the Linux Foundation Technical
Advisory Board (TAB) will be held electronically during the 2023 Linux
Plumbers Conference, from November 13 to 15.  This announcement covers
both the call for candidates and the details of voting in this election.

The TAB exists to provide advice from the kernel community to the Linux
Foundation; it also serves to facilitate interactions both within the
community and with outside entities.  Over the last year, the TAB has
overseen the organization of the Linux Plumbers Conference, released a
kernel  contribution maturity model for organizations, advised on
code-of-conduct issues, and more.

CALL FOR NOMINATIONS

The TAB has ten members serving two-year terms; half of the board is
elected each year.  The members whose terms are expiring this year are:

 - Jonathan Corbet
 - Greg Kroah-Hartman
 - Sasha Levin
 - Steve Rostedt
 - Ted Ts'o

The members whose terms expire next year are:

 - Christian Brauner
 - Kees Cook
 - Dave Hansen
 - Jakub Kicinski
 - Dan Williams

Anybody who meets the voting criteria (described below) may
self-nominate to run in this election.  To nominate yourself, please
send an email to:

	tech-board-discuss@lists.linux-foundation.org

Please include a short (<= 200 words) statement describing why you are
running and what you would like to accomplish on the TAB; these
statements will be collected and made publicly available.

The nomination deadline is 9:00AM EST (GMT-5) on November 13.

VOTING IN THE TAB ELECTION

The criteria for voting in this year's TAB election are unchanged from
2022.  To be eligible to vote, you must have at least three commits in a
released mainline or stable kernel that:

 - Have a commit date in 2022 or later
 - List your email in a Signed-off-by, Tested-by, Reported-by, Reviewed-
   by, or Acked-by tag.

Everybody with at least 50 commits meeting this description will receive
a ballot automatically; they will receive an email confirming this
status shortly.  Eligible voters with less than 50 commits can receive a
ballot by sending a request to tab-elections@lists.linuxfoundation.org.

We will, once again, be using the Condorcet Internet Voting Service
(CIVS) https://civs1.civs.us/ . This is a voting service focused on
security and privacy. There are sample polls on the website if you would
like to see what a ballot will look like.

Please contact tab-elections@lists.linuxfoundation.org if you have any
questions.

