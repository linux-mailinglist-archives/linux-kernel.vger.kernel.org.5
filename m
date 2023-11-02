Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0532C7DEC0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbjKBE6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBE6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:58:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2091.outbound.protection.outlook.com [40.92.59.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F280FB;
        Wed,  1 Nov 2023 21:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaeDX7d/nCJVSRXqNyspVgzoeeE7SjqA8bTMC00aNWgARRaZKVHV/tSPnxiFgcQKeYG4cQ4YFDJYDRJEKVTyT/EzCrN3G2jYOn+ZMLZXeHORuGsM0UFUZaXd70Y9GSSNybG/1heSaUR6fKVsnzRYLoo590C4YK+UVGwhdmOhucq+dDNUmj/uiNkl3Nt87Y+u49h07iflmuW8ouy2rntbOoavW+GmpOTXE7GV/cfvLDIcMT5wXhsqWJJG1whPcFRRcMt/ZeXl1E9dC6DwfdV3LERyNqpagZVMzMAEoKB/u1rpVJUM5Eej4LsFiPb77sTWhO6sNk+Hs31IK5dhd/xeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBr0VFT4r19CBhKUiL6Ru+Sj7GMQEN00XcosNd6W2JA=;
 b=GIkJEmSRpyloUiMbHO0MoTIsmwPLxL/1ssxNkSVLJiskbrUZW03RactZlgC3pZbXRVPwde/80GKzurKckZxlgVR8UWWizHGrMPv2mMlxu7yxU/RVjW8wyb5vCa5xOehGQj+90SRtBnsgBBM57vR/YhfyW/8kxWHW39KSC6GfUReugutSU9zbQQGgbuc+0szREBIq61BtnfrY6RYxeaK2YRE/W0wVG9wufHGYpluPebt6xK4sHKcmnm76ADrGjNx1l8MMs/V95fk4pA/XNSoUDcUudUl7EA3fuCGwKOmmQPb0MqzOLPEFROV73hKBSnN+URp8mBvVuvi2Ti45A+qepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBr0VFT4r19CBhKUiL6Ru+Sj7GMQEN00XcosNd6W2JA=;
 b=CBC8sZDm3BjcUzomcUL/ubc5uodx660mv0IUwBiys2c8PWFl33TfNicTZZpwdG/k+8Aegm/wz/7me73Y6QrqArI5zUN4U3B7nW7HP/66rXhyyKCntdWfiiiK+3jo3DZbeDF/nHlTe+JBeZty05jhsMQ7iihFcCw/fi0cIoGjrvkiK+kzSkN7zPGRA07dv+WLFgE0CxdT/TI+NaX4K5Ii1uRmm7Q5q33hH66D6Iyy8X/062qNFV+W2MF3SUugQU/S/DMujY2Q3TfLk+2vQap9b7RNAd0JXO5KdWmtBV+vCLI+D63IOQRoRy20OFxWc0E1K5yOYM2E0bDYwpFhOpc6JA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by VI1PR10MB8302.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 04:57:58 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 04:57:57 +0000
Date:   Thu, 2 Nov 2023 10:27:41 +0530
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 0/7] crypto: Proper Initialization of `struct
 skcipher_walk` in x86 Glue Files
Message-ID: <DB3PR10MB683587925DA82E44BD8D5D6EE8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <20231102042043.GD1498@sol.localdomain>
 <ZUMl9BJcEXta1Spg@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUMl9BJcEXta1Spg@gondor.apana.org.au>
