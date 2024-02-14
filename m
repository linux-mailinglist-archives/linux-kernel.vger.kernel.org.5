Return-Path: <linux-kernel+bounces-65293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA65854AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D499D283802
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE554BDA;
	Wed, 14 Feb 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="culw6g3e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HYGHZyRt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEB61CABA;
	Wed, 14 Feb 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918520; cv=fail; b=FHQ3pXwZXbRSMtnI1IBeOzHWuDWypOXUE1XdQ2kDdvSt5/Y6gENc9nVqN4pgopmKTq16PhbjYcToU7BO4ff3MftCAFduRse+bXC+C8KVsrDyPbyr9dyw5n8FYKsbUFXcUnnurRWqMsYyd4G/+tgd0DGW20LD+IesVCRoED80rO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918520; c=relaxed/simple;
	bh=lmvvi8DdxyTcT+ia+aTfpTviHUc9a2KyPkI3plwgD/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SpdzY+jd1ED+N5/YC7kYS68FuxH3hjasvsOx8FdWk4UvWxEav9MW5jov9O5PVcN0I8lMIdFXQIGBlOMS1ewT+ky2TwWAKjTzZhLlL0yT5JK5xddHPhOU3Mxnv9BdGdbGr5lMe3egGnfLtyB/jriUbun5MsSsLJZ8ycaZwo955o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=culw6g3e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HYGHZyRt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8iJvG005667;
	Wed, 14 Feb 2024 13:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=N+QVFKycLEl022BxcXaAVo2ulIhMqmRkAgpnKjwA1SI=;
 b=culw6g3eporPtpcdyHo0WyqvuQy5quOWkB5nR3MaJsqlLQo0bX0VTMTMQ9rbFDZYWhRq
 zT9M5cCiPApAi3fABDsnnWLI4AEqYJ4cpgz0zBIzTLLel/GRnQkTDhflBibmlh/Wfucx
 I0H1qOysoGdmJKKIF9WItMBLTQ87DX5qOyeo8AzlLB8iJVP9UCqfmH4kq3VW0bPiMtzH
 WL3K5+YZMOlKq41fDB6dpv3MhkshAKlg1g9F5jCRotT8bI6pRGkS9oLNWKJRK+f5Xf/o
 SfIWT0YOjZJvuaVdeeuIt34xvK/YXtRF+cDNwroBc37/OY7TupXVbNvxL16tQECo3HsP RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8rtcgvk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 13:48:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EDFbID013986;
	Wed, 14 Feb 2024 13:48:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apbr17k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 13:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW9SK9/rjPWLiBM7bN0dUWbuykdE/N4BK1cKH6K2EyXvrfWRjZHKQIog4x6LGeMllgIkacZ/Kr8uCYVgokmZeaA/xZ5FuGcaUaVEYa5Sg/CvvwXvTy7duKp02mOdCuFDNJhTuHY6/sPePBvNGX+iuEbf73M4IXRSC55HanQyk7KxGdAwQuqG63KRKTdvnWlijEXi3CimNLRuu8uedalHIe6Aol1FuJXjh7VifCyU+4jFMEROcHUtJYFRipFTyEW2vQUmXY4EPycPWywrlFuFqDGl5Qq7MaicuGZBjVTh1w0o0p6/SELbEkz5U6DM2wnVpyoyfvqS42U1OtGNitD5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+QVFKycLEl022BxcXaAVo2ulIhMqmRkAgpnKjwA1SI=;
 b=Zx8tanE6b6dANYBUMWEnD9A5Gq2aREq+VpRa8Jc3cmqlLIjM4h6HdEeyRWO8AXZiWNoC/TC9ZGOi+MK0vnujz8eC4MnTUXCOAmurYrwfhmgiDyWS8xm8TZ7cTwshOt1XVvsMUvb26mcp1mtizvBzN2t/72bXw3Dv7K45mL9MwlSMgHrHo2bfPQ9jsOb/WNS0G7j+V0gI4e2uGbLhRkdqoUmzApKvSQNpknh8KHJuMvK6VrPGVkN9AyueQt3thDfuwHeYGWHM3NFM3M83ByP3CWVQtjHH1TUFlPtihVVfS1tzJuKtW6uqFnRP9AZrUGKc2k+az1/l2/hdxp7z3UTdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+QVFKycLEl022BxcXaAVo2ulIhMqmRkAgpnKjwA1SI=;
 b=HYGHZyRtTd1NgfeXF9B0uEA5l4Us5dCBo1T5xmOjGmvvZDv7IgrcuFzzMJ9bA7YFlvVXA9nIwS6JHmw3ArS7W1oYNnosz3b9yvxnpTh6JQMWwM7Y23OUQ4AqMeaIKpWosfzRh/goDLB1QAom3J8gGedCpkVmWjQrjWwWjEXemRk=
