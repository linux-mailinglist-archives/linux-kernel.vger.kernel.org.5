Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2CE77E546
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbjHPPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjHPPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:36:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030E2684
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo1blBw4QtKJQNDcdf+npQE5JSHAjU6d3jc8poWgGW9lM84X5uvTN+N+fX8704Cq8+jfDCe3gl5zUISIkYOZ9j88ACvmLW+RqeaNTbvftISnNvowNcgeR7mrP4N0TG0M5yxQjA3PLJDYskSzOTlO0JaIemH0dFEwvZCACg/sCqbhJfdUqP4t73Qg9FbugnwkGNRLNk47KgEAX0I9EuAFk37PPRR3crYPsDFrk5ttv3Ys1jb2NonjPpPhbFlW403NtIHSCfiuCrLw7HCYFSrsMh2g61MSYFTKsQ5/1RcTb6rCYXMuiuOvckZvgmDsg7SaTbSBl3UOj9MSIHS2sBV3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBTnd9tti+MVS/NSXcajTSuI1YjUrSsROgs92XzpKCY=;
 b=bGz+8yHRwpNWTcxtk7w5hsSojRxZR+hiV1vHZYWglpE+oUjCVQUj7tWE7caStV4bGW3Vj7tn413/OGaBasf7nDIohOC9ifdT8rrdKaN0iHjG1/0RKV3W6bkOZ/TnLWljzv+UMOc7q9DaO9r1223frT/UtDmU+8Mc5g31SxMp4i+bUGEummLVMU9hB4HvgsOAoBlxPMrd9zO8/fY2RR+pg2iAYuG4RIVE1VlZBiZ2ypCXUCOZwkg0ZNnClCIVQd9r0+Xn9MnikeHaAneZrffEv23j64nUocJmGNoKehpVMDnH9nwz/HAqyue+Ss+7XeSpvWc5gJwIQ+QiZpxHl1+etQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBTnd9tti+MVS/NSXcajTSuI1YjUrSsROgs92XzpKCY=;
 b=PSIUJWK29WU5L4MJeBF9x8Li4FJrXiNYJ+ai8J5w9TRSBDbSGmr8UMDS26iKCi971gH5Hx+/yc/qIje9SXgtUtK39Eeo+zCexvgBkS1TegLccHpOgVdryoESQz4Dr3gYI3kqjQ5yKVSvlyAMKmB0L77JHBpRSfZ1eVddEJJFVQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DBAPR10MB4041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:35:58 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95ae:6cb:e93:cce0]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95ae:6cb:e93:cce0%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:35:58 +0000
