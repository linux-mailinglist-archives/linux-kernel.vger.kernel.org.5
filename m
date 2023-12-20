Return-Path: <linux-kernel+bounces-6959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5968B819FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEB1281C64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF582D63B;
	Wed, 20 Dec 2023 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nkC/wKlA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E292CCDC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuijCg6h1xAfCFNnjY1zIrPCJgkRESVFVmoTZ/B7vAi/GMxRL0IqFNtjzz5itId+jJXpvrRSlptpo8ME4DRGTv4GT1tQEnWAhU81ByWDne7m4Y+rWjUTGjK5SG8+2fo9mjG1Gmw7pJ5JzKAM4ZUAMdKuCFn/tfyYB+QDlLxr7hQCLzVNtBbhqDpizPWpsZ1r4rrQPl9GsYDvtlMB66aMH/l/vATDcvck5X9h/bhEHT85WN/k3k75YXhlxacKUbMuIFcgkWo6GfqCI8aGMbEc6/4OfhSW1RsEkKWv97fFyIx/XGCs7rGW9gLsDEmahsyZkzcXXZ2JeRLlXpOvVw2KQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9CqA37nyCRQ4V+jM3oWucL+PeUEco3MDfE8NqiduQI=;
 b=FqW6M0zxaxG57BuHr1Jx0yRdzKF76N5dWjb2KzpogiL8PWbp1WwQs7eWJXj4G8hFexQdUArEoORq74d0MrV9kcfN62zVEDNI5uLLhUNmP9erXDIqcFOSy0fOSf4N7tpxklGGI5q0ee4L+gWJwN5y0PxpVkFgFKonsH07xG4X2wR1y5SV+j9pj8wfuLky+7UOIVu3aX4yli2MYF9TRcrYEm8mv9DomYoyvxlF2WT/oyoO1cD7JRnaHcaVaCQpchmbb/ayJJIV3P37NZv6rgssT8Z922wn67qlPv2SBF8wM4LSWnxLO6IQTdRv/4YTvWNbAp8Zq8OemQeuy17ADoICsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9CqA37nyCRQ4V+jM3oWucL+PeUEco3MDfE8NqiduQI=;
 b=nkC/wKlAe60wdVevuIZKQNbm3PC4DXkL/OdzJiRIzQ6sq1qEWRRE1VnPzf7DvjmktxkNsgdntGM80X6x/D5yV4baPutavaVeZH3TKeMAK5T+dNsV+L1utiWyM8rgRYvecGoHfd9EC3BZ/B3idOaiL/6F+7EuV/jo7EKXjrfSXyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Wed, 20 Dec
 2023 13:29:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 13:29:37 +0000
Message-ID: <ea76da63-4758-400f-a5ed-9cb223b65c80@amd.com>
Date: Wed, 20 Dec 2023 14:29:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: zynqmp: Enable Bufferless IPI usage on
 Versal-based SOC's
Content-Language: en-US
To: Ben Levinsky <ben.levinsky@amd.com>, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
Cc: shubhrajyoti.datta@amd.com, tanmay.shah@amd.com,
 linux-arm-kernel@lists.infradead.org
