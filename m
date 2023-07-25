Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220D2760B19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGYHER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGYHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:04:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5EB83
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/CmX2G4OEPS45YmW8WtusspuoqliVMaApR6OEAoiYE4TMOxLbm5AUL7pvtNFY6C0UdrVfX0LRqCFoWvSuG12x9ojurYU3g6ygwOzihqwG1VpqSNif0eX8BB9yPZNyW7k9buxNtUNPcEuZ6cB1GNZ+A6/6s/SZovPvC1SlikCARlA9pRn4XgUntoQ4I/M98Pu6obrpz/qaXQHUHJSOhdxmGCaqWHtcrl0gKxdDTD0wBgSBRX2t+wcfb9eXVVhv64/9fwwlHjDt3Z9zDhvEmkG7UMXSnMy1dicW5Uv6vfhGB3MgbpWBO/c2xGdBNHxRtiB7LmFffChltcf2C0LwhNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAxtSNP1R6UV016cQgJQZU9N9jTZaAHsC3RGUVAJ1qg=;
 b=U1Ov/yw6kI9F9WVxhGUfyMCRekEm99+2FFXikG9leiY0TvDQAonMg5Hglgvp73SXT5F9Lu21y1Zg/fRfMghXhpupU5nMZ79Der8qlu8isaJR/BS2EDJERPa4hPtOSEnOHhI140IMYdYm0Dm3UBhDJDNP8GbSNbXcewoN3cm4g0clLCqQzxrJSGpo/ScpmOUx8YKVHouUBlUMAa2dnIrLI9rIFUZqAfD/oMAbToDERSZvQwdR/kDtk8otgY0Evi0aKyg4EzzMtpj4jWBrJNYRX2bzbmJk/8BCRD2dfrVVx30QDgly2P1thchQ6d3g/5sn6KGnH3/wdTy1FsVg9wRatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAxtSNP1R6UV016cQgJQZU9N9jTZaAHsC3RGUVAJ1qg=;
 b=Im0XHU3mW8+vbYjoPdqIXiqQehjB01Dut5MHN1+S6RIdOA+hOlgAS+4G4/OqFbNNH1xA6DskAJNvDYTTHbZ58oNMGLFdxL/19BqmJXQWmLRizSqwBDZ7LI6pryQiMlm1UuOmxEY0XlsPclElFUsxgUe2z3QbdUIrDFfwM5aVKC3RGabVP1Q7kU7fKfSa+1HwCNbKHyNKTmuAUxBS853fnA711Ryml6ICkLjFYe1tbB99MLwfsa6r1W7t3dIkdQJ1G/VPG+oLoRVj1avm1fqalHgCL5dbGZbQ/kbFr8hDOd7cqD/Ql6LCWXbPdF6+jXFUCOchWXPX1BNekpU3tKDqFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:04:10 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::e5cf:5743:ab60:b14e]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::e5cf:5743:ab60:b14e%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:04:09 +0000
