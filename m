Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05017D4741
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJXGS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjJXGSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:18:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD9C0;
        Mon, 23 Oct 2023 23:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLOf+ASkq8m7vsi4Jwj7mIW1nAbz1UmdraQjrgpJqnV/qjFVJuJGu8CLlgewl6oT/KKLz5xO+mtY0dEPJN9TGNp8QAWKylH/sByEWHEjvgV1t6TfOySzFmopwRMJgCg8OARy/MMlgH7S6/c7VuCfD4NEURyEaPey1HOD3DzsbHK1Nl4gd5lwRq7xG6FO0Je+5n62u86HyL/pSVAGYipBXztUDuliwH3AOuopM/PO7Fwmhpdm+l3wEqEsVSHdTnnhTPr/18VXkXGlPA78ecP1B6DojTg9iUjGockdErCOw90pMO74ugST7Bx+gIZdt4DJ33rGZXwU28240Jn7T0OHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQrDV+1ceskPHbnzMlfJEPmAtXQ3t7Rr+8uusHi+sYA=;
 b=cQJ9KGZsT14EfjuNtYWA/MuiIPkaCHylbKc9pnItov+LHdHeEsVOON8hxZw3ilcoF5z3LR4DHnD5CH4HFtfBMORCtyD+Loho2nKquu3RN9RablUSewCCXydjCM6Nt7G4tF3RCU984xBzGwsUSHaHm9coMhMN/BVaxcUMx7aOnVkA0XLgS2Uzz33XPNwF/evtII9tP2/ovG/gD9iObc2VPJ4PM5a+UAjR2f01fVWTwqh1yEIp53IlcwC1yybq2s9oCuU1JF4ilLtXXqSNYenFxVDxeon7jm7PanYv1Gs1iV2PB9XzFdARaBISZosHM2hctocoHpV+y2+4jMpOeTl0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQrDV+1ceskPHbnzMlfJEPmAtXQ3t7Rr+8uusHi+sYA=;
 b=Sy439v6656Dms5rxeyT4PdW/9VjE/J76wX6tU5D2Ug4rdRhtC1RjS6Z8t0Q0bVjTfpBcwg0jxM+Mdnn31F4juCP8pTNS19Ij6hbipl/fjOmg1xjruVDCHWaKYNeyaVXKFxULbxIg1jGdij8Q6H75pDsJAyme3HEPVDXHhIC2Ldk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 06:18:49 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 06:18:49 +0000
Message-ID: <90f7a38d-00ac-a5c4-436b-c5a1a0901ab1@amd.com>
Date:   Tue, 24 Oct 2023 11:48:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/7] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, Muralidhara M K <muralidhara.mk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-3-muralimk@amd.com>
 <20230720135950.GHZLk91jGbX7l+7AMz@fat_crate.local>
 <b70fa364-2f68-1336-8d1c-7687f5c4f1b4@amd.com>
 <20230720155533.GBZLlY9cgqIZb2kd5J@fat_crate.local>
 <74beab00-091b-0359-0ef2-da6a9d34bdd6@amd.com>
