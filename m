Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64377CA4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjJPKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:04:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13425AC;
        Mon, 16 Oct 2023 03:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSvsKEQczeJubuXyJt1CrQ6ZSOOaok8tJ6iWuwP5b7ggZfyLSTAb1CExtbqNzQpWr4e6hdbNRGjKr2K6olHezIkZqmQlZClkk33vWHOXHz33MPaiZOYdCU6HcECxBGm5IQGZHR11UhdplddSr1OHjhph7HS2fqmC1gST/LuEdd23pHohQKbNuP5UaRBBvKxvB/pXVHsOvxj50jsq3N5HDsSu/Zpd8MA8/tUHI0VZ9rYfOA95X6wZRvBuJuyucN6atCbwSNr4FgzZiTIH1n54buAIDBgH+6ZWalYBEqKHFdGmnLzyAL8ZFBiElBcoPSywn4JWTjbZ7acGRSGAFhHD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbMeSWYm8KPCQwawSSov3A8QflecMkqssxcRITSehNo=;
 b=dcWQkoVJPyTeK1p1Ax7+HA4Sfzqm6oIJShMmg4FCuuJI8YCSX9ubqhNjvh+C2EZt279gt/2fQ006iIvMjvTYnOCe9Kjphu7NBwO8jHhJviZyUX+G1pylIl6fvzw/JoYqftsy2bqINHnWNClhdetQIdldkRwHJjpKY3x7Y3R7xZhyQ7uMBmQEkwwkt9h5I/+mWRb6BaCSpR+L2Xg4WCqETOlH/fNZUxxztRcqsx4pFW1XEvPBsA0pE2QJLocwuUTTb4GugC/iEk6FMV4IQd1cKMr0ZkMy+NrjUheHX10hsEemIiv0EQEywwb4kHSoNx6zZt91aHaH4u29v+k+nFXHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbMeSWYm8KPCQwawSSov3A8QflecMkqssxcRITSehNo=;
 b=HSj0/DvVryGw0YbxtfyvWxr+NGdeRQ64bzLIbZ0rzdnlYtKqX6Ca3/sHqTPOKAbkV6kCAgLXuxIuKD2nKh5Dgfk+YHgNAMoe19M/GezFNtgBV1OYQPq+kcEXeLkH3PlaKCA/ioH6qD9/3nXaC3ts/d/jPl4ayy0mFdv9Lr4Bw0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by DB4PR10MB6143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:389::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:04:40 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486%4]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 10:04:40 +0000
