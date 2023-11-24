Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E87F7397
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjKXMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjKXMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:15:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043CD41
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:15:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE8C433C7;
        Fri, 24 Nov 2023 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700828154;
        bh=xWJDM89s7PEji+2SZq/p+Vm/gSZqz0iXR9i8e95E0SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8eTrReb+GVfr8lTv7ZL31nlMfW3VZ77M7/wAcKveA5oin3ne8kb4VF7oCW+sxGU2
         KF0LPPf3s5dG5n4lCaLVcxuaecJEPIUERJKOZb+1OSTA2xGYWEubHkbtwPThKVcy9q
         cjcKRI5sVDxPlcKuCySoFWl4e8rf3IqLoa7Sm1xmqQ99ZD0VPRyWwBwbc6H+ilAXWH
         vaDlqG9PFmt4gJRMw22EVT7pj2pYahuxR03B3LQOFN/4kz4IxHX51aewxUbGLMOjmM
         qPgcJ4NRHmq9B1yr5IQFnQpCtosEzdmOXXykZ9Zg81cb3hRjx0kvKrxsVt/rrxIqLt
         zr+XkZDwIroiw==
Date:   Fri, 24 Nov 2023 17:45:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 09/34] dmaengine: idxd: optimize perfmon_assign_event()
Message-ID: <ZWCT9sHhtTsx3u+t@matsya>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-10-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118155105.25678-10-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-23, 07:50, Yury Norov wrote:
> The function searches used_mask for a set bit in a for-loop bit by bit.
> We can do it faster by using atomic find_and_set_bit().

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
