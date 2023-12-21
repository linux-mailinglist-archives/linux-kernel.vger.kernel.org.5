Return-Path: <linux-kernel+bounces-8917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A681BE27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50D71F221B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59576095;
	Thu, 21 Dec 2023 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C6gz91lI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BF745D3;
	Thu, 21 Dec 2023 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd+Iw7xDlD3UAmvAbb8/tajBCJ2bM2koSrzz3MKEewkN2Pq1A9wvN3Po1k5t4HsSDF+lL+bjx7eyvUtFhphpsaE6dSFXfwYLSogXciXt8VcxsUmP9jIEc17Ee1F0OfRDGjHYwU7QOsGaM+6+IM1GHXu3zvB3Xx3HvFU3LmRTrGueCvs1LDZXxVtmXs8914q2rWDSZ+s99nJzhTZ1IzJyddanqqCmuRpcL+gTN8atXRi4aSfNiurENa7bYIgXO1QsUqCxGvxJXDw8tJo9UWdyjAm8n/uGv46NcyuAsUXo0c94NzeF7Ic+7cnieEN3Dt0IEAUoYkSztMIFxJ+9gh6Jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7EJZUvj0JZEI/1mUL153lCCyRgtZCCkL2wc9q4I+98=;
 b=JBstNtdclOg2EHANpLFncQ+J3HgOyovHMDKv2fCOsAHlulgCQt/gctoHDFSWd+Na9FtfpBcZhSu++uhTQVO/5/8oUg1cHfkUXH+m6PyEATtj9ZsQPU5QElO2j0kTHCvsH78iShQeprNmVyYlzRATu7KCEehKUKwPrY4rrlWJGnUfN0zp+HD+OQq3Tz005zqK9GR6k4l0/PKrrakw9MG1+2wiQxwbS6PzXppbDCmx3xgGO6p9iJgEv//LKfaYaGvmZGB5fxD2dAmowe47SypKbVy4pZ1UOw9NBA8DIB4l2PhpsPkhaRtJerh7ZjXK7fniajpnRGGt7DfxDYbVFe7ROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7EJZUvj0JZEI/1mUL153lCCyRgtZCCkL2wc9q4I+98=;
 b=C6gz91lIPQBSznQfP92BjWvzOrQ/1Zlm4WIqhOHL/qdkbEB12F4OcdEbIy1Od7fcANpCvYQLHrIk3af0X5fiQ1cZn2Z+5Ch6o25kmzwPzjjxhVKNuontugWRtVqh3EFKfOhpR1VUHQWeZH2btns6I3cWl8GIgdq15+n9igbSvVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 18:25:43 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 18:25:43 +0000
