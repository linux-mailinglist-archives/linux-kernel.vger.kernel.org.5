Return-Path: <linux-kernel+bounces-22519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B735F829EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5FA1C22987
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259584CE1B;
	Wed, 10 Jan 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5nMxCzdt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DE4CDFE;
	Wed, 10 Jan 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKLt0cWI20zWMfU4+LlPJGFgQfbKDOf0Oyze9fMc0L3rnTRSilT9X3uLJsEpMrUnnyWnXaUMyJfb6yYQ2ZH6yIHSfd2zLjSQvVfJx176srR2GbybmiG8DsBWnDz9gYBP1hUNwgScNDdPGUCYnlGRAZe9f0TulWiAWIvzcLr1zKCF/XPHjijoZSqaf1F7t3kyJLl2VmUyNkV+mtnxVL3ehfjDD6O3l5TWT8q+iasrTlDkEJbR7UlcWpvkFbQsIVw5EtcmWj7dx44z74X6lnU2tKwvIHrPn5qniziyyOA5ITpQSVMUrEtuhFqBoc/7QkzoMqmuRgsWwlYxiBLf7nM6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMB0Qp+BXhNXehwVIdn7Dm8bnxsEXf1pmsJad5Mtv6Y=;
 b=MA3v1V/LmIGKI/OKMA32rJt4b8R86Fd4ZbNWiGbfORZ5CDQwVAqtxAIOwZp8eiEBQTrjNK1a17TXdsEm/PkZf9zCxH0Z/KlT/9vK7WH9UaQ+CrzZLZ+Ke7g/Dcz+eOhf3pz5gidseHDXHa10IsTEVNror1vGFLm74Z3KFAOLnKPAlknVCGo4wMIF9IjZT8hfpKMjVaM0a0RCsh0QeRhhKrT4Tz1lhmtjgEVyMC7MTxRyL3T+8tRNL+XLgSy1MhFQkER8igF9dZa1ERzbhRBgpN8/a/B6BwIHgt0LZ6JUuD51EDi8m3ugTO/elHJIc3SQO+mq8MICzdWXQSdIBfniDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMB0Qp+BXhNXehwVIdn7Dm8bnxsEXf1pmsJad5Mtv6Y=;
 b=5nMxCzdtvb0g5kkVjkEGvt5cNTcfBwg57SOXdh/0U8H2N0MQRvgnrP/StXYBiSOGeTwgOU8FrSEdaBlAyiaMPt0QIz1moQE8rPWiwF3Sw320nClWriOfpAl5kIGRqy/RK5RVdLIn84/0RM18sfqfvsjhv+54XDnGcNOx+nHFDVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:19:46 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::9b8e:816d:20b9:9845]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::9b8e:816d:20b9:9845%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:19:46 +0000
Date: Thu, 11 Jan 2024 01:19:25 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Adding Zen4 support in
 introduction
