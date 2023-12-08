Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E41809F57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573431AbjLHJ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjLHJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:29:27 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB8171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:29:30 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231208092927euoutp028f37cb5e609e0b8faae019da534c317d~e0Tyiqm1S2397323973euoutp02c
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:29:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231208092927euoutp028f37cb5e609e0b8faae019da534c317d~e0Tyiqm1S2397323973euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702027767;
        bh=hE8sODkIeEHFqXFm5HcOUWIH6t5yKxghLDYGa8J8ECc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=WHRL/oQxdmn5U14HX1lu0o8WFux8vQ0m6bEqmpIueyXobj9sJULG9LQ2/Ly6wh82l
         2mkqylJ1GWcw3xGbvlJHFkla6zG+rHE2fKqH9ZRftg+I216G8cHe8RFkiN8oTEA9DZ
         s600DZSMY660fom8fjApnBF+WmU+TZ1wa38XZV+8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231208092927eucas1p289f6e8eaae2ae16a61a45089204cb1a2~e0TybG0Zp0116601166eucas1p2u;
        Fri,  8 Dec 2023 09:29:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.14.09552.7F1E2756; Fri,  8
        Dec 2023 09:29:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231208092927eucas1p2f6750026f74e981c67b05e9b4c9bc821~e0TyIQs722669226692eucas1p2f;
        Fri,  8 Dec 2023 09:29:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231208092927eusmtrp2eed838b6d3d48966ea8ae29a44fc8a58~e0TyHqcx12545125451eusmtrp2d;
        Fri,  8 Dec 2023 09:29:27 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-e5-6572e1f7293c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.3D.09274.6F1E2756; Fri,  8
        Dec 2023 09:29:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231208092926eusmtip2f2e07dfb887e860169d8168f68c7c165~e0Txt7aj72297822978eusmtip2A;
        Fri,  8 Dec 2023 09:29:26 +0000 (GMT)
Message-ID: <6587c196-8e25-4511-9c86-4b9cc18ee7e1@samsung.com>
Date:   Fri, 8 Dec 2023 10:29:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: rtnetlink: remove local list in
 __linkwatch_run_queue()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231205170011.56576dcc1727.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7rfHxalGizfJGbRfOojs8WjFbPY
        LT5u+MRicWFbH6vF5V1z2CyOLRBzYPNYvOclk8emVZ1sHr3N79g8+nu3sXh83iQXwBrFZZOS
        mpNZllqkb5fAlfH07Vv2gl+KFQvnPWVqYPwi3cXIySEhYCLxbcVx1i5GLg4hgRWMEqf2LGeH
        cL4wShyY/IwJwvnMKNE95Ro7TMvdU1OhWpYzSmxasp4JJCEk8JFR4sPsAhCbV8BO4u2aM2Bx
        FgEViYU3ljBCxAUlTs58wgJiiwrIS9y/NQNsqLBAjMTtRZvBbGYBcYlbT+aD9YoI5EjM7tzD
        BhHPlfjc/AhsDpuAoUTX2y6wOKdArMSBHa+hauQlmrfOZgY5TkLgCofEtd6JjBBXu0jcaX3K
        DGELS7w6vgXqGxmJ/zvnM0E0tDNKLPh9H8qZwCjR8PwWVLe1xJ1zv4BWcACt0JRYv0sfIuwo
        sWTqHWaQsIQAn8SNt4IQR/BJTNo2HSrMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspWGYheX8W
        kndmIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzDxnP53/OsOxhWvPuodYmTi
        YDzEKMHBrCTCm3M+P1WINyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFM
        lomDU6qBKfOlWuhP75kfW47uf+fbJKdy4NTs6by3DggLMp/OX/pZXeDtm/mLfLXalyXvvhPU
        Uysrmvtrs3W2X8yvHbs4u+LXs7bc+hPesEg4n8uWX527+O7FE5k5n3dOfRzjlrBjRufPU517
        jwp2LDNqvqV0V/1hHGPQBQ/zWc6tTTPMhDVXfteala9SUWXdof317x2ZhXPzXm3k6Cwt4XjQ
        ImigoyU5/ZGGwcNdnh97N03IkG78nh251c/Ibr630UqVI0nLN/2zXDdj+jwhqbdlv8Qy83YI
        75Ra5Cy4Wu1AufgViXUaWdV9T7zZZv6Zr3e7Nm3B3Egn7V3ZCzfrJUZ8+PwgQDL21yyvi2KJ
        C42e734bqMRSnJFoqMVcVJwIAOtVtLqrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7rfHxalGvyex2jRfOojs8WjFbPY
        LT5u+MRicWFbH6vF5V1z2CyOLRBzYPNYvOclk8emVZ1sHr3N79g8+nu3sXh83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/H07Vv2gl+K
        FQvnPWVqYPwi3cXIySEhYCJx99RU1i5GLg4hgaWMEtdnPWCESMhInJzWwAphC0v8udbFBlH0
        nlHi3Zz7YAleATuJt2vOMIHYLAIqEgtvLGGEiAtKnJz5hAXEFhWQl7h/awY7iC0sECNxe9Fm
        MJtZQFzi1pP5QL0cHCICORLz/uhDhHMlTi3oBhsvBFR+f0IT2Hg2AUOJrrcgN3BycArEShzY
        8ZoNot5MomtrFyOELS/RvHU28wRGoVlIrpiFZNssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhb
        XJqXrpecn7uJERhn24793LKDceWrj3qHGJk4GA8xSnAwK4nw5pzPTxXiTUmsrEotyo8vKs1J
        LT7EaAoMionMUqLJ+cBIzyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi
        4JRqYHK9wdDUFB1xp4q//wVT8Nw59f8Yr/vPTfh9hE9jJYN4aORTOUmd0+0fXy68fbDxiAu7
        1Y34vZfbos3mTyuJU7N+dKox/bXI9RWPixdX13wrLD44vy3c/s2JT1bS+ocvbfY51d99uEB+
        ppfUaT+D9y+/OXyctGZjfHyDR60x+xFJ02kfLuofO/hQf5n0ZK3QdONj7w/w/Xi3IoTxZs3W
        JPWPexwWVM+cr1AZdvdLxa6ESg3LqvetE6uXJz62v/dZfKnmnbjZD1SvRGbs9cnb1lt20WX7
        gkMHFu43q5lwxFr7VIrA1eWTLvnNnb17+oIf3+R2OcoUG1wy0XsSWtQeMP1QsbMIU9bBxqUM
        rnG5n/YrsRRnJBpqMRcVJwIAcz67kDwDAAA=
