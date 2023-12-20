Return-Path: <linux-kernel+bounces-6952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B838819FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF99F1C2313D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBC2D636;
	Wed, 20 Dec 2023 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEtZ98E9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400362D61A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhT/2DeqvxnpEy40UzpSvVckwqpGb8sbKGDLJ9BadudebSQmPhDn6ymjorRTHvBAVKXOJbfsqi0IoRG8KmcPN30g1Krg1tDl/PWRzPgYeYjT1zgODL1KnzQlo1/IvpdpTr6SzSj/+f4cvSZ18s5tI1i4CWcIvq2zlJGUHEGVIF1/c9h7Pdq9Ui2Ez1LKF+kFiQ84jF3fNkZdLemsyl8cQeL5GQfgfPxZG3stHwJaerQWFl/knQlyEjVFtPn3bRkrSxWzgWglMNBnhqiYGQFOOOBxb6HmVTwPLZCFNReJMx/AAyL8dMfeOwsMdlYwMJmtnUNQC46ouQZNFs5tgS53bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBacsGFXxnGeY9+IXlrI66kwLEDXwsZN+eW4dW5f8uM=;
 b=lh8VzRHxCIdqTPFv0t6zct9VU8yVviDRUVDq0QBBghgSZDLzqn6ViKQvSz9SmZG/LxUnnXY+EFAZW9rjzxVEgJ4oHjCpOczFUxvi1+yufAOPk04fvnY6EzoEqac0oEWXs8qvHg8b7ocXyhq4LmJewbkr2Jagy3yGCoW0C+v1NHEZ1JmPLzqA74VpGsMa9r2L2tgFCCs2B6lQ1/b8YcbiIbVf4udLDimWChNzpl3x2UvTjSbMTJI6dV+eoqo+3tNWANVK8pRnv5SnxeOnAqhN6VB/kdVDSciDS3A4pRxBx49JFxkIaoDAdxnTY7Ia3yzaUEjIiwZlV5tK05ZCTr7+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBacsGFXxnGeY9+IXlrI66kwLEDXwsZN+eW4dW5f8uM=;
 b=UEtZ98E93rAipc1fCMd5jm+of7PPKyaJZzxsgGu+feCzhvVbtiNaHHcKcQcVAX8XI7XMdT5bKSnDEpjNZ9QeZezpa3y42i6RYBCNMoQiOFtBEk/PqX2Idql7mVUqzA922uvuVCFqQAW8FeXEaIA80uFiSMzD/3tnm1k3lEKePE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Wed, 20 Dec
 2023 13:23:49 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 13:23:49 +0000
Message-ID: <c7ea6fd6-b4cd-45e5-b1b0-12c8e2aa8696@amd.com>
Date: Wed, 20 Dec 2023 14:23:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mailbox: zynqmp: Move buffered IPI setup to of_match
 selected routine
Content-Language: en-US
To: Ben Levinsky <ben.levinsky@amd.com>, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
Cc: shubhrajyoti.datta@amd.com, tanmay.shah@amd.com,
 linux-arm-kernel@lists.infradead.org
