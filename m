Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9F7D42A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjJWW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjJWW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:27:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1810C;
        Mon, 23 Oct 2023 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VVhvRIlQqXGnJRR9+75jpe4XOyrEd50DqThibj3ReZo=; b=B28j4+UgaFzw453tRvs72NdXSl
        I2Z0dLC5hPPnj0ywIP5zD8YYstf4UXvNhnlomEnP52ijEefej+i9InagDQXrsphVZFatJWYfCYYFd
        htEYny0GJEj0XsOENTwyCHhAyGfzldVAyhXVR0zoHH8LN+LBTQeDpedAycF8WYj5SvASyFDXrOM6K
        SWQbXwxJqe7ZzsBlfuWLsxP1uMlkVAfjJ8oKk8vyb5j9RaFN98HYEKToRCHwySwCtxrcfjT6qqiAJ
        +Kjn4YhiIMaYnfi0xuqjgY+YLpQ5Mvk0d8ZBju1ztybgKLcCWNOgqJtwWSac9TPeUPZdoOl8Hi7Dv
        4N+z7nJw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qv3OG-008Mvt-0W;
        Mon, 23 Oct 2023 22:27:16 +0000
Message-ID: <9e56e94d-536e-435a-afb0-4738e6eddedc@infradead.org>
Date:   Mon, 23 Oct 2023 15:27:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 23
 (drivers/iommu/iommufd/hw_pagetable.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <20231023165831.30d525ad@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231023165831.30d525ad@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/23 22:58, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231020:
> 

on ppc32 or i386:

powerpc-linux-ld: drivers/iommu/iommufd/hw_pagetable.o: in function `iommufd_check_iova_range':
hw_pagetable.c:(.text+0x90c): undefined reference to `__udivdi3'
powerpc-linux-ld: drivers/iommu/iommufd/hw_pagetable.o: in function `iommufd_hwpt_get_dirty_bitmap':
hw_pagetable.c:(.text+0xa4c): undefined reference to `__udivdi3'


Is there already a patch for this?
Thanks.

-- 
~Randy
