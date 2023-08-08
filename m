Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E4A77454B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHHSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjHHSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:39:51 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AFD5BD71
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=uB5US40Q21RX8MYKg05X+4c/ml2vvAJnUQlqT0skdcg=; b=GOmtHZVrIsyUc2pnqSmmT8t0Ya
        gnNjlu96fm2D3Nv9ZH8s/9ZAHOjPhGs7h798y+wcjFwYJN8aa3xg7aTf3mn+d0e6RGzPFCRRZGWFL
        WBKXLywz9l/ks/rP+zgcOhmesyNhjy3nJuFDStUvucU8rQmoxOR+FIre0OVTC0SYxJKY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:49596 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTQ7J-0000iN-Ns; Tue, 08 Aug 2023 13:03:34 -0400
Date:   Tue, 8 Aug 2023 13:03:33 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <agk@redhat.com>, <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <heinzm@redhat.com>, <linux-kernel@vger.kernel.org>
Message-Id: <20230808130333.2207c675d008fa6c808a472f@hugovil.com>
In-Reply-To: <20230808150301.45196-1-yuehaibing@huawei.com>
References: <20230808150301.45196-1-yuehaibing@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH -next] dm: Remove unused declaration dm_get_rq_mapinfo()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 23:03:01 +0800
Yue Haibing <yuehaibing@huawei.com> wrote:

Hi,

> Commit ae6ad75e5c3c ("dm: remove unused dm_get_rq_mapinfo()")
> removed the implementation but leave declaration.

Maybe change to "removed the implementation but not the declaration."

Hugo Villeneuve.


> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/device-mapper.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 69d0435c7ebb..5bc69c6a64e0 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -502,7 +502,6 @@ int dm_post_suspending(struct dm_target *ti);
>  int dm_noflush_suspending(struct dm_target *ti);
>  void dm_accept_partial_bio(struct bio *bio, unsigned int n_sectors);
>  void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone);
> -union map_info *dm_get_rq_mapinfo(struct request *rq);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  struct dm_report_zones_args {
> -- 
> 2.34.1
> 
