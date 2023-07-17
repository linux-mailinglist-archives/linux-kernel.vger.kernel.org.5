Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11F755D52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGQHqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGQHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:46:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4FD170B;
        Mon, 17 Jul 2023 00:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiIfLWAk5T4HXZ/hI/2H1Uw78fNWgJ56pwqVJ3rmePOn1wo47VT9Crw2Zbsm1qu+uEfgK+mFj8xyvNk64ln8Njf1dW4fCpuBkXC2fSz8rtMs7Du2SZQXrlDQ+B3/XqCUDz4zcoVtFbKu3wr+zfwIO7hL/If0alnu/9Xw3ktMqPSbdKW+JWlQGycNV3uqrlaer4dgm3o3YzTANFHlq62laIW60Q9D7rrWe4S9yC3uMNo5hChg4t0RzfvtcJ5eNcm/FOlaRjTUIbKJfhWaeHwshk8vlUVZ3k98WuXZDmOmwqG8ljEcSBGDriiu+fNQgm48J5uWBXOPP5F6iUmR+MwQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezaIJRiCK+vxJ6JatJtH5a3EjJVS9ErgYH3A41s7h4Y=;
 b=ZroLKU9TwPVPmj1FFqDBANtp5nHvSZT86mJ5T8kWqKz+wQX2AroTbaoqFEecY6pAB4prF+8iNuoEn1kGHq17Q3lzckd+M+wbciVC45IWfRPlxCsiHT2s39V0BHnlwKJtM4Iwp/fmRVJrNL1kawpToyYsc7qkj9I/uvtytVm3sCg9ZG+KVQaRjDPzQGS+RyHbUY4QchzHOPAM9QjuH9FtLMBm5kct8GqyA7LTO9x1nLbBgT/KKXZA/HPDHMl1w8veks9IHswf2y9M44cvAKT5J8gUOqLivjuwEb5MnWVhE+fQE7pGOWYFUN4Y1zbfzN31mqanMo3pAkKwURJjdvqZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezaIJRiCK+vxJ6JatJtH5a3EjJVS9ErgYH3A41s7h4Y=;
 b=VRgGjcEXt83PMfEs5WUPeImGJ0idfbukM+DQavUy0tk5pJU/+qiUJAwpKE5Zp0okDg8yOdFoQEWMw7JY1aMyZmNNTTNWqYkIaGo7ubMBZi+2GtT8HCXjE0FVeCv0UWWGynG4hb8IKGsXgLGt/IXpEcKGSsxYwtWAO7uPgQahlBgKOLpmc4cD1eG9M83ht8GU0nfs1E3+HFMxCICIvtzgQGSEWCWJKBVGuzQB8TuGpuIp7/TjfS0K++MpMamSNTFrcA7Zlx8dKMmb3rVF9VdcBHwCTgYig5HxdxYf2oiKkvV9hXPmzOeSGDE2r7Hhq4gFVFFWt5ttH/zDNFnjrRgvFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS4PR10MB6134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:585::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:45:37 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:45:36 +0000
Date:   Mon, 17 Jul 2023 09:45:29 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 0/3] platform/x86: simatic-ipc: add another model and
 hwmon module loading
