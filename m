Return-Path: <linux-kernel+bounces-19813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E882749B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1E1C22EEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD2E524C2;
	Mon,  8 Jan 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VHtUerZD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D849537E0;
	Mon,  8 Jan 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8ejlqiXnLFqcPeHTsJzq9ej5IOFZ0lxpMyvvrybrmQLEWJGKvmr9F7QS3jtUkIXkr5eZo5VTXV69mzEp33xEFFyFwEyojtF2d+OKN0ChEzc5g2e+go1ekS9bwTxFdrk6iUdNx+m8yZAIDJDaxIwWQtjKqsEk+F1aR3WCPEUt3aviNjeG/3kC3AxYxygrDk4eGxOJrILD+6hzN6eMgpeTBFWwGZS/EIojeynOqmLQKiPDDqZpY069Zo97KmxYhRDnvmNwJGfRNxD77GbfrWRiA0lLnp4nK+5ZMQdw1AHEaHu01JhN0bdVe5jQkXK1o460ah0u6gYxiPRqv27IsKnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF4DpJtdm3ZfdFIqOOOT8sby8I3+i3IHBShjK6keoQI=;
 b=cHGOejzddfzbSBaiMkxtqLeohCKQU2tm+edkbZ+5kvtlE+bVvz7R/0GFko2en/socAjTWrvt0x952UPkIEMb9GWGWmOoNiWYFBfvxSSa2EOC2DwnmuQaO7cFEsj1SEw1KK4EqMCTKZOvhfVbAxZJsDolatyU/Mzuhs6V0DcOUbcZ9806GgieVYsHYx5S1ehOH6QXhDu+183UHdIPx8iWX23/fQsro911DSllqQVlyMe9lPmVylJDGIABKGSb0EwjHwGMhihJI7Cl/WrEDpH/JwvQHGEunykF/qTKrudkRafUJkJ63u34We6HZwY2MAH0XymHkqkZxbHGC3WsAc+XKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF4DpJtdm3ZfdFIqOOOT8sby8I3+i3IHBShjK6keoQI=;
 b=VHtUerZDE1HOjUryYL+WtO4ZCcNAQ9CGkFGtS1eEQpGgnJOn9T1bfOlKeH1LYFfc7YoqRlyTrtcevOgUQnLT5y2WNSWzH2cHyZoS8RrldWXnoJp3ycP0i73kH65b9/JKOkiMPOuIAYV9/7IyZNhZ+1mpLRlxEdJN9NYdPoHxkWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 16:01:50 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:01:50 +0000
