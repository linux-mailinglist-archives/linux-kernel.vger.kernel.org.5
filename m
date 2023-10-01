Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47C7B46E1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjJAKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:33:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE818D8;
        Sun,  1 Oct 2023 03:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA/gxp5I7i5Hv+jkeiINoaWsYaJuhvm6/Mi5hXXAKi4YNG8ak0ct/u6wOZaRo1kSv504gSKPKWUyxeVGlqWOt4Vuq6proYjbGU2CWCU6VzR3WLqvLVD1+swZVto4KrCsj9/Gg7sMcvUYaJ4FZJyVoSbTsnW980Ggqpi877flaFovhogJ+JLsFSEGK3PFK1G4aDWDpeLksVTLkZdf0zdkl/7HNpXBOrI8d8FkDlcwrGWlV3+EJidPkZxSguFy5JLwe5Sqz0LufceZI2UhN+mvOKavNS19diFSJ8bR+VpwrPwyLTL5tCtQq3FvLSBXhNsuJOkTSn0dE0/k6gZqEZjBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ+lVYMOTZKaHpXKutt3xvCl7ioXOsZ+CB4SQmDczYg=;
 b=TfTVHnOCOdB7GtsuswN492PAaiyuxhBw/hO+Tc/6yQ/ol91x5e26fuljT952gTMkcDa3jW/woRfcUh6/8SMIaxHl2RMJYqwDZ+h3T/VgaFWbCBGjKux8/Wxs9vt23NTgA6nMVvO3maZiRRh5fmCZIpSU3q4f6zWkGgNhM/uowWPwXMYe2rLjI+7Znc2aZSds6MTW4orgONtS7ZC/2WOFV2/qblaTuPwuThsldGpvZ72J35EdOdfuwxY4ZSuE4tDoz6RuwJK4I6nUZRlcu8lPL/220W9P/NDt1e+2YqMDKXMz+LR9ZDK1Mf8r4IPTOmgpgcG0wDZymg1N1pa9vfPY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ+lVYMOTZKaHpXKutt3xvCl7ioXOsZ+CB4SQmDczYg=;
 b=qJj3IgY3Zewe8ytHkfrAP/tO9n8QoboVD9OM/X99iegMAjUDBOVKLcbwtCVaCpHcE7u8ScuKqQjpMXWHcCP/9dpwITOM15wWmacDJtQH3/Gr5RNIvi3/y9nZBi5Id+GoGjHSK3fy5dW4GqfsovZhzjSfzpm9Gf41NfxITM/SkM3ABelT/my83Lms/umT5BPeo44R6FnT1AzRbrRg5GZRsYpcZ+aUrS77Y7U9aBHT1An3d9wbTiG7/K+BG4yUdAdCbhgLoc+1VFZ69Gmsf9N581TlUyr9q+r40rZusDGxHQuTBhYrKWlXAwOqVWd2CzF7zyXmbIjrqcRkJw6iUrvdkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sun, 1 Oct
 2023 10:33:14 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6838.029; Sun, 1 Oct 2023
 10:33:14 +0000
Date:   Sun, 1 Oct 2023 13:33:09 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/5] mlxsw: core: Annotate struct mlxsw_env with
 __counted_by
