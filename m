Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563257F9F61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjK0MQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjK0MQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:16:04 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B12187
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOX25ZFI4+YXGM5eRa0uBa1rIB/g74a/JlgqKVjwjHw+CpYri1MYUKpwQB6z1rstOGz83SYunwnyPKYQIkWWhmKHrXUetdo5cGAqMBNcUaAWBxnn47VcFmHukno5xONf7lbFEBPYOlKUp3EJStQ1o/jJqRRiraedZYJMAegiO9NZgCEnmooY9/iPzy8ud/yBEBXtNrUC0E24u8e1e1X8CRUUUlfvewfDKJ3soGcd1l5Wxz+nwbbO6mXAvnvX6icE6KhF4fsABf3eCPB/J1Bc/mmrCTaBI6x9Iivq2R5TzDCMhmaquRlBgzmt62c1BpAij1J9jXDJ4aF1+IWPt3Ecbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsRr4QMBz2jEizZ6c3oZHr/xxRTeHPvxLmajcM5Q5QQ=;
 b=DZOppMfJSJYDC2sE8FSA/bMgnvtOFrZPj4wPR0NpsxQYU0XVtlnxCwFdEi8MvR/ub7ayU8zntYvR41ATHn776ymGHmTyLY8/UfCfZYph92Be4oFHm7Dn3+5bW05/B36Ht47m4nm+Qc8hy0CFL5c17umGo6sC+S6VJGVddEmzlmuj8WJIaw/DgFvp5hDtbQ9NTdpyeuuHiARalYRDk+ci1Ku+bfjDXo1N7m6k9H6QkYhyqu/wFrBYjK4px2ysd7OhxBdMuJo+ES/WpMZ/Hn+oSsG9IuVYKLilg5KVj8HB8QaBlmx66JjzcMW1cwucSQDKj3ridVOM9CdYuxKoKIizhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsRr4QMBz2jEizZ6c3oZHr/xxRTeHPvxLmajcM5Q5QQ=;
 b=YEkT7ONkzhANeADPc27n6oFzTEMLFvkeTkMKTEqQFXJO9XK4dAou6Xsvy1ADEz9tZEU99r9VHnaNvJYGk/YOQY1aYSdty7YRI702WYSPIGpoDmPwrlqRAM//6jP0dSzTxZGsBWgfPh8mXqIjs1dIJIK17nZZlLxUB0MNFaRNQ/s2j56PPZfteh9LP2O9OUSs7wWKFk71cqaP1ez3izleRThrQ9cOIIkQQvvECH/dP2/obVXYj3BR6n9/WWXZQ4FP2AiTSdpty8KFklX6W7Cp/kh8LhAEwcojj05SievcmQd+tJw1hT6qyQEbt7teLm103F84bz+c6j6jojmEIgQmcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 12:16:06 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 12:16:06 +0000
Date:   Mon, 27 Nov 2023 07:15:59 -0500
From:   Wei Gao <wegao@suse.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     tglx@linutronix.de, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@redhat.com,
        peterz@infradead.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
