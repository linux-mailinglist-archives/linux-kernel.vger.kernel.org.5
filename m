Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3845D807F07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443157AbjLGDCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjLGDCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:02:22 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCF137;
        Wed,  6 Dec 2023 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wkUbEgsT8kNDGnTQ+f2FTszBUpCpO7t7fL8xzputNT4=; b=r00ehVHVV4tFckzjwm9kVevs98
        cdFDuHzbnScMOKmGjjs62I666xSsM7nibYUEvZ2TUwz90A+UfZXQ2LzQSndu8Ctmasw08Sm1/6LHL
        NbNV4obpYC8XDsyROBsHgpHZkwrlxuB55YP7LTSWJHSlfFPjSlMUAUuUxRZkAExGbigmq9+6mSv/e
        +s1IwT7QGhdE2AnM2ThIcfSQan+ezCrwVnwetc44D5yoWn9H17F1vzBME2wQP7MEzV+qQLUd7euxn
        VUlHKiOFh94YqLSonRQye73MO5teOUsBG1RmYEOQ7TpfnrG6MutGtAoIPRi1bxCOCe/41i778aWnr
        vdU9lGOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB4ef-0083nC-15;
        Thu, 07 Dec 2023 03:02:25 +0000
Date:   Thu, 7 Dec 2023 03:02:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] vfs: factor out inode hash head calculation
Message-ID: <20231207030225.GV1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-7-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:05:35PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> In preparation for changing the inode hash table implementation.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
