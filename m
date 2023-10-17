Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB857CC938
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbjJQQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJQQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:57:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F8592
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:56:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1487AC433C7;
        Tue, 17 Oct 2023 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697561818;
        bh=RCqEA4EjJgbOcZTfdfXQm/IITm2752KvO1ZvbyXbBW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFR/NVQeHNOupCOKU719/W4nPTEYiCvMSv9HU/vssvPFmBz0UQzqh6RdG2bLWJyJj
         3sGEOGkj3F/7gKNEpuEUSKICBdhIDcDiISIr87JqhlER5c9uWT+ZVvI6n9m4zWt3a1
         2wG3KMl9nDcu5ZMVW0n92Ay9ToJhaHmWeHOV6nxQ=
Date:   Tue, 17 Oct 2023 18:56:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [drivers/char/mem]  1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
Message-ID: <2023101759-front-ember-6354@gregkh>
References: <202310172247.b9959bd4-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310172247.b9959bd4-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:06:42PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -99.8% regression of stress-ng.splice.ops_per_sec on:
> 
> 
> commit: 1b057bd800c3ea0c926191d7950cd2365eddc9bb ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	class: pipe
> 	test: splice
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.splice.ops_per_sec 38.9% improvement                                       |

So everything now goes faster, right?  -99.8% regression means 99.8%
faster?

thanks,

greg k-h
