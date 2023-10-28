Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAA7DA483
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 02:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjJ1Asc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 20:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1Asa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 20:48:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2047.outbound.protection.outlook.com [40.92.91.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F1B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 17:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWOiHtz1qLr9YKcgAjd3nDrgkkRgFQwwFOCQ0/Obnleh0MvOuRp+YWhe663rkko2dFtMzf4XHBu4Qr8vGJP7pOXPl79/dci3+6DPan+IqlINRxoLp2eS3XHCiQsQ7dj4nq4V/ZEDBpOyR7HTl1qfUN5ZDBh76oeFRuQbs2unoFpdPI432988rr6wjf/aGXtGvs+avb4gqjsdFPAeSwL/glPqT4L58zJDK0hiFkGtqIKlkgBdZYBEFPHGmMwshdNbw6j+OOLmGtdx18JODKx8S29QgQOnOl5ohatFwDyZg4x7+iGPg2/C/Y5Z+jwvBjPpJ7DxVSrJ+SlbioLhxkcdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijryH2cwV593iFdnbobPQmBt3dXyq7smFv2RtMU1E1k=;
 b=Uyo93Vc/eaY/AlJy7rdA9WmU3+Pax3U33Bqeewzq6o5EX82Hmx3ep31HdMlDuLAAICOYyZXTQYvRh7/X01bbcxV4ZWu/E3d/Jf0YkkKah6iZocKK98hqOE6jDFKMHgwCjU9mWu9dF/t81K6lZ8PKtqTBNCWOZM5eCXipz1gVwY09nlNGa0mXNbx5ngi99sVythsCrvZedz7/QQO4WrM9mXlQNkmNPmT+AG4VFRT6MIp+Cg6GQxitWA8nXTpQtx3It7qnJsJ4gdcDt/SKXE6vRcUpHoByKyMiaWmb+A3DeigYdsMTfMg+93rKpeZUhqBiZsYhQkpcp9BbIzLQFYgZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijryH2cwV593iFdnbobPQmBt3dXyq7smFv2RtMU1E1k=;
 b=gyTavy1Q/jnE4Jh99lt7o/yrcv4B9V+7hSVFa7UDcb5RXTehBYUnUe8fVyzKdoWgY5ST4AIUiXWJsnCixi6wVtEoYB4UqdUI/3DBmgz92gBvrLwK0eOuYoKhrNrbIn/j2yHrV/jiKcorM7HJhrA9i8MEyfv3pH+ZI+PMvMauF4MMaU1vrOb7BwpT/UK5RUq5Oje3HP27ki15VaKwVeZhtYZB/7t1wwoEjZgd2iNZyrS6NOf5xRMNs2uOaUXeFVB5ka3nYgmpiG9eb/h/gL4Rxzjz/EUzvlVUqJa9F9rm++P7UiBjDfRm+AidBcli4qPvis2617KW0ENKZO+e/91zxA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.20; Sat, 28 Oct
 2023 00:48:25 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 00:48:24 +0000
Date:   Sat, 28 Oct 2023 06:18:15 +0530
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] drm/amdgpu: Fixes uninitialized variable usage in
 amdgpu_dm_setup_replay
Message-ID: <DB3PR10MB6835311E66539604DD442CBBE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB683590457246A6625BAA6102E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <dc2242cd-6522-4073-b376-edc2a9abc3d9@amd.com>
 <PH8PR12MB727953EE85D593EF25650454F9DCA@PH8PR12MB7279.namprd12.prod.outlook.com>
 <39ab34ec-209d-4176-b271-1a02e2976497@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39ab34ec-209d-4176-b271-1a02e2976497@amd.com>
