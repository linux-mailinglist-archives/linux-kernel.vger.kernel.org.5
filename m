Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92C27C841B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjJMLKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMLKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:10:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B4BD;
        Fri, 13 Oct 2023 04:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/Crf94kBDawk0qTvtoxsMfb9RJDuc9ZF2Iyvie5hemJ3WljkdNMCMrF/fb8V/HVo7EgWsRF6+/okgobHoNnwcKsdIJXQCZCdC3po1t3x573SBNEgEzdK7DsDA9EZ6j+KjaYZNE6IJuswJi07IyFy7r6Fjmypb6n315KLBQww3XkhlG6MlOZEI4+W84ed4ZPGwb0ZqhuOiTLXzpa7ICawvQyNFDgzMWWquivzM5fqqa4NosBsTBEqRzhqNliLSFPLbWhlb+GBUiUzms+Vxx5GihIkqAEde66fwgiy4hrAVxce+xlkGrbbaMUSGTorlCfJvPoLKa7t5v6nHxghNb7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBBlRBJzDQreCpUxKK5jVwfK9FwDa0HNroKWmqvgZyo=;
 b=GujmMSa5wgBYRK9KYO/oTYhfuuaxDG3tB5eiCsWLgo2A0ZHTf0wVjkx7Ld9hOddg0EDDO0JBeM908G7MEWUyDaNodTgyO8GBdGZHzDoRbG8sKDkpI69Mu2Tybah87iRQAfbsnYBzK2SKtFKgYWyk+3/ugWecVGAhKjvpiTca+ONuM3NdDgG1WogmCsZB/zWGdso/AtZ8+DWon/TfeaeVLlquskxf1JqqBCT+4NddhUDvsQBtv+NHxUuZMZ+KUWq/RIf6wn+Dboe7MNmO5cRhRrX1pOpSLo6If7qACFfDWBNFIYlCYDBWSHGaJqhOWzxqmyqioa1ecW21mNIDsLAnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBBlRBJzDQreCpUxKK5jVwfK9FwDa0HNroKWmqvgZyo=;
 b=iFYMEgf227boWpl+Mr38QkqvLLPyJCXs8Gorc/+LCaC6gfJkW1dj7l6DWTelGfnDhs3LFdLqgxw5vCe/LCiMY3sXqIWivJ7LsLpjKAOb7NHL8oa3zB/EPT0NXsCL1SzejLa+Y39b8rp4N3bjsFZ5bY/R0oUIF2ihUtfowWW+t2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TYWP286MB3646.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3f8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.30; Fri, 13 Oct 2023 11:10:37 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 11:10:36 +0000
Date:   Fri, 13 Oct 2023 19:10:32 +0800
From:   Zenithal <i@zenithal.me>
To:     syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-usb@vger.kernel.org,
        sfr@canb.auug.org.au, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Subject: Re: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