Received: from CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 13:48:07 +0000
Received: from CH3PR10MB7305.namprd10.prod.outlook.com
 ([fe80::fbe1:7124:8feb:25b1]) by CH3PR10MB7305.namprd10.prod.outlook.com
 ([fe80::fbe1:7124:8feb:25b1%7]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 13:48:06 +0000
Message-ID: <525d30cd-c17d-4f7f-8dc7-28670962792f@oracle.com>
Date: Wed, 14 Feb 2024 14:47:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: srcversion hash does not cover all the module's
 source/dependency files
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <08693d17-f2a1-4b5e-a136-81138ca3a58d@oracle.com>
 <CAK7LNAQjVjiUdXq3Wcuh14rW7q420J76Y8=AXNW8OHhYocCZ4w@mail.gmail.com>
From: Radek Krejci <radek.krejci@oracle.com>
In-Reply-To: <CAK7LNAQjVjiUdXq3Wcuh14rW7q420J76Y8=AXNW8OHhYocCZ4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0096.eurprd03.prod.outlook.com
 (2603:10a6:208:69::37) To CH3PR10MB7305.namprd10.prod.outlook.com
 (2603:10b6:610:12e::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7305:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ac3428-d4a3-47bd-864f-08dc2d639274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	irx3r7ov5roiYEhybOPk4a7mb/W/l15Kiml/Bf/vLXPSfm47IWWQDWUuWm/AzDfFxn7s1rjzFdSq4gXQrQ177+EW5aU+Y1vb4BT/nEknrocQMGD1fcj0wtt2duL6r4Tr2Jbd8rXkQCxcjjs3Q47/roRpXXvZ9jvDiIIvH9goFHDswiiph8bd/qNEfDjUoX47yV/zh9Z5JSNuBP5GzTVTV88dnJeCu6U96YMyF5FM5X/8gh3j5XMatxMUgG76tno9WScugAcM0FZMq0hv6CUAkaLGTk+L1raPZELs55nA0TpcBNrlTzncmTl7HsmYKfBBJEvB25Es1Sw2O6rtoioZyEq729u8XDRlw8THGDf6QvNIyl07PhIuGDfjCBj+RtyOs74egsbdRBoRgFt4O8+2rCuUqTxCe+Z3Nwyca7MdnUUbQGJZzLwLwFq8zN4XtqbwRRQ978owmPzfUf9jbnNu2QwYYyIbdtPPVUHiW6qXsL9WO2YmR2Lup1laFtilIDJCmiSSKhV5bkPOC48c803mHwm3+d0+2+1U7yj3PcDCScQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7305.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(53546011)(2616005)(6486002)(6506007)(966005)(478600001)(41300700001)(31686004)(2906002)(44832011)(5660300002)(8936002)(8676002)(66556008)(4326008)(6916009)(66476007)(66946007)(6666004)(316002)(26005)(83380400001)(38100700002)(36756003)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmhmQ3kvSlZFL213YUtsUk5tbHNqZldBZXVzTGl4TnZNK0Zma1Q4aXdaV21p?=
 =?utf-8?B?SDlhdXNvOG5GVWZIeWUxVE1SeWtBSkVzOEl4dE9ybUFoNENtSHZrSXVPWk9m?=
 =?utf-8?B?SU1pa2FnLzhqMUlhaHVHVG5RRTB5THVKUEl0b3BjL3hwL0IrZ2NpcklTQzFn?=
 =?utf-8?B?aDlQYUdTNlEzWDFmeEg2YTJ3SmVBL3g2bmRuN3BkWkRETGJyYzhJOEtySTFM?=
 =?utf-8?B?UWpwUTIwaTlWeXpIZGpIM1plMFloNm9mL202Yk92ZEtjenF0OFNVWXFkYWxx?=
 =?utf-8?B?bWtZV0dST091and2dm53eTlBcytXU2FoZHFiZ0d4Q3cwSDltUmJ4S2xwMnBQ?=
 =?utf-8?B?Tks5MU1NSjdIM01Td3NkcklOcXN4cGhLMkQ2YjhCbUE2V2lpTFdMTlYxdkNR?=
 =?utf-8?B?RnhIVnBhNDNmSERLWmpLb2c3VmluQmE5ZGYrZEs2L3lMTlEvTU1IUVA2Q1o3?=
 =?utf-8?B?MHZGTFlNektpWERkTi95NnExRFo3cEovdCtPUDRWWjFzaFRBQXR2TlZLUEJS?=
 =?utf-8?B?dm1kMlNoVEpxQ0gweVlZbVhnVUZnazEwN2xtVm1pVFBFTThBUTl0ZzhieW5i?=
 =?utf-8?B?Zkd6aVdSUzdJciswUHVLZ0RIdktIRXVCZWZuOEptZWtkR2FIRnEvVzdrV1FG?=
 =?utf-8?B?bWczdTJZbzdOWWlOOEZLZUVoQTJGTVI1Rmk3SlQ1d255Z1ZteFZWRG1LcXZu?=
 =?utf-8?B?STRCaWJRSDMwMVBZUzBvOG5KaThZRkdieGkrZlFvYXNidXZmUnIyVlIxeVUy?=
 =?utf-8?B?WlU5ZHN2a2dxMDRmUWJ6VHEwYnY1N0JXZW13bHllU2Z2cmUyMGhEck41cGxk?=
 =?utf-8?B?STR2SzNTL1lpU0k3S0U2VDlxV252THpZWEJMM01FcmpHTjg2dzBEblVIK0Iz?=
 =?utf-8?B?c0wxSjFJbyt0ZTVKRUFYT1J6SXA0MXdJbVlMeCtkbjY1OXVLUWFtMWY1T2hv?=
 =?utf-8?B?VE00Q0FjREV1VitHeWExbHJ0Nm96MTdZTWhxaGdSZUREOXdLcnBEcVJ2Z1dT?=
 =?utf-8?B?UXVyKzIwN00zMWhxaXVBZU8yQUpkbEhMTzZiamdCckxhUG1NcmxjdjdLVTVE?=
 =?utf-8?B?MUdVbDJITEdwL3FwUkV6cTRhSUtydlFUcm9xN0N1eWdWNWh2b0RFR2pmTkpW?=
 =?utf-8?B?dk9DK2U0RCswMGUwQjRwVDU5QU1qRUYrYTlyZ0xtYXBiR2s5L2QvSzduZUxu?=
 =?utf-8?B?TGdtdlhRd1M3Qy9kUW9XckdBUFFuTVdKbXFCYUZvRmJTMUx2VTdQdjE0UCtC?=
 =?utf-8?B?SmtERVZVMnEvdUJzNjgzQ2JvdWk3SEpheEtJMlJBbTlLT2J2MkhDT2xNaXpI?=
 =?utf-8?B?ZTJBTjUzajJRNFM4MGs2dWNreERGTU9HZW45dUw0ZS9lRklQRnpudmpKWmI4?=
 =?utf-8?B?b1U4d3RNWEtvUnZxdlRMOFNnejREMEU5enhYelMxamVoSFVFbS93Y3RFU2Z6?=
 =?utf-8?B?SzAza2M3aE1nVklDbXJYRWxwT3JONVFJRDRoSU1zWkgzWTJsOFhCRFZMSlpG?=
 =?utf-8?B?UE5IWWMzSDFidXBoK0NwZW1kWTBvZ3h0RG5SZ1Q5TjBxU2lVdDVsTXJ1VUpu?=
 =?utf-8?B?dHRYUTVKelJwMG81MnV2VFRlVXM2SSs4SzRiQ3B0aVdNZGNiS1dGWUVUVmhC?=
 =?utf-8?B?VjUwM3loekRSRTBmTXRBVWkwVE95TjMzUWpNaWt6REkxVUNoMlQvcTZkK2hD?=
 =?utf-8?B?NWpZODVvNTlIZUcrZml2b05Ra3BPclRSRFFYQUI1d1RHdVMwblVLKzZBYXNF?=
 =?utf-8?B?MlNna0t5ejZGQTl5TVg0aUV5YzZjZjVtYWVxeWk3YS85SkpjTXg1WlVBRFBB?=
 =?utf-8?B?Zk5YdGIwcVZaTG9yTko3OURSdC9HWnU5b1RORlBpT1loT1IrZlh5akFBL0NZ?=
 =?utf-8?B?Qit0UUZ2dm9zQzR3RHRhTnhPWURVaDhHNjM2ZEc0OXpGbHd3QTZBZ2Zmbkg3?=
 =?utf-8?B?cExJcktjY2JjaGxzZ0RaRC9nZXBWb1kra2UvR1IwNUs2ZXdjRG5aTzBub2g0?=
 =?utf-8?B?emF3QkZrWllrVExucVA4QjhiMkx6NUhPVGsrakhBZnJiZTZScHNtbTVhM0Ns?=
 =?utf-8?B?dm1wWnZ2cUw1bmJoVm15M2lnMmN4dHNKSnc2UVdKbVJkemFGK2hieGlpNUhi?=
 =?utf-8?Q?F3OY7K2ifGwO1j7Sspo/huF1P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3hndfKGnXXEJbxNhn2ZrMTOP9oksRgFq8WO6iQved++VWD39Wo0kbyERhdQtALHQ3a7ODpHCiVoMpG2uwX7bo1wcKxHA+wztuBmE+o29ESbGe7WVaFRBsnmp8KlI0AhddKFLAKaYimV3hj1x+sddGYU/9VXbrthjL2zatRLdJBQwGgnvEky+kucLNbhtPE1sQZkD5GQ+pf94MmI5LpnDZvCVJvU3RrRo9yyy25ErIHXvY0Oxf0NnxLYj3EY7C/wdsrMf5Yr9VCmBvIodvzMAsNyMh92CC5q/Kd1rBGXt1rnIMoCd5g6Qdgx2pZOYseyD47QMBkoOI4SSNc2SmtBBonscPN/njrLJu7Jvwaf/G4koL/zuvv2nEdAj7eRNuXjWjW3MgLKfe456hfamBvN+BrrSNB+1/81NeKZBGVDlfpVReKkhxMMnf//CBweSyvwWaAZnwECUly6HSaMpdjhS2SiC1WJYcpdcKXLybDPxgp/odckE2nSOnedNEzCtK5WUr1RT7jb4+NOeHpVOBvYqF5cNeK+UbIQQTjaL3xFUZ6UW+LhXd/ImeseQy5GAgjfowoALTUIPJD1qaUDRMzEGMLmiD4uR9hcoGhTXOWGYEFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ac3428-d4a3-47bd-864f-08dc2d639274
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7305.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 13:48:06.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEQMaKkwolcgzISs/7YQbsNX7fDNoqRvIHiaM1ejHgcwZXu4Ad2g08MNOXgbSZeHNdm/z387hYnJ4LwjqHl9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140107
X-Proofpoint-ORIG-GUID: z2g5xzgPfwlVgm6t0bJvUJjNvrIhsvwh
X-Proofpoint-GUID: z2g5xzgPfwlVgm6t0bJvUJjNvrIhsvwh

Dne 14. 02. 24 v 14:36 Masahiro Yamada napsal(a):
> On Wed, Feb 14, 2024 at 6:43 PM Radek Krejci <radek.krejci@oracle.com> wrote:
>> Hi,
>> I've found a bug in modpost - when it gets the list of source files to
>> generate srcversion hash, it skips all the source/dependency files
>> except for the first one.
>>
>> There is patch [1] in v5.8rc1 replacing get_next_line() by get_line() in
>> parse_source_file() function. Besides other things, the difference
>> between those 2 functions is that get_next_line() trims the leading
>> spaces of the line being returned. The issue is, that the source (deps_
>> located at the same directory) file names in the list, being processed
>> in parse_source_file(), are indented. So, when the code gets to
>> "Terminate line at first space, to get rid of final ' \'", it
>> effectively hides the source file name from further processing, since
>> the first space is at the beginning of the line.
>>
>> I checked this behavior with modpost from v5.4 and v5.14 (and confirmed
>> with the current master in git). In my case, my kernel module had just 2
>> source files - mymodule.c and mymodule.h (both located at the same
>> directory). With modpost from v5.4, the code change in any of the files
>> was reflected in srcversion hash. But with modpost from v5.14 (and
>> master) there is no hash change when the code change appears in the
>> header file, which is listed at the end of the deps_ list. I believe
>> this is quite simple to reproduce with any module, but if needed, I can
>> prepare some example code to reproduce the issue.
>
> Thanks. You are right.
>
>
>> I noticed this [2] email thread in the list. It mentions a similar
>> issue. However, since it happened a half year before the change [1] was
>> introduced and because I was unable to find any further details,
>> including the promised patch, I believe that these 2 things are unrelated.
>
> Correct. They are different things.
>
> Parsing the headers located in the same directory seems
> to be a design.
>
>
>
>> The enclosed patch worked for me, but there might be some other
>> consequences that I've missed, so feel free to modify it on your own or
>> let me know.
>>
>> Is there anything else I can do to help fixing this issue?
>
> I think the attached patch is correct.
> I will pick it up later.
>
>
>
> One question is, is this feature still used?
>
> I assume the answer is yes because you noticed this bug.
> (but you are the first/only person who noticed it
> in the past 3 years)
>

I was also surprised that no one noticed so far. Maybe my use case is 
somehow specific - I wasn't able to use the module's version (not 
maintained by the module authors), so the srcversion was the way how to 
check that the loaded module is the one I expect. And surprisingly, with 
the same source files, the expected hash changed between kernels v5.4 
and v5.14.

Thanks,
Radek

>
>
>
>
> Thanks.
>
>
>
>
>> Regards,
>> Radek Krejci
>>
>>
>> [1] -
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-kbuild/20200601055731.3006266-26-masahiroy@kernel.org/__;!!ACWV5N9M2RV99hQ!LR5KEN-WVLtWxWk3vtaqPD9DwmpPPIwMFle61qi8b83V1SGdNbFydDDQ_DGJ_bUmjM6Z6NgkH4NuxliZewmIkA$
>> [2] -
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-kbuild/CAN19L9G-mFN-MTmw0FS3ZX4d1MjeoL2U*s-Fk7Qw9UYWn5Q1YA@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!LR5KEN-WVLtWxWk3vtaqPD9DwmpPPIwMFle61qi8b83V1SGdNbFydDDQ_DGJ_bUmjM6Z6NgkH4Nuxlga4dF0SA$
>
>
> --
> Best Regards
> Masahiro Yamada


