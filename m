Return-Path: <linux-kernel+bounces-28602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA4830098
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACF31F24CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35843BA50;
	Wed, 17 Jan 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sY59nySc"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2114.outbound.protection.outlook.com [40.107.102.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672FCA73;
	Wed, 17 Jan 2024 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477066; cv=fail; b=fHpwqCzKq4lUUu2FTfzc2o7VhJOGDKPxfyx/AA7WGpyJVYjLZp3b4xOTA9cofPXiL64VDMt4QqRnin5oKZf1H8iuf2iuRmGVyVv7wIaNT6IvNcZc17g+PQ9nKLqN9Ya0HEMzykcIh06evJ1jyMlsfU9FPekobDT0kPg2VCpS3Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477066; c=relaxed/simple;
	bh=kEprHw+xv8IdFWB17ZSbH5HUyGWXEWM7RHGGnAVlB5I=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=mBct8UeYz1AKMFwtWpF+EC1bE4izgPpPcePi24QL3nZZ2YWzEyRG3uWFl9Dn4xoLOpwrVsPpIQrnyuQmg7L99apqvqxTyIhwGCkq4J6FaNQOCHCiIVH4fT5OrZ9AqhivqJrMuEI/j/BknFXuM0RI94LVfVykCH3fmjxsmPm+15A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sY59nySc; arc=fail smtp.client-ip=40.107.102.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYzgfgc6L2QT9Q+/1Lvsfc6eSNUGGEfmnpmexzVWrWcviPt/2bGQHlKQrAWXBrMe7oyu7UR/VIeGbmhKX/8up+2npvj3nLvfb3R97DLN5k10l7dWSA88P0r06gi5vngX3/0ww4fMDlqFVi2c6VserA49BIgoCfKRMRTHpku8WAFGoQ+reQKIEYOWRDwIH/7hFnysPGnCsCx950OdUXhKuL5K2KU13wjj1xiBbPa8QEgkszU6hMlo4LcdtcKnwu80Es88CJXptXxXx6JgTenJe9qUTkgFHX2cwRgpsyFwAH18GKP207CYTGKpH98Y7xo1PUlDc0UqF7LCAv3ZDJPB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBFsrqjOK5LJiS1b7YXXGC3gWh4Shb+fImkuncKwHAI=;
 b=Jf0eokOpUaZTdu6ymg7MQMXHPuU6/ejnSNYA/XQEy71h8ALVPUrWH2Etf6925lXJDiyP9+8aCP6XHP+hEWKesIxz/3eIEWCstlYbqt8v8Ae7dWmHGgiLvncxo/3JxHIhoUZKLeW1LVjQHqaV6HUdRefe87AM8IwFzXxoOTZmWyeH9P9OB2a2zZAIjJ6xP6PGep+ET1xmdQqdbqUmj+me87e6RFskwD/AjVydvKqGy+/HrgkMcstqcdhI8VnyKLLblunMQPqK6rP3Ap7t+cKAwCZpvUOHCoJ6D0dgPPtmuzDxR1c/fDMPquyclrCmx020o05Pr6wSnGeqSHcxrWZJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBFsrqjOK5LJiS1b7YXXGC3gWh4Shb+fImkuncKwHAI=;
 b=sY59nySc8IzNBr+1n1Ly0d96TG2WsFfmOcNU5oQXbN4wa0JlYeUm6NuyXjO//SoE4RkCnMjBQY7I2/QSff+Ow6YFAFVgptVR9wWTz9z2uWB/FUiL8XcwlKgVF2mI+6C7EIP2M/U6mYiX5si8QNe9sAWVLi/AGvEEMcBA2X0CQAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 SJ0PR01MB6333.prod.exchangelabs.com (2603:10b6:a03:293::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Wed, 17 Jan 2024 07:37:40 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 07:37:40 +0000
Date: Tue, 16 Jan 2024 23:37:34 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: James Clark <james.clark@arm.com>
cc: linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
    Anup Sharma <anupnewsmail@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fixed masked error condition in perf data
 convert test
