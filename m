Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786E17FC17A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjK1PGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346550AbjK1PGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:06:00 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1088D41;
        Tue, 28 Nov 2023 07:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my+qser1rx9D1Yvxe56rRSPouLebXqCENBR/zXnQrnTyzPX6GwdNYVGq3rh/ElIlLOAYKD0xjNaMkK4jWcz+l6GX1N7Ej/TaJVgGXLOLIVmyd3Cex+NBWnF0VCDMDJARmOS1Mc3NF1s8nDu7YfXxXf7o3zgslPG0xvryhOznwqgMlQGkAbQDYaJ6t3d98BqTsLlHmU0H0YskVrbclhMkIJgcliOJzDBoxcsh7GwJnNNecL/vA48xp1xrOlXQrJJ6oPg8UTosSG1ZktsAkHlQ/jtbryKuuNmoKDnoNoxqC4Fq02TNmZO+LxCA39WcNRddasFeOtW46kap41P1PufxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dyc2sQDoHVh8VfYCiEsMXXzJ0SZaJAIs8mkRinfIibM=;
 b=AZEkTGbCWuf8mR7uqQf/CCPkcf1WboOBwvgapV8ms/BNk1gnWhSJ2VEYlHm4m1ygyUNa3cY3pX0oaf+uBCYLj6+PrCCc1vrH8vLR1EO5KyNFCc2f2qlnhTXMUsKOBft4HeHH69ohYmNuXROiTFAkpMVYNkBI2HEerL/V2Km5V8JID8yZE4UrQgoHYKmqbMLSS9LtBMgPcuwKNSp+GqSsZJ3/OBhVTUmiUfOQNtfQYsAnrgxofoSwemBWDta9GCrlW808UedFSIbxVrve54Mst9y5f/mQOCCF+PlJM+taidfgSGR/jTQGoxGvLj2Yw1V1sUjwNaDo/U6WV+VhX3Tkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dyc2sQDoHVh8VfYCiEsMXXzJ0SZaJAIs8mkRinfIibM=;
 b=Kg9T3354Vi7yzOzvtl0EUHKoq/FtZHgF+oxgl0mV7+IaR3FC8es3NQRHaG04p7Gfi0cUUDHRG1UUNFF6mEW+A6gdnCD3NYmQVzVSssznQA3Q502KnSK35xbmjtMFLTCoZTSXiOAFTJZMBqOlEPJ15ZoFaOJZFo8Qji5IXiZfZVwthgSOHagh0JhqfBZdb8Ry3bATqXEu+Itu8B7bg2vNRLswizQr7CQpHOIV0/C0ljZk08k0zIEjCNqOSAccCTPDsBZx0yHqJ0gizo6juVrPdI0OR1KU7m/gSI8aXZKNeDNI3cy9W3umwCGU2UHxoz+rqwD/hopTBpm/39QqhjSCtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PAXPR04MB8672.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 15:06:04 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d%4]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 15:06:04 +0000
