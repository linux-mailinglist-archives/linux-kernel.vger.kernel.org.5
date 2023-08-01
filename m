Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561BF76B9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjHAQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjHAQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:30:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E2187
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU7XjkwqgTFnAlsfNAiFZs8eNWmPfE/37IZiNQCOzUg9CJA3eFE4q3Pj2GDEGsEYa/eqDntExFwUnUemMMUbf/nZMFbd6vzUnj11kNgQ/w90Vq6mJ1kjKVuVm2csB83rwPy0idTMX/930MqoyMRVgyihOIUuu2LGDjQixq563SIG1CBwubPH6CUbaK/RGVzhJLUkyJIbgofIsHef6bS9PuDicz58+S0o/K+AfHF4Jm7dvjCDMZf2hKGHha3XEXQ+MPpTw4h19B2hfr8rc0J4McCI/kSSiV+/LHyxRvFYGSmJIOLBjrXcKbkawBr/LAU+dtKCRIcvJvEKikvHFD9HmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZKtNA5qvYnmlJUGgEzbB9Whhdf+9xnlxBl3LBoreUs=;
 b=JCoZ3rikN8A1BmaKeuOshin7I1FLx4+sOdlN8QwHf/COOjDrwZ959gU1FOICVOoAZpgIbHal3TYL8qsk8+ACKqoj+uJdD7fx5gZtvyMp4bH+EBRDtQadX2YUUQQBfCSdMuKTPu79eBtWXX9FcvTQslB/idEVeKBYVWy+aOE93mBnxKTEoemkEFoqB0xIYn43nuFsjD+FKCVb04N+rFvQiiRIfE67OHmNNNDSnVI1Ec2BSUL3W60zvwjJNERMIg4yjEkGWBBZ+WcOTuRmGPk8kni1VU7nfIvFWPsJns+PY00j1QGriXooG8pvmtGrCqr3NTqCUWba+vcvKhtCpQLzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZKtNA5qvYnmlJUGgEzbB9Whhdf+9xnlxBl3LBoreUs=;
 b=1Ugdbn0cjZQKUpzJ+XbRYqrrOIE7VDnVs9B47VmZysC3SXrlQFnIdK4thsszJoj7U1pDCo4nG2ZQ+JOCOEQbZl6ucopkWKmXkvTiLk2oNP/wqt+BInGZo5uWGlNcjsGXGAThw72+/MlG0+24qlYaUnzEuZyePQ7TxeUKsuJKfnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 16:30:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 16:30:09 +0000