Message-ID: <ZWSIfy+QJFyw/zGC@wegao>
References: <20231123053140.16062-1-wegao@suse.com>
 <189e733e-7056-45c4-a5c6-3371f8219b7e@igalia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <189e733e-7056-45c4-a5c6-3371f8219b7e@igalia.com>
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 73951a92-6d96-42a8-b1d6-08dbef42a159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Re6VYlz9SihC5HSVPf/ZUNyopDsVthNwDTm5xdxr/92mBROqARaUVI5Z5AbuvsAqQYn79GVTf0XrmXWrqAoGVnvpQ5tVSY3aOg9r37dr+ZUCbBArn8FwS9mhQHPIN0/AVQPcY91qYh7Xfry7w2O9LSiKPSxC8EHDA268/ToZovhjfJd3C+8ImwH3Y1/t0HjZFN5pehwCLT20m0BrKKUiow7SDRVpuMge2vCyS1gDtLs+P0jxEbB9nVPKirqc59GFNiBkuhVHRE31p4YvExmPedpxKpjd85IBHszwpNRB6H7a+eoWSrp0eLiw5UyrII5bXSzBH5uUUh0oijzXFntT9XvAnaJP6+LLeQkAXf4LyDtfTnm/mvqtgSZ0f60fL9fOjOoUQ+Uua80EDwi8ScQ0t5xYKbPT3ZdOKZjwAJ5/LfviScHPALxpCIluIMhU419kH5xxRk4/M4m5I+thj0irocTzh27R44cMT9w+kcKAkffxDvlGVre6oFS3cWK088HTLSt96dDSFD2bCuMidyA5TOZM9PynTf0gWiYCyZGW55y/Y8kW3vwmj/q2588ZxrN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(6666004)(9686003)(6512007)(41300700001)(478600001)(4326008)(8676002)(8936002)(6506007)(6486002)(38100700002)(33716001)(83380400001)(86362001)(66476007)(66556008)(316002)(6916009)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JVqsbnG4RfhkxrtqZUtomjXPnCPrA1KWt2lie2cMZmmdWoQcuZYba9yJaI?=
 =?iso-8859-1?Q?hm95oS2h0TVchOyoTYrff3Or5EfPsid9ssj1ahNexKUw0rpcOZgTOGDxmJ?=
 =?iso-8859-1?Q?2gGjgDt+iy8TtTuaxjDZbLsSrfXIT/p+6ujgz/o1FnC5MLPsaReJnW4N/4?=
 =?iso-8859-1?Q?yO9rXN3fSIDzzOYgw91Fa939pEd3Iy3WzMSsDVLK/+YJEI/bBjM7EkgRyC?=
 =?iso-8859-1?Q?qNbntck7YxDx6K++6B90eMOLYCqq7PjJo5Pl4p9cimNAgqgV5EOq2ekbpA?=
 =?iso-8859-1?Q?EQrSjXjm4Nb6WwNFbDZf3msqIcTm2pQ3BgTlvPWgKsMbUWPK81ksAwzGKl?=
 =?iso-8859-1?Q?Zlv5Pwuwf3KL0obxYwiwF46/lTLcEraLaY3/L4xcTqbA147yXSJlS2PiiO?=
 =?iso-8859-1?Q?nqXrpMfnlLsgIJxBSePkthYprdp4HPKINA7XlRvMsDQuNddeQp7kGgKh2y?=
 =?iso-8859-1?Q?DtC56uRsG6+L7aCE43/XtjXc6b4vHhcEaHldq7yLSj50jLozVsbO4EnjkH?=
 =?iso-8859-1?Q?vjLicZL6DB/m9+mWYa0TYq8moC/uRFB8MUcMG/gwsDUYK0OvX2bogjesoC?=
 =?iso-8859-1?Q?gkTQ9jcamNC0/en0z4ypQrNE/Kra0ff1qTrn1ACXAnkWOShftqqxZkGBA6?=
 =?iso-8859-1?Q?ZIgy2eaIoE3J32sH6E+wIcUYwxuEPQzo5mqVOrO9/ZhgjobCv6wZDf+Zeg?=
 =?iso-8859-1?Q?oH/Wi6NfYTYkqPx0ONkAslm6DQ9qEAR0cLZtnnszVEF72aF+EOBK6+FGsh?=
 =?iso-8859-1?Q?FptY39sb5kuA/dT0F+eglL7u6uCPRDSxVkomLqDdQoM879JcBAyMO0Vxoo?=
 =?iso-8859-1?Q?ixlVHqbLvnMLevTm5aeUJIqtJNptkyRoqmbdgyAKd2Eklk2HbdbVFMzWbo?=
 =?iso-8859-1?Q?HgbrmxE+8oUWbxY0USwjI20tO8aTAXVZMw4FnZYn6IbP2o1HNFslK7PB0y?=
 =?iso-8859-1?Q?InLltmXdTZwxMGUETSy30THWPWqCQUu8duH66bKCmKOLxsDhRWveOnzP+E?=
 =?iso-8859-1?Q?wdbnmcTkHa4hnfrnpdK8fD+zXRMxYbsBkahUFRjnDhTJdXLhSqEGmoxTxv?=
 =?iso-8859-1?Q?7RkCjJMJJji3rNMm0SEOD3uM4yCs2yQMvB7DfdBFQJYaxMR7QHriQOu64Q?=
 =?iso-8859-1?Q?q07Bqs1z1dnUxR0sVZ9b3Vknx2bHIMhptkeBd1Mt+DgCwRwtJpXDznEGsJ?=
 =?iso-8859-1?Q?yMvuIXWE+vC3iNhJkYp+3BP7fcZSY6f4ATRIh4k7xjg5MHrgFbFxthuLEL?=
 =?iso-8859-1?Q?GnaFI5WZmVBCm7QbNdXcQje0nJFHh4B2zYszi/xhTCgrnvvkxcyZeD/UxS?=
 =?iso-8859-1?Q?OitzJz3PwkGVCL0Sk81mTKM0Tfe67SW9S/4IlkBU8avEHbZ6Ml29c4AeJp?=
 =?iso-8859-1?Q?HxyeazKRrTR7Kxd7lA92IPl7tcqRCJMqv+VyFRaljWc1A/lyzQ9J9glXEK?=
 =?iso-8859-1?Q?pnfuGRCZSm1svs97sgmymnQ0ypFEXIRFqTvZp6uAniLe7U+52BpyEtc4f5?=
 =?iso-8859-1?Q?XHB/8B5VfNG6DJImYtvAgGw7bt2M1wPvErvXY0OJ5PyiUr8l0TJxK+75L2?=
 =?iso-8859-1?Q?eM0X6rMYuhLGP3EgLrjo2QFRypSzQY5HADKGdQSExT9WdEamr7dh2ACkA2?=
 =?iso-8859-1?Q?0kce4n8AabjNU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73951a92-6d96-42a8-b1d6-08dbef42a159
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 12:16:06.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgijzCCmT9jLJOOXnRZyUK3F06uKgIJ+pp7EuGL3qT/f4NiQnAtpWOne4Kp7aeBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:09:55PM -0300, André Almeida wrote:
> [+CC Arnd]
> 
> Hi Wei,
> 
> Em 23/11/2023 02:31, Wei Gao escreveu:
> > From: wei gao <wegao@suse.com>
> > 
> > Current implementation lead LTP test case futex_waitv failed when compiled with
> > -m32. This patch add new compat_sys_futex_waitv to handle m32 mode syscall.
> > 
> > The failure reason is futex_waitv in m32 mode will deliver kernel with struct
> > old_timespec32 timeout, but this struct type can not directly used by current
> > sys_futex_waitv implementation.
> > 
> > The new function copy main logic of current sys_futex_waitv, just update parameter
> > type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
> > and use get_old_timespec32 within the new function to get timeout value.
> > 
> 
> From, what I recall, we don't want to add new syscalls with old_timespec32,
> giving that they will have a limited lifetime. Instead, userspace should be
> able to come up with a 64-bit timespec implementation for -m32.
> 
> Thanks,
> 	André

Just a comment, I have checked the glibc latest code but do not see any implemention(*.c) on
futex_waitv syscall. So normally you have to do syscall directly with __NR_futex_waitv from 
userspace. So i guess glibc-side can not covert this struct correctly currently. Correct me if
any misunderstanding.

Thanks
Wei Gao
