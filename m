Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801097CA09B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJPH36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:29:56 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2081.outbound.protection.outlook.com [40.92.49.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460BAD;
        Mon, 16 Oct 2023 00:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5lVFCZ3zNcDs4RZY2bvCSl4R7fBYtUvzAcJlPnQUsZBYiH3DoPg36ieNHcdeK5ayGUkLP6INLnTDC2jIcfZDDCC6k2s8evtwxabCvh93GQItn+VEaC0s6KgUYzbbLUwR0jwY9bRRfrYlG3ryc4DmILqc5DABCvkicakSByRE6kywOXcZ/jlzxvfmbxa3+URw/gmUxBICuCbbrAx03g/9f+RVvIGEUqQRd49l8902xugnfm5XFJJq4GRdtJFGI6Wz77oTqTftdNQY18u/CDcWMdOb3o122eY09gr4qs7VD5QNh0I2oaxwbLf22KznsCYAONeQLFtberI7nK3nZgOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8ZD+VE6xDx92ONnmydVSnfByQO6QE7L7wogSwXu5M0=;
 b=dxytDmnzpcClUtmzHvG3mHDzv4pUL3admf5tUxx4v7pV7k602FGGiODazWS+MNRmiC2XFLUOoyLD4tnqOjIJB1uD7D+TT6MApcnpVaKlgZYmETczLHDBZiz/iYTDtBVkJn4shrclAFzxXOuh3a34f69mFfyCikRpKj9J/oRlmID/LBWcEYgDGmNchd1QRyf2c3JwUxquo9iK0wOF2mG+dJUdgrCL7BpdMiMvuAJUErv/KMFs5g51xB6/0O75eIA6tjiV7v7gsesRrw8ol8fGLT/RcvH8OKykS0UK7ZiXjPDtQY9peQofGKkl0VBum2zWPhb3ieWIAifoKv15iSwy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6398.eurprd02.prod.outlook.com (2603:10a6:800:198::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 07:29:52 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 07:29:52 +0000
Date:   Mon, 16 Oct 2023 08:29:48 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/7] tty: 8250: Fix IS-200 PCI ID comment
Message-ID: <DU0PR02MB789959879FC6EC46936A157CC4D7A@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
 <DU0PR02MB78991BB41F77731BF0BDD777C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <17636fae-6aad-4f6f-bd16-6296e726b324@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17636fae-6aad-4f6f-bd16-6296e726b324@kernel.org>
X-TMN:  [5Spj37XGBai377bwbBn/p2VZlGFbYP8n]
X-ClientProxiedBy: LO4P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::9) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSzmbI8fnHKweIRV@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: e636bc5e-6be4-41cb-5f94-08dbce19af4a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3iFlTWo0xPHV3N1Sx/HEoqgdEvfvuZemDRp+j+F8fy1fVs78NUhnltN6Zo9RFrTUFfgEqUEbVfbZUUmro7noeY8hqNMNS0+uunDYcIUHWsUATNbmT2h8tFFPa5v+z6awk0wDdy2ViFNxi08FRoltPdsNGOD0lRqT/wte54c1vjHDT5bsbms8toHcPZ5XSvU4TWvbz/r9pMrpmE8HNHuc3cumFAxMlPIY6GMQvqAeBAKT3eU8+D93tyIw/LBDxVpDR1vhSUMyfDG6vEL+4j1CEhyMQXuQVgO//Iza6qrhGWt5qSvISxE82pYLIbU1fLmkvdGm5VJoAuzmg8wrEUZ+YPZtgUAAU+yCKY7oB+XDWmz/IUiR9egD8bsXzBFSIgXFNK0cja5Qmmf7PzlQyPfj10c1phmb0k/PVTXlDY2fs2e8+d59suun23uu976Auprp2ZKZYY4dKg+AaDma3xH1uFUjrn6qyKLNvCUAk0SvyQMnVFyJEaYFW3JDl3B1okKgc3gxmsrvcFrZs7wc09toojFnJ5IZzmXPYNM/+eGTi4BQnLgDrF9lzsbLsQ3kbmVDW/dHULGMJ7pUb+IoFcpcQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gw1wEYNkriRUs8tsXW0EOq4ObfQmx7eDV7+ZGuNDOYPEwSjZyZqMh519NItN?=
 =?us-ascii?Q?FkMAbCb6P5v+w8GTdVLt7uT9mhZ/3u/9rv8tBu3hanO/mUlFxKKntX4sa/kt?=
 =?us-ascii?Q?ZIQQdQTpvkq+AxvF7gdHzpXMvBOoCGKbduVBsOmKycztKKzGPbWCR6fMzF8t?=
 =?us-ascii?Q?0W0hk25ovKXR1Eg2MpMQ1ayQ962YMiBT1bZEJY2pM0OPSK5Ftop0Pu1M9SFC?=
 =?us-ascii?Q?65zVJan8axm3cV7vMAoqRKqBWUmjE56OENPRfbaD0uXyCX10mL9b5GayKsLV?=
 =?us-ascii?Q?43XpXyjdLZ0LT7Fdy/lTGwG0LpB5Rl+nTByQkm42VIk8rrD9Fiprt6X/HJMU?=
 =?us-ascii?Q?wjGptAvVCssiO63PfU7NAXasgb3wpZuYUnj1BDCXD8QHLb/ktuU2WtSrcfUa?=
 =?us-ascii?Q?7H2lgP9O8DslRLrx1lEGegly16nRQ0j8rEWNtEF/UmUwKBd6whpEPr+KpGT1?=
 =?us-ascii?Q?L0dmoajop8yEzyrGadN/eLCT8sYl26IZxaBjw6sAeU5T3UZIA4sehi4y1PxH?=
 =?us-ascii?Q?kc/gx9pde8j5qIQRRv140nbreYQ4zgkjZboOkkHjhdLpb4pEno38SQu5BLC8?=
 =?us-ascii?Q?UO4i2qMt2QRKDeFHKxO0BQ3iGbs5rUZefjNvZr7NFwYCTu2hrCOs0wjJsXeF?=
 =?us-ascii?Q?Zt5Tj9HHMObGSfyqOFLSPT+x9/fqGM8LaddCTQt9rcUOchWXMiT80nfu5WgJ?=
 =?us-ascii?Q?OpSZZA3DMANSjrWWIXGdzq+IjZbclCaO2bzQ2KT0kzVb8gUQHR8LFzUpSEt/?=
 =?us-ascii?Q?AVkTyOKRmfd2/iI+0EjwrgDz+PJZbfHJM+V1QY9eqCPxcu6L9zfxYqbSPSjG?=
 =?us-ascii?Q?nZwJXxyviQQHRsmGIW29iOZKiLKaI58ZNPHTtUler7mBkfYgxurgAxwb9sk3?=
 =?us-ascii?Q?rJQWBshmmRVXx1SkkZHfNDpwuuNPhwLGNFsthlyMpJj0yn5BIVe1wErPxUse?=
 =?us-ascii?Q?3Uxq/M0fROWXnkmMEHvQkhbDaOVPTbL0uX/JWf5LG5Ki6Ks+t14ERESN+Ha6?=
 =?us-ascii?Q?tkO82aEkc3JmfiMxSlW5ZWiEknZywRycgLXoJivkVUsJRZbEsUoV4TpaKoei?=
 =?us-ascii?Q?0hNa7wnfiJCY9rbpKZ1/ClLVx0bJ//VWja9FgFaoxKNdFV046CU66mcRsHlT?=
 =?us-ascii?Q?zHlhyzKpvPSbPlPqoFT8hDE1ehnb8cMPz47brnFBMhjD3lRKmk5Au3fBkRaD?=
 =?us-ascii?Q?KbWU6VRen7tK/DucKgcTb4wKW5SIy4JcryIHOg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e636bc5e-6be4-41cb-5f94-08dbce19af4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 07:29:51.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6398
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:37:43AM +0200, Jiri Slaby wrote:
Hi Jiri
> On 15. 10. 23, 19:10, Cameron Williams wrote:
> > Fix the PCI comment for the IS-200 card. The PCI ID for the IS-200
> > is 0x0d80, and the definition used (PCI_DEVICE_ID_INTASHIELD_IS200)
> > is indeed 0x0d80, clarify that by fixing the comment as its
> > neighbouring cards are all at 0x0020 offsets.
> 
> The real question is why to maintain a comment here at all? I suggest
> dropping them both instead.
>
I try to avoid touching other people's code unless it's wrong as is the
case here. I could remove them both but since they both (IS-200 and IS-400)
refer to the definition in pci_ids.h, and the rest of the cards use the raw
hex IDs instead, its more consistent to have them all showing the card ID in
one way or another, IMHO.
> > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> > ---
> > v2 - v3:
> > Clarify commit message with better explanation of the change.
> > Re-submit patch series using git send-email to make threading work.
> > 
> > v1 - v2:
> > This is a resubmission series for the patch series below. That series
> > was lots of changes sent to lots of maintainers, this series is just for
> > the tty/serial/8250 subsystem.
> > 
> > [1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> > [2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> > [3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> > [4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> > 
> >   drivers/tty/serial/8250/8250_pci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> > index 62a9bd30b4db..ecb4e9acc70d 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -4917,7 +4917,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
> >   	 * IntaShield IS-200
> >   	 */
> >   	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200,
> > -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0811 */
> > +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0d80 */
> >   		pbn_b2_2_115200 },
> >   	/*
> >   	 * IntaShield IS-400
> 
> thanks,
> -- 
> js
> suse labs
> 
