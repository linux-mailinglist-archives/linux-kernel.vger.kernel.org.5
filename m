Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99176A74A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHADE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjHADEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:04:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5EF19AA;
        Mon, 31 Jul 2023 20:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzg71hlnkkfGHOJHGhaVo1F9qYKAxymcCCIBQvcLwsWLG2knKmRxN3Jz9/762wCfVcJpCw34GQublGRuvbhvnAASA+sx2RRIkXxMU+ewF/LYcipwBSF+ZcZlwej4ZjqUidoJsf4p4/WbIfCVwwUDv0iC2id3BgtUvKObguG24mTd9lAMqTxrHh/bkpaDiTdLc1ryevz3S85ii1R/OVuMhZ7NgPiMWj9DCMFl9GiSEmcnVtm9YdlkkDnuCYlAd+bAvByI5vwhjGoGRuieH53LEq4KapGFsekvim9XXVV7YJet5O/EvstYwtOjrQ2RJPjesPwpk4qWziKM2e5aLDfp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYy0hNCl/3i4JfVhtNlMGbLRAOKCHBTNjTeaXYpqFCM=;
 b=jQr2TSEDExymbmy0+AlWSDpR2TAZYyfoVQ+gvQz6OyuughxC1lNvDZUdF6WsSkdZ/ROuHZJnKbcVdSOirPFAPAYsYSAvEf/UaDShBMkivLlHmCW3nikvd/1f/rKrNpi2wr8d9wVcGyBj8vAjOS+wwTSqNF7vODtQFJrrAWTenvLj6qiksaDeyk7/TZG3xkeAEcM+iYt0NDL8PXHpV6WInelzddCZBVlkOl6/V6c2pP9cPn5LFVQ9T0ZqSv4yrrhlhBYCb4kHjPgtlNoNIXZO6OxJb7lFadgkW1uUH4lvSf+OmWXXDdFb4dPjvoHb9ScNyXJOIs043NjbsblWaK0bVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYy0hNCl/3i4JfVhtNlMGbLRAOKCHBTNjTeaXYpqFCM=;
 b=nDAZvsMQPLdHXtenxJvQCUsUeHUsMFeG2L75SPQKPP2NohDAiodmuzVwhRbk1HMF31P+ITfUPZMsDUZCDAbhZS8ezjELMtJWVzqXubhD26o1zq5jW3H9QXHaKKKDjUQK1EAXov3SrN6L3X3r/Vuw4XslX5TUKDRKtiQI8UncUxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 03:04:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 03:04:17 +0000
