Return-Path: <linux-kernel+bounces-23025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4DB82A673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF52C1F2413F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20347ED4;
	Thu, 11 Jan 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mHx2qKp5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E916AA1;
	Thu, 11 Jan 2024 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnmV6pwonTKpaLax4jFyW5BhDFzUYhk6kUxAN5r8/2F1eZiQdzzLXwfZ2JpdxnWBhbgS5QmAHAxomQvRhxdtxUSm6cQFFDhQy6G5GnTNWWT/+42NMJJ4x+VdaCEKiG0z3vf8lOdwhDVSgsQ8t2nmxu6B+DuYEXYu3UWJabgOfTlfE0tr4qWnzb4DBfgMCj4o2GFQv6mIf/G0pfkYAu+xlrCyiAnBkFF7bI/Tre84tl73Osg7GSJPskAy2jZKfzL7sVXCac8zYHdhlpv/W14xB0kFBy4xJUs+0f+ousTRY+UjRbo3Vp/A81uEPg77NN+RLJmXKazcx0zA8TEUvMPokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBFNA6Mgj38H997TbHgp9Ma4WJujpsG8oTyz51NEbcY=;
 b=P1Wo/IMOvKuz19U4Sm8pvW8kxIbydb4vXUhtrKelCmddJ8MtRjLPqqjnfB5Mvui5FicqUzYo8+eWc83W8aun3aESCBDJakH78CInT7x753jUTf59xtG2rhQg1kkpqyejR+YyghTY9net7DLkJXvHyMr7rIQtqYFIgjl7M58W2wmjmVdB9IyitHz6gJs1jUKHreZmvgz9FgU/FJiR+vKP8Qt5itBsdo2fudS5GTlxrtb1NibSFFYHs+sDY4txHnkf3IQo2jmF5LkqUHAwWWg6Sz1XvjH1BKFJrOdSFGygoRK2faFKEx+AAXYFTWu/Yc/wFljqkm6QbBMHGJdCGIKe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBFNA6Mgj38H997TbHgp9Ma4WJujpsG8oTyz51NEbcY=;
 b=mHx2qKp5DoDM2B09YPGbA/sIvWVTnopwBfpGZ0V8m1oGoElsGMkFAmV3gzidtvFlGLFQi+EYxUR4g7nMNQQcihJo8h7cT6PBgfTHGpN66TwPiynfnDDgvOHwg+0YxXYUsr5iS7hI1OmsnU1q1wgBbp92GlKHSaMs1/DCd0tm+J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 03:25:37 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::9b8e:816d:20b9:9845]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::9b8e:816d:20b9:9845%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 03:25:37 +0000
Date: Thu, 11 Jan 2024 11:25:18 +0800
From: Huang Rui <ray.huang@amd.com>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Erwan Velu <e.velu@criteo.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Adding Zen4 support in
 introduction
