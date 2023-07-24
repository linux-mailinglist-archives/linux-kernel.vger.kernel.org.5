Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8475F572
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGXLud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGXLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:50:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D6E5C;
        Mon, 24 Jul 2023 04:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur7RWLCXo2LvZqInbjMH7ELcKHqczWz6t7GuaCv6jg46doS0jpWXY7REkc/brwPFefoaNaQZGucgNogxbRsHv3AGEx4N8aSLXFMYlcgQFmV89beSUf81nJR6rVNINSVukwnCyu+weCALpUga4DK+aFJ46EzvPktdtH6/ENKU2xUxMJuYgVVU29qtcVCV+9QKltVZdy69ZjMCBlq7OBAWmRGnCVOHa+9UuS2HISDaxVE6zxFqjySnaS40KI+R4BgmApvI4UWbsBFuovO0t6K9V31bhkiqvZgwyqq7KJAb3/w29cn3UfhS/3ghhk4r0H70J0uM+8htOXUD/SzLzZBrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MKgXwRMqrxesCWt9U5g+oYsFnIxxtohbVc15krIDpo=;
 b=lsNQrN3Vb4y+hzjrkVJPq9Til0qkSI96jf7UqNrztgrHjkr4Cou55/OgdkubVtj7UzsrUDYHy0h72mMUuaTkbbfFoiwto46vUcR6xjuVKHHkL3eeM3W+ZrEYVAN5zo5eog9Ip8wDld/BsSj75PIKZ1RukpywIgt+SEYPp3wGNwZXYdyiwg8akJJdcqX4SOz0rtAfSUAgWpMak8osgFxh52sRmGy08S1Jefl+WEemLfOPoxBHheo4S/TRQ8YdLhqLkLsSqiBv8MAqiJxMKY4dz0uYDrVz1kLPgV847mSudqEFGlFet+HCy/r/cEao52HOp+DznghBVM1+633vQ8nVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MKgXwRMqrxesCWt9U5g+oYsFnIxxtohbVc15krIDpo=;
 b=LHoSl/0Sw7G1p/fyX42XJyvk24yRG41OvOYb3asMl5HnYn9olBqP2IpxuhB/sMxuLC3pZ+hAkTKfFIImRswBokF43IUaIJ9MziRndSugvIy0QfnpqUAlNxbMo87OKMOjM3AurcWVLS7XGfT0e/4LNj28iPfAZD65gY3GmGm+nXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6212.namprd13.prod.outlook.com (2603:10b6:806:2fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:50:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 11:50:24 +0000
Date:   Mon, 24 Jul 2023 13:50:16 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Tristram.Ha@microchip.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Message-ID: <ZL5leEd4uQXdmMXH@corigine.com>
References: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: ee94fb4f-9eb0-4337-58b0-08db8c3c2a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdTh94wBGFtG6N54cpLXp3ed4EeSuEdo1P/76FmsUsr8JK1Bl/o37vPn5nM2soqgvuQ7c2uH/1WVfcjNaExgQLqAZv2ml1EJ91OrflLjOmyvhIyTNhrw4emd09wjhtoJ7Vy7MkGgMIQ0hCfeSOYIyxFJhR1lJf8sONANp1hdnRtyS+XTA8slKII7Ciqq3GS9BMSCfa//H2NtZ4aCVkcmnx9YYvvGIc0idpOg1gWQI7V9CReTx5GDYZ3SBojvxGBRHAjZMTqzhtnJH98KwGOGF9DHOT5OaSIfC749EPOcfIb5qb0W//WZlf7JanhXT/Z06bJ/KrKgj/jDa6iG3xmbQMuSlcH0FLg4z957PWbKweLgijNC/+KoSe/p0fDOW7BejAcYTMuHdeF6W5aatCHhHSgoqXJIrXD8l9iHFrD46gXqHt2L/6VJrINxXoOgPrqtBemeVAR0bx0aEQDuT6JBNdYzQEl3xFHz64tu8Vfif436Na4FJI2X5zsTxHMYsy+3G39LRvkLo0bL4C/ggjgd6zYF9W0IuyveZbWEnAbCGxT0pKVywYyDavzl3TLRgot+tF4u7XX51krJ1QlmmcG39aYCpla3Blf9pD9rUZ7umCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39830400003)(366004)(451199021)(6486002)(6512007)(478600001)(54906003)(6666004)(86362001)(4744005)(44832011)(2906002)(2616005)(186003)(6506007)(38100700002)(36756003)(66946007)(66556008)(6916009)(4326008)(66476007)(316002)(41300700001)(8676002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlwIjkl23f215iKECaRHiSMwXS4WNyYBMwGmZEhvZTwn4r8PQo5EwXOfMp7M?=
 =?us-ascii?Q?BexpaLXrr7GiOZ+MfAtJqooYgL6zbhldhDeL6L98jrPQG1dJXNwkzw+p+0hr?=
 =?us-ascii?Q?9L+mrdQ8Y3D3xJc+qLhEnE6T833CQ9DBYVzcwotffAYzMD6Z+h6Ja/gc8DXW?=
 =?us-ascii?Q?7cMxa4j2PpVvlGjPBZCcShbRjhrB28Ghp7jWRDzEUbqOTHoTQnoxZ5WqAURO?=
 =?us-ascii?Q?Jo+Ff59Tvb8AWDaizX0AeHLBf4fKko9k4CnvD6ScZmK/bmqXY5WaQpRSFo4C?=
 =?us-ascii?Q?KKm+p8zbdD4SbCTcnQKqn9XYPqrvhE2hFG2vzH9vrBTS0dV9a4cm8f9kV26B?=
 =?us-ascii?Q?mWnjkJ4dx+3XRoYNV8AAM6lgKnTutXQBlJjNEJZjbawZISIzyrTEb3O7ALBr?=
 =?us-ascii?Q?pgEbW3k0ZFsFwfNk2bld2qrGt2puEaEQUMz33pP2mKONdoQ1RiD3/e4GT8e4?=
 =?us-ascii?Q?jmvDOKHXsyZPOcJOeA92G7cBu4kt9aNQbOHEgGL20X1U58+B2lVlxrd1YzBC?=
 =?us-ascii?Q?pBWz4P3VQk9yPB9WmWZ/bKiv6K5YDGfD/JeNd03V6uZfO9Lqjcncsm7QIte7?=
 =?us-ascii?Q?lc/f5bH3dHejutBi7RN5QIOxe/4GJ3FZ6cuYYBhmQ8LIU1BRfQ4BYwsCQX0v?=
 =?us-ascii?Q?bv7FP9u2hLqhvahRszbadnn4AimvgXPz6vbv9Dm0WSRckF8CGnTlJ/3Y+rqK?=
 =?us-ascii?Q?12F2tcS88y6jsSfzkrQWuVQShK7TA2i0Sy4ACwHY3h8+JtcVH8326wIgiIA7?=
 =?us-ascii?Q?e5f4ik/b2HJiXGDAR4+zgEllPRUxvNIp42+m9M0HpkQt8VyyznoNt3V9IA2F?=
 =?us-ascii?Q?f8DPnUA0JkvyWVex/ICtBzVAvsFQQHON8rN1VxN27sr2rRgVwmkhK5wnMJIq?=
 =?us-ascii?Q?+bQMiqeeM/9RM0lmYN4n9KbRvZ+vldWGAuf/CebDVQ7l0tvkcS/9C42NKXPM?=
 =?us-ascii?Q?RQvocmX5tF8gMg5Q1yzcLJJTjNoMuqP8U0EGXiWXpdNfFPf44ZPkHXpODSvg?=
 =?us-ascii?Q?VumHkLrv9LTqSFOPBqHtIWhMNOFiBbxfIikZ7Brep8tf4hF3gNUxSASXUUsD?=
 =?us-ascii?Q?j548eH3/WoxgSpP3i2s3CHdif5wofvIMqsiX2THh62JeL7OT+vnS1w06F1V6?=
 =?us-ascii?Q?2FyCbFCmg8yEb+Ywjr9s9G9LsmTsv24Llae//nHGP/DrXbbw9xrjZ8UQwWOb?=
 =?us-ascii?Q?9EGzIdm0Tt1EgDBVCegiAAbTBe07Cqr+0E8dy1Mvq5zat7MDqTGxwAlgs+qE?=
 =?us-ascii?Q?CkSyp7Zq6l4L5wJbj/fvWWlcMpTNkeyYA6+Y/+JbXeU2UVBwPCkKIRKKLvdo?=
 =?us-ascii?Q?+DCQFwkq6tr5Ry8+PZIzBAMN2LOKiSFi6FexSKnb7iYo8zytpQvLS/QzDOAk?=
 =?us-ascii?Q?jtztmOkZ9wwcCxDVJGIFcAYj4et4ZuSZwQVhnCnmbjTS4Ni7yKjD6E0IqlP/?=
 =?us-ascii?Q?0d/8Q6c0TVobWPx37Z6ywk2CC0lUUbUh6iIbdKDpMhWPmGHIlGMYUdU+9bXH?=
 =?us-ascii?Q?KDfP0fZz6A+h0EiYBlTFv4k5IhlXpokMvjWoFJqZpZbEPfN3+qZ7HcGPi20R?=
 =?us-ascii?Q?UdfHJNdhURuW0yYElW5ul+lyrbA35FtdqbgyH55HNWe//Nfu4NPb5dFhfxWy?=
 =?us-ascii?Q?1+aFBWq2LozKzYjYHjwLNBk2WzL2pzwDEGpOFeW4eW+hs4mhAdayhtz1lr6y?=
 =?us-ascii?Q?9eO+YA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee94fb4f-9eb0-4337-58b0-08db8c3c2a5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 11:50:24.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPuqbOg2XdXTFngspVLf1nHRmwoKq8832c5Vz3mlfR2KNq/Ep3bV1ooNKTOTIRFWrlSkwboElzZaVoLUzzknNeT+X0MRmWsxzwVO0NOr2iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 05:40:53PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
> of frame data, which can be used to implement ARP or multicast WoL.
> 
> ARP WoL matches any ARP frame with broadcast address.
> 
> Multicast WoL matches any multicast frame.
> 
> Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

