Return-Path: <linux-kernel+bounces-3075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786F8166FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89041F216D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770979C1;
	Mon, 18 Dec 2023 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P2SHE51b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F406FDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3T54tNWb1AlOHSZ9RdJuA1GxqimHkO1dx05JO1xCFE4B/DkkidcXzG254m1lOzyv0gaBvet49+/mYudgzSffmKONlHknRnxBVp4RfF1FI1W3YZ4K53fp4uWbEfBua6fXRGHC4/qAozAtV7IagJGp3LV8dVGqZ7gb4a7pDmvdCburT48dJAKC2ZFf4GgdOVxe21cNwIoPcpdJtFuyuF9sD24PXyd6qjh31szcJ4Na4dopY3pHASczX+qzq9iSO1lIQ7kZWfEY1/a+cY9dOh74jmepfvoTYZburJClUNGQ50BvRD0ivU0X476WOiUktMm1AgmGNuOjHJwO5Kf5vRefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtN+xQtPvJ0t9TIMcKJ411dkFMn6R0IChCuB62y+rG4=;
 b=fwOnZfXaBAMu0fucwd0StoNWvOZQx3AhtYK0/7RclIBk2npp+z88gOR83/35UgLhozRiHOhIHSNVir+sMXiCTzT7j2TGWKWCjnxVJmNOqb4XOP545zcEj92spYaPYep4Bp/VlCiwfmk6eLIVGzyd0uszhnsqI/0PU82DV5yxqdE9SYdiUlcdLeM9HN6ZDlJP+2IuMdJ6Mf8oL91joCX+r3cIqRo/ySTguuVcXqCPlapXctKCnytZVWdl9/xq74rdLrhl0iugbTMRsm4BQXn/kmilm3p64QJP/jvwM2jbJQGKvCWKr01WvRQfRccPrF5n+BWHOdHI1AWp7Q5Iva7RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtN+xQtPvJ0t9TIMcKJ411dkFMn6R0IChCuB62y+rG4=;
 b=P2SHE51bAg0dAL18JodsNJHaTBWUklj0ekpXEI+9TsKpZAe1l3jMnfnDFDzpf/KKgWGvEddATp+ZraL51gVQlq4MJB3QRjAdNBqc/UjYADAAkfLxGpuNLaoOyzF6U0O4FtPyuKdaEj7RP3Q5Muob5PAF7f0zS3rcbiRsyor6XVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 07:04:11 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 07:04:11 +0000