In-Reply-To: <20240112120737.1995575-1-james.clark@arm.com>
Message-ID: <726d2423-13a-010-e72e-8d3366f9c542@os.amperecomputing.com>
References: <20240112120737.1995575-1-james.clark@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::21) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|SJ0PR01MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: d90434de-c39d-4c70-e5f5-08dc172f2ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xuW+SRmGP4GcWw2apf645XZRN5hSEzBoVxXrAjmxE9h/GcApd/6tGAe9cOVK7qelhNbaA42CI/x5kFwBNF+6hmwXAsQKv/RVPMj1DMMUf85FVibEs+ja//0OHpTgcsz1sseaDAbU8PkazygIC+e84qHf78y8J3oiyaq9dGs/E2aLw60rA4LMNUmfGl2MVuC4DtJKZry3FshKIbGfHwOQXixOUnpSBfj8omRuWn4KlM2QbugjixP79OOj4EWYs+1X1/9JtkHbRJvdglN7+U33xVSs59IYPweQ4pSOcCFn+M7gntzEpsh6HvGk/FCaOtp+oLY3PO7jLmfCO71v+xNEvslTew5KzddaclKsGq52FmBEclo5NY6/eRBTO341LEgMEKHJ0zWZAIx8NeZrZRtcY/z77PEbIDwKu8b1Ofwq0j9j22injsGy7jHUyo51eCjxDF8WLXHtFsJz/SDOrLaLWrNbLZbDtuJqkULq9+wJ66m0tZwRuYM/70nVYorgc1GvXqZIk3vys4VjRvl21m2pjKItzpHLt91guFaxcssqngk/5E0W3KdDo17U+8B8tgJMzAtZ/KpfEbJI0JCho0hdEY4uYwwq3joetpNYV9zNEjEcHsCw12vV3vqyGrBCf7gM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(52116002)(6666004)(6506007)(6512007)(2616005)(38100700002)(5660300002)(7416002)(4326008)(8676002)(41300700001)(2906002)(8936002)(6486002)(478600001)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f1/h5CzmmyfG9z6hZhJe+TVBD+U/xdb5TOMs79p5omFNT7omB+gQniGo4VOm?=
 =?us-ascii?Q?oXz7C9JdqMnw1/f4cZk04Q+JxE+HJJuJL9wmIxsWmdXeFY8z1WGHw+qF9yKQ?=
 =?us-ascii?Q?EpTCUJ3m4fzjfKL3q+DQwO8iFV+c949b/osiBS0bk9IiZQT32YW9RzFpYvsr?=
 =?us-ascii?Q?PwHWTqJ6O/p7pErW8Mvh3vZUZ9Yt+iG1ebJxwDDk70xgUD5OPiGT+WLeYt9B?=
 =?us-ascii?Q?0XTQaJ/AA1JPw722t3et3ETcOy3P9FrvBOhaZvqtn6gJ4wgUwNMyKm2IQ6f1?=
 =?us-ascii?Q?FvY8hIf9BNmIB81xa/19h+fxQzwEEvTjdFVyHqtubUyMkDsZFFsBKS1CkR/Y?=
 =?us-ascii?Q?5bPYr84vKpUzocQVRhTSnmlkUGDsLaKO/0ba7oHXWFb2naIXBqMdc/aCHXW/?=
 =?us-ascii?Q?7Kqr6rvl/sciBAZakERtU/AX2x+p94JGHl+lUK7BqpemKrkXP73EjI4nvxN9?=
 =?us-ascii?Q?BnslveSmeoyWosGfHc8Sgq0tQ9nCZXiCPunZRNRKD+f80YGrJ1YhOYMdJqBu?=
 =?us-ascii?Q?J0xJhC/fL4bO1fqlGB6zqGst6aKLBJqzgfyY/hOYqyfamix1qgOh8Vib330d?=
 =?us-ascii?Q?1loi1trC+qB2xPwKCM26Z3vbPanQ/9sZ4Iv7KuEGPppSPTyaWkejxDz8xy4f?=
 =?us-ascii?Q?yxS7fl9LwkMZpUlCFV1m7oaNHl3fYeb+AcXpywJ5HGJ8JefwEEqXV2PnvoWw?=
 =?us-ascii?Q?E7pgKilidORA4duKGWY8yE2bDVviryi7yG3lstBcbiY005+t0MvOjDu9BIYr?=
 =?us-ascii?Q?bJairBxJ3zo4v7dEexJ7PWDchaFViSRYzTdHYmwe/d7wqTgPSfzDRv4l5bzw?=
 =?us-ascii?Q?KHprWcgsiSzOMw1r60bZEPQn4v+3vCPfp7KdSgJZC2wHo7bljPIkHMQQIfTg?=
 =?us-ascii?Q?TvDE/bzl4yT6loWoigrVebtT8TzSFe2A/JZfYbZNCU8uYz9aLzpKUCH3x16K?=
 =?us-ascii?Q?gLL29uvOJyLtUwoxxnM3udffZEsJY+ncyOz0wNNOHtI1RA+SievzRVPU8fAv?=
 =?us-ascii?Q?v3rzrnATxilOhp5ryLG9pKmRhgNikll9zWEUb8JA9dngnoeOArsLacp3lKrQ?=
 =?us-ascii?Q?hjp1pgepdUJLzU4keRMOqHL+ARzoboMZq2P2Ar1RtN39jxc52VCyrqIIuHAr?=
 =?us-ascii?Q?qidlIWHcdAyy28QLN+cp8D03ddZRzy59lRkS4rnNjnTrL4Zuf6gP/OLPvaCH?=
 =?us-ascii?Q?JHNqGhXc4SPQ7/frhUbL1/RxGrPoj3KJ4eQ5pGWwPY1sMPLER/I5UxIqkzJT?=
 =?us-ascii?Q?3IIzzDQYdgLS+SnpDMoO+8AlcHyBcex8cZcXFJ1GsGJZAsgSqYISD0LLCDvV?=
 =?us-ascii?Q?ZexBa/Ffg8y00868XKhJfqvsYMbJ+CNw76WznhIR1grZnC+HGLuJjgrUEWOe?=
 =?us-ascii?Q?kUhH0myot+WU55dSEhzynLHZs4oeLc6d87xaWFckiU4YF3pjR7TkMsnTuEBY?=
 =?us-ascii?Q?3OIuaUt8/sPrDKMeBPdAAzgQDiridfZcG9wb73XFHNljzeYUwwCH/mKkUTz5?=
 =?us-ascii?Q?xEsmz6EkdFW4MsEbLL856Zk+l26SBQSin/M4P+7Son7BP5CBoCqE1hZBK8aL?=
 =?us-ascii?Q?/tgnKF/29pK7Ic28RiS7UwO8efV81UFFQbtxDuLjGdwrSAS31ka4e3GE2RhY?=
 =?us-ascii?Q?UvClBmgC8elu64zFXuzmsWM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90434de-c39d-4c70-e5f5-08dc172f2ef1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 07:37:39.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efTHwvZ//eTv7NidAwvv73ceInnEVl87tztyIWOvI47MbD8GJ0tz9TfI8/550Zd7ZSigqjp7Z6smr3cWW85opC+fw8QYq7dBwOtRp+ZP5bMw8vVfoIiEWerGEgCKNPAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6333



