Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999FF7C8432
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJMLQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjJMLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:16:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6AB7;
        Fri, 13 Oct 2023 04:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=df9lk9Jn+c8tYH9+ZmZ8RAbh8mLpBswta/zbRHjjWCPTjRxkZxEk+Ac3Iu94pE86PJ6wJEgdjCCjbZXR24ZAmhPiODchE9YHV9R2nfnpzY0JRx42373tV9qGS2EBQK/aQZROoBcQAXcWrdUQinBd40Vk8Qc80wj3cXPGK30a+1ATuV30ZRelVwH2t43jWPtP5J6wANyjCU82QAtx+QvbSYODa9MGdugxfh4dxqSUkqdPbnJ7t9e9FFXN8qSIjBS/HyfLQnUcP3S9z4UenrBRK6j+Yd6cwPcvas7dF5k652xhi944CpxwEcS313SmEjDO9gnmH0UFcPC6W9C3Uff+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arS/C8gwWC7XkAVvV1qTw+c1Co2CPvmWsmFoOl45BAg=;
 b=Zs0wSZKi9BHDbZEkEcKRrbH/BjTCnEM6kAtHFIaTQq5WVoXHyzzJ7HTM0+RXKhGE4pVMrZqa7YCRgsZa3eiAiRxqiPnUMWWczNOW/RkKOKnP8WPQKLxRrBQDQMhVwLUw/rUPGBx6uH9X7T1Q1tbPSPeDC2M589uX3r4ltp1hRlI2P0ZsA59eGoCCDCCsK4xnz77SAaJRHqJOuEcVty9r4Ll0tVFBDt6PEfnK4T2aLbGsjQXj0LfvYrGmgGW7Nht3D0XBHIO/EuK81Gqm/7/0DgG21MQB02gntB58eRuV0PeeBYJxS6oi7KKQB3qa3tuiBj49GCkCRZfZuyyWCTlOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arS/C8gwWC7XkAVvV1qTw+c1Co2CPvmWsmFoOl45BAg=;
 b=sMcNaAtXMdkiepbLXw/kv4lfMGzTYLK//G91cqNvj7uDQrxZw7HUKksqphpQcA2jAclU6FAYSsumaCYV812B1DCk3oCDEkKNog5CtxbkUpwVGZEgs7e48LAkQErcD84kkjSZI/H9qi+AvdF3Q2ALWoQRAO4QmgKppsn1SzXsEzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TYCP286MB2351.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:18e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.29; Fri, 13 Oct 2023 11:16:42 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 11:16:42 +0000
Date:   Fri, 13 Oct 2023 19:16:37 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-usb@vger.kernel.org,
        sfr@canb.auug.org.au, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Subject: Re: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
