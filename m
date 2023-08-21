Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C4782F08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjHURFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjHURFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:05:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD23102;
        Mon, 21 Aug 2023 10:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbGDJUjhkYxjhP9JhdBJCICYbq20cp998ntNQxq3zR84cKylmt2bA+MmR+QKq1P85/uGQD/BTNgZMxVQoRAk0zdLZq9dc9athojCRQ6etT6nRWlZUy4PUXnu8MstGPJT5lvnT7BvzBjGqIzJVUl2C7ugCg4XXOJ7mnjJf7zakfj6gyNd3r1gCN99RrdxqujnFHbdobmh83OyjfzvX+BHjpjB2jSt4o4NKgXWbaqzB3b7OBmTJYeIx/6y5iExLW5jQhTvLFmO8eAaxVjbHjK+ubpRRYOJDg1XQa34g9NG9Vkh0SkHE7BB1wncELm7GZlX3owhfFTYxOx/CRaU1V0wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBx9a1R26KoyU2Y6R+fZSzGpeK5xR+XZo0LWQuDYmQ4=;
 b=HbKev5kJxOCiaBaqzIw3JUGZRjnH1cFIuC1kodozOE2UiuricXRJFHxf+4zNM4AcxDmKw0f5qzo5BLgNdkzzgAlSk5mHgmLSc/aoyxqQPqh0inYykJqopm0+aeJuD329UyiozVb5zN/qW+ttQRogVlxMekG2AHLshDJSMsrwZYlZsROnkbiyrVIhQO55kljqb9TzjhvbZ2UJ//MAo4F6W3KnUCU4d+G+F+aUdvFqP4W6HBIQ268H7i7Fh7unQcKrCgwUJg8TsGo4o685I2XvbJIASDSyD4iqSWLlM6FGKDi6k9lFyZUcNG7umlWFHfQZF9ns5J9edZ5VmfvCGhHFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBx9a1R26KoyU2Y6R+fZSzGpeK5xR+XZo0LWQuDYmQ4=;
 b=XZbWNe/K086VkCC4qKXjNprAu6pkIl7kYG960v8N5i/sEPUrIOsqJmS0HU0HVoDtR9aHv8EyekMEYC935g47vm25sniLMfPuGiRb4lQTQ3usZeXqIlr6KMqxll6NiV1dkFTDecOY3dFrNn+86MVyylw+CoMFC7axSpMdoIXv4dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:05:25 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::ee63:b5d6:340c:63b2]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::ee63:b5d6:340c:63b2%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:05:25 +0000
Message-ID: <ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
Date:   Mon, 21 Aug 2023 10:05:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
Content-Language: en-US
To:     patchwork-bot+netdevbpf@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, shannon.nelson@amd.com, brett.creeley@amd.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
 <169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