Content-Type: multipart/mixed; boundary="------------twtoQgukQ1lLOmDhRpcR2xvE"
Message-ID: <61b363bc-286a-535c-27da-0f52673768ad@amd.com>
Date:   Mon, 31 Jul 2023 22:04:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux@dominikbrodowski.net, Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
 <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
 <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
 <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
 <CAHmME9r9DC+EMfxQy+HQAkf4AkAQnXNeBmOfCWnBUyiFQh2t6Q@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAHmME9r9DC+EMfxQy+HQAkf4AkAQnXNeBmOfCWnBUyiFQh2t6Q@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:806:f2::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: ce83460b-ee64-4abd-87fb-08db923bfe4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivBgvmgbxZmGQ3HD6xFccxz/3UEtJNhbVVYc29yMRsdtrfEdKAvj7mCeEELcw27EntwDHJRZ6p7bFavkhRjII/OrZUgv+wLGeTOH5ilOoUEgBYVfWvaJxT2/SLAyIryNheuoA9i25E1txxbmdi2FJFeyZd1b+/giCKGJVPrY328xVYFV0BIW/0Ps4GPcUr+ETImiUSwVTtyBsyVlYYx5mJlZxgxxgdf3etpg6vsnVy3IR9m6Oe3lVv69Y8z6py5TPsMuMOWZDsd3L568/ErkdVAba3N93phYImznBeg5RUi0YWqEFUIZhEEn/hE8c8QtvfHDuOztjxFKZhmPRy+vfkdj86DcToNw3VlZEAgJk2E02ptprOW0QKRG7pq6pzRgaYwc3fAb8OTMLiq3a1Op04/8wu0cYLXG7W6PoZSaLOA3Hk8sopGz6XJshuUahQKhPOVsH5kRRiEC4U47B/0a9V39nyMjG8PxwgWK+USSYFooLWh+r++oXdbPX4rrPHspVIwpjUOVsHXyKWOAVOq986niEwZ5EMq48uK6CREIh2kg9uO4xEwq0AVicSfp+PK8Vc1/+2yqNl4VcmGfGxKJwypQ3kwlz3Dvd7cHxzduB4MXuV9dgeLwUZe7ZSi5wigJhskNMzG9PrVqSkDdyAgkgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(5660300002)(235185007)(2616005)(186003)(8936002)(53546011)(8676002)(6506007)(4326008)(316002)(83380400001)(7416002)(44832011)(478600001)(54906003)(66476007)(66556008)(66946007)(110136005)(86362001)(6486002)(33964004)(41300700001)(6512007)(6666004)(36756003)(31696002)(2906002)(38100700002)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek1vTkdIQ1A0cE5EQlZTdmsvTGczQVFoL1RaYmlPTGNXeE8rdkFLL0lxMW5O?=
 =?utf-8?B?MU5hRXJick9tVFdzZlcvMXpPbkZIY2VmbkUxNE5wdUZERmxabHRBU0NoRnpF?=
 =?utf-8?B?WXNudFJyZkM1ZG5sTnJqN3pjbE1BNmFkUWxrd3VVVEtxWUNLYys2aGpQUmEz?=
 =?utf-8?B?bE8venh4ZnJOVUpQV0NRT2NycWJHSmF0UXBWaHlmMlNmYnRSWmFzZldySkFR?=
 =?utf-8?B?cVRkcW14N0RQcHdFSi8yNDFoWjdmRk5CK2k2OHEwSnZGMWREenV3SE9senRY?=
 =?utf-8?B?WHdjVXlHSE9HZExKUUthYWhWdWh4aDgwNktvbXlVMVVLR0xZMFU4QzQzNXk2?=
 =?utf-8?B?bTBsMGVKZkVBc0w4NFk2TXBVa3ZYOVV5SEtVd0xUajNTQVJBKzRra0pTcjFs?=
 =?utf-8?B?REVPMjZtQmxXWjM5L2hqWGtQQWljUDB4VVUzSXJsZ3FaUkRrQzFHYnZidTRN?=
 =?utf-8?B?SHV6K0EzY05WclExMnlySm1SQzhqR1ZqSCtGRDFUNlJHdjBiZDN5eDNudjlz?=
 =?utf-8?B?UzdvWFdhS1JiOFkwZUkyUGxCMnZlZW1abEQzVkVxeDdwQWh2YTRZd2RqczZn?=
 =?utf-8?B?dW4vSGFPSXFCL0gzUDlqMXJtQkxaRVAzMkpvVFRVbTBKYno0dHhYclpaQ2Zr?=
 =?utf-8?B?a3hDRDVZakdCamFtVjc3Y2NWd2F0Y0JHNEk2eHEzRTA0N0hkSmFpUCtieFhi?=
 =?utf-8?B?Qm8vaDZFNGYwL3RYUlA1YXlhT2JycnFyVTE2WHVpSTlXS29oMDNURVMxRE9F?=
 =?utf-8?B?NmlwOGViT29QTHhSUUFxc3dxdVhrdHlnbVM2K0l3R0Y2c3JINHF5N01IS2s0?=
 =?utf-8?B?TURmQUlhQ1JPaUFMRkJqVC9iSWtFR1M3QWEwTm5RN2liQWxMM05FT1RoZCtX?=
 =?utf-8?B?M1hJVDVEcUtPVGxFL1pZckRVd0s1SXZYNHNjQm5ueWNEdDN5UlZmY3N3U25v?=
 =?utf-8?B?aFBucVp3ZGtxTWhGaG9zZWFOSTA5OCtVb1BMbmsyU2g5b091NVdGRjNhRGMw?=
 =?utf-8?B?MGVmTHJkMDNjWVZpY2lFYldjOStMZ2p2UWRPOC9hUTh0dGxlcWQ3QlFiVkln?=
 =?utf-8?B?YkZwU1FwSGI4OVBxVm10V3dnN1dabXhRTDlGaERXMDdlMlI4K1dsbW9JTTg1?=
 =?utf-8?B?L2xhMGJ6UkQvZGJobVM1TWlTYjF5SUxhM3A5cHZCTVpDK2dRUUlUWFpOTUxI?=
 =?utf-8?B?alZpR0NyeDdYNmRXSEtQRyt1aWkyVGcxZEpVTHdjYnZ0bjFyeWR5Ly9DZUda?=
 =?utf-8?B?TG5nODJmekZTdUZMS2xadlpSRERtY2kwaU5Ccks3Y1JVNVFTcmhuQ2Q2aHgv?=
 =?utf-8?B?UlkxWmVDUG5mSWhiOUtYeG1FZXlCOEVSMms4RFB0ZjdMS2JmdEJoQlJ4RUN5?=
 =?utf-8?B?T1VGTWx3STJEYjgxOFdrTzJwUS9yNTR2S3VUSERGSTc5cWVXZER3VDJCNVJH?=
 =?utf-8?B?aENvMjRWcjZDNW5VUldmbTZ2T1c0T0k0WTEzeUV2dzVzQ0hVQXBiZ1FtYnJE?=
 =?utf-8?B?Q0Y2UlpqTys2OHlvVWY5Ui93U3ZGNHM5bTNNNEV6RUZGRFBmRnBQYkYvSFo2?=
 =?utf-8?B?ZjFucmRvb2UybU4xTmhQMXBWc1FTVWIxaFNLZG9waEFOSzBKTDYva0xTd2lx?=
 =?utf-8?B?enJsM3krQnh1S1VuUTFQYk9PL1F3bjBxS3cvUmhPOGw2em1rSm5YRFIzaGZm?=
 =?utf-8?B?Zit4dy9xb3lDWld1UmFoM3NvcWFJNXZ2S0FUdkV6N1puNGNsejBTc2VWYUdQ?=
 =?utf-8?B?MDJZL1ZheGJjbGFFTlNrWDJ2OWFZYlBEZzJrSTYvY3pIN2ttSDRUMFpkak9R?=
 =?utf-8?B?c3IvM0xseUk3UDMza1hTazJJVzU0YkxHcHBZTkdxdnB5czBNdDFrdG5LQk9l?=
 =?utf-8?B?Z3hsQWJKTFhLZjhsWklVNkFJRjNxS3pzS252M2l2bks3STV6ODZaUCs2b0VF?=
 =?utf-8?B?RDllb1RtczBxVTFPQmZTWnNza3d4Z2dYOVRZZnBMdDRPSTlkT0NOb3pZNzdL?=
 =?utf-8?B?aDRqN2h6Y3I0RGJrZjdYUW5FeUxldTRWaVk2MU42S0VBZWxoWnNtTDBoOEF1?=
 =?utf-8?B?MGNtbU16VDRKbHZ2MWJjbHNFWXhHSWFUT056VnVCakxZWGVVRnM4djkxT0ov?=
 =?utf-8?B?M21MTS9MNWtSV0JUc3RlYVA4YzFvZklwVGJvQXhsNTJ5b1p1VFJSRHVSU2E4?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce83460b-ee64-4abd-87fb-08db923bfe4d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 03:04:17.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMaVDBJibBVFQh7HOzqWsYA7ICSCMwnC+pQWy1bIAIAYvYsypt+m4HgbqJ7COnRRvZkhLsj5eWW5BiRVIOXyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------twtoQgukQ1lLOmDhRpcR2xvE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/23 18:40, Jason A. Donenfeld wrote:
> Hi all,
> 
> I've been tracking this issue with Mario on various threads and
> bugzilla for a while now. My suggestion over at bugzilla was to just
> disable all current AMD fTPMs by bumping the check for a major version
> number, so that the hardware people can reenable it i it's ever fixed,
> but only if this is something that the hardware people would actually
> respect. As I understand it, Mario was going to check into it and see.
> Failing that, yea, just disabling hwrng on fTPM seems like a fine
> enough thing to do.
> 
> The reason I'm not too concerned about that is twofold:
> - Systems with fTPM all have RDRAND anyway, so there's no entropy problem.
> - fTPM *probably* uses the same random source as RDRAND -- the
> TRNG_OUT MMIO register -- so it's not really doing much more than what
> we already have available.

Yeah I have conversations ongoing about this topic, but also I concluded
your suspicion is correct.  They both get their values from the 
integrated CCP HW IP.

> 
> So this all seems fine. And Jarkko's patch seems more or less the
> straight forward way of disabling it. But with that said, in order of
> priority, maybe we should first try these:
> 
> 1) Adjust the version check to a major-place fTPM version that AMD's
> hardware team pinky swears will have this bug fixed. (Though, I can
> already imagine somebody on the list shouting, "we don't trust
> hardware teams to do anything with unreleased stuff!", which could be
> valid.)