X-TMN:  [gK1RKZMcW/dThrt6g92boikMWOPWyY+H]
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231028004815.GC1301832@nmj-network>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AM9PR10MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d9005c-cb18-42e1-0fd6-08dbd74f974e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Jeg0ZfJ2EErjrpHeGNySrxxCumlcZEyMNUHrKeVnlSIz6QFxU235asQqzrZx/d3WAorW9vQWG8snWobN2n5KcG3szhTQySbTInU/+Alb/c9TxsHD/uHgTM1jhkDejl1e9ANMeJXfBxbfrEk6sEaLx3ST72BNKPCJlfNZ2EBE5XGdX5AD/BmxZgHfzUAezr2p1jgkD6LwlujOvX7n0CjDwMsXNldm05UnSOoG2SU73QanDU7KWXTD6nha3Vk1jjkAHogCLw4y6bNqnL7nROev+kukI4hZ1B1O8bcCs9BnSIgkztVpTlo8jyqTU5+uAcfdlIAZw9CoqhJOiL+CP5BFBcDtoUUcQ+MGANXuDD1IXghrPT9xmyNXM4XyOXzMrWk29XSJIStmxFwkgxuBx3eYSGIQ1qHS8ghzcaC/EsESoWC/OxUErbHx7T70VvC2ZZVtOctlcV9O6o0WYwePWxgXa6kBzWzRwQdV/A7BOU+Y+rMVRTZ9qCUuJgnvECsZW/8K5hrAO9v8PQ93y6CnV+m2Mp/zkivoYWl0ATMVpWswZqOsQvfZYHurAIPMFcYY6xP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3eTqngevDhFw7wFGaYdOeLtggo+nIAWADaBHxkZKu1Y3iHAkZE1nkkIenV?=
 =?iso-8859-1?Q?1vEycrQ23J5/grnxI8LDZraJ90vjC0mR8teioTkFUcUFd2UoDGnjIYh02k?=
 =?iso-8859-1?Q?UMuhrOXQbOlflAwc+COCGgH6Npqf41Li5/Yr0PVkktEihyE8IHPZAsDTDT?=
 =?iso-8859-1?Q?Uzox1Uk2ME9MG8qG2MQ5T8lQ/YJDAwIwws6HuSl9eH/uYCWqSXbxj9P1Ek?=
 =?iso-8859-1?Q?vWSEWJYmOguLRidF0klXTejWR1HtS7YX3iVGTc7bsWk4yoCVVzQMUo9RMm?=
 =?iso-8859-1?Q?IuyFP14bxOTMROEDiIK5V15wW7zdxgGMyKrGwCWywkQzSzbhOMJHvkAUMO?=
 =?iso-8859-1?Q?eu2NEaJcgaOzROGIRgbJ9bMqkAfEKq2H+SmLQfjFlsGT/jLB83PlbXbDP7?=
 =?iso-8859-1?Q?YiABIh3Y1cBB3vHHWxn8BTMJmTPLdCvvZoX2ztOjyZdaXLpHgPslzX9W+5?=
 =?iso-8859-1?Q?x+HCeBCbydOaQpCZejrTo4DkB+DKyQGE0+kRpfrxyv320DWwBTbhTA8ADr?=
 =?iso-8859-1?Q?tiMicagJcM1Nru6pZ0bB252qdwdqzl1ZhvAmoSAZ5dSK+rDGLsFTIsM5eI?=
 =?iso-8859-1?Q?XiSwaU83x92cSnH2lYvaKsQSLlPm3xU3DRJkpnwy1y/23bTeBNIf/gB2Qs?=
 =?iso-8859-1?Q?PrFsgNncXK26tb0I5pJSxrANbbIiQc76lNSZjN98isQj6I71oubeup6Jii?=
 =?iso-8859-1?Q?WpW1wJWgyIBAkYUfuOZF577GfDMMDLjOJHKCAQe95+aH/iusZvLcOaSJbN?=
 =?iso-8859-1?Q?cNm/GYUTkztvNy5lHTOtwYknffhsHAh7LGCJZl0MKKOpM5KFghmIhZdHuw?=
 =?iso-8859-1?Q?N4q/TmKBEIm9eSYUxI41xE7BAVi4BiKbwTCRGGG6FadsB3sDeNqnoMhPir?=
 =?iso-8859-1?Q?DADdkGeRmvHgfo5zMD+zdGaujb8m3U+SIfxPLRY3SIWdR+0j5rCvIwUAfT?=
 =?iso-8859-1?Q?u8P+xiIOXu+/jfF4Z7qD04mgDWgMMavESTU/7q/8M6HKtcYkhKYgEYFsVC?=
 =?iso-8859-1?Q?mOPgvP0zjyZefvD5lYtI6D1DrT+QistTLe1aftg6a2l4JIUHFT2HuNG1Zt?=
 =?iso-8859-1?Q?OO5KGvKZg6iXQG2wz9S1Tq/T0KcqNoqCpUnuCdQlBg+xIYMgMZGt9Sxay6?=
 =?iso-8859-1?Q?R8MGeQGPd1XVS1tglR/t6ZOJfNStWsZJmxEyWv13vbmOhOPLn0EA0kFxzC?=
 =?iso-8859-1?Q?ciBts26ejuo+ULOUPjgtwSr176uS+NN/R1hKlPH+4yrZEwuAqQRK+ojjtP?=
 =?iso-8859-1?Q?eDV0U1wsqD8/eGxZEBSm2gpx48gPU9LhGiWm2yAbw=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d9005c-cb18-42e1-0fd6-08dbd74f974e
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 00:48:24.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4069
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Fri, Oct 27, 2023 at 11:57:45AM -0400, Hamza Mahfooz wrote:
> On 10/27/23 11:55, Lakha, Bhawanpreet wrote:
> > [AMD Official Use Only - General]
> > 
> > 
> > 
> > There was a consensus to use memset instead of {0}. I remember making
> > changes related to that previously.
> 
> Hm, seems like it's used rather consistently in the DM and in DC
> though.
> 
Have you decided which one should be used?