From:   "M K, Muralidhara" <muralimk@amd.com>
In-Reply-To: <74beab00-091b-0359-0ef2-da6a9d34bdd6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2bf3b7-223a-4836-61f5-08dbd45915a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nDG9AQktcWqMCDPS17kRVp2oReKC4IYW0TNgzKypjBaC0Mu1KAaVN7EadIZ/58HaczbrqN2yynd5xqJyRX7qSatjclTwHE1rzShcCSdmyKaaDs3zwnOFfHDFXsHw4mhy9dZ8F9LvXvSZKVAg4SrM41IVo/0DGtTPy3lbB8pY89gISE9+KFUNSqEdou0u786MWmFYuaqVAweXGNHQ5YMW6bhQh6FHi++OAg3yIceWdch5QJoYD7N+/sdbJn860cL8RWPvCsEdKSCjKqdsBfUZLs/AYn71OVx2r95GMPdCb9Q+G9NY0Pg+93WOSH+ViSORvJF2fJnkTXt8VMvJDfB1dB9kp3M56qM1nONg5olGQQhzWI3ElARINldplyCBIwzF2CUSL2Dxp1yKHRQodIUTHvctsL8fkI+nZgs5gTMi1MG15qagV25k3xijXbI71xqB82USm+K4F+t2+I+MRDW8WzRWrW/hoWitbiCzrzdQDgl5/jqmmSDWpcdRCUUC2wKwYIWVhXnKWbzXWnkuChSk2ysSW4qq8dXlSEi0gzdqw5882yWoYrO9rAfzZiURrQkTGzoUmVLtO7aM+rZ63wJVlN3gAZ1DlFUHItkywNiqhgyG90Pk8Xplu8xdzdRtbfo9WzILcWrviqao3ElAlmU46f5b4IDtXNmpwCrI8Vvj2CKSipXd5NXhFbqgxt2THox
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66946007)(66556008)(478600001)(110136005)(66476007)(316002)(966005)(6486002)(8936002)(31696002)(36756003)(2906002)(8676002)(41300700001)(38100700002)(4326008)(6666004)(6512007)(53546011)(6506007)(5660300002)(2616005)(26005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRvQWhUSUd0OTd4Um9YcFhJK3h2L3VVWGJpVEs0NUo3V3lmUTl1ckMxZ0xk?=
 =?utf-8?B?WG9KTGtpVFArc3JpeU1iOWQ3UzNCWVJad1dkLy9NLzF2SGpYSkNRNlo1NENs?=
 =?utf-8?B?NUk1eUI5aTlNR0hjbU41RzNSOVVuL0szb3pTQzZ3SXhHV2dQN0Y3S1F4b0Zh?=
 =?utf-8?B?TkNKeEpLTGdIRncwRlZaYnpOL1pmdUJydlNGSGZ3WW1ZSjBFcXpudEtGNTdJ?=
 =?utf-8?B?eXBFN0QvdFdJZ1hVYy9PMnFlUTJYOFgxekZ0Z1c2YzNscDZ0cEFyOHZNaFM1?=
 =?utf-8?B?b3E1U1RKTFpDemxsRzB2R3R3YlRpQWdwaUczVXdpNkhOblhXYURIS0dLQi93?=
 =?utf-8?B?MWM4NkRXTmRkc1lBOHJJekthRFFxRDBWZmNCSzFOaGxEWUhyT1JaaDdQbnE1?=
 =?utf-8?B?WGx2d09SdUEyRGp2TVVpd3VqOHY3RW9iV2FnOUpqRTZCSTFnSWNrVmdVQWhE?=
 =?utf-8?B?V1Y5b3c2bXpVdnBMSHJDTWU5U3IyK1JhOFdZczFUaDRmZ212ampYaEhUYVFU?=
 =?utf-8?B?NEpGTlh6cGg0QXkxSmlmcExYZ3RZVHVreURVVXRnNVUxVVhocFNQUk81ZHBF?=
 =?utf-8?B?d09EVldEYlNMMEZ3azM3OVNnYXJVM0IwUDJTWldrWmo1dTZNSXk5bVh6RFhs?=
 =?utf-8?B?KysrSVhVdXg1M0RVcytNRFk4a0NtSThjT0ZEWWM0WkhhS1BSZXJoR2RramJH?=
 =?utf-8?B?WmQ2Q1FWdGk0R21JMjk5K1NWalNzTUtENlJpMi9tU2IzRmsrWnBTMnN0OFZD?=
 =?utf-8?B?OVN0QlBwdkZZUS9TcGxvamh5dThselc0MkRwNEVkbWJaTVNhaW1vL0UwNTR0?=
 =?utf-8?B?QlNhL2dPVFhnT1daMHpCZ0pYWmk2VGs4NnBITVlnSUdJZWJaUitnbU0wZTgw?=
 =?utf-8?B?dGpWUGRZdUVTM3J3UXIwTVh2Z1A0ZlQ1WkZ2RlN4R21nWWxPRHExVGtubkg0?=
 =?utf-8?B?MGtLUHA0WUVTMnBrdXBBY0luRndqck5oNWRQVFlDalBoL0d6clVPRHE0VXNB?=
 =?utf-8?B?UExRb2xLWVlPN2RZaHJ0VEhLeEE2WUVVTkUrV1ZvMkZ2NlVsTm55b2pyeFBS?=
 =?utf-8?B?WnlsQ0piT2FkcWI0R1RvQm5zZTVXNEEvdmJnemMrQjhTNXkwYUJIL09qTEhM?=
 =?utf-8?B?ZEVtQTJqbkNyYm1kT055TnpMR0xUbkhWMzJqZXBsQ2pCMFlzL0JXWkxDcEtJ?=
 =?utf-8?B?K2dhbFRJc2tta0huU2laaCt5VDB0ZFhVQk82bWV3aHhVMEdhVUhHaFdaWHpE?=
 =?utf-8?B?bTdPMytENENyUWVSaCtueVpyYkZvRXVWeHAySVZUenVoWmdST0VlRGtrdUNu?=
 =?utf-8?B?aDNFQ0pOWTFMQkFVV3FQVFl5NFRhVGhmSGFLK0luZVNmakJHc3FRSlhveFM0?=
 =?utf-8?B?M1Y4VGNJYlFiVU5LSnhINlU5QXhZYW1nU3B3SFBNS0czNnFrWVNMck8rWHRo?=
 =?utf-8?B?Y2U0N0lNOGM5QStaUVYwdjZtUUJqQnZGVGJzYmJWK2oyWmJPRlo0NWFPdTRJ?=
 =?utf-8?B?eWVhNDk0UDhWTUhvcXJJRzVXVzgrZ1ZrclJwemlFZ09sTnV5VisxWjZaT0dM?=
 =?utf-8?B?aU56dVlVN3J1SlNCdklVNU9OS2lYcTd4eFMxaFRPYWNGL2wxTlovQWNxbTVN?=
 =?utf-8?B?bFkwU0s1Q29ER2hjUnRVOFVvN2gvSkVqdXgyVmlyWEptWkIwK2ZxRWU5cWtq?=
 =?utf-8?B?cFNrbGtFbHRZa0F2Q0JKQ3VCKzR5OHk5Q1dEREJEVFFialRQaFovNGxsSytq?=
 =?utf-8?B?WXdVUk1HSXpMNHZKakF5TGVia3l0WW8rNXJxd0QxTkNKKzNCOHVaMU15aVRH?=
 =?utf-8?B?WVBRQVB6SkNZV0xFOGVUMmdvWTVucmNaUGV0R1EwbWhSbXFpV3J3cTlMeXFi?=
 =?utf-8?B?eG84VWZjYUtvSk5MaWY4VWtKazRxN1hZWVhJbjJmRFR5UFdEWmYzR0lQWTYx?=
 =?utf-8?B?aGlPK0xFNTVVbzJSaGRLeXZTTkl3ak1PY2NSU2dwQ3NURG5rWk9ET2hqZXNX?=
 =?utf-8?B?L1BRWFNTYkx5Qlk0SSs3RkdIRWk3K0h4VU1VN0ROSkhTRDFoQUF0WUhKRmll?=
 =?utf-8?B?NTg5VU9FelczTllEc05IRXZOVGtzaU5qUFl1RGxtWFNpRCtkUGFTblFQb3Mv?=
 =?utf-8?Q?DG7krqRodU5WLLLXWHjWtkA0c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2bf3b7-223a-4836-61f5-08dbd45915a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 06:18:48.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNQMxaAQ+eS+Dxc8U3UxFyxlfI5Orfx9iWqgDXQMAIDKLJRfvZuNjPgjmyxaa5mZZXcERQQYVzjW4hv3IoQgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 7/21/2023 8:15 PM, Yazen Ghannam wrote:
> On 7/20/2023 11:55 AM, Borislav Petkov wrote:
>> On Thu, Jul 20, 2023 at 08:55:01PM +0530, M K, Muralidhara wrote:
>>> Pull request created in rasdaemon for the same.
>>> https://github.com/mchehab/rasdaemon/pull/106/commits/09026653864305b7a91dcb3604b91a9c0c0d74f3 
>>>
>>
>> I'd like to see a single error, once decoded with rasdaemon, after those
>> are applied, and once with the kernel, before this change.
>>
>> Then add that info to the commit message so that people know what to do
>> when they see an error and how to go about decoding it.
>>
> 
> Agreed. We have already discussed this...
> 

The below patches got accepted in rasdaemon.
https://github.com/mchehab/rasdaemon/commit/1f74a59ee33b7448b00d7ba13d5ecd4918b9853c 
rasdaemon: Add new MA_LLC, USR_DP, and USR_CP bank types

https://github.com/mchehab/rasdaemon/commit/2d15882a0cbfce0b905039bebc811ac8311cd739 
rasdaemon: Handle reassigned bit definitions for UMC bank

I will describe in commit message and submit v2 of this patch series.

> Thanks,
> Yazen
> 