Message-ID: <53a4fe26-3a6a-47ce-8532-be60da674aca@kontron.de>
Date:   Wed, 16 Aug 2023 17:35:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: spinand: micron: correct parameters
Content-Language: en-US, de-DE
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru
References: <20230815161024.810729-1-mmkurbanov@sberdevices.ru>
 <0f54b3dd-1fce-4f81-8652-d50fe1bb3873@kontron.de>
 <b619ef58-06c3-c61a-bb0f-ba243a4a2ade@sberdevices.ru>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <b619ef58-06c3-c61a-bb0f-ba243a4a2ade@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0051.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DBAPR10MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c76ba2-25db-4c26-012b-08db9e6e7cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n59x30/u+ruBH8r6wRCBxVNN4LyOb7DRqRePkZepWIfepgT7NXNjF34W1zxKjwm0qE61QknH66phkCe/WcZQfP5fNPlIGPRzQLttjEsrsYiPZnltfGg6wL+SnaJiccx+nyuchtPBFtBXbOseQrhAKET53J2HAEC9e6MzCE6BphrRfdFXvyZMjSTwb00frZhOvE9ZCMmciz/YO53cyH98cWzg5qXbxDz6qC2sEDZytebYYbOME8iUf/PuUcqcJ9j0ZvXspaGNveLOtMeVIx6Ct3st9el4J8cGVClAMWfZYQ8j7iRblupt8OFiikCb6QhzxftwJ4P81+vJNywoa5u0XQ0fzkRR5dgkMMeTmNR41DBEAvI7MkCwXVHpmJsqJ5EbK6XLOZYhKwqfIEUdWqJ3SaVsYHVv+KqYn2zt1YiFkFDJj6D4PEHgmxvn+bH9py1/zQ0v+yilEVUSWXkv/eB8Y8tKymcllILWvL9oFqW0NnADcUBCRSaqkd3dT78ItU9JZ19pTypMZnqmfuCD+Pw9ZyWpeWUVqKrs7O7tkW6hJ6aPr1LAkVA/WbYlW2VPnfmvzUiReR6sdkII358BgONbC70h9k1miO6gmdNFj3dUo3Krx3nZ/6rdONvHdfqnAQpYxfY8M2/xBxMHDjHRSEAP7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnRFZi8yWnQrVGZYQ014NWtYNFNVaVI5U0p0WDNyKzgzWUg2d3Zlc2xEb3pU?=
 =?utf-8?B?YkhkRXpmVzErQ1dpL1ZaTFpiSDJDMWJuQnE0cWREVXlzYk1KRjRYWXZDQm9J?=
 =?utf-8?B?YVlUWHU0MkNnUXFmQ3V0aW5ubW0yNFZDYWI2MjB2b0VYeGt3eC9BVGxMZGh2?=
 =?utf-8?B?OWtLcmxiT1RZZ0RIbDgyeHlKbjBlNnF1TzVBakRoWTJ1aDRtd2dIdFMzL3dJ?=
 =?utf-8?B?R05wdDhjeWc1aVZHWmFoa3lUQ2RMUWVOSWFYTjRnTWZMVVhBMUYzcmJhN1pK?=
 =?utf-8?B?QVlzaWdEblFCNE9KblFTb3FIWENVMjF2QUs4Q0NhODBkSUM2Z21tOURDdnZR?=
 =?utf-8?B?bjhXd25Jek5QVHBtREVlRmJSTll2WS8reExlMUFiSzl1Y29PQnZIYXZJSStW?=
 =?utf-8?B?SGxJUE1vNHNkSlBuTDZ0MW9JV3RTajBFWUtKV1JOUTA2UDRKZ2VBRGxXNm5x?=
 =?utf-8?B?bi9GaU5JSzgyaHM1S0N1Q3M0cG5ucGlkVEZzOTJDYkRWOTNEcUhSN2tJeE5Z?=
 =?utf-8?B?Z1E3aUpocXpTOG9aQU1yMGorTlNyaUJHT3FSVXhwK3VrK1YwRTRkTldLSG15?=
 =?utf-8?B?R0NwZzJ2UUY0R1ZoOEZsSkpoaE41bEpYd0t5YU5mY0lxa0dZcFBndllvZ05V?=
 =?utf-8?B?LzN3Q0lTWVQ1aXFTWW4wTW03SHBmL2greWc4dUE3Vm0rc3ExQThFSnhyVjdi?=
 =?utf-8?B?cDZFTERsbDZxeXI0SnRLT3NLUWNNUWZVbjdwaUplWEFld202ZEpQR1hrc2pp?=
 =?utf-8?B?VWxvVjhYS0dFdDVPcDFuK3dZS0Nqb1o5ZTVnS0ZRdHBTbzZacVFUYlJwWlZE?=
 =?utf-8?B?S1VpVXJTWmk3Y3NUaEFKUTNYbXdNUXJTcEU4bXpUQXpIQ3RZMnI4TUlSMWdP?=
 =?utf-8?B?clhUdnNHdG9yOGllbTYvV2pyVGRpQWRveHFycDJDSlBhMEE1MmZnMnNBVGJ0?=
 =?utf-8?B?Rmt4bHFzMVJ6UnJ6K1ZaUDlMdW5zMEJEbVlheldvRXJiTzE3OGZOcGhqYjFo?=
 =?utf-8?B?NHMrcHZQM0JzQTduVWJhelRMYThmREF0bkFjTlB3aUNaaFVEbm90dmVNTUls?=
 =?utf-8?B?UEVqdUJDYTRHWHI0b3ZvZzNua3pvYjdlR3dxYjNLYkVnekNubmZMaG9oTlVk?=
 =?utf-8?B?QUJGSDdsTm9sYU50NlJkTlVXQzdBc2cwSXl4Um8wV2s1L2JvQmpWQzNCOTRr?=
 =?utf-8?B?eGtTWEEwek8vNFBJRzl0WWlhTFd4dDJaT0JIZHllRWp5b1BZOS9XYi9sQS92?=
 =?utf-8?B?ZzdSY3dGRjZWSnFRWG50NnlNaDN1elVVZElQLzMxZjA4V2JyWUxYc0p2T2Ry?=
 =?utf-8?B?MTJIVFRaQmhuMXlFT3l4SlI3aDZ2U1lCNTM1ZmdBWnR5VFcyZDhYR1lBVlRF?=
 =?utf-8?B?YUVVZGl5b0laQmQ2dVJ2b2RsTmdhMERLQXEzVFVQcGR3eDRKby9tVm1jMG9Z?=
 =?utf-8?B?MEl6OEdFS3AvL3lhZzZ5dDZrbVVOclBZVERZeUtUN3BqQS8zcXEzRXg2QnJB?=
 =?utf-8?B?aTAvQS9oK3ZmVjBjVmYzTjNWQnNHelhCakJodTM4bVo2MVAxS0hkRHhBb01G?=
 =?utf-8?B?eXl2YStUbnU1L3M2V21JOEY3bE5idzNjcmtPRzZZYUphZ0tubVl0ZmRMVis5?=
 =?utf-8?B?TFlnT0x6WUM2bUJSNjYwdlFTaUIwa3lVRExRbFVEWmlWWmgwVmtnM0RDdlRM?=
 =?utf-8?B?OXdEVDVNTklaeFdGdGhaRzZCNDArZVVQdzFmb3c2b3lqTHBPZ3ptcnhhZWRK?=
 =?utf-8?B?L1lXZFhrTnNvYVlYb3RVY3ZXVXJjOTZINm5sMUMyNVU2YnU4c2N4cmlGTEw1?=
 =?utf-8?B?bi9mU3R1MEVoaHppSVJEVXVya0JNNDRHcWRsdlQ0NzQzNDh5N1FuUTRQZ0ZO?=
 =?utf-8?B?endLN283Nk5GWklhWmhLSEh4MngrZG1Kd1RoeDJqZEU1NkthVnd3eGNFc1F4?=
 =?utf-8?B?YTAzNjlnTFBWdHRtTkRJbmNObE9Na3NiVXhpc3pJejhBeHUzaWFXZ2dEcXgr?=
 =?utf-8?B?MG9SWXEvWGt5QlA4T1NkVGtjOEFWTEpuRzNMcVNMMzhCd0FVM2I3QTIwa21R?=
 =?utf-8?B?cFkwdXAzN2tZeWhaVWNyQTZKVVpHOGxIdG0rOGVWcmt1bHNUMzkyRFhDQUxT?=
 =?utf-8?B?RnlJODZDTDNwODRTWitnODk0YnZEd0V1WVJVTjRFZzIyejZkQy8yZkk2MnpM?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c76ba2-25db-4c26-012b-08db9e6e7cc2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:35:58.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIsrsejCxiMfux3sp7BLYz4gbOoyjhoH51/EeyQHY+IoDd5M7XsVSZX3T4PmxGQ7bMIf+KMtjbjI3XZ/p4EC/2TNEwFpAFJu0rA3yi0RP1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.23 17:28, Martin Kurbanov wrote:
> Hi Frieder.
> 
> On 16.08.2023 10:21, Frieder Schrempf wrote:
>> I'm okay with 1. and with adjusting region->offset to 4. But I don't
>> really get why we want to restrict the free oob data to the
>> non-ECC-protected area only. Is this specific to Micron? Other SPI NAND
>> drivers also spread the free area over both, the ECC-protected and the
>> non-protected bytes. Why do it differently here?
> 
> We encountered a problem with the JFFS2 file system: JFFS2 marks erased
> blocks with a marker to avoid re-erasing them. To do this, it writes
> a special marker (cleanmarker) in the free OOB area. And if this OOB
> area is protected by ECC, the ECC will be written. However, during
> the next write to the main area of the same block, the ECC will be
> incorrect because it's necessary to program both the main area and
> the OOB area at one programming time, so that the ECC parity code can
> be calculated properly. Other SPI NAND flash also susceptible to
> this problem.

Thanks for the explanation. As this is a generic issue, we need to fix
it in the core and not in the Micron driver.

Also I wonder if JFFS2 should instead write the cleanmarker with ECC
being turned of explicitly.

I don't know enough about NAND and JFFS2 to point out a correct fix, but
I hope Miquel and Richard have some ideas.
