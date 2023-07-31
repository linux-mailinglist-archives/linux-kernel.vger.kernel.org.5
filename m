Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B68769B00
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjGaPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjGaPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:43:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3661704;
        Mon, 31 Jul 2023 08:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAs+hCTtbSIxKoa7c4gZHZ6guHs/JWGQ1r3Kf7EgqV7B3ye+xQvxnzcrdnZU4oXczaV9FDi1cl9NU1j3di20rr9i/O4dWUhuY9FZ+a1eDFrM8fpUVvwskIIwoNTBf/2Wc8vHH+TqXrPpG/YLDzZaqpuA78TGojdfj9QXaxeN9Mx2+HsMAKDIOIclRy3xkH2g4+rHLEZrUE4V1y5GbvEcsK1yEhoUJFFjssmRhTCqODKAWVcS9TLb24EqLNZ9/uXM/VscrIKihsviG9Q9FQ4yS7mLh/17msdCXKGc19TLeGjtjfaRkZ//XGwi5izN4aRM9J3NC3rW74qYPG9kiUcR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU9jCXus2QtTEyRE8aTa8FWf40eH7wPnxZPdlnW2ewU=;
 b=YZNT7uWhtHwjWOhfVmAnID5/W+sRe0XnTHe0Q3wDSfwelTaxCMxPcaC05LOxCDZ1Ft5B4kuC9NGONZ0RFsYZl8u9u4BhwHyjzYnenugrwbv0n5lU+6iKp8bfd6ClSF1cboIMleuKOaO4CohIaVqKumNe57RuKBh4EeFUZDL/08fXcenOmudAfZewRvwPG5QcE7mXN4wv5LC45uSRb/G9cfsV46Wb5m3ZW/YZMKBt2g5FhYSKjjcut1JVer1axqsjpt0ru9tmHbcrQl+29bmcrS7D74Q7oTyob9xdlcMtMPcm6Woxlxts6WG3jzSUZiFmHTgUObkjAjYgWBsL9+0e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU9jCXus2QtTEyRE8aTa8FWf40eH7wPnxZPdlnW2ewU=;
 b=Jl2okJ+L8WqDSOmAjwya/a4ZKJUAywCwVwuUQfbRDqsWxSLk1qcSXIxBOdZsLmWIy1opMHAPSQs4ne2tVmfbZwek+91p9Fh1x2rKjPntD9uN2CfwILayH1u6NbVJj3GeKTMxEs0NIp/3Mzxp7u7dm7z6PIr91UicSnvQDfLEbq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB6843.namprd08.prod.outlook.com
 (2603:10b6:610:c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:43:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::3330:a9d7:a566:68b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::3330:a9d7:a566:68b2%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 15:43:26 +0000
Date:   Mon, 31 Jul 2023 10:43:23 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 15/22] Input: iqs5xx - use device core to create
 driver-specific device attributes