Message-ID: <1a4e6652-2e24-955c-5332-da84cced68e4@amd.com>
Date:   Tue, 1 Aug 2023 11:30:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/14] virt: sev-guest: Add vmpck_id to snp_guest_dev
 struct
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-6-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230722111909.15166-6-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:805:f2::42) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cd28c7-9f75-4563-bbf9-08db92ac9265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRbIkMbrdbECv0bSqnJZTkavOZlDjAluaffUupKSylk2XxI2jF6y/lRTUymv3MFVwI2nD4gC0ohzv2ZzHPAUpJq1mvyy1Lp3zAXqK5i3BQ7azePlCo+SOJI8oPT2nq/WP5zu82Ap51vFbVvU3Fcm9tezhgetZ7/mGrFmbAwM5nO1B5GwoF5Golyj0WEYEyWHsFoNnKbvPI9eTmz9SXym3OLIcMcUdb43zH+rNnz5QnpSrwlF3GkIrB2/IqnkP+kwfROY/QOKqakT24S1LfBdNQv+Idl34aAsr9JFdUeoCI2TQfDXFhP4Zh8VdO+4Eae2bsDU5aehff+9zqXeu4TGy/ASm6PRs5vm2v/AbtE1YltX1fWfLYwijKvAU+SWPykCJ1Wbd5qYdLFyKQ5vCziJOk/IuaOFdW/D/O6SGJR0frKcrVGoUse97T/3PEEQdv1zGrEhsrfhIW5n2gAfnHy+tWYd+usZMZCL0XIJ9dfbkoCaKTuGITbxSIUkXac/jRWjTxfys4uaQQ319pTCB5buld5VrN3icfKANN5CdLyBvtXWiT07DeRU3QEC2U65GL8dh9N+nuzsiBh5bdmSMvTvbFtQDDNEr9XoNBNxmA3Iji+7PmDuUHpou7ZDpqT1fSgrJpuvVz8uI2yHDeO3F+/CrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(38100700002)(53546011)(26005)(6506007)(186003)(83380400001)(2906002)(2616005)(8936002)(36756003)(5660300002)(8676002)(31696002)(86362001)(478600001)(6486002)(6512007)(4326008)(316002)(66476007)(66556008)(66946007)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZnMndQd2FETnFXZXZWMURUM25OTXM0SzV4S0t2NzVYSFdYY053d3pnSUkz?=
 =?utf-8?B?YU9hbVZHbG5yaUc4VFFSS1N6NHRXd1RycmpJZDRFbUJRNng4NDZtZzU5TG1z?=
 =?utf-8?B?WDFPcDVVZ0xZbWdQcjc1aWhpV2IzVURPdVZPSkhoajBLMC9iU0F0SVJrTkNy?=
 =?utf-8?B?aSs1VXJGNnNNdFM2WEZNUDMyajQ5QjBCT09rT3JIZzg3MGJBUGRjS1lJVEo1?=
 =?utf-8?B?SnQvLzM4N1orVkllUmdYMmJmUWVINHE3Vkd3aXgxWDA4RmhwM2p5Uyt6VTVt?=
 =?utf-8?B?TDlJZkNGZG03ckdWa1FCN3BtM2NvUFF5cXFuMzlzYW1kd2NiNVBDT3BXY2cz?=
 =?utf-8?B?eTN5elpvMk9IT2dkTkFpUVhycXBrVkRqNlNwdWVIWDBDWVEvWmZZSTgyQWpI?=
 =?utf-8?B?UUVpRzNic2RlbjRSQkk5ZGx1cCtYQzVsVEZKeUZKQU5hZTUybGRRcW5DNjl2?=
 =?utf-8?B?dlR1TDZFMjJlbmhGTGpPTjJiWmQzWTY1YlZGZC9JOTFtREdaWVlNSnU4VFND?=
 =?utf-8?B?UUZGWGZzMWV4akNCYWFUdGtoYitwQkVmSlFUOTVwNi9WS21JU25QcFdrenFW?=
 =?utf-8?B?Z1B4WTZPcmVXdHpLRkdWbjE5NUVYU2FMcFVQbFVodkh1dUVFbnI1bW5zUDJK?=
 =?utf-8?B?cGI1Ym9aZ0x2QU9aRi9XNXdIUXpQQ3NNYTd4NnZGY3lDak9LeGVVZ1BtbCty?=
 =?utf-8?B?bE14eERSaGs4TC9vWUg5dDd5dmR0cmF6ZmNSYmNNNi9BcCtyTGtCOVI1dDA5?=
 =?utf-8?B?OHZwd0JNaTZuSVVxV0ZjMFJQK0c0SWlybmNjdCtBVXBTd2lpZU5teDVJTG1n?=
 =?utf-8?B?N3BaRStzbWFyMGxZNzE4Mk93blV4WjVjV0ZXb09oUTZVcTZZUHFMdjlya3Zw?=
 =?utf-8?B?emY4ZjVCb0hZUjZzRjhRWVlzOXlUN0FGZXdaYlBxellPbVZQZFdqRkpZek8w?=
 =?utf-8?B?QWxna1BRUlFrNHQrbGNyamZ1SUU5K2JFWXJzbWY3aTljKzQraDFkVEEyUDY2?=
 =?utf-8?B?ZzlKRFZnMnV0cmI4Rm1VbUNjMUJCTC96UFdyMHBEV3BUNnJCNmFZckZWc0w3?=
 =?utf-8?B?Z1RaZ1dlUnVZUEFyQUlrQTh5Qit2eFVkajhXZ21SWURrU2xQclY5aFpSOFRi?=
 =?utf-8?B?bCtoRE5wSkNjQkZiRFY3VnZBTkxHOVRJOTZDT0pZcUF6blZ4a0kvVzhtZkZS?=
 =?utf-8?B?dmRDa0ZUaGdsS3VkSENBeFhmSlIwb0E3YW0zNjljY2pQcDM3Rjg3Mmh0a1Bs?=
 =?utf-8?B?Z2RmQ1REdXo2ald3N29XbDBSdktxVjRMaERpVGpCZ01TOVVFVDhrWnAvbXcw?=
 =?utf-8?B?RGloY3JxZnN1djFEK0NMbjhrK1lYU2djb05UVkVHSVFkK0xaM1JjUnFJem9M?=
 =?utf-8?B?czEwdGZ6NURNZnFwOWtPZ0NrWldhQWJGWDJUQmF1ZGlDdDFaQ2NzdEEzNFRk?=
 =?utf-8?B?eXNrUk82dWJjNTc2Qm9ZbjkwTTV3cjBGNlQwS1NKV2Zmb2hWbGlmMGFIYnlP?=
 =?utf-8?B?VEkrSWRDc3VZMDlxaVdQS0NsSzdLSUtUSXFuL2hNWVFTc3MzREVKQzB1bk02?=
 =?utf-8?B?NFVDaENPYlBISzQ5ZzdQR0x6VTN0a0g3bk9VUjVOcWxzNU5ZRDZBZlN2OGNl?=
 =?utf-8?B?SHNRNXdYT20vNUVEajBYOTlEK1hHcmgycUtmMnhVUm16eXkyelphRWRiV1Zu?=
 =?utf-8?B?eFY3M2dVS0hzUXpQU3NyZllTYTV1cHFIQWsrSGwzT2I4c1AwMjNtcmhmT0Rj?=
 =?utf-8?B?TkJIcmNWME9mY0NFVkhLYVlac01IVW92NmZhQzV2ZjFBYUFsUU9rZVFkZVdV?=
 =?utf-8?B?UmMzNGx2VDJEeGFuelFjUXR4ODJqNUZSUEpYc2JyVnZka1ZCeGw3V2NPN0VF?=
 =?utf-8?B?MmI3NWd3Unl3ek1QaXo2T2gxSy8vTG9HaGFrNURuemRVLytXbU1qelczRENY?=
 =?utf-8?B?Si9ZS0c1ekt5TkFPcDQxSUR5U21QakhkSFppc2dWV2NyVGFOd3VkSVJhQ1pR?=
 =?utf-8?B?bHVlZUhOT1dTeXR2V29YV2pFUUZRSm4wck5vZS9saUk4L2xYL09BaHcwTFJS?=
 =?utf-8?B?Z3lvV0lrbVJIUzBTTTNlUS96WjFhbmdrZFFSVE5Vc3UxSXpIV0tubU5nZVVp?=
 =?utf-8?Q?Q5bvWE/KHEjYt1vQtObMxW1Lm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd28c7-9f75-4563-bbf9-08db92ac9265
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 16:30:09.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elqDveJdyYvyJo4Qyokh5Fq184CQ3R5QXBZpAjhPzr1S/tMTL5Jj9PtyPbE1vQseCHsUAU1jHGVOWF0/nMzRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/23 06:19, Nikunj A Dadhania wrote:
> Drop vmpck and os_area_msg_seqno pointers so that secret page layout
> does not need to be exposed to the sev-guest driver after the rework.
> Instead, add helper APIs to access vmpck and os_area_msg_seqno when
> needed.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++------------
>   1 file changed, 43 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index d4241048b397..8ad43e007d3b 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -50,8 +50,7 @@ struct snp_guest_dev {
>   
>   	struct snp_secrets_page_layout *layout;
>   	struct snp_req_data input;
> -	u32 *os_area_msg_seqno;
> -	u8 *vmpck;
> +	unsigned int vmpck_id;
>   };
>   
>   static u32 vmpck_id;
> @@ -67,12 +66,23 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>   	return 0;
>   }
>   
> -static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
> +static inline u8 *snp_get_vmpck(struct snp_guest_dev *snp_dev)
> +{
> +	return snp_dev->layout->vmpck0 + snp_dev->vmpck_id * VMPCK_KEY_LEN;
> +}
> +
> +static inline u32 *snp_get_os_area_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	return &snp_dev->layout->os_area.msg_seqno_0 + snp_dev->vmpck_id;
> +}
> +
> +static bool snp_is_vmpck_empty(struct snp_guest_dev *snp_dev)

I noticed this name change from is_vmpck_empty() to snp_is_vmpck_empty(). 
Is that in prep for moving, too? Is so, maybe call that out in the commit 
message.

>   {
>   	char zero_key[VMPCK_KEY_LEN] = {0};
> +	u8 *key = snp_get_vmpck(snp_dev);
>   
> -	if (snp_dev->vmpck)
> -		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
> +	if (key)
> +		return !memcmp(key, zero_key, VMPCK_KEY_LEN);

I believe key can't be NULL, so this check isn't required.

Thanks,
Tom

>   
>   	return true;
>   }

