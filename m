Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B27B3EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjI3HG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjI3HGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:06:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F033FA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:06:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A607C433C7;
        Sat, 30 Sep 2023 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696057613;
        bh=DSppv+puotLzLGa9P89I9XPs6L6xfrHSkKaipjzNnGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHUqL8TwN9w7SazoLtaCEqx9fopxIPS332QJ2cXRvzKbhE1Y+6HBQB9m3F5/fmgpP
         /9ELdRLGy84YrjfifmI7G4+kmtLvUcm2NAF60WeZ0xDWTK51WyEpzDNckE25aVRl9l
         uQABzr9h+gKVMkQMccQWZzQGFCT6LV/Bb2ux0uZ4=
Date:   Sat, 30 Sep 2023 09:06:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Leech <cleech@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023093055-gotten-astronomy-a98b@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929170023.1020032-4-cleech@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> for dma_alloc_coherent buffers.

Why are ethernet drivers messing around with UIO devices?  That's not
what UIO is for, unless you are trying to do kernel bypass for these
devices without anyone noticing?

confused,

greg k-h
