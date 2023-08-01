Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0338976B8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjHAPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjHAPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:34:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E030BF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0GOPjQi23oikhaEOARI7EYQLm7RfOeiS4BCXkbY4EdvDx/v8N/l24vJbB0yhaIjunC1rfJS1PC9o8mojD/te6uVc6wVFef9GR7Z93T5RLFQqoqtAUoss0+o0qn58mL6YcLM0lLNMykZuwWab0OPWBIuIjOh8txsfkgoIF/XVy/1zltx5LIBBOUpR1OrrJyfxbXxMNzaoJg+SMJYn9QoARgqEf5qVIWz47TnY9dpjgTZLZrkattF+rEj7iOp4aGd28tQKo4ri/+rJb3k5ThIRirN7MQoVfaUmilAzPbjFzkvjwy6JA3Q0sNjyq7rFS/FBzrqdY7/u4RqwRRtrzPEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kpzv1wrpWkh5IVa0cfIwuegB7I3M4z2l+blU8XnwZTY=;
 b=Laa6P5jU6Jn7m8agE1kSjscpthZFTitRE6UZZGUs3Fm1LEg7YF3TI1EJzs+t+/aMbCIp0M/6Thnc3b9xsD2z8ZX96GdJBE/pyv00dSzLkZkhikdZGtgBkJumF3cJwkietG9WSVVsxgPASGk+2PNhrCwdPPPqS24wtAMcGOohoQ4r6+3VynDnCKitGh5zDJ/QSfHPotgcgvsJS/P2dqBxzuq6IRP2Ypse4cK8ew89ZYkruJhQyFFrugqIdTUmRp+9FUin3hy2D2Li8HKc/+wSefCKzXBxGDAIE/YZzi3ASY0iB/TSC7K+Rrei4UDrrV6yScqg/SuLiT3k1bUZeS5LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpzv1wrpWkh5IVa0cfIwuegB7I3M4z2l+blU8XnwZTY=;
 b=v3ejpMqvol3vdrg5GW3H53TWibTWOYOotguvG+QubddGNRfxGLxa22rYGpdyUU+6zpuxV00hAfmdbcnYzZbpVYVcnyXizNZeWUtEHte8oVUQtdzPRGJA6Aq/+8fJCR2i25AlNWFtIMUv41cDtLnsPvEB9ch9Ti9//3sGRFQ8/00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 15:34:33 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 15:34:33 +0000