I find it very likely the actual root cause is similar to what Linus 
suggested.  If that's the case I don't think the bug can be fixed
by just an fTPM fix but would rather require a BIOS fix.

This to me strengthens the argument to either not register fTPM as RNG 
in the first place or just use TPM for boot time entropy.

> 2) Remove the version check, but add some other query to detect AMD
> fTPM vs realTPM, and ban fTPM.

AMD doesn't make dTPMs, only fTPMs.  It's tempting to try to use 
TPM2_PT_VENDOR_TPM_TYPE, but this actually is a vendor specific value.

I don't see a reliable way in the spec to do this.

> - Remove the version check, and just check for AMD; this is Jarrko's patch.

I have a counter-proposal to Jarkko's patch attached.  This has two 
notable changes:

1) It only disables RNG generation in the case of having RDRAND or RDSEED.
2) It also matches Intel PTT.

I still do also think Linus' idea of TPMs only providing boot time 
entropy is worth weighing out.
--------------twtoQgukQ1lLOmDhRpcR2xvE
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tpm-Disable-RNG-for-fTPMs-on-SOCs-that-support-RDRAN.patch"
Content-Disposition: attachment;
 filename*0="0001-tpm-Disable-RNG-for-fTPMs-on-SOCs-that-support-RDRAN.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5ZjQxZDMwMzdlMzdkOTFkNWFhZjE0MjA4YmE0M2JhNzZhNzYwMzFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4KRGF0ZTogTW9uLCAzMSBKdWwgMjAyMyAyMTozMDoxMyAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIHRwbTogRGlzYWJsZSBSTkcgZm9yIGZUUE1zIG9uIFNPQ3MgdGhhdCBzdXBwb3J0IFJE
