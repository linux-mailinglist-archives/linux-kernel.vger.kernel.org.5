Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FAF800425
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377655AbjLAGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377641AbjLAGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:49:49 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09131720
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvQQA8y/c72D/K1kTE1c1sUnELaa7Wmf0YGMLI3ayl20fwuMiBx1FqCTdMQfuY3o+W9pI3+FJ/zKABJ0whKDcPP1mfTrB2sQQ7kBzP5TM9DOdC6D01olmlx6baix1mU31A8XYpkiIV107BXmLDdceESzFth8dyp8KnmRyax/Hfaz3q6TdP48CzZL2KerDKTt7VXHOmeDL4ZuUV2eCequPAap8MC/L8ug0Rsf9/iFFySXB2pmrz+sU9fBCW0Jz8r6HvHLf4bJqULfxhAwc6aj+obTApd9apUa1hKNnHt51qQ8F3Pt+VbqhLinld2Y+6+7C67q8IzC/BOUoTJYGXXEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3fYrHivPh73Owdbe5EMa4EbtOf+JKssHo+Mb/A+vmE=;
 b=nlitSM84zN8NcJqKZZx33JvQ9mczBjpxt5XAxDHzl6ePe5/zJljrtqC+3hNfks2UW+Os2sLdQOVRKnu1o8Pqhzkg10h7xThVSGD4q0mE3aC60BbqUxQtFTjlvRW3z7oAGpwm07CPDIe1TtqF0IhBOI2K6Eige1cC/7QcgVZbHo8BZcYeQATeg2bpl+rMyX40m279x+oc7phonCXKBSo2INxC7r80JkmK9ZYbxzTVoFO2ZNaLu0R8DZ7Vo2P86cCvrN1QhDWMm3oXRURAO/am3c7+1HoI3NuaeCspb4ol2NsEys1LnjKeRrz6l1aik21En991cr+plNDqKd9bZ2QfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3fYrHivPh73Owdbe5EMa4EbtOf+JKssHo+Mb/A+vmE=;
 b=lbYKwTjWPkvgOvFIUfq563VPO6UQkHFzr/LMgoFsnu51iTkUCTchsR2larPCYOCOIKGxsTkvqHNN7UJOdd9MbGeFTshzl/nF0Vgm6MvHqYI9xyBjSEpIzHbYEA2qAaby5SsEzsm8sutrWMz08w8vtpnTBFdLe1PS6YJ7aq4nmsc0PDYZnltBzPnm3W38ac2nqqlOXlsX5cj2XkpuHuONu06+Lt6TC8HZFpgPAUb+xGiebxOzz7032PfbQR7r95dTlLG5xAEW6bZ7E5MD1wCKoloa481gQecuh/AhOKR1w9CrWAYAXtH5fLUwJ4lEO3aMBqTvN45U1ANy1hvraOCXCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15; Fri, 1 Dec
 2023 06:49:50 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 06:49:50 +0000