On Fri, 12 Jan 2024, James Clark wrote:

> The test does set -e, so any errors go straight to the exit handler,
> where it returns err=0 (success). Fix it by leaving err=1 from the
> beginning and only set the success code if it ran all the way to the end
> without errors.
>
> Also remove the exit code argument from the last exit because it doesn't
> do anything, it's always replaced by err in the exit handler.
>
> Fixes: 68d124182610 ("perf test: Add test validating JSON generated by 'perf data convert --to-json'")
> Signed-off-by: James Clark <james.clark@arm.com>

Looks good to me.


Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> tools/perf/tests/shell/test_perf_data_converter_json.sh | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/tools/perf/tests/shell/test_perf_data_converter_json.sh
> index c4f1b59d116f..1781b7215c11 100755
> --- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
> +++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
> @@ -4,7 +4,7 @@
>
> set -e
>
> -err=0
> +err=1
>
> shelldir=$(dirname "$0")
> # shellcheck source=lib/setup_python.sh
> @@ -36,7 +36,6 @@ test_json_converter_command()
> 		echo "Perf Data Converter Command to JSON [SUCCESS]"
> 	else
> 		echo "Perf Data Converter Command to JSON [FAILED]"
> -		err=1
> 		exit
> 	fi
> }
> @@ -49,7 +48,6 @@ validate_json_format()
> 			echo "The file contains valid JSON format [SUCCESS]"
> 		else
> 			echo "The file does not contain valid JSON format [FAILED]"
> -			err=1
> 			exit
> 		fi
> 	else
> @@ -62,4 +60,7 @@ validate_json_format()
> test_json_converter_command
> validate_json_format
>
> -exit ${err}
> +# Set -e is on, so it was only successful if it ran up to this point.
> +# Therefore only set err=0 here.
> +err=0
> +exit
> -- 
> 2.34.1
>
>

