Return-Path: <linux-kernel+bounces-6825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C675F819E20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE731C22A40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B721A02;
	Wed, 20 Dec 2023 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pB13cycr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB52219F0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X42MpGBDdMBblwH4G4mswPcdqzJN91pdFpr47QCjEbDSLUV9L2jlmuYxJ57SsNCHuM3D0ScYKte/Jb2lF/WaDX8MlUYWe9srFZt/W6+gsnhj+qlGWq6Bh95YlXM9bKJqOG0x3XdWMkF9qwEjCdJmVzi2iHi6SaLDY3tyaXAFBdZyOR/+Z7ptFSyn1kg0RUwII0jPtY5gAgfuaWUVwHXQIrAsQE3AxPccgT+ZIwsNjFJOVxDFbmzbTAicewa0Gy3Mfj3RVT3ZRYJQR/IdCQ08iDVXOgCzRbxnIEQioDqJAEk2j605QS+mlpaqTD3OlR6A1vhOtPKWtbO4t5JEqt5RMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hHRJVE2ekW8n916T1KcxNLVgBAXYuboQ48VC3sJtCI=;
 b=hr5RLKmqbWThwYUDHuUjWW4LB4wNQ+M4q2tZo3tfsC2xnVJMrma/qfutSPvu0wupCrGD1EhfE4CCp/pcFFDY+ZZmbUbyJl81uL4faaM7pjzvH0FaSDaY37ZfetVZ5HoD5KNvaWGaN3nx6YzUN270Y/ahIqzuxeo2Cg0o2MiLg9axq4QX38f52q7jnS1NcxnNX98VUhynS1sPAeZl22nOyMCCvixUMsGkfAaRL+5pxU1zCt6ih/1XmdDcbD9HYtn0O+rIjO5xiIwtLSlcfqrkLxNhl5skSf/mGCE2qHlObv7fkn4vAqnJxCDT3mdZzclIbokshAawTCPbmunYiP0Dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hHRJVE2ekW8n916T1KcxNLVgBAXYuboQ48VC3sJtCI=;
 b=pB13cycrtkXmxshQTWruQVJonlso8xUh0uOdkE1t6KKblJYx2IulSacnCwy7kxKapfRkwpWu3IjEb/Hulf3fCSNKXIcIGdTGwNsG2yl+A5fxhZ+J/8IY/3ZjtQ/4zuu6xrykIW88WyY6K2inOBibPyosA9sdbWtWDAo+0h+1tk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 11:33:15 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 11:33:15 +0000
Message-ID: <d3eb97ea-979b-41c3-9f29-95ad4e1220f0@amd.com>
Date: Wed, 20 Dec 2023 12:32:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: xilinx: Remove
 zynqmp_pm_pinctrl_get_function()
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Arnd Bergmann <arnd@arndb.de>,
 Dhaval Shah <dhaval.r.shah@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jay Buddhabhatti <jay.buddhabhatti@amd.com>, Marek Vasut <marex@denx.de>,
 Nava kishore Manne <nava.kishore.manne@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 linux-arm-kernel@lists.infradead.org