References: <20231214211354.348294-1-ben.levinsky@amd.com>
 <20231214211354.348294-4-ben.levinsky@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231214211354.348294-4-ben.levinsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0036.eurprd08.prod.outlook.com
 (2603:10a6:803:104::49) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdec446-ccaa-43a0-da56-08dc015fb634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TJiDl0lNrT2dWFiFJlBQyjUzcHtzHzazy3Pt/qpPIISs0y01LZmmPxo9Hpp6Jc8TudNF+i7Ja/gSMrCxMHZ+pbyHN9fKBJr+/ympa99fGUxROT/g1QlB2756Y7zq8J1iyhaJmaG5cA4Q2/lg05oim1zam/rTrlGqKhESi/wMZ0oLDrmy3Aa2Ri1eHy9EEXXVAz1TsvI77EfSnj/ay9eOUybdqggrh22nuJJtRWIUPmkYv6zbKDnvsLupapxmWp89y1jFUorJS3B22y1vkpPbUpU6GFM4SodZJYxjjL5vTB6jkloZDsVx1AvECKXpAyVkekFGe0yb+hND+jfFMl2ygTDEtL02kBEvR0sL1k3VY+CDx7TxhquUWk+aWv0fdEspOuje84AJYTrH9j+JkFumtLbw7nevdOfTIVJVF3oZ8RErqH4v0wCKfjWmsvyfxJ+HPX70HhyeN1b59eKJhcIRM8CQwkOkHYWweUosyUD+tvgzU4xai1ZTZGFsXchT1cSeuND3XLE+S7hGwqCpciqae82pxmEgjJua4M7cKGcEi4jzkAt3dJmhJ0UmjMU+IVp1t887mkjgDbELp1hmjfNm03W5s5pL7j4uOTL6Um71UW6njY9K1AmO8o55B8RuDSi7jjzvJwxxebSq0TgKogprSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(6512007)(53546011)(2906002)(6666004)(6506007)(6486002)(5660300002)(83380400001)(15650500001)(4326008)(8936002)(8676002)(478600001)(316002)(66946007)(66476007)(66556008)(41300700001)(966005)(38100700002)(44832011)(86362001)(31696002)(36756003)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlYaHlOaVRvVU5TYXA0WElVTGRnTlNDSElCdUR6ZTRaNUROd0xqR2NqNjRk?=
 =?utf-8?B?aGJmTEdONS9YbTdJblNFSkhCUGNXY0M3T1hWL0F2ZjY0cCtvTkhuWlY3ZFda?=
 =?utf-8?B?WmphVm9MRHB1OExNUkRYNnlzYnZpT2xUKytFTjVrMlVicUpxSXhFSmxHOXpU?=
 =?utf-8?B?MnVZdXFYTjZTdUhaTmR2bjZDLzFiT0o0MDZiNG53aDdrRVRpNUZ5MW4xeHZ5?=
 =?utf-8?B?amtPcmtNODJjTVV3c2E3alY4dlg2dE91Sk1QU3JnK0haa2cvQnBsYXdXZm4x?=
 =?utf-8?B?V3ZsZnQvTEVsNWM4bEcvYVh2akVYUklIUDErcEZpVC9SNmY2MTU1ZzIwZ0hN?=
 =?utf-8?B?dlhrZnBMeUxKUC8rZVY0VXA4M0dPWTAraHFOTTVYM1hSR254QzRoVHFFOEEx?=
 =?utf-8?B?SVVVQTQ4Nkw3dFlkVXNtUWo2WTNFV3E4Q25DZGdBcWxMQURRUG1GTjF1UTRk?=
 =?utf-8?B?T2dKTVBWWjR6Sm9zQjBxcWIvUEY3OFdjZVMzTXlJMW10amduWm5heEhCdmQ3?=
 =?utf-8?B?ZTVpQlpBNlVqMm9MM0MxdGRnQjYxUmt0YkRVSFhsUDFzN2VEL25tYkIxa1JL?=
 =?utf-8?B?YzZ2WXlXcmJkOUJ5YTVLMFRGUWRKMStka1hyWVo1aE5sdGV1WTRvcm9zcnBY?=
 =?utf-8?B?NG1TanhqdDdUS2RZZkNCU3BpajI0WElpVkZEaFIxRlBnMm85QWJQVXMxTFlZ?=
 =?utf-8?B?VlFmKys0TXJBNVNMS205dUdFUkNRb1lUN0FyNVM2TmNOODJSOVdCYkdxcjBG?=
 =?utf-8?B?ZVFDT202UVU5b2lqSGhaWXJQdHVOeCsvUzhpbTNrcTFudDB1QXB6cmllbTFX?=
 =?utf-8?B?T0U2MENIL0ZXSFpWRE9lYUZodnF2T0hlNlIyRlVmZkFxOXNDeTZaLzk0MDd0?=
 =?utf-8?B?cGRIWnQ2ZW9ac01lcUFOUmI3NTRnQmoyMFNwT1MxRW94Q09KQ1dGL3dyYllj?=
 =?utf-8?B?WUl2dzBTRHpWUmVIc1p4OFNtL0Jwc0svNkJxcXgra3lVY2R2ckhLSXR5T0NF?=
 =?utf-8?B?QUtRenFOeUJvQmJmRXpjdEF3K2p3dU1wNTJQMmZWcGN6bFBGRmQ1dHI0ckNU?=
 =?utf-8?B?RU93OVMzWmF6YTRwb28xVHBLM1lFUjZlWmJ0NU5PaDJPU21SdWRVMEJzaDV4?=
 =?utf-8?B?RGpmaStIcjBMM3pia2s5eVAreDhXa3pFRlcrbFNidDVKU0E4K3c0QVJLVDFN?=
 =?utf-8?B?bHdlTWdEdGU2WVZQR2JUUHlja0puVWRxT1BnNlBacERCY0RGZXNHZGl3N29L?=
 =?utf-8?B?UGhXNWthRzVGLyt1T29QY0F3VEorem52dlYvMjJEU09sRU40djU4T3puUjFY?=
 =?utf-8?B?bUF3MHc3Y21vT2pZL2Fva2h5MWRETEJ3bnFxV3JjQzk1UjhLWG10dGsvQ1pJ?=
 =?utf-8?B?N0RyVHlqV3dVUlZDaGdwanQ2VW9oQ0hkQ09RakFUdkpGWTVYMzRiZ1orazJI?=
 =?utf-8?B?R1FaTUhVM3lZclg0N2d4S3NaTjJiRkVnU3RlcDJseU5yaGlPNTJjc2Q1Y3Ew?=
 =?utf-8?B?Q2hkMGp5anozN2lYY1FFSkNwQTBNVTJsMDQvYmlqUHgzTlZMcTUyRUE1VFdP?=
 =?utf-8?B?WW9JRWJlM2dvbWh1OWR4V0duTWMrUnVSUHpFMTVDZWF3Q2ZSS3lNRjdMbm0y?=
 =?utf-8?B?WnRtOXZIQkpxY0hmOHByK3ZRSFh2NHlHZXBtVzg3UVNjUndvY1M5ZHNBQnM3?=
 =?utf-8?B?WiswelRzNzlKTzlKVHB2SHExeWZOM0FjczlNYjZSZFRVbGFIRUxQOXY4aGpJ?=
 =?utf-8?B?T2lJd010clBYRU1zRHYzTDlMYUdQWjBtc0JZVlhQbkxxZ2lJZlJ4Nm91RWl3?=
 =?utf-8?B?Y25EZGVqbEpIZnlwT2JSVUhsd0FHb2ZTNTR1UU92S0gySGppeFlnOVhuN0t0?=
 =?utf-8?B?UWUzT0h0eml3bjBvMVUrR2pIOEhZTkEwekd0WGJYR0FKZWp1UHV1Qmw5b2pD?=
 =?utf-8?B?dUVZYWM5THBCQkdFK3NhNVRQQlVrMHNNUG9YY3NFTzJkOTcwWmhLSk9LcGNm?=
 =?utf-8?B?TlYwcE10c0dKRHAzczRDa24vZGRrOE1aaksxV1dnUkJoQlpFYzY3Vk5UYkVQ?=
 =?utf-8?B?Rzhvb1VFUE5kY3Bja1IyYmxzSDQvWmZNWjdHK21PcmExRGFpUWRPQnc5TTB5?=
 =?utf-8?Q?tE8uvVfijC6IZnfYHz1/ui1Rp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdec446-ccaa-43a0-da56-08dc015fb634
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:29:37.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/4Mj/+sjv2/lp0VftGzDjGKZefxB0OmCdIC/tvXamTmBrU43XqTqjEP8mAIC77s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195



