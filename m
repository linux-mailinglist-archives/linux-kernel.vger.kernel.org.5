Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC008760C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGYHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGYHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:44:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F7B6;
        Tue, 25 Jul 2023 00:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiFkjnW6NXaQjxfIAiO9sr7SDk7wggSpI8ulkVNTFqanukAWyPoqVWHFDToEhwJm5se5qSejANnDDq25oDzdfS11qJP3Yv4p7riGUVwFpKXgDSUpNhIR3EuKfcdvE+Zj9RqUOhQ+wkP17Db2meTaVMXCuRqLJzyiKY6AY4oFTAw4UnpGrCc+QuvGrrf5i3slK09c/7yDCc7Nfjtwq2YkBmz7onLkkHgQWUkoOYtq1+ty22jbZrbHzffSe/Qd0iz7ymDrWO5NRwfOgucJdh6BGDq9KEBXpMX6DAhjOSCLYGb8iZlaC/CAhGi8sh9N3svsUQJ9B9NwpMl9pLLdRPaQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mhI1Qn/PMDQ7SjA4VyqYuSmtU35r49STxz7Ok1nfj4=;
 b=WqVSnmOunNIwVwlq2gPkTGhsqw524gORAZEU3+UyrZuR6BAW1/mBO54+Jq3ZbNSmz9a9vWqRV5TsG3Bt/b8oADHNfftcc5uODQ5cEjnnPwVv9xxGd67S4WJnYlPFhJ9yx/IDvbkTaMQTqYPTZJvvKqqjw1/ukLHYeOdApdKFXekfKatnwwCalcih3xRM+HFgnxZ2nJHj+A26Mg0n6/fzkcY8LM7RPd7w8mILIDvAR9XppBVMSiSpdL8DrT0ngBXmEnNN94Os2/FYzAz3+UU27Ja1Dgzv6TvH/MrWpa03Bs5E2lZ0I4uR5sUwTwBkfmAbabzgNTDpR0Y0vGRtEJQ9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mhI1Qn/PMDQ7SjA4VyqYuSmtU35r49STxz7Ok1nfj4=;
 b=qT2lQF1sFSoAe7AI66vzNR4ytRksZD373Z2s+f0dzLSZfC/FHCKhbc/oBooGqcGff9JhgYyZdfH5g8L0Y/gV2LfLLWR6P03s6zYnsBcvbk7lFE3ajRW2aZecQUOmlv9KN55odaLKiCPY7waF6iFOyXqVFij0OZNpm3/ozUxjMkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4834.namprd13.prod.outlook.com (2603:10b6:a03:36b::10)
 by BY5PR13MB3843.namprd13.prod.outlook.com (2603:10b6:a03:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:44:34 +0000
Received: from BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1]) by BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:44:34 +0000
Date:   Tue, 25 Jul 2023 09:44:25 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [EXTERNAL] Re: [PATCH v11 03/10] net: ti: icssg-prueth: Add
 Firmware config and classification APIs.
Message-ID: <ZL99WfF7iuzeMP78@corigine.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
 <20230724112934.2637802-4-danishanwar@ti.com>
 <ZL94/L1RMlU5TiAb@corigine.com>
 <b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com>
