Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5B77D40B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbjHOUUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjHOUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:20:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B21BE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTSc8LLC5qq7F5cMDRGuh4aJHxtoZNPgBzq6Dm2YhX9e3C3GcBYtk3ONgb0GEAq/FAOCUipPhk7Xmjm5TuDNgb1oShH37q97ML0L1HFtH+yBw9KbIpUtk/kyhBQqEUoDMf3dPeuuhxqHMnKQTXrJyCLlWzrfpmX95z116g5kwauUKfLwaV7zsxWmTWIYwkZa/l86vBPLUwxDazOtuydneTMkJkyGcUrKBDdOa9itC8yv5ZQmkhw55Gxbi1E3ZdkyEX8PM1jkp+COPjoukNlcWTVcGvp+Jz80XvgDKonPdJpkWlLHOe7v65GqPnGwtk/DScACrn4Cwu/G+Ub9vp0oBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcZOU/3iKer4blTfAquOthSe/ZLSkG1jcNo5Leo0ym0=;
 b=g384Fp607A9xk825nmbgG6ujCzScSH0xhexfxvBzMp/aWc3SPH3wHxzMYklRJ5RH/Z8dToZ6DrWJaVqWtinCuEzlbHudK+SUsgcdf2FlHOKmO936IUJSW539EeeW0yc5lp6U2XRKNxCcsSOly5l4nCM7XDoX7ED48EE50FX6+QaVRw6Pl4QdGW9MoeDb0sfmRLdvXt6xEkAMSMGN4yhkz/ilngUrdUwwhPPkI+7pF5Fw29vNxETKnGMqfG6hXfOjDjd8rTHHh7Nc2sIJ2af9Q61JnNwI2KaMkjk1VljIKVidRFDVq6joivr8yWYV68fXPPIQdWYFFkwRi7KJLMW0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcZOU/3iKer4blTfAquOthSe/ZLSkG1jcNo5Leo0ym0=;
 b=VwsXu6kN+znK1v3PBu5aWT6rY13+UD5PKzVzy2bk2Ci5MoWgSvhuFYICexuMKwVTP9wd7pJsIw8eBiXM0KSCNCY69ZZKFBKVTWPoG6U/OK0AaCkaUV0QgVRFTtWdlA9n6qZRVWrGmnIK9BcCacetQmb5zi31o+6Y9SmuoRllvzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 20:20:33 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 20:20:33 +0000
