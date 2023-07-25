Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897C5760B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGYHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjGYHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:20:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E683ABC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYpZ1omjT7q2tA+UB7+wbhAh+ypxd1cgWzxRVVJ4vSiXDIpQTgo0nIE2GAK61wwkV5CabkMN6g66XmeTmF83XPAvy/ClDKOt4PjC5ORQjcnl0JwojJdNZM2Mfi5Ep72G4V21yIyT7GbNGa0UYBJC+h234gZDx8TuCCn3W+ldbgpkuyHj4m+N5PQ5bilLluCPL8N9eQcTdjBU/nwMeqKVDy+DqanCbb5LBwXo/De0MpKTq6Vkq/1IEOon3HJ+S0P/WPk40LJ4yJQW61wp88eva0YtOLVHMzm73TLk6+cmQG1WFdvSmpQD2aMv0Q3Rccc2YtrNw6Up2GCKDrZ/2bDixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfkmAbvaGhDvplXe8kl8ESjTuPx4xFgu5vAhX9Q5f/o=;
 b=VBpTy7NuMcLRyEuqGj6p9bVFE+pUnPr/iziQBfAh+LAM3cNnBJIfIVU+YC11NuchSeBUXIaf0EIORAeSXYgF1hs8crm3jEg09QtXs19P4Aqy+YfsvkSDcS0FECljriIAfnYqLLxoH6gQNVzYC/HAWfL0wAZbiyQXN5ImbbfXRyTzdpc7NYXZ5dFTOeqhMdPkuucdMunRurMN1zogQxU6YY2Yzm0FB33KezC7JzhZB7wuI6HFw6rDuQi4Aq+QV1pdtfBKaZQIgNnNb+uRRTfeC8M3nP5Tt51PmjNtpqgy7J8Rb+1q4dgxOcz9RqH7TkO4yzdxepH94PEdo5vNkME9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfkmAbvaGhDvplXe8kl8ESjTuPx4xFgu5vAhX9Q5f/o=;
 b=UGnZig7PqqgWfJCu2CuFnhayz7qMuouLoZ1UEOCM9lVQOFB3ugxCmnaRHOShzWJppEZxm0HN6ySg01GkBidYbBShWNbhuQcrex/zAifMeTQ6RHLuCv0JSa/patfZzma/ssetgA1e+z4zUjYbWj2Mn54qDSu+090vlstpeqGT0JZXGtH2TKxy1pnhjEFJnF6LAFfa+COg234N5MfDL1PDduufbBJ/MxkNn6uSbTkPkX+DlKcrJzrxGBT46Z5rnTnyWxwrVej/rVL+cp710ItzRtRDRL5RBKWhvJ094XeQk592JFq2QPk5MImbiVmZS65FKt/G09Kc5b9EZhqClZXXLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:18:08 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::e5cf:5743:ab60:b14e]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::e5cf:5743:ab60:b14e%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:18:07 +0000