Message-ID: <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
Date:   Tue, 25 Jul 2023 09:04:07 +0200
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
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|VE1PR04MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6a2fd1-7e2b-4a08-900c-08db8cdd582a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLXiQQuuRo1Lce7KLaYUbs6xV+kEBWyBdR1hgc8YITCMaGDBlFWrDyVs7yra7NnJWivUuqcJwj+qyq+c9VQ7WSTA0JacTHxVpgZDpqF4b3bgAKyy4jusmzsTrgljpwWnbLEgt1Ea2iwMbIXM/aGrIwKzMPhRAb1GSj3T/iFVpZIPGm7xOVBmroiOz1jCkpJkuuoynJCst+pTYVoRDGCpH3DE/HOw3KDdJuEOO7gH6JgViyjUEkk4I5tPbZxDSNv9zFZxMsKOzN9qsPstBzWEyzU2rf3MuVnUd4VvE09C83zoA3UZl9DeExEaJM4Yv0jGTvB8fO6zafRkmIkytBJPgColZmrrjyF36GKPh7HO5vqL43lsKsV5R8A6oBikWjb7my98qvqlKRiOzPsacfnCeSJYZMOe5CjKsNnkGEvcSx6blExwVfjbbXsq9NhpoOe0UvskGX3gG8ajzRYJmbqngJrFcoiLKT9bjFDgnhYqfDArhLR/5lvMCwCzGm8je3jUbS7hpcEUNqCBxCl3szCCKZXS8yxVeazWbVWNv8ZwcN462TGqPNDMvw1IP4ZUvv1i9R33orLZ6GXrA4QmrHa3CXBgeL2IMscLJkHxXGJZP5HbfmtnVQHKaH7Uaygu16ojuGRZD7ufHYEdWZRmceF5sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(6512007)(31686004)(186003)(2616005)(53546011)(26005)(6506007)(41300700001)(4326008)(316002)(36756003)(6486002)(38100700002)(5660300002)(7416002)(6916009)(66946007)(66476007)(66556008)(8676002)(8936002)(2906002)(54906003)(86362001)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9jZGtYdWxuZ0ZqaWVMY21yTDVqQkMrM0dKYXpHN0NhQ3RpQXB6azlVaGFh?=
 =?utf-8?B?dVd2UkgvVE9DRmZnRmhRckVSSDdKMU9yMExsYmkxSk1mMmpmZ0VtcFd3amlp?=
 =?utf-8?B?d1BDbGRnRWpIdXRjRXFjVHdscmZVL0VwMGg0ZDU2TUFGNzgwc2lzZjJ4RGQv?=
 =?utf-8?B?NFJIVGw5WUdseVhIYWlIQ0l6T0xPL0lLd0FoMEMvYUZkQ3J6bmpSWDFZUjFp?=
 =?utf-8?B?amk1emgvZUFQeElLWWI0Ujh0QmpZOGpVbHJQZllvenJKTVNEZ2lSRmNjVVpU?=
 =?utf-8?B?d0h3ZmJ3ZVNOQmw5VTY4UnI2MldKQnFIdEdHTUhISmFFNS8ybWNWS3pVc0V2?=
 =?utf-8?B?WjByNEp4Y2JsY3dIcDhQblRMbW9maHFqTDZWb2N1cThZRFJidmE2bDNvT1BS?=
 =?utf-8?B?U3pFSTNpcE9Nbys5R0VXWFZjQ1BoSUtOM0NrV1ZONmdlbkRlb3ZNckxmVXpU?=
 =?utf-8?B?bkhZRHBRWGhRRDYzZy9pM05WWG0yWEJqSE9aUk9EeXplY0ozNEhaRzM1QlZU?=
 =?utf-8?B?c2xvTWlPZm8vMXRDRHhwY0JtQWk4SFVvY0VkbU9zTjJVWlJLdk1kWGlMQUli?=
 =?utf-8?B?dlZHaXFHak9oQmxqV1Q5cUJyRnRjVUJmci9obTJuZTcreTNsZ1RPSnNDQmsw?=
 =?utf-8?B?OCtpSVgrVFVLVGw3aUtQeFBreEJ3ektCM3FrUjVqY3J3UXNrMlpRNkNTZzdm?=
 =?utf-8?B?QjNOM0FJOGk1aEpkczVjcXdzSFNRSHFMTnA2TTZlWXNXNDJhWDRCcjNXR0Zo?=
 =?utf-8?B?RjMrdXZVZitqWm5TN2IyVDJuRTQ3TkRhU2VoMU9BaUdCZWZ6Zld2SU15ZWJM?=
 =?utf-8?B?dERvdzd3OWo1bTViaHlXcEdoR01DM3gyK0tWUWJDb2JZVmo5MEo1aUIrN2d3?=
 =?utf-8?B?UW90WExNQ2tRWGRlOCtvVW8rZ3VFTlNhQ2hPT3hLVDZaQWM4ZGU1elhTTVdK?=
 =?utf-8?B?Z3huMVU2Vm1nNGduK1dOdnZ1SEZiYmlwazVoUFJHSzFFMTJCS1lWSHFMbmp6?=
 =?utf-8?B?RUFzRmZlUFl1cWRoVHVFK1dYZ05xMmx3cUpjTmhYY0NmcjhqSWI1QzhZTUg3?=
 =?utf-8?B?M2l6NFQwYXZkTVZEcWRZZWtMRDFSOUdEZmJqVnUxUEhlbkVSeGkraVhTaUdn?=
 =?utf-8?B?NlpzNGUyN2gvN0J0RlBMM2FtR0JNMS9mZzEwVko2Z3B0emtCQ2J3N29EbzNJ?=
 =?utf-8?B?RGMzQnNnVlNNTERTOWJUdmtnUHd3Zlp1czNoYlBuTlZHekZnM2JCaXoxSUdj?=
 =?utf-8?B?ZUxPdW9wbjhtSjZnZTFSeUk4M21Iend4dUlha1N2d1lTb3VJYUpxeGt6VmRI?=
 =?utf-8?B?UStDaCtHSVdjdTROVVhZVjdYS09PVFpDQ2lUWkdTMGtWczQ4S04yT3B6aGNw?=
 =?utf-8?B?VWNKQytlZWlnWkl4dnhFZEdSbndjMitLQWhuMzZCak56MWNKem96Y1dNbC9J?=
 =?utf-8?B?YU51RkpBS2xZdWpPaVFhT0c0cWdJdFVPUDNVL0hGb1dQMmw4dTdpWkVPWGdi?=
 =?utf-8?B?ems4cWpTRWs0c1dGczM0S2JNY3c1OHc2TW9YMTBoS3hhU0VFTFBLQXYwTjVq?=
 =?utf-8?B?dE5qKzhGQUhQb0Z1SlpibW9DSU4ycDYwWFRQcHhITmRrd3R4M2xkd1FhSTBN?=
 =?utf-8?B?bHkxR3ZSRFVsd1A2QkM2RXNtcWdleDAzSkhTYzJzSWZwOUlCbTY3N0tIY054?=
 =?utf-8?B?Um1vTVFYV3Zubm0vWlFTSmo2bnpYSlpwczNiYTF3Q2dpK0tRbm80cHpLSDY2?=
 =?utf-8?B?N0VQRExObjR0cng1MWlXL0pDSHpXQmRnS0VKWjFwOHd2YXFEcUxDczJhbWth?=
 =?utf-8?B?d3ZqWDJzYnlmdHU3dGkyVUxZaEdQNkZVRzBHZHpwc2lwT1RON3dOdDJLUVA0?=
 =?utf-8?B?b241S1huUHFpWktSYTdwelFTT3VkY3d0YnBFS1BKcnlPYjJqVDFNWHpPOERw?=
 =?utf-8?B?SnNMV3Q0ck9ubk95cCsyek5KZzFadVBqSDdkYTdGOGZtVmRmQ09TYmdwUEtu?=
 =?utf-8?B?UWJIbXZ6K0pyb3lCY0xtVmEzdDhCNExTT2ZQV1pNSmk1OGJsOE9kTjY1U1Qr?=
 =?utf-8?B?WjQ1dGdvUXA4eEoyVzhEeDQwTHI5WGdjYnh3eE9aTVk2TGhFcWxXK2J0Ri9I?=
 =?utf-8?Q?ACAUREpKARfMC1JHiSXaY2jgO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a2fd1-7e2b-4a08-900c-08db8cdd582a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:04:09.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeZ6Uui4epOhtdVXI+e1kFRqy7F5dQC/oMPHImFDOGtqBhlePvYjrwInBU3KbgYgxFmRnbx6dRDhyC4oh30BFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2023 08:47, Viresh Kumar wrote:
> +struct xen_dm_op {
> +    uint32_t op;
> +    uint32_t pad;
> +    union {
> +        struct xen_dm_op_create_ioreq_server create_ioreq_server;
> +        struct xen_dm_op_get_ioreq_server_info get_ioreq_server_info;
> +        struct xen_dm_op_ioreq_server_range map_io_range_to_ioreq_server;
> +        struct xen_dm_op_ioreq_server_range unmap_io_range_from_ioreq_server;
> +        struct xen_dm_op_set_ioreq_server_state set_ioreq_server_state;
> +        struct xen_dm_op_destroy_ioreq_server destroy_ioreq_server;
> +        struct xen_dm_op_track_dirty_vram track_dirty_vram;
> +        struct xen_dm_op_set_pci_intx_level set_pci_intx_level;
> +        struct xen_dm_op_set_isa_irq_level set_isa_irq_level;
> +        struct xen_dm_op_set_irq_level set_irq_level;
> +        struct xen_dm_op_set_pci_link_route set_pci_link_route;
> +        struct xen_dm_op_modified_memory modified_memory;
> +        struct xen_dm_op_set_mem_type set_mem_type;
> +        struct xen_dm_op_inject_event inject_event;
> +        struct xen_dm_op_inject_msi inject_msi;
> +        struct xen_dm_op_map_mem_type_to_ioreq_server map_mem_type_to_ioreq_server;
> +        struct xen_dm_op_remote_shutdown remote_shutdown;
> +        struct xen_dm_op_relocate_memory relocate_memory;
> +        struct xen_dm_op_pin_memory_cacheattr pin_memory_cacheattr;
> +        struct xen_dm_op_nr_vcpus nr_vcpus;
> +    } u;
> +};

Is sync-ing for the sake of sync-ing really useful? For example, are any
of the ioreq server elements halfway likely to ever be used in the kernel?

Jan
