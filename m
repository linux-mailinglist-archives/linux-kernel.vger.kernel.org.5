Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95376B907
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjHAPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:49:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A71AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR81Yg1ymgr1x5xVR32q8jmxKIdJw2eQxhzhHzS8cuyCcAUguWUEOr+6wRiUpnjcPtJ9IYBcD/zL8DcnB+QIrxStHBoZQH1/LNOrJm6Kodg3lT9lHRHRHwKgbUIPu6owzYPlChUrJCWMG9BDR4iV/SoQGT2Nt+ZdkPkfxoiyhQuV/IqQYLheRHSD5ixnAWQkFdGoMuSH64xMGEETy1ylzdnvNwg3myWYiwaMKDTVKeyPfMAbvoKFH7Bf54yIe7oG52YbBZhTzDRRdBHB7mwH/VcFKEFlP2y2AYTJ6UXuX+MoW/aNKU2FhrfS8/mFXwr20H4hS7zbnGpDfEK493wXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YYiLjhZ3u/G6eUgRvk2opRvrmQoWLZwecIJDJRMLNg=;
 b=P7DkTBkGqSIBLSaXJP0z1DOiiixIIdcRGoFVFWZqMWKAZ9tuAwbGcapix41AAUK1bCyEyfR2LNyVdlu7Bn+SpFQ5XArR7qL5Rf4OSMMDEat67kxdJe5GAW6KTTjsI3dmRYnAMPNVGfM4LMBQ1zrXGHzxdTR1c4myFWlM3ZbpjhjTQd5ZGCwx8+GrEtXoICJ2nqrP7lIGK6Etzg9N8YNidLOSvqH4nzIyzmraqgZOCRRn/7pcxAVbuPaqC/KnXDxzONiYec8he+4FgsYj6/7jQLK2LdtrJ8pJQMhmMqjjrV9Ne0zAc81+Aoihp8DDpU899m+3CDcU8Jfib35f/rdhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YYiLjhZ3u/G6eUgRvk2opRvrmQoWLZwecIJDJRMLNg=;
 b=olJ60YZ2I/UanG5gO5dUD+Q9+YtvtcCgjsNVwQhJED1bnANgKGvw4oaByjR8Ecn+lVpz16uRRjAbqO4iB18PNNeXyY0C3vIwLtfnRupyshVAvLBP/Vq0UY6mCDUkbSk0U6S9q/564guZM/1u+6V/pTQ3fNkKwfMlKswK+WH3fFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 15:49:42 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 15:49:41 +0000
