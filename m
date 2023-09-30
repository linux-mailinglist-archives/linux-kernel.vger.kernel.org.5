Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410297B4304
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 20:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjI3SaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjI3SaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:30:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186AD3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:30:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110ACC433C7;
        Sat, 30 Sep 2023 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696098602;
        bh=Y4imC89W3KdMY2UPdzMV4XPUqHsU4iC+LIa8tI7NQ8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1RyzUb0dql97BmSTWWXH4WElBuESRh1nfdjAYmTH6vuLq7CQYn81zMxLMOFAd/clX
         iF+kliizT2sMMAonxvxRvneMRkqHLihK8T/2wT2afNvjL8A1K1mlo4KXLJcHHMSGmr
         Y47tDVyqgVi4Hl20otmWlcRMF8i+XqmAWjqicUL0=
Date:   Sat, 30 Sep 2023 20:29:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Chris Leech <cleech@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023093003-city-pursuant-956e@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <yfws24bzfebts5mr7n7y4dekjlrhlbbk6afr6vgbducpx4j2wh@iiftl57eonc6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yfws24bzfebts5mr7n7y4dekjlrhlbbk6afr6vgbducpx4j2wh@iiftl57eonc6>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 02:10:50AM -0700, Jerry Snitselaar wrote:
> [1] https://github.com/open-iscsi/open-iscsi/blob/master/iscsiuio/README

That's IP offload, not what UIO is supposed to be for at all (yes, I
know DPDK abuses this api as well, and I hate it.)  But this is on a
network card, it shouldn't need UIO.  Why is iscsi somehow "special" for
this?

still confused,

greg k-h
