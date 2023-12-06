Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8A80650E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjLFCgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjLFCgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:36:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EE9E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:36:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC5DC433C8;
        Wed,  6 Dec 2023 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701830175;
        bh=jl8ZgGJcA+2u2wRfb7gRBaYrQkwzkFENKH/0Cgo3FZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bX2eZiVpgXQ2pNi7+lhIJhnsL8/i3CVmd9OAdZAcCaDfvL/BtLey7fmRifKPSg7Bg
         2hUAWGrF7H+dDWBTNLONt5j2YJbvUifsT+6kpK+DF7W0K9ktJU7yfkhiaQLPGRz0iV
         hhmoaQ4gLUI821DvgDIAiSRVCc1tEhKyy+sSjmOw=
Date:   Wed, 6 Dec 2023 11:36:10 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourav Panda <souravpanda@google.com>
Cc:     corbet@lwn.net, rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
Message-ID: <2023120648-droplet-slit-0e31@gregkh>
References: <20231205223118.3575485-1-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205223118.3575485-1-souravpanda@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:31:17PM -0800, Sourav Panda wrote:
> Changelog:
> v6:
> 	- Interface changes
> 	  	- Added per-node nr_page_metadata and
> 		  nr_page_metadata_boot fields that are exported
> 		  in /sys/devices/system/node/nodeN/vmstat

Again, please do not add any new fields to existing sysfs files, that's
not going to work well.  You can add a new sysfs file, that's file, but
do not continue the abuse of the sysfs api in this file.

thanks,

greg k-h
