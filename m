Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43B7EAFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjKNMWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjKNMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:22:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157C130;
        Tue, 14 Nov 2023 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699964540; x=1731500540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83oVHOMWmo585ZtLA1OZ4XOOSq7Vg/fHO3TUuPuK0GU=;
  b=k0cFwMG97mv084oKamncnPK9pEm4cTpTxAiidTzJEkZuVRwLbrdr2nHY
   rQabH8EDlgzMWMUEj4Eml+ZBE+9S1PYSr8Cg47c5tNN6Iif2fB31MF8aF
   xjsAtRr53Kh8flQKl3tIMcbquOPk9JJSF4LqeAlo5q9fL1oiDp4T/OQ8I
   +zgD5GrfZ1nZsr2Y4u70zKugKrKJVZ5JPLoJz9THHZi7tGrlEHCgUfZ8m
   pgm/xfTp/yiKZ2nlQibT4LnD5wPZUBIzWOA6FrSnEb4/jriFQ9gvuEL7S
   zQqLg2jAabWtC+bnjG4Y7HsTJ03BNSZLimVyq5DFHZ2WnfT0jEX1aDhit
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="9283010"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="9283010"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="938075811"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="938075811"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2023 04:22:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0B0AF5E2; Tue, 14 Nov 2023 14:22:15 +0200 (EET)
Date:   Tue, 14 Nov 2023 14:22:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thunderbolt: remove duplicated re-assignment of
 pointer 'out'
Message-ID: <20231114122215.GX17433@black.fi.intel.com>
References: <20231111201543.338893-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231111201543.338893-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 08:15:43PM +0000, Colin Ian King wrote:
> The pointer 'out' is initialized and then a few statments later being
> re-assigned the same value. The second re-assignment is redundant and
> can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to thunderbolt.git/next, thanks!
