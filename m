Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB87C642A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJLElF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjJLElD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:41:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F17A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUA9MScJu0Nv2sVGzlTvSThI1d5//7ziF1iwTvMbsk5A/2s7EZjKy1GidjDNGckwNwRzCEJhrCJ5JqP2jAp/sqfTpQHrOafoDf4iTGK9jsFolXHWGZB1biFVn91c7W7/hcvXy1Y871AQZ8L3Qg3bNhsnQUIpDzmEzJVS3FwcRRWqtF9WqhCsOui/BhXPwlVIgDDfgnoyJWTWfPD71SPY3Gav5Ge5zH26DNfsR6dyr1B3YxBvD/C49B8pMXf01cJjC5Vhd+pRAMd6ji7gqqulzQXoJFcP98LwBdCmBcqs+yfr2mobFXTpMjwhXB6bi4NDK5xZ4oj99Z4w7BNby8IPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd7TK16J3tZZc18zwkTJHvC3zX3NWzl095JIB5pjsJ0=;
 b=LYRkl3bbgsGibyKrf6Lc8a3zzWrfRNnypbHWKiAiY1AGBBsbyuAu/vVzDQ3khOZ3IbNbknUX24rf8tfCwhIOR9fpLp1vcZ1/CNkQIwnWbHGiT7UAlxYhYvtXS1+LtSilAW58KEAMfh6wbmWgbk4Lyk4ENGTlgJQ5Ie88nkoU0W/N6rNBXiT1hMUv7CvtFFQQM2v9EabhXb8fNDK2W8Q4b3gwKCwqevQDRTg0vI55vdeCv9qfkd9T7djJ748eVzwZkycmg0rrvdX4mjviW/lgQ6bm4WlOVby1LJswQgjnMy+Du6/NvDRl+NBcCHsoGsAT4DHpGzNGHCm8eUgy7GhHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd7TK16J3tZZc18zwkTJHvC3zX3NWzl095JIB5pjsJ0=;
 b=aV6RHg3xc2fqUNXWou7kcb4nz3lYIimMx+Xb3pYG0sv4bXLKTDd3wa3HrYcjm1G7xuylr/wS0Xq0vt33DNL80I3457FrjdYlLI9K+29eFsK7fwzSpqad3ZJKRo0/55KiRBDvtn/GWCU1SPlXzTn7IW5u+y48CCWi56y2GTOQKZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 04:40:57 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c%2]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 04:40:56 +0000