UkFORC9SRFNFRUQKClRoZSBUUE0gUk5HIGZ1bmN0aW9uYWxpdHkgaXMgbm90IG5lY2Vzc2FyeSBm
b3IgZW50cm9weSB3aGVuIHRoZSBDUFUKYWxyZWFkeSBzdXBwb3J0cyBkZWRpY2F0ZWQgaW5zdHJ1
Y3Rpb25zIGZvciBSTkcuCgpGdXJ0aGVybW9yZSBpdCBjb250aW51ZXMgdG8gc2hvdyBwcm9ibGVt
cyBvbiBzb21lIHN5c3RlbXMgY2F1c2luZwpzdHV0dGVyLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcgIyA2LjEueSsKRml4ZXM6IGIwMDZjNDM5ZDU4ZCAoImh3cm5nOiBjb3JlIC0gc3RhcnQg
aHdybmcga3RocmVhZCBhbHNvIGZvciB1bnRydXN0ZWQgc291cmNlcyIpClJlcG9ydGVkLWJ5OiBk
YW5paWwuc3Rhc0Bwb3N0ZW8ubmV0CkNsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0yMTc3MTkKU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8g
PG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hp
cC5jIHwgNTMgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYwpp
bmRleCBjZjU0OTllNTE5OTliLi5hYzM5ZWQ4Yzk3MDRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2No
YXIvdHBtL3RwbS1jaGlwLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jCkBAIC01
MTAsMTkgKzUxMCwxMCBAQCBzdGF0aWMgaW50IHRwbV9hZGRfbGVnYWN5X3N5c2ZzKHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCkKIAlyZXR1cm4gMDsKIH0KIAotLyoKLSAqIFNvbWUgQU1EIGZUUE0gdmVy
c2lvbnMgbWF5IGNhdXNlIHN0dXR0ZXIKLSAqIGh0dHBzOi8vd3d3LmFtZC5jb20vZW4vc3VwcG9y
dC9rYi9mYXEvcGEtNDEwCi0gKgotICogRml4ZXMgYXJlIGF2YWlsYWJsZSBpbiB0d28gc2VyaWVz
IG9mIGZUUE0gZmlybXdhcmU6Ci0gKiA2LngueS56IHNlcmllczogNi4wLjE4LjYgKwotICogMy54
LnkueiBzZXJpZXM6IDMuNTcueS41ICsKLSAqLwogI2lmZGVmIENPTkZJR19YODYKLXN0YXRpYyBi
b29sIHRwbV9hbWRfaXNfcm5nX2RlZmVjdGl2ZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCitzdGF0
aWMgYm9vbCB0cG1fc2tpcF9ybmcoc3RydWN0IHRwbV9jaGlwICpjaGlwKQogewotCXUzMiB2YWwx
LCB2YWwyOwotCXU2NCB2ZXJzaW9uOworCXUzMiB2YWwxOwogCWludCByZXQ7CiAKIAlpZiAoIShj
aGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfVFBNMikpCkBAIC01MzEsNDQgKzUyMiwyMiBAQCBz
dGF0aWMgYm9vbCB0cG1fYW1kX2lzX3JuZ19kZWZlY3RpdmUoc3RydWN0IHRwbV9jaGlwICpjaGlw
KQogCXJldCA9IHRwbV9yZXF1ZXN0X2xvY2FsaXR5KGNoaXApOwogCWlmIChyZXQpCiAJCXJldHVy
biBmYWxzZTsKLQogCXJldCA9IHRwbTJfZ2V0X3RwbV9wdChjaGlwLCBUUE0yX1BUX01BTlVGQUNU
VVJFUiwgJnZhbDEsIE5VTEwpOwotCWlmIChyZXQpCi0JCWdvdG8gcmVsZWFzZTsKLQlpZiAodmFs
MSAhPSAweDQxNEQ0NDAwVSAvKiBBTUQgKi8pIHsKLQkJcmV0ID0gLUVOT0RFVjsKLQkJZ290byBy
ZWxlYXNlOwotCX0KLQlyZXQgPSB0cG0yX2dldF90cG1fcHQoY2hpcCwgVFBNMl9QVF9GSVJNV0FS
RV9WRVJTSU9OXzEsICZ2YWwxLCBOVUxMKTsKLQlpZiAocmV0KQotCQlnb3RvIHJlbGVhc2U7Ci0J
cmV0ID0gdHBtMl9nZXRfdHBtX3B0KGNoaXAsIFRQTTJfUFRfRklSTVdBUkVfVkVSU0lPTl8yLCAm
dmFsMiwgTlVMTCk7Ci0KLXJlbGVhc2U6CiAJdHBtX3JlbGlucXVpc2hfbG9jYWxpdHkoY2hpcCk7
Ci0KIAlpZiAocmV0KQogCQlyZXR1cm4gZmFsc2U7CiAKLQl2ZXJzaW9uID0gKCh1NjQpdmFsMSA8
PCAzMikgfCB2YWwyOwotCWlmICgodmVyc2lvbiA+PiA0OCkgPT0gNikgewotCQlpZiAodmVyc2lv
biA+PSAweDAwMDYwMDAwMDAxODAwMDZVTEwpCi0JCQlyZXR1cm4gZmFsc2U7Ci0JfSBlbHNlIGlm
ICgodmVyc2lvbiA+PiA0OCkgPT0gMykgewotCQlpZiAodmVyc2lvbiA+PSAweDAwMDMwMDU3MDAw
MDAwMDVVTEwpCi0JCQlyZXR1cm4gZmFsc2U7Ci0JfSBlbHNlIHsKKwkvKiBpZiBDUFUgc3VwcG9y
dHMgUkRSQU5EL1JEU0VFRCBpZ25vcmUgZlRQTSBmb3IgUk5HICovCisJc3dpdGNoICh2YWwxKSB7
CisJY2FzZSAweDQxNEQ0NDAwVTogLyogQU1EICovCisJY2FzZSAweDQ5NEU1NDQzVTogLyogSU5U
QyAqLworCQlyZXR1cm4gYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1JEUkFORCkgfHwgYm9vdF9j
cHVfaGFzKFg4Nl9GRUFUVVJFX1JEU0VFRCk7CisJZGVmYXVsdDoKIAkJcmV0dXJuIGZhbHNlOwog
CX0KLQotCWRldl93YXJuKCZjaGlwLT5kZXYsCi0JCSAiQU1EIGZUUE0gdmVyc2lvbiAweCVsbHgg
Y2F1c2VzIHN5c3RlbSBzdHV0dGVyOyBod3JuZyBkaXNhYmxlZFxuIiwKLQkJIHZlcnNpb24pOwot
Ci0JcmV0dXJuIHRydWU7CiB9CiAjZWxzZQotc3RhdGljIGlubGluZSBib29sIHRwbV9hbWRfaXNf
cm5nX2RlZmVjdGl2ZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCitzdGF0aWMgaW5saW5lIGJvb2wg
dHBtX3NraXBfcm5nKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIHsKIAlyZXR1cm4gZmFsc2U7CiB9
CkBAIC01ODgsNyArNTU3LDcgQEAgc3RhdGljIGludCB0cG1faHdybmdfcmVhZChzdHJ1Y3QgaHdy
bmcgKnJuZywgdm9pZCAqZGF0YSwgc2l6ZV90IG1heCwgYm9vbCB3YWl0KQogc3RhdGljIGludCB0
cG1fYWRkX2h3cm5nKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIHsKIAlpZiAoIUlTX0VOQUJMRUQo
Q09ORklHX0hXX1JBTkRPTV9UUE0pIHx8IHRwbV9pc19maXJtd2FyZV91cGdyYWRlKGNoaXApIHx8
Ci0JICAgIHRwbV9hbWRfaXNfcm5nX2RlZmVjdGl2ZShjaGlwKSkKKwkgICAgdHBtX3NraXBfcm5n
KGNoaXApKQogCQlyZXR1cm4gMDsKIAogCXNucHJpbnRmKGNoaXAtPmh3cm5nX25hbWUsIHNpemVv
ZihjaGlwLT5od3JuZ19uYW1lKSwKQEAgLTcxOSw3ICs2ODgsNyBAQCB2b2lkIHRwbV9jaGlwX3Vu
cmVnaXN0ZXIoc3RydWN0IHRwbV9jaGlwICpjaGlwKQogewogCXRwbV9kZWxfbGVnYWN5X3N5c2Zz
KGNoaXApOwogCWlmIChJU19FTkFCTEVEKENPTkZJR19IV19SQU5ET01fVFBNKSAmJiAhdHBtX2lz
X2Zpcm13YXJlX3VwZ3JhZGUoY2hpcCkgJiYKLQkgICAgIXRwbV9hbWRfaXNfcm5nX2RlZmVjdGl2
ZShjaGlwKSkKKwkgICAgIXRwbV9za2lwX3JuZyhjaGlwKSkKIAkJaHdybmdfdW5yZWdpc3Rlcigm
Y2hpcC0+aHdybmcpOwogCXRwbV9iaW9zX2xvZ190ZWFyZG93bihjaGlwKTsKIAlpZiAoY2hpcC0+
ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIgJiYgIXRwbV9pc19maXJtd2FyZV91cGdyYWRlKGNo
aXApKQotLSAKMi4zNC4xCgo=

--------------twtoQgukQ1lLOmDhRpcR2xvE--