Message-ID: <1ef6c0a0-4d82-4fdc-8007-87e054a4c08d@suse.com>
Date:   Tue, 28 Nov 2023 16:06:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tracing: Disable events in reverse order of their
 enable operation
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127151248.7232-1-petr.pavlu@suse.com>
 <20231127151248.7232-3-petr.pavlu@suse.com>
 <20231127125815.4a4d06c6@gandalf.local.home>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20231127125815.4a4d06c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0052.eurprd09.prod.outlook.com
 (2603:10a6:802:1::41) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bfbb58-c0b2-4635-f032-08dbf0238a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQ4YB7YUDnCAbDoxOC+ZoXn6i0iqRsVhvSqyjW58pvAotis10ZS2WFfAYTikf9rHRTT1e4PpyJ8Iy9mZhTfPb8HkaaQtW7yND6fGlR9mWt+fk1rjsAuGdWwIfd23JNwkhUkr9xY89c1qqcZwId2Xi02mfUln6zLm7tv5NOFQIizaYa7KCKAg2f0gZMUN8q5u3gLpoQFvXTYp83iWEVb77i40yjUyIm7Srw5d+eK2TfVrPOVHdc0tW8qymo7H1piewRn9XIm1VBjUKgzfMKob744AF9/2J9Ja1Kdu/K5AuLiZpP2X7zwNRZAhCdu8YgUcV8qjHEXRxf8Fm8GCzSbXOk6yWKelLLt2TZaaZJbHRbBziyNIc1yaEwKnfHU7S/T2scWAJYA/lzg252YW8xCFJU19LQ2W2f5rGvU3LMM01B09jMTDeIuGdc2jZWJTfLb+AIZug4OyaZ1P0tbFBDWKj2Jrb4w3ji4No4YlRQQ0zq4GyzKRqjMkbofcdkXj9QG4ti+UfgOyHMwh4z8vArGW7Nr48leRpHCft2Wvw2Z805ZuawqP+uFn0lvwSourBIivBHpzzsTxMBBiHPEs5ioGFdyZw3nz8KPD4t2IF1ELpCGKwB2cXWttD03mrMcGfM0/3W3be1b7MrdnueKnn+eFBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(31696002)(2616005)(83380400001)(26005)(53546011)(6506007)(55236004)(6512007)(31686004)(36756003)(38100700002)(316002)(44832011)(4326008)(66556008)(6916009)(66476007)(66946007)(478600001)(6486002)(5660300002)(2906002)(41300700001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2RDWkwyYVVxRkdNUUEvMG16a0NwcHgxWUI2MHhFVkdiYnRZYmJqcVJ6L2ZQ?=
 =?utf-8?B?U0RPSmVsSjY4MkExNHhwUUg5MGhzeC9TNU8rMVhyUmxDUnhpQTN2RS9nSkk2?=
 =?utf-8?B?WU10dzVNeEdia01wc2pRZldzNUI1L2ExVWlYZzhrOWJUTEdhYkF0NWpJMmJs?=
 =?utf-8?B?cjQyaWNLVXN6Zmx4TG9nQUFGVCtXZ2ZYSHhRcjBUeEZtUStoVHZ5dTJrMVlV?=
 =?utf-8?B?KytkQmdjcHliNnJkK2ZSc1pxNGdmK3dxelMxaDRmV3ZJUWhxY3ptNXpDeEdk?=
 =?utf-8?B?dU5mdXFwSnA4MVZHYXF4Tm1MV3laU0c1eVBlRWppWnRQeUIwSWIrUElhRGpH?=
 =?utf-8?B?TWFFR0xSTFozN2I2ZjVzWS9SWkFNQkFicW5aRzBQbVlBS29GYURHZlF2bytP?=
 =?utf-8?B?T2FOL3JYZ21tdzM1akgvVGRWWHJaa3lxaGpwemVITHJ0Z1drT2dvdDRJMzJu?=
 =?utf-8?B?ZTZpN01EbTdOak9XeE1ja1lWekhVWHFXUnlmd2FsUmc1WUI3dTJ4NFRHcjNN?=
 =?utf-8?B?M1BsZC9zQlFJcit2NHlPRW9HTVFlNTJ3QnpXQ2JkVkZxUFIwQmR1QkkwZDBB?=
 =?utf-8?B?ZWg2K0QvUnVSQ1dtcHhVUGlnWHFuT3BDTE1idVYreFViY3NlVGpDYUVDN1pk?=
 =?utf-8?B?YWNvQ3F6cytHQno5RHovWmdVL1lFNWhreFRFZWI0bmlieXo0SCsxbVhpdTdE?=
 =?utf-8?B?OFpKSWdQTmtXK1BMdDlOUEJzK0ZFS0ZGY25hdzVkSU0wUDdnVHltQXUwZ0Fj?=
 =?utf-8?B?cERoL0w0QVBqRThiNlNpRGZqRlV3Qmh5M2hFWHFRV05kOXloWElDZWpUdFQv?=
 =?utf-8?B?UzlwN2FxT1BGUzFnU2liWWx4R3dpM01XRE5XRWQvc0tOSnVlS09ucUxJS3lC?=
 =?utf-8?B?NVJ2MDFqQVU5cmtPSW4wTC9hbVNuL1E1bTBYN2lPd2JxUXVDL29pVmhHOGZj?=
 =?utf-8?B?RmhQUitoQTJEWnlnOHd1SFU0VzdBcWpQWnpIb3JNQXIyeUVEWDIvRVBWc0pP?=
 =?utf-8?B?dkhrK2xMaXdkT05pZ3F1VVJVTytIWDFyQlBHbVVJSmFVMEpUZFI4dzVSTURZ?=
 =?utf-8?B?cFBHeVVOcDJYTUJSMzdMY2FGZnVja3BDV1hiZno1UkZwN1RIYnh1RnZXN24w?=
 =?utf-8?B?ZlVseHpNaTFzK1dEOE1hNlFoRlBNOUxMT3J3NnFKdXdXSU1PWGg5RHF1aTRp?=
 =?utf-8?B?S0ZMNk5td2gyNXVRWjhkT01MSUovZVIvckVkNkRtSStka3Z3WHBrT0Mwa20v?=
 =?utf-8?B?dEozamZwaVJnRlo5UnFDdzNuU1drdTdJcEkvTDdXTnd6eXBSTzN3UExEb3lK?=
 =?utf-8?B?dSt2ZUF3K1YycmhxUFg1eXN6QzdROGgwUm5nRThlMUZ3WGx2V0xMQzlHWGlB?=
 =?utf-8?B?SlBOYTBzR0pEK2lrSXdQY1J2SWlFbG9YMUhON0VpdW9rUVh2WHlPRzBTQWRo?=
 =?utf-8?B?K3RCbFd5bm81YVVtY2NBZmt3MmF6eUcxQm1LeXUzVzhEcmppQVZOMVF1MGU5?=
 =?utf-8?B?WWI1d2JXL1VtOWppNWQzY1NpekZVVU5MQWdHUFpsNjYySUJxQ1JzQXp6NVRN?=
 =?utf-8?B?RWdaQ2ZpSXcwNUs0NDRvbHViWnVmblVxTFgwdTNndVVUQlA1NmZHTVEvSVJC?=
 =?utf-8?B?czdOY2o5UFJiVlZxK1JCdDNWUG5GZEF2Q0lidEp5akpiLytubkhrWFJuVTky?=
 =?utf-8?B?SEQ3YzVUelZ1a0hheEF5L25odmx6cDBqOVdiTzdIOE5KOURSc25nMVNqdGt3?=
 =?utf-8?B?ZlZQazRYSjdVRUFLWFNqRHk0OHJDbmRpMjE5OHV5dDNOMzBDUW05dUxwQytM?=
 =?utf-8?B?YXBBUjV6NGQvTEpOT1kwZnNwUnJKR3JDMkMzeW9XR0RRazFjN1NHRWRBU2hT?=
 =?utf-8?B?OUszaU9sSTJaK3IwaUwwT0VkMTA4WmEzVGhVNk10bllWcXVOVlMvSGkzQ3Ey?=
 =?utf-8?B?MnFrWUZ2N0xHRDhPSXIxSWdzTjQvM01IdFdyYmgyc1pSUjdteklhdy9IV1lz?=
 =?utf-8?B?WlJ1b2xjcXV6cVJURHNSMHZiZ3B6amFlOWZYN2dIQXdoM3QxbC83ZzMvRVpm?=
 =?utf-8?B?RDQzS0h6eWVwZ3RJenA0cHV6NDJ2T1orOEoxN3FsQUp2TlVpbTdqdmF0ak9O?=
 =?utf-8?Q?glhx7e6DLLsJW7YSoQ1qTLfn3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bfbb58-c0b2-4635-f032-08dbf0238a47
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:06:03.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBVLvvAMNOsrVkvRcg8jZFL64mRIQxnrty/muBm1qG4yBaTPm9A9ni2Cw1NhsDCoMDGFJ6G8Mmg3RmtdH5J9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 18:58, Steven Rostedt wrote:
> On Mon, 27 Nov 2023 16:12:48 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> Make the disable operation in __ftrace_event_enable_disable() use the
>> reverse order of the respective enable operation.
>>
>> This has two minor benefits:
>> * Disabling of buffered events via trace_buffered_event_disable() is
>>   done after unregistering the trace event. It closes a small window
>>   where an event would be still registered and could be hit, but would
>>   unnecessarily go directly to a ring buffer.
> 
> There's little benefit to the above. Going to the ring buffer and reverting
> it is just a bit more expensive, but should not be an issue with this small
> window.
> 
>> * The SOFT_DISABLED flag is now consistently set only when SOFT_MODE is
>>   also set.
> 
> This code is a bit fragile, and I rather not change the logic. There's a
> lot of corner cases.
> 
> I'm not saying that this is a bad change, I just don't want to add it and
> find out later it broke one of the corner cases. To add this would require
> an analysis that every input produces the same output with and without this
> change.
> 
> If you want to make a table showing all inputs between soft_disable and the
> flags, and show that the result produces the same updates, I'll then
> reconsidered applying this.

Ok, that is fair. It looked to me as a reasonable change but I don't
feel strongly about it and I understand your concern. I guess I'll drop
it in v2.

Thanks,
Petr
