Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F17CC790
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjJQPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:36:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408FC9E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehjf/RHsfAJAuvico0SE7toHambUoh14FCWUUqPYOdxqTYleE7LZj3IhVSVJZS1cIiLFZ2x18o4Xd9W8H7cnnxQJoClbB6BDSOLIH5BbzxNqLCqof41vK6WcoiQai24TfOOFzz0tefWsGHL1vZz4LvieWLXztbJgLFI2RoNBuKkZWEmW5ALt+EWut+btIifcHhUjmY2/JaG1n9ebS2EURAONWOGQ8DEt8ecs4UfHVaspkqndco1RLYyIeZupixxBZoApkzh4rNaG3BPgW54rViMBxGYuBS6kvbtMcYdGTBySI9K5iaJ7EEcxpqE0+0axIB/zGnEcN9Qv9+Z7ktJJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKdcrLCuJJzUpgCNrNv2TZRokTRZnqp6o9qE4X+24K0=;
 b=EF6xruRtoMAtBo1toj0veeiwsyTGa8qHP3+CqTxSfpdWxZ+9m/gaa72VyMKT//pSQ3BzimKj8AxvkZwo45LjrRA8BfjQYP2zk9S7UvozwL1Ya8xv0TgBEC/DwMT6tfz6/sEtc4jSIVAT45vf2ROAZ7imkV1CN+mtZXGR6TnYzusJxaFaYSy346JpVG4ZAEScKw7aPof74XZkUhGmhOBdSMOHVm6yz7BxLIuBLlHd7VTZogNTxD+DUiNC/FN09C8RLlM5GPPA4j7G6v0FLYAC167Go9n/u9ZWF0sFPfJ+ljCZg72eh5VTfHVJUXU8EfSryED4r2q8onbtoPPan6sF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdcrLCuJJzUpgCNrNv2TZRokTRZnqp6o9qE4X+24K0=;
 b=BTQ0bEUTx85vwWWnnn0lZS6UIoFJbUJ4LF2WYCQb34EmCkRKH5KMRa8hVRTopr5NByzTEMNSbAy4btaWA9hBcgC0muOPHLhFjR1nozJSV5K8fd7LlArp2a9PRipBm314O4gzZQjWDHPl2tKzESluFcHz7va9rCyAkjyrDOfN0Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:36:17 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::90d5:d841:f95d:d414]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::90d5:d841:f95d:d414%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:36:17 +0000