Message-ID: <ZZ9fntJX4bTDK46b@amd.com>
References: <20240109175844.448006-1-e.velu@criteo.com>
 <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
 <ZZ7RnYy1xINapcSC@amd.com>
 <CAL2Jzuzq-HVnhGZ8W0bSH6xibpYWXdXc30kC1Ub4vESfc4w7xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL2Jzuzq-HVnhGZ8W0bSH6xibpYWXdXc30kC1Ub4vESfc4w7xA@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da8c340-a40a-4fb7-0a1a-08dc1254fa98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8sMKtASF8FV+8yyRlAmM7RCA6PcNgp4PCFQCeyO0bfihywNu6CasLXR8PZ+ZVQmFvnYOf/yJhuiN2RMr5/6YcT9/HFU2d4ocmDfKAmKNUaX+hiwfw+LjOSkzRdSVFdH6Bpu4XrgeiQhSVOarZ5gzZUtNUQKdiIKwhBcxANeiM/dwMsWCkN6/dM436NnEQzyDuYkwA7l6zjJr4ibobotEQxfG0id3AZRjGWJymx7B7BJv5RhZJH+0KGvJauSgRNHRDBBEJFb8OnoH4rvqHKDIfkWoYMoJuDSDRJNfXr5njb0/BE2bspzH3y0WrOa7hqS4BWXHtW/rtXsjHkuCqz1rzbgdUcV4ow6ja2NJzxmTZjktPw+eyMhtBWAJ+yhMwTJVsn7vaygyW1i3dEXmRsJ4NPZsPcbxtyrX6lRvVp3YamiEKJuebm9KDFLUpIjm3RTVrusvfGuCSKj1TXHQyWluzX8xiwUSDSMp/0Luo6hA5J0Gr6foeEWuD0Ys1YSeGVUL+6L0pKpErxufr/D8CLQUSgYe0csgdkRxz+EthwHjzFw1oo5uT85aQ7U8LnZvCm3T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(53546011)(6506007)(6512007)(2906002)(2616005)(38100700002)(66574015)(5660300002)(4326008)(8676002)(8936002)(478600001)(6916009)(66556008)(6486002)(66476007)(54906003)(316002)(6666004)(41300700001)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDg0YWtWdkVYckdKblEwcWpDd1pkZWpaSnVIUkh1VjRCUXQ5QkJzeGVYUlV6?=
 =?utf-8?B?bG4va2ZvZ3ZlZDluMGRuZFZzZ2JNSythU1c3Z0FlTTdHZnhrbUFXRTNwWkpZ?=
 =?utf-8?B?N1pHRTV0TVBLME15WUE0T25GM21jKytHNUNNc3ZrNStwN3VRRE5DL1MyQ3JM?=
 =?utf-8?B?bnRZQXhJRG5mZXJzZGN2UThyNHBzMERSRitrbVJkUy9vS0pjVjYzNVJpc2xE?=
 =?utf-8?B?UUszbG5JVVV1WlAvc2h2a3c5Ukhmc2MyYjBOdDhTSnJVejhlcWNSeGZSRUpn?=
 =?utf-8?B?ckFzd2FreG8vWldmaEJkL1MrK1hIcHdBOUlrT0l5MlBldmFBRGozZ2hpaS9j?=
 =?utf-8?B?R2VRbnJVMWhpWnpkcWlhVkRkWjhXR2VtRUpwUVZTV0hoaWl2c2ZRME0rVERj?=
 =?utf-8?B?ZmxpK2VIMFUzRTd4VFZ6R3czV3lyTktyWlRWY3l4VitEY0xhWmYzZ3lHN3N5?=
 =?utf-8?B?K3NoM2owQzRVejdqQURzaXNxTG8xZ3hzNE1nd290Mk1rQ1paK1hFdmZ4MUhS?=
 =?utf-8?B?Z1V0ZzBNVUFMa1FyS2FhdVd2YTdSU1dMTTlQUG5JTnpqTnBvRU0ySlplOVU3?=
 =?utf-8?B?S1VHUmJHd21DeUtiMEFpL3grRFNkOFYwNldwcEpjbCtmVzh6MHVCUm1oVUQ5?=
 =?utf-8?B?YVZvdjcwUG9XSElVMUdBNnBIL1NBZVJWQ2tUdndac1o5TFk4R09qRDJoTG1G?=
 =?utf-8?B?THpPSEtwekJYcjUybmhyc1lLTkFkSmQvTzBEVmxRZUNvYWg4ZnY4dGluSWY4?=
 =?utf-8?B?WEtPSzdKR0xKNDMyTDRxZjUwTlRzZ3NlRS95VjErTGh1Y1BpcERKZ2cyZlNL?=
 =?utf-8?B?TTdHZkkzVWN4VlVBbzFYaDJvZ1FIR1ZjalVKK25hRHJ6aTNic1ZsamJ4TndQ?=
 =?utf-8?B?MVROZ3Bma2pFOWwyTU5XazdlZmJKMk5yRUxKSEhRbWZOaFR2aGJlbjNNWVhh?=
 =?utf-8?B?cGxodm9kb1NibTU2UDBHMEtkZXlKK21zcExiZ1d2K2Y5Wm1vVzBUZEdhbjNn?=
 =?utf-8?B?NDkvdTQyRG0wZHBPcU5OajdkMjFGREpLMWNsU0FsYkJUeGM5bUc0YTJqTHJp?=
 =?utf-8?B?aWRRbm4xYk9xd29HVmJlTTUwNlIxUmVxSUo1Q2l2enJnVXZxYXVhNXM5allp?=
 =?utf-8?B?UUdOTWcycG45bzd2c2RJaFZFNDJUb2Z6K0VvTEZ6V09HaUlaNVlpcWdvaDlm?=
 =?utf-8?B?NGpDV1luSjdXV2F1a2FhWEtoNHZYWWV1Q0pNblBLenV0TnBoQTNMQ0pNc0ha?=
 =?utf-8?B?dVRSRWYwSU4vR3Z3M0QzdUZFUE02ckcxaXhnYTZ6RmUvZzBPQWJqWTFiaDB6?=
 =?utf-8?B?L1Z6U0hUaTJuRHN3bTJOMXQrT3JUZkJRWTNWOVlSK1ZCUFUwMzNadEpKbXFh?=
 =?utf-8?B?RERuNTRKOHk3ZE1TYzdaekwrbG1GZzgrWVU5WSt2YXZSbTVUQ3hjY0Fyd3Bs?=
 =?utf-8?B?SEppa09FY0k0SlhVT0hmZVRrbEhReE9ka1VvT2l5MklVdTAzRUhhby9HY1dM?=
 =?utf-8?B?Qm1QbVlUQndTNWRVU1pJN3lOaCtSWGltdVc0MnlONTEwWEliWlBlaHpSQm5y?=
 =?utf-8?B?ek1iT2hSeGV2S29ISXpXc2o2T2xCMU1Nek5OU1hIWUhXVDRvalJoZnkzVVli?=
 =?utf-8?B?L2t3Z1RCSHgyS0VmMzg3bnE5eWN0NW9HMUM4M05UQnp4QzJkSG84RGd1TGV3?=
 =?utf-8?B?K0QrNzNTbXlZTkJOZkFIcWxJanFjV0pkbThPNUhSWUlrWk9nbk5qbjhWQXZx?=
 =?utf-8?B?bWYwZ0lFMEtJNmF6VXBHRVl3MDFaTVlJd2NReEorQUIvU29keGk3RmVabFJU?=
 =?utf-8?B?RWMvcTM5djJ2bjUrUHZ3ZlF5Tjhla2FGcTRmQ01rRXo2Z1VxZlhHQm1SYkZm?=
 =?utf-8?B?WjBvT2ZRUjZpajVTckRVYU9hblVGalFPM3pIN1Mwa0krRkdXSEhiMW03QWpn?=
 =?utf-8?B?c2lRbCswdVQrVEd1L0duSGhSTTRSZ21VQWNrY3BsMnViWC80K2hXeUlnaERs?=
 =?utf-8?B?TW5seFB2SjArUzZId2twWDl2Uk9EL0Z5V3BtYWRoRUJ6VXdaUnVEQkxvM1dX?=
 =?utf-8?B?NHpjV2JnamVhd2RKcXY2TlBGcXh0WmczYVhST1dVNmJWeVkxWTlNWWVKbmk5?=
 =?utf-8?Q?nBUMguAL3bYklLkPSC4/KRCSf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da8c340-a40a-4fb7-0a1a-08dc1254fa98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 03:25:37.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs9uOM3R759l85ABtpCkDzgCTBEr1XnKZYANxdeqMZq2H9b6skfjafp5uMy/k8ukT/U64gzYXqjeVeaxmGU5FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