Message-ID: <ZZ7RnYy1xINapcSC@amd.com>
References: <20240109175844.448006-1-e.velu@criteo.com>
 <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db2b178-26ec-4e51-4bdf-08dc12005789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vvIxaRw8EvzuaL1Wf+tnpcRytLo8fd3KQOGyOEX/cDLrXwSs/m2U/2f84oRoHo6qlcAu94RBTSbquv5IRWZf2UVcLpk/yxz3HQsSYxSRImVZP/Px12FB9lMccVkDT2i5LCmKUWI5QxK1hjZYQ7h5xrgKbemSqBmtr+jpriEPNDI3bCzT0A87+/B8n2hMQydRD6NBILmnSL58MpD9yX9kQmUJzQ5Q1SfoRXV5lnNWAyscJZsAYxZoCatLU44LC+tSTeLnp+1nbzveNZnhsfh7tLyDJLErbwdUhetTctIOYIyM1w9ZzQ+/V5aj8OkauszNog8krL5RqLzA7MhZEFU+4lAuoEm035SBiJVX35q9OVlPo9GYZUoNODo+ybgIxJmT28ZgeJG3hngvc5s1N5jnVORvXJ0Te0MSHJThLGpdijevPz8GoynnISwupo01u2YhRbj12nlDyHgjWWIj+XyC4G+MTujEvKhrH0Hn36jfF02ce5x55kUtHoTOw/EFi2gqUtnD03hsB3QwBKmFYRDALGJhSgOTJSLuS0qs39HLWDn62agt4hSzUySUL7eDqVJb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(4326008)(478600001)(8676002)(6486002)(8936002)(66556008)(66946007)(316002)(110136005)(66476007)(54906003)(83380400001)(6512007)(6666004)(53546011)(2616005)(6506007)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3U2Y2xxOE9CNzVQbjVnWE9vc2Y5OVZUOVRCbzFuVTZaVzRKaG90QWtvMzQ5?=
 =?utf-8?B?QlVFZElUWFU2WXByakhEQk1paXFtTFhKK1hyc3N0NVFhcHBLYnV5TlRZckxV?=
 =?utf-8?B?cHZqMWVoWUFkYnRFOU0ybWZiYVB4SXZ4RUxuT1UwZ2s5S3dVNFJuUGtNWkpl?=
 =?utf-8?B?YkJmd0wwY3VRRWhYVkg5SkFJN2xDUFhZZFdhS3ExOHBjY3BNRWVsWjZ5aktm?=
 =?utf-8?B?ZWE3TUVaRzJhM2xsMHE4UUsvTThEWjk0WS9uRWZhdUhEdWM5RGtjdU9OOFZy?=
 =?utf-8?B?ekhsbkw4eW1raFBNeHd6cEErV09nSk50SnFpOVpiZmhsY1YwQ3NLZzU2dWdi?=
 =?utf-8?B?ZlZNS2xLUTFVY3lDRWlRVlZVa2NJWEhiQ1loaXd2a1NxZUVsdVhYOXROVmgy?=
 =?utf-8?B?TG0xNk5uL0pGTlFpNHNTWXZnNTNQR3gyd2J4cm4zVEMvZWpSS0hGWlN5akY5?=
 =?utf-8?B?V0VJRm5kMm5rUlZpdm9vZjA3NGJvc20rZ1lLMG00MUkyWmhsWmFnT3paOGRs?=
 =?utf-8?B?Ulh2NXdTQTlGQkVvc0c0Q3lPK2I3QTZwRlB5TU1yTmhNMW80R080VUdIc3J5?=
 =?utf-8?B?cU5zdWNjSnF5TzlQcGlKaFlNVzEvWFhmSFFyMEtDUy9NaTlNaUtSNlFxdEgr?=
 =?utf-8?B?TUFsbzBzdEczaTRNU0QyRDk5U2V4YVJSVm1rcElEZzhIdUY1U1FtVmJGNWpp?=
 =?utf-8?B?ay9PTkhqNmdlVUQwNlhBTng2cVRkZkNpZkh2dVZYSlNoTStjaGluUXJnSjZ2?=
 =?utf-8?B?U3Z5KzVOa2hpYndDdzhtS3p1V1UwcHVkK1YxaEJOWTdkY3MvVzZsbnJzUlNR?=
 =?utf-8?B?TllEY1hTa1VubGthbjd3ZGJKUHFXSmdwSGtXVlZBdWY2Tm1nZHdhNjJMang5?=
 =?utf-8?B?cmp1aS9lcjUraGdpRTN6ZEplaVA4V0F5VnRTMXFQVFNtU21MTFFNNHQxL3Bw?=
 =?utf-8?B?SERPS1ZIYnNqZm9QVm5BWTZsNnpHQmdOaVh1amx1dGFuRzZYWDdUbzZiSTha?=
 =?utf-8?B?SXhDZThxUGVmS2JDdlhUVXN6TXpPcEpXcHV1Z284NmhNVytUWXhMdDA4VElL?=
 =?utf-8?B?WVVOM2UxN1FGdVV3TUNaWVVXdDNCZkJyb3ZMZTNvYytQNEhheGdOcnRRbjJn?=
 =?utf-8?B?cm11VExncTJaT09vYVVQVTR5ZFRLZUU4U0ZwQTJGMXU1MjRZN2JMZ2lsUDNq?=
 =?utf-8?B?OGljU2xDeDNpK3RtTGxwVjlhR0ZSQXJPVWx1WjRibFpYQVQwMFM3S1k0VTVi?=
 =?utf-8?B?bEdEQ3lQY3FzLzA3cDlCWFRidnd6dzhaTTJGU29Sa29weCtpZ2x1MzBuWkxH?=
 =?utf-8?B?UnBNVzFKa0QzWVVlTE85VXFmaGZpZVpiSHcrdmVYZDhLVGpUak5Oei94UHpY?=
 =?utf-8?B?dFJRejFBTGNiYTVKZmRPQ1gzN0xnQncwMlBNK0FWTFVJMVJ0OTNtb21hSjB4?=
 =?utf-8?B?ZVVrOUZhakoySU9uRmZteU5sUHd5WVdTV3B6RCtBZG5kQUczb0RDeTRpSjlL?=
 =?utf-8?B?OWNWZy9RMHFxcFVBeS9TNGdSR1JLY1Z5dWM0L0l2NW1YUHdSUmc4cW5KZEJu?=
 =?utf-8?B?V3k3b3d2b0pEclpuSkcraUh1ZlFrNGdhMzRsS0lEOUo3VzBEQS9jOFJZYVZB?=
 =?utf-8?B?aEZHbkdlY2VXR0NGOGFIWGNKOTlHYlViWVljN2NDZVpxRU9peWpNenlPZjJN?=
 =?utf-8?B?N0FuNm8wL0tOYmJMa1E1U1BoZ1lIZS8zdlo0UU9TNUpzYkN0SVNuc3M5S25L?=
 =?utf-8?B?cnpScGFmR240M3RYNWp6bEtVWDlHOHdldEpLaHNtRElsUHBrdElwVFlhQ2M1?=
 =?utf-8?B?NS9IeG1zWTlUTE9qamhJWTlndXZPZVdFUE5Jc2lubDRQNkIzWVV3YWZGNXdu?=
 =?utf-8?B?cDJzcDdMcmhoUmVwa1gzYzRCVW53ZVFvSm9LM2liTmdSY0VkWk43SWRnMFZD?=
 =?utf-8?B?R2lzczYzT2l3VmloM29hNFR1MUNYVi85VC9MbTNPRCtkV0Z5c05kcnhoeHdo?=
 =?utf-8?B?NUVPSUNubm40N1EyQ2trM2Jod0VVUGtzRktMQUtBQkkrN1dnU1k5RVVET3pp?=
 =?utf-8?B?ZzVKZE12NkpNRXBpbjlxbDI1UEZ4TDVXVG01enltdXJOTzJKbTV1ZEJNZGU5?=
 =?utf-8?Q?3EKS6xgaxpgdxLCyFwjJBspMf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db2b178-26ec-4e51-4bdf-08dc12005789
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:19:45.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXHTvlZ2PS0X3ErgD4gJFKy0XFkYxQkd11zoCmgiBe2aTRrv/C9ynlSCOnOjTvOYj8u6NipNLoDsp0hP5T5QSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