Date:   Fri, 1 Dec 2023 01:49:43 -0500
From:   Wei Gao <wegao@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        dave@stgolabs.net, andrealmeid@igalia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
Message-ID: <ZWmCB5AL0sULlOFs@wegao>
References: <20231123053140.16062-1-wegao@suse.com>
 <87a5qwz3dr.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5qwz3dr.ffs@tglx>
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 362b204d-2a52-4b81-58fc-08dbf239b757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zc7Ox/vaHZwiQUl9STQgih3ZM9baaxb9PpDQGeV8kaFbTXZatWIJOS3Wuj5Uv9qVm1kW7w/v5la3+lr8lojsM92+r49lAEXcqNvANl39ni4mXYUDOEO26gxpqiP6zfXywnEvUQ622RLrq8FVAAgpzNlTEDm1OIxluQ1fRouXL82Bu3U8TDawK/LzX8jt4EqwHSYThtk1Tpw8ZUuQ5gZ40nt+UOWv48/xg3NLP1dk35DZYALhrkrDLYwPCseg27EniRNsIOFI8QyvyASqqvAczCPZ/8aCxJQwvGURKIyE5jM9X0Qoh0UoUMMFOetIlqxb2kCErY+DQqbryY9EVcpfNaLytVTe3fwVeXUZUbL7pxBgA/z/3ktPE5p/8yXWxFomNs3N+OlVAnfct7y0UV3wbagSOSW4fBv6PX7+onrM7Yf6p9j9skEtI0/6+PuZDk1Oko/ARA+Nljz51h29z6FplVCP58aKRBIeANs11fJy7tZiTpTVu/LViDe8NEvRL06b9hl6oS8DXqLpAjCZ6T7zemY+uir5ynjatCLxrx0w/FxcUcOt8ZIKTNTtqxZievfJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(478600001)(6666004)(6506007)(6512007)(9686003)(5660300002)(33716001)(2906002)(41300700001)(6486002)(8676002)(8936002)(66946007)(4326008)(66556008)(66476007)(6916009)(316002)(38100700002)(86362001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7ehahfRV/LulOkGJqIkZwDdk9A1M7WJZ5TIKKN6VdBHYy6VnzkrRlX0J/Vw?=
 =?us-ascii?Q?bJmjfoDHCywoVCDI/c83y5KxTzf7BDxZL5zm++xFFVoIsTTJ4SsO+QAtqXtP?=
 =?us-ascii?Q?4xWUCW5oGL5BR4TtwDgoU2gdJSmdfdg7rD+0OKEbcIrqY1p5CJIYH/nsqyM3?=
 =?us-ascii?Q?1v31eziDVcPqJ5e3BT8UJsk3P6m1dAzAc+jfyKjg7POLtQdMetAcVlDFfXUN?=
 =?us-ascii?Q?evBf2T04caCFVKzgGGzVq31ffCJrA8VAOUu29vJQqqKJp+nF/rQ9xQq7+exR?=
 =?us-ascii?Q?+mbcJ1pd8Hs1DErc0No+MG4hvw2/9wk+M1qMUW1k+Mmx9X5b1j5IfkLUKpqU?=
 =?us-ascii?Q?T4HrY2L6hXGBvJBrHfwulFPS/q3/MeiQj0xRZc3BlqhlvFRAZgb0JWwVdwZ3?=
 =?us-ascii?Q?ymEpvNQhoPR4nwh4YA45oghDEpn/u9K+yb6UoR9mfh8Rzv7FUIn/V5HF7IH6?=
 =?us-ascii?Q?GGayE8hKIxd6njX/j2VK6c90K9ZD//9uripiuwwJikSIMue2kcQZmQIoEBeD?=
 =?us-ascii?Q?nGCwn6k/GpqQaYB04Ac9lBFCHm2K8WHiXu/UYSWXCYlqKfeUzWi64eJmkMpc?=
 =?us-ascii?Q?N++Iqopdp1ObJNFLbN3heXre/qDHIcf+QKrFXYLNJom6ScXMJ1T9ioKu9aiD?=
 =?us-ascii?Q?UEtgUCt/0o84wNAivyL5oH3xbIYNLaxmXiFew1FVhURQBYR9clS0qdTr8O4L?=
 =?us-ascii?Q?gVecEUl8LXm1GmToSDpUL6xTADSAiOux569zRIot+2mNp3L97RW2tkNqHeFC?=
 =?us-ascii?Q?9onGUrdKANQBSH8oGjxbEi+2xeNgWcIQacBvM4Ef7nN49EfSF8c86E/CPzM9?=
 =?us-ascii?Q?fDbnCGP2RLER5Uu+9sOzV2yrtiWWAPQS5tT115uYvftnrLM4Ny9BxSF1w+m+?=
 =?us-ascii?Q?ug4NMTvvt+zBt0rBuVoNL1r+B7h+G0Oozvx73GBstk7EbPtCRAzKV+kT+ygt?=
 =?us-ascii?Q?3KO6Z8BkflIm80dZTr/rblZ8JVrUqSTsLysy4NNoAcMSIVW49HnP4M+ElTVX?=
 =?us-ascii?Q?92w7wyLHjVJWDx8RRu7WnpvMNN5/rplCayBEuu5v+SCTYlgOSYtAR2jmlS6G?=
 =?us-ascii?Q?9FfXWiplCfUalqUdQXQU+yeyblNL4G2XmwTGq6agHXfvjIHDNrkRY24mSyc0?=
 =?us-ascii?Q?UbVet3vWxb0fZzgVRt67QKL1LVfASxuQ7tOyV+xBccL4n4BLgoDHXr8jy0RM?=
 =?us-ascii?Q?1SLLR/jUzCIFdEXYRKf0R0d8yE3y2CRuE1u/a/TaqxFqAs2Dmnkle2YzroId?=
 =?us-ascii?Q?9JKWbP7cXgrtsVWPAqvBfByjoTUJ8L/a/cwQnGJtZGvWq7vzuarvJOFhM8/0?=
 =?us-ascii?Q?87QcSsR9UVIbewteH0tpIQlETOKBgcfg+g283QECBr5En3fTkywfkIssyvEk?=
 =?us-ascii?Q?Lq3GjtW7b35aOq6k2zlISxLTWCQGPHSyJdWE9DgWg+zuFbiYVv6KoQls3bvJ?=
 =?us-ascii?Q?bthkZrsnFCAPOxY2lDcipGw9Giw7SZoiKtNHkBJTZ4Qj9MG6ts+c81mV/Z/c?=
 =?us-ascii?Q?WCmm8kSCuhpq0aQrNjP/PXtkyiFD88LdlcZAuOj/Sa0PK0ONc9YJbiQIGObG?=
 =?us-ascii?Q?yQ/qC16XqhlBTQ8AMu8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362b204d-2a52-4b81-58fc-08dbf239b757
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 06:49:50.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHELEMaE24lFeU6UR+mnNx3jg6YQjPmjLWWXNQpbidplgpRNtKLYRsvYfhYa89mE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:54:56PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 23 2023 at 00:31, Wei Gao wrote:
> > The new function copy main logic of current sys_futex_waitv, just update parameter
> > type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
> > and use get_old_timespec32 within the new function to get timeout
> > value.
> 
> That's not how it works.
> 
> struct __kernel_timespec is the same on 64bit and 32bit syscalls.
> 
> User space has to use the proper type when invoking a syscall and and
> not just decide that it can use something arbitrary.
> 
> All new syscalls which deal with time use the Y2038 aware data types and
> do not have compat fallbacks because there is no requirement to have
> them.
> 
> If user space want's to use struct timespec on 32bit nevertheless in the
> programm for a new syscall, which is obviously stupid in the context of
> Y2038, then it's a user space problem to convert back and forth between
> the two data types.
> 
> Fix LTP to be Y2038 safe instead.

Thanks a lot for your suggestion, will check it.

> 
> Thanks,
> 
>         tglx