On 12/14/23 22:13, Ben Levinsky wrote:
> On Xilinx-AMD Versal and Versal-NET, there exist both
> inter-processor-interrupts with corresponding message buffers and without
> such buffers.
> 
> Add a routine that, if the corresponding DT compatible
> string "xlnx,versal-ipi-mailbox" is used then a Versal-based SOC
> can use a mailbox Device Tree entry where both host and remote
> can use either of the buffered or bufferless interrupts.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
> ---
> Note that the linked patch provides corresponding bindings.
> Depends on: https://lore.kernel.org/all/20231214054224.957336-3-tanmay.shah@amd.com/T/
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 146 +++++++++++++++++++++++++--
>   1 file changed, 139 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index edefb80a6e47..316d9406064e 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -52,6 +52,13 @@
>   #define IPI_MB_CHNL_TX	0 /* IPI mailbox TX channel */
>   #define IPI_MB_CHNL_RX	1 /* IPI mailbox RX channel */
>   
> +/* IPI Message Buffer Information */
> +#define RESP_OFFSET	0x20U
> +#define DEST_OFFSET	0x40U
> +#define IPI_BUF_SIZE	0x20U
> +#define DST_BIT_POS	9U
> +#define SRC_BITMASK	GENMASK(11, 8)
> +
>   /**
>    * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
>    * @is_opened: indicate if the IPI channel is opened
> @@ -170,9 +177,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>   		if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
>   			if (mchan->is_opened) {
>   				msg = mchan->rx_buf;
> -				msg->len = mchan->req_buf_size;
> -				memcpy_fromio(msg->data, mchan->req_buf,
> -					      msg->len);
> +				if (msg) {
> +					msg->len = mchan->req_buf_size;
> +					memcpy_fromio(msg->data, mchan->req_buf,
> +						      msg->len);
> +				}
>   				mbox_chan_received_data(chan, (void *)msg);
>   				status = IRQ_HANDLED;
>   			}
> @@ -282,26 +291,26 @@ static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
>   
>   	if (mchan->chan_type == IPI_MB_CHNL_TX) {
>   		/* Send request message */
> -		if (msg && msg->len > mchan->req_buf_size) {
> +		if (msg && msg->len > mchan->req_buf_size && mchan->req_buf) {
>   			dev_err(dev, "channel %d message length %u > max %lu\n",
>   				mchan->chan_type, (unsigned int)msg->len,
>   				mchan->req_buf_size);
>   			return -EINVAL;
>   		}
> -		if (msg && msg->len)
> +		if (msg && msg->len && mchan->req_buf)
>   			memcpy_toio(mchan->req_buf, msg->data, msg->len);
>   		/* Kick IPI mailbox to send message */
>   		arg0 = SMC_IPI_MAILBOX_NOTIFY;
>   		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
>   	} else {
>   		/* Send response message */
> -		if (msg && msg->len > mchan->resp_buf_size) {
> +		if (msg && msg->len > mchan->resp_buf_size && mchan->resp_buf) {
>   			dev_err(dev, "channel %d message length %u > max %lu\n",
>   				mchan->chan_type, (unsigned int)msg->len,
>   				mchan->resp_buf_size);
>   			return -EINVAL;
>   		}
> -		if (msg && msg->len)
> +		if (msg && msg->len && mchan->resp_buf)
>   			memcpy_toio(mchan->resp_buf, msg->data, msg->len);
>   		arg0 = SMC_IPI_MAILBOX_ACK;
>   		zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
> @@ -640,6 +649,126 @@ static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>   	return 0;
>   }
>   
> +/**
> + * versal_ipi_setup - Set up IPIs to support mixed usage of
> + *				 Buffered and Bufferless IPIs.
> + *
> + * @ipi_mbox: pointer to IPI mailbox private data structure
> + * @node: IPI mailbox device node
> + *
> + * Return: 0 for success, negative value for failure
> + */
> +static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
> +			    struct device_node *node)
> +{
> +	struct zynqmp_ipi_mchan *tx_mchan, *rx_mchan;
> +	struct resource host_res, remote_res;
> +	struct device_node *parent_node;
> +	int host_idx, remote_idx;
> +	struct device *mdev, *dev;
> +
> +	tx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
> +	rx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> +	parent_node = of_get_parent(node);
> +	dev = ipi_mbox->pdata->dev;
> +	mdev = &ipi_mbox->dev;
> +
> +	host_idx = zynqmp_ipi_mbox_get_buf_res(parent_node, "msg", &host_res);
> +	remote_idx = zynqmp_ipi_mbox_get_buf_res(node, "msg", &remote_res);
> +
> +	/*
> +	 * Only set up buffers if both sides claim to have msg buffers.
> +	 * This is because each buffered IPI's corresponding msg buffers
> +	 * are reserved for use by other buffered IPI's.
> +	 */
> +	if (!host_idx && !remote_idx) {
> +		u32 host_src, host_dst, remote_src, remote_dst;
> +		u32 buff_sz;
> +
> +		buff_sz = resource_size(&host_res);
> +
> +		host_src = host_res.start & SRC_BITMASK;
> +		remote_src = remote_res.start & SRC_BITMASK;
> +
> +		host_dst = (host_src >> DST_BIT_POS) * DEST_OFFSET;
> +		remote_dst = (remote_src >> DST_BIT_POS) * DEST_OFFSET;
> +
> +		/* Validate that IPI IDs is within IPI Message buffer space. */
> +		if (host_dst >= buff_sz || remote_dst >= buff_sz) {
> +			dev_err(mdev,
> +				"Invalid IPI Message buffer values: %x %x\n",
> +				host_dst, remote_dst);
> +			return -EINVAL;
> +		}
> +
> +		tx_mchan->req_buf = devm_ioremap(mdev,
> +						 host_res.start | remote_dst,
> +						 IPI_BUF_SIZE);
> +		if (!tx_mchan->req_buf) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
> +			return -ENOMEM;
> +		}
> +
> +		tx_mchan->resp_buf = devm_ioremap(mdev,
> +						  (remote_res.start | host_dst) +
> +						  RESP_OFFSET, IPI_BUF_SIZE);
> +		if (!tx_mchan->resp_buf) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
> +			return -ENOMEM;
> +		}
> +
> +		rx_mchan->req_buf = devm_ioremap(mdev,
> +						 remote_res.start | host_dst,
> +						 IPI_BUF_SIZE);
> +		if (!rx_mchan->req_buf) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
> +			return -ENOMEM;
> +		}
> +
> +		rx_mchan->resp_buf = devm_ioremap(mdev,
> +						  (host_res.start | remote_dst) +
> +						  RESP_OFFSET, IPI_BUF_SIZE);
> +		if (!rx_mchan->resp_buf) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
> +			return -ENOMEM;
> +		}
> +
> +		tx_mchan->resp_buf_size = IPI_BUF_SIZE;
> +		tx_mchan->req_buf_size = IPI_BUF_SIZE;
> +		tx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
> +						sizeof(struct zynqmp_ipi_message),
> +						GFP_KERNEL);
> +		if (!tx_mchan->rx_buf)
> +			return -ENOMEM;
> +
> +		rx_mchan->resp_buf_size = IPI_BUF_SIZE;
> +		rx_mchan->req_buf_size = IPI_BUF_SIZE;
> +		rx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
> +						sizeof(struct zynqmp_ipi_message),
> +						GFP_KERNEL);
> +		if (!rx_mchan->rx_buf)
> +			return -ENOMEM;
> +	} else {
> +		/*
> +		 * If here, then set up Bufferless IPI Channel because
> +		 * one or both of the IPI's is bufferless.
> +		 */
> +		tx_mchan->req_buf = NULL;
> +		tx_mchan->resp_buf = NULL;
> +		tx_mchan->rx_buf = NULL;
> +		tx_mchan->resp_buf_size = 0;
> +		tx_mchan->req_buf_size = 0;
> +
> +		rx_mchan->req_buf = NULL;
> +		rx_mchan->resp_buf = NULL;
> +		rx_mchan->rx_buf = NULL;
> +		rx_mchan->resp_buf_size = 0;
> +		rx_mchan->req_buf_size = 0;

Just curious if this is really needed. If none fills that values aren't they 
actually already 0/NULL because that location is cleared by kzalloc.

Thanks,
Michal