Message-ID: <e738e3f8-4984-a7cd-05b5-006d73cb0cf0@amd.com>
Date:   Tue, 1 Aug 2023 10:34:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/14] virt: sev-guest: Replace pr_debug with dev_dbg
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-4-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230722111909.15166-4-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0069.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f6a227-06d0-41b7-66e3-08db92a4cdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNRf2g36d7Aera3DXygs3rqYme5+WfLto38KvVjHfU6dm78eC5VAiSU9vp9S5CS0iVM8QfkdAR/T25BCcPM7jSBRBdsOT9aga3QJ4jm+4XxeekTC3J30GVgpnKJwdocOR6WHp20aSkoWzSpnMChyhg0fxYmdSUUC5JVw/tAQ4D3LZ8AoLld1eMwLdM5t43bTyzE4YgrS4ILJqBbB7q5RUMY358kucI+HopRG+VRdK6VXqi75PBsIe7NAAfDyj2ZnCFpNp9oLPocbuiMA8QxY+0axWG6fEbZMknruvYwE9oWa+3dN0OzitZu1Txx22PECRzt6AHvfX+VkrEuLZZJQ9lRUxjmTjwxXHyhOIgSH/FUxscdv0UZqqTqXQr8SJq8eQ/eRb3CcGE0EX11AA1cE1ubOrN5DMuY5SLgYY4BAGuZKKaeVNfsKYi2R2Ike/C6TZWRNfkO9YJh8shLUaTmyciHSvqrCg1ekv7fdJVIVgRLHSQqlIse+A+es7ox2cRSj/xFR6QDI44THKMaro7Xm+PNq/83bPEVxfkvQv7psmC+WrtglncXCl65f2vzsNlVu8WvQ+XjwtJI161+fN/0HsSxrjniqAVyYOovfzTG9TAVWIh2/kwYOZgpUTvFzkD1kFyo64ArQri3y7B4D64ZWfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(86362001)(31696002)(36756003)(2906002)(31686004)(8676002)(83380400001)(26005)(186003)(2616005)(53546011)(6506007)(478600001)(6486002)(6512007)(38100700002)(5660300002)(316002)(66946007)(8936002)(66556008)(4326008)(66476007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtxQTV6ZDN2QUsrK2RGQ29aMmgwS2RvL3pjaUJqRUwrQnA2YjA1cGZHNURP?=
 =?utf-8?B?eG1scjFLZm5kYzdXU1RXWXpvQWR4TmFuYm5ydGd0OXdLMWhIYVUzQU91UXkz?=
 =?utf-8?B?dnMxY2RZckdsS0tBV3BLY01nZHB4S0hhcS8rN2ZvT2psTXYyNmw3TGkvT0tP?=
 =?utf-8?B?TVhhTEgxczR0ci9oRmNMWXlCcCtZMlkvWW94M3FKeVN3aGwyUTNDVTBUbk9J?=
 =?utf-8?B?NDhKQUxkcFNHOXdSbDljUFUyR0FaUmsrM1JBRmcwQzRZK1Q2T3o4Qk1EbzA1?=
 =?utf-8?B?bXZLeGpwNXVoWE8wTDJ5bCswbm54T0xHSHBZS3pMdjlGSVVlMTcvUHh6QWpp?=
 =?utf-8?B?TzlJbm0rN0hqemxDcmR0bW5uajN2dWl0Q09qZk5rb1RCbytQVFJjNVc0VVQ1?=
 =?utf-8?B?MXRKMHhHSVNSWWJrY3FTeXFDUEpRbE9sZXpVYnpwVlhaczVlRmZmYnFCRExO?=
 =?utf-8?B?Q3pJWmY4K3hYMU1hTDdJTmd5bTNBTlFvaXYvR050ekprSGRHbEduMGpNRE9Q?=
 =?utf-8?B?MWFHbm10MkpsSW56eVlVQS9zSUJBbDRCVktXSmtNSi9RYlRuRjhvdWFEc2VT?=
 =?utf-8?B?Si9Oc1ZiRGhlNTN6Y0hGUkVrb3JNMzhMMko1T0IvZ2M3cU5pTTV1emVZRjNS?=
 =?utf-8?B?Y2dsSlBWT3duYjJZK0FiaEc0eVRvWWlVc3ZDMVlZdDNkRWU3aUloeWxUQWJY?=
 =?utf-8?B?QjZSdkRtRWpxcjNtQmpwK2R6d2pUazZHQ1VsMkxjN24rWEVlSWRGV3JBRDh1?=
 =?utf-8?B?blREQVFpS0NERmh3R21EY3dadW5raFdhODRpVGJFbCtQdXpiUFVCUjVKYWV1?=
 =?utf-8?B?bU1XNnJMWjlqekJ6ZC9lRU85eldJY1lqYjFOY1M4OWRueTdlYkJvWDY0UUJt?=
 =?utf-8?B?QVpmN3NtSHZRV3hLZ09Xa0dQZnBnQlQ0UGQ1ZC8wd2FSUzZ6NGQ3c280TkUw?=
 =?utf-8?B?dkVNNFNUYW1rY2VOUjJlUUQ1ZXl6VFpnQTRLalVSNnFEcXkzVnh5SWwxVzdF?=
 =?utf-8?B?NWZZRVU5NXRZN1pSdncvN09kTFF6KzBkUGtic3BsakRxYkFlTnF1b0wzN2sv?=
 =?utf-8?B?Zmp3eTRsVDFYYjVwd2dkYTRxNUxOREtmcW5WdUM2ZGF4aEY2cDBPU2trYzlO?=
 =?utf-8?B?Q1RsT1NpbjBvcXQvYlE3cHlrZlJiZWxYYklwVGR6bXR0NHJCS28yeTFEQTJl?=
 =?utf-8?B?RXFrL3lYcUVsUEFMYjZoZnJvSkJOY1VnYkhlVi9vMitTdHE3Q0lYbWRmdWZU?=
 =?utf-8?B?TzhTOUpaY1ovRnhjaHl0SjJkam9oODRUcFI1K2RvbE9nREtHQmJOeHg0MmQ4?=
 =?utf-8?B?cWRiRnRZUDZoZDV2alB1a1RBT3kxUXpMeWNqR1FFNGZicSt3VVdnUi9QRVE4?=
 =?utf-8?B?WTREUTZrTEwzVjlVekpxQys5bGhRSS9YN1lMK0V4M1Rhb3FNQzJPMFYvdktu?=
 =?utf-8?B?eWhPaGtVZTBjYXkwKzNtMDVWTHNodHlkVUxPV0p0V3MwMEpyR3RieEFDdmNJ?=
 =?utf-8?B?MVBwNWhoQitHRGIrMURpTDFKdE9VQmlTZGg2L2RQczVqMlB5dFZVMTFNMnBi?=
 =?utf-8?B?VXhRYXJoczdMeHFLM3JXM2ZjSzJIWHZhL3MyMG9mV2NJNkdmNVVxS3lwYTJl?=
 =?utf-8?B?SlEyd0N0b0FUNnhMcjBkRGw4QlZ5V1ZkMVdIN0laWE1ZaGtDZCt6RFpUWTVS?=
 =?utf-8?B?L0tZZlJSUVVZWGg0T2hnWFA0K2x3Yy9MT1NhbVFQVzdqUm0yS3hDOUpYYVJF?=
 =?utf-8?B?K3d4di9xTExKcnZ4Y2tkZUVRSG9iaUJQUmczMExRYUtDVWdRVEtNSGtjcS9t?=
 =?utf-8?B?Wk1aK1BROUpKV1k1NzVmbnlQR051ek1xMExuL3dYSFNTWG9tRnRXak15YS8r?=
 =?utf-8?B?eTlyWkVFaWpvVXZQR0w3eHlSOWZxUXRWVUVQL3BXQjVUMXBvNlNoYzRGbHkr?=
 =?utf-8?B?ZHZiaEhDbUkrL0lhbXVINDB0cTFUenlxYkc2OFNPcHNvd0h2OWZBNkJSNnZa?=
 =?utf-8?B?VkJsZGpmbEt5RzVac2I1a1pNdUNwd1hFazErelREcUNjR1ExdFZRUWR1cTF5?=
 =?utf-8?B?Z1lsTFFuN0tHTDJacTNUMm9ocGNwaVJZTGFxSUJhNU9jUTdYZllPZFFWZ0dj?=
 =?utf-8?Q?YKDeNdrJyw7VTiKlI/9c+mUoN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f6a227-06d0-41b7-66e3-08db92a4cdf3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:34:33.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsrwn7vCBUeE3gFVt1Imqamdrjj1kJLCW68IejpGBQRNAUedAiLrFlVjXW/SQXAkV8X9ToN3xmhe0/37OzOEfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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

On 7/22/23 06:18, Nikunj A Dadhania wrote:
> In preparation of moving code to arch/x86/kernel/sev.c,
> replace dev_dbg with pr_debug.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

The subject is backwards, you're replacing dev_dbg with pr_debug. With that:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 8ba624088d73..538c42e64baa 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -206,8 +206,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>   	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
>   	struct aesgcm_ctx *ctx = snp_dev->ctx;
>   
> -	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
> -		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
> +	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
> +		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
> +		 resp_hdr->msg_sz);
>   
>   	/* Copy response from shared memory to encrypted memory. */
>   	memcpy(resp, snp_dev->response, sizeof(*resp));
> @@ -253,8 +254,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>   	if (!hdr->msg_seqno)
>   		return -ENOSR;
>   
> -	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
> -		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
> +	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
> +		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
>   
>   	return __enc_payload(snp_dev->ctx, req, payload, sz);
>   }
