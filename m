Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3837D13ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377823AbjJTQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJTQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:25:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC8A3;
        Fri, 20 Oct 2023 09:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJuVSwq1VDZ2vBBHiaa0G+lDTxrxwZBpHtfmoiIf8lxoh/xGvTBm+IYQsJYCp6ZJUXiA5PNhUor10drQe/HG1YA7emDY41rNc2IHFzKdCS0AlXddaWYYeqduaB0MbXm3EPOwmQEgIATLUzif9LrX2FW8DiUJp+fXzqfKv34gb8w/g71SFhsCEuiGgnOI954nVrAjF4rP1KY25fk3VUvLQCSRbgEraV5fLTXSz9jtSe0kXCf2XeEaL2c1do/oPeIF9W4lcnNVh6fhrD734wLxldaev6QH+YNLrKFT70Uo1UGDodFmEpOxW2/Awqho21J9icBxuMJAF1XBJFhFkWgJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gONmHvC0lZVR8PTBRyupD47x4vcUl+PXv25XxfLsw5Y=;
 b=EtjNK5SIaV/LdvzO5grMamoDFQwBUGgxiA0dLsLMM3vArKkjOweXX/TETR7DlgbdLhN8DIZ07jnJ3ln2NOgHXsmBEzEBHlP0stki1L56ka2HkjZe5CIllbo0vB/NwUJ2izIT8J1Pcy+Uuy5EFiv2TH8RrsWppc4D9toVOD3yodQbUvxE26ykSeNi2sSJKj7mBixFoJ6H4Uz3Y9Dir9L27p50LHQLLc2tI5fKZwA3IqaUHKX6PEE/cIXBiv4VwyTMIxEDf/YPQXqbwiNXyYJBW4prRQGjJcsLNYyiosGZOvSsC3eMrmYiVmNlqL4v/jEb2HM8F4DpbLKO8y93VwEj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gONmHvC0lZVR8PTBRyupD47x4vcUl+PXv25XxfLsw5Y=;
 b=fadiafe73841+cjIVsbL5UdljcEg9TzE5NesWYcWvlnWJFKqlxCItKj20RkrfUe/PjQPOaLOiMEHZLD5DXEwZRrE3E84aqjCNwEE4KzUt3wnF9H7YL9WaNcOPgxzUfF+JW+W4lQnIAl5CQ5Zt9rMz2Y4c21OcAcw8E2RzD3z9Qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 16:24:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 16:24:54 +0000