Message-ID: <44477b0b-af38-569e-95d9-e78c118c9d18@amd.com>
Date:   Tue, 17 Oct 2023 22:36:06 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun and
 destination fields
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     joro@8bytes.org, seanjc@google.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
 <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d348a00-5dad-4946-09a4-08dbcf26ce03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDh3sImBuTHqt1s9mXewXazHkJS/XTevadnALShY1fJOPsy2vDrfmFskoC+mOb9dhxFpH5iDq37RC3gqvXWl/m6aBjBGQi/0UXjmiT8/2r4nlla3Tdkj8hpY3ZWBcS4xm7eG0ttZnOtP5nGSM1OUHBf1jg2kQcdUyFNXolcXMxyhtNOEyGPbaqQbrkiaLAyYBmqukjl41fP3onF1PcsKDWiT6P8ehGBahv0bduir/2/V7nOygd2FTb9vFjrNR59FP3YAfE/MwRVd7ZyqRdtSiVsWjVbqrpqf88zhpzjid37r/3MMSO87RliQKLhJvsi+97vhkzJYEjQY9+7LGWYe1D7drnLziKvAlhezl/wnwYIS4rUGm9ifrkkzLv2Crv9a4EZkfkZE8q3REIC67gfMebsAIE3ZvJc8LJVGylulVyfeiCTCzPKS5WKXST49y8v0Rzk+FtJTd2a6LSFe1Zw80p+RH13zaQiy66y02AKfN/O/CQZygk5Vx4RExURSk9CB+YmFw/QQwlwnPhRSiGhrp003jrRbqmQ+FgGD/jwTh8WfUB1AGKhw246+RRWkYebouuCSJLhVRMqjpGPmz5PwrN2sQzuM4bIFANAGHCNoYmdDNuabgSbyTHtFtyNy/RG9dAi+EZX0q6tVzfKMpFhByhkGHV4zRUjcFD03TMDUTlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6506007)(31686004)(6512007)(6666004)(4001150100001)(2906002)(5660300002)(8676002)(4326008)(8936002)(41300700001)(66476007)(66946007)(66556008)(316002)(6486002)(478600001)(53546011)(2616005)(26005)(83380400001)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amVhb1RKWklvU2pmRW5SdGxSSjhYNkpVRzZIdytNQTlJcVlpSUFTYnNOeW5X?=
 =?utf-8?B?RDBPeU92MUFhQlYrL0VUUy9LbExRU2tQYkdGd2k2QVEvMWxUdWd4SXVUVmhN?=
 =?utf-8?B?dlljdkF0dVZNcm5WVFFiRExQYnlqMXNUVE8zWWxZSVYzME5TdlFDY1hTV2pu?=
 =?utf-8?B?bWYzSW1mV0VrT25zVWluYkZ4bGpBQjIzcWJYalg1VXROdndZMkl5U1NHb1ZE?=
 =?utf-8?B?Vk9PUlIzcXlzMTlPWjlGZzEzRzR3c0xYaUF4Q2ZqM2cxcElmRTNEdng2dFZ3?=
 =?utf-8?B?UnBUN3EycGZIeG1FUXljODA2b3BadVFnNFZLeTFPeFloeTBGdHR1bDViR0R0?=
 =?utf-8?B?aHhSRVByeit2UUttaUJ4bkJ2SmtiOURlNkE2NDlyRnVGaldwUWZnOHVzZlpa?=
 =?utf-8?B?azM0QlBEYU9WVm11L3pDektJd05mRTNwLzhZYlNESzEyaVExNUFrZkFvSWNv?=
 =?utf-8?B?UWVtNzcvKzZjM00vNVlvb2lmbVhlb2FFN3JpSFZXTlBGMXJuNVF3MFB4emQ0?=
 =?utf-8?B?N2lVWU9iRjhZaVlxQmc3WVhnZE5scndLVzNmQTJyUzVYYkRGSmh0Z3J4UG85?=
 =?utf-8?B?ejl0TlRDS2JtQXE0SFJCZEtkOEdKM2oxeXZ5UllWWGI5d1VuT0dPTDNDd3Nt?=
 =?utf-8?B?QVVSd29OYVRnZXdwN05qTDVTd2htTDgvY0NucTFrdU5qZVVMMzYwclR0dVNx?=
 =?utf-8?B?YUpXNVJkM09GcmhBck9jMEZpZ05HdUZrNG1DYWlKU09jRG1kZ0U4VER4TjRS?=
 =?utf-8?B?bWQvUzlUS3Z6emUybFY1dWZtbU1xL0xIazhuTnpFVEM2S1VJRjBIQ3MyTTI2?=
 =?utf-8?B?WllvRnVhVTRLUWluU2JNUjVTOHFnelE5dHlmeVV6bXM2VkYwL0JFT2Q2eVdn?=
 =?utf-8?B?V3pOSXViU1E2SnZydmxHRnpqeVpsSlZkWmszblZhcDlPYUJoM2ZxbkYyVUNx?=
 =?utf-8?B?dUp5Kzgxb2pPR2NESFRwbW82bWgxczlpb3B4ZTdmZWJZWms2MXFBSjRHN2wz?=
 =?utf-8?B?TWJzZCtOVkc2TzdLVnJzYkc4YU9LQjRCamhRRnIzV21HdGkzTEhGMFNsN3I2?=
 =?utf-8?B?cW9IV1praGpDTmcra2I0UUJrRUtoZDhDK01LTHBvUDFoZUh4UGkwNzhtSGlI?=
 =?utf-8?B?WkpqbC9GYmo5eEFwa3h0ekFQdWQvUjJWTS9oS0RzeU5kb1cxUjVUZ1dGODZi?=
 =?utf-8?B?SFcyVklSTjJGUDk4cnRTbFFqRGJUNkxSRDNQZnRYalNIclU4NmY5RkpEUmcv?=
 =?utf-8?B?cXJTOWVNS1I5ZWxTSTBYay9IYlZDdUNRV01VbTFDa0Ivci9GcC80dlZnWkc4?=
 =?utf-8?B?K2RrVHNLYWJPVncxekpveHVZRC9rZUVoa3hGclNnUFlLYnhNTW9Pd20zUjdY?=
 =?utf-8?B?UFQ2Y2o2Sm1iM1YvUTNZeThtTUxoNkgyaTE3UHlaRDRnOXhrWVBZdmQwalRH?=
 =?utf-8?B?TXhtcXdyQ08xTHAvZ0pXbnFJbVB4TzRTOGJLN2ZxSVh5aktjZVZBeS9DOUtu?=
 =?utf-8?B?aVpGSERTRFlKaFBiVTFuYWJrN1J3Vld4VTE1cmlnd1I2RE5nei91SkpEWEY3?=
 =?utf-8?B?cEJ4c2ovZFZZRVlILzd2dmovK004djJTNk14em1lWFZqaU10bGVrbG5yRTZ0?=
 =?utf-8?B?eVkvaEpFbEJMcEY5ZEJRdGxQWU9uNjNIVExwSjJ5am05czl4SG9wbVBoOE1Q?=
 =?utf-8?B?L2tybStBb1NDaUtYbW1NY0hiSVkxQTQreW84YnQ2M1QzNFBvaUdmT0VISS9X?=
 =?utf-8?B?WGtXWFlyOFJ1NWk2cUg0b3NGS0VXZ1paamlMMVhnTkxjNWp4UHZORVNscGFS?=
 =?utf-8?B?NVNJeThHQ2U3cy9zREZVRlFnbXhPSDc3dHVlM2daTzF3aC9WYVMyaXFJeUNX?=
 =?utf-8?B?Qkh5bnAvUEhoRjJYRnZwajd5cEtXOHlPY2F6SE5WMFFrWWNadEJRZHFSQzFo?=
 =?utf-8?B?Qzc5dlJrV245M0gwZWtCRHNjczh1YVVYUFVDZXFmMTJXS3BWM2JFU2RJMEZp?=
 =?utf-8?B?cGY4ZG1WSjNyVjNzZ3ozQkZWU2RDMWdvUDJJMjJxa0NUakl2V1p5T2FSM2dF?=
 =?utf-8?B?M3M2eElnT1V3dnI5a1B4OHhSMHloYjJZQmk3MElrVEZvbFFYUDcyVFNMUVZ4?=
 =?utf-8?Q?Z/r+CDOgRx+Lfol050aB8oxvp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d348a00-5dad-4946-09a4-08dbcf26ce03
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:36:17.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVyfSJk8dluW1vIM5xpDsv08AQDOLKnSVBufddsuTl4sccpaLeT7Gi/34nFT5a/RVDXLIokRMJ4909ks4b6V7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 9:51 PM, Maxim Levitsky wrote:
> У вт, 2023-10-17 у 09:42 -0500, Suravee Suthikulpanit пише:
>> According to the recent update in the AMD IOMMU spec [1], the IsRun and
>> Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
>> cached by the IOMMU hardware.
> Is that true for all AMD hardware that supports AVIC? E.g Zen1/Zen2 hardware?

This is true for all AVIC/x2AVIC-capable IOMMU hardware in the past.

> Is there a chance that this will cause a similar errata to the is_running
> errata that Zen2 cpus have?

Please let me check on this and get back.

>> Therefore, do not issue the INVALIDATE_INTERRUPT_TABLE command when
>> updating IRTE[IsRun] and IRTE[Destination] when IRTE[GuestMode]=1, which
>> should help improve IOMMU AVIC/x2AVIC performance.
>>
>> References:
>> [1] AMD IOMMU Spec Revision (Rev 3.08-PUB)
>> (Link:https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
> Looks like the link is broken.

The link above is the default location for AMD IOMMU spec, (which is 
currently being fixed). In the mean time, here is the temporary link to 
the latest document.

(https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_3_07_PUB.pdf)

Thanks,
Suravee