X-ClientProxiedBy: AS4P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::24) To BY3PR13MB4834.namprd13.prod.outlook.com
 (2603:10b6:a03:36b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4834:EE_|BY5PR13MB3843:EE_
X-MS-Office365-Filtering-Correlation-Id: 4149bf13-8c6a-403a-e4bc-08db8ce2fd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QOAcrAfFOq9gHnRJy2NpFm8UcZsT6vY6jyICMnrfcXomHxoTDtfbjzwJE+dDnqawz0+2NBdiTfC+OE9L1W1e2N20OfEzt09a66qL6UysUHHkpKkplV/1ub90rXfh7t2//18LdybfPGKpScj9a1Rdio48mLFnm3whFLxekRghxlrAI0m7F9r3v4/u8wRKz24ebbubyZTmPMF483rhvu+D2YkHDCVqd85jcdesb5a7bcnj+yjY5xjZvQd/cKNu9bM0MfFXl8i/a5AINHLCf5oStg2xEzmLeC2/w8oOW0BsskbYr2HYh1DSu3G6dnaX99qrQbU2HtlAmPySG47jYdelG+k6OnPgzgymZYWMnGWvAGkDa0Whgdp+PWWIl2SYwmIKNF/9klKNBhObr+SNM2VVBw+U3tk6y9MI/qgTw0iUVGuiJuKO7AKGOI/lrCg0GKYmw1ieytTHJ6FbF7F20lSyZD7irzLwGvgI8dZM/oWUNE1O9ao/5xY2YmJnX+rzVAln+j7yG02Bw0RT6jBKMNXNSI85xg92nvSPgV7/6q6kbzgCXPhpKQaoaXCPMtKVgNoVtrkDmcY0sieLX4hSFlLqEMYhUtwSvn14QG76qjiYOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4834.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39830400003)(136003)(376002)(346002)(451199021)(54906003)(6512007)(53546011)(6506007)(478600001)(36756003)(38100700002)(83380400001)(2616005)(6666004)(6486002)(86362001)(41300700001)(66476007)(66946007)(66556008)(6916009)(4326008)(186003)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mw9eqSHXtY3QJybpgmghZ+FGYRL6hsYO0XGo3LAL2hyb6FFIl+SnrjAgENf?=
 =?us-ascii?Q?Pg6q1lkvwnej1Vr2qrBfhUhNUrv+pW7oXLLlnLSkcVGcM1kVtgNQ/JYAFCpx?=
 =?us-ascii?Q?tvesOkgIzxq88VwgSodUh8XFbLxj/N/ngXRZPexR37kgtWe0Fx2G9hEPCegf?=
 =?us-ascii?Q?fu/qHl7PbnpvsdyJLFsK/hhYvACYgmoiOU+VbDy7fq4AuaWmtR5gXtOoOOGW?=
 =?us-ascii?Q?oknOnoTmyyTiw33hEeYPMh3UpuCS0btCdPOS6TQJ7Uho76zLpm7HitHa7zl/?=
 =?us-ascii?Q?uABhoEIXqQe3STrVHuaLGi5rwj1iyxogE08VGYdeuqnoHIy2sZfcC9FGqhJo?=
 =?us-ascii?Q?6QZOEBHcYUG85fBbDgt+1zlgQTfBS2l/T1ed2Nq1qYwAMTe9dhOG4Jvyc64P?=
 =?us-ascii?Q?QBUwaLFBxBSlfGg8zffh0Q0eKDBfYCH24j2PmWl9u/+u2Aolrwe5TCO9Uzoo?=
 =?us-ascii?Q?LTnXaQMSyOwYb7KrPyBMl3lLF/sb5GdIDFAfra7mWpeSIB3cpRPoI+Ud5J5a?=
 =?us-ascii?Q?cAtUggvPDQC1us7/rxsjBv0TRR+XCMp2sDv1Okb/nX/Uh0o4jX+BE7DdaH9F?=
 =?us-ascii?Q?Ob9oThKsK7KEYgtibD/UVtvPNX4f0r/Q/D93XRAT+esFK4f5s2f2VFMARWuW?=
 =?us-ascii?Q?K0lLi+MdDg+Tbq07s7GA/yMBd3eR2fioFKX9C4XNeEGgtIQ4+06KhDa516aM?=
 =?us-ascii?Q?AGSced+WP03P+xsjSXLYdrIh/SPFLeT57XiUQXUZkGMat9/W7BtCQ8Lfiz7n?=
 =?us-ascii?Q?u4X6x01lfQRuPgfCPzdy3e62yDJr0XrvA6T/ld2R0kko5VHNccsyzeJhpIUp?=
 =?us-ascii?Q?yqjzGJ83FfsyIBJ3ZD4DJ/N2V6T01oJh1FSyoKcFVf6vajxOuTsmqWxZFJG+?=
 =?us-ascii?Q?b2pEtW7yUvx1Xm21TnJDHadjPpbLeDqWOqfPJrVX02IzCNIOgg3VeH6dBahx?=
 =?us-ascii?Q?0Kvzwx57VW6m70tZGLLchrXeCVRqYTuEEDDuYUI9vWBBs6g5moevLOqLWADM?=
 =?us-ascii?Q?Ps7RRK0Ylm2ze7R+Y2gHJCwKznXlaRWd2JZrkQmhNmjAux/KGqP06UaMKUoK?=
 =?us-ascii?Q?bE3ScNY96CSyzMcZlgcRFklvGXM20O63CGFH4GFkUfnrjWD3VGFKSZlhptX7?=
 =?us-ascii?Q?0YeeFTOTuzp29IG2iZkvBR+VLo/bl/Nz3vJOTOBcddgM5iIoJg/M0pvQ93+C?=
 =?us-ascii?Q?9amotxT7ofWBxv8fGLGBgt7RLet5M7pro9TLl4NyrDXc8jM1auCltMnctycq?=
 =?us-ascii?Q?n/UKx6vGIWVlvz9sPG7ycPijVxSgToEsEeQP1qcPEDZc3U2B8DftAshlOwsO?=
 =?us-ascii?Q?bRx823y77cSJnjUKbKhmfrMiS/3ZACbzq4t9nfOGSgXXKZBV3d5fSU4Z92pe?=
 =?us-ascii?Q?7Y3ChiOXpu1lGFhCPFu27iTdpSSA/GHYvgLeLQmZOX8pN7HixLfutHT3zDwX?=
 =?us-ascii?Q?GyS34EoP5Wk+DSvpj2G186B9teiFFC00XOYJPOuKDB9r+JysP1BuhD3per6m?=
 =?us-ascii?Q?BR8xp6kfZ+Sz/Kd6aagnZ/2vSm+F7mELGGlfcJ4P5nlX9TP5EgsNNC1HxEZ/?=
 =?us-ascii?Q?CP0gVrsIzsLmuVJG2FXmn7uII2SVg6JyFSxcReqFHGITnyZGjI6mdRauEcQv?=
 =?us-ascii?Q?4Z5+CchCgzblCoYC74uAuAYRXcgcN4GRYTvBlqawV0jE7pX65Qg0o8hh4I8m?=
 =?us-ascii?Q?QdQPkQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4149bf13-8c6a-403a-e4bc-08db8ce2fd46
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4834.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:44:34.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7amhPFhVALn4BjnSqvfxFV2O/Cxpx3rsrDlfJ4mueoLCJzDNq5CFizjRjhyRQiN621buHkPbAsU7eGt6pTjiUewi3F6DCb7dKLTDTMO6f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:10:30PM +0530, Md Danish Anwar wrote:
> Hi Simon,
> 
> On 25/07/23 12:55 pm, Simon Horman wrote:
> > On Mon, Jul 24, 2023 at 04:59:27PM +0530, MD Danish Anwar wrote:
> >> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
> >> configuration and classification related files. These will be used by
> >> ICSSG ethernet driver.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Hi Danish,
> > 
> > some feedback from my side.
> > 
> 
> Thanks for the feedback.
> 
> > ...
> > 
> >> diff --git a/drivers/net/ethernet/ti/icssg_classifier.c b/drivers/net/ethernet/ti/icssg_classifier.c
> > 
> > ...
> > 
> >> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
> > 
> > This function appears to be unused.
> > Perhaps it would be better placed in a later patch?
> > 
> > Or perhaps not, if it makes it hard to split up the patches nicely.
> > In which case, perhaps the __maybe_unused annotation could be added,
> > temporarily.
> > 
> 
> Due to splitting the patch into 8-9 patches, I had to introduce these helper
> APIs earlier. All these APIs are helper APIs, they will be used in patch 6
> (Introduce ICSSG Prueth driver).
> 
> I had this concern that some APIs which will be used later but introduced
> earlier can create some warnings, before splitting the patches.
> 
> I had raised this concern in [1] and asked Jakub if it would be OK to introduce
> these APIs earlier. Jakub said it would be fine [2], so I went ahead with this
> approach.
> 
> It will make very hard to break patches if these APIs are introduced and used
> in same patch.

Thanks, I understand.

In that case my suggestion is to, temporarily, add __maybe_unused,
which will allow static analysis tools to work more cleanly over the
series. It is just a suggestion, not a hard requirement.

Probably something along those lines applies to all the
review I provided in my previous email. Please use your discretion here.