X-CMS-MailID: 20231208092927eucas1p2f6750026f74e981c67b05e9b4c9bc821
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231208092927eucas1p2f6750026f74e981c67b05e9b4c9bc821
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231208092927eucas1p2f6750026f74e981c67b05e9b4c9bc821
References: <20231205170011.56576dcc1727.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
        <CGME20231208092927eucas1p2f6750026f74e981c67b05e9b4c9bc821@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On 05.12.2023 17:00, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Due to linkwatch_forget_dev() (and perhaps others?) checking for
> list_empty(&dev->link_watch_list), we must have all manipulations
> of even the local on-stack list 'wrk' here under spinlock, since
> even that list can be reached otherwise via dev->link_watch_list.
>
> This is already the case, but makes this a bit counter-intuitive,
> often local lists are used to _not_ have to use locking for their
> local use.
>
> Remove the local list as it doesn't seem to serve any purpose.
> While at it, move a variable declaration into the loop using it.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

This patch landed in today's linux next-20231208 as commit b8dbbbc535a9 
("net: rtnetlink: remove local list in __linkwatch_run_queue()"). 
Unfortunately it breaks booting of many of my ARM 32bit based test 
boards. The issue can be also observed on QEMU's ARM 32bit 'virt' 
machine. Booting hangs on very early:

...

e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
pegasus: Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver smsc75xx
usbcore: registered new interface driver smsc95xx
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver cdc_ncm
usbcore: registered new interface driver usb-storage
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu:     1-...0: (1 ticks this GP) idle=b7cc/1/0x40000000 softirq=23/23 
fqs=1027
rcu:     (detected by 0, t=2103 jiffies, g=-1163, q=8 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:

Reverting $subject on top of current linux-next tree fixes the issue.


You can reproduce this issue with the following commands:

# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- multi_v7_defconfig zImage

# qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append 
"console=ttyAMA0 no_console_suspend earlycon root=/dev/vda" -M virt -smp 
2 -m 512 -netdev user,id=user -device virtio-net-device,netdev=user

(the netdev parameter for qemu is important to trigger the issue, the 
lack of rootfs is intentional here, as the hang happens before kernel 
searches for rootfs).


> ---
>   net/core/link_watch.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> index c469d1c4db5d..ed3e5391fa79 100644
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -192,8 +192,6 @@ static void __linkwatch_run_queue(int urgent_only)
>   #define MAX_DO_DEV_PER_LOOP	100
>   
>   	int do_dev = MAX_DO_DEV_PER_LOOP;
> -	struct net_device *dev;
> -	LIST_HEAD(wrk);
>   
>   	/* Give urgent case more budget */
>   	if (urgent_only)
> @@ -215,11 +213,11 @@ static void __linkwatch_run_queue(int urgent_only)
>   	clear_bit(LW_URGENT, &linkwatch_flags);
>   
>   	spin_lock_irq(&lweventlist_lock);
> -	list_splice_init(&lweventlist, &wrk);
> +	while (!list_empty(&lweventlist) && do_dev > 0) {
> +		struct net_device *dev;
>   
> -	while (!list_empty(&wrk) && do_dev > 0) {
> -
> -		dev = list_first_entry(&wrk, struct net_device, link_watch_list);
> +		dev = list_first_entry(&lweventlist, struct net_device,
> +				       link_watch_list);
>   		list_del_init(&dev->link_watch_list);
>   
>   		if (!netif_device_present(dev) ||
> @@ -237,9 +235,6 @@ static void __linkwatch_run_queue(int urgent_only)
>   		spin_lock_irq(&lweventlist_lock);
>   	}
>   
> -	/* Add the remaining work back to lweventlist */
> -	list_splice_init(&wrk, &lweventlist);
> -
>   	if (!list_empty(&lweventlist))
>   		linkwatch_schedule_work(0);
>   	spin_unlock_irq(&lweventlist_lock);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

