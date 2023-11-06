Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B47E3198
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjKFXrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:47:35 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878C95;
        Mon,  6 Nov 2023 15:47:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFLV5CTI4v0uPNfind8hq51JeV1R3A4+TA0Sg+/gpr9IyNBRDUeKHH92eLfnCBoSkJrInBm92XyrEIQUKh3HBAAEEqZYKPKuiUcyVv8rmx2B0IqCHzoaluwvyt05B14Z5fo5SFv0IKEoG9aYmEl3QPB88PI22r7mxo9RgQsj8GugjuTqQJDZ6keLsvneV8qHqTJXoZo95VeQC9xHiV8/4D670BSOi97wDrW9EU5N/+uIVRPOE0MjzFxtehDoxipRqSymflCnm+DeFfAJjgO51LXJtj49NNyKvm3OwqFglWOnhZxxEt2cwNnhFApvdJmgnhlldutaxD3khgOkgfbkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0xMfxzhhnyxFQXGU8y3kAVuKxi0egh2ufOtPnEI5wc=;
 b=mOJgg0j4KZKxWWjLlXAjTekb6xAyUZ4vvPsni0f9Ed6dZfPHNWNYGZEI8seoZ8d3hdA0u9HCQ8RmX13fkgOOcXRLrS1C9hljlOeiarPtOxheBjFV178vJRoOyn6+kqFVjMZ7SNeQJ+QbfBO06CSzszyzGlL8Zdw+HksvQgd7yU1Y6uOa8HzGCYIhMcwOVjuOicDeH93ajtCHo5fHoOXVB9JF0G8liW3zPIBA7Vr5VdC4Rs9PfuHQFkH2TziOkqDP/g6G4h8b8KRD3S+F2gcvQfxxZbbAQjxBR/wYFtzcYo4FPXj8KvgTieasxqrE+ciDPY2vGlP6bkGX5Tb7Xt/gFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0xMfxzhhnyxFQXGU8y3kAVuKxi0egh2ufOtPnEI5wc=;
 b=SXuxRgcGT8/oesZp9dYNNBwhdt3tGSpfoEfBrJ0/OWalYy36zSlW/hpiTrzJPTVgR8o96BCaCYIOpegYQsiMF2/jhgZpqj18v+i7gAgmX3WJXxfqjqmPI9vP4cUJGNqe9coWRaN6xaNvRdFzdRkKlEt3fPveh3i42d7gNAq5nQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 23:47:30 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 23:47:30 +0000
