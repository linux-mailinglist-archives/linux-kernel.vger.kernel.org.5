Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73478C7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjH2Osw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjH2Osk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:48:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2036.outbound.protection.outlook.com [40.92.23.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF019A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkM6mKfh8dVSSl3N7tQl3TXS+IzW27JoHbGfqHRUMLrIGS7jDGCD2UvDED3ovww0GVsu6uefgKC+2vHcv7A2jjj2c6cv1CjKJbooyBv0D23EbTELMLJ3vznavyJei0X4TxlfP0IekWPNFA1Tg0e32QO14Xcd3IYJkIbde7zfGYqoL5UxL6T7tVUhwRdWIYNeYJcS+qEvOyWhQ6ESWW84JJ/SOhtiF4prxLhuZemgZLA21wTkHuGJ59cQmyiHAPyd58pDLAgIf/PrfoDVFpl/HYL1Ni+hVSrfv7hLyP6hdNC04LV9ACfvc77o2H1x/02Akcjr1nAaQUq9bmAjBBg9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4STJGClH7HGw8avf+bDmapeF5LQC37WuZXo/dhvKoH8=;
 b=j3XaV3PL37OeQuftMoUyJEyJ40wEa+MoajvKPFUKR82BZd5bC1CPyfPl5/H4Dx4ipFjOY8RoYHjVWVb6S1Yv7dgly7emRQjBUp+qxULjJEf6MWp1d9KVqIIJ6uo8Yh3Fe57zXrcwCJvilwbg4uNZnh/sz5b2YdU+UjGeS2cMScYvKWOW3V8IDfULcmKPqK5BvpsmC1ftTrWW1abhTq5r1wCAaPMBKlU3t8MEE/2gYEI8dt6cwx5SemFdmEerJ/5ZcW8OBi6OzK15aPs6Nlj6WBhhib32OiLWvRKUJKGO3JUsp8kHV4T809wnnCNR2TLqDs+6GmQF2iui594YfOcwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4STJGClH7HGw8avf+bDmapeF5LQC37WuZXo/dhvKoH8=;
 b=TdfviZOclrcBeh6VwKvUzkjbKcdSSOLmsVIa5Tj0W4geGWhxeh+RFsh0H7R8kVWr6QIymH+MbLZzaTWvsIyPIhTcmCAWgYW4FTbHjqAmosB427azvWCwHIV7aod9FqVga3/D3R5IbYEYHu0EeAABVQDWYlIrnLVt4yZONOPTgjVdpr2MJihVU4M1aJqwGB10nnckHDmF/ybHAYn1LQB7i9gRxeozumVfqGthfyQ602U5v8PpWj0w0eWwfJjXyNmQltyDVISrHQGUQU8BJuGEwyIU+BOoCdL+Zjg4iX5sZ3BkgC+z+aWObWcn8iKR0i6yQC9KpVRKPvd8mVOaWyKOWA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by DS0PR11MB7508.namprd11.prod.outlook.com (2603:10b6:8:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 14:48:33 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 14:48:33 +0000
Date:   Tue, 29 Aug 2023 10:48:29 -0400
To:     Nam Cao <namcaov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <PH7PR11MB7643ABC9DDDEF7423218EA37BCE7A@PH7PR11MB7643.namprd11.prod.outlook.com>
References: <PH7PR11MB7643280D48E45D2B660F5B6CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <ZOysbIihBA5ZMGc9@nam-dell>
 <PH7PR11MB7643DE405C5FBBE0B0E63313BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <ZO35mJ/9p3TrZiWv@nam-dell>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO35mJ/9p3TrZiWv@nam-dell>
From:   <ozlinux@hotmail.com>
X-TMN:  [k4dQpwTh3ViAMteb6ezWED/9pYwpDPW4D8YdtA6VB0VY5nHGjBcupywHBfmTgw26]
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <5izfqzd5o2qbrn5rfpmipj3yld7cpgrawk2sxai23xcgwqihht@q7zqwzg4dwod>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|DS0PR11MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 4447a5d5-8cf1-461d-4a3a-08dba89f0450
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U63dSrpIHbYgh6HLIpMCv4yVKkQCqxgv3Ld8wTY6KkpdRO80lvsmgoOdeBs7KeNd28rAXT8q7pjHxIkzMCEsUoDj4I1d+MQ5ldK6bqXUqoKR+kxlxV5ygYeXDnh5fFyvIYOfb9K/Qaj0L5S6FAp+Sw11pPULd/Frs0lKLjj+pbKSUYDEQM7wdij85nGGHl3rgDtaMwTdavRXx5kUExxj7bB/u7iZrgieUz6WcdlvBbTLpKh+pAvIG5+1Qm0+PoBqIlWPm2tCdEC6PRzH+52KElglkZSNOQEJ4nx76sePbp4mNIPZvGFf7F85bO2Fj5+hISC/wGaTaAXMQSB/CjU42PlfYugKVkNNHAmigKUT6bl2GqbnfCwxl+O1bYN66UsSEhXStTvFNleENUzMFR82qKX6nbciTvzfkc0Icv/b6xdlxnUWtGf7gFjmKe374wkMIQuuYTx1yYdn1YEYShlYybo1GiHs0q4S2t+As8zlO7SAw3M41PBbsUkN63Po1YsfxCfLCTiyHw5lSt75Gw+79xPTXXNyHMSsW6xeYL6bByQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBWFyE68jlzDb72oIU9EabJF75idgYFxVbjyBGtysnAG0L9+TXGupUvLwCpC?=
 =?us-ascii?Q?lrXda3C3CS9cccWJDDK+cguU8oqkRA4x7+pwqxSu58s8rMsoTom050lgNltN?=
 =?us-ascii?Q?yww/7lAAT9T1eozZrmX3ehDBDpD8UBi1z4QvQxcIS5+Ba6GCB11gxyMyEsHM?=
 =?us-ascii?Q?6A4LJvtBvtekUWTCjBjNxbkpHnk8GpVhTYWcpRgNP8f+EnMcV8OfVAkUmxU6?=
 =?us-ascii?Q?6ZG2IGKhLE1OlNlZspPNn+3Vz+LYIcp3Yr/OWHErK71bL///iY4U9HvV5kLy?=
 =?us-ascii?Q?zJMsF9KQH67aNmHUIjOICoQoUTisTmd8i3N6pBV05z3SPgPUxFFYjGgpZL5f?=
 =?us-ascii?Q?Y6Fl7FdyGbj7pU0DHhm4IBXWa6yJdWL5JruO+SAu7ZUF+Vgkv6pCTULc0jJ/?=
 =?us-ascii?Q?ge5FmucX5ChcFNlcU6cVsHHVCmpxOrnvht54yErR3b4iPWcS45LAeHc6TiO1?=
 =?us-ascii?Q?qQzptCi4mjkCQmDLHselKjubMxW0A9vLza+sp+FK4dT9vKDqdLmK5wMFaP2s?=
 =?us-ascii?Q?H0IhqSt/jkL9h7NHUyFH3AGRFeeSHQG5+fSB7cktSoFPE+RIDIEe3Y7/7FpR?=
 =?us-ascii?Q?keFoQlUmrb2twPi9J7dXQRQuU9nymRNGQ5pssdv1D8ILsmF/ZuFD3jFac8Li?=
 =?us-ascii?Q?ZxsF+NmqvgS2Q6Lyx4c8f7YVnWNNYcSUsPUNxYZwT2y8GDVxAkodZGh344hy?=
 =?us-ascii?Q?29ypqlSspy2ZnC0b/rzagh08eoSAKxVu2MiDh1iv5DHlHz0rQJ6QxFiBwMtv?=
 =?us-ascii?Q?6kx1SMHKwgwgg/KFsPzzObJEX7GfS6Rlc5VmNZDmeHWUX8NOMbdLqEEqLESe?=
 =?us-ascii?Q?uhRnBfekHXOFMvTX1TpHe6uZE1lUlsPHeQnr3gFD9SoywBYogn1Q3tSjStfH?=
 =?us-ascii?Q?t5bRBgd3a/SCisFR2vh/fHCYGzXEShM7CHYVNb0mfVOQBJ5hJzbajJue84jz?=
 =?us-ascii?Q?JEJVdkLF1QtjbDqGFPB0dL6zClb2rpeP076HbdPwf2aVduMBFGBDkq+mSTwe?=
 =?us-ascii?Q?aLmXZzw5lOj20rY9rq2Xq02tsvHC2R65o/bUT/leFv7IWJAnCWMi0Cd2rpOS?=
 =?us-ascii?Q?WpL6+eFdKxfHwfLSTG5jO6GLh4gqyhhp65IybqT2xtGq2g52sf5lxTWuDCsu?=
 =?us-ascii?Q?DSgqzie5aTK5GiW7B2waCxVijVF6+HsJxn8s8ieLUkQ7u2N554GSkNufWl9T?=
 =?us-ascii?Q?p+gR7xFE2vBOH1iEzMyYjQzTVunbPnCykSWxSvcK+F762P2ak7TpnXsFwtC/?=
 =?us-ascii?Q?J+0bRs8egaXhwpNm8v1u/Rf/2DxRKUaeKyF1O3vDlw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4447a5d5-8cf1-461d-4a3a-08dba89f0450
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:48:33.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:58:48PM +0200, Nam Cao wrote:
> On Mon, Aug 28, 2023 at 10:44:42AM -0400, ozlinux@hotmail.com wrote:
> > On Mon, Aug 28, 2023 at 04:17:16PM +0200, Nam Cao wrote:
> > > On Mon, Aug 28, 2023 at 09:39:13AM -0400, Oliver Crumrine wrote:
> > > > Make the octeon ethernet driver better conform to the linux kernel coding standards
> > > > 
> > > > Oliver Crumrine (6):
> > > >   staging: octeon: clean up the octeon ethernet driver
> > > >   staging: octeon: clean up the octeon ethernet driver
> > > >   staging: octeon: clean up the octeon ethernet driver
> > > >   staging: octeon: clean up the octeon ethernet driver
> > > >   staging: octeon: clean up the octeon ethernet driver
> > > >   staging: octeon: clean up the octeon ethernet driver
> > > > 
> > > >  drivers/staging/octeon/ethernet.c     |  6 ++--
> > > >  drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
> > > >  2 files changed, 28 insertions(+), 28 deletions(-)
> > > > 
> > > > -- 
> > > > 2.39.3
> > > >
> > > 
> > > The patches themselves should also be sent with this cover letter. Instead they
> > > are sent in a different thread :(
> > > 
> > > Best regards,
> > > Nam 
> > 
> > Looking at the what I sent, all the patches should be in reply to 
> > <cover.1693229582.git.ozlinux@hotmail.com>, both according to the patch
> > that was created by git format-patch, and Outlook. If in-reply-to and
> > the thread are 2 different things, please let me know, and instruct me on 
> > how I should put the patches in the same thread.
> 
> (keep in mind I know little of emails, I am just guessing here)
> 
> It seems that your email client or email provider changed your message ID. See:
> https://lore.kernel.org/linux-staging/PH7PR11MB7643280D48E45D2B660F5B6CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com/raw
> that "Message-ID" is not what git-format patch generates. Your original email
> ID is instead in "X-Microsoft-Original-Message-ID". So your patches have
> "In-Reply-To" that refers to an ID that has been removed, so the email thread
> is broken.
> 
> So perhaps try to change your email settings to stop this from happening, or
> change your email client / email provider.
> 
> If you figure out what is the problem, consider sending a patch to
> Documentation/process/email-clients.rst documenting this.
> 
> Best regards,
> Nam

Okay, makes sense. I'll try to figure out what Microsoft is doing to
my email.

Oliver
