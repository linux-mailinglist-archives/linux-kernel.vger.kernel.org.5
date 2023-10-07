Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEAC7BC713
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbjJGLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjJGLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:21:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC5EB;
        Sat,  7 Oct 2023 04:21:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E27EC433C7;
        Sat,  7 Oct 2023 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696677688;
        bh=ypPx73/HPVt+pc+5aZZOAJz1R6TMbfAvk+Bltq6Z5Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pi87RE23MySu6BfirA5WmmiZ8HSYuKP4fjZOAXlJ5tVih/q1dihOzZuk+N4wqWkvO
         lr6A6n0ygAmwNwKRYnLoMa8sekL9NeDhhFZMB6Vo2Hy83DXo+wJ+mfSxlg2XCeH+Ez
         qX6A0vyTJdn/EHELMKb22ZHjs9QuADxOIWmbXWus=
Date:   Sat, 7 Oct 2023 13:21:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, joe@perches.com, blamoreaux@vmware.com,
        linux-kernel@vger.kernel.org, vegard.nossum@oracle.com
Subject: Re: [PATCH 4.14.y] drivers core: Use sysfs_emit and sysfs_emit_at
 for show(device *...) functions
Message-ID: <2023100737-enchilada-angriness-2a42@gregkh>
References: <20230922121454.2735355-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922121454.2735355-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 05:14:54AM -0700, Harshit Mogalapalli wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> Link: https://lore.kernel.org/r/3d033c33056d88bbe34d4ddb62afd05ee166ab9a.1600285923.git.joe@perches.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [Harshit: backport to 4.14.y -- regenerated the diff with the help of
> coccinelle script in driver/base/ directory.]
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested. This fixes CVE-2022-20166.
> It is not clear whether the CVE was assigned for a demonstrated issue
> or just a theoretical one. In any case it's a good defensive measure
> against future patches that may introduce a real issue if they assume
> this patch is already there.

This is not needed in this kernel tree, so why are you attempting to add
it?

And if you have questions about a CVE, as the entity that gave the cve
out, they are responsible for it, not us!

thanks,

greg k-h