Date:   Mon, 16 Oct 2023 12:04:31 +0200
From:   Emil Kronborg <emkan@prevas.dk>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: set fwnode from parent device
Message-ID: <imjcptmiirsbevdbk6lpbdcdmodaic3bfaj6hkrh6nqvkrrjni@6u6g7ko6ekd5>
References: <20231013154742.76836-1-emkan@prevas.dk>
 <CAGETcx-MP7XNUa0uObFpEDBiwjaGgTGvKu6Q-RXkrh0+hvXZvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-MP7XNUa0uObFpEDBiwjaGgTGvKu6Q-RXkrh0+hvXZvQ@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::31) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|DB4PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: d53ca775-4557-4171-b8ef-08dbce2f4fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GdzOI4nyTJ6B7s3bEWxOLeCO6dQbS60oNl2/2wbWP1QQ6MSQ2P2YHfVGyNXXW8by7M9D0Dgff9A17KWCY4TkZwSueqrFIYGmAa5CE0Z1iHQTV3txal5kMxNTL9TUULpVh78nrLRkcnMlefysGG16REEtThXu9Y2POaSLbKohoIBJuHYeVhVqKTGTaqKFcocIsKSsaV9v6xsyFFbRALBeMjd58abn1Mft2AR0SuvFXP4+stAi72e/sGzsIgz7b/LLj7WluaglfpF9HHxWmvQDxsftOLHRHVwOoiSI3bnZdO7Ig8pDmwx/LphqER6r55RRZ+ypicRV6UW9tiVt+GqFsUUgqoG5+Papt3OS2Krj64LgWPekbH56A6InvxfFHbMFFkWIKo1psHnn/H6LtgPs76dv+Yc2OrDDTL2pjiq5NDQYw2glI0Tjl4ZCROEpZOtPHutqC2ul2XyQ6Ezz7+zNHrU5JetqFbv5bBbKZBDJjFHYdcgm2VJd8WqfVCkbepsABBgNLhY/jfV+gWgwnhGI3s/uNWVivmC9M0NfKAPo+ms1iEpNSH5GRfqsCduHiO/IvhHGtS0DqURMezhnebAqGlTkkXhbpMM+TIpmYY9uLnuwzooEyyxIoEWO7eQ3E6s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(136003)(396003)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(38350700005)(38100700002)(6666004)(53546011)(9686003)(26005)(6512007)(52116002)(6506007)(66946007)(66556008)(66476007)(6916009)(316002)(478600001)(41300700001)(4744005)(2906002)(86362001)(5660300002)(8936002)(8676002)(4326008)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzMrd3ZWYzVOWENsUnhQNjhVUGNrUVQ4eFVFMTdkNDZnQ2VqL2tRNmZLR3BQ?=
 =?utf-8?B?dUt0MWhJRkd1eEJTbHNqNGhrdVRyeEpIMmU2MXJ1ZktRUDNSQi9HZDloMnVG?=
 =?utf-8?B?MnM3UnFMQWxDTFpLUWoranV3bGJkWnNnNkdBTndWcHluUlZjVDYxcHBpcXZG?=
 =?utf-8?B?TUs4TTRNKzFIVm4yOHhNbmtvWjhMTThpdHZ2Yks0bVVQLzFNdVVqcmNTckx2?=
 =?utf-8?B?V3NlQWpnZ0NXTTNraFAvM3NSeU9DQnZFKzlWd2l6SUNoSUhKSE5QUmJCNzA4?=
 =?utf-8?B?cGJ6eHpKUGZxa0lWcTJXNU15bTdGQmRsWVMyTzBmY3BsUHBSVkRKTW1LSFFZ?=
 =?utf-8?B?S0dSNDFvem9Sc1QzN2J4NncwdUwvd3FNS3J3RDB6c2huSjZPQ05GcUFLMUtL?=
 =?utf-8?B?c3I3SWNTR2JPaDlUdkNFTE9TcTFJeWxQQ0tWSnkvMnZNeXM5Y0ZyTHVjN0oz?=
 =?utf-8?B?SjJpd2I5SlIvMVQ4VVpsRU5RRksxWC85K3hqUWY1MFdqanltaWV6eEU3cW5O?=
 =?utf-8?B?ZHdWcUlGNGV1QWFtZEhBR1F4L1ZndHcwZE1Fem1aV0J5d3BEc2tRaVVZMEFU?=
 =?utf-8?B?dENCQitwd2FqVWpSVW5IWDhNTklzTGp6R1Z6MXVzK01NRU54aVV6THV5bWNL?=
 =?utf-8?B?enVhVHNVRFdPYmxiRm1neUlFVHBRa0wzRGM4RkhaRzAxWFhMWXBVY1VUcVZh?=
 =?utf-8?B?Qk4xclJhOEUydlNTblM1QzdHN2VielpqTWthYm1PcjNoeVA1WmMrSlJDU3Vp?=
 =?utf-8?B?cDNhdWpWRTRvRlFLZmR0bUxYTUl6VTY5S3VJWkJaZUwwWldHSnBwclhJVWFj?=
 =?utf-8?B?MW04SDhFQ0FjRkVEdU5pVXhWUTlhejJRMTBLTHFtMWdySk01UTRsRGdvT0hM?=
 =?utf-8?B?dnR2V3hsMTZZdW1DNG15emdXTWdQU1RPVDBvWC9mUlNjRVdIYlIyK2NRMEFX?=
 =?utf-8?B?L2hKRXRzN1B2WFljbjZaWTcrWHBpVnp1RmNZZjdsK2FIWGcvMmI0ekkwbmFB?=
 =?utf-8?B?eCtGdGNBT1JBM2F2a2xLM2E1TG9pdnpDaG5TYjlWV2NTZ0F4UXpCUFovRmV5?=
 =?utf-8?B?VU9ycElJNitTRDRnbDVPR0wwNmtnVE1JVHQ3TmtLMjh6WkxTV0IyL3U1YjNH?=
 =?utf-8?B?NllOM0x5Q29kUGZKVG5sQVppdFRwdjhsblJnOWNzcnN5QmlULy9mSU5pbWEv?=
 =?utf-8?B?TnFZaU9HenlNblN0bmVBdXpaWjYxU1lOUEpHOElPdytWVyt6VWZiOGlXSDJV?=
 =?utf-8?B?ZEE3RWp4OHlPeHFMdytRb3lPZDYwZG5aaTdFZDRaVU4vbFFNRXI4WDJuRDRk?=
 =?utf-8?B?MDNMSUZ2V3Q0a0NmcGErcVc1OGJjNWtrcmk4ZEdpRzBUeEhDWGRITlgzeWph?=
 =?utf-8?B?cUtmQUY2S1pTbHluZmFITmJiUFFhVjM5QytnVjQyak9pNDJ3dVpJRXVseFRZ?=
 =?utf-8?B?TUFLeTZYenVQUS8vT0FTWE0vYWR3ZGdvYkpzWExhZGJlOE9acFRmanFack4z?=
 =?utf-8?B?Y3ZFa1VraDhJeTJLUzBJYzdsRDhqdWd0MmhaN0gydml6Nkx3RmV5T0t4Q1Ir?=
 =?utf-8?B?SXYrQlo1NlFMai9jQmMwcXo1Z0RJVVNPYXAzaGVQNWgzZ2s1bmFVUDZ2a2J4?=
 =?utf-8?B?QW5FWFBURkxORU1tb1V6V1FpbHNqVGg1WG9HWjU3bWdmRWNMeHdLZnp1Q0V5?=
 =?utf-8?B?OUlFYVJVM2lzbERHWjFETlZzY25GbnVSMWJ3QmMrZzNUdXZRWkxRa0MxTVhU?=
 =?utf-8?B?SzRXV0pDUm16ZGpBNU12Q1NIZitPY1NHbUhISVFtYitESkJlQTdVbC9UT3l3?=
 =?utf-8?B?WFhyL09SWXQ2MnoyVThoYW15VEVES0F4aThjQ2VJZ2RMc0RpaEQwbFluS0FG?=
 =?utf-8?B?NXlGYjZZRlVLamtySkw0QSsvM0RyNmo1M1FHY0FISytSQW1HenBlWkVEczlS?=
 =?utf-8?B?T2ZRbitQdStrMnRGVE8rTHFWWVF2SjRFVHNFT1ZBaEVvQWt4ZGFybk4vdDNl?=
 =?utf-8?B?OFhRYnRlT0o0M1Nubk9kb1F6M0tUUSt2VFo1eVE1bVMzbG1ZY1F5b29Fa0Y3?=
 =?utf-8?B?a3h1R2hoZUVoN1IzTHgrbWJuR1pqcWtFY0Z5MTRORkZZeWFZZ0xDM28rNTFC?=
 =?utf-8?B?WEZiWFJDRmtXOTB0UEdqVDM3VWRtdjZtZHUzMHNxWWx4YVAvVlZTOFZteitX?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d53ca775-4557-4171-b8ef-08dbce2f4fb2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:04:40.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsddBWLV7W67D8XFLjV/1BtBqZYJCr0uvoJQ3US2HmyhLAbVr9KnMONCDCmjskFc1H6MPRitr1dKODJsw+Bdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 14:28 -0700, Saravana Kannan wrote:
>
> On Fri, Oct 13, 2023 at 8:48 AM Emil Kronborg Andersen <emkan@prevas.dk> wrote:
> Can we do this at a tty/serial framework level instead of just this
> driver? Also, this is the latest kernel? I feel like I fixed exactly
> this (but at a framework level) several months ago.
> 
> -Saravana
> 

You are right about about having fixed it. I mistakenly mixed up two
boards and thus tested my patch with a wrong kernel version. I apologize
for that. Commit 1a5ecc73b2bf ("serdev: Set fwnode for serdev devices")
resolved the issue at tty/serial framework level.