On Thu, Jan 11, 2024 at 01:49:27AM +0800, Erwan Velu wrote:
> > How about modifying here as "partial Zen2, Zen3, and future processors"?
> And all processors starting Zen4 ?

"partial Zen2 and all processors starting Zen3"

Thanks,
Ray

> 
> Le mer. 10 janv. 2024 à 18:19, Huang Rui <ray.huang@amd.com> a écrit :
> >
> > On Wed, Jan 10, 2024 at 10:21:20PM +0800, Rafael J. Wysocki wrote:
> > > On Tue, Jan 9, 2024 at 6:58 PM Erwan Velu <erwanaliasr1@gmail.com> wrote:
> > > >
> > > > amd-pstate is implemented on Zen4, adding this architecture in the
> > > > introduction.
> > > >
> > > > Signed-off-by: Erwan Velu <e.velu@criteo.com>
> > > > ---
> > > >  drivers/cpufreq/amd-pstate.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > > index 1f6186475715..9a8d083f6ba5 100644
> > > > --- a/drivers/cpufreq/amd-pstate.c
> > > > +++ b/drivers/cpufreq/amd-pstate.c
> > > > @@ -14,7 +14,7 @@
> > > >   * communicate the performance hints to hardware.
> > > >   *
> > > >   * AMD P-State is supported on recent AMD Zen base CPU series include some of
> > > > - * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI tables of AMD
> > > > + * Zen2, Zen3 and Zen4 processors. _CPC needs to be present in the ACPI tables of AMD
> > >
> > > IMO, it would be really nice to avoid extending this line so much, but
> > > this is up to the AMD people.
> >
> > Agree. Actually, we will use this driver for all future AMD CPU generations
> > that starts from paritial Zen2.
> >
> > >
> > > Also, while you are at it, "include" in the first sentence should be
> > > "including" and a new paragraph after "processors." would make this
> > > comment easier to follow from the logical standpoint, because the
> > > first sentence is about the supported platforms and the second one is
> > > about additional requirements (ie. something else).
> > >
> >
> > How about modifying here as "partial Zen2, Zen3, and future processors"?
> >
> > Thanks,
> > Ray
> >
> > > >   * P-State supported system. And there are two types of hardware implementations
> > > >   * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Solution.
> > > >   * X86_FEATURE_CPPC CPU feature flag is used to distinguish the different types.
> > > > --