References: <20231214211354.348294-1-ben.levinsky@amd.com>
 <20231214211354.348294-3-ben.levinsky@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231214211354.348294-3-ben.levinsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::39) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: dd26f20e-3b73-472b-e4e7-08dc015ee6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P+rGDlSPG3VKhKVIxJc1YU6s3D9892kahU65M/0hP4MmqNj43xr+l+5b5LV5ttG0bzoopQH0v2nQ+4vF36IqErXu8f14Ol5VqoPy57W/8KVwDRkwARWSIj2SWvpi4KALhrabl9MMJn7wYv1xF3kBYh13F5f1/xzxwDfFKoDIgRUwO6ev4cG5cTVGWbin4CaR0O/fla0rS92vxjCBijlqh8npb85vrGvicLwcuPiJwL4Coma9nqd4CoC+2lq5+UsMfu6h51hPBYScWcUwfyVLAD2ZPhRqhE08JiYe5qcNJTyeL5xYQRdszF1hgnzIF1MwkPtJGX8LqRXLqOWPj4MgSjXuQ/FaPRjv902FqY0mv05Z1oH3rWorav89oqrLFLmy8hp10QgvNk+6TwqPJvgSQ/hyjCeV2Z8duw+LqqgjOH3PUh/eqTuS03sCz50jtPaCBS5mA1jMaFX2tcFZIdSPmZ3ko0Tr7cJ8Of20unBHmNNClQKgeVllPgTn+54l/vpAd5aViyBXBfDGDN7Ea+Mbf47sDYRidMmeN0l4kbV3LrnmEbm8ZFvQhMj/zkJ6rYHXMTP2nZxt3MF9rekJ2lyCWznOzY8Uo9EqV14EpsCV+F+q+yY1dRiU0nwnIwaUjJYuCcX5xyn0e8cmsOsaKAHZEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(6512007)(53546011)(2906002)(6666004)(6506007)(6486002)(5660300002)(83380400001)(15650500001)(4326008)(8936002)(8676002)(478600001)(316002)(66946007)(66476007)(66556008)(41300700001)(38100700002)(44832011)(86362001)(31696002)(36756003)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjdpU2VzaS9JUUtSRHhSYUtSQ1ZuV3JlZG1TM2pESUtaZitNNzNLODlaRE9x?=
 =?utf-8?B?NDh1ekVVM21iNU1EZnpjTnEvYWhOYmRHUzlvVHFLMmFxbU1zUHlOYmV2NWxK?=
 =?utf-8?B?SEQxQ043akpvVXFoajFxdmRmRzhYNDA4dkprd3FZQlh0R01PdnlKWnlHc2lq?=
 =?utf-8?B?ZTd2MktTY2tGWVlqakhFOGN2WDl3d2JVaHVDc1ZHdmZXTXdxL0lkNnZna0E3?=
 =?utf-8?B?dysyTnMrNThNSTYyc1hla0svMlpUTmQrc1pzejNITFFnVFk0Y1V2QUhrWnB5?=
 =?utf-8?B?ZzdSRGJ1cWtLYXZvN3VHd1BORDZUU0dWdGk2aHFZeXRjaGJLemthYlYvY01O?=
 =?utf-8?B?M3RnWWl0bHp1QjFBRUVWNGdSMnR4NVd3Njk0eFNwVE9udEREeVlQazdwdFpY?=
 =?utf-8?B?eUdYamdRUi9OYTMxWk1NcDBla0xOaFlLOHN6NjU3Wm1LTm5vS1JKMXd3QkFs?=
 =?utf-8?B?VHlrRnV1TGw1ZDFiRWxGSWlvTGtDYmUxU2h0SVpPZHprUCtYK3FNNjN3L25W?=
 =?utf-8?B?Wk5sRis4WlNBejhYZmtvQW5JUllDTHNrcjNMczRQRXQrWFpmeTNmZ1V5L0Fu?=
 =?utf-8?B?dVVNOVlQQjNZRzVCOHlOM1l0T1JoVHF3TDZuYlVCSkE0WWI4NXdWeWl3bHht?=
 =?utf-8?B?cGZwREpwNUdUNlM4SmlhK3pIaC83ZGhZcXhjbEpoWUpqWmlybnIxcEZna2lX?=
 =?utf-8?B?alQ4T2pXVVJrTy8rNGllZmw3NVNJN0VBTTE1N1ZJVTQvQ0ZNcWlmV1QyU21i?=
 =?utf-8?B?eHFkZnM1aTlPVnFWSXA3bThka0h5elhsMFpzVzdYNVdMaWRleGlpSTFTZ2Jn?=
 =?utf-8?B?TzRvTWxWc1BtUGF1SXJKZWJvcDBydnFmcVZoVENFNmJOQmc4YmtBd09rZTd2?=
 =?utf-8?B?cS9ySUxoSzVHaGlzVSswTEdJSTcxZzdVMmdVR0lDR3JGekVZRm44QU1BcGZG?=
 =?utf-8?B?QS9lWjZBdTV0cVRDUTZWRkgwWHdpY1BOTFhKYXN4TkFpMVI4djBYVDEvelp3?=
 =?utf-8?B?UGpCbEFmR1VuaEVBbGRONisrQ2duVVF1cWdicm9KV1JPNDk5R1EyN0U2TXVG?=
 =?utf-8?B?QWRjS2RsS2FQN1NabkpXQkY0LzAyUDBkOWs2OFNMVEs2ekV6VFVlUUNCclJn?=
 =?utf-8?B?QXRuSFU0d2RxZDhkejVvV014QjRCMGNKTm0rZE9uSEpUelhHbGNnYXFBbldV?=
 =?utf-8?B?V2lha203bHd1STlud2xwY3Z5M3N3VXZneUUxMkZRWDVkNXVGWEdOVkRzZG9a?=
 =?utf-8?B?NlFLZnBHWEc4ajJYM053QlA2a1FvaDZhNlBzYjV0MGVOWEFMbTZVanducmV3?=
 =?utf-8?B?MjFEWU9QUlJaU3FEMk9lUnRrOTE4QlZTU1JRVTlXUWJqYUpQM2IybEt6Tzhi?=
 =?utf-8?B?TmU1Z2hPYW1rbWsxbHRRQ1VGamN4UVV2WXQ2SkNKWm5NeGxOU2FycGJzTkRI?=
 =?utf-8?B?KzlSb002VE9ZRGNDa3pOSzNoUFFiZ2lkM0pQVk84bjA0anBRamFYVHl2ZUFy?=
 =?utf-8?B?YmFpZC92TnQ4QXJkRm1seHZyaXJsZStjb2pheWRLcGl2Z2hEU09sdUgrUlV2?=
 =?utf-8?B?Tm8yRTBlTjhGYWQyazhNVFljTXJKanNGTTh1a09KbS9ydERWcEQ1aWpYbTlh?=
 =?utf-8?B?RUc1ZExWRDZMcE0wQ0h6V2tJQ2JwUVkwbEo3NU5HRjhWSlA3dUpNVXE0WVJq?=
 =?utf-8?B?Wnh3cncxRVMrRzEyeWxQSnJ3UFE1dmRORmtINEtRSGVXbFI5ZG5rUTdrNDh3?=
 =?utf-8?B?YjhKNzUyL2tKQjFoRjFRREkwaytTQVVFNjVEUWJ2NDhPUXl1NEhndW02V3dq?=
 =?utf-8?B?dTk5RjNFVktYZUNiOFdVM1FEaStLM2FUb1FpZ0V6RHA0NnRNTk1UV05HSjRi?=
 =?utf-8?B?S256cUt3c0dnbkRrYmovWWhPcjhxenpHdUJNUUswcmh6RGc2bUUvY2Z3eU81?=
 =?utf-8?B?dTdxM0VIaVhNbUN1bDlvSlpnTUhHVVN3V2l5cDNqbFdOM2thNzFiejZlSENI?=
 =?utf-8?B?TFBYejB6VGRhem9ad2dJVFRiQVVOUUZERDB2WjMxaE5OUmhnTlgzRlVUMWNV?=
 =?utf-8?B?TWJhT015WDYvOEhDUHNQM1FQYndMUk0xMFpDRDhnOUcweDc1MTUraEljS0Ri?=
 =?utf-8?Q?kQTNh2vOO6bz+/n0jDIJmqcvE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd26f20e-3b73-472b-e4e7-08dc015ee6b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:23:49.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXr0BIEBjb4GxzQOV/jK9sw1F/IF+y8tZRfpxO0w38lW50VbXEqBicTfJswO+l0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195



