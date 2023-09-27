Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6C7AFFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjI0J0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjI0J0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:26:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A207F3;
        Wed, 27 Sep 2023 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qfYeV0mrUskADI6kvUE3qnG1PQGSpjmorA6QIfYZs4E=; b=T0I0TLBW7+PUBIN/h5ANXCHLiI
        okhgJ9NsFg/rdLas2o0yGamLfpYUCdOzttLZYJwMzStw1KteKcFykQN4GtztPZfHkBwGHdJ6/elbF
        EDFWskh1i8J24IRoufVN/OUoUIUhUS3WkJ/9FmDnKUgxWC/kExEBSX/2tg6eW3e4fwqNyXdamM4er
        EzgxL5bQnCckge9cdIhavxE7GYgKOKWrqDZ93xMKH2cUmWMNGONr+qYIxM3K8tFyHuDopFTDgWSZO
        GS41L/NqK+jta2t2RCBZtoBmcR/lVPhMtkgOXJdxg9uukH6WAMgO/TU9sASogTbCKap9JHDArJo9T
        PpZNXyRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qlQoR-000T6Z-2P;
        Wed, 27 Sep 2023 09:26:31 +0000
Date:   Wed, 27 Sep 2023 02:26:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org
Subject: Re: [PATCH] net: appletalk: remove cops support
Message-ID: <ZRP1R65q43PZj7pc@infradead.org>
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:00:30AM +0200, Greg Kroah-Hartman wrote:
> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.

Looks good:

Acked-by: Christoph Hellwig <hch@lst.de>