Message-ID: <8e059965-5196-4dc2-9cbd-828443f7e7ec@amd.com>
Date:   Mon, 6 Nov 2023 17:47:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        Avadhut Naik <avadhut.naik@amd.com>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
 <SJ1PR11MB6083962F7F6C4C535EE1CB94FCAAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083962F7F6C4C535EE1CB94FCAAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0122.namprd07.prod.outlook.com
 (2603:10b6:5:330::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f9a3f7-aab9-445e-62e0-08dbdf22bd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbDR9CgFuXTjWKNWdjzgxRJAukRhQNOj4wTsBh/awEmriMR8AwUe/h8PoqoLxTThiNtLegNeX8scuewwyvgSaEqMnRZ1Et6T4I6GKl33GSxBQ9KU6RgikXSi4pFgV4nQphuwLGFlUxeAsefudmY3DzwR70iJXoNjz62hEny8re9MGtf4czp+Wn1hyesnKD5/KG/v4mxY74WRu0o355YvhF1zF9NZtq6Gp3S2pD2SArXuaKkv7vXH24JI9G4Ijvs0V5tOGr/3qKDPIgOZhYrRczeX57uRHj4IfZjPWcj5No+AcScp/0QBYjeG1is/jk4noarXqC5X89ug4HIj7rrKqWa5/ZY3ygZaTXANnep4dUKoCxYLrlI2zl1LEOQbRTGc54JE8FtB3dU8mbre7dvx9hbPokXScqX2m1rAiYtktvIRdmvgWj9EFj7vlRn1B3Czor8eI8URCdabv4n/81C6IBa+VgQPGd0YhhHxDflDQ41BbLgrF2/itnY7rKesXVpq9HnaECYg7oBVl7tivcX+ocDcMoeBd5EqgKm37NyzhqHOzeaV+bPL6c4I/PjRAVEvRdoQBPKq+nS43N85voZXQ1rAgFfnjQO3zHidkREqDxsIJA1hrliDksWab2LkimNG+wVqOtiJZU2rFnO0MP67mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(316002)(66556008)(66476007)(54906003)(66946007)(110136005)(36756003)(6666004)(6512007)(6506007)(53546011)(2616005)(31696002)(38100700002)(83380400001)(6486002)(478600001)(5660300002)(41300700001)(8936002)(8676002)(4326008)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEMvZ1JqalhMWGYxY2tjNEVGL0pPZnBMTWc5VlFYcW1mRGVtVGM0Vm5zR1JG?=
 =?utf-8?B?UmIyVjMyYTNOaWtydngxVHlTMmduZUFrSVpXTGgzL3JNTFRwbHdSSmVrcmVQ?=
 =?utf-8?B?M3lqV0s3cXFvWjVUU0J2bjd5ekowQ1ZMMGhLM2dlQlFmM1NGaDdjVUVaem90?=
 =?utf-8?B?RVZNeG5LUktBbWFSYW0wVDRUcTU0aUU0Yk5uRU04RFBsWHFPbkdKUDM0MGta?=
 =?utf-8?B?QTNNY0J2S1Fyb2ZUM0FsZ011RUlHa0Q2THp6SHlUY0RlaWFQZkNrWjA1bHZv?=
 =?utf-8?B?RUZNSjNpbzZ2ZXFyME5yQkRMcFZpMFUwVnpHOHpZR3ROdXU2cFRBSmtWWU9X?=
 =?utf-8?B?L3J4MEdSZEFmNjZ4M1gwdjFyNXNwendEZENTOHR2SGtIbFJmOFJKRGEwV0ZC?=
 =?utf-8?B?Z2o4UVBPN3JYeWtJRlRQSU5mZGpvZmNqYnpkcDJqTitNWWVmVDVWR2NlVTUr?=
 =?utf-8?B?blA3VzQyLzZsUCtqaGFxaTJPZnhkaGhhYVRTSGI4c2FWZWZRYmlqRldoRTRr?=
 =?utf-8?B?KzMwZmdkblJ6WkJaY0JXZUNaTDZ5VDA1ei9BMmFNSkxTOWdCaWZoaThaTjIz?=
 =?utf-8?B?ZjE3ZzRDWHRMMTFHTTYyU0xzcmdmOXp2YVRxTjl3VDQ3Sy9xbVM1a2ViQlFU?=
 =?utf-8?B?a3g5MTBXWXVlQ2FlMFpmZkF2OXpWa3RrQjB0ei9MWFZzMTJPKzZsaVRvOEto?=
 =?utf-8?B?aVVaTzE0cHltLzdIa0M5QlBUK2hIR3pGc2U0RTNEbHVvM1BEeU1xZ1dqQjNX?=
 =?utf-8?B?eDBVSy9VQy9vS3FDTzFyZWhZNVNPRU1Za0JFZWkyMk1YZmwyTjNzWFpPRHNV?=
 =?utf-8?B?RzhSL3Nncm1wK21rRVoyeStnZ2craDF1OGR3anpHaTFmNlBCT0lpQlluaE02?=
 =?utf-8?B?czVGakkvT1ZacDMzL1loamNDTjB5UHo2Q3BBRktWSHJ5T2I5NllMcWFndUZK?=
 =?utf-8?B?aGZPcERGcEY1MDN1U1YwbEJnNm0xbzY4eTRtZXpwMG1vS1pnbDRuelo1b2pG?=
 =?utf-8?B?QXJoTnpwdmljZTdXSmVnRmtSUzlzQUhBVWJhdmxaWmJ4d1ppUjdxUjJXamhV?=
 =?utf-8?B?dnNDTjNJR3lKSW9kUjUwNjgyeWRQaGdCTFUvTitEYWk4cWJJT0RTL212dTdU?=
 =?utf-8?B?OWxKZW0yZzAwTkdaTUxvWmptYkJQTk41VmQvcEZ5cllMSkl5TnVYUFJ6WGkx?=
 =?utf-8?B?WGpLRzBtb055MlNrMEd6UCtwUTZHTkNCMTdOZGt5RW45R1MzNTd4d2lrY0V0?=
 =?utf-8?B?Q1lSY1B6WWlPSXlBZWUrZFU0QVp0MzBISEZSRDlPc2hka1RXa2IyQVBRSk0x?=
 =?utf-8?B?ZlNzMUJhdUdZaysrYzNPazMxUkRzSFk4Z29IZmxpK2dPNUhpY3hnZVNpUWNl?=
 =?utf-8?B?Nm5ML3JNQW4wemxhOGg2SS9pc1V3VU1ueHVjSmpXd01sMTJXZlZsR3JVdStZ?=
 =?utf-8?B?TEU2TXJOajd2VmdCRTFkd0dCNDRjcXNjUmpXS05ZNmpPK3RzeTRoK0doWnll?=
 =?utf-8?B?cXIzMkg5SnZjbHpxRzlteExWNDZ6cS9Rb2xsK2VHZjdBbVpkSm94VXhjZklG?=
 =?utf-8?B?aWZiRjB1bVRkN3U3cGRmTzRrYVdQVkgrT0ttdGhhZEZoL2Rja1duYzI3R0I4?=
 =?utf-8?B?bTRQTVJ5b0ZnamtKYjUxMnR4NkhZbEJnSEJrTHNSeks5NS91WGNFSGxEUHhO?=
 =?utf-8?B?Z3EzNFZOTFlUZElLUzQxUGF4UXpBZzc5bUptK2ZGQVZsSHB1ekEwemVtZUxo?=
 =?utf-8?B?ZVJEeDdQcDNHVDZheTFVby9qVisyTFk3ZTQ2MUI4S1YyNVhUMEVjMkpqeW4w?=
 =?utf-8?B?akdkNHNBMjNXMUlpWXQzVmVYb3BMWEdNVC9zQkZVNUR1NjFrV0Z3QU9jMUhL?=
 =?utf-8?B?K3crcm00QW5Hd0FzZzI1bG02NURzT3dvdWRoclB0eHFJcTBKSGlGTEZmR2ds?=
 =?utf-8?B?d1ZQRktVRlMvT3MwbVpOc2kyTkx6Z3diMnoydDZiTG9aQ0RteklMQklDOXN3?=
 =?utf-8?B?ZDk4c1NzMzZrcGdxOHVTdjFGWFBORFJXODNTUEk5Zkw0OVlvVlovTU5tajli?=
 =?utf-8?B?d1ZDeDNVZzVQaU10UG9objI2bFlFdjhMWExLbWgvWjdVUi9nRFI5Q29pUFFx?=
 =?utf-8?Q?je5TI5UHYIU2zwfoVAKsZr6w5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f9a3f7-aab9-445e-62e0-08dbdf22bd06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 23:47:29.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL0gCKyp7tugJVyN9LYrvY2f6LQpQ2tb1ETagPOnEDFi35uwcEUZKwV1UE9UvD2pjqVV5EzoruDHPjz/GE10+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/6/2023 14:42, Luck, Tony wrote:
>> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
>> a set of GHES structures is provided by the system firmware for each MCA
>> error source. Each of these sets consists of a GHES structure for each MCA
>> bank on each logical CPU, with all structures of a set sharing a common
>> Related Source ID, equal to the Source ID of one of the MCA error source
>> structures.[1] On SOCs with large core counts, this typically equates to
>> tens of thousands of GHES_ASSIST structures for MCA under
>> "/sys/bus/platform/drivers/GHES".
> 
> What combination of CONFIG options and BIOS table support results in this?
>
From the kernel side, CONFIG_ACPI_APEI_GHES will have to be set, at the minimum.
From the BIOS perspective, it depends on HEST Table implementation and whether
or not it supports GHES_ASSIST feature.

The actual number of GHES_ASSIST structures will depend on number of logical CPUs
in the SOC, number of MCA banks per logical CPU and the number of enabled MCA error
sources.
 
> I don't see much under "/sys/bus/platform/drivers/GHES" on my lab machine
> (Dual socket * 36 cores * HT = 144 logical CPUs).
> 
Does the BIOS on your machine support GHES_ASSIST? Can you confirm the number
of entries you actually see? 

Typically, bit 2 of the Flags field of MCA Error sources in HEST indicates
GHES_ASSIST support. Below are the results from one of my systems without and
with the patch respectively.

This system has 256 logical CPUs with 28 MCA banks (I think) per logical CPU and 2
enabled (Machine Check and Corrected Machine Check) error sources. That's a total
of (256*2*28) 14336 GHES_ASSIST structures for MCA in HEST.

[root avadnaik]# ls /sys/bus/platform/drivers/GHES/ | grep -i "ghes.*" | wc -l
14349

[root avadnaik]# ls /sys/bus/platform/drivers/GHES/ | grep -i "ghes.*" | wc -l
13

-- 
Thanks,
Avadhut Naik

> -Tony


