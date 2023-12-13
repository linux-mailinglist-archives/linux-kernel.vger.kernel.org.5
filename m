Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A31810CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjLMItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:49:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36826E8;
        Wed, 13 Dec 2023 00:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I+dkvxeAcae4QrSyLPuuRO1x+IeiVhS+Knt3ouNUsYk=; b=QCb0AqSkp4xdsj2xNyFWhYHV+F
        5D6njHGju8uCFzrj9nxpbiOXMeQsgpOyg4rX/SgXH69cD+nVAZROL904DvKZW8IVwEg8nmiakvXZx
        MJ9zQAq7fRXDPAYCe5FYSx18oeCwfmD1XVCn1kWueFpbqhZfFV1d0/82E7r8X+pyOmFcNqUfphQYp
        r92j0FLSF4jlcVBD8U/6GLKha1o03Z8DWeBOJTKp3o5IyUw8o3V39O5gv7B9H5ylR+ABXjI3IkToz
        skDWmPOwgXvjjB99RtsCqDkHzjLs/M1qecbS/cqn2QOKllZZFo1MQtBbLARyE0g7KWWXPNOjqDmrG
        eaKXiJPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDKvu-00E5Bt-0l;
        Wed, 13 Dec 2023 08:49:34 +0000
Date:   Wed, 13 Dec 2023 00:49:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] btrfs: factor out helper for single device IO check
Message-ID: <ZXlwHgQpFTWxd7Ag@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-1-b2d954d9a55b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-1-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 04:37:59AM -0800, Johannes Thumshirn wrote:
> The check in btrfs_map_block() deciding if a particular I/O is targeting a
> single device is getting more and more convoluted.
> 
> Factor out the check conditions into a helper function, with no functional
> change otherwise.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