Message-ID: <ZSknFd3ywz6e+wNg@Sun>
References: <0000000000007634c1060793197c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007634c1060793197c@google.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TYCP286MB2351:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d79e31f-9c9f-4a87-0752-08dbcbdde0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpx17i3mTlgpw3iSfEAjhaTflgM83aP7H8dS3fDGz15mM+gHizOBEG6Y/v64rJEoJqseCRcfIwfEoP318hD5ieP7LxkHZy3BaUHKWmEuDNqzSrgmCqwMZKBv4NTZ3fpMGuF+Gwit97VInNnhOFYocbRkFL3z8bCTR2d7DXw38aZaUDVEIUhpEqclabeifxUS/imvTMq3nTDfGwfUI9KQ+TjtJTbigI3UvJaMpd1YcfCfwiTuRrQ2i9jb9l3/dRPNi3aby4KXZECYywiysPQwcpALMzbMNzEy6nsu3rm4px3P1Y29PImjKnvg0ulznwFqDimkmtXRGTtH7ItEm9piTS58JoT/nZB8Zit/PnJfLD0QM2epCucdWM1LM1fa1hPG86m6nFTggeQJf6ysuRph370031xAxcac6fI9BC6Gn8/1jDLMEEVSqCdp81C3dsu9M76+qgOWb/b24Nx1TTg6SNnDuJGAO6e1HfVejaDjgmDoKGo7tZnCkBRorGn2Qf2JO3pU20UUdqOwzV7jLA9JQ/E5LP8K7CprjqZhBKXdyW5DYyXuHUTurgpgWQAoT2Vq5BAO7cJJNEudj2Kw6pjyv4KZ79E13EN+nMksAVySfrShIcMl3k7+VZOB6y/xQHJj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39830400003)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(966005)(6486002)(6666004)(38100700002)(316002)(786003)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(6506007)(478600001)(9686003)(6512007)(5660300002)(2906002)(41320700001)(86362001)(558084003)(33716001)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eY+w0mYIN2m6aBLWgoelvjJB05/X7CML/U2DXMjtE3tWukskD5DTFLzkLydM?=
 =?us-ascii?Q?5ZYEi0t7Q1/QxIWb1F0H/V6NBdHNkzL6EK0E5FlsNZd/Kfrun+4sMvL8C66x?=
 =?us-ascii?Q?VIg8ZasD7RTAZfA5xzymlazH51XMd/ajq0TCM2LQVrETGY/78Ed9YGnmAxxg?=
 =?us-ascii?Q?j2HV/N/KLJdepT+tMJ2SoDwlPIYjubF2gs/GKYxtwHZXFgP/Ji1YR7vj3l/e?=
 =?us-ascii?Q?b0ecmDT6u6YNBDsbwNolBz6fq0ydmgiWHCC1q3EE6uotlg5+cif/+1U0cmqU?=
 =?us-ascii?Q?kDwwcuir9d7Dv6vTV9qFpucMTRK3HglvyIQ5yNyXtAXYK31hY4QP9S72GhDN?=
 =?us-ascii?Q?2Inmd2mr/ho1B0+8HuwOFqRIAIz3YVqMHsklmbpU6T+FwuyMh2GphsVdIkEf?=
 =?us-ascii?Q?ZdvW9ijhHu68X3zpxflaH009DXsawVquC9SGjYKET28VyyXLREes4DznqK1D?=
 =?us-ascii?Q?0p0zuk3ARzukyjDLBLN5TiqLC7LPpqVFQ4UHgKAshmkbhMiUYAJQd45oVzxL?=
 =?us-ascii?Q?l+7fKZKq+5IoGA+8OLxsWJ0fFhQ2rcZ4KyiHIIdGAoGMCrz9cgBHJerMN/Tk?=
 =?us-ascii?Q?q3+wMHooXZNErDoePjSLMLzmwlz3PZx1IC0EWI5pDq1Sy/jyBLOgdYa9gLmS?=
 =?us-ascii?Q?HtVm8Ai/554k/S1bomtscrGxinL0BrEJvyBvi6Pp2SZBC4GCaWKmJ9fSsHhJ?=
 =?us-ascii?Q?01bXYepRe/51oJ2yZu35BIOads/mj0dKIzT78GZfb9RtgbT8J1fL8g1bm2nx?=
 =?us-ascii?Q?DYU/uYkM5YuWTjyuNXAyu4vxddNfhtVSCmDf+dmKPhHme9GhBAszVetO6duy?=
 =?us-ascii?Q?dHfWmKkcTar52buaRrqIW5BNXdQjq+Jpd1r9ZY6oH5ucCjAxyF2Y+/ppoZa2?=
 =?us-ascii?Q?P+IEaSCKDd4wjqYPdNCR8zNPdfr7hBA2sbPOHgfF+o6T0s9Msq6xrTV/yhJX?=
 =?us-ascii?Q?4SaXRlR0drZ5kiLbQT1FFufL/wuEfIFuU9s2ghPqwnN8kt4F/El1kxcM693y?=
 =?us-ascii?Q?C6vmADVwfGNNgh91P/9qYOkfiKT2w2AIocIWPIcJNwQ3c6uj3SJwYmthWf+n?=
 =?us-ascii?Q?NF1xOZMH7XpZb4cvWIgHWGnIiVezutc1G0+FlLItQJooLjXViBQIKSJe+DuS?=
 =?us-ascii?Q?8XpCXzbvjA8OPx8Fd3gwwMpaGu6Pq1nemWroG26X5L52qSNuQxDqz8hZ2ZAn?=
 =?us-ascii?Q?teaYQVDrhkgSaEd4FyJDNXTT66SFd99eypbq/bRZjqAbSOR3WyxQ9DKCPIkV?=
 =?us-ascii?Q?VkRjndTE1syLheiZjXobfw1YPU9AFdx9Gh3l/r7KWcgSDf6X5xaoUKrzYqbx?=
 =?us-ascii?Q?k/4QIbUwo7yvVCZWsN+1Dkz83N95k0vJxlRBhFTkofRDJNtmU8uVvPAVbmeX?=
 =?us-ascii?Q?m8FZUzxgvpI16cFMENFGoAb1ilZctXFfxjnl6PYPV6adjtWjkumP9M6X5nZy?=
 =?us-ascii?Q?GJp2QiYbyBKKBI2EoA54veOzV4i0Nvm5HZb/fKhMzuuJgKlyRO68wkMggSVc?=
 =?us-ascii?Q?ekUfYxFZ3T6u4ZxP1zZwtnpiJAAbYfVOyiikljZ4pj+bMhcTIpg8+Wt9WdoC?=
 =?us-ascii?Q?GaaiWSzPh0DiRFYdclbVmLD2pc5N4DagmrjbpyJz?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d79e31f-9c9f-4a87-0752-08dbcbdde0f2
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:16:42.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asx144FrzcL8mEEwwDkml2Ucrrs/yGjJ4lfUOdg+d5+zr+cILNCstAHjxjt2frx8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2351
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/ZenithalHourlyRate/linux.git usbip-fix-wrong-platform-data