X-TMN:  [8puoTSQyOB1q2X1jSitcHcx2dFrKxpY3]
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231102045741.GA1557102@nmj-network>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|VI1PR10MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e67d29f-4e24-47bb-b71e-08dbdb60478c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeisqKZRZE1YbA6aalb2OBz+VucNtzPO4ajQ6Mker23MRECnT11YbMnz8fUWI45GE7pG6YERmDhLFDYs9obR2WxWnkFb6jEzA633gSyF55nBdh3axGRwrWpnL8j187RLsEfaCIpRGL0nIxtRpqf8WcCq3W+zYun8031eGeenmSRmi3DWEdn2EXVV/xO+BflxK7R5iXEdFG9xxxw1Kafcg8YYIC+VQJ0M8ejf52hrLzjKPTFMdyH9BohdMtJJxL8SYfDBU11XrSlJ+IlvYPYDsEBaJ83IESybU56DHHKflSOTOSN2AuDdSgMTADD6YP/QGvg18MBoZh8ezWA4a5ZEY6imVqZ6+WGBAniJYEYGDFiySuvkZOg6VyKnuP8jP2IoP4hpssr2jnOxsf3N9BCDd0SrBixzYjPzEfLo8Q1qrES758NZLOEqCia/Sp5iVe//6oiNTtWdD/5Py2D8Sd3PPFtdd8h6Co3ci1k60/ctYW2MlIdoRDw9iiNrp/Gsz4AsH+oovxLb5kGv0+YZSZdi/CaOGHfXIVH9mHyR7RwgvlwyK3Y3LHaLZw95Ym0znidm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0I2aYVKCb6MAfnj4WXc6yrujt4pFyVscCsZpFql7dnPZC7yg+aIuM66Qb+2?=
 =?us-ascii?Q?ThW7t+W1HTS3grCzuSWGbodZGTzDGp4GnNKefg+LdEl3FDJ4sIV6WyFtM50Q?=
 =?us-ascii?Q?AUpwNJDvBC1X4nAOjsjVkUIh+yyJ82EeHrjBkylS990cihuj5mFK2VLjX1ff?=
 =?us-ascii?Q?D/KQkiZ7yrJ8sI9Tbn3yf7XlDx9j/UQMqgNYYX7Xo1FuWXRelXQGzIzb74Kv?=
 =?us-ascii?Q?JxiSRc0+DWENVDrzgBUTJA67JPEbcUbo8oC7XJ4xDGhEM/cx+rcJbT/3YXYn?=
 =?us-ascii?Q?PY4k+Ubxmbm1eYG4jFWykPO1dVeYVFxasX1rmNrrPiqIJEOca4W2VMiR59O7?=
 =?us-ascii?Q?zbgVRZds7KT9z/MYAOramwxVXhi83WTNlgqScSl0bq+Iy6goGh8fNdNZkykk?=
 =?us-ascii?Q?7WgeDeCgT7eaBi9H706J79B+G6AWOn4Ye8uYFILAjgTxLeWV9jHecW+W89vC?=
 =?us-ascii?Q?WffXpZHWPSjAGSV30ln8ylZrrja3uZt3dpJuC7GLtkzhL90efyWZh7ha/Ay3?=
 =?us-ascii?Q?pIV7MYHjcPx0kLzF6jC2EOZ/MqIfO8GZNgJrxXKWHlFyBks03566snjUrodx?=
 =?us-ascii?Q?UBY9JnC6+ehIf8UtcXB7NY/c/EU3wCXdg5QcGUb/nMTYuRrVjCRJAWLe0op9?=
 =?us-ascii?Q?IxirFULMZ7XyZQs/pri/Ki6uYfgtDlmHwavY+w9u7DpTtaKYFOCYqMzyAu+m?=
 =?us-ascii?Q?2a0tB53E4nxO6LwqtRpcnpfkNPQGLAowUR3yhAr9icLg8XLw6PFPSUQJM7Ze?=
 =?us-ascii?Q?xh5x+KwDG+IooflvdW5pbosny8MKFf2brgHCZX8KbkYXFnSFMQ1UlM6UJ5cV?=
 =?us-ascii?Q?NMk3DkszIGdsbR6aWW9TjlMEt49rIXrZ/ir2uilQLD/7OmgG+yHNgSHanqRB?=
 =?us-ascii?Q?IQyG9oUe2X4HReRi/JrsDgIyKlEOlMsI3OBDHKI7T0dqw5qs9Y/x5TEXpGAz?=
 =?us-ascii?Q?agpO6R3Vre+Q44irH1bE+ii9WuG3a2z5ZbvrtJhJYL2cQ1WKhaEl50qsLnm4?=
 =?us-ascii?Q?6rID3XIY57Iwhw+gkPkJoZAWyXdTpCM1QZB7qR5YrcxP5u14IjINTshzqP2H?=
 =?us-ascii?Q?9U9gJXNq4B0QOiIv9p0JktR2t8JkL3i39xA9boI0D0NjAO+JjZJAMjQgMH5h?=
 =?us-ascii?Q?GNAwdt+/OwQn/BdeNjVOd2+WOp+P/mZAaHnX/lE/oDG4jSVAFA9GKCugNVeZ?=
 =?us-ascii?Q?Gvp89Hi85KWUqpyikR73wAHkcVzqY9KvEzEiaIqKbVX0ikXd8e09ZhHP2W4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e67d29f-4e24-47bb-b71e-08dbdb60478c
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 04:57:57.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Herbert,
On Thu, Nov 02, 2023 at 12:30:44PM +0800, Herbert Xu wrote:
> On Wed, Nov 01, 2023 at 09:20:43PM -0700, Eric Biggers wrote:
> >
> > Updating all callers of skcipher_walk_virt() seems like the wrong approach.
> > Shouldn't skcipher_walk_virt() be fixed to initialize the flags to 0 instead?
> 
> The bits of the flags that are used are initialised in skcipher_walk_next.
>
I noticed that, but since skcipher_walk_first can return with failure, there seems
to be a chance that those bits are never initialized.
> > Also, does this fix affect any behavior, or is it just to fix a KMSAN warning?
> > It needs to be fixed either way, but it's helpful to understand the effect of
> > the fix so that people can decide whether it needs to be backported or not.
> 
> Does this actually trigger a KMSAN warning? If so I'd like to see
> it.  If it's just a static analyser then I'm not applying this.
No, there is no KMSAN warning. As I mentioned in the individual patches,
they're addressing "coverity" reports (so yes, static analyser).

Initially it did look like a false positive, but upon seeing that 
skcipher_walk_first can return without ever calling skcipher_walk_next
I thought that there might be an off-chance that skcipher_walk_virt
returns without ever initializing those bits of the flag... hence this
patch set.

PS: I just saw Eric's reply, 
> > Updating all callers of skcipher_walk_virt() seems like the wrong approach.

and realized that maybe my approach is in fact an overkill. Maybe simply initializing 
the flags would indeed suffice.

Thanks,