Message-ID: <ZSklqKDnv9OAGMC3@Sun>
References: <0000000000007634c1060793197c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007634c1060793197c@google.com>
X-Operating-System: Linux Sun 5.15.67 
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TYWP286MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: c7954fed-b239-4390-4f6f-08dbcbdd06fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYOVMpLPqvAB98aA0z4WPu+yXm9UQiA8cC/J9AXp6FR7/YXQWrV+F0GaZjcqs5SONqEKjZIg6G8m+YZDYGPwKlB6miV9RBa4unXt3yw5I+MCOBkPl/+W9pIMqtSr8wWFk/Aee3lrZA7XdAaOlGrulcpNpXNOKFnJoJEde+S28b0izg/YzyxW9kKQ5gBmBMuU8oR7bAXBwG0uC5mwRP9Njrp4tTyvHEjez7gCvx6DtdMshUO1YxUN0Ck2BIupBJL1tPqIakDr9WTDoC/0l9kCARceQSj5FfMrEpophy6zUfedFkbhumIV+UYD3VjZi84xQyyyfT2UYgRw8i5TCb5n2Ax/CIA+jtG/4syp5NBB+mBJDDNscjom+l96WCGEJCcJN8ci9i7rETBkX3FooDQL3YzyZY/nQLFqpPueBZAi1J5xbwNBL2r7vTBnHNkpR6FaYgX5g8W4LMJEv6Kt4al3MRsVJxk7DgJPObZKvJcAcsWuWT8ylvpGS2nYXCvTzHk7hiA4R7duAfw8xu22kG8L0nEkb2VWSgNqKntwIqSYejmQDFdmaFeYJNQxfb1YjkOx6tQbBcRQQv9nx1ss8P3QgfaGxLklxAz2Vwn2wo8XqYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(346002)(39830400003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(38100700002)(6512007)(4326008)(9686003)(558084003)(86362001)(33716001)(2906002)(5660300002)(8676002)(8936002)(41320700001)(6666004)(316002)(66476007)(786003)(6486002)(66556008)(66946007)(41300700001)(478600001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ccFpivMnxTJk3bTE7f+gex8IQR+nNTAaA7aUeRI5uBCTMHMkciRgiNqSi1TT?=
 =?us-ascii?Q?8JeWfDNkF6kDNqjjNo9swoGu5VbSVhf9G/m2C1/24u2PjLBZR++0XBs8talI?=
 =?us-ascii?Q?8Mb7jl/W3mEKRgAOROGZrtlldKPTJgSaXgIOYw+NVdmvFGNdeeesEb/u/HcR?=
 =?us-ascii?Q?CtvrBEa4mHNdis2uGb6+LD7G5q80bSrThVcOsyXvTLJxOuydF5bLUwDbIGXy?=
 =?us-ascii?Q?ejh0Ejlb6sUKdYX3qRhCc2U1pD9zXwSJr6gCnBcguTuEquVeBvEMYCvJ+T3R?=
 =?us-ascii?Q?DNLRnBV5D9NGcqfk85YBJ+POr0GCjVuvnLMyOwGTIWt1G884wSMfs/Q0rRDU?=
 =?us-ascii?Q?ND5rVabME9Z5UgtzrZVbngtEhpoZslku0wkmW3DVNoxHkXI6gN6xkrmVbE9b?=
 =?us-ascii?Q?KKkVFotVrG7EWR/tRLjZGL70OWpVke/Rnvv+ozkHMKQcBLNzr14bvHecYU2V?=
 =?us-ascii?Q?xo1UcPWu5rzrZE2qIZ+qqGeVVoHs/B6oD8OcVLkEtm8DcPMRjWN8DPMoMo3u?=
 =?us-ascii?Q?TrbOmzt4OyPg0Qe1+ognce8myRXUS1F0Mdg+Vo/p+FjvrPaRRMi/Bo9otmcR?=
 =?us-ascii?Q?5udYnkAPXdUBgqis53HUaUxOdiTNqmqWtB2eSjVXq/v7q/Lu7LGoniQpNZd1?=
 =?us-ascii?Q?wWZ9XWzfRKjKtiRn0DhHynGX4xiIC4gCkfeGws0aHmYnixwUF9lP8YMscYp1?=
 =?us-ascii?Q?enPqEuyuZWVVmPWJetgxOuzLo4dDAgy4SxNnjXuQIpJ0+IXxbT1WtnwvyR1d?=
 =?us-ascii?Q?ikFm+RvMLlBGZ9s7NBNI43wBFJQEiAKhUi+BGXHJbuQvDa7xhGUon3Oh1wlN?=
 =?us-ascii?Q?21BtrGZwE3wj+aFcltBsM7pWiEdUVteIiVVL51amN5foY4YHHXggK4952CqJ?=
 =?us-ascii?Q?CNHhevhP0pe6jOrpnpkPMzljjDNp7P3UKzu9SxEv2Ys7lTk4oji9maXgDoVR?=
 =?us-ascii?Q?yjRvQn6E5T30clUQs/CbbxncfadkDtwOKvhvbyvrbwswtCMcM9erkTdUVUP9?=
 =?us-ascii?Q?nz75/q3Z5SUCuQ2/KnXtP5oS5uwvuJ/1yO6bd8L0YPKOEHvxQnQuM2ug/Hv8?=
 =?us-ascii?Q?RL7P0w5mvcsVK18PGxv8bLQ7CNYB5SqfieXlZZNuER4M1BCg5JK9tpVvYzFJ?=
 =?us-ascii?Q?sNHmiVbQ5MIYyzVYqmfgeJbF6SgqNT78oMO4oXaSSD2J3lLULwXxLaTyLBuP?=
 =?us-ascii?Q?7T+lpHTbf2f+5T3kuM9/9BqzH/UoR2bwPIqwRvgBnP8JLiscBEzJN3O3opQa?=
 =?us-ascii?Q?GPBgP/GgqI0AGvKKiAjIHLdAuCiAx82fsAnFFz3+WRg54Jqv60yC0TJrrVSL?=
 =?us-ascii?Q?HSKX9FjPdRxyc/unnSZK/5pXadIyW8HcV0F//vrDn23yiK8K56jLkCgxGHjd?=
 =?us-ascii?Q?Mh6ImhXtQ0Ty8KEMOPBXAcvQsxGm3+zxqAt3Zev3l6filBIRFSNabAK4aSK0?=
 =?us-ascii?Q?EdeI+XOtgQGDFYWQ9vJIyBbgchMDDjTj1SKd58cM7dqhY9Oa77Ol18EoZVQ4?=
 =?us-ascii?Q?utMLDLe9On+shBBVWSW+bqlLIEXxr4eLCmWSNcagKs3ISpxM/EjIFMeCJ0oa?=
 =?us-ascii?Q?5oHf8AJvrYYoLXZTqG40bK9LQmlBQPP7ISigSTTB?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: c7954fed-b239-4390-4f6f-08dbcbdd06fa
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:10:36.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QoZ041nt2BNGGtdMwmSgvp2GgWg7zEa8B2HLKCxJhPAdsUm8jw78tDXG+/msgm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3646
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git@github.com:ZenithalHourlyRate/linux.git usbip-fix-wrong-platform-data