Message-ID: <7f8e8ddd-f7b6-4c62-b8ff-9549b2edff46@amd.com>
Date: Mon, 18 Dec 2023 08:04:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: zynqmp-ipi: fix an Excess struct member
 kernel-doc warning
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 linux-arm-kernel@lists.infradead.org
References: <20231216004156.26967-1-rdunlap@infradead.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231216004156.26967-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e19926-de1a-4453-88a4-08dbff978955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xng6IB6KRSu0H7mOr8bSubTsrxf6+z4gsgKmeqz2+cEDUQi55CZd1/sUs/Da7FHtZ5A31Ta98HFg1FsWvNJNFqfeTxRgTAv4YJ+jWinj6SbFnhLeCw2yRSfvwCim1GOqr655zPslVEoMpXnKzeqWa+xMxb5DW31qB65PwmzHWg1DIW+qlMhdN5357QYqS0rXOme4L8pBnByxdWjq4fCq1BBYihulpvXkfYMGqU62wpdK+8XifSuBBFweWz1tkYTfw/UmYMuQ68q77QZV7jUrIVPBOMXGZB6s2qWGVIZ2MsaT28doRLkh6w+RnpQ/MYCVq54/XwjgrbgOdPd7JdmG2OkGH6z9+cUDElhbbL+m47PkMvYrPKVnMGc2i6adhoNtTO2v2oRNcNZkWons8JsYlTazKHS1XYNt/ATgxsvtO7KFXE6mL9BGj9Huun1HSVI7NAqKiOV9oOkL4cGSsHjWfVDzvVF2FyIQ14byElKSg2nsfemwjTUEgMyhoGBIASnF/5bZyB/knqBXnXstPwoVpuMMHygrPPRzXAiiFSUkSA9qmhK04H/WbLcfCBrJgZwlpokKoI3XtY0eoDAiDPRJQ6tggK8KuIeFB1d2fMv22skMN3QJwUjt80NPixkgh5xRfiWE53ZRQ4CNyQUBvUWmIxBzw+7x+giSOqtNVnMTcsfoivTIaUjr0soO8k34O/C3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(31686004)(26005)(2906002)(15650500001)(6666004)(44832011)(6506007)(2616005)(66946007)(66556008)(4326008)(316002)(54906003)(36756003)(66476007)(53546011)(5660300002)(6512007)(83380400001)(41300700001)(966005)(8676002)(8936002)(6486002)(38100700002)(478600001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTdpTWxjVmVkMG9kMENDWDVDQ05nL0RjczFDMjRhdEoyMyt0dk1lNEJSdGNK?=
 =?utf-8?B?bkY3TEpxR1dubHZOaWR3YSsyT3F2R0QxYS96cjJmNDZyVDVzRmtpVWxxSFF0?=
 =?utf-8?B?RTFiWElxanp2endGZlFWNFZJek9lWUtRclFvVjZCRlBwWDRkSDNCNW1zdkU1?=
 =?utf-8?B?Z0V6cGhuVm1iMW9pbWIxTVBIZ1E5YzJheEQ2d0VHTE11SlZmYzVncTVuOE9t?=
 =?utf-8?B?ajVFdDRFR2toZmFGcVpDYXRFaEhyQklZZFA2UXZmZTJrRldWNnNMWHB3Nkwy?=
 =?utf-8?B?ZDJoU0lYU2hBZUFsNzA3aThBRVBXMExFMnNnZnNQbk13T0RrR0dvVkF1Q1pE?=
 =?utf-8?B?bnBBMVlKN2tkdXFuenF1M3BpTE14V2JSN2NmaFRyZXR5bk5Zc0dLbEUzRExw?=
 =?utf-8?B?RnN4Y1FmL2RrdlUwSGNjTndzYTcycHUvQktLcGRORnFmY2tWNVpsQjFEa3Nx?=
 =?utf-8?B?K2dad0U5OWxqYlVZczZEK01kRVdzQXBkd1kvN1ZFVFNQZStyV1BqL0FvT3dx?=
 =?utf-8?B?R2xnanRIMFBTdE4zZE8vdW4rMkdvNG4xS2pGeCtOaGlSVnFlVG9DL2h6V0ti?=
 =?utf-8?B?Wm1XVnRBVE9CWHhqZFFJTnBDeEI5Y29PMkpnbE5XTnQxQU1JMUtZem13OUtI?=
 =?utf-8?B?SVZtbE5XcUxCaEZiYTNTNzZ1ZWc1TW5UR1dpdTk1UVY3dHRZazRqa0dSd2Y1?=
 =?utf-8?B?aEZaV1J3Sy9rTDladWtNZ1dHRlJnWjV0S21EM2hTK3d1MEVuOTArNmNUNklj?=
 =?utf-8?B?ZTc5c1N3dkZVVy9lcnNXZ0FNTEo2cC9xV3R3VVZWL2VBNFAwMU9Yc1RpUW1V?=
 =?utf-8?B?NTYwYzBPTzRaTjhHZitqaUtERXZMTU9MUDV1ZU9UQUhqY2xqZVVBT3g5U05m?=
 =?utf-8?B?N0dvUmVLRFVadWhqVUV4K1dCTXdsNE5pa1ZTZHJUL2JoSW5jZ2JhTHhYaU93?=
 =?utf-8?B?T3ZtL1ByMkdKK0NHY3pUOC9BS0FVWCtVaHZWRzdXejZJbms0UThZY3lnRGhj?=
 =?utf-8?B?Z3BRL2R4bWF6bXZpUFJ6VHNhUm1DWjFUS3o0aHVEcGR3QzBIWlJsNmR2VHpL?=
 =?utf-8?B?a3ZpNjkxUGtGU1Uya1Z6WUZaclBYWGt2VTZPb2RuZWl2cDFZNXhyL2JBbWs5?=
 =?utf-8?B?azlFbEhUWlYrTXNsZytqcHkvQjV4T0pLL3NMc01BRHpqL0NwRkNxd0psNTla?=
 =?utf-8?B?ZEZubjZWR21ET0hPdlNBeHVaRm9LTHllcGw3U2s0NUFsdCtzdXBucDFnQ3Nq?=
 =?utf-8?B?RnpaUlVPOFh5WTNXZVl5U0hFQmlMTHlXb0txcWpPWWx5bzdjQStEZlVGcmVz?=
 =?utf-8?B?c3VKeVJaNVNPaEMyazlYMWFYZVNJU2Y5VkRFaDRFdEdmTDlSdkR2WEtEMi9Y?=
 =?utf-8?B?SnMrcUZPeFB2Y1VlK0FLdEVaa3RkTmxDall2anNrdDFYblBIbkgxMGgrRUZG?=
 =?utf-8?B?ZWZtQUMwNkZuMS83aTlTaEVHMFFHdjl4K0xYdDBDdktxK3VKT3R4TlJnVjdz?=
 =?utf-8?B?eDczeHVrTnhQRWxpL204Wm8xN1pWSG1sL25PSTk3bEsxQjF1QUdVNDl1T0tG?=
 =?utf-8?B?ejZKc1FLMVJtOHRHNkUwaEZnUlJOckkxWFhCMlRncFR1Mmd6ZWFGT1g1V21V?=
 =?utf-8?B?TzV5RmxjajR5UzJWYmtjMXJhUTJMK3hOdnc2L3ljb3lBS1pNZE5XdUo3eVpR?=
 =?utf-8?B?R0Z2M1k0bUxLOG9QaEJ3WFd0aDRCVXRUQzh4YmFRZE1PYk9FelpmWGVRcHVB?=
 =?utf-8?B?a1Buams2aUg3VFNKOGNreTJJbE84YTU0bXZUam0yUnl5bDR5aXU5SEdERXZB?=
 =?utf-8?B?MW1BSnVVS3lGNTBQbkF0KzRKMDBNbnR3RTNMVlg3ZEs4NTBRN1JiSVpRemIy?=
 =?utf-8?B?NDVvU0FYWHJKdlZFK0tjMWwwWVZBalBSSXVDWllGeTVKQjUyVlpuZ2txRVJ5?=
 =?utf-8?B?RXU1akZ2ZTY1cTdKZ3lQNGhzVUFoWmltYkR1Y1pXT1IyemVpQlZMZXZkWmNY?=
 =?utf-8?B?b3oxcVZ3czRTbWwwSHhRNDBJcmZmaFA0NnVmc1JZYkE3MzZiZ2pCTFRvbTI3?=
 =?utf-8?B?YlFQRkErQ2dsbG43ZEtqZ2w4cU5yV1NDTXc2TVRLVmFBWkJ3ZlZETlRmNmE3?=
 =?utf-8?Q?Y13cKOkvpBzl2gkBDGlAlsEfU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e19926-de1a-4453-88a4-08dbff978955
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:04:11.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjIDHkt3Z5e7zo6feft9LUXrkO/7F5bJ3FmLY7dI1ZINP0LYnp9alVXBvPsXl2BK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225



On 12/16/23 01:41, Randy Dunlap wrote:
> kernel test robot reports 2 Excess struct member warnings:
> 
> zynqmp-ipi-mailbox.c:92: warning: Excess struct member 'irq' description in 'zynqmp_ipi_mbox'
> zynqmp-ipi-mailbox.c:112: warning: Excess struct member 'ipi_mboxes' description in 'zynqmp_ipi_pdata'
> 
> The second one is a false positive that is caused by the
> __counted_by() attribute. Kees has posted a patch for that, so just
> fix the first one.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150705.glrQ4ypv-lkp@intel.com/
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> diff -- a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -81,7 +81,6 @@ struct zynqmp_ipi_mchan {
>    * @remote_id:            remote IPI agent ID
>    * @mbox:                 mailbox Controller
>    * @mchans:               array for channels, tx channel and rx channel.
> - * @irq:                  IPI agent interrupt ID
>    */
>   struct zynqmp_ipi_mbox {
>   	struct zynqmp_ipi_pdata *pdata;

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