Message-ID: <b01a4948-0632-f899-2357-3bba6bc358ae@amd.com>
Date:   Tue, 1 Aug 2023 10:49:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/14] virt: sev-guest: Add SNP guest request structure
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-5-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230722111909.15166-5-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e84a85-9529-4069-ff4d-08db92a6eaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B50WEWR3nlp4i63K7XjBP9kw+pn/mYih47tO+lY2I/xFmcOwnbcleeuC5BuDtYUNFKTjGcdb7hcEtGZIRzktuu1dtp7nLwxZ1Ut8nMlcHjPOhreZGakeXxhhvSOMlMXXwq3Z4hCVbahl8jbc0Z9pNpICXGGNd8IDvDIAO2JuaUajz8fOqg1ySgMWakwOmg0g9mfippZloJBOI0TLAUb+Fu+cvFDk+iuOHZ6aZiFYMjn4zoigY2eL3rzSczaSj11ymajQRVlzChL9yFrNAuJ8TJPUipjTDCDtvu1TN2BW9kNsekv2CXlVKB6tVOethkJYIGiezaPresKug2jjmz75NzcQVZ9T8ZI4kLXqcSWp59z7svMGfRnBkAH14k0rtTvB2pou71HGSKgHShxqSqdWnuC4ov1So4L/d5dXz0yBMvNigBMX+7pfObQWkpNPL0BNSwB6Cw4/AWW82CCEvOGm9DLaBvy88Zb5zawWzwmGdCq0BqnuVwWwg5ys/yF4NqUrXDkm78SknD7+9yVvKJ7Wv+rfbubg6tujokG3kILBl8AYUV9dWD05YG2WKZjxZZQzhkUB9nDiA47iewDYhF1de/DES6GSOVMLi6xvTTzA+lJiJ7pKvh60oWpOopAwkhKTVh3EMcf/A8ZxV6txNgOm8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(66556008)(66946007)(66476007)(2906002)(4326008)(31686004)(5660300002)(41300700001)(316002)(2616005)(6486002)(6666004)(26005)(8936002)(6506007)(8676002)(186003)(53546011)(83380400001)(478600001)(36756003)(38100700002)(6512007)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdGNHNTNUVXNjhOckhWTHV0MDZkbjljTWR1aEhSOW1sNVYzcUIxY2tKRVNZ?=
 =?utf-8?B?U1RES3ozNHZhd3l6MzcySEg3SVI0NWV2OStsU3BGYldMMFNWeHVpVGZuV1E0?=
 =?utf-8?B?VEEzVXJYM1F5NjFXMUU3SmVVMWlzUUJiYmRMa3FiS3pGa2NLVXhZOFZ1YkNE?=
 =?utf-8?B?NldVZEZWNldDVWtaNXprQmVjU3pOaU9UOUhPVmd0MitNSlNTRk1COGNkeXlV?=
 =?utf-8?B?Y1FvK2EySHhtRlkyK28yMDQyejY2bENSbTl0NVZUbWFlYnJibUJEK21zQXVO?=
 =?utf-8?B?U3UzdVhzNk5aaHFyTlorbHZGaEU2R3hMdElCN1p4SnVWNUQzT05PcXU0YU55?=
 =?utf-8?B?YktjY0dnV2VSYlNKK3lPTFlNRk5XY1FVQ0ptazRkM2lheFJZUFNSYTVNbmhR?=
 =?utf-8?B?a1ZxbkYwMnVYMGdlNExpQ3QyZlhMR1J6OExOWG9KVVNQR2tZQ3o5U3l1TEln?=
 =?utf-8?B?WXlGb0xORjlKWjdETEJ3SVRtdFZ1bUU4RHNRWnFUNGZja0pUcHZuZmwwVkFo?=
 =?utf-8?B?RzR2anZHMTlNL2lTbTRCTlhBZ1BpRlBlT0JuNTlqREFiem5rU0crSkVkNjUr?=
 =?utf-8?B?azdPcnlNU1d6b1NlbHFBOWEwb2xjMGROVjNXdTM4cVZOQnpNVVlWQ2h4KzZZ?=
 =?utf-8?B?V3NZTWFMZGdxYk9SS1VvOHM2RE1kMGZVUllxYVlmbllUaGlkeVRDeTQwY1Jm?=
 =?utf-8?B?RGpLNHprZ3orYUQ3SDZZaEMrNE9ZSEU3TDUzbVAvT2pKcTJsYk1lMEYvZHo4?=
 =?utf-8?B?VGNrSDlVUEF2T2dhako2TTJjWXk2SXNOL0M0Y3lGSzJOUWdvSENxN2NnSnJY?=
 =?utf-8?B?R0hsMjYrREk1U2RvRnlSSWRHUFZVSGpULzBRcElxenF4L21qWnhRdDRVVHp3?=
 =?utf-8?B?R3ZKWDU0Q3Nob2J5MEw5MXNEeGZJNTBaUkI3TVFtUHBpNDBZK1hHeEp6SkEy?=
 =?utf-8?B?MTFkbFN6WTl0YmpJUm9FMmx4RGNSQ1Q5anl6YmY4dTh1K3Zza1FHcklBeWlS?=
 =?utf-8?B?Ui83RjBlZlA4eVV0YmpNamxmQWZuR0drU1FRWnYwblZsSEFaaGxOZjkyUDY2?=
 =?utf-8?B?UDdLRXB4bW96VWVUYkRXL1lTcDNIUnZOUTQydU5pNlRROWNhdlB0b3VEcWdl?=
 =?utf-8?B?TTRkZGgrb1lGdEg4V1ZYK0IyTmlobHpENnlXTlRIQXBITUZGOGRGWGRyN3Vo?=
 =?utf-8?B?T2FoQmoxY2ZFekluY0V3bGJUa1IxaU5EYy9HOGhaZk5oVWhqdWJrYzFuVDhY?=
 =?utf-8?B?d21xYVBSSWRFcm8zTkc3V21WdEoxLzJ4WUlsRVEwWW1lTHYzc01meGhhMFN6?=
 =?utf-8?B?Znk5MXl4MWFDOTBkZElvT05JYmVOZ285TnVvSS9pOEZKdDZZeDY3YS9zanky?=
 =?utf-8?B?bXM1dmFsMXYzQVVDelJxNk1YZDNDUjJpUHI5SFdESEZZalFwV3pyQ3Zwa2pG?=
 =?utf-8?B?QU5jY3UvUEJFeUNhWTlaVElBZkNETmZiY01qWmc4MkVMd29VODM3RWM2NXhF?=
 =?utf-8?B?M0dNQmQvMUo5ZlBWZWovcDBvQWk0Vy94WXp3dXhyWTlVMUVBQ1ZwMExsY3Zl?=
 =?utf-8?B?cXl6NmpmT1pBL3BwYWJiU3RkQkVoVTNBOENqcUJhTUhJRkhjN3BoWFBLSjZI?=
 =?utf-8?B?R3FrVWtHbmFRUjhyODNXN1dJZzZCUGdGbjNlalhnNC9MdTRkb2tpcTFWdGJ6?=
 =?utf-8?B?OVgvUXpYUWxhODdXVGl6N2tRUlMzd3NNRFNEaENad0xsV3YxTjFlZzc5bXFS?=
 =?utf-8?B?SFlBdXg1T0R0SDVHWjFQSUFjbHdwUkZ5V2Y4RUtTSmM4WFdRbUJCUWVVbXRO?=
 =?utf-8?B?c3F5YVdMUGlQY0lzT3BLcW5FMTh2THUwZjh1NC9aTW1TYmw0U05DNVZxNGFr?=
 =?utf-8?B?K3V6L21zVjFGdmp6UEl3TTc0VnArb0xxT2FBbjdFMy9DQWFaQ0FkOU5MMFN0?=
 =?utf-8?B?dFV6VmZLNXU4TENZcno0TlJPeU02NW1oZE5UeUp2cFNrRlJaY1Q4b1FjNXVT?=
 =?utf-8?B?UWp1ME9abFZEQVlwazZIYzNYeFFYK0RYMStTUzR6SXR0RWZuZjd0L3RoRUdl?=
 =?utf-8?B?dm9JSk1qblFtU2lkL0JNQzZpblRSakVLOUFEemx2a0lZeXB3MnQ3WmNWVUZv?=
 =?utf-8?Q?GZO6oDUwMyU2hQb0FE9ktojy9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e84a85-9529-4069-ff4d-08db92a6eaf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:49:40.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdoTaapI5DDP/7AyVxEnUOm8r+FFGlD5p2JVh0qoCQwshvoawFlH0Gf5bvl8PODIF/KSzXdgphyDnz3SIZjPqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
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
> Add a snp_guest_req structure to simplify the function arguments. The
> structure will be used to call the SNP Guest message request API
> instead of passing a long list of parameters.
> 
> Add two helper functions for filling up the parameters:
> handle_guest_request() and handle_guest_request_ext(). GET_EXT_REPORT
> queries for certs_data from the AMD Security processor.
> handle_guest_request_ext() provides those extra parameters for
> receiving certs_data from the AMD security processor.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   .../x86/include/asm}/sev-guest.h              |  11 ++
>   arch/x86/include/asm/sev.h                    |   7 --
>   arch/x86/kernel/sev.c                         |  15 ++-
>   drivers/virt/coco/sev-guest/sev-guest.c       | 107 ++++++++++++------
>   4 files changed, 93 insertions(+), 47 deletions(-)
>   rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (80%)
> 

