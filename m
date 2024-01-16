Return-Path: <linux-kernel+bounces-27007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B782E90D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF841F22C58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB211738;
	Tue, 16 Jan 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FK4+J5bv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564431171F;
	Tue, 16 Jan 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7Zfv63GCmVbErW/qQElRdOW3CfC4bGUjY45+fk0PBEvDiGeSKzXbXLTUwMBmRK4ylL3wnNu/FpIksJC2z1hVa3mWANSVxqz/7QHzyaxHsZWTat2dV88lKN0/roJhH8G4uPbBE7J1Wo9lgO6hjDxBrLTJUcl8/oZW9yEJFu6RCk3JyrDisoz41/wrb5LXpwwbM93D+zpmJaDm+13KClqKxBhVkB42SFO+BWV7hFFZ2weOHVm3NHST2rCzAXBcR9cQgE60FsztB013eHW90auzatmiKe7qfmgJ+7ztQpFZuKspmgoqgngKeo/VQx0Wyxdo06FSKkId5ADVDGS+uX6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdrwUXyC7zxcyY5yfWK/Gv+JjRxsHPI1Nb+LjU1i0oY=;
 b=WeMzctJqq4am/F63OqS/Vm2bgObZuAFJot1hfDYorOyLITvst+fCzVgUSdft05Y0z+9Zf7jZPCfGmtT+QnVpIqSOvuV1j1HqiIbq4Ye6Sj7qX4pMLkyMjgWv4NDeTNFvuVJcQ7hdL7yBzYPojhGZJ9qoTtohinSYfnd0r7mLI+Je6QuU3FPMaZ9DfFNuRms6fsaQ8kjIB8LwlkqJ83qR0NkbV5xrjnVidfETBaccYmwI/sjUeAsM+rIuJcfLEG7RZsLO9ZG/HaVuBnzEfb83+xtWcL2eVeA8R5ljfhdvPSwxB6ebh7bc9wUY/k4tJkuYwdCoGfNJQ+2uABiuRkyTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdrwUXyC7zxcyY5yfWK/Gv+JjRxsHPI1Nb+LjU1i0oY=;
 b=FK4+J5bvvH77haybrXI4Viv+i8X3PM/v0w+8/9R05HwgJeZhsm7bds1I6ZI8IShPhK32b0BFo0u+lyR2hRFL6+ULfdk30D62Uc6Q7WMOHqqiWh/DfX51t28Qh8dFFEDPYUw54iIPXRnO7rW2ob6tXUwBz8KDDq4PRC3cskgO1GFPjMK1FW6V9S2xa0ulWELNeowE+iJY3AkfWsHsZatyLB6FBtUPbVBCLpvuYNafLYgk/HLt7tFkkh+4l2glZQ0y8TsP9DyUVjFNqedIaWTKX6iLA9CA/wsnZWa8XLnKZzbRTi1rTtn5wc9he7Cx83jmvQh5G+h7ohDx3z7mHPao9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 05:06:04 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 05:06:03 +0000
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-13-lizhijian@fujitsu.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Date: Mon, 15 Jan 2024 21:01:22 -0800
In-reply-to: <20240116045151.3940401-13-lizhijian@fujitsu.com>
Message-ID: <875xztzx3e.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad8df28-3c41-4b45-7543-08dc1650d6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P2Z08bw6oQKDV1w9Y+aDW+7GqeaDZeMjA/UgvEX+LfdpwV0WIAZCld+UeVLgGe7ZwDlSRXgKgaKrSX+19ub95LALntQ6GzX32rEtoDehofEqWDurVN14tsSiVTjx+dBNWAd6a2YsqV+sYpBSmyN4Klv1bc78/Ma9L3r8uj56Zcp7KH3nb5MUAO599bD27BJ4e8dZ6wvLaJ8WKXxDxkjS0WzOo6Tl9KRb359a80y89GdaoL5vJtMXgqNvB2F9zoTD3yg2t7Leo9V8CT67ZxovwTmabOEHbY3A+wbe8jBG+kDdXl5xkscLIJrxLDR4JpOzTB/d3kwomH6DqxQq9OtPtb++N7v0o/vPnLMnhEISVpUGsqJYE44R5g+nE8Qkoszt/4X4/7gSX/+WF2MqonnG/ujGI7hXb8t6C29PjJcyjKK0rnLYvWpo4ncWJSqDyK2LnYUvJYrhJSfNVR8fTdFqwgBsG4GR8Tf3ei3oyICojARdy6sRBKzZEnPMSiZub5GyxWCV2Lg6ALigqQs1PApZK9GcLod+u3cNRtxN2dX1ULrc/PPbuMJCaugZQI3WiG86YGSTzpTNcVdMd6QeJpPx/rHynCi7rToi37nVaFgjVK2f4suKZAcqX4gLhAmMKhqk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(6486002)(6512007)(6666004)(6506007)(26005)(36756003)(2616005)(83380400001)(38100700002)(86362001)(41300700001)(478600001)(8676002)(4326008)(8936002)(5660300002)(66946007)(66476007)(66556008)(6916009)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgZl8tONTROflBM3Z0q59QPtdi0Clqn1mOuSzS8/WP6vKboxfU/UR8oCZyXS?=
 =?us-ascii?Q?J5AwBGIt0g2KxT5XRRdyf9QUFrC/ekRru9Cda9DNalprdGSGw0jYUmhQJd1q?=
 =?us-ascii?Q?IH8AdG/LY3VvC2Leal8QSks3esfNKkEi5OWm2VfshXRmpgkI6709DVJOdy8y?=
 =?us-ascii?Q?eO+Lf+994p/rIEMyH3iMvT7X6g+5vIlFICQT6KTbHfgig+Hux5ae146Lfos6?=
 =?us-ascii?Q?AcvZQDs8rrCHMDlYfAYbyc42Q/Uytia/atEUGMoraOB8lYA/nKFd7IsLv8hK?=
 =?us-ascii?Q?bMsjKAumnCv/kkOt97buy4sdgzCdKMOgr2I/5nlNOgpfnhQ2Bo3zCvriMli5?=
 =?us-ascii?Q?mjO2m50xrGnM9FoLbeuVkDZe8MkukmAtwj36U/EuGT4X/wljjb9QASuLNC1D?=
 =?us-ascii?Q?F2kjR1dWUeFmCBSTBEG8k0ziBN4lNzVnfvC/CCIMGjf5I2ipN+ukMivvRkK8?=
 =?us-ascii?Q?ddVplQFgAMgIgkCSS1tEgXFmr7zPPL2MBkF7K0SUps1Erg03Qe8enFI8eUfG?=
 =?us-ascii?Q?Ti9hlamGpK/+djaUapQL1pGgqa9QHHoYUbiP3ZMQH1aNfuI7n2bKG09FCUl8?=
 =?us-ascii?Q?a9addTGFCFQwB3imCZcXyVr/+LQcmZ+G7zOyzLuK+MvAR7sMWbnzOpVL7WPG?=
 =?us-ascii?Q?FSVtE43taLg6HaEV7wMHxDJV0yEAR/Y/agQqa7w4Pyi3kRNuUZDIjje66Ihp?=
 =?us-ascii?Q?uXqC3GghC/hh+Szx3soNLSLDed/S8M02VgO9uXGI29dbuphq0zyS4FWEy3ZO?=
 =?us-ascii?Q?Im0Jn7070Z+3fHRMhI51NVbb6IEqIRRUeluM8EqdrsK1/MqM6l77tccXkTOG?=
 =?us-ascii?Q?LpG3K7ZSpdTkyIufutmsAZFbne+E2k/gzCYt+5urZAC/lkPS7UmSbYY+bxfQ?=
 =?us-ascii?Q?rdZSxUN6pF6s037TFDdPuNINwB8nYdPnLkQIBC9jA7FCyOIMIzxYjkc/GeIT?=
 =?us-ascii?Q?ewHsk78orxwE+HgmGcefmSmW/vlyYMOpt/pZbxkTezWfnt0iP9pFw/PFU7YA?=
 =?us-ascii?Q?9lPrEKgf/1XzGfIqA96TIPrEvOvcW3THAHxz+s1qhwKOA1asBzOMaczy31qD?=
 =?us-ascii?Q?Dz3+01w+IyP1VCGUOribsllMnI3GkZbUkzw8VJRIcSdi35c5Mn+c5BS3gZ7S?=
 =?us-ascii?Q?wNesaG/qyxh5gpGgKgf61kzbHfTp9nE6vaNCSQYDOCaIuRjHevDBQhnqB2TQ?=
 =?us-ascii?Q?/Fh9QYzdxysQ8L+mSW74zpIuSdXgtIydb/if04748vaP8kMXKcvbRS4TU0w2?=
 =?us-ascii?Q?zYN8Fnkj2FV5nP490nkv6+cRrp6Gw+l4PowcYqXSIgIhKK22NmAMlbk+5PB5?=
 =?us-ascii?Q?iPJXXjFT0Pj2rfGUk9V13NruxbZd7JvJxl3cjv9Qz3RIp7EtStO9lAG4ax55?=
 =?us-ascii?Q?+5ACGNO6hDm44aVqw977WBuEyfGXfAbHzUhafI86+tW2haSuV3BsE5+1PfSx?=
 =?us-ascii?Q?1qyzRjxpK93sT6XyPbBhpoDC+eHAuWJSLAoXeQ7DtDv9bjxE7dz7AhahqhA7?=
 =?us-ascii?Q?UJzBMIqlngPZwdcF8tVSL33HZScqo11/JSh+BqXCfzsgp9ZQ3qNrbL28qDjU?=
 =?us-ascii?Q?p6NIK95eUvH5FrTPhzXE9LatuCHszL1f9FfyUoX+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad8df28-3c41-4b45-7543-08dc1650d6b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 05:06:03.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en1aVbH3vYRD8B+EADjw4USpNOTIkPs7s0xcll7odAguL2hOpqfzdAP8gecPUk1pLNfSmNBn3qIY/Uqj2rfVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215

On Tue, 16 Jan, 2024 12:51:24 +0800 Li Zhijian <lizhijian@fujitsu.com> wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
>
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>
>> ./drivers/ptp/ptp_sysfs.c:27:8-16: WARNING: please use sysfs_emit
>
> No functional change intended
>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: netdev@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/ptp/ptp_sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index f7a499a1bd39..49737ed6ef5f 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -24,8 +24,7 @@ static ssize_t max_phase_adjustment_show(struct device *dev,
>  {
>  	struct ptp_clock *ptp = dev_get_drvdata(dev);
>  
> -	return snprintf(page, PAGE_SIZE - 1, "%d\n",
> -			ptp->info->getmaxphase(ptp->info));
> +	return sysfs_emit(page, "%d\n", ptp->info->getmaxphase(ptp->info));
>  }
>  static DEVICE_ATTR_RO(max_phase_adjustment);

I authored the lines that are being changed here, so figured I should
provide my review. Doesn't PTP_SHOW_INT in the same file also use
snprintf in the same manner and should be changed to sysfs_emit?

--
Thanks,

Rahul Rameshbabu

