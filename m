Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A187E7C9469
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjJNL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 07:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNL4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:56:41 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2018.outbound.protection.outlook.com [40.92.48.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16711AD;
        Sat, 14 Oct 2023 04:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEAiAGfigTsUok9Gq+vNALOYqZWzXiC7NFyLkmwHEaFhRAkqrsP9wSkiPbkdw/iFG0WcSkMXw/GQWvoPg6QqT8E6yIiBr825ML+L/lXaDeMaRGAwxhjJ6aWLqzYXk45ceQV08mZ1f2G7r58F6xNgT1fNs/xY7EnveyaXLrYptd0SxT8HnlrOWFnqIkcf9lzecj4ELgK2bnwS43BMjNdVmeQSy1kb5hATkcvLiYP3xATY4VTBods3U019Ky9RhBv/t1lpYsNmJzOCyEY2Mfrxh8d3YL5AhaKu0bCF5Gpgo7s+wt4MSd+shg8enmd7DoMIucLPsOox1ZzVFTfWanjL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE+tqS/1GBRACqs+fGXENQE4MPOsOZ5CU7VilGbgWqs=;
 b=BhaCUsv9lqttntnZayDta9O32P9eNelwwjH8twvbswzzG/wEvjHx6vgIQb5EwwczDdnPTNQgJk0QmDfbzP7T65hd0n0ftWEwjY5odX3T4JK8yXy2LSGtQHP0YRyo7OJGyG+iJpIg1CJLIfPp97a1nv+bfzJlu4hxyuaIRMpiQcIR5RgNqHco+qRE/WsayMO0B6tRFxdGr4wwuZghOzj7BL1QAIWgtpjYFSsWBun5z6DGZjzgDuHZRdQ83SoVHQk6vXU0eKoE6khlhF2DiHAJIIzdfVVSxyULF4gXNnxcbJVNCWuGXJGla2th1aEo1fzd6N6M+GV8aZtLmAgoffMsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DB5PR02MB10137.eurprd02.prod.outlook.com (2603:10a6:10:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Sat, 14 Oct
 2023 11:56:34 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Sat, 14 Oct 2023
 11:56:34 +0000
Date:   Sat, 14 Oct 2023 12:56:31 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/7] tty: 8250: Fix IS-200 PCI ID comment
Message-ID: <DU0PR02MB7899E040B68084B59972EC66C4D1A@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <2023101431-online-sharpness-84d1@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101431-online-sharpness-84d1@gregkh>
X-TMN:  [lSLAQGE2Wpwhs4D03gihj3DFgBFf1TyJ]
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSqB71hr003mJN8D@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DB5PR02MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: e34cc2fe-32ad-46a7-ee31-08dbccac9c97
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6bX+obqWKKOrWGeqWtJgqpBNnh60N/oeCOzcWm4h24BYmQOjFJwvfZbx8qelW5+0lyB/jqNKCDT9GT5Vpnp0eYXyyAMNAkdpsM1BW5ef8TtDwaU3/++9EWDDgLmV8BUuDJO5aHoMu9RCAX9esLoKKVmfbOrbiskSF6RwDAvfz1p7LCyVEIJb1XIMpdB2EtSDSBgIVqvM7YZ7RS0LomvlniM+0PBiG43DY/KmNjYjfubdA8VC4RQRvGFx176jBcu46lR2W6ddjggkaqby1HIr+PfHu0mfq5bTLoYvRwF7EmsO3l8zRurQqMFxUWqF6dye5x54BmF11a4mCvqqfBhaBcfMrUQGoyCT8XrKI7WpizyA9vQNO1Yq21/xhesfsCjwcJWIAd37+FG2Hn3Y+fuiA7TuyHP9BHbzv34PZxd9UX7h/WoEUlehNYmZ9WxqpURgWS1epUzgSrgNh7DA/PgiI5uJCn8zhIUN9QHC4zmBypGaqasprJouHni0bBUgzMCHDeOfexZVdqIdKImPIelIBJ+/GkGBHxSDCJ1mdhRE9Npu8idRo1qlZJRPP4dQbFn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ss0o1TPZmIgjU5t/yNIU+LnqDeLJocZmgMq/rrzEkYZft/8nIUWXggshkeiS?=
 =?us-ascii?Q?ZJhqyYYc7uGXGOIywZj2gZ9M2xh3pqZAYk+UFvgidHS++dCtmwHGVpM+nifw?=
 =?us-ascii?Q?0EM3O6fhNAUJ1UEhkh/BV3XcY7GtjqJ4/Z57XXktiwuURZ+WBShnYpA/KdD1?=
 =?us-ascii?Q?W4XgbbPERSrACm2lyKlNesTYMMUH0k2vpAwUqWHCnbI9Efyyb3Wy+psUQhit?=
 =?us-ascii?Q?aVJJAje2/rwMfLjk8Viv4RbvvGTQdUiH41G39NWdXJlaOJ9g8jZetHSbwcRp?=
 =?us-ascii?Q?wR/Q5WVZlRIc+o3l4nP6W2h7LYHiaerT07KXZVFcV2wNsCatkDvutimRMA/S?=
 =?us-ascii?Q?/O7xF7qyaknkJ5EjlBoJPg5HJHTB1u5KScFaBGPWlY7bvbQTy3/Nv9z6b/8D?=
 =?us-ascii?Q?z3eQNBcRlHzxQmN8QgeUEev5iQrB/3XSaVneNyigF4BQI69KYwM6OQVYFCmN?=
 =?us-ascii?Q?JzSuFWKWzX67ekjcTdcjYoSqVxNtW8EUHQkM/LvrDUMCODpPQIOiVS8r16/z?=
 =?us-ascii?Q?Zqzn0dUfcJQNa3Paj6yU4lvcrU1ox1kFBBIHE5kS4/5AEevFw0pRKsFcxZwx?=
 =?us-ascii?Q?RiftpXmjeY7tQfPqGk9Uj3hjnjKp0o1xQy0GZhBK5ABsewFCGuNTwaBmLfl6?=
 =?us-ascii?Q?eg3jcxboG91M4WrSsdQ0mIpK/gvqAe/FPJDSdUO2ISBkc4+FtPApWf7CvQcl?=
 =?us-ascii?Q?2f68EsBB0mB4fGMtpfz8R0Nc56xVKm3mkIVDQ29kXchVTDi8uS98+r9ANQ/l?=
 =?us-ascii?Q?Hev578o9MTx1RaQ1D46JmG9s1HecbkW5vNDAvK/wiyVtFwWdxf0Qh6Sz54GL?=
 =?us-ascii?Q?KMM4BLYTkw4MBGcm8jWUSW/6gSr9sKtfGG6vRUxRqKypb1acNWVxE5/z7bAs?=
 =?us-ascii?Q?zsWgrjoMMqF/Q0vyBx/Ttzch5lnU8cCn9czD9hLTF6ASZcZv+uz8brcXCbMr?=
 =?us-ascii?Q?aJuyuE6jsG6zQ4txeVymKMskG4s3bbgjQLWiBe3MZdYPBKzmkhIZUUwXUAwV?=
 =?us-ascii?Q?JE+hWIfSliOAW3Zjg2HcBTLyJY5zfl574srKNGzCvh5mUQYdMO6TQcRrPGYP?=
 =?us-ascii?Q?WcJlVP336uKq++SvFKGy9HV0e1lhzIvqcxl1E0HYiqBeuIV0AH/ibU+pYjIg?=
 =?us-ascii?Q?DF2oUr1vMHszI4KfLsQxBbixjTzkaNSUUaVzllkMUU8TYAhQP3G62SF3xZj5?=
 =?us-ascii?Q?r1yUcF+KUicsADJ9XmrcVM9LoZCCJnrz8nTy3A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e34cc2fe-32ad-46a7-ee31-08dbccac9c97
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 11:56:34.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10137
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 10:28:33AM +0200, Greg KH wrote:
> On Fri, Oct 13, 2023 at 11:11:09PM +0100, Cameron Williams wrote:
> > Fix the PCI comment for the IS-200 card
> 
> "Fix" it how?  What was wrong with it, and what is now right with it?
>
I should have specified better, my mistake. The PCI ID comment (135a.0811)
is incorrect, the card ID itself is 0x0d80 and the definition used
(PCI_DEVICE_ID_INTASHIELD_IS200) is indeed 0x0d80. It's just a cosmetic change
as the rest of the IS range of cards are also being added in this series and their
IDs are all 0x0020 offset from each other (though the IS-300, 0x0da0 is in a
parport_serial patch). Makes no functional difference.
  
> > 
> > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> > ---
> > This is a resubmission series for the patch series below. That series
> > was lots of changes sent to lots of maintainers, this series is just for
> > the tty/serial/8250 subsystem.
> 
> Your patches here are not threaded at all, was that intentional?  Our
> tools will not pick them up properly, and so I would have to do it by
> hand, slowing things down and making me dread handling them.  Any reason
> you didn't just use 'git send-email' to send it?
> 
This was not intentional, no. I had problems getting git send-email set up,
somthing to do with TLS issues and since Mutt was already set up for general
email, I chose to use that instead for convenience. I can look into getting
git send-email working and re-sending this series as v3 if you want the
series threading properly.
> thanks,
> 
> greg k-h
Thanks
Cameron.
