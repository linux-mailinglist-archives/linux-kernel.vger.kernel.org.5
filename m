Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6A78B375
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjH1OpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjH1Oov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:44:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2018.outbound.protection.outlook.com [40.92.46.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4B9CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWdrt9D0hT8JvhziB/NITVVCWH0UG/L8xracHj4YvaKQ+4DKiSy85MaDnTGNabrEdraamERmqpxCc1of+sdQAZjeH7H6i+InqUbL/wlUu85vr+eaU7jZcVswjUNLCTGUHyMiqhKA3EBq4SpIRAhFBUAkOLlmeNgWO51HPCwjZirXxiZqO82OO9mSIzts9e8EnL7ZznvUZmc2wQUDbtZbn2VLEELdlN05W7HFUvv0UtQ5/XNZxKNBw3He6hOoNZi2m0Ta4V7XmMWaIJ6deZDf/Wrlh12IAbGcukJVLtXU4E4No2Gl3C36fZS9Li4Ggy3l3V75SSusm7ZvggSjJ5XwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZawRMBisfDODoyt3KrLauFPVApI8tgS6N7jQs04aUg=;
 b=F9IbRr9RYbcW9kksZvqErUicSoaqBk3Ob1j78c0p6WQICpRAEvPeYtXwFPOHVJKM95Kg3LPiYdumkZhszme3JGS/Fr8Axlv0Z6fhLogxfOp+WLDygefEUEwDdNk28kpKVjTHiWJGfUwdPw2JMvoVZCb1Ou+IIZbyNkbi0ImUo9pK4dtA9aMnpuHOivkOzpw8stbqUI7xvQyvBvzgFeoAbCUudBTQiNL7035dGH81Dno4vDipxVZbVuAY7YyNNoBuEw33v7GQ7ByXQGMhZtgxJmFEOzAS6y3kALl/mhA6q0uVWhNQgV80i0muCjTE45ZQl8GSedRQdnb3wy01+hi4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZawRMBisfDODoyt3KrLauFPVApI8tgS6N7jQs04aUg=;
 b=ZlEKgEuBR6ftmdd1uVgScr0jyoKYhK4aJ/6VWOsnN4/hkuKLAnqzkyvo6pKdFe7Y31tDJaaEHNq3ehLMpJhxhwDfJQDwvHebFGH+2fefnPTUuEXe631zQm9Bu0J2yYzwwdxPLzP05F2Bwoodggrh+Io30ODpxxyuyN9Fu9IhomGgFRqaHYoswSljKoN3XUjWRDF+MTpvwtBjs907nu92hNQz0hP2mqfzX3R8nINHJY/+2dXWUEEN+N8hc4uDJRvT8DbIyNVTDGzMnsIqDF9IfZaGwV4YeZcbka2y8lZr917B2qHb0AiMXUogsFy36fN1KT4OFQEUczw2LacqEk0QEQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by PH0PR11MB5660.namprd11.prod.outlook.com (2603:10b6:510:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:44:46 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:44:46 +0000
Date:   Mon, 28 Aug 2023 10:44:42 -0400
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4 0/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <PH7PR11MB7643DE405C5FBBE0B0E63313BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
References: <PH7PR11MB7643280D48E45D2B660F5B6CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <ZOysbIihBA5ZMGc9@nam-dell>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOysbIihBA5ZMGc9@nam-dell>
From:   <ozlinux@hotmail.com>
X-TMN:  [uHWrq4bpLS5JHnQNCec6qcMB/MVpwY/NNF6hc+zfbORLyCMo52NG3CR00VtoK6sh]
X-ClientProxiedBy: BL1PR13CA0377.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::22) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <m4wcaburryjfkpwhqwq2nwaerlboezvvw2lrnblv3ns6vqgwhm@r42eo7epmtzg>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|PH0PR11MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 949b8fe9-5038-45d9-02de-08dba7d55280
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/KTUxKYJQHTbBou0yhOra5YraoCD5CV4Zhm5UxbJkDeLdzbVovcAiQdLAMavnY/NmudK6SlApqUb1VlCURzIDTXfREq9QGAGsa8lMdMhCc87T+XCu+QHCwhCNRMhWAD2lRcVW1ZSz7roXGpnmIgZzac5zXK8Dt9qsdmPhMYHi9EhIcfGE2yv5W8mHJvo9EWh3YnsUoJzOHcG2hdFE4MPnbhuwu15Sg6yuvtZOMaEx6qlDB5jc42KdfbMejmgV4c5oaTmk4tI2Su7NDFLiFxwzxd1FYHa2Qq8/ObZ+Uoks5TWyJJkNNPwkv+oeu+I2bPdrlwNIjkGZoTRet9rTQMQGVBLvEj1TJ4uTdFSjNtNq+6fydJ1F8a3HMZrAKbCLwSymONaQGWNrldwvRl3M3cFJY2BVyCLDoCFkAI77Yc5ETkndzOhf2wNEpoaFYbMWaDlSmC0TUr/pRn2LbzBUHDpZ8SaQznDO2zYQuci4B0LN2MSvhvVp+9w/AX2mY4j+MF2FPxNQ2qJ2SsexH00+JuYVL3A1XtfBYMksxeYU+mGh0i2+PnvvIGQAcQmKQDcGK0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?raUu8qHQLNiLBmWCpwS93KsdlOU2u2k1EH7hKJsfVwAp0D/ippqZZLKmYpLR?=
 =?us-ascii?Q?GcQcrCAVpfZqzt/mvxviQXRX+qBc/kZsmhJ1cweSrXcVqtmc0yoJvOT418br?=
 =?us-ascii?Q?q1sEJ4Xc72cidpLYlWNwWqvju2vaowff+DuogQi4IbXp1EuGGZLqJyRIvVED?=
 =?us-ascii?Q?eNNp/SXvo/E/XUrGpVSWjrPWZUA7X3H//cJRIGGrtiPTPvZGMbre4C0wUOxO?=
 =?us-ascii?Q?6rMipZln49d79u3C/b42TDHVQT//ORaEDmI72QRocU7NmCu8vyxeryT5Ij4B?=
 =?us-ascii?Q?gP9U+UYi1KFB2VN8xbeB44dNrhyGlDsrdSBHh+dm+WO+FmdKI9f1zr/+tt7r?=
 =?us-ascii?Q?7PwpboL2smZJgS03Gn6ZKAZ3xGmL50iNwAt3nPJvENCRAZRgN1rHZXCfOTlt?=
 =?us-ascii?Q?ZRXEThax7NGirPEN5RsjgafKSdvpXLnIDrZqdoRiT/w1Ib9iy7+2EiYdRpRv?=
 =?us-ascii?Q?x6OzrimjpROMTSFqwP716Kh9SdeRGp1rBsC1PPBXUoU3bCCBezDjgp7w6rVN?=
 =?us-ascii?Q?GcUYtMw+VgWNPZufLZETRaBrP2hIKqBdu28ls+H5onDolEqFCEMToMkhx8ZY?=
 =?us-ascii?Q?J+87R2D5C0jhszhnYLS+5jIYQmHt1kv30+aEGarimMfh3FjZoZs7guurSU8C?=
 =?us-ascii?Q?M4kd+CIWn8vHoQMZEe9+q0D9EDMfJD4JgziBX9cpX8H/t0m3xT8J0gIMzO4t?=
 =?us-ascii?Q?jHVTM0ZIRdh4znP2T/buzt1aOYD2T5wGSfe77+gosm9I/YYu6fn0dcsoYspm?=
 =?us-ascii?Q?qW7uyktmrcGN7NdbYS1Bwlo0ZGrTwdaPaIKGnnKzoFC2U+4H6hvlDXuCyfgC?=
 =?us-ascii?Q?0dpOLdQLBK4FgOk91otCf+uGoko9r79pxHzCfJbs3u0dIi8Pwna3NY5M9mV3?=
 =?us-ascii?Q?dt8Lqiklc3KdCP1RhF1EqqXzzorlL1Qmh4M1+MMqem64vQnrfSkpaXp3jYmh?=
 =?us-ascii?Q?+kT2M8G02hP6m5nqkbb8FehiNtJqCo+Aq3YBvnLshHp8KyutOUCq0i3vkvwb?=
 =?us-ascii?Q?TH0LYN4DyLrW8TCLzXt05BxDFOliPe51OHMumuBwAJW5r4G80VSotTRcaLO9?=
 =?us-ascii?Q?xBdc7QZ7YkZhbj1q1osWvWo4S4Yg9xBioa/xEVtHV5lbaEbrtzmEIJKNGWo6?=
 =?us-ascii?Q?u55O2V0hav6OGSr09uqXRyBxfDQpmgf2JRvmpwL3qEtSEfbL3ELCj/NoePZY?=
 =?us-ascii?Q?oBMkEv/lTjEbQ2wZnk1t+Fr1KW1OVnBS+cHS++RVvgk9DMdKRLblrQVul8vI?=
 =?us-ascii?Q?+L2oqfGSnW2LHlms8YT2PGKV2U/CDRU+SrrMnU4e0w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 949b8fe9-5038-45d9-02de-08dba7d55280
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:44:46.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5660
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:17:16PM +0200, Nam Cao wrote:
> On Mon, Aug 28, 2023 at 09:39:13AM -0400, Oliver Crumrine wrote:
> > Make the octeon ethernet driver better conform to the linux kernel coding standards
> > 
> > Oliver Crumrine (6):
> >   staging: octeon: clean up the octeon ethernet driver
> >   staging: octeon: clean up the octeon ethernet driver
> >   staging: octeon: clean up the octeon ethernet driver
> >   staging: octeon: clean up the octeon ethernet driver
> >   staging: octeon: clean up the octeon ethernet driver
> >   staging: octeon: clean up the octeon ethernet driver
> > 
> >  drivers/staging/octeon/ethernet.c     |  6 ++--
> >  drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
> >  2 files changed, 28 insertions(+), 28 deletions(-)
> > 
> > -- 
> > 2.39.3
> >
> 
> The patches themselves should also be sent with this cover letter. Instead they
> are sent in a different thread :(
> 
> Best regards,
> Nam 

Looking at the what I sent, all the patches should be in reply to 
<cover.1693229582.git.ozlinux@hotmail.com>, both according to the patch
that was created by git format-patch, and Outlook. If in-reply-to and
the thread are 2 different things, please let me know, and instruct me on 
how I should put the patches in the same thread. 

As per your second email, I will be more specific in my description for
each patch.

As per your third email, I will make sure to invert the changelog.

Thanks for all the feedback, 
Oliver