Message-ID: <ZMfWm6H8IKiyTh0R@nixie71>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-15-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729005133.1095051-15-dmitry.torokhov@gmail.com>
X-ClientProxiedBy: SA9PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:806:23::28) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH0PR08MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ed5e75-c6aa-4e24-ed6a-08db91dce11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F66jYRsx1WeGL8CEgPf9Nfh/wCvXyzgD9zocF1XmGSmtr2/8zcqHatjmfZa/PqFZatSyXb1XlOEv6Ncajl85Y0GBGZhEmkxwijUUqNVXbYt9+SNyCiiB32OAgJyr20NtniH+2RCTdt6f/J7UWWELDBrz4EBowYJ3/f0surQi0QPBvbZ4lQIZlU9lSe2bEdxpXQO2KiE6ZXlafycqBNPSUT70o/n02IeUE7cr8g8xu9MOXuhh+D+ASYMm5HfY8c5uwb+uR6hjCwMGX7RtpVFCiIYpOlKPF8TwaAKBcQ+Xa+2e3i/dpChTkaTytf7AYws7qpuGqJ1sR2ewY95oCkWO2lygygH+kyLHex5oEzFa7scQggrqb/DqLNfy4rOx/z+0C5DTFAHGPdiLyOP5HB2q244NSlgDntQ1OXN1iZ65EExj1HBHCjI+7YVD/Nd9KzLzu0G/USP9VfbAo/ulNZD3guIDcKJQ7SA4o3qUEujSWuzi+Kjyi0DIjQyNfIjdcmdFj04nqKHgM+6AkzgjwxnwYUUpc8J5ekSRJnpzThU9fsp1gEhsOEl3oJfPD+Lwb9/DqFQVqs7qBlR2aNZYcA36QA38mZRqlHopAVy4EtJGSsJ1FIRlYZtpxzJcYgL3Z3IlrhIoOzP3Ggl4aBkAX601VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199021)(66476007)(86362001)(8676002)(8936002)(316002)(4326008)(5660300002)(6916009)(33716001)(41300700001)(66556008)(66946007)(38100700002)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(6506007)(26005)(83380400001)(186003)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxZeVdr1PBqhVPrTX6mxID4bDr6jUvBz/fxGd8qMYCNr235iBeLzQABtfhcL?=
 =?us-ascii?Q?fJ3U4PNBhl3jSjnUXideQ66LZ1nyy2Qg7pMlCINfnEcM+ge5Zkwun7S88SWL?=
 =?us-ascii?Q?rjXoUJhmVLQXdferXKN7YAyepCnIe3ITH2QV6hujTbwtOgj4yhb7chaapw6V?=
 =?us-ascii?Q?sSmYT9qJjKe2TBsPUy2gpla6MFxfvZ2Rr8hjVbxhXXpPsqd0QUC+tptyRFMs?=
 =?us-ascii?Q?Q1G8AiXs2O0IH3C6hsoOFVsubKNAipcZ3QLOcL9wjYV7qRhBPuEhwdwXWkXW?=
 =?us-ascii?Q?mVB4nbQOC2sdbqtAXS8nn/dg+nCSXWSFsyzffGJr+CWmYQHP2lvnhc6t+rT+?=
 =?us-ascii?Q?xiyMVmi9aQbVAI00yWRXk3OeA/2JfEl8lBjGYCULeJ/gn56TWjKktWvS2VqZ?=
 =?us-ascii?Q?aa94L45xZ7H4NXkNpMysSL/lh27i6FADh1NVIZw3UeoNsaWf/QHcQwIraHus?=
 =?us-ascii?Q?c44Csc9y15Il/+SvSTDfgYOT/OeeUonHRXFBMKNHAqv9EWr46nCjNqOcMDb7?=
 =?us-ascii?Q?sWIAYN9uh/8P9EHEpRvxpv0h8akipsxyAoHlBEtymwRa76oUlQxixNv2Qzec?=
 =?us-ascii?Q?nYodhn7dbIA3gTBhQf6K930L2h1zH8xIJQdLhsAznQTXgd6QC/L2yKoe6JKt?=
 =?us-ascii?Q?+6kLi4P8pnv1MB8qBj+BYMIDVM6m0rxJEcqnyZbvdV3QWtrRKuqcPDw6DD2r?=
 =?us-ascii?Q?LSQrFRUjfWlzDaB5xOocF7dVnzn6m6Esy8/LrUoFjXP5aChh15SFRrvQDdPA?=
 =?us-ascii?Q?FyI1o8dj33Qh7DgfJSqYOlgLhSfkulLmmsM2oXfKy75miFHVdg2Miwj+MZm6?=
 =?us-ascii?Q?ajIeZEEbonIFuQdu0PAG8dxBtuvrJ2u92vswhuZW2QRo96/UFuw/Y9tjOUG2?=
 =?us-ascii?Q?Yas5cDtXPbzTzmh9czVMYyaiRoZlXPpQ6C6CjXGv+7mzIlbOO8oAa0aY3QvB?=
 =?us-ascii?Q?BAkBeKgFfPTFsDMT+t/Xh1U8NyMl2DsD4vUGvXfTrV4F48rGQ1lyy51FIdvC?=
 =?us-ascii?Q?u2YUkSX2rFmJXXgD+Xp3YUgxX07/7Bgh+8TOUe5JQ5hTPnn/KgnjOKKacCxZ?=
 =?us-ascii?Q?A3fosm9GWGV00W5VamSi3IHN6ew9egp+XeM7TkG1yD1ldA6d4uSmqCT4I1UX?=
 =?us-ascii?Q?hse/1Ns2y75YWW73z1mhamM1ountDaLcyyLG3x3jEWtDZooUJbZvSfz/fd+t?=
 =?us-ascii?Q?aXer/9O1NRcZUBpo2qouzdi6766DI/LCWUc/H080fDj2W2qZRcr0o+ThMOfo?=
 =?us-ascii?Q?85cvTE/0e+S8/5RpJA+QkD47+gObfTaq83vkzxDEYjTwTsT5W7sjG4OCoRXC?=
 =?us-ascii?Q?Nj5AiEBBmdwVaMtGFuUMDP2VOxJMOT60Ns0fZS3JXKRCFpQTvBnaAHmbyb78?=
 =?us-ascii?Q?5uq6H/+z5R6Dk1dE0QlOSKrkEMzctUQub27+rajDjMP86l7aVE3PnEUOxTG3?=
 =?us-ascii?Q?J3JgqBXFxUnEW/KbRqOtb3Isi2CvGN4OoyjmV3EdsEwbQOq3AfkjdlLYBbaC?=
 =?us-ascii?Q?Uv2oXoFALUZPKzHrii+kOpBEe7DDvWbkwEOTh4IPXOYoyw9V/yI58guZIKn5?=
 =?us-ascii?Q?8ZTbwLit0V364aQA7OZtkL3YdXvhnx0NeA+iBBG7?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ed5e75-c6aa-4e24-ed6a-08db91dce11d
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:43:26.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VU2md2LJgfvbr6AEjtu18iaPH+tIBg26eDgE2wCNTpj1Jrg3J0iTknQRQ3pX9bULBo+YjFIkUFeKt6Bt9hALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB6843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:51:24PM -0700, Dmitry Torokhov wrote:
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  drivers/input/touchscreen/iqs5xx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
> index b4768b66eb10..a3f4fb85bee5 100644
> --- a/drivers/input/touchscreen/iqs5xx.c
> +++ b/drivers/input/touchscreen/iqs5xx.c
> @@ -974,10 +974,11 @@ static umode_t iqs5xx_attr_is_visible(struct kobject *kobj,
>  	return attr->mode;
>  }
>  
> -static const struct attribute_group iqs5xx_attr_group = {
> +static const struct attribute_group iqs5xx_group = {
>  	.is_visible = iqs5xx_attr_is_visible,
>  	.attrs = iqs5xx_attrs,
>  };
> +__ATTRIBUTE_GROUPS(iqs5xx);
>  
>  static int iqs5xx_suspend(struct device *dev)
>  {
> @@ -1053,12 +1054,6 @@ static int iqs5xx_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	error = devm_device_add_group(&client->dev, &iqs5xx_attr_group);
> -	if (error) {
> -		dev_err(&client->dev, "Failed to add attributes: %d\n", error);
> -		return error;
> -	}
> -
>  	if (iqs5xx->input) {
>  		error = input_register_device(iqs5xx->input);
>  		if (error)
> @@ -1089,6 +1084,7 @@ MODULE_DEVICE_TABLE(of, iqs5xx_of_match);
>  static struct i2c_driver iqs5xx_i2c_driver = {
>  	.driver = {
>  		.name		= "iqs5xx",
> +		.dev_groups	= iqs5xx_groups,
>  		.of_match_table	= iqs5xx_of_match,
>  		.pm		= pm_sleep_ptr(&iqs5xx_pm),
>  	},
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
