Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5915B800B41
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378907AbjLAMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378882AbjLAMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:44:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699101A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:44:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36CC433C7;
        Fri,  1 Dec 2023 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701434647;
        bh=ah7J3Jqo85Y9L6UmtUaNFJgYT5iUf/nZE7iW/HuhMYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnrmfvMkp6yoWoq8NJ1XEtT4O7m4/JQFa1GxIQtgU5F5aVDX1HP/VVulkZDwyD9T4
         BGMGmR+Ksv/nWBy6gUv3Kf7zzXD15PwDGmDpOZ3O6677P90vL/UIHKVpfsF9QLy/r8
         85SsqfXldhr9nl3+62tAyAV3Mi9xas7AUdSF1E1o=
Date:   Fri, 1 Dec 2023 12:44:04 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
Message-ID: <2023120139-staging-sprang-7e77@gregkh>
References: <20231201123205.1996790-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201123205.1996790-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:32:05PM +0000, Lukasz Luba wrote:
> The policy returned by cpufreq_cpu_get() has to be released with
> the help of cpufreq_cpu_put() to balance its kobject reference counter
> properly.
> 
> Add the missing calls to cpufreq_cpu_put() in the code.
> 
> Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Cc: <stable@vger.kernel.org> # v5.10+

But the Fixes: tags are for commits that are only in 5.12 and newer, how
can this be relevant for 5.10?

thanks,

greg k-h