From:   Brett Creeley <bcreeley@amd.com>
In-Reply-To: <169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 62904ae0-b0f8-461e-830f-08dba268cfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omPxb0nPlWK6GCduiGvw2YnW44CRTXn94GwQJwNFK18Fr7nW5Msk8nqzd4VncK7hBsSof2Lh2dCoXtaqfsvv7wszay5zMYnu21gt1EjGBC8D0kgDb7qXCsW16MVl2XlwQAQLGbgIAu7notPztab9kbHvCmLdbyJO2pb3Sb36dyfy3TYZQcr1yXeBKLgsUiBzd1J3sz0kaplablLxSE9SOLbn0tAwMzpkuNX5CB0RJnqAniFNXq/cAH5Zf391lVuKcRmUChOxZosm3k5cLx0C4tplbFdx5DNeH73vZUigAqkOtuoKkEToY5jv9Ts3RGUpLnYN3jkkGnbIsY0eQc+Xa1chy9x45PRuh9i8WB7nqdGX45e9LnJJbY1qCh1EY4mrDLExeDx81q2rpXXGPeCFx/G3vyrvzkPWoTNZvftQ8b5PCfzvkhIYSm/hrzddT070Ud6cCIWDgv5YhyO4LAIATZQzGhB7qih+e+cbOvdG1sH6vRjZOYwFAO7N610pXiB6yST0gzYOU9KsfUEpBnsY1H8vSfdRiGLod57yXBR1opZX/h0Mg+HcXGWKgrmVcfs6VRBApCCodYXSzQnUS15kAYuWk2gX0WOQX32v4an6a4KpNWhy6X+nQKem7dmTygebw9pFNyWsZfU/86lJGgZHOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(966005)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZuL0NJemRXN29VUDhpRlZoVFVWMlpwMW1WMVZZd1ZsTGVKZm0zK3QvSzQx?=
 =?utf-8?B?ekhicDIvdkU4cXg5d05rVmNFeEpvYnJTbEQvSWlYTE5LSDBENUpPTlJ3U2dy?=
 =?utf-8?B?RTk2K0NIRUM2ekxKbkVndS8wZXhTYTl2ZCtPNWJIUlAvSUlERVFTZDVaN2lR?=
 =?utf-8?B?TGFWemtYZUFjYWwyekxTZ1l6WXVUNEFMdkVxbjFDNFNFZ0tTUytjcmQ1bklW?=
 =?utf-8?B?VUhTMlNnbWdwc3h3NFBNUm5FVUR0WmdlMUZMclhJd0xBU1hXUG5GYmdYY3M1?=
 =?utf-8?B?ZEFZUllYRHdGbGNVM2xNcC9zbjdweTJMQnZiMlFmUUlhUFF5b1N4SzloU3lW?=
 =?utf-8?B?UWxOemZsRStIVThIWkViSDkwTktmdFFlYysybjRkdFE1OG5hTGhYME15akFm?=
 =?utf-8?B?L3F4bThjaS9oalNJTERSTFZZNTFtNHlGL2RKUU15dk9obS80MmJEQWRxaHQ3?=
 =?utf-8?B?TU52bGpTWXQrZThEU3Vid1pCQVRHb1QvMWNrWDVGTlVtNkp3bGRnb2tyZWtX?=
 =?utf-8?B?OGo2YWtEWTZIWEowZWVTRHFJYnpTdDZpaFgxcUEzWjg1R0lhQ3dJSEpFaG5V?=
 =?utf-8?B?NHpPUHpzeWtUWTNWM0c1azREV2cvQVJzYXZzT2NlTXRxZGVQeERnTWEwUUo4?=
 =?utf-8?B?Y1VDQ1grMHY3UmxLY21oRGVqa1B2MzZ2Q0tqajF6MktwdjA3Kyt4L1NRWXNx?=
 =?utf-8?B?K0p2a3cvK0s5RVV2UXZSUnhEa0RjRE13QjFKUUNZTjlES0tPemxSZmpFUFIr?=
 =?utf-8?B?aDJLRUQ3TG0vK29sMzlGY1IxdE1YOFpNMVdybnR2WlRIQ1VTa05XNFM1ZlZy?=
 =?utf-8?B?U1N2NWF6ZUZVcU9JVkFFNTAwWjkrcC9UaDhRL1lnZitvOTF4OTF1Q1lybG9w?=
 =?utf-8?B?SVFRd3FpaHVIVENZb1dWUEpibjZTd0hud1BlZ3RlYzJxaitjeHRZSURHd2JJ?=
 =?utf-8?B?ME9DeUxUQXRWdGxLbWdiU2FucWV4NktGUkdmbk1YUndhNFV6bkwxNDJmZ3FN?=
 =?utf-8?B?RXhmakp6dDBZZTBQd3B6SjNSVGFJTzI2akZNcmhqUDFUSWFXcHhHWW14YkdC?=
 =?utf-8?B?bWF1Q3d6UkVSZ2RBVnNETFB1V1FreGVJNW0xVTVJYzZvSHJnemtiMDMxWjBZ?=
 =?utf-8?B?OHVtNkNxRlc2Q2hHM1VJckpWS244dWh6bHdOMzMzbkR1dGZHQ3JZb2Z3a25u?=
 =?utf-8?B?NWphbUZZbk5PNWlBUXJwWSsxREl5cURMelZkcEl4akE0NitaUDEvSjd4N3cv?=
 =?utf-8?B?aHp3aDVWM2Z0MTcwTG5QNS9nR0d6VnZkeS83S2pRV1NuK2xueDBhNVg1NEYz?=
 =?utf-8?B?N1I4bFQ0VS80OHNjcExlSjBxaFlia2J6T3ZrK3J4RXR4Q1EvdXo1Q3pIWHZs?=
 =?utf-8?B?UFhQbnBSRDZOK0RtRlBEZHVJL2NjZ1lmNFVhNnhRNUZjdXFUMlZHMTJvbXZD?=
 =?utf-8?B?aGdKUEpQdExYMHZSd01vL1dZd0JsdTFDUnQ2RzhCWkdwSjVRWENPZENUcmc5?=
 =?utf-8?B?ckZ0OXZ1eGZEaUVUeXlTempZQUlMK2RFTGU5K3JIQW8wYzlRU3dsYmNRblp1?=
 =?utf-8?B?NUt1UVhJZzFJQUtJa0NlbjRyNXJobUxCc0c2UEkzREpITm1VTmFYL3NaeWdw?=
 =?utf-8?B?S1dTQ05naXRvVFJBZmw1alloVnpqMEl4TzBOWlY4dzRTVk9zQnZ1cEorZHVh?=
 =?utf-8?B?cUp2OThvbUtGWEhIUVNqRDFGRDdIR2l3djZhandiaHN5aWc5bng4OTNuWjgw?=
 =?utf-8?B?YVVDMGhuZkZzSURaallMR2t4ek0xZmxGUER6c2M5VGF6TEUzeGJGSTI2SWZi?=
 =?utf-8?B?OWxWdGJuL2svNlhZcEpWb0ViR20xbHgzSTFBN21Pd0tZNUxpWlRuRjF2cjho?=
 =?utf-8?B?eXBSRjlQNVU2WUZiSzVhSnBVSmlSMVNqSDlWNnFrQlJHc2VzdEo5aCtBQllC?=
 =?utf-8?B?N2JZTytDVk96WHNaNlgrZEYya2grSnE2OGcyczBPeFhqN1FXclY0SWU3UUp1?=
 =?utf-8?B?YnlwaG9lbVhET2VkbzNaQXRRbmN2WVcyMEsyWGF4MThiMlkwMXZOQWRLSFN1?=
 =?utf-8?B?dVNEUlM3akYvUGhTck5ZZmREbXFaNnE0Vm1kSElHMWwrcVE1Rks2WnMxVmRK?=
 =?utf-8?Q?7N29ilqVSxOmEuZEUvhHGlB9X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62904ae0-b0f8-461e-830f-08dba268cfef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:05:25.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKUJFEdyBMxFbGZqUooS04yhHKakhcrS5e4FjHQRICITcl45uyHkO1VWWHBO4aaqpsEk48bqFIG4C/wqPWU4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/2023 11:50 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Mon, 21 Aug 2023 09:55:37 +0800 you wrote:
>> Fix some kernel-doc comments to silence the warnings:
>>
>> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Function parameter or member 'pf' not described in 'pds_client_register'
>> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Excess function parameter 'pf_pdev' description in 'pds_client_register'
>> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Function parameter or member 'pf' not described in 'pds_client_unregister'
>> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Excess function parameter 'pf_pdev' description in 'pds_client_unregister'
>>
>> [...]
> 
> Here is the summary with links:
>    - [net-next] pds_core: Fix some kernel-doc comments
>      https://git.kernel.org/netdev/net-next/c/cb39c35783f2
> 
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

FYI - there might be some conflicts here as this was already fixed on 
Alex Williamson's vfio next branch. I don't fully understand how all 
things get merged into v6.6, so I just wanted to update here.

On vfio's next branch this was fixed by: 06d220f13b1f ("pds_core: Fix 
function header descriptions"). It also has a pre-requisite patch that 
actually introduced the warning: b021d05e106e ("pds_core: Require 
callers of register/unregister to pass PF drvdata").

Thanks,

Brett
