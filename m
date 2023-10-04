Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A17B7ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbjJDMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbjJDMOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:14:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D3C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A82C433C7;
        Wed,  4 Oct 2023 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696421661;
        bh=fff8v4/61tUh9ShqU1effVhQXWYy0R5I3axgVxyLMdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNeyRWRUwC5JCM5xWi8dJGga5y1/nbhWwSwWkY49upOOACupldRtZZyPqPQmHff2v
         eKcl2P6jcvWpkeSO6LcRo7NGwbz4iQOrKc5ArLWaJ+wYRyspXSAOb4xkRYx/WmoQuO
         /YjdMFWLzoV2hnJ7I/xD90peMPrIaZhj8tHZvu8Q=
Date:   Wed, 4 Oct 2023 14:14:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     michal.simek@amd.com, tanmay.shah@amd.com,
        nava.kishore.manne@amd.com, ben.levinsky@amd.com, robh@kernel.org,
        dhaval.r.shah@amd.com, marex@denx.de, izhar.ameer.shaikh@amd.com,
        arnd@arndb.de, ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] firmware: xilinx: Update firmware call interface
 to support additional arg
Message-ID: <2023100445-rising-brittle-fe69@gregkh>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-2-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004094116.27128-2-jay.buddhabhatti@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:41:11AM -0700, Jay Buddhabhatti wrote:
>  int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
> -			u32 arg2, u32 arg3, u32 *ret_payload)
> +			u32 arg2, u32 arg3, u32 arg4,
> +			u32 *ret_payload)

You do have 100 columns to use now, why wrap?

Same for other places you did this.

thanks,

greg k-h