References: <6ccbffbafd1f0f48f6574d5a3bf2db6a5603fdb0.1702565618.git.michal.simek@amd.com>
 <e52a415a004e28a43e6d08e9e22d9e8fef3737df.1702565618.git.michal.simek@amd.com>
 <CACRpkdbso5A0muF6yqVyTquX+uPLTQCUpC0CF8DvR1_-uU0frQ@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CACRpkdbso5A0muF6yqVyTquX+uPLTQCUpC0CF8DvR1_-uU0frQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 276253dc-dc46-4770-2429-08dc014f748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iKHXJxGv/F4nChnEhQmKQlq+HWa73tPj3gj46igAaDVGtIQQoy1QYGpMJGUIMCJiF2FG0zPMXDsfum4+LPI9QtWx8LjdYl1ylH/lEVWni6CGB1GqNIBM64mFfpRSuJcbmg63n/SYIeNKnBuhRuMTIfVzLMIFH1x3qeiJyTQWyosOw6Eb92W8K7QDmwDlE5WXML8rIB765hxLj4GXDsr7q1/rV0ooAJqhukAExKreu5xACPhCkNg6tRwe+vAiVnSyG8/NY2ZdAkOxG9I+68TxRYfwZfHW6e3Fzj0ssd0yrmZJJIJbUdCUsTLzrENiF4uBDDo+0va1mziQ2EDATipB2u4UKvuQXYT+sX7cVxv+rbRBE+39O2VUyVXXe3kAexLyMdj0XIBnBrjx8Y5rGw+nB9GHoLRDc71x1s39Q952pg4As2g8GsZmWxedUDeONaxJ2kDN+TDx+gIi49HuPR6qCf1e40oZmMfxNqAvs32CfvOndjx5ki+N/zQ2M2A4Rk4pbDjT0PRTiDJgg1r6ECX8rsJnv4PkDhkr4kv3bZVIHLre6Kbvm2rZv4z2nTzZhfXD0KXUk6FZ44bPm/AansaNzFe4g2oHVpQDPGwg/CFy3OCj0vXSL5D7VhZBONfuaNX/SM8klK8+czSIS6z/0xmSsA5crXdRWUFzStqpLqzv5Ji7KwJoeZ39NkY3/cBMtSiIQZZHEwpu5YqUddmim/FXXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(2616005)(26005)(38100700002)(2906002)(5660300002)(8676002)(8936002)(316002)(4326008)(44832011)(4744005)(6486002)(41300700001)(6506007)(478600001)(66476007)(66556008)(66946007)(54906003)(6666004)(53546011)(6916009)(36756003)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODg2V25uaWZDS2ZVN3prRTBRb1J0YXNNWEVOTGpqUWFub3UybEJBZmJLWThU?=
 =?utf-8?B?eXZmM0VzTElPbzAvY0JEZ1VFa1RHeHFYT2hnVnlSV1BTYkoyMG5xMlNmUG1G?=
 =?utf-8?B?RUl3RitBVG1zdVVPUklUWXFoZXdFMXlGMmRNVTZEMlc1dTlNT2o5TGFIbU1i?=
 =?utf-8?B?S0dvTmpFYkJHRHlpSEpCd05DaEN5ZFFSY0w2aGpWaytPVWhaaS9weTgvMDZC?=
 =?utf-8?B?RWRuWSt6RG1jN3NZakd5RUtYZ1N2YXVjT3d2cUEycHM1U3pyUjE2YXFPYUEy?=
 =?utf-8?B?Y29JUC9jL3gxMXR1TTNTRGdTbWU5SXZad1lDSjZ0QmV2cnZKRStoVGYvb29L?=
 =?utf-8?B?UHNMTmZSbWlLWDFWTGd2NlNlWWVSV1NIdHk1ME1kUGZmZ2JUUjhKa0xlR1p3?=
 =?utf-8?B?dHRnQTl3cFVBUzFZMkxmdDBZNGVIWkMzcExGUWt4cW9VREN6Q0tNdnRrYi81?=
 =?utf-8?B?WjRJVENaNXY1VjdCQzNRNGoyVUlPbzlTL0hjTmk2VVJBNWdvM2ErY2hyUVdS?=
 =?utf-8?B?NGF2cU13Q0RiZTlNZTJQYkpDb29GbXRTekxwcUtTdE40dEtxS3NXSmVBaVBl?=
 =?utf-8?B?T3NHTTFHZXNLSW8yY01FaXZQL2VrOGlBWmZsaitRMnE3a2tTdytlVU9DWTFZ?=
 =?utf-8?B?U0NjQlV1MUZGaC8vT0dZMHBVMGRXRUdYUlYzS1VHZkRPcmdjdHl6WEpPQlBu?=
 =?utf-8?B?SUE1bGNrb3BEY3NGSnNXOHl2WFhiY3N2T2puaWFhOXlnU2c5YXZFK0E1MmJm?=
 =?utf-8?B?Nmt6UElWTkNlb1psN1BjeVNXZDdINnBGZ1djdXdSNFQ1YnA2TmJSOFZobDlu?=
 =?utf-8?B?Rm4wMVdvYVI3ckdZQVh2VE1LMThiV1EwSDhmak9qbExZZzZrNkY4bW9Obkxa?=
 =?utf-8?B?emdyLzl6bzYvcWZhRjBSR2dqS0YvWWR2S2p6Y0xrSStCWTBIK1lKWkFQWmZm?=
 =?utf-8?B?QUlNL0hBZC9pSGNlV2xWTFdmMVdRN3psYjlGMncwZ2JZaFd6aG9mSUptUEY5?=
 =?utf-8?B?emxrcWpIbVlrWm0yZUFwaXNwdGlhdjNsUGhZbEJtOWFWZzRsWTZ4a3FBdXha?=
 =?utf-8?B?eFdYcXdDaHBiaW9TUENNVFhGQWJrMXdvWXNWQVRVYnlCODg3cFh6MENhMlF3?=
 =?utf-8?B?L2cvbUFRUnpTaGNyYzd3Tnc4azZ0a2xrWmxQL2VDUnNFdUY4ajNDcXIraFpi?=
 =?utf-8?B?NW5WUHRJK2tZRW5jUit0bG9QTEhiWkNaQ0VtdzFkUFFGSzVzYitHM0RzNkZQ?=
 =?utf-8?B?ajM4eENBSExOYU9BVnVOQyt5Y3FiZGRnSm9MZ3ZoRy9WblRMUGppODUycTZp?=
 =?utf-8?B?T0pCOTZOdmR1VnI1UHp0M252VFFvZFM0UUZvWFJzVENMendJeG5UTEpnRkRh?=
 =?utf-8?B?ZktTcTg2eWxvajBzeGloVTlpa3dFMjExM2tqNUV3bm1aUjdpRFVBb1Q0c2tp?=
 =?utf-8?B?M2tGWHdJN2JteFB0eWZxQ3pFMHhna3ZkZFkvMEVCK2xRZDd1djBDbW0zalBq?=
 =?utf-8?B?TUxNRXVSS29NVlZXU1ZaSzlyZzQ5YlNsRzNSL3pkZlNxZFptRUV0VEt4Tkxa?=
 =?utf-8?B?N2ZSR2U1UlRyakNsclBJZU5wWmZYYnM1YVgwTVUyRVAyWE8rK1lPczI1TERu?=
 =?utf-8?B?NlpDb0hIOFhYTy9XeWh6Ullzc0Vra0d3aTFZTUxGaTE0cXRiUjRwZzRDdXUw?=
 =?utf-8?B?MHo1TVJFNHlzM1RtT0cvN1VxYXVYcUtsSkd0bTNFZjR6ZmkzRmlzOGpXZkcy?=
 =?utf-8?B?b2JTaTNCMHByRHVJcUpyUHcxdnBidks3RnBQdHBSZ29xc1dETGcvTmNvK0Jt?=
 =?utf-8?B?NU1PWkNTQldQaXV0c3pGTlJJekNpcjZwdmNPY0srVUJYZzlPVndIZmk5dzNZ?=
 =?utf-8?B?b21saXI2bWczYVZ6M29LS1M4WXJ5SFdndFdOZlliOEM1SEZZalltWjFRakY3?=
 =?utf-8?B?WWJNajQxL3U0SGtaM2VFYU5RUmxiV0Y1V0hycnV4SnlBdTNOWTA4cEVuMEQz?=
 =?utf-8?B?OWFHN1FjUnRvRWpUMFJUcGlTb1V5UEJUQ2JvSUFxYkUwY3BtNk4zRUdOYnh0?=
 =?utf-8?B?R2ExVDdrOUQ2Wk4rc1lUUVIrajVuOVJqdGRKVktHYk1VY0psREpZR2tVVDR6?=
 =?utf-8?Q?z/Seqis0dxcYgwPfKC8n++Vbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276253dc-dc46-4770-2429-08dc014f748d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 11:33:15.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAc+BN8KN7PdzYzsqPlo4DyyIz8xs7G6egOL4rFc0RVjdTXGDCfzmEswDdSXFQb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182



On 12/20/23 12:13, Linus Walleij wrote:
> On Thu, Dec 14, 2023 at 3:54 PM Michal Simek <michal.simek@amd.com> wrote:
> 
>> There is no user for this interface that's why remove it.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I assume this will be merged in some other git tree, tell me if it
> should be merged through the pinctrl tree.

I expect Greg could take it. If not, I will take it via my soc tree.

Thanks,
Michal

