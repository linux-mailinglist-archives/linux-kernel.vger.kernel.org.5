Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90F7B713D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjJCSqL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjJCSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:46:09 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77730A7;
        Tue,  3 Oct 2023 11:46:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2158E6340E0E;
        Tue,  3 Oct 2023 20:46:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YXf_5sB6IDQO; Tue,  3 Oct 2023 20:46:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4184D6340DF3;
        Tue,  3 Oct 2023 20:46:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zQ-FJz0PTVGL; Tue,  3 Oct 2023 20:46:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 025336340DE8;
        Tue,  3 Oct 2023 20:46:02 +0200 (CEST)
Date:   Tue, 3 Oct 2023 20:46:02 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1135175877.31585.1696358762881.JavaMail.zimbra@nod.at>
In-Reply-To: <1bb74a9feeeb64dcd94024fbfa3a8259fcdac53d.1691717480.git.daniel@makrotopia.org>
References: <cover.1691717480.git.daniel@makrotopia.org> <1bb74a9feeeb64dcd94024fbfa3a8259fcdac53d.1691717480.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 4/8] mtd: ubi: block: use notifier to create ubiblock
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: use notifier to create ubiblock
Thread-Index: pcyMIJkQgdcxJxlQRVjxanFXVjGyiQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> An: "Randy Dunlap" <rdunlap@infradead.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>,
> "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
> <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>, "Daniel Golle" <daniel@makrotopia.org>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "devicetree" <devicetree@vger.kernel.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Freitag, 11. August 2023 03:37:31
> Betreff: [PATCH v4 4/8] mtd: ubi: block: use notifier to create ubiblock

> Use UBI_VOLUME_ADDED notification to create ubiblock device specified
> on kernel cmdline or module parameter.
> This makes thing more simple and has the advantage that ubiblock devices

*things

> on volumes which are not present at the time the ubi module is probed
> will still be created.
> 
> Suggested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> drivers/mtd/ubi/block.c | 152 ++++++++++++++++++++++------------------
> 1 file changed, 84 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 69fa6fecb8494..e0618bbde3613 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -33,6 +33,7 @@
> #include <linux/kernel.h>
> #include <linux/list.h>
> #include <linux/mutex.h>
> +#include <linux/namei.h>
> #include <linux/slab.h>
> #include <linux/mtd/ubi.h>
> #include <linux/blkdev.h>
> @@ -65,10 +66,10 @@ struct ubiblock_pdu {
> };
> 
> /* Numbers of elements set in the @ubiblock_param array */
> -static int ubiblock_devs __initdata;
> +static int ubiblock_devs;
> 
> /* MTD devices specification parameters */
> -static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES] __initdata;
> +static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES];
> 
> struct ubiblock {
> 	struct ubi_volume_desc *desc;
> @@ -532,6 +533,85 @@ static int ubiblock_resize(struct ubi_volume_info *vi)
> 	return 0;
> }
> 
> +static bool
> +match_volume_desc(struct ubi_volume_info *vi, const char *name, int ubi_num,
> int vol_id)
> +{
> +	int err, len;
> +	struct path path;
> +	struct kstat stat;
> +
> +	if (ubi_num == -1) {
> +		/* No ubi num, name must be a vol device path */
> +		err = kern_path(name, LOOKUP_FOLLOW, &path);
> +		if (err)
> +			return false;
> +
> +		err = vfs_getattr(&path, &stat, STATX_TYPE, AT_STATX_SYNC_AS_STAT);
> +		path_put(&path);
> +		if (err)
> +			return false;
> +
> +		if (!S_ISCHR(stat.mode))
> +			return false;
> +
> +		if (vi->ubi_num != ubi_major2num(MAJOR(stat.rdev)))
> +			return false;
> +
> +		if (vi->vol_id != MINOR(stat.rdev) - 1)
> +			return false;
> +

This is more or less an open coded ubi_open_volume_path().
Please either split or adopt ubi_open_volume_path() to fit your use case.

> +		return true;
> +	}
> +
> +	if (vol_id == -1) {
> +		if (vi->ubi_num != ubi_num)
> +			return false;
> +
> +		len = strnlen(name, UBI_VOL_NAME_MAX + 1);
> +		if (len < 1 || vi->name_len != len)
> +			return false;
> +
> +		if (strcmp(name, vi->name))
> +			return false;
> +
> +		return true;
> +	}

Same for ubi_open_volume_nm().

Thanks,
//richard
