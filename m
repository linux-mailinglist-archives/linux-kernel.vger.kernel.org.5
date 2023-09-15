Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB17A1677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjIOGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIOGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:51:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493812707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:51:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A7FC433C8;
        Fri, 15 Sep 2023 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694760713;
        bh=PQoeNqV6xHn7JACo5D6UVtHw6kZFO2kntyCiUbxhaDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DilZRN7JAb8G+9kk1vgiNoy1SKXy1zou8JL3D0lzUIxto+hiFbV7mBJDXwB7CMSk5
         8EnNpLMLn16HijWN14skXIETQeK8sXDTJkKZ9vu5Bm2jpWfR8CRnkgxY+bIPCsyfWF
         pwe6snVlnhkxLJveMlns+EINWhH8cS0EtfgT6Pfk=
Date:   Fri, 15 Sep 2023 08:51:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Ricardo B. Marliere" <ricardo@marliere.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+bbc59256015533127d80@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers: core: ensure device has a name
Message-ID: <2023091533-subdued-antler-d6ac@gregkh>
References: <20230915011930.199009-1-ricardo@marliere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915011930.199009-1-ricardo@marliere.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:19:31PM -0300, Ricardo B. Marliere wrote:
> device_add() relies on dev_name() and dev_set_name() to set the device
> name. This patch adds the fallback case where both the call to
> dev_name() and (dev->bus && dev->bus->dev_name) fails.
> 
> Reported-by: syzbot+bbc59256015533127d80@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bbc59256015533127d80
> Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/base/core.c | 2 ++
>  1 file changed, 2 insertions(+)

Already submitted and in linux-next:
	https://lore.kernel.org/r/20230828145824.3895288-1-andriy.shevchenko@linux.intel.com