Message-ID: <ab871b36-203c-6b40-f5e4-2dfc4b15b41d@amd.com>
Date:   Tue, 15 Aug 2023 15:20:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b97e3d-9845-42e5-c847-08db9dcd13f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsCK3ki+9DyUupAGXsmIppEtH/gsHUSbSglAWO8VF0UdG9rCqGUts9CLQxXcYCrw5/uqY5V6PZWHB0/lKvkGCQpVWNcysOTX2XpcmEHNO5oiG+BQ+l4Ql0xIcgCk7bq017an02slFafBwh8OVDOpFkIphT0j8GSxEEGB+4U2Wv9S9k7PrLXklwhyt2FjvdxJnsueypfAJoA8hMm0OIrAvZVz1ST0GOF3mTxY9D4UY3jqY9OTyfK1RHBa1LDEwMOFPiAPEkC7/p/HQnLlprgcFyEsuNK0xKD2qJzuFkVOcutN1FTALt+t2Q+1snV3frrBgQgcyxRyU8TaFgEbqjXqdzLBhDhbrRdnXsgBVGULVeCEIbYzi4MqDFSYN/PUHkHZ/m9huHl5hYQzKRsvjvQMG3wdiUVb4bHRdmIoECVMU9toS6qKVsKIMdHnbpG3LFtcml8PDBt+hI8fIEcIzpCmF5koPUIE/cgQCgcYS5cgjW9Q/8Hb+FBC2CZWRwWcFGY3jlHwse0oUPfFVeDjPz7XCAjNlZYGbUWzfuql1+ox59qay13aVYHqSxvd2y6RhBrXICTimc65pdOed1kKHu/e4nd+t+ZDqELqhxg8Pq+BFJYmE9bVITSdlPFpZiFnEr66+ntK4bqODtYh4Jf5Mgj9Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199024)(1800799009)(186009)(8936002)(53546011)(38100700002)(54906003)(26005)(8676002)(83380400001)(66556008)(86362001)(31686004)(2616005)(2906002)(31696002)(6486002)(36756003)(66946007)(41300700001)(478600001)(316002)(66476007)(6512007)(5660300002)(6506007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnRWNk1lODlGRFNzUm9kREZ1RlF2OGRYZWJLZmlUZTVnODM1SlF1SjEvQ3U5?=
 =?utf-8?B?WGtsYjZIdkxlNmp2eUZraFZoNE54Q0xzS0ZXR3lBUklVSzE4Y1FzOHlHK0c1?=
 =?utf-8?B?NUJJTllZajloYXdKT2tYdGpvM2ozSXRzQTZGVUZOcTBJb2hITDdDa1VEamNk?=
 =?utf-8?B?RzNHS3JyWUZ3aTJhU3BIWm5OM3dTVE5xZlpTeVo2SFRjYmZteDJyejh0SUpV?=
 =?utf-8?B?c1MveVgrL2RiWXhxMk1YbVpISGdhajZaOXRHbk1BQys3T1ZyWDFWRFFsLzFk?=
 =?utf-8?B?Nlg5MlhlOGlSVjZpU0JaOGtXNWVHZU1GazFrbnlrMVp1L3AzczdwNmM5VFRx?=
 =?utf-8?B?WmcvelZoL2hXQVpPRW1vZ3g2WE5SaXN4TUpPYVJLRUNQcUVjcGl6bVRWcGZ5?=
 =?utf-8?B?S25Sd3BBdkYzOFJlN2RiUTNjTkkyZUtiRGU5YjVnQk9ScmVvSWhNUGRzV0dD?=
 =?utf-8?B?VXppdUx3VzNMV1BHL2Y2azZOZmMvK0pYdTJyYThjQnhrK0N2QndCQi95Y2dO?=
 =?utf-8?B?Y2lnVjZDK1oyamFOa29WbUl2YWw4czJ3aTFmVTZhWjNHZlRNS1V0OXUyS3NO?=
 =?utf-8?B?TG5XWEFtY25OTDJNbUcyRXVlQm9qbytoaUtJZnZHditvTG1hZ0I2US9odjZB?=
 =?utf-8?B?VFptOUQ1MWVIT1NXL3ZDMEJDaUJUWmVhRm90dE5oZzZjUEkrbzRZOGlsY01Y?=
 =?utf-8?B?czJGaGdHRkhJWUwxa0V5cFhscnVNMTFmNEo0N0YyQllSYmlIREhWcjkvNDhO?=
 =?utf-8?B?VndiRWdFb1V4VW1MZnc0b2t5Wm94YlFBZ0dKZ3F4dWhkVkdFMWdWRGx2TWJ2?=
 =?utf-8?B?dm9KUDFDY0NlVTc5N0pMbDloVE1OVGZOVkN1RVRrcEttYVpBOTNlWFJhaW9C?=
 =?utf-8?B?eGVrSXRIRnZMYnJheXZOWEUrc3JseEs1UDkrTVdxT3JTODRKay9ZSnZWQ0o5?=
 =?utf-8?B?Q2xndUFpZnV1QnludnExcVVnekduR0h5NXZueG1hSEN3TWFUdy9lUEs5TGVj?=
 =?utf-8?B?Z01rT0NzMnVqQVhGL1lrcVFVd3d5RTNBbXZRNlpBZEsvN0ppYmFsU3NRNEFl?=
 =?utf-8?B?Q2Q3d2ljZlF5SjhVd0Q1MlM0bFRKVmltVGk0UkpsSGcxdzlZSGxDYnc0S2ZJ?=
 =?utf-8?B?VitSVUkxWlhLL2xWaUhIWVRRdjI4UmZCSEJkNlY3Rm9qMUI0T2xJUWV1ZEZI?=
 =?utf-8?B?cHMreVVVaFpEYWtPaDRCQko2SFRXdEJTNDV1OVJVRHJLQXRvUFJweCszWGll?=
 =?utf-8?B?YUh2RHlNQmRyTnNwaUs4QTFWOStaRndIT0g4Ym5Bd2wwcXF6VmM1S2dHOSt5?=
 =?utf-8?B?cjM3WjRZMFhKcEwxQXB1Y2hPQ0txU2lmcXJyck9oNXRzUzIvSWNtKzlIR3RQ?=
 =?utf-8?B?ZFhyR3k3YmFMSjJHNjRDUEFJb3dDWm82NUNONWZ1SnFQZzhHZHZoQU5UUUxl?=
 =?utf-8?B?Y09yb3d5emJoLzV1TEh4SXpGQkx1Ty9sL0pZNERzYTFTN3ZMVGlpSWdINkYz?=
 =?utf-8?B?Sm4rL1JRNDNidzJVaFhuc2NxU0hDMUxDWVRlZHlFV1V0dkxBMXYwVWpOUHFR?=
 =?utf-8?B?TWdNN2tRSGY1YXUzRU9Pa0hFVDBVSnp0bEZXK25zam13d2FsZWlQNlN1T1p3?=
 =?utf-8?B?cHloS0tINngxekhZMjMxQmI5WHhxVFhLaG40Tnd4VitMMlZtVmMya2VTZnIx?=
 =?utf-8?B?OGxsUW8ycy9DWnJmK2s3TjR6NFc0L2oxdDZ3by9uc2t3d3p6Q2sxbXpHY2ZQ?=
 =?utf-8?B?M0t6bStmS05TRXlWTTB2QTZQU0RTNWVlVkhkekY0YlVTelU1Sm0rRXNCcXZi?=
 =?utf-8?B?U05uVFgzUzBLWitkcEd2bkk5SmVWb3J0cjF3dlI2Z1dRUVBzUHRnMkNtOHZs?=
 =?utf-8?B?VFN5NWc3c2ZFWDJFQXlBZlZrKzZzeVdYV3VEV250ZFFTcm45SkxwbFpRa0Z2?=
 =?utf-8?B?b25Yc2UvU1RSZUp4bzcyZUJXNDZjaWg1VVNabU51QlR4WjVFeHREbFRZZHVl?=
 =?utf-8?B?eW5qSzlqTHppRHZNSWFrTTJQalZ3U1FrTzc2c2tFTGo0MEJWS1FHbGplOU5r?=
 =?utf-8?B?MDhGUnZvRE16TUEvbmwxaHExTzRIR2o2QWZNUXltblYwaEtyK051b1FjeW5l?=
 =?utf-8?Q?0R5FMHDpPEetR1KZCnVXrcAXm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b97e3d-9845-42e5-c847-08db9dcd13f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 20:20:33.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vhx/OY48qu2P+vwDG3C8QlH5jNZMvN9lIoSToqHG1J4akWCibjrLRXHQXzqmD9O/C2d654gcoDsGHCfIIYqXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 02:43, Dan Williams wrote:
> In preparation for using the TSM key facility to convey attestation blobs
> to userspace, add an argument to flag whether @arg is a user buffer or a
> kernel buffer.
> 
> While TSM keys is meant to replace existing confidenital computing

s/confidenital/confidential/

> ioctl() implementations for attestation report retrieval the old ioctl()
> path needs to stick around for a deprecation period.
> 
> No behavior change intended, just introduce the copy wrappers and @type
> argument.
> 
> Note that these wrappers are similar to copy_{to,from}_sockptr(). If
> this approach moves forward that concept is something that can be
> generalized into a helper with a generic name.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c |   48 ++++++++++++++++++++++++-------
>   1 file changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 97dbe715e96a..f48c4764a7a2 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -470,7 +470,32 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	return 0;
>   }
>   
> -static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +enum snp_arg_type {
> +	SNP_UARG,
> +	SNP_KARG,
> +};
> +
> +static unsigned long copy_from(void *to, unsigned long from, unsigned long n,
> +			       enum snp_arg_type type)
> +{
> +	if (type == SNP_UARG)
> +		return copy_from_user(to, (void __user *)from, n);

I'm a fan of blank lines to make reading functions easier. A blank line 
here and below after the memcpy() would be nice.

Ditto in the copy_to() function.

> +	memcpy(to, (void *)from, n);
> +	return 0;
> +}
> +
> +static unsigned long copy_to(unsigned long to, const void *from,
> +			     unsigned long n, enum snp_arg_type type)
> +{
> +	if (type == SNP_UARG)
> +		return copy_to_user((void __user *)to, from, n);
> +	memcpy((void *)to, from, n);
> +	return 0;
> +}
> +
> +static int get_report(struct snp_guest_dev *snp_dev,
> +		      struct snp_guest_request_ioctl *arg,
> +		      enum snp_arg_type type)

