Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87BB7591DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGSJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGSJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D05D10D4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC76F6134F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B008C433C8;
        Wed, 19 Jul 2023 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689759884;
        bh=oyC8+51fu/8hbXHd/jdrqz4m+gvM97rqzFKz9D8GHDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QftIU3p1IxnDxY7dPXrEYITZSubiWsVyp7D72Oyi0f2+X4h9qsdvLBZwQ0H7Gg5V0
         PBVs3fS3sdduA3S8hhWU+nglPHV9vG2XOFX/K6eic4wrADJrKEiQ17Bs04ae0EO+OB
         LkdUU7jNFnMmOE57efP87/pE3mFLkQ+IoEgnl1Tq61ZCcUcUhEpvMWi424YvLby/Mz
         jiZ9V7CCEGuouVdLguUAGwRODVcVc8Xg9lG0w2ZxA+Gy8JY7GNvZkN2amKyHd7C1ti
         DfV+4PJEeeICA8+ttHBLKa9xCGIPD+YzFpILpa8XS/P1Ko0bFtuFRzlhG8+jIxA9Bg
         H7LCg7KvYTPeg==
Date:   Wed, 19 Jul 2023 12:44:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] add page_ext_data to get client data in page_ext
Message-ID: <20230719094421.GI1901145@kernel.org>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:58:09PM +0800, Kemeng Shi wrote:
> Current client get data from page_ext by adding offset which is auto
> generated in page_ext core and expose the data layout design insdie
> page_ext core. This series adds a page_ext_data to hide offset from
> client. Thanks!

Implementers of page_ext_operations are anyway intimately related to
page_ext, so I'm not convinced this has any value.
 
> Kemeng Shi (3):
>   mm/page_ext: add common function to get client data from page_ext
>   mm/page_ext: use page_ext_data helper in page_table_check
>   mm/page_ext: use page_ext_data helper in page_owner
> 
>  include/linux/page_ext.h | 6 ++++++
>  mm/page_owner.c          | 2 +-
>  mm/page_table_check.c    | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> -- 
> 2.30.0
> 
> 

-- 
Sincerely yours,
Mike.