Message-ID: <20230717094529.45664a4a@md1za8fc.ad001.siemens.net>
In-Reply-To: <88021872-8aff-4bd2-ba95-8277a5a8e1fe@redhat.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
        <88021872-8aff-4bd2-ba95-8277a5a8e1fe@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS4PR10MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e15f87-3aa0-41de-3440-08db8699cef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TehQZkVhiZAnM3fc97ty917qnUtlALxOqnodjOlgnxhL0Vrr0eCuzxPCf9Aemz+HvoAT4qUjX0MmQ9t5CsKhnlcX5sDZWvnR3OMLj2vWNhvaYD2H7ywvgKzDAq4owwz+rfcezjQL57Kc5+iBdc2QWYfTNq916iWBojp4sqtMajrdmjYkb9bV10uMXFTlCMCsVoJYAawgZCRgv/QCCGYkvQE0f+ljLhPQ4iS/SXw9Zpz+vnDaSX7rOQuZZVyYbJT4f4ZQYflGG1TyVJR+93BMhaBPKcHXNd70YKWdXp1+XaWwVQroNOmXs2VDIExkXRxStbbDZ+BQjKgeP7ecvCDUfZYRTZu6EjWfT8w5udFxscN0CUBD3xtEL4VHb8suPMlNT3X158Q3t1fVR46W5nooe7CUUk97ifERkofevkGnowmiyIiH+ZKtj9hkkebVQG5SVfM4JM/2mtgZ48nhTbSPhJW0mtbylGGdERPvVSMhjFPjXQcUlL3utINsmdKJVcex2edJ3vtAvr93e9OvuEf+w6XHNVW/DuwblGPPD/v3Jzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(966005)(9686003)(6512007)(107886003)(53546011)(6506007)(1076003)(54906003)(66556008)(66476007)(38100700002)(66946007)(5660300002)(44832011)(2906002)(316002)(4326008)(41300700001)(8676002)(8936002)(6916009)(86362001)(6486002)(6666004)(478600001)(82960400001)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtTeKB3uyo6mLra32VBAoTVGWec8yASaLVE2pfBPDLi8VhWi+4cUNVYsUYp6?=
 =?us-ascii?Q?qOgoy9uXj7ZPN6Aqs8LoYK7XybrvvMoDEwG4zs21Qm8C9F+8upAGQlHddIuV?=
 =?us-ascii?Q?SPYYsZm7J2nEwIViJ3HyTPx5XYx3e7p6RfX6heNVsPhLKcSQ4rdHgeCUmFC5?=
 =?us-ascii?Q?32v1nhgsiabPQEUeoGi4nK1wmO+VDa/U0V8PDg0B5EEWDxpo6u+ZMFyTe3Ly?=
 =?us-ascii?Q?BcMK3+iGdFAtWbWHYwkdwqgQoW845JNmvNGt32qJ5/w1DLsuBnkPCFFq7IOH?=
 =?us-ascii?Q?rgGtl0xeR6BVMZIf40T1bPG2GrTnEXD3TGmQ2e1fwqSj+5LqZ6AY6coZmG50?=
 =?us-ascii?Q?Y7gd/vwSNtwweHoE5DJhTZXMhVHjz1Zpu6ZjBE1O4H9ZzWi8rFFnreZE/2mU?=
 =?us-ascii?Q?M3vz6NnTvdkEQBzDohMfgGRjsM9HoveR3zJDJkNsFgADTWKyD0QQVJdwpOcl?=
 =?us-ascii?Q?NKodQUB7Ig63Z0eaTPgIZdutTyMJVYxf/9OPBqiEeCHMSs70fS5Su5J8+JUQ?=
 =?us-ascii?Q?4RmBN8QHiuEUglbo6A3wXU+0Ai2MfsWzcRKNxvoywXPnwXqm4AkKyQRaxY0V?=
 =?us-ascii?Q?24YpFMMSfTOPZpp3ufiAZmjUrnokxgkYbCxLHjNFCNhmQAl73tafLWDVkcVy?=
 =?us-ascii?Q?MKqXsWlOJmouZyT2j9K1JNnuU1Cy4tN7yIoG41+S2IrqeVA1MgrvofwMf/8N?=
 =?us-ascii?Q?f9b7N7earKoHHmND6/wQUMkfLIn5tYkMHA3YpMQKmeBth1M2CDZaZKoRqyul?=
 =?us-ascii?Q?zeokagqG6Ysza5J48nSqKBqS3PVGVkdesI23sRpN6F8CZEKnZ+ASa2Dd7I+T?=
 =?us-ascii?Q?9fTWJ1V+w6BC5GnKFguZc7EwfVAFbHTJLviEzoHaQBHGyUKxDQ0hBe0iWCRL?=
 =?us-ascii?Q?CDi8LZUx4OOoncNO10esuc/w5LqOKSZMjpSm37KXTZ09UtKWAyPRnzmbiUim?=
 =?us-ascii?Q?K9WsAJ4mN/7OB6vuDW2hK3phq3JCM0Lp+XHSo353h8fROB2CJzBKAgR1QVuT?=
 =?us-ascii?Q?IWH7gRNHvNy33GpdUyB8knu0TMJXYacgkl//Whk7bX3rUtjPfoDUyUObdQvV?=
 =?us-ascii?Q?hlkWHbHS6Ls77ZmKQeBQWjxCRyeyO+SPZirPIQb0a+7/FNB1Wg1NPdu8yvAI?=
 =?us-ascii?Q?/Iw9/l86Lf5g/LPN9N0uccAw5zQeY8PDWiJiWQtpdsGLRFlG9U9ppx2fi0np?=
 =?us-ascii?Q?tSeG0yVC0HNDi7S0fuW9a6cTf6xP7peF2Sia4zNUrgFaKFzaXUsVMzswgSCl?=
 =?us-ascii?Q?ozrMUI4qbniVp2+ppqww6d2gOiwFajQfUIsoLO2NHB6jVPZV3YkAkkSYpAeX?=
 =?us-ascii?Q?WWGKHxAMRBz1BuWSlqZkirvLGwgzIL5UQuM4hxrsFwtD6RhDKZv4K6NFXTcO?=
 =?us-ascii?Q?qGVzDLJEQTWo0aWCj0QJsog4LcDoTUCPvsGDCIhBDQMBhr0iIuFZmGbwqjXY?=
 =?us-ascii?Q?znWMFYJWFN3h00dY00SF/MuUZO2y+JvV+36U889v3Gk/X9KPC0o5A89h2KtT?=
 =?us-ascii?Q?040MahcwpgIFnTJVsrvJQLYAwKqbzfdBkPPXvd1V4oGq26jO/v2emfzav1kZ?=
 =?us-ascii?Q?I79Cq4b9cDbQF1sovkO25+JFDQd83jKaBdvchhe7QJtWBz8mHRPAZsULjbAb?=
 =?us-ascii?Q?uqhh+e3z7vcXxBVGXkItBNdsZLQe6VjKJ2aK7b2KfiRItvgX0tZEpYCiu58f?=
 =?us-ascii?Q?SFY1EQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e15f87-3aa0-41de-3440-08db8699cef5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:45:36.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TRzwC54qWbTsQ7VhhQY1VXO0nHzD00iZdIM7dRSAjrBkpEW1YQnYjYXmxgvI0gKBWsQFDSqXLznUEzvNKeipjcmJZOUqQ4Fx3ws3u6DjEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 14 Jul 2023 12:18:04 +0200
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi Henning,
> 
> On 7/13/23 16:48, Henning Schild wrote:
> > cahnged since v1:
> >  - switch to using a list of modules per device
> >  - add p3 and make the watchdog module load code use what p2 created
> > 
> > The first patch just adds a device that is pretty similar to
> > another one we already had here.
> > 
> > The second patch loads modules for hwmon support, should they be
> > available. That will save users the need to detect and manually load
> > those modules after a machine has been clearly identified by its
> > Siemens Simatic IPC station id.
> > 
> > And finally p3 changes another request_module call to use the
> > mechanism introduced in p2.
> > 
> > Henning Schild (3):
> >   platform/x86: simatic-ipc: add another model
> >   platform/x86: simatic-ipc: add auto-loading of hwmon modules
> >   platform/x86: simatic-ipc: use extra module loading for watchdog
> > 
> >  drivers/platform/x86/simatic-ipc.c            | 74
> > ++++++++++++++----- include/linux/platform_data/x86/simatic-ipc.h |
> >  1 + 2 files changed, 57 insertions(+), 18 deletions(-)  
> 
> p.s.
> 
> Looking at the latest simatic pdx86 code:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc
> 
> I see 5 Kconfig options and 5 .c files directly under
> 
> drivers/platform/x86/
> 
> at this point I think it would be nice to move this into its
> own simatic subdir: drivers/platform/x86/simatic
> 
> with its own Makefile and Kconfig to avoid cluttering the main
> drivers/platform/x86 dir and Kconfig too much.
> 
> Can you prepare a patch for this on top of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc
> 
> ?
> 
> See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28
> 
> For an example of a similar move done for Dell.
> 
> Note this example also adds
> 
> "default m"
> 
> to all options except for the main X86_PLATFORM_DRIVERS_DELL
> (X86_PLATFORM_DRIVERS_SIMATIC in this case) so that on interactive
> make config only the X86_PLATFORM_DRIVERS_SIMATIC will gets asked
> about and then the rest will automatically get enabled as modules.

I will look into the relocation of the drivers and send patches in the
coming days.

Thanks,
Henning

> Regards,
> 
> Hans
> 
> 
> 