> @@ -398,6 +393,46 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	return 0;
>   }
>   
> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
> +				struct snp_guest_request_ioctl *rio, u8 type,
> +				void *req_buf, size_t req_sz, void *resp_buf,
> +				u32 resp_sz)
> +{
> +	struct snp_guest_req guest_req = {
> +		.msg_version = rio->msg_version,
> +		.msg_type = type,
> +		.vmpck_id = vmpck_id,
> +		.req_buf = req_buf,
> +		.req_sz = req_sz,
> +		.resp_buf = resp_buf,
> +		.resp_sz = resp_sz,
> +		.exit_code = exit_code,
> +	};
> +
> +	return snp_send_guest_request(snp_dev, &guest_req, rio);
> +}
> +
> +static int handle_guest_request_ext(struct snp_guest_dev *snp_dev, u64 exit_code,
> +				    struct snp_guest_request_ioctl *rio, u8 type,
> +				    void *req_buf, size_t req_sz, void *resp_buf,
> +				    u32 resp_sz, void *certs_data, size_t *npages)
> +{
> +	struct snp_guest_req guest_req = {
> +		.msg_version = rio->msg_version,
> +		.msg_type = type,
> +		.vmpck_id = vmpck_id,
> +		.req_buf = req_buf,
> +		.req_sz = req_sz,
> +		.resp_buf = resp_buf,
> +		.resp_sz = resp_sz,
> +		.exit_code = exit_code,
> +		.data = certs_data,
> +		.data_npages = npages,
> +	};
> +
> +	return snp_send_guest_request(snp_dev, &guest_req, rio);
> +}

I'm not sure these intermediate funcitons are really necessary. Can't you 
create/build the struct in get_report() and get_ext_report() and then just 
call snp_send_guest_request() directly from those functions?

Thanks,
Tom

> +
>   static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
>   	struct snp_report_resp *resp;
> @@ -480,7 +515,8 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   {
>   	struct snp_ext_report_req req;
>   	struct snp_report_resp *resp;
> -	int ret, npages = 0, resp_len;
> +	int ret, resp_len;
> +	size_t npages = 0;
>   
>   	lockdep_assert_held(&snp_dev->cmd_mutex);
>   
> @@ -520,14 +556,14 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	if (!resp)
>   		return -ENOMEM;
>   
> -	snp_dev->input.data_npages = npages;
> -	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
> -				   SNP_MSG_REPORT_REQ, &req.data,
> -				   sizeof(req.data), resp->data, resp_len);
> +	ret = handle_guest_request_ext(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST,
> +				       arg, SNP_MSG_REPORT_REQ, &req.data,
> +				       sizeof(req.data), resp->data, resp_len,
> +				       snp_dev->certs_data, &npages);
>   
>   	/* If certs length is invalid then copy the returned length */
>   	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
> -		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
> +		req.certs_len = npages << PAGE_SHIFT;
>   
>   		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
>   			ret = -EFAULT;
