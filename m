Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBEC7A4C47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjIRPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIRP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:29:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C43E73;
        Mon, 18 Sep 2023 08:26:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D8C32795;
        Mon, 18 Sep 2023 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695050239;
        bh=URrgxBmmjOm5I5ZVE48VrpmsQfHoO3kqUULfZBBaFfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpiY81vwOCn31BF7i0beAwTwa7d1uqPpEJrKIrpIbR46grtvPT8LqRJ23Pa1q2ZSF
         cgdi1L3YwAUHH/mySmjimE9q5aUuGVbMOjhiSrYocBMe+VibwOWawWejy2BoB0hdFu
         D8O4K44DQGmJwdc7cyjiOvN9fh+d7GyfkuDR3QXQ=
Date:   Mon, 18 Sep 2023 17:17:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] driver core: platform: set numa_node before
 platform_device_add()
Message-ID: <2023091804-pope-gumminess-8259@gregkh>
References: <20230918134527.252-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918134527.252-1-guojinhui.liam@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:45:27PM +0800, Jinhui Guo wrote:
> Setting the devices' numa_node needs to be done in
> platform_device_register_full(), because that's where the
> platform device object is allocated.
> 
> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Where did I provide this tag?

