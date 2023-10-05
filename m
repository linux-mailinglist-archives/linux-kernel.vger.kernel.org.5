Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313947BA095
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjJEOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjJEOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EFB11AE0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUz9xavkGZ1A+Wj3r21ows8udAq4oe9YfwDpMM6e96tmRBlZfU8rxLBdCRAiU8MnhHiiQ5ed/Ke/6hGYWj7t2Ezjsn8eOCh+nnOr533EBs2XoFsBoTXT5zTHnJJIaFDWSm9lcuJd1TbTduz4bWgkbIpO9b6z1H8yK8U/cp1owsMrFa4Lo+1VoJ04CH1n9y0AHYVkXV8GD2n5lIQnQbA+fILQTw1Eqn/slkRk7WncXDa4MObKrx3wJ4UgYYzu+9nM8Oz98SzwjDvPtHS0q33uwtSeLlNNws7H80gi1F+46bKyuyDA4ukj3bWu05yM4sDWfS5lKcwsgb8Jt0MJn8kJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMJzp+HZUPxWM0zXkftHZC/z5UlSKoVBqwTFwBqBLdQ=;
 b=e+XUaV1g8zDfnUfz2Ewj4R9x7FwxgQ4yVTV28ll/xzOwiU2FcTD2tAOSwjyIMO5wFo5VQPZmpj2C5DzTyk8EXuo6GjWszQqd6uVA2VekCq3omFkRn/ftmGlSBAWAjRzuN9kuNnTJDGdDUZw99EZKRpL8TUs2RZy6fuCjrMO8okMCJwiZYOMdVGchrN36QrgmcPXboEGf+s3TpZ0K4r9Vcsl7moQLRCJjIwgvM7JLjhejsj+8IVs61zgEtcdjs7IN8O4Kv9D7iBsIpkhaCLqKlvIEMFn6xW0FsIM9XhCb64Zw+kNM/QiYTdP0vFzgw2fEUY4SCLmRdy6PT3427xALOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMJzp+HZUPxWM0zXkftHZC/z5UlSKoVBqwTFwBqBLdQ=;
 b=pOpZZeg4Vd4HX6BcdvFcefE+82FrkxDSda2CoSHddoeekcMdtinrsRSlkKwESodmRfyUHtiLdY9P8koiJ+CjIKva08ftA/VQpvNyYamAUy1f3l7CMd6FFRW2XPUGwRbeS4N8T3wLRp8MmIiir2CTeWSoJnBGeqYoJXToO6cNI/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.29; Thu, 5 Oct 2023 13:57:58 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c%2]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 13:57:58 +0000
