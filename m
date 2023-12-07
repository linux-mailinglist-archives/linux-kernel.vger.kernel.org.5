Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED4807F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443147AbjLGDFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjLGDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:05:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60919E;
        Wed,  6 Dec 2023 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IEfEAW8Upymct/6VGRYrscPfQ9rwqDyeWXvyRn18uJw=; b=BtIVegwCorHHSu8ndACf/UxXbK
        ZujJD8nArCsBUBERFNWhPFTccfqj0K2pKUYOJPfBkg7AKVKYBYJXM4aexPgL5GbXZccWGdd3JxPim
        mVJB0vOUXZIjsUDqcuZGpwyJQOrq5DDwEFoD8c/kUVOTA3Plq13gd7XgoKnzTJfy2JUohIqy3f0pU
        oidHOobCFWj0qmmivEMRm4J9Oy0RsE7HlIxc1QjRePPga6LI0WzjV4vRHh5LI3u11LRKckQZ1SsRe
        eNm5n3IkliGntyNHcjrgm/jYvoovCsgcJVgKegOhEIaWitt2eNp7Jxw/pij/XO5A1x8tXeLtDIMge
        9eyMrvDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB4hO-0083q0-2D;
        Thu, 07 Dec 2023 03:05:14 +0000
Date:   Thu, 7 Dec 2023 03:05:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] hlist-bl: add hlist_bl_fake()
Message-ID: <20231207030514.GW1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-8-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-8-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:05:36PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> in preparation for switching the VFS inode cache over the hlist_bl
> lists, we nee dto be able to fake a list node that looks like it is
> hased for correct operation of filesystems that don't directly use
> the VFS indoe cache.

I'd probably put it as "we need hlist_bl counterparts of hlist_fake()
and hlist_add_fake()"...