Message-ID: <ZRlK5Rtt3PIa7wyr@shredder>
References: <20230929180611.work.870-kees@kernel.org>
 <20230929180746.3005922-2-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180746.3005922-2-keescook@chromium.org>
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e3b4a8-01ba-438b-1cd7-08dbc269d1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWilMDkRAHRQFQplqAcNetksNnzncW/33tqCXdTsAL9hHXxPntmJTieuqickAJAvOYHQ0Ua579SRixXpnZ9oCWdLEqAYuZDrDnC1XkAMC//SbAV4yiYEXNm9UIPMWPqoQ6UtvE6gR9x9sypw7IjFnLWy35TAzGisiFHTgd045IRv9baTyhaq7/nJ3GUVQ1lnniQvBm4Fz9URXGTk4BD5eoPnMGf1WCzcttUzh59x6PI5+o50pEYFP5X4/vzIQKJOyFN/iVLwEXIF5tINw+qUXSonp5DOk1aS/cxMGAgXGd8Y97Tgj/9fR8nvIXPwJVndE04u8GE2xLGkE2S8VK2XupcFbGWT3pFJIRKLErLmMDsWnFE3ohS6DQuf8hN3t3M6vikMxAp3Z2XhBdQq1KhjXqZKGMq0eqNnwcPLMu5ouO6gyYlkpcm2nsKyw2C/9cRsw8bbm52mFiKnyDSqH32gvAW2KZfEUim6rAw9lMsNsyyd/kviZx8IzwzwXWR5xLdlKg35QMPlDbnpQ/ZIvNir3zaOK8kQS9bNEyuXmTGmg9Pn0xZr8E0R+TvuzQfiKR1qkKsV93HEkIMHsD3DTV9Ucdjfs+xM6YwBzPY9VfHJCo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4744005)(66556008)(2906002)(66946007)(66476007)(6916009)(8936002)(316002)(4326008)(8676002)(41300700001)(54906003)(5660300002)(6486002)(966005)(478600001)(7416002)(6506007)(9686003)(6512007)(6666004)(26005)(33716001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtJSA/59FxB2ZGrho8pfnz/vauK3FMVWctjXjG9r3Tj/Wb59R+I8/V34GWW6?=
 =?us-ascii?Q?NT+7FWB3nVcIS1xrYdfBbnoZoAHKRVKW4FsmGAEIuXYFWISnkugjJHaYgIRw?=
 =?us-ascii?Q?mgzUpwG5RJN3Pmwm0YvxUFPeJWPp/OuRW79VvNbosJjQQ19nlAq1XmLtqc7S?=
 =?us-ascii?Q?jj6kZkTri/lPirOiCZjM9v63JhR2YxeatXWq4nLn7n+xspSgQPuaVyAJ8Ppw?=
 =?us-ascii?Q?j1bDtmi7ZQiBfYiOtDUSQnTgrtArmJ68yfnhL9/mi2nYkPWEP9V/ewdNRUNc?=
 =?us-ascii?Q?LkHMsjTcpky9mjvT0ciVW0GBjRWY0LvhmQN8fDtc3hc3+10R57E4oUg990Ro?=
 =?us-ascii?Q?01hizbumcn7b3UKdK9sC4WeDCzbYPN3askNF5nECLnO0ErpyOMN05zsr4iK0?=
 =?us-ascii?Q?SofFoBj4STr+LfJji0JqvBe6HIgZL7Bu/2QG42/iy0wdPMfszTHpnhIzKigf?=
 =?us-ascii?Q?B8iFt8TX/tqdHkLIp/ZOzGgp/0uhWGFyW0qjiMSIBZlNOUgdBozVNfcZzKw2?=
 =?us-ascii?Q?gB/UDPmuGqcT1kbNsc0irY6A5m0l++ZWqkGmN2V+weOwtfDt0LvOSz1h+gJu?=
 =?us-ascii?Q?7oqe+25fCB0WXvkFsawr3itoGZh/6V416Ii1chBDW9PhIcShma3ys47Z2V+7?=
 =?us-ascii?Q?+bJQnxet/IiBVCgwdwvw812fHYkep6b46XVP7gdVuixMLo++iXe5HYdHJeRE?=
 =?us-ascii?Q?c06lg+lnlOujgIILA0i8FqLtmPfxiC03RP1ucHu/3cGsPUN/k7hmJbBaLfhs?=
 =?us-ascii?Q?du8jlhdiz0NbpEnlsPQv8Vx9WrkYDMCDxkEHIcUmH/mvl8KSjpG3swsCVkTR?=
 =?us-ascii?Q?jHpDfKSFYtwnc2OxuLZLjckcNv4zoBvSR2R4fXarPPMa/izdeA6z2Bg4I287?=
 =?us-ascii?Q?Do/NW7HqgATV3JTNRINFsowTntflB1byjcedCY82wEaWPtK8mJ6wiiCkZVsP?=
 =?us-ascii?Q?UFetbLLMX+Q48VPCgPCWkGFtaxT9Wvu3QFVX4zIojr0w9hNKFan72wY6Dup6?=
 =?us-ascii?Q?hJKYvy+1ZWyDAE7HcKqFUZJWeCdg43m16CJX2u5Ptnuk2q/SUJGJg1AeI6Kf?=
 =?us-ascii?Q?+ogJNQjJX7HkxcP8MO1WwDCnvB1tN7k7qHCAulONhMcwsRZ4OibD4P4ORw7z?=
 =?us-ascii?Q?qtxQYTYUS7lWPGKY5RShrb17GSn898y+I7adGUKezACYySXflvkN9t1jjCdG?=
 =?us-ascii?Q?uQ0hWiA0YMOdYHdiGdRGbEjb0b1rVs4bcUX/TsBiR7Yq0Cvdhu0zn1ptV2G0?=
 =?us-ascii?Q?NwSY1k1BG8nC0DOz98L+++WogrHqe7RYbZEOGPi2U1Q4/BSCFShyC6WK46Z7?=
 =?us-ascii?Q?198QRBM6ePcZHByDMgX0vxNK13xho3rIUh0x5KzuM04vWTIP2etRaFGkmpyg?=
 =?us-ascii?Q?XfaPL6IIiDAaBwpGcUEdC1WnSLUrk146cDVBtGJqxMdJJh+fLw1PWWgFr5tL?=
 =?us-ascii?Q?rwvIzhYmwSInSAxMkvQrg/ZQUMid9O6qYrxQYkman1An6+DgmUVXpo5flJYt?=
 =?us-ascii?Q?R2qcsJk26/kcINmdz70Tz2OTv6o1upDnYriEmdTH4GPJlIOyY6DbgVdkolYW?=
 =?us-ascii?Q?nvj3FC2DozkddXSNME0ru1nWKvVw+NRp/GeT6lOI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e3b4a8-01ba-438b-1cd7-08dbc269d1a0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:33:14.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f62ed+QOib0kckEQ8N0k076ndxlzLtU0ZYFiiWOI19EybbARB5y2JwDS0l0+bkDUuW3BeqR/yEclPSsTjLOaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:07:41AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlxsw_env.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