Message-ID: <3770f13f-0621-48af-4c79-880a0ffaa8a6@suse.com>
Date:   Tue, 25 Jul 2023 09:18:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 1/2] xen: Update dm_op.h from Xen public header
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
 <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ae417d-a3dd-4223-9432-08db8cdf4b8d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CArRG2W1Nc/aiNCg9S0murR+9buaMNPkWAfcxzSQKKGNEAlV/pxOIM4v2kOlGbzp73NOJMNSZ/GXEkOtxcjn/zNWJrPgZ8fB3dozZkOEorMpQGp769jckr/+WLxKJ22iO7McCGWUwfjQiNZMa+q6mcQBcySxDSIr8SOWnksG0FDs+FZWCCs3c92YY4h/TY4avdJn/wkluWzVbRb3WcziltMCmAaVyRw+hN3b1WKXbLdrmpedHC0mF5js1xggWO+IF92cYdpJh4+Qu1zwJ1qtRcQ/pKyElMqQbS0LtDaRF3vNtedFyshAmIwRIRMFnI2ZDq42gO9lOshrUvn+X5I2lXK7Us3gMP2OodrHR06M/Xg+KgoX4vSaE3hFZWGK24IimtB5SiyLXR2OttrMFGKbPWKz/VHm6sw9/5KCy+t3CZkj4Kb6qS8MDdCWGgIWEJZaeTWxKJEAFsas7cqOF7NwtvJ8cp8g7annP6a1rR8lBkvKM2WB+cbxNuvitcLDGNMqeUqKZkl5H9oaMFHU3i3Uj1DHljoOppIJh/EyMbn+zjfwGZLyiUqSHFHLjDPQned7ZNghIg+U5QW+Ti9DDqrdOnN4Bnu/Jj1TTXg33w5LdhUoX5qRcEQy/2YiSvnmLgH5k62tMaT2ChfpTuNWWcK1UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(54906003)(478600001)(6486002)(6512007)(186003)(26005)(6506007)(53546011)(31686004)(2616005)(6916009)(4326008)(66476007)(66556008)(66946007)(38100700002)(7416002)(5660300002)(8936002)(8676002)(316002)(41300700001)(2906002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVI0YXJRTHorTVhGL3pMbytRbE9QOHNVaU5HV3pCZWNHODI3TFZFdUdwQ3Nk?=
 =?utf-8?B?YkdvM0hWbkZtd25lTlRkb1pLbE9Od3FkNzlwVVVaNmo0QUlYdStXYmViZXZt?=
 =?utf-8?B?aHoxQmdPYVQzZmJuRkdwY0dMNjNwN3IwcVNOTG0zQU0wTWJ2eGJKMzFscnBV?=
 =?utf-8?B?K3hsb1FhdVpQS1FQN3k3NVZ3K0VCeFVVQjM3STBtaUY4bk9ETVpZVklnUWZR?=
 =?utf-8?B?c1BDL0t3QW15VE13U2tCczRmK0ZnSzQ3OFpNc1BYemQyK2hCZHdUNHg5Wnlu?=
 =?utf-8?B?RE50ekVLZG1NMEpvcEwyNFJBUndCUVV0TTNtSzZLdW03bDY4elQwSHBlWUpq?=
 =?utf-8?B?Z1JtSHpRRVBXdUZMRzBrN20rcnovcGtjVFIyTUxiazZjaGtKMUFLZ0dLWWpp?=
 =?utf-8?B?K3pWa0dCR2g3czcxZENueGEybEhQQ0l4eFpudVNzY3B4QmZtZllZTDZSOW93?=
 =?utf-8?B?aHlEV09wRmk5bXFWb1ZoZzlHMWtYWm5CbmtFNUVtbmpSQTVTL3FaaUg0MXhq?=
 =?utf-8?B?aFoxc3ovcERabnVCWXRNVFkvNFFSZUhaL0M3WjJZN1paVTRUWlF6N3NKQTJK?=
 =?utf-8?B?Szkwbkt4ZnlnOVgyVHBOT2xYdzBDR0gwSjhmekF1QkVHQi9FLzVDWUtYMXhH?=
 =?utf-8?B?VEdHSG80bWxSL0s5T1RZTzlZQVR0aVJlam9WMy9LYk1rRzdya21BNE9XNlV0?=
 =?utf-8?B?dG1YNUVjRThrNTl0dUU0RFdlcUdJMjRROWRYRTNsRWdBeWduWVdubXBmT0E2?=
 =?utf-8?B?ZEJpN0RIRVlWbkU1VW1XRnNudjRNcTJQaU1NK2QvYnlISFZ5UGxJSXloWFY0?=
 =?utf-8?B?NnpwcTNIZmNROTk3RUJyR0ZiazJYWVhPY3ViS2tzV2trYVZ3WU1YU0l3OGFB?=
 =?utf-8?B?UzdYMlovZzBKckk5Ri8ybldZQTFHaTlwRzN1VGxEbFhueWdOODQvL3pSRnkv?=
 =?utf-8?B?YWZ0YUV5ZWhDakZMV3dQWm5NbFV2L0VWMnY0Zi9JTUxocVJBQWpucUdBd0Zn?=
 =?utf-8?B?ZzVUUk9IeHA4Yy9zL3NYQXkxYndNOFBTM2o2RDh3R09mWkFMS2RSU01TTjV1?=
 =?utf-8?B?YkFXaVRXQlJhaGFWWkQ0cURGV1ZmbGlkZDk1Y2wzNjAzQUNPc0YzVVUwcVht?=
 =?utf-8?B?UkYxYjVoTXFNeXZMd3VFamY3ay9qaUxmaVpsZ2h6TW1JbUpQcWVMSVpYZjIw?=
 =?utf-8?B?U01FVjhMQkZrd01wOHNlQ3l3UG1XRU4xZW9jZFhnUXpYaWE5SkNwS3pGbEI3?=
 =?utf-8?B?UllvdWRaVEtpK01tVlFWOTdyR1RNZkJOZVRERlAzelhkRTIzNWxTVlNFYnd0?=
 =?utf-8?B?dmxBbGtldit2ODFaWGpETlh1M2Y5Wi9YbUg0K2UyZENDZlAzaVBkNWQyanoy?=
 =?utf-8?B?ZGNBb3ppYXVXcmpZYkI0TkZxdTk0MW9Ic1pOaUQyWGJYOTFkMUZWSks4THVy?=
 =?utf-8?B?a21YYTVEMkF0bENXOGo0emdJSjV6UnM2N2NyMVMxeHA4UTcwTHRQL081SXVZ?=
 =?utf-8?B?QUVMczZ6Z3ZyRzBTdFpmS3g0eFQwekJsS2k1UjRwdng4R1NlSWNnbnI2TjVj?=
 =?utf-8?B?NGUxVVcwK2dDZXZjQnpDclMwUlF6UUl3bjlMTDFNbVJoOUFPTUdud1JmZnhX?=
 =?utf-8?B?aSsreUM2RCtwU2h1M3JSMGd1a09XUE1iclphSkVSWnpJRDRCcGlEZW9VUmRh?=
 =?utf-8?B?T1ZaWXovVGMwdS9Tck1MQlp3WXE5ZlgrU2Fwd2pKcFAxWkQ5UmdYbDJFMWdy?=
 =?utf-8?B?K200L2hBZGI0TmxkWTg4bkxzT1lSbjlwMmdTR0drTytkSHllckZHSHM2TXFq?=
 =?utf-8?B?NmhVeFFyTDRRZGpZVUNOZnhCQWhydkFGZWtRYXVwVkR2RnVkZXlpTExzaU9D?=
 =?utf-8?B?T0oxTHJSOGpXUFcyMGw5VWJlTEZSSGFWbnZ1VGVyRzdmS2RmZmd2Ulo1UmtZ?=
 =?utf-8?B?ZUY4UDVWTU1TVVd6bzI4VEpkb2d6MXlOdkFLMWJoMEw2YldvUXVzcGcrbmlo?=
 =?utf-8?B?b2t4SitNbXNzdzU3Q1ZVaTZVdU95TnQ0NFZ5elBFYUVaRDRnSmRaZkpmdVcr?=
 =?utf-8?B?cUV5RzVxWVkzamhTZ0tVWGc2MG5IOVdWQ0NwR1ZINHBTMmRDUldDalBZSXE2?=
 =?utf-8?Q?c0JHU9pvzCLztsofPvDGHoobq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ae417d-a3dd-4223-9432-08db8cdf4b8d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:18:07.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo79Dc1IE5uq52cmMGFbEh8vYrAZFdXGnWbZwUc/MAy+dtJEeBTuRwKJ0mv5J5DPj121EOcuYPu7NrDefjatBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2023 09:09, Viresh Kumar wrote:
> On 25-07-23, 09:04, Jan Beulich wrote:
>> On 25.07.2023 08:47, Viresh Kumar wrote:
>>> +struct xen_dm_op {
>>> +    uint32_t op;
>>> +    uint32_t pad;
>>> +    union {
>>> +        struct xen_dm_op_create_ioreq_server create_ioreq_server;
>>> +        struct xen_dm_op_get_ioreq_server_info get_ioreq_server_info;
>>> +        struct xen_dm_op_ioreq_server_range map_io_range_to_ioreq_server;
>>> +        struct xen_dm_op_ioreq_server_range unmap_io_range_from_ioreq_server;
>>> +        struct xen_dm_op_set_ioreq_server_state set_ioreq_server_state;
>>> +        struct xen_dm_op_destroy_ioreq_server destroy_ioreq_server;
>>> +        struct xen_dm_op_track_dirty_vram track_dirty_vram;
>>> +        struct xen_dm_op_set_pci_intx_level set_pci_intx_level;
>>> +        struct xen_dm_op_set_isa_irq_level set_isa_irq_level;
>>> +        struct xen_dm_op_set_irq_level set_irq_level;
>>> +        struct xen_dm_op_set_pci_link_route set_pci_link_route;
>>> +        struct xen_dm_op_modified_memory modified_memory;
>>> +        struct xen_dm_op_set_mem_type set_mem_type;
>>> +        struct xen_dm_op_inject_event inject_event;
>>> +        struct xen_dm_op_inject_msi inject_msi;
>>> +        struct xen_dm_op_map_mem_type_to_ioreq_server map_mem_type_to_ioreq_server;
>>> +        struct xen_dm_op_remote_shutdown remote_shutdown;
>>> +        struct xen_dm_op_relocate_memory relocate_memory;
>>> +        struct xen_dm_op_pin_memory_cacheattr pin_memory_cacheattr;
>>> +        struct xen_dm_op_nr_vcpus nr_vcpus;
>>> +    } u;
>>> +};
>>
>> Is sync-ing for the sake of sync-ing really useful? For example, are any
>> of the ioreq server elements halfway likely to ever be used in the kernel?
> 
> The only field, out of the union, I am using for now is:
> 
>         struct xen_dm_op_set_irq_level set_irq_level;
> 
> I am not sure if some of the others are going to be used or not in the
> future.

I question that use, btw, but it is not up to me to decide whether to
accept such a layering violation in Linux. dm-op is, as its name says,
for device models to use. Your intended use doesn't fall in that
category, aiui. Imo the present contents of dm_op.h in Linux is indeed
all a kernel is supposed to know about, unless it was to gain in-kernel
device models.

Jan
