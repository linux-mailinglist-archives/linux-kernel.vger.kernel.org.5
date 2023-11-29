Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDD7FD7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjK2NYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjK2NX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:23:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76EA3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:24:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FCAC433C8;
        Wed, 29 Nov 2023 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701264242;
        bh=1NbDZfh8R1r80cG2RxeClfnngCV9fEBcQY0EYYXzdXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOLmr3y0gmg9UK2nge9FwAY4v4u0n/qscw6QMpBPSYu7oAoWC6DyLDg1O5HJVk2w2
         iCkDburLZyxf3ZWWyB96VX4SdKBpmRnw/d8E0k6GQFjY5tj2aYROnVDZP5XuRj4fJM
         JdSzXA57JzFAxMviX6WiPtAbHkCCD3tOH7S8YoWCOXheww2wmDXYx4P+vJ1TDDXHiS
         mRFQyyAWR4EO1JSx/FGWkwL1rNq81Nlk6Ep0BRU0nFjPwYOuzVHfizSq8vC5Cooy90
         18A4AdHN4ndYCogaNOM1MwNZro37homwTu2F3iNC4N8YrJ9UVu2RCEYqCUl2lpep+R
         udDUorHEPj6Hw==
Date:   Wed, 29 Nov 2023 18:53:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v10 02/14] dmaengine: idxd: Rename drv_enable/disable_wq
 to idxd_drv_enable/disable_wq, and export
Message-ID: <ZWc7bRoRuqQ+hPt4@matsya>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
 <20231127202704.1263376-3-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127202704.1263376-3-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-23, 14:26, Tom Zanussi wrote:
> Rename drv_enable_wq and drv_disable_wq to idxd_drv_enable_wq and
> idxd_drv_disable_wq respectively, so that they're no longer too
> generic to be exported.  This also matches existing naming within the
> idxd driver.
> 
> And to allow idxd sub-drivers to enable and disable wqs, export them.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