Message-ID: <6bf7da8b-6a0b-4c0d-959e-329d7cbd8cea@amd.com>
Date: Mon, 8 Jan 2024 10:01:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: use tabs in CONFIDENTIAL COMPUTING THREAT
 MODEL section
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <20240108140852.20533-1-lukas.bulwahn@gmail.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20240108140852.20533-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:5:335::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BY5PR12MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fbea4f-4964-45ad-aa17-08dc10631fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HqZHQ+bWqxIbRuo457j8BMGTFALcTg3i5MGIJDajD5fyyjZ5CXTEmQj7JnEcFER4sCuiOWfHHuCyZXXInDIwJCamDovkV1w6bFJQR74ePJG+kqtsNO0stp26u263fjrOo50MvRrYltmUQMYQqedeM1KyihZt6NuUjKtMjM7VvQLaEQEP/tsMo7ynOUfbKDP4ExLr5vk1fntGT18GWrj9x0zjFDGsh3i6Tymd6DlzMpRCgT+kznUZXN7bcrZ9DGWJf5gFAnfxHqJwLsRr8kervGVDWGBrhxjdP+p9PyT/c5re2JimAu4N6l9oqr3U1IkJk19DuTFsAhSYr2xgryzC/vdeV1dY5gZCyXT8q0ahLLKWSw4fHPnRwCqtmq/hZCt/qbXy6RPfIVjReqgs5JR1MDM0AU6E7TZ3uoSYWNgA54WjIEjrFumZ0qWpekvttRjYj/4IPUDkMAUf/elIRP+vWYM1KQQKk/J82C9m3pYH11Tw8wYju4k4jiJGaUMuDnc0CtrMb2s1pVQQxXiedNTvDPa+DfAE0bPgyrTri+lXNzAiThLGpAHZldxC7zSGVcBrIKb7F9auG/rPGwhDe9GYKKesV+V2UjQfLJyqN7uAfWyW1dlT8H7O4nRg04+u1lS4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(53546011)(83380400001)(31686004)(6506007)(966005)(66476007)(66946007)(2906002)(66556008)(110136005)(316002)(31696002)(38100700002)(26005)(478600001)(6512007)(2616005)(86362001)(6486002)(5660300002)(8936002)(36756003)(8676002)(44832011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N21taWNacE5oNHhwc0p5SUhCMjVCMFRDZUxWaTkvZnB2Z0p4Z3lOWGFqYy9L?=
 =?utf-8?B?d0J6SzNESlNJMGxyL0NWS01VTjZHV09SbVBUZVBvZjByYy9LSkdyV2JWR1lQ?=
 =?utf-8?B?blgzQW9XM3VsYWRBUU5EN2k1S05rTU5qS1lQZGNsWmptNHRpQktsb2hmbXZu?=
 =?utf-8?B?NFpqYThnV1dXeW1HOWczK1RVZTYyZEQrSCsyWWMwNUp4V0NVdnlMeXJIZGtZ?=
 =?utf-8?B?TWM1dXoxRVlpYXpJQmVlZDVXRDZaL0svQjk4N0hXc2ZNczcrcEhzSk40a1Yx?=
 =?utf-8?B?c2MrcCt6dEg0bzZFN2lkQThlV3VNclRsMkRXKzZ0NDh5Z1g2L3VQbk53NG5I?=
 =?utf-8?B?UCtJaWs0bXp3QktvSUQ5b1NVaTB0aUFjUy9ZdUxqanFyenpRN1N3VVBLdnFO?=
 =?utf-8?B?UWpFU3BkcEE4eXVrQ01kRWtpM0Jub3FZMHZ4SHF3Vjl5czhIRVpvT0d3M2dx?=
 =?utf-8?B?QXljT3pFNFJNU1JjZjFKR2tkMXZZRmdIRFJ4clBJT3g1Zm9iaXB0UkFCVDBv?=
 =?utf-8?B?WEE5dE9rdWJvNTU4VTdaUXlRbTRmaTNMSmJiSlpyT0pYaHBJd0JibWF3dENp?=
 =?utf-8?B?NjBZQkRjVUY1KzE2OTFJeVA3ZFJuQ3dtYTNsZ09SQlRPVE1lZEpEQS9NMC9h?=
 =?utf-8?B?Ti9Sdi9MaEV2anVxL0FpL2t3bW5nUW1KQWcxeGQyRXpZUzkrNFhFRWhBVWU3?=
 =?utf-8?B?ZCtpSklDM2ZmbDJPU3lEWW1mbHdmNjB5UG4wc3F5ZVZDaTBWeDY0Y1E0N1pu?=
 =?utf-8?B?UDhXL1Z4SmNwSTc3ejJIYXNLQnREU2l6Wm4rRWdQUGdjVWhBWnBJZGlYV3h3?=
 =?utf-8?B?emxLOUU3YXBiMlpIc24zQ01kaDczSXNPSmtrS2pjT2Z2eDZTMWM5SStOamlN?=
 =?utf-8?B?b1dvK1U1OU43WXpIN1JzY2xmbkRwNjNVWG5zZ1hLMkdiZVd5N05yNkROQVUx?=
 =?utf-8?B?Mnh1SmVrK1NOOUkySEtqN3QxOU4rWU1NUTkxTm9yRGxsU0ZEcUc0L2dSOEtt?=
 =?utf-8?B?RGtJYVpZeGJCRklHSm4vVTRlKzlKaG5vc3g0bDBYWDBjVU1XNkpQWFYxTlo4?=
 =?utf-8?B?Q0JtaWhpeTlrUGVwZnBWSGxYNkZDdnZpM2ZzemtLZGtiRDNvalJkaHlPTjBG?=
 =?utf-8?B?SVFHQ0lORjZhMGJFOGtqRGNWTytTUXhJanJvbGZIaVZEUHhmdjl5RUtVYUUw?=
 =?utf-8?B?OWYwanZYMlhRZG5FQ3JMRWJDUnpkQVFvMGhIZDQ3OHhnY2ZQYjlSdFh0NlBT?=
 =?utf-8?B?Qi9TRTNSekpVNmZOb2R2dVZxVmwvckhSK2hpZU8renhWeEd5amVWTWpBRGhu?=
 =?utf-8?B?Zm1xcVFaRlJTVlVneExScmo0c3BzMXVKWFJWTFgvMjdldnY0eHBzMldWeG1a?=
 =?utf-8?B?cnhNcTd2Zk5oU1ZETmdvdmRuUkNMdXlJM1BtaTczWHREQk9DQVM1bklaZ2Jz?=
 =?utf-8?B?ak45MnQzNUQzbHhMbUt4azdYdkp5Nm83QWhjZ0t3ZzVwMDdrUUdlVHlYNFJG?=
 =?utf-8?B?TnlDUEs1NjBlZk5EVlczVWhSbVFlTWwwdzl6MnBSZW1nNXhUUHNha2VQaEtm?=
 =?utf-8?B?bkN2cHFrc2xKaGdrM2h4ZlhvdkcwU01QZ3RrZFVqNFUraUVtU29MTTFKRHBI?=
 =?utf-8?B?T0cydk4vUkFZcGFaMjN5TVlJVG1ZNWpLdUQrbzcwdGZWaWlwNldGUU11emM4?=
 =?utf-8?B?ZDVHZWduYXZ6TXN0KzFETmRRbUMwbzdsTVZEdTlIbitQSDdUL21EVkdkclpM?=
 =?utf-8?B?MVJyVDdSdGhmakRGZldUczhzdUJZSE1pSzkya2tYQzBnSDFFb3pXc2dTVmFi?=
 =?utf-8?B?TnIwQk51Q1FYS3RBd3g4SnAzVUxxYlU4Ym9TZmpFa3l5dElVSUx0YUdYRDlo?=
 =?utf-8?B?YkpQa1JRSWZmNitseHBHMnhpSHE3akdsKzZPd29OOGw5TDYzRjNyaXRFdjFi?=
 =?utf-8?B?SGZwVUY2WEpDUWdKdWlHYndyS1kvZjVyMDdjcmUvbjd6N1c4SXFUR2twNllD?=
 =?utf-8?B?UGN1OUh0RFdFRmZTSFhiMUE2RmlFVHdjeEVvM1M0bXhGVStkQmxOTzV6QXIx?=
 =?utf-8?B?eFpkQmFpakw1OTh6U2FVYXE1VUp3d0NUaGhvU0RBM2c0azdGQjVHUGtNdDN4?=
 =?utf-8?Q?xD469kikV8LGDHc1z/Kj495Fm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fbea4f-4964-45ad-aa17-08dc10631fd0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:01:50.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSUytYNrL8O6xIe/8EZLB6aonKPemU4VzZyiIlaNtt3NfteKRz2YNDG80nSr4Cdc7MwvrHyf2HY4TVhw3KZIeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902

Hello,

On 1/8/24 08:08, Lukas Bulwahn wrote:
> Commit 1f597b1a6ec2 ("docs: security: Confidential computing intro and
> threat model for x86 virtualization") adds new documentation and a
> corresponding MAINTAINERS section. It however uses spaces instead of a
> single tab for all the entries in that MAINTAINERS section.
> 
> Although, the get_maintainer.pl script handles spaces instead of tabs
> silently, the MAINTAINERS will quickly get into a messy state with
> different indentations throughout the file. So, the checkpatch.pl script
> complains when spaces instead of a single tab are used.
> 
> Fix this recently added section using tabs instead of spaces.
> 
> Fixes: 1f597b1a6ec2 ("docs: security: Confidential computing intro and threat model for x86 virtualization")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Jakub has already addressed this issue with the patch "[PATCH docs]
MAINTAINERS: use tabs for indent of CONFIDENTIAL COMPUTING THREAT MODEL"
from 1/3/24. Also, I recommend refraining from using the 'Fixes' tag for
things of this nature. NACK.

> ---
>   MAINTAINERS | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa67e2624723..c76884e40434 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5296,10 +5296,10 @@ W:	http://accessrunner.sourceforge.net/
>   F:	drivers/usb/atm/cxacru.c
>   
>   CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
> -M:    Elena Reshetova <elena.reshetova@intel.com>
> -M:    Carlos Bilbao <carlos.bilbao@amd.com>
> -S:    Maintained
> -F:    Documentation/security/snp-tdx-threat-model.rst
> +M:	Elena Reshetova <elena.reshetova@intel.com>
> +M:	Carlos Bilbao <carlos.bilbao@amd.com>
> +S:	Maintained
> +F:	Documentation/security/snp-tdx-threat-model.rst
>   
>   CONFIGFS
>   M:	Joel Becker <jlbec@evilplan.org>

Thanks,
Carlos