Message-ID: <1f740bdd-666b-4686-8d04-1c28da9917bd@amd.com>
Date:   Thu, 5 Oct 2023 19:27:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v4 00/14] Add Secure TSC support for SNP guests
To:     Borislav Petkov <bp@alien8.de>
Cc:     thomas.lendacky@amd.com, x86@kernel.org, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230814055222.1056404-1-nikunj@amd.com>
 <f200403b-c460-5ebb-fec5-c5caf0cdb006@amd.com>
 <9a6af215-e696-5091-69fa-1cbebe772471@amd.com>
 <20231004070100.GAZR0NrFSIDKPSQIjA@fat_crate.local>
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20231004070100.GAZR0NrFSIDKPSQIjA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 24da4624-0277-4df4-d07d-08dbc5ab14e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDFhjQUYTFaoiI11DZY9rvxqZDkAMhlwuOktjXVsXxbFsWGWOCmupmI88HrMIwYw2GIqJgDC7wvig70fbXW+N6J6gaug5rXiS7eFnSt8qHUPT0hq1kVDycIOLjD0Om2oWQkubYStm+x5Z+qO38KYfMvN3cQCf6Ohulz8FCRihPxhnKY+BpNSLqFNyG7azVkk6SE5nRqH4LhgQjYj87t2MODtn//U+xiz9b6b+4bEe5v2H/gPof1t6at+UEM0fqH1eNqPvz1WSCIi9OI2Ix+NZTWU71x4KET/UYB7FZAL4W65WBAFT/nDPJZZqzIclF+CJADCi56E2+e7ObIwKghlxCLchRqILiT+X1GI6DjIa+wS4Ec24p+Vh6+lGzoKxKJoJARAIj+AslDUIgVuAwyOxUKcW5xU3B7F+Zc9d2B1lwOoDiKSSGSPZ3QXvF/OyP86tmXRda6VqnuGJg8hQvykiMiGIzYIQJen7vORbAU8509kh1tyPOdk/4+1avbuzlNmvbthX2omOV9ZvRqqIVNcTjmC4mctYxUYesbIpIZ+Fr7zTAL8MIrrnNYZIF5CD+UWlEDpyv/vL0WPmt8dYQA1uYmttKxxTgfFK4QtvYn1khY/88nMY9QVZ4Up1vEBA4N69iDJVj/Y3SHWFZkRDMVlPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(31686004)(31696002)(53546011)(26005)(966005)(2616005)(2906002)(6506007)(6666004)(478600001)(83380400001)(3450700001)(6512007)(6486002)(8936002)(8676002)(66476007)(4326008)(6916009)(316002)(38100700002)(5660300002)(66556008)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFWN3M3TktQZGlyVmJEMkUrOEpnZWdKTkxDdEpraHd6cktlY0NLdVV6M2o0?=
 =?utf-8?B?Smh5N3dBb0M4d3laV0Q1MkNpNWFHMC9yZVR1OHBHYnZKWXpQWEdxT1FGUzFR?=
 =?utf-8?B?Z25QcWFuWHZjMVNFbW9YUjdjempwbUUxaTR6VHJrV2UzU3JoYWFxL1UzSGox?=
 =?utf-8?B?NTR2QUJ5em96RW5EejNaWndYdDgxOU1DQ2dDQlNjR29JWmtGbU95VEZJVm5M?=
 =?utf-8?B?dzJWdTFuWnpIRmRvZ3FqdmRqazd6ajNhSTlMUEtiRkd5bGRKZ0JFeFU2WWsv?=
 =?utf-8?B?WURFYXA1Q2pMMkpzbm9sWGVxNXdmMnJWcEl2N1UzNG10aksvT3EvUm0reU15?=
 =?utf-8?B?Z1ltMkRaYk13aFB1RkEyOUg3MWFNQkE0QnVxMlF2YWpwTU9jaDNhWVRXbzJo?=
 =?utf-8?B?Tk1hU01QQTRuSlR1NURsU005UkFYTWQxU2k5WTdMLy94N1B1ZDVpZjJycVdl?=
 =?utf-8?B?Q0s0ZkF5eDE0VGpoQnpveVdoVkU1YXdRM0pmUGh3R3FHcXgySXBFTWdETFl4?=
 =?utf-8?B?dUt6Z2hKOVVjaXQyZHRPVzZzNWNjd3RybG5SZ2svbXdnZ0FQRjBaRlJaY3gz?=
 =?utf-8?B?Q2ZLVGozb1ppMkU0aFU5MGovc2pnaUZrTHI0VUR5MEpQV2NLbU03Zkx3aEg3?=
 =?utf-8?B?cS9oRU5DYVdxaDlPNVB3YU1ZeGh3bVNHZGJxZkFoL2prNW41SHJSRSt5VWxk?=
 =?utf-8?B?YVB0OUNCYS9LNUIwdEtySnU0Y2xIS242cE9wekwwV3B2OURJSDRtTnJMNE1T?=
 =?utf-8?B?RVBTeTFsOXd6Y0Fud0dWSENwWmZkTDZLNXA1emJhcVRsSndXQmU2SzdFeWt6?=
 =?utf-8?B?Q2M0SlZhdGRRWjVkQkJURjZ0ekdFS2pwalYvMHVvS0QxOEdPbDBXWFNCcXJ3?=
 =?utf-8?B?RzRUTWVkdm5tTHJ2N1R0MmNzbHR3QUlNVHlkNTdqQ3ZDOTRHTVJTSXE4YTNR?=
 =?utf-8?B?NHRzT0JLeUduOXVNOFlDYVlxSzlMVUdqSGJpT2tNWnlVUlNMWWllcXprb0xt?=
 =?utf-8?B?UTd2ekNFOEplMnIyRWZoaElSOUQ1RzJiVGVpU1A0R3JHU1VqTUlqMTl3MlpP?=
 =?utf-8?B?bDBCZUlpSXRvZTQxV1pWeXJLMjNnRlltTFNSNmFuNWdrQ3hpNitJVFVrSHlV?=
 =?utf-8?B?akRBcERhL1Z0R2tuMDZmQUVMM0I1RDhJRFM4bmJ6U0xTY3YxT1RkeGdWajZZ?=
 =?utf-8?B?UWpjK0lYV3g4b2FISmQ2eFJnNHRMSjRqWTRHWTQ0cVZtdEpjaERmRHdvSzRh?=
 =?utf-8?B?WjZPWHpOK0QzREhkcWNUNnJxYnA1OXRxYWlwc3dNWVJYaXROT3JmeTJ4c0sy?=
 =?utf-8?B?ZGF2VUNBZ2tXUnVpL3JsZUpNMWtubkVMa29ZQ1ZtOVIycWRBRXpkR0V2OGNu?=
 =?utf-8?B?TGZaaG81NHVyZk53SFJ2TlJRdVVydFFBYlllQ1VzN3dPOUswdlkwUUJiK0Nj?=
 =?utf-8?B?OU4xaUZrMVgrL081TVBIUktoc085S2FmaFIyanZQVnlwbEZ2bERZRHVySVFh?=
 =?utf-8?B?T3pNbyt3ZXRCQ1cvRVhEcDgwWmhyVWtGZmxWRE81aWFBQ2NZeFkvVTNsUnNn?=
 =?utf-8?B?aENtVnppQ2h5TjJhK1ZjYnAvTy8vemdDVitPNGtOc1Y1dTNwRU9KR00vaWpy?=
 =?utf-8?B?TWErWlZnNjBsblVLRlljZGs4V21MSTJFM201MWNmR2gxWkhCR1NyY3VISElZ?=
 =?utf-8?B?cXE0SEpFY1lhMWZwcXNUQStJaUFIMXk3ZzhTUStWNVJWZUV3bnNMQjdWMkVC?=
 =?utf-8?B?WWFTRGNpYmg4b1JXMDVrYlM0THlOWHJNa3FFa1pKL3c4bEVDSEJnK3ZiTXVq?=
 =?utf-8?B?NHR4QXZIRE5ldG9XcmJNUzU0bU81TGNuRVpkN2ptZXk0djR1WWpENFo2T3Vk?=
 =?utf-8?B?VTExZExVRjNVMUZKeWRVeUFwejluVElzdVRtK1Z5N3R1M09MaThQbkRCNjNn?=
 =?utf-8?B?TjQxcExUcWp3OFIva253eXRaVS9URTNwUnVwdXAyNlc5SlM4VGlZRG5HVmlS?=
 =?utf-8?B?MDZubXVwQUZ4UUN3ek9HTEV5KzBXWVhwYXRTb3dXazZkU0FoclZlSWxHSW9Y?=
 =?utf-8?B?YS82RFpxM09WcE96WWxPRE03djRVYlVNbXpGc0VXeTNJejVzT0FjNS9GYzdI?=
 =?utf-8?Q?hczBqEA40UUm7vCUV6f+InDuU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24da4624-0277-4df4-d07d-08dbc5ab14e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:57:58.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4W611bDwVXP7qfoLs8PeooN3wiHGO5cW4BoBJEiFLKaX/Cti5ubJ6PlHGhf2RDbB0Hx6rRdU3EW/UVufjDkPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2023 12:31 PM, Borislav Petkov wrote:
> On Wed, Oct 04, 2023 at 11:05:14AM +0530, Nikunj A. Dadhania wrote:
>> On 8/28/2023 9:17 AM, Nikunj A. Dadhania wrote:
>>> On 8/14/2023 11:22 AM, Nikunj A Dadhania wrote:
>>>> Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as the
>>>> parameters being used cannot be changed by hypervisor once the guest is
>>>> launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".
>>>>
>> ...
>>>>
>>>> Changelog:
>>>> ----------
>>>> v4:
>>>> * Drop handle_guest_request() and handle_guest_request_ext()
>>>> * Drop NULL check for key
>>>> * Corrected commit subject
>>>> * Added Reviewed-by from Tom
>>>
>>> A gentle reminder.
>>
>>
>> Ping ?
> 
> Pong.
> 
> How about you find other SEV patches on LKML which are waiting for
> review and review them, while waiting for yours?

That is a good idea and I wasn't aware that this may work as a good bribe [1] :-)

Regards,
Nikunj

[1] https://lore.kernel.org/all/20230816081942.GBZNyGnk%2FK+nDuBzsC@fat_crate.local/