Message-ID: <77cf96b2-9a48-ae3f-f234-1c27186b1d3f@amd.com>
Date: Thu, 21 Dec 2023 10:25:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] r8169: Fix PCI error on system resume
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, hkallweit1@gmail.com,
 nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231221044350.441285-1-kai.heng.feng@canonical.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20231221044350.441285-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0d7810-6884-49c5-8855-08dc02523e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qBvFcHkDm0aZ7A2VtWPvgXUEFrKrmODEC7aqXgYye89JYfiT8z1YMOZPYBJblMH7L29vvo3JyfVi2JUGHDdlAtRcZYMd6esminY/tVT/HYA4IXQF6H86z/6/XftdEsVwvdY9ihFfaf48XIKoLXQvmJPh46WLu6Qu3Ij2W2o9seS8sJRQVJaIQVx54DgV0h+6YoATo6KY/fNXfUAbxrEqWz4scGmiyhzG8gyMsf7k8Ce5k/ZmbaDnfXhV1q2pWCvAcpTT4Sv7p164RldoNaW8K8MsUY6iPb88IvJZphtDSG7IdxAYTY2LdjmNAotwpsz0SGImNUEM/q8usEvvrS+xvgV0gPUEFT0aGGpgOoHJ/L2ymsYVrdDWz5fEztxeT0eNzvhqklK27lUolrJz8586rzEYYVwhoZj74bT9uv5QJIPm6D/gDraqB5knFmb8Ws0qELJV1lzk4T5FnmA9KqBIs108lcYioVScwaAO2IrDd8cFzycMe/FRGFW9RPcq6SRmViJ3YiNW/8T8S2sxYVTEH4/MfGwixs2w7zfA7eyIs1oLMZAfS00DO0IygCfCOPnHp9sZwTGZqn82egP89vxRZI2k6RdXR4R8NkLPGpdPe5E6pPMqz9SigGOw6J9YfO3eH81dxR+iNxBmFihIRrau9dOqg9xozoSPnuQSjPYD5UHeL7zNeoKJWHl94Hehz9MQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(31696002)(38100700002)(36756003)(83380400001)(2616005)(26005)(53546011)(6506007)(6512007)(54906003)(478600001)(66476007)(316002)(66556008)(6486002)(8676002)(66946007)(8936002)(2906002)(4326008)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anQ0TGltL29ONmdZVXM2eWcrMXk5OXhDaWkrOVA2QnhNQWIvMzU4MFZGNDFP?=
 =?utf-8?B?blE5RFlyNHpxa3Y4aDR4QXBSNXozSElqSjBZZmU2dnZ6UlRmMEp2TElFRG5l?=
 =?utf-8?B?RXJFSzl3c1NOeHZWUTduRElxYkNIdXdvYzliOFV2elhVVmRZZ0VzYWVtOEEy?=
 =?utf-8?B?YVJaeVI0WHVOb1hCdDhhb3R5bWIzWXBzTm1WV3Z2SGhSc1BVd2hzbHVkSHFG?=
 =?utf-8?B?NW5pblZSNkN2bEgyZzhuZFVDa1Z6WTBVb0J1dWxwazJxMGxCUkN4ZkdOenc3?=
 =?utf-8?B?ZytwOFEvblhtR05kelFJVDNYRnhLeTRla3paOFZhN2g4T244QUJmTmlMYTRM?=
 =?utf-8?B?QmJZeVU4TitVREV3MENCa1BSc2tSYWROdC9SYmpoQ3NKcmJ4SGl0SVhEYURk?=
 =?utf-8?B?RjlQa2J2K0lEclo2Um9tUWswN1ROWDdNWkw4b3dFaTJHVXF1Vno0dUtYZzk5?=
 =?utf-8?B?eDh6SXZoTU9MVUxvY21hTkxqYU5kK3J3dUFkTUNtaGhKcGg4cllxTnJ6QWpz?=
 =?utf-8?B?amtBRkZ1dWdSRFV5U015UUt4MnBKS2RwZ2doSGNWL2ZORmVRSFhSZzJ2NUVG?=
 =?utf-8?B?Z2RxWFVaYnRFTE1LSUswbzVmUm1XSWgrSHlkbmszRjg3MlpRdVRYb3VBWHhS?=
 =?utf-8?B?QmFiV0pGZytXWGNPNElMWC9LMngxeVZuTlBTTFNZVDU1K0lHb2RqandiNVZB?=
 =?utf-8?B?WnAvakJ5N09RemNtL1QxcEN1YWh1eTFUa0dRVmY1aEJRdm1oL1ZOTkxvczEr?=
 =?utf-8?B?TW02MW9HN3R2NERselBSSnlZTTMyc3BoR2Y5UVBMNklSNkJoYnlFMWVvMlhk?=
 =?utf-8?B?UlhMdEhQbUk2TDRYZTBkUGhGTjJPTWhxYldOODFsUFl3blpaRU5DSzhTRnBE?=
 =?utf-8?B?bUdpcDR2eWJpZHVWc1BzTHppbXJxd2JwU3d1MExKU1BGT3NlcERrOVJILzNr?=
 =?utf-8?B?YWJqUTVEd3FmczJEMFZCMkNvZy9CTnZ5d2Z0QUlJRDZSOFMwS0VmOTQwUUZu?=
 =?utf-8?B?ZEU1aEZJRExRcTMyNkRqK3krZWUzMUc5OE54cWRMZ3BzbnFRRkUvQ3BPMmpT?=
 =?utf-8?B?aFltemtNWU5rM3BoalAzNzd5NFZOSFg2WFJIVG1rZGs1T2VIRjNrd3pYVWRX?=
 =?utf-8?B?OVp2K0hIcC9wSHBVdFdCVnpaTHgxL0M2K25vLytuVTN5dzZYZ1FnVVM0aHBR?=
 =?utf-8?B?RnhyNTN5ek1hbXB2bWdQWUoyUGJCQVdlVzVxVDhkR3VuZDEvZEgzR1lpSUps?=
 =?utf-8?B?UDdEb2pSbkxZTGFZTjBjSjFMS3F3YW1ocnhjSEVUQnFRa1F4U3E5d3REWEUw?=
 =?utf-8?B?aTZWU0ExU25pb1pSc21nWElidENZOHZLb2piTDc1Q1ZtNU1OdUlxMTdTdXFy?=
 =?utf-8?B?eFB3YU5TSWNCTDFlaHoyTHQ5d0NpMVA3UFdGcCtWZ0M1Smd2bFN0WVlZcEg2?=
 =?utf-8?B?M2FWMGw5RTh5RUFBZXJMMlZIVlRNQ1V6SHBRWm1oTmVvVGdjMmhUZHZvRjAw?=
 =?utf-8?B?TjJGZ1hhT3BtQ25OSEJiZk5pUGNmUlU4TGdVZ3hac2hCN0NpTjVMTDl0QzNZ?=
 =?utf-8?B?OUo5cEVDSllFdklEUlpoaDN4WVp6QmJ2RzBrclZzTzFGb09USFRmeHM4Nzg2?=
 =?utf-8?B?am56V3VpWGdzSklrWStCSmloazY0YUtvZk5ya1Q2NkhqY0xQT3h1YUdocnJn?=
 =?utf-8?B?MndCb0xKY0dzdEJBSS9scmdBYm0vV2NqZHM5MGhMbDd6ZzgzdEZmNlFGVG1S?=
 =?utf-8?B?L0RhdzJMc24xTWM5TU00MUZKRkc4cWQ3dEF6MmExWnowQW9OSHpoR1RJZjR0?=
 =?utf-8?B?MWU3enBmaFdmSlhkSWloNmpKWnpzbkNaOGg5ZWZ6Q3Fvb2MvVzRMdnZ4ZGtu?=
 =?utf-8?B?b2V0VURPUzdhVTdnY2ZtVWk1Q0NFNWY3TkliMUJKSXVJSUJTYktuTGFqL1Q2?=
 =?utf-8?B?Ukhtb2RSWmRhY2k4aFNVL3Q2d1dtdkdjaE1BelVwTldJN2FYS2JlQ3B2TlN5?=
 =?utf-8?B?NmJRSmpFdWVralJMd3NYazk4a0cxUzlkTkd2d291T2x2clA5eW9LVm52Z0FN?=
 =?utf-8?B?OVl4SktxUUxIblloM00yN0g1a3JGY3l3VWxxN2tWNXViNjdnSys3RTNJYkxh?=
 =?utf-8?Q?2M+0HIwnikCxrtMVAOjcV0UGD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0d7810-6884-49c5-8855-08dc02523e31
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 18:25:43.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EK2W8llTxBpW3MEwvTxv1pLQ8gzEuAAKM7JWeyDfjsiH63MH7nEt16Sn5ubF0E2JvjdJTctVOs/00RUhkmbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565


On 12/20/2023 8:43 PM, Kai-Heng Feng wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> [  688.051096] r8169 0000:02:00.1 enp2s0f1: rtl_ep_ocp_read_cond == 0 (loop: 10, delay: 10000).
> [  688.175131] r8169 0000:02:00.1 enp2s0f1: Link is Down
> ...
> [  691.534611] r8169 0000:02:00.1 enp2s0f1: PCI error (cmd = 0x0407, status_errs = 0x0000)
> 
> Since increase the loop wait on rtl_ep_ocp_read_cond can eliminate the
> issue, so let rtl8168ep_driver_start() to wait a bit longer.
> 

This doesn't really describe what the issue is that you are fixing. I 
think a more clear commit message would be helpful. Also, why "30" loops?

Does this need a Fixes tag? If so the Fixes tag should be added and the 
subject line should start with: "[PATCH net]".

Otherwise, the subject line should start with: "[PATCH net-next]".

Thanks,

Brett
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index bb787a52bc75..81fd31f6fac4 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1211,7 +1211,7 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>   {
>          r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
>          r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
> -       rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 10);
> +       rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>   }
> 
>   static void rtl8168_driver_start(struct rtl8169_private *tp)
> --
> 2.34.1
> 
> 

