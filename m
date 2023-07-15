Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88243754850
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGOKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:55:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2116.outbound.protection.outlook.com [40.107.243.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E99435B7;
        Sat, 15 Jul 2023 03:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5xX3pAx/5RhPP1ZfTh18J1tIGplrkZTfk3NF3WAKxbT+gL25NV0672/dfxTdxXU25OU7wwi0+BDti+K2/MYskVglE1P/JtbyfbIwq+LaotVIVLgtCrvCJMBj/i1vuM91hmqD+ln0CXd42GS4KMF/XVfxJsC6faBj/uMU5p2tMoXukVK2bBhCQe62jgX+aPzqNM6NODiVgDHsVwwtAsOLOWvs6d6+UqqKCKGYg0Zp3AbrZIeC5w1KSY7FI1syRwIP097acdIEq4PBJjEQL+xk9Qm9vGFXpiqW43L/4hsRozW6xy3mbiwAgVE8/a6HrSMT6IFPjHD6dchqpxK7Rryqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuaxMiQ5f2RFmvUf0BkEsBx+X7QRrhoX6n7x1RHbqWo=;
 b=S1REV2RMr6+WvIj1Eelkt9U+1KnvY0QBRjCCpK3Q8M6Re19aiUPCP4ZpzGJ0TB4oRjpQLqOvn4yVnZ+CIEcA+sbwaL1T3ivfAa2ULkzDdsDE92uj34oFwVbhYhWEqc5QkwJtXVoiTxuBj5mN5HolB9yc1smOI2aOo+2X+BpV2xVFVpw1ZsIaJNcdpXzl6n1iCUMn6vWfD8pXD1iEfMnuhitdNZDXSuZ29Zso9unpr7huYRU9iAv1NGrvQ1a5xku6UeyPuiJVVGilCKjvfZvnwRdxPbPq8HNO/M2Siw0NWdfXj5C2dxVW9fNg0zC9LVmkgsMrW8hiGJXb+b34H9KdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuaxMiQ5f2RFmvUf0BkEsBx+X7QRrhoX6n7x1RHbqWo=;
 b=BjvLns76/4cbjhP5hoMI+kEzunU1x65edUpBGid8BcCzoGYlr9rt/1mEI7t806ght+KA/6WhoIf5aqIfOa+n/VD/1B+x0mSQDswyBBX0slk9Q+Lum6zWG4GE7roT9MXo4bMe11B1tm+Xmdoedd6CnR5gldj7cQQHi5roOuLNFMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4681.namprd13.prod.outlook.com (2603:10b6:610:df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 10:55:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:55:02 +0000
Date:   Sat, 15 Jul 2023 11:54:53 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Tristram.Ha@microchip.com
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 net] net: dsa: microchip: correct KSZ8795 static MAC
 table access
Message-ID: <ZLJ6/ZkKk00AFPqi@corigine.com>
References: <1689295582-2726-1-git-send-email-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689295582-2726-1-git-send-email-Tristram.Ha@microchip.com>
X-ClientProxiedBy: LO4P123CA0156.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b48ace-cdae-459e-6a64-08db8521f09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVtyzJiuGWtTgPcC/9JI9tTV6DB3Ay9LYNfjK9ApSAe4hLyFsFvQWRbV3RMggepl97Ke01/NSAhKgZ5BnvafqJPbfaXnaL6AB4b2v7txIehvZmRgAUGKfd8yYToFIIpsQJA34EDvu3GjmzW05885Y44T2SHCMvMm/Ge5N/O2k0srQ+0pYBL5bnGPertZIoROoYOkFN9bX2vQpZJ6fvhpMQ6uVHp/nkJWTZzof7JtrNf0chuFw1t/aYgGXm7HQzB2+ywp/Dy3qI6wxjP+Pq+xOsKPwi2OtBMcBxGVfjPiZJf0GnGdGri2l2yVBQ1NILwl7Sn8emzoLjScgHpNIF2BlbLQMJRIlfMI+25MNpmMfAp6sy0+aeIyo1Hay6Wv6aTgmGmzE33tEMZIz2ln0kP59fprCF2elpcjK0Bz/vA6ETG8RWAZNFVEmB9ogmIlSjeeSkYb6oehCtSgSOJxLNOJwPhSk+CPkfzJILblhYPVBd6b30WT676qjWabafvOGrzkxeXXPczlvwlYJij6SW3pBieQMWmWWFPkUDyjn46bgfcNyWAv6s0NLvov7+6is9yBJxi9T4pyaizl0ubSksNesOH02uGhTth/UGL7rEWaGsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(136003)(366004)(396003)(451199021)(8676002)(5660300002)(8936002)(316002)(41300700001)(6916009)(4326008)(54906003)(44832011)(4744005)(2906002)(478600001)(6666004)(6486002)(6512007)(66946007)(26005)(6506007)(186003)(7416002)(66556008)(66476007)(83380400001)(2616005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rCPsilAZLokz9b0kUaThqwHcGoE5+BYNV5dBqGhyUesdGg5b5z1nrSAUgwaJ?=
 =?us-ascii?Q?w73OPkV4/TI8YlzPFHf5upbOxrAU9pTe38tvzLsUUktzMJBk0sRsH9SzabJN?=
 =?us-ascii?Q?lAJk6BzL1khfG5jAJrnMohLDkvjioX4zocnQudkXlVvWlWhpc5OpzuB8g3xj?=
 =?us-ascii?Q?FEsyGFHP6nIYH70zcMK2OAo4eb/ffx5YzjwkeCS/2QXSunggnoDRU3EVhIqN?=
 =?us-ascii?Q?uAN3GKVcDKLg8PixglhsuyQ+DPf3wgJ+JlAVIuXHZU2arlZ91j7d1ZDXRP47?=
 =?us-ascii?Q?417VnPV1mvoFN2CDyYTlRqfT50Y1w5ph+TE3eZ4N8ApSe0RVXa79KgzIQSPq?=
 =?us-ascii?Q?WuazF6Pq9+lzGFIIUNECD5z2AjFd/LAkt0U1HLcBkmt4UDhflJmH8kZQjGNE?=
 =?us-ascii?Q?p/P8LBNLJNonkuWhgjo5vfdJ0kQcYk6Li6gsSdNJ67Jep6QaeEBttayxvTwi?=
 =?us-ascii?Q?vnDMUeCJ1jGe1WfHHcWbIR+Phw4w5wYaSP5nZzsuhl6Iv21ytxhvlW2b/Otc?=
 =?us-ascii?Q?jdtn6fuppUj97mJgFNGyYjDGnA/f4d6SasyxD9fRVar2rYhuwSDNvxSQ+v26?=
 =?us-ascii?Q?x6lRO1sfnbqXCH9PO8+pPDA8CTOOulGt/Knu6NEepnoOdZBHU5T+zy/x0g3o?=
 =?us-ascii?Q?S40T9bGDWuqrcA8gfKpxu16NwQWmsTOatRyDfJ0PY6IBlMGyDkk35X9zwS9Y?=
 =?us-ascii?Q?KrzUcj0SBC+MgwxH208++l5MnZ5paM2zAu4SvdhBXwjb++mO5jJKvlEY7/0u?=
 =?us-ascii?Q?TEl1txDJhkA8Z92zrfdss+7N94s17oIKv+cMaLfhaz0jqPNGSZXegz26KBXQ?=
 =?us-ascii?Q?mlOM36eeQPAMUOzXun156ILhUghtudDYMyA0AnumbE2un5203jXjDNdxLDsp?=
 =?us-ascii?Q?QDQ281uqfX/KMvGJB8s1C53cBoomOSBDG+1JAyUy6eXvV+3juIppAkf9rmjk?=
 =?us-ascii?Q?iIsP4gexZsAL6eDGexzPU+vOytUUKurtILbhUveBh4qUkDhk78meqCuRJEw3?=
 =?us-ascii?Q?DH19qjUf3RLS+wI6PIGtopOI7MmNqDPEmyVU/4Is1m8sEndy86EQZpCg8rYA?=
 =?us-ascii?Q?yz5UFHqeQvxgDALgsaN3eFruNfwZ7TRqCWDOBTY0p5LNiT1Atvg97mebwRhT?=
 =?us-ascii?Q?d5Qr/yyeXxauhSIN9UPhpUAg54aQJ5yIsQsiNk35bgRXtPpJE9UQV2uJ2K1e?=
 =?us-ascii?Q?HQc2Vy6BSmeo0XlC/1F9xtUX1yT78a805vOFtJfMm3GyALnhaSJbla3xpRkO?=
 =?us-ascii?Q?udzSVPxAIri7sh5GVtD0Aarkk/4x+XWDyYAqXeerfcKU/T0IcR9+dXy1uXIa?=
 =?us-ascii?Q?bUCJqYg+ge5hSIdniA4GzeDDHHSEGMg/u/FiZTYrKrjaYGj9NKlAJDFEWIzu?=
 =?us-ascii?Q?dfhJYxwnLx1E3TmmL0HKV8IxNZPeD9hyg1X/uzHE4z4JO35Wn6KspS13NAxI?=
 =?us-ascii?Q?aw5MAy8XMzU1wTRW92MUJOB/moF2XXRlNwJQAXdGrJvSgiW6i0WwQ2eZU3Eb?=
 =?us-ascii?Q?cN07Aizxbeqfb51vy5NpHKMuXG4o8MlJs28/AEdvIYdOCpWJdKSBWONd/scc?=
 =?us-ascii?Q?JieG8RwDNzlrMKVIEdm+gjXTMsj2LTmRQK6On17yg3b67zj1MHOp45w7R/aB?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b48ace-cdae-459e-6a64-08db8521f09d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:55:02.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXYnDC9p+f5RWHTQjAAQmpTVH2CQw11LeTVs4Fw2c65YOGe/wrNQOxEdNsd8dGR81MKDXrgSr9D48ZiZx/1IkQkpsoPTHSfgBIpUZd2FJSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4681
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:46:22PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> The KSZ8795 driver code was modified to use on KSZ8863/73, which has
> different register definitions.  Some of the new KSZ8795 register
> information are wrong compared to previous code.
> 
> KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
> and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
> than writing.  To compensate that a special code was added to shift the
> register value by 1 before applying those bits.  This is wrong when the
> code is running on KSZ8863, so this special code is only executed when
> KSZ8795 is detected.
> 
> Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")
> Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