Should I submit a v2 patch using {0} instead of memset?


Yuran Pereira
> > 
> > Bhawan
> > 
> > ------------------------------------------------------------------------
> > *From:* Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> > *Sent:* October 27, 2023 11:53 AM
> > *To:* Yuran Pereira <yuran.pereira@hotmail.com>; airlied@gmail.com
> > <airlied@gmail.com>
> > *Cc:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet
> > <Bhawanpreet.Lakha@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Siqueira,
> > Rodrigo <Rodrigo.Siqueira@amd.com>; linux-kernel@vger.kernel.org
> > <linux-kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org
> > <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org
> > <dri-devel@lists.freedesktop.org>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>;
> > linux-kernel-mentees@lists.linuxfoundation.org
> > <linux-kernel-mentees@lists.linuxfoundation.org>
> > *Subject:* Re: [PATCH] drm/amdgpu: Fixes uninitialized variable usage in
> > amdgpu_dm_setup_replay
> > On 10/26/23 17:25, Yuran Pereira wrote:
> > > Since `pr_config` is not initialized after its declaration, the
> > > following operations with `replay_enable_option` may be performed
> > > when `replay_enable_option` is holding junk values which could
> > > possibly lead to undefined behaviour
> > > 
> > > ```
> > >       ...
> > >       pr_config.replay_enable_option |= pr_enable_option_static_screen;
> > >       ...
> > > 
> > >       if (!pr_config.replay_timing_sync_supported)
> > >           pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
> > >       ...
> > > ```
> > > 
> > > This patch initializes `pr_config` after its declaration to ensure that
> > > it doesn't contain junk data, and prevent any undefined behaviour
> > > 
> > > Addresses-Coverity-ID: 1544428 ("Uninitialized scalar variable")
> > > Fixes: dede1fea4460 ("drm/amd/display: Add Freesync Panel DM code")
> > > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > > ---
> > >    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c | 3 +++
> > >    1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> > > index 32d3086c4cb7..40526507f50b 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> > > @@ -23,6 +23,7 @@
> > >     *
> > >     */
> > > +#include <linux/string.h>
> > >    #include "amdgpu_dm_replay.h"
> > >    #include "dc.h"
> > >    #include "dm_helpers.h"
> > > @@ -74,6 +75,8 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
> > >         struct replay_config pr_config;
> > 
> > I would prefer setting pr_config = {0};
> > 
> > >         union replay_debug_flags *debug_flags = NULL;
> > > +     memset(&pr_config, 0, sizeof(pr_config));
> > > +
> > >         // For eDP, if Replay is supported, return true to skip checks
> > >         if (link->replay_settings.config.replay_supported)
> > >                 return true;
> > -- 
> > Hamza
> > 
> -- 
> Hamza
> 