On 12/14/23 22:13, Ben Levinsky wrote:
> Move routine that initializes the mailboxes for send and receive to
> a function pointer that is set based on compatible string.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 124 +++++++++++++++++++--------
>   1 file changed, 89 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 2c10aa01b3bb..edefb80a6e47 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -72,6 +72,10 @@ struct zynqmp_ipi_mchan {
>   	unsigned int chan_type;
>   };
>   
> +struct zynqmp_ipi_mbox;
> +
> +typedef int (*setup_ipi_fn)(struct zynqmp_ipi_mbox *ipi_mbox, struct device_node *node);
> +
>   /**
>    * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
>    *                          platform data.
> @@ -82,6 +86,7 @@ struct zynqmp_ipi_mchan {
>    * @mbox:                 mailbox Controller
>    * @mchans:               array for channels, tx channel and rx channel.
>    * @irq:                  IPI agent interrupt ID
> + * setup_ipi_fn:          Function Pointer to set up IPI Channels

Here should be @setup_ipi_fn.

>    */
>   struct zynqmp_ipi_mbox {
>   	struct zynqmp_ipi_pdata *pdata;
> @@ -89,6 +94,7 @@ struct zynqmp_ipi_mbox {
>   	u32 remote_id;
>   	struct mbox_controller mbox;
>   	struct zynqmp_ipi_mchan mchans[2];
> +	setup_ipi_fn setup_ipi_fn;
>   };
>   
>   /**
> @@ -466,12 +472,9 @@ static void zynqmp_ipi_mbox_dev_release(struct device *dev)
>   static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>   				 struct device_node *node)
>   {
> -	struct zynqmp_ipi_mchan *mchan;
>   	struct mbox_chan *chans;
>   	struct mbox_controller *mbox;
> -	struct resource res;
>   	struct device *dev, *mdev;
> -	const char *name;
>   	int ret;
>   
>   	dev = ipi_mbox->pdata->dev;
> @@ -491,6 +494,75 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>   	}
>   	mdev = &ipi_mbox->dev;
>   
> +	/* Get the IPI remote agent ID */
> +	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
> +	if (ret < 0) {
> +		dev_err(dev, "No IPI remote ID is specified.\n");
> +		return ret;
> +	}
> +
> +	ret = ipi_mbox->setup_ipi_fn(ipi_mbox, node);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up IPI Buffers.\n");
> +		return ret;
> +	}
> +
> +	mbox = &ipi_mbox->mbox;
> +	mbox->dev = mdev;
> +	mbox->ops = &zynqmp_ipi_chan_ops;
> +	mbox->num_chans = 2;
> +	mbox->txdone_irq = false;
> +	mbox->txdone_poll = true;
> +	mbox->txpoll_period = 5;
> +	mbox->of_xlate = zynqmp_ipi_of_xlate;
> +	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
> +	if (!chans)
> +		return -ENOMEM;
> +	mbox->chans = chans;
> +	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
> +	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> +	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
> +	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
> +	ret = devm_mbox_controller_register(mdev, mbox);
> +	if (ret)
> +		dev_err(mdev,
> +			"Failed to register mbox_controller(%d)\n", ret);
> +	else
> +		dev_info(mdev,
> +			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
> +	return ret;
> +}
> +
> +/**
> + * zynqmp_ipi_setup - set up IPI Buffers for classic flow
> + *
> + * @ipi_mbox: pointer to IPI mailbox private data structure
> + * @node: IPI mailbox device node
> + *
> + * This will be used to set up IPI Buffers for ZynqMP SOC if user
> + * wishes to use classic driver usage model on new SOC's with only
> + * buffered IPIs.
> + *
> + * Note that bufferless IPIs and mixed usage of buffered and bufferless
> + * IPIs are not supported with this flow.
> + *
> + * This will be invoked with compatible string "xlnx,zynqmp-ipi-mailbox".
> + *
> + * Return: 0 for success, negative value for failure
> + */
> +static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
> +			    struct device_node *node)
> +{
> +	struct zynqmp_ipi_mchan *mchan;
> +	struct device *mdev;
> +	struct resource res;
> +	struct device *dev;

nit: you can put it to the same line mdev, dev.

> +	const char *name;
> +	int ret;
> +
> +	mdev = &ipi_mbox->dev;
> +	dev = ipi_mbox->pdata->dev;
> +
>   	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
>   	name = "local_request_region";
>   	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
> @@ -565,37 +637,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>   	if (!mchan->rx_buf)
>   		return -ENOMEM;
>   
> -	/* Get the IPI remote agent ID */
> -	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
> -	if (ret < 0) {
> -		dev_err(dev, "No IPI remote ID is specified.\n");
> -		return ret;
> -	}
> -
> -	mbox = &ipi_mbox->mbox;
> -	mbox->dev = mdev;
> -	mbox->ops = &zynqmp_ipi_chan_ops;
> -	mbox->num_chans = 2;
> -	mbox->txdone_irq = false;
> -	mbox->txdone_poll = true;
> -	mbox->txpoll_period = 5;
> -	mbox->of_xlate = zynqmp_ipi_of_xlate;
> -	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
> -	if (!chans)
> -		return -ENOMEM;
> -	mbox->chans = chans;
> -	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
> -	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> -	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
> -	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
> -	ret = devm_mbox_controller_register(mdev, mbox);
> -	if (ret)
> -		dev_err(mdev,
> -			"Failed to register mbox_controller(%d)\n", ret);
> -	else
> -		dev_info(mdev,
> -			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
> -	return ret;
> +	return 0;
>   }
>   
>   /**
> @@ -626,6 +668,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   	struct zynqmp_ipi_pdata *pdata;
>   	struct zynqmp_ipi_mbox *mbox;
>   	int num_mboxes, ret = -EINVAL;
> +	setup_ipi_fn ipi_fn;
>   
>   	num_mboxes = of_get_available_child_count(np);
>   	if (num_mboxes == 0) {
> @@ -646,9 +689,18 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ipi_fn = (setup_ipi_fn)device_get_match_data(&pdev->dev);
> +	if (!ipi_fn) {
> +		dev_err(dev,
> +			"Mbox Compatible String is missing IPI Setup fn.\n");
> +		return -ENODEV;
> +	}
> +
>   	pdata->num_mboxes = num_mboxes;
>   
>   	mbox = pdata->ipi_mboxes;
> +	mbox->setup_ipi_fn = ipi_fn;
> +
>   	for_each_available_child_of_node(np, nc) {
>   		mbox->pdata = pdata;
>   		ret = zynqmp_ipi_mbox_probe(mbox, nc);
> @@ -694,7 +746,9 @@ static int zynqmp_ipi_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id zynqmp_ipi_of_match[] = {
> -	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
> +	{ .compatible = "xlnx,zynqmp-ipi-mailbox",
> +	  .data = &zynqmp_ipi_setup,
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);


M