On Wed, Jan 10, 2024 at 10:21:20PM +0800, Rafael J. Wysocki wrote:
> On Tue, Jan 9, 2024 at 6:58 PM Erwan Velu <erwanaliasr1@gmail.com> wrote:
> >
> > amd-pstate is implemented on Zen4, adding this architecture in the
> > introduction.
> >
> > Signed-off-by: Erwan Velu <e.velu@criteo.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 1f6186475715..9a8d083f6ba5 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -14,7 +14,7 @@
> >   * communicate the performance hints to hardware.
> >   *
> >   * AMD P-State is supported on recent AMD Zen base CPU series include some of
> > - * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI tables of AMD
> > + * Zen2, Zen3 and Zen4 processors. _CPC needs to be present in the ACPI tables of AMD
> 
> IMO, it would be really nice to avoid extending this line so much, but
> this is up to the AMD people.

Agree. Actually, we will use this driver for all future AMD CPU generations
that starts from paritial Zen2.

> 
> Also, while you are at it, "include" in the first sentence should be
> "including" and a new paragraph after "processors." would make this
> comment easier to follow from the logical standpoint, because the
> first sentence is about the supported platforms and the second one is
> about additional requirements (ie. something else).
> 

How about modifying here as "partial Zen2, Zen3, and future processors"?

Thanks,
Ray

> >   * P-State supported system. And there are two types of hardware implementations
> >   * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Solution.
> >   * X86_FEATURE_CPPC CPU feature flag is used to distinguish the different types.
> > --

