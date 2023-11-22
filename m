Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050187F3CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbjKVDwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVDwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:52:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2065.outbound.protection.outlook.com [40.92.40.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB81AC;
        Tue, 21 Nov 2023 19:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRiLjEu+cbT/1zpVjAsUY4XnKJ3idN/ipUcLkg36zTPlUb/QGjQgnUeBsQm036D65fsBtqwDO4ApTrp2LM7C42CZr3UrSLyR6qk/fTk99mJys/a8Iu9flXjFyd60sMic+OqAX5fqWzadB/2eeQq85y/GiM2bf6a6/8EkQLIEwNXffRjyHlRMrpmLe45ZThvHtJrK+NRW/ray+i1PGciBLZjsQL0U67YzH14tAL7hSmMRRf87rCItJ3maVFz4BuVYcTzCUYuYbKV4w69DVuiNsd24Gbt6CVH8QP5Y7JOOfbiFUY/06GsXnmfKKXw+VwliMhSFSElxJX/6U9qslv5+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9urgUznpssW7OU5X3sW8vceNEsFF5oSaZV8WNMo5KGI=;
 b=KEqQRqccQSprNFJqx4EXl1Q1YHqUvC787Bdm6dQ8nJ3cTeLYp8zgof7QEJ911bpQ01kEX2QBwh/QiCW6nlyxQ9Aa7OMQPPIppA8wmA5/4QeqV0sT0g7t0gT+5OtTXlBIBJLnO/i2Nm3WmSkfZ7ZRSxCJzuSeHwpugILjnC5bPmbMHHEY/UfQrzH5UIFI/WAXjuJzcFwzIbdZaCgyawC90ytsaYTwxD3TfFI3q0G3apm4dz8oxHN1NqFbJstzG0vZBGXSjkSjakQIxjhh2V5JWtuGVp2hQEplVqQhePJBS0q3XglnlnitM432zUcc8dAOpo6s84AKRgMkp2Zo3VXfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9urgUznpssW7OU5X3sW8vceNEsFF5oSaZV8WNMo5KGI=;
 b=HyuDrQeVJk0VUrSl43fGqmUsBtmlDtmzUB+jsJjJvL+bHFx4+qWf0gNThNxFyvFK7I/eFSJ76kkSxRg412z8fKmbRI1eGJce7Kysr6ATfODULU+6omRJih5rYf1gVgkcTNVoxnNgCHO8ClZH39IkKkfL7O7cmpMm15YVMFt73uA1gFxADPLLYBz4a8e4Z4AvfCtVhg7ut4HddgT3TefSrq3QH2quuXINbj4+PjVlc//X5vfBdSJgClV4Zhv9BYctpu+MRNXpEHVAz2agGVAQSfkthPV5HfmAtL0RuQP0/5brkcZ0iJeRY8jzNrGYMuwR8qevrcs4so/9sozoWAL+Nw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 03:52:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 03:52:07 +0000
From:   Michael Kelley <mhklinux@outlook.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: RE: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Thread-Topic: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Thread-Index: AQHaHOzT1swvwv/9iki7z8jdYKFBMLCFsPDw
Date:   Wed, 22 Nov 2023 03:52:07 +0000
Message-ID: <SN6PR02MB41574D8169D62EBFAE90427CD4BAA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
In-Reply-To: <20231122103103.1104589-3-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [iyL6NfASMoRTvJ+xZMop4EMqelMWEHW8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: 560530eb-62c7-4134-7664-08dbeb0e65b3
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAkd9SicmqWgV8FL/hl5TstSJFozTBMGD8VtW61wm8M5/6He6vwFUJ9dwFwBkWAoPZ1OTxm3q6JIp6pEdtJewT3aZGPKfdXiU28qW9UvTKLoiV6g9dXOv6MVvAHfk5UnqFZnVFCWo+aS2AUDZVjunlowprb9D18Ut9bYMDHmahgHvE6Nu2PphQ2DCWgbGLn/YT7UQP94sxUjUA2kbtxvicxlNM2yV4WLIu9irB4LOSyKz4vEE7tthn5upPo7411XYrGy9Xqs2JQg6e8py4z7sGGMoZkqmYVy52imH2CRkz4RJ/Pux2rT6SzsoehnG3rFX31kNAC4BscJYw3pcqj0Lty3GlSsNbako6tCKF9qj7JaNx92W56GBCTrCRMAq/cmFEU8gyZ83tS/WIYKQvTIGZyfSPtbT3CQJPr/Qg9AdspQxhlktRwvn57Qo02maA5iZdRvgwJH2w7nrZNHHcCN+vIrPS0y3rUrRRznfSedcmwdQgONmkaHlNoY5ko5m/VEe5zYgSt7TQk6DbOLXqaLdh4sLb1ro2GKFU07UXyWZ7ruC0zLU0lNKmy3l0zXb/t9
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w5UXTE+Bcl5ADh386jBHyMTnVOvEGaH2x/M77WQsH12v4DoQA9E8GanVyCBz?=
 =?us-ascii?Q?dwWafjpAeIDmQyJ8Dwe60N52/qe4uP+KUlOgKr2bMEpkJb8Zrr/orcZYuh6S?=
 =?us-ascii?Q?Qmpnk0NxFk8oj6SBPtgrdgrmX9P5aKX9j3Vnk01KhDlSNKjDIGMmFF1lpghh?=
 =?us-ascii?Q?S0BrjBzumhO86SPnBPLEAHVM3pY2CSB3b9Hfcark+Ig1pkf0PXxUrJScIghp?=
 =?us-ascii?Q?Gv1wUVLQ1TDcO98gDff+xMW86vqgf/amdz75Now1ROYH4zUrNWU+yrjisvq3?=
 =?us-ascii?Q?eKJPbk0KI1XaNXl6wtAqCiZPgMAVunI45pOf1iM0gHaeMIShAcN5ch84YdZh?=
 =?us-ascii?Q?E/6Y0T6+3WKRsmWJjphQWnO7FLUibIkEPN5H+Qakbpk6VW5egFFUcnmqeAOU?=
 =?us-ascii?Q?85pi/tq5jBtJdWKUZkOPz1eHfxhSnLO5KFhCOpiR5mNOfdRISotfVJRqbQV4?=
 =?us-ascii?Q?oZ/dF68cRsl7DxDJdkDcOq8T6SJPuTKvI5zNDALQK8IaRvrkaOD6AzSZCSPW?=
 =?us-ascii?Q?e83B81QIJ7iumAGAVwgNHXfZUi8MtMIR8zs6fx6job/eY33Fx3EE5HtIGfwD?=
 =?us-ascii?Q?pLXhhanK3OYEKzDP5VPmLeNHWtAPzQoSSNTVu3rkpoePEWmqVPjflin0nCHc?=
 =?us-ascii?Q?nYESE5gaG7x1QwJ/UfGhii8Ax4sIhpKYmDXCHV4rJcOoIeY403gbdC7w1ArW?=
 =?us-ascii?Q?xsBGCc/fCYlquCklihEJL/0AfLPoFLj9zr11SuD4wzSDKmd/2FANJHILtdF6?=
 =?us-ascii?Q?/qF6RNkXLxnMba+RnPTvTA5uqbG3TM3KBUzbw2lhz/veJOhl1LVZj2BbbYtv?=
 =?us-ascii?Q?7EvzeMRSm1mpXmboPkUU74lZ8awxI2WIZoCMat2EEF5pVYTrI0Bb8z6M73W3?=
 =?us-ascii?Q?Bd1JLjmq6syoGZ+y3ACpNUfKVjOzYFCY3hVEXd4Aekq42hDyx+GpPFy80MCN?=
 =?us-ascii?Q?kkE+92UrVIo/B7pyF2p8Tsu0/0pHHGMcmuB83QvnqSEfHMTcArYqoy0UkIga?=
 =?us-ascii?Q?AJNGZLJbM43bK0WTEQ6visWK6nZI3dowd9jCaNSKrTctdJp/09oyEaoM7eVo?=
 =?us-ascii?Q?uGKvKExOBrE9H2VCqxgqGgxnFvjUniunajjmCFi64YTOdnGpO5yFz5MTjX+Z?=
 =?us-ascii?Q?qbOMLxaNvj3k2zoK8xlvjNPRA/mzu0S4ylXd6GSvhB8GGaKKakiajqRkECiN?=
 =?us-ascii?Q?RKIYDST6CTUwYcEo1XhIMv2LtQH1VMoSUHqTqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 560530eb-62c7-4134-7664-08dbeb0e65b3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 03:52:07.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai1@huaweicloud.com> Sent: Wednesday, November 22, 2023 =
2:31 AM
>=20
> There are multiple switches in struct block_device, use separate bool
> fields for them is not gracefully. Add a new field bd_flags and replace
> swithes to a bit, there are no functional changes, and prepare to add
> a new switch in the next patch. In order to keep bd_flags in the first
> cacheline and prevent layout to be affected, define it as u16.
>=20
> Also add new helpers to set/clear/test each bit like 'bio->bi_flags'.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bdev.c              | 15 ++++++++-------
>  block/blk-core.c          |  7 ++++---
>  block/genhd.c             | 15 +++++++++++----
>  block/ioctl.c             |  6 +++++-
>  include/linux/blk_types.h | 27 +++++++++++++++++++++------
>  include/linux/blkdev.h    |  5 +++--
>  6 files changed, 52 insertions(+), 23 deletions(-)
>=20
> diff --git a/block/bdev.c b/block/bdev.c
> index e4cfb7adb645..10f524a7416c 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -402,10 +402,10 @@ struct block_device *bdev_alloc(struct gendisk
> *disk, u8 partno)
>  	bdev->bd_partno =3D partno;
>  	bdev->bd_inode =3D inode;
>  	bdev->bd_queue =3D disk->queue;
> -	if (partno)
> -		bdev->bd_has_submit_bio =3D disk->part0->bd_has_submit_bio;
> +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
> +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	else
> -		bdev->bd_has_submit_bio =3D false;
> +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	bdev->bd_stats =3D alloc_percpu(struct disk_stats);
>  	if (!bdev->bd_stats) {
>  		iput(inode);
> @@ -606,7 +606,7 @@ static void bd_end_claim(struct block_device *bdev, v=
oid *holder)
>  		bdev->bd_holder =3D NULL;
>  		bdev->bd_holder_ops =3D NULL;
>  		mutex_unlock(&bdev->bd_holder_lock);
> -		if (bdev->bd_write_holder)
> +		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
>  			unblock =3D true;
>  	}
>  	if (!whole->bd_holders)
> @@ -619,7 +619,7 @@ static void bd_end_claim(struct block_device *bdev, v=
oid *holder)
>  	 */
>  	if (unblock) {
>  		disk_unblock_events(bdev->bd_disk);
> -		bdev->bd_write_holder =3D false;
> +		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
>  	}
>  }
>=20
> @@ -805,9 +805,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev,
> blk_mode_t mode, void *holder,
>  		 * writeable reference is too fragile given the way @mode is
>  		 * used in blkdev_get/put().
>  		 */
> -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
> +		if ((mode & BLK_OPEN_WRITE) &&
> +		    !bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER) &&
>  		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
> -			bdev->bd_write_holder =3D true;
> +			bdev_set_flag(bdev, BD_FLAG_WRITE_HOLDER);
>  			unblock_events =3D false;
>  		}
>  	}
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..f9f8b12ba626 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -482,7 +482,8 @@ __setup("fail_make_request=3D",
> setup_fail_make_request);
>=20
>  bool should_fail_request(struct block_device *part, unsigned int bytes)
>  {
> -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
> +	return bdev_flagged(part, BD_FLAG_MAKE_IT_FAIL) &&
> +		should_fail(&fail_make_request, bytes);
>  }
>=20
>  static int __init fail_make_request_debugfs(void)
> @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
>  	if (unlikely(!blk_crypto_bio_prep(&bio)))
>  		return;
>=20
> -	if (!bio->bi_bdev->bd_has_submit_bio) {
> +	if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO)) {
>  		blk_mq_submit_bio(bio);
>  	} else if (likely(bio_queue_enter(bio) =3D=3D 0)) {
>  		struct gendisk *disk =3D bio->bi_bdev->bd_disk;
> @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>  	 */
>  	if (current->bio_list)
>  		bio_list_add(&current->bio_list[0], bio);
> -	else if (!bio->bi_bdev->bd_has_submit_bio)
> +	else if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO))
>  		__submit_bio_noacct_mq(bio);
>  	else
>  		__submit_bio_noacct(bio);
> diff --git a/block/genhd.c b/block/genhd.c
> index c9d06f72c587..57f96c0c8da0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device
> *parent, struct gendisk *disk,
>  	elevator_init_mq(disk->queue);
>=20
>  	/* Mark bdev as having a submit_bio, if needed */
> -	disk->part0->bd_has_submit_bio =3D disk->fops->submit_bio !=3D NULL;
> +	if (disk->fops->submit_bio)
> +		bdev_set_flag(disk->part0, BD_FLAG_HAS_SUBMIT_BIO);
>=20
>  	/*
>  	 * If the driver provides an explicit major number it also must provide
> @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NUL=
L);
>  ssize_t part_fail_show(struct device *dev,
>  		       struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
> +	return sprintf(buf, "%d\n",
> +		       bdev_flagged(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL));
>  }
>=20
>  ssize_t part_fail_store(struct device *dev,
> @@ -1071,8 +1073,13 @@ ssize_t part_fail_store(struct device *dev,
>  {
>  	int i;
>=20
> -	if (count > 0 && sscanf(buf, "%d", &i) > 0)
> -		dev_to_bdev(dev)->bd_make_it_fail =3D i;
> +	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
> +		if (!i)
> +			bdev_clear_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
> +		else
> +			bdev_set_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
> +
> +	}
>=20
>  	return count;
>  }
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4160f4e6bd5b..a64440f4c96b 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, u=
nsigned cmd,
>  		if (ret)
>  			return ret;
>  	}
> -	bdev->bd_read_only =3D n;
> +
> +	if (!n)
> +		bdev_clear_flag(bdev, BD_FLAG_READ_ONLY);
> +	else
> +		bdev_set_flag(bdev, BD_FLAG_READ_ONLY);
>  	return 0;
>  }
>=20
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index f7d40692dd94..de652045111b 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -37,6 +37,11 @@ struct bio_crypt_ctx;
>  #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
>  #define SECTOR_MASK		(PAGE_SECTORS - 1)
>=20
> +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
> +#define BD_FLAG_WRITE_HOLDER	1
> +#define BD_FLAG_HAS_SUBMIT_BIO	2
> +#define BD_FLAG_MAKE_IT_FAIL	3
> +
>  struct block_device {
>  	sector_t		bd_start_sect;
>  	sector_t		bd_nr_sectors;
> @@ -44,10 +49,8 @@ struct block_device {
>  	struct request_queue *	bd_queue;
>  	struct disk_stats __percpu *bd_stats;
>  	unsigned long		bd_stamp;
> -	bool			bd_read_only;	/* read-only policy */
> +	unsigned short		bd_flags;
>  	u8			bd_partno;
> -	bool			bd_write_holder;
> -	bool			bd_has_submit_bio;
>  	dev_t			bd_dev;
>  	struct inode		*bd_inode;	/* will die */
>=20
> @@ -67,9 +70,6 @@ struct block_device {
>  	struct super_block	*bd_fsfreeze_sb;
>=20
>  	struct partition_meta_info *bd_meta_info;
> -#ifdef CONFIG_FAIL_MAKE_REQUEST
> -	bool			bd_make_it_fail;
> -#endif
>  	/*
>  	 * keep this out-of-line as it's both big and not needed in the fast
>  	 * path
> @@ -86,6 +86,21 @@ struct block_device {
>  #define bdev_kobj(_bdev) \
>  	(&((_bdev)->bd_device.kobj))
>=20
> +static inline bool bdev_flagged(struct block_device *bdev, unsigned int =
bit)
> +{
> +	return bdev->bd_flags & (1U << bit);
> +}
> +
> +static inline void bdev_set_flag(struct block_device *bdev, unsigned int=
 bit)
> +{
> +	bdev->bd_flags |=3D (1U << bit);
> +}
> +
> +static inline void bdev_clear_flag(struct block_device *bdev, unsigned i=
nt bit)
> +{
> +	bdev->bd_flags &=3D ~(1U << bit);
> +}

It seems like there's atomicity problem with this approach.  In the above
code, setting and clearing a bd_flag is *not* atomic with respect to
setting/clearing some other bd_flag.  For example, setting/clearing
BD_FLAG_MAKE_IT_FAIL via the /sys interface could race with
setting/clearing BD_FLAG_READ_ONLY via an ioctl, and one of the
two changes could be lost.  This problem wouldn't happen when
each flag was a separate field.  Admittedly, the likelihood of a
problem with BD_FLAG_MAKE_IT_FAIL is extremely low, but
conceptually the lack of atomicity is still wrong.  There might
be a similar problem with BD_FLAG_WRITE_HOLDER, but I
didn't investigate thoroughly.

Michael

> +
>  /*
>   * Block error status values.  See block/blk-core:blk_errors for the det=
ails.
>   * Alpha cannot write a byte atomically, so we need to use 32-bit value.
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 51fa7ffdee83..fc1d55ef5107 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -741,13 +741,14 @@ void disk_uevent(struct gendisk *disk, enum
> kobject_action action);
>=20
>  static inline int get_disk_ro(struct gendisk *disk)
>  {
> -	return disk->part0->bd_read_only ||
> +	return bdev_flagged(disk->part0, BD_FLAG_READ_ONLY) ||
>  		test_bit(GD_READ_ONLY, &disk->state);
>  }
>=20
>  static inline int bdev_read_only(struct block_device *bdev)
>  {
> -	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
> +	return bdev_flagged(bdev, BD_FLAG_READ_ONLY) ||
> +		get_disk_ro(bdev->bd_disk);
>  }
>=20
>  bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
> --
> 2.39.2