Message-ID: <3b484a1a-e6dc-3b73-ba1d-72fd6ba38ebe@amd.com>
Date:   Thu, 12 Oct 2023 10:10:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v4 01/14] virt: sev-guest: Use AES GCM crypto library
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        thomas.lendacky@amd.com, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230814055222.1056404-1-nikunj@amd.com>
 <20230814055222.1056404-2-nikunj@amd.com>
 <20231011185607.GVZSbvx8rJ8DXPqYfg@fat_crate.local>
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20231011185607.GVZSbvx8rJ8DXPqYfg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cda0eb-596a-492a-cb6d-08dbcadd6c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDMq62ZRZ/UfAaasjOsU0o1o2ASKjyzIueccPJ59xohQsn5K3HYmI4bncJBBsdiiXFvnWLk7F1jNxSSNE7CAtOGUM5rhzrOQKaKnFkRQZ/dvhkKHzrLi6ARviENxQp9vWQH7J4NsIRV/hUiGKl3bytZBnRVpU15iUKM8Aez6+cCn7dfbpWlKvzoPeZpt5l9OfD8LfWIUZc9iI16EM0ngqQ4J0nJF7CTZ38skhZSfm0vFS8U5YEbgab3DlnSNeMGcpnZjHFtZiLGdorrCO+1MqvIq0dpeqa672dK+bmnLfTrY6P12vCIJOeOYrTbJ7BEkM9PZt7zLMIhkabU+X7ZJQh3L5PCKqLse7eXDChki8h7SArWGmjx1O49BO1JP8ctKZwh/TjPGDJh6T2WGZipbmsxnVMtfjNOUT45qKc6DEloTchI03kobvQbeAaQRD6wzV22UhUS6tyjkIg3gfgRuHG2bEQofTl9iyg+/ei6pkQAFw+U4TVZ79SKUCuy52RN3fuOstSc8+CDeFDeJhitxgdMG1D3X4G10JaYOxdgS/K3IFfSoGunSBQBYPNM7i2ekwA5h52j/FgmVjdkt/8eLsQ5J4QlqORm4dmays6lYupdxFUbY6s2p0Y7Wx5hWvelnCo6y2Et0KuQWub0Doka7KsIQGLKkAJxq2kmP01mk8gCY6LDmIE8B5xo1Mxmfq7ha
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6512007)(26005)(6506007)(53546011)(83380400001)(2616005)(31686004)(6666004)(4326008)(6486002)(966005)(478600001)(31696002)(36756003)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(2906002)(3450700001)(66556008)(66476007)(66946007)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1p1c2RBcnlSWlpFSjYwMG45N29NWGk5cGU2SjVKSFQxeWgvZlk2MTFKOGdJ?=
 =?utf-8?B?b29YWStoRm5pb09aV3g1UGJRYWxTSXJmaEZVc1FQQnpsOExYN2c2YTR0MFJy?=
 =?utf-8?B?bS9nZ29tNmE0bSszZ3dJUFFnam11bXY0Q01BcEpJUEFTd2pKUTgzM2dDazJ5?=
 =?utf-8?B?Uy9nOW80UTJkLzl1R21HU3lkajhhaTRNWTVZdGxZZWs0OEN3S3ducU9CTnB2?=
 =?utf-8?B?RE1GMlRpZVFVOHhQcTlHTHI5UEhUT2tjUlJzT0d6d1pMbWdjU2R4SEVPaCtN?=
 =?utf-8?B?Zmd3QmlDTHZhUDM4WlFHWVAyQW5YbFRXY0dSZFo0SnArL1Y5MFZuNmdrSTBo?=
 =?utf-8?B?R3V0a1JacVU2eWR6bXZBMURYNEdXaXdva2VLOVFmNVBRZDlvZU8yWENONDl6?=
 =?utf-8?B?REZsQ250NUJsQ2dRSm0zSXBJRUJOMnh1N05TRDBlRWZacnhwOXQyaDkwU09Q?=
 =?utf-8?B?VnpVRzBUWm8wOUZOcG4yVjJaemY2aFNhVFhWOWNwZVpDdU9oSXpjMmMzU0ln?=
 =?utf-8?B?MXRFQmhEei8rTmlidU4yZzdGY0NzNEVZWnA3WVZ3Um1sSUpVZ2g3eDZyNG82?=
 =?utf-8?B?YytNUjdsRDYraVZZWFhuVGxNVllPT2RFSzNrOTRVbllYTHBuTnhBUUVEUDBR?=
 =?utf-8?B?TW5XZ01DbVlVcENKOFJvRkxHMXB4d0p6bU1vdHRVMERmUDRIMW5xT1EvdFh3?=
 =?utf-8?B?aEFTV2x1S0s5M3owUFo1TGhDVHZBbkF3aXZMTzRtbXVocFN6bFNrY0ZOVXNP?=
 =?utf-8?B?VHluMlplOXpqdnovNHZST3V2clVXRDVmcmRxTTdxZjVlS2xnZFVGOHF3VzFT?=
 =?utf-8?B?U29IUHkvbWJPcHJWS2pQQVVLZUJYdU9wNW5JUEJuSUg1emV2dlR1OGVQZUNX?=
 =?utf-8?B?bTZvVGJJRitQMFBwTUtBbVlMRmxKc3FyeURmeHRwUVlsWEZKaXRPTUYzOEJE?=
 =?utf-8?B?SGdrK2pmMERjUkFvZ0ovRFZ4VFNySFdjRlV2UCtDNUZpY01icFhIKzgrUkZM?=
 =?utf-8?B?YWxWbzI3bU9xM1FiYnNnZWVyQkdWVS9CS2VMa1R0VlBBUVVFZUNNZmhaUlpS?=
 =?utf-8?B?OGZDMFNsanc1aWFBMWNoL1Bya3ZJTlg2UDB1OGFYeTh4WTh0MVFzRXZzNFhP?=
 =?utf-8?B?bWNrQU5SaDBzL2o1amx2a1dQR0xNdXRZa1c3ZDJScGRvam4yQ1NWcktiU0dw?=
 =?utf-8?B?SDhIalA4dFhKOFVTU05nVmNlcHFmZCs2Tiszak1QajFsSHdQdG8rZHdWdW5R?=
 =?utf-8?B?Sm81ZzZRbkpLRCt3NTJzS3hObGlwMFFtYlFxMFloNGRnbFZOempRKzdkQ3lL?=
 =?utf-8?B?ODM2THQxZ2VXSE1RdUk5VVdrQkYzRXlWTks5ME4xbTJneGx5VlRrdER5NmFN?=
 =?utf-8?B?alVzcm8vSU8xUUpTU0RlNnk1SlZ2THZzcnZEQ1B2R013Z3hpeThZZG4xanNw?=
 =?utf-8?B?am0yVnFqS09iYVFvRjRxQS9nQWlkeTd2VFlZanlNR3BSK1hhMU9sWWFvV1pQ?=
 =?utf-8?B?anRyQ3E4Ui9uVzloNDU3d24xemJ0ek16Z2MxS3pWZFBycTV6SnRDWXY2WUJQ?=
 =?utf-8?B?cDJJdHM2MkxJWTM4bTNpWDFaWEtyUDU5VXE5VWxYODJub2g5MTBHNDEyWU1O?=
 =?utf-8?B?dW40L2hNZURVcC9tZGRTL1JQTVpWeDYyTXZwZ1p1bC9HT2VnZXAyN0lTZVY1?=
 =?utf-8?B?YS9aSG5rUFNTMmk3Yk4vVDVxSkFrYmRXeHZTTHNsRjhZSHFCSnNjQm5yYnRu?=
 =?utf-8?B?ZTlPOG5DOG5Ob0tiRWVUalBTNE5heHVOa1VyY20zdW5MTm9hVVZaUXdaMHJn?=
 =?utf-8?B?QUk0eTVxZmNLWHZpZjNtWVNBK1dnanptdjBlR0FGakpHMm9EaXpTTWFtTURV?=
 =?utf-8?B?QlJodmhvU0hKdGE5NjNOSlVYQ0VPVzNFK0NxOGJxQkd5bDI0VVlUWTFjQTZJ?=
 =?utf-8?B?S0RBN2JldlMrRGNKUWd5ekE4K1p1YzRMUm4zcks0RFVFUStBTHJxS2NaSVNu?=
 =?utf-8?B?T1pmZVloRCtydURIU3hCeUMwMnJuTnpTTDJnRzA3V1RFRFQxK1hqaEhtdDhj?=
 =?utf-8?B?VU9QTUsrbDhJQmdOTk1OVWVubFNnY3A0N2QvNmRmYnFNNjRJTUhpMzFaWndV?=
 =?utf-8?Q?BxSls+eUuJtY/jMB8dERhbP9G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cda0eb-596a-492a-cb6d-08dbcadd6c8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 04:40:56.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LOUfXx4t0CZDqO+Ye3nThHkfUQzWYsTYkwZpiIqign+QM/L7j8UBAv7uDbA1+98xa8BXQ9Nh2obO048ZsJ8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/12/2023 12:26 AM, Borislav Petkov wrote:
> On Mon, Aug 14, 2023 at 11:22:09AM +0530, Nikunj A Dadhania wrote:
>> The sev-guest driver encryption code uses Crypto API for SNP guest
>> messaging to interact with AMD Security processor. For enabling SecureTSC,
>> SEV-SNP guests need to send a TSC_INFO request guest message before the
>> smpboot phase starts. Details from the TSC_INFO response will be used to
>> program the VMSA before the secondary CPUs are brought up. The Crypto API
>> is not available this early in the boot phase.
>>
>> In preparation of moving the encryption code out of sev-guest driver to
>> support SecureTSC and make reviewing the diff easier, start using AES GCM
>> library implementation instead of Crypto API.
>>
>> Link: https://lore.kernel.org/all/20221103192259.2229-1-ardb@kernel.org
> 
> Why is that Link pointing to Ard's lib?
> 
> Link tags are used to point to relevant threads regarding *this* code
> - not the lib you're using...

Ard had added the library specifically for this use case, this was the first 
discussion thread: https://lore.kernel.org/all/c6fb9b25-a4b6-2e4a-2dd1-63adda055a49@amd.com/

Should I add the above link instead ?

> 
>> +static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>> +{
>> +	if (snp_dev && snp_dev->ctx)
>> +		return snp_dev->ctx->authsize;
>> +
>> +	WARN_ONCE(1, "Unable to get crypto authsize\n");
> 
> What's the point of this?
> 
> You either fail the whole process or you succeed. What's the point of
> warning and still returning 0?
> 
> What do you do when no one is looking at dmesg?

Thinking more about this snp_dev and snp_dev->ctx will not be null, 
because the snp_init_crypto() would have failed resulting in sev-guest driver 
load failure. The below should suffice or I can drop the helper. 

static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
{
	return snp_dev->ctx->authsize;
}

> 
>> +	return 0;
>> +}
>> +
>>  static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>>  {
>>  	char zero_key[VMPCK_KEY_LEN] = {0};
>> @@ -152,132 +152,59 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
>>  	return container_of(dev, struct snp_guest_dev, misc);
>>  }
>>  
>> -static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
>> +static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
>>  {
>> -	struct snp_guest_crypto *crypto;
>> +	struct aesgcm_ctx *ctx;
>>  
>> -	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
>> -	if (!crypto)
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
>> +	if (!ctx)
>>  		return NULL;
>>  
>> -	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
>> -	if (IS_ERR(crypto->tfm))
>> -		goto e_free;
>> -
>> -	if (crypto_aead_setkey(crypto->tfm, key, keylen))
>> -		goto e_free_crypto;
>> -
>> -	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
>> -	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
>> -	if (!crypto->iv)
>> -		goto e_free_crypto;
>> -
>> -	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
>> -		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
>> -			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
>> -			goto e_free_iv;
>> -		}
>> +	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
>> +		pr_err("SNP: crypto init failed\n");
> 
> This driver should already be printing with "sev-guest:" prefix - no
> need for "SNP:" too.

Sure, I will change this.

Regards
Nikunj