You can go out to 100 characters now, so you can put "struct .. *arg" on 
the top line and just put the enum on a new line.

>   {
>   	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_report_resp *resp;
> @@ -482,7 +507,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
>   
> -	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +	if (copy_from(&req, arg->req_data, sizeof(req), type))
>   		return -EFAULT;
>   
>   	/*
> @@ -501,7 +526,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	if (rc)
>   		goto e_free;
>   
> -	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +	if (copy_to(arg->resp_data, resp, sizeof(*resp), type))
>   		rc = -EFAULT;
>   
>   e_free:
> @@ -550,7 +575,9 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   	return rc;
>   }
>   
> -static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +static int get_ext_report(struct snp_guest_dev *snp_dev,
> +			  struct snp_guest_request_ioctl *arg,
> +			  enum snp_arg_type type)

Ditto here on the 100 characters.

>   {
>   	struct snp_guest_crypto *crypto = snp_dev->crypto;
>   	struct snp_ext_report_req req;
> @@ -562,7 +589,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
>   
> -	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +	if (copy_from(&req, arg->req_data, sizeof(req), type))
>   		return -EFAULT;
>   
>   	/* userspace does not want certificate data */
> @@ -611,14 +638,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	if (ret)
>   		goto e_free;
>   
> -	if (npages &&
> -	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> -			 req.certs_len)) {
> +	if (npages && copy_to(req.certs_address, snp_dev->certs_data,
> +			      req.certs_len, type)) {

This can also be a single line now.

Thanks,
Tom

>   		ret = -EFAULT;
>   		goto e_free;
>   	}
>   
> -	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +	if (copy_to(arg->resp_data, resp, sizeof(*resp), type))
>   		ret = -EFAULT;
>   
>   e_free:
> @@ -653,13 +679,13 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   
>   	switch (ioctl) {
>   	case SNP_GET_REPORT:
> -		ret = get_report(snp_dev, &input);
> +		ret = get_report(snp_dev, &input, SNP_UARG);
>   		break;
>   	case SNP_GET_DERIVED_KEY:
>   		ret = get_derived_key(snp_dev, &input);
>   		break;
>   	case SNP_GET_EXT_REPORT:
> -		ret = get_ext_report(snp_dev, &input);
> +		ret = get_ext_report(snp_dev, &input, SNP_UARG);
>   		break;
>   	default:
>   		break;
> 