Date:   Fri, 20 Oct 2023 12:24:47 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>,
        alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <ZTKpzwKIfekMx7X3@lizhi-Precision-Tower-5810>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
 <20231018205929.3435110-2-Frank.Li@nxp.com>
 <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
 <20231020154528.2f5f68f5@xps-13>
 <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
 <20231020163348.1752167d@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020163348.1752167d@xps-13>
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b028cac-c5a8-4848-d0b2-08dbd18917fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Npna2Zboo25Z9VbANEIbCOwXg9QUlhEFREfqwGnkTzQuOo3BsOkkNg4LeZB0DZfnfuqGTf5GH25od3GG21GDxbqwxqOEGmjJ2iBorrv5rKb5aSP/OuDwI+z+1fNc9bK7Zc0TnsNoFQI+86Wi/KafnB1t+CW6MDSK51vUc0rRubvEcuKj+R2sL6dygQaTg2E3LWTCWvkQdfATglAMp1QBCAYfjBnTHlPqLIJzapXl4oFSoM0Qv6z6kGANXXCniiV+6E3r/OAt4TyPWOGW26QQtXCS1gDBICn5pn6TW9vx1Pa8wUi0dySJouxJVczt96rWZekPwTKdOvp70jFK5n5efWUO3/ChH+cvbl8q5Uke/m4Xs2JkwoEgKOLUSayWyLHRwOPfAgS+RpMS4ZmMyqsSPpcjTbf1MAci8mv9UJo3rfFW4JQROSAGPZDsXxGXYGLtNzMsrL9M6GNmK7HlPIPDtltG9ml36WKlpTogJ791yUKrx5mkBPCTkwG7R3AZrfiPF3Eq+9VCZ/AlJaEtQkhOcTqk1+8hpyqVSiXyM2S9YH215bfwJ28p+zCM3HOHEcG/SoMLsCMhHYSFNwgfo5BSkggGQwQJEr3uYUgwcoDPfyGfoebrKtIc3BzkJ+5joUZ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(26005)(6506007)(6666004)(9686003)(52116002)(53546011)(66574015)(83380400001)(41300700001)(7416002)(5660300002)(4326008)(8676002)(2906002)(8936002)(33716001)(6486002)(478600001)(66946007)(316002)(110136005)(66556008)(66476007)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SOc5RoQzrbglBIgHZHvbO90yjStDSInc7NtJbYgUTwH3ZHZx0C4JCWPVCP?=
 =?iso-8859-1?Q?o4pDZXhIZ7FDaa2XdG6xlJ6xH2+p95dXzUKVND48KxT9HDUa8036G4ooOc?=
 =?iso-8859-1?Q?JGbjw8SH2h1y/V3UrMxk0n297NEbbBfSy22W68pAZYTGkr1P3gajTzQcm1?=
 =?iso-8859-1?Q?axCHaUPmeaT8ikCz6QxBRRvc9W04EilzVi1tIuK4EvQUYSHlwb3hWNuvew?=
 =?iso-8859-1?Q?nu7+Qs/11LXU+gJYKt8SRPmml45tTJvWWiQ1+SfUbV1qd9AZwR9rX16WZC?=
 =?iso-8859-1?Q?x7KAKr5gqx3vyYf0theDap1C0O664s+dpQaVI+7wVTtTKBBOsr8yDds3s9?=
 =?iso-8859-1?Q?mNboJNyQgxwm3I75al9QLxP0LR4xeiVyhcTa2swVvJDNQIRm9/3EcKa3d3?=
 =?iso-8859-1?Q?r23f1w1u3bnSAbsq+X1wTyqJ2SUodRfjMCRwKmA/fYfLZZYfw08YyG66Oe?=
 =?iso-8859-1?Q?NL8iIaiLSBjy1+MKpeL8XpDFMpipniN0rBhvX7gSW1BI7pTc1Q7uu06rIP?=
 =?iso-8859-1?Q?7PSGKOg5nKL9/dSImPB6eBwm+q62wcCFvYbahjYKRPChr8UhRb1ATA/cMF?=
 =?iso-8859-1?Q?dl8ohwljteI1M391GauENURUOslQO3kBV3cYY//SwoeAw9wxsws1DJwT13?=
 =?iso-8859-1?Q?tuWcHHHu9axfY90wR0UROaA253xJv4d4D4Z4nDTXmaQ/dRlh8rLejrLWwW?=
 =?iso-8859-1?Q?GYKSfWQuM3vPvO6cthDYvxoZIrMOiQ45qAP2O/VzcV7zOGU8k8LIqBG7AM?=
 =?iso-8859-1?Q?lD65BJerdPFKfFGSucsmiug268OacS8aGOw+A6i6HoryGEBdavocKO1udr?=
 =?iso-8859-1?Q?n7d23r4sA59a2P/Nz0aRk/qbdXX32hdO2RRxi3RLlu1s26ZXEz5T0MOh3p?=
 =?iso-8859-1?Q?uLr/l15Pj1EIwforn1j5xT1j7rFheK+Z4euGYQpIYzld2ZPWWoRHJrwOEh?=
 =?iso-8859-1?Q?zv8yC0bhmLRjegKg/iMMTttiqvWnCqJ1YBuGjP4PpCBkeBVbY7W1Cx8II1?=
 =?iso-8859-1?Q?4RP3vAs4NdzM9XMKAGzZMAyMFQqhBV93f7TqDYGnkUIKbV+e96qPQEBsiX?=
 =?iso-8859-1?Q?ALsv2qmhM6C6z3HaXseG0gdc3+8sGsFP8QgjmQT6UV5BnaVw9VIUhusVtg?=
 =?iso-8859-1?Q?kkNXWbtzUv4PD1oO+nK7ggbuna4/fSle5rVo3X30F4lowfak52Cl4k951X?=
 =?iso-8859-1?Q?5p4sJB2XCbQbJLdLPN8l06wBaAbB72vSCuOC4xlFhwMOIu5v+dZCHTNEQG?=
 =?iso-8859-1?Q?5/K30fQ8IJfQdW1MsF4TV29X1OxVf3moeyNv8QJTRWCS40WlBmp6/BOWxC?=
 =?iso-8859-1?Q?vVtQ+v6Nb3pGhDLufMUGu2GcyzFxjoMhjlNuoX4ENC3c1s4nRLIxpwPqV8?=
 =?iso-8859-1?Q?2GYDG1JTwlLc6abn3LfuxWP4D0gkP4gzGAavBxcW5vtcTIw10K35wjWAVj?=
 =?iso-8859-1?Q?SdctRY4nKjuoiteotx1jC/p/MIaYqYOnR21FtS7tjYvy4QfzJMv1+Z0F1R?=
 =?iso-8859-1?Q?4MTJsIcqmJPFp6/1wC0aTq5pwvu68QPR0J/ugTYKuRtNuAejuZGsizt6Eo?=
 =?iso-8859-1?Q?dBjururk2ZjXH9LovkZdXv60bJby1lT/+VwJB063qR4zV+W7AHLPFQwkVh?=
 =?iso-8859-1?Q?TxHUaj0DYrUL8/YBjuMIcoA1bN4T1lgvOd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b028cac-c5a8-4848-d0b2-08dbd18917fd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:24:54.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPN1UH62p+xqkq833tJ5kOClMfDQPamZZ/FL8CwUukgSTADwgWSyDYskHIo99Gj/I0VNC3utXFD7ThPaFYPwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 04:33:48PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:20:57 -0400:
> 
> > On Fri, Oct 20, 2023 at 03:45:28PM +0200, Miquel Raynal wrote:
> > > Hi Lukwinski,
> > > 
> > > zbigniew.lukwinski@linux.intel.com wrote on Fri, 20 Oct 2023 10:55:27
> > > +0200:
> > >   
> > > > On 10/18/2023 10:59 PM, Frank Li wrote:  
> > > > > Add hotjoin entry in sys file system allow user enable/disable hotjoin
> > > > > feature.
> > > > >
> > > > > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > > > > Add api i3c_master_enable(disable)_hotjoin();    
> > > > 
> > > > What is the use case for having HJ enable knob in sysfs available for user space other than for debug stuff? In other words, does user space really need to enable/disable HJ in runtime for other reason but debug? If it is only for debug maybe it  could be move to debugFS?  
> > > 
> > > I don't think hotjoin should be considered as a debug feature. The
> > > problem here is the power consumption which is higher if you enable
> > > this feature (you need to keep everything clocked and ready to handle
> > > an IBI) whereas if your design is "fixed" (more like an I2C bus) you
> > > may save power by disabling this feature.
> > > 
> > > A module parameter does not fit here because it's a per-bus
> > > configuration.  
> > 
> > I agree. sys entry is more flexiable. and let controller choose better
> > power saving policy for difference user case.
> 
> Maybe it's not the first time this case is faced, would you mind
> including power management maintainers in this discussion? Perhaps they
> might have pointers or even have the solution already.

@Ulf and pm experts.

I3C have a features, which call hotjoin. Some controller need enable clock
and some power domain if support hotjoin.

there are two kinds user case.

case1:  All devices attached into I3C bus, not hotjoin happen. So
controller can use runtime_pm frame to make clock and power domain on only
when transferring data.

case2: some devices can dynamitc join when system running. Some clocks or
power domain need be kept to make hotjoin event detect logic work.

In one system, two cases may exist at same time. I3C bus1 for case1, I3C
bus2 for case 2. 

I add sys entry in I3C bus driver to let user can turn on/off this feature
for specific controller. 

My question: any exited solution can handle these in current power
mnanagement system. 

Frank

> 
> Thanks,
> Miquèl
