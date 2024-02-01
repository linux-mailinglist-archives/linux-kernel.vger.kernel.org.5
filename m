Return-Path: <linux-kernel+bounces-48588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8F845E82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D5AB30C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082B5E3CC;
	Thu,  1 Feb 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="B5pz8IK4"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4D5E3B6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808408; cv=fail; b=eshQuCuM3Q8nsH444GBGmhK0YojH7dVknZZ8YqIPPXe5sI3HN68fkdOTUSv9o8eDm8MSNeB6aClSLSskE3vp34awgGTInUo3jvb2+0D3g+1miLPDnrI3N9qCZo2o1XYNxqfn1kjy7uofnnQThEY8+6bh22nQnluJDlaCzL6KK0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808408; c=relaxed/simple;
	bh=cP/VshhGLU9fBJlCgcmRC4W+KxR0f0qWH2Qb56TcEjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0HCoevmxu0DVyLZDPE2VA+WQeWjbQx85NhkYs9KoA2oOzX5khM/uYlK9nFZnKxvBlmoEv70u/z6Hx6fanXgYbdzOsi7I73vC/COSAr3APIAQzJCzoikdlQecol7RNVUGrI8T+Xgm3xsa/Fdfdm4jcesg2VRo6j731FFvMjzVRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=B5pz8IK4; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.9.169])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 66DE210CF0A34;
	Thu,  1 Feb 2024 17:26:43 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.193.99])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 211EA10001913;
	Thu,  1 Feb 2024 17:26:36 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1706808395.630000
X-TM-MAIL-UUID: 87337e7b-c9a8-4f01-9c0f-3e1dc47122b3
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 9A0CF10000E57;
	Thu,  1 Feb 2024 17:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLAnDnju8SHc4kyZjMUf25El+hJOVqgCd/HiQ4FZOX8hSkToJd2Au8XBksB/Q+VwZuedv1HueBj0a5nw8/OKwZVwTB/u7Oz12dQdQMRMXfZNPsKcH9J5PG3Ki4LU0rWd5J/MvmwjRibAyQ3aUhW8yeVn6zEp7xMp0jOn4b2myr0hGowEFyozNtIv/56TUNAAeBSJ7RE6RL7y+KAWK/xIKM0u8vvnkKaGWGkTMZ3iK3d0PtcIX1gKFxRIwg7OibxoMoRu+mNrQzBAcbE12v4Omgszoocd/EBYnq6yPKZEOHEYEeuHZNST5n1s9qBqQWUi3sRCuE/a33ossOU+4MAXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA4cY8LGE28uWnzZOwnrv86sX2/spSRh05UH1B9bA48=;
 b=N4f+BeQ56bE6mymGUY937WKfpnpfRnAeZEAo5Q/QhEJSwbQ2wgYVd5+XA7Pgx6xXXsFTPCmO8HsYYC0oq5U71wz9dEQYiMKjm3PnjKiHseXHu9rZU7Sy+e2C2CwFpXkTNzrbaGZBHA2WSy2TToIEH2TJECLBhn4/zx104yvlkCTifvsy8d6+6KYCRIEhnW//ntbtylHwkGhtKeSViSsfmPv1Ia8joNfjku2dY7d7xthmVpqwVW93nfsg39hdbCL0IG6BibweMlh5woE6qfvvg/BW7jYyBIQdhQfmXgrAEeWdYXjQf3FpPZsxtyMlCxNVEvpctFl9zpySnc/NeKMrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <31c94125-06e3-4459-9688-d371fcc87b2a@opensynergy.com>
Date: Thu, 1 Feb 2024 18:26:32 +0100
Subject: Re: [virtio-dev] Re: [RFC PATCH v2 3/3] SPI: Add virtio SPI driver
 (V10 draft specification).
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-4-Harald.Mommer@opensynergy.com>
 <6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:56::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2279:EE_|FR2P281MB2127:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a91bb5-f244-4468-6a1c-08dc234aeff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bDVfXz6InDD+DXnhcSEmDiK7A6X4XObueXTy94wsiKB5nWGxp1/Jg5uH7hMNYw91drlOwEhX1Wra4u3Zfnmh+cf+E5tU7kDX44SpLhEslofjsKakJWi1sAuQquoOt/EQq03UwBUMI5/1C//XL8FvrsFkk+c5zU2884kGJRhU4NmGAOpOnLwswoPZ6j7KIliG/BKcB87q+lG+miwNftsZ6cJhabUIAzfwGZsg5yzPPQKU/rAWm9oPdLaQz1hX65P2DnzHCspKOJX5ptjWdAvDtQN9p4UgIe6T5a0PcxWEFocsNjErdHdJbYOmTM7SReRMBw/VtHd6uZcgkMPlVnSal1air62oat8CRWpo8mvu4Zb2MgNNaHCSCUSI+/V4Fg6gns5MytXPKegM/F8u0c7RrU8P9EeRAXY2Zhjexk8KDP3Tk84svNh2BmKJiGnx4vi54+Aqg/opNXAEmiEU6hKpmqexRCEYe1NuJgQOZNjxsJ5ugtVaZowCwQB4pVIwvp2mztGCCOxu83VyivJjAW/fhR2YF+2z7ideWdVJg6on1Jc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(2616005)(31686004)(26005)(41300700001)(54906003)(966005)(316002)(66476007)(42186006)(36756003)(478600001)(53546011)(38100700002)(66946007)(83380400001)(66556008)(5660300002)(2906002)(31696002)(44832011)(86362001)(8936002)(4326008)(8676002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjlWNGpLWFc2N0NnT25YRFcxUTZSVEJSUnJDMU5QaExFaHY1dHdpNklIcTFv?=
 =?utf-8?B?TkZDajhHbnpkZFBZQXo0d1J5dGF5R3VjekR0OWlodTFhMEJmZDdnb2ZQMHdq?=
 =?utf-8?B?cGwvSzFNbHJKUm5JQUtNVzc2d3E4Q3NYc1hwRHlxenkzcDlUN0VHeHZqY3JN?=
 =?utf-8?B?NHlrd3FteGJCRjEyMFVuWVA2VEFqZUgzY2p5OW9DVUJoWFZsYjVyQmRkVTh6?=
 =?utf-8?B?VUdJV3dOcXE5Smpya01SbVBkbmxDV0ZleVF4dWVjZ1YzcGxPTm96YzdEbzNv?=
 =?utf-8?B?cy85Wkd0VTFvb01SbXorbEgrTUUvMDhJUUdGUzJYMHkxMFhwYUJaMjRIWUsv?=
 =?utf-8?B?OTc2Q3BoaVJNV1N5UDh1dXB0ZkIyck1ydjFqTTlPc3ZXRHRlSEU3ZDJncVNH?=
 =?utf-8?B?WW5yMWUzbjRLSUE3MzM2TmlWTW00MnV2WmZiS0hSRVJxY3BEbUMxWld2eVhn?=
 =?utf-8?B?QURnSHFncjZkQ2F1RWJKZ1RiY2kvZkp5aExLS0xIUWR3aGNEUVpiSHVzMkVz?=
 =?utf-8?B?Mm9Xd1VGekNKZGtrOHNxL1NQTWpPUnVYZDRxV2w5SEVFWmZNSnJvSzhZK0dK?=
 =?utf-8?B?RUFkeWVxWWhBajN2TDllQjNaUkNpMGxTWjFVZlpNZXNLZHdta2g5dXVUSXpR?=
 =?utf-8?B?SEFwSFVja0YxeUI5N2QyRU0wNm43WWFKak9yQkhMWWlwZlhhSEorZjVuMEZE?=
 =?utf-8?B?NTVYSXNMNyswd2NFVWI4NDFXOHpaZWp4MFVYQXdFb1VBWTVSUk5mWm51Uzc2?=
 =?utf-8?B?Ni8xazg2UGJiU3dIYlNsUGxacm9UVGNobmoyazJsWWJoNDVpdXJLUTB6ZHhs?=
 =?utf-8?B?MlowM3lNRE80eGFyMFBJOEw2UXRnZHdjTlRSRTlaSk1hR2hPd29kN01NYWgz?=
 =?utf-8?B?b01LMkh1c0dSUnBzSFFTWEFncHNVWFp4bFFQTlJIRWNIS1dibVp5NTRXbC96?=
 =?utf-8?B?dndaQ1V1WHcwaEkzWU5rSVZEYlg2c2I2NWlhdi9tS1laTk42ekV2bXd4ZktZ?=
 =?utf-8?B?b3hsNGJFaUNsc2o1MHA5anBoZ0w5c2VBRjhtdmxUaGlINHBJRWtLeGQ1Q1ls?=
 =?utf-8?B?RHNFc3BQT3VkVUxMcHpsemEybys1NUs2VjhIYUxkOThrNGY4d2ZYeHM5THhv?=
 =?utf-8?B?UW5SRUVNYXhEWGFJYXB1REttYzJyejczMG1DRGhER2I4MmFMYkhoUFFmNFYx?=
 =?utf-8?B?RjJEZDh0UXMxUndSbGdHQ1BDeVJHMzZraUxNczJYeTg2UDFlZ2orYWZSMWI0?=
 =?utf-8?B?YkdiNE1LVHd3WnNmR29FdmR4cWhFeml3VElVNTkrYkw5dU1ndm1TdHprckJW?=
 =?utf-8?B?anlGaU8xZytOa1dPckpFb2VCeFJxNzNvVDlSc2pvZ1E4UEg4VWVWUDRMTUM0?=
 =?utf-8?B?YTVoMjM4aXlrNE9uRVpDTE9lWm54RmZieGxkSWszUUNUMHp6QUJGa2dxVDZC?=
 =?utf-8?B?Q2NNWjN4YjRvS1dXMzgySUxDS3FBZFhiRE1WbC9wcWpheHphRC9DbUJlTVFy?=
 =?utf-8?B?ZFdxUHdzVThEK3l0QVZzUkh5d3d2YjJqcnFFbkg5WEhoY3BqNFk5TTB3NXhX?=
 =?utf-8?B?cDIwV2E2MHZyVk01U0ozRE9pMUpVTGFQYnFoTDE2d244TjNvNXZmcWJXSk1y?=
 =?utf-8?B?bG5JdVBFa0tvWG03K2JJUnJuOGYweFdmdmtGQjM4NGRXQnFHajNmRFhQYTJo?=
 =?utf-8?B?ZWRGYW1uZ1YyRGc3U3dTWGFDOFJ1MDIyTjFES01FZmo1OEpVRjUyTUNKZEpW?=
 =?utf-8?B?Q1hjTGRCOGRHN1R5U1ZRUlBvaFF3R1dGK1lLTmRST21MSkM1THVTbUs5b05U?=
 =?utf-8?B?TmZlcmF1MU1aZXJJWm9SeGV0UHphaVp3UjhIdmJ5Qy9WN2xZYno5UUgzSWo4?=
 =?utf-8?B?NE1VRmc5Rm9EU2J0em5Xc0krdmtha3hMci9iQ3JzMjdRekk3ZHdkazIyWmFS?=
 =?utf-8?B?THJzRkNHZVRRTTJWMVVrZTgxQk92Kzg0UzhoL1NNbEFhNDJIZnJtRWxxWVRP?=
 =?utf-8?B?WVY3VldIREl3T2hJb3FKMFJvanFGazJUSTlzK3dHY1pFaXA1L3cyZ0tkQXl3?=
 =?utf-8?B?bE9RTUZvTUlyRWUwS295MyswcmtNMkYreHNBbE9VdXZrYjVMODhNdi9WRElH?=
 =?utf-8?Q?4xMzrbw/zEYGRr1M0X8IcRo/b?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a91bb5-f244-4468-6a1c-08dc234aeff0
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:26:34.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfyC7akxZCVYYIfklmN1ksRwzq1xCi08GG08bmnYF29HSsUAtDVEta8wV6CVB8LLf2Z2phvMV8mbkdw2cMIf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2127
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28158.001
X-TMASE-Result: 10--15.520200-4.000000
X-TMASE-MatchedRID: 8+bhjh9TQnH5ETspAEX/npGPSO6O5JCaTTDWNi9ivw+J3Smid9WN/ZZ1
	P5vNF6357E4hcO6MtBZnL2Fmt9cIIByvYkiXIxX7iu6u4shZ+fEH/MsNCRnylTC402g4LjYv84Z
	CfU4ptaA5hCQFWpSptiPJ2hEK0g1YYNP5ZvfGAKvOlc6uOs4xMfJDp0CY93MS4j+plUCB/Tou1L
	sXcrdKSAmz/HlFMCJXEVh8nh3wkeLM++KBJYTUQWKwQsDFdhcMJbzZuwLx+4WZlZD1Y4akg11HP
	AVML+u5OSKcrSkG2gig9SIO+VAFXuYEkpbanTHuQfEHsmyy6QIUb00fKSHNj63/rEOakn8sT0BR
	ZNI+YwbANog326X8vtXNOAQ2MSi2muMpo5XKw2858Sarp97J825FeHtsUoHuthEh7LXCm+W/hfz
	PDA48fmkIJe/rPpLiU4iF1jKxJ6iwFMlIPaIBbQ==
X-TMASE-XGENCLOUD: 3dcee6a9-ff04-493c-9609-a83a29d843a8-0-0-200-0
X-TM-Deliver-Signature: 671EF3F6A6472E86F37AA7FBAD324E4F
X-TM-Addin-Auth: sYJhKQnzhzVpicWH1lRpymmchr0sb8Uas/HOkZn7ejEbc0MhlcscoOjTdEz
	V7igpqMavFDqJIULsq1ttmFrAdZ+1yx+8fqBqmTC6eSdjgVJHyo63VLGbPsXlPuRzHG7OEZI+Ep
	7VhOQiOZuGH6a5eVyEClv1NRFDUCOwFP/Cml4vD6idART6P9yUUJFJWZXQo4HxjXuRjGKcVUlEI
	JVg6Ct/5+0AURcOnKHI2C6yDVYdU2whb8ufmpGwLuvMw7WXT6bFY7ko/6kB57IUBNSI3n/AOTHn
	OjA2NoecZIXBOVU=.nXRipX3oo8SIongewef6CFVmY20p/5bZK84yJpwIv6wRlumesm8ubimeCz
	y89RhvdxhA2fxHNPKBQiZixO4+RAqpiZwHY12JsIICGEn3+nzYaG6vIRJYyqSFyhH/uYJNIhgWi
	M7eM7azS3d20f4v6Q1TxuhAA5Y9zbBxbopQxZCgaFzQBWro2e5voB+pz5BWZBF6Teg13VCZnygu
	5cmMxk8hw3SENqKI/W7SOKaPSJgRTm4hVKCPDjXkj+wD2OE7yv9RzU5bM6Sr3lfPepcY8IteA0c
	b99vxLgUAHefwW3sfo+px6JfqNaj9CJQkgDD3672Dkl23pPe2yKh8VVMscQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1706808396;
	bh=cP/VshhGLU9fBJlCgcmRC4W+KxR0f0qWH2Qb56TcEjg=; l=2287;
	h=Date:To:From;
	b=B5pz8IK4MdL4+eY4DhuTosn/a5HL9rFKgLIWVCZQoS1QKb/W2LYQPlzJtSgxfKCqm
	 b0V7qtDjZcEbvYvO1yf2iQArEYVXYM+1YuUtFqePXpn5nuaQfbMpXPsHSXE6xdIYu6
	 Ix3cTEwq7qF4yxGAI8OyNN7yOpDRC5QEI5l3qdDLH17Kkao1YWykLDfUyVWraTOedd
	 h5cqBiBcvGNWVj8wMOqpgvMLe5g+Zi0gTIbq8zxKXXLsnu/+zfJ177THS7vrY6GIi/
	 Nvft8jA69tSLXsujUZCktPcQhnfJDAdOxu+Fhukh+3PfspXTlR4N8CnrqzN+WNa7Mg
	 D+6M58UPL7c9Q==

Hello Haixu,

Thanks. This was a hard one. I knew that I did the delay settingsmost 
probably somewhat wrong but I had no idea that I did it so wrong.

Reworked, made a new function for this, currently testing. Added the 
link to the place where your E-Mail is stored

https://lore.kernel.org/all/6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com/

as a comment to the source code and hope this will survive the reviews. 
Another option would be to add the diagram + the explanations below as 
quoted here as comment to the code. Whether 30+ lines of comments would 
survive the reviews I don't know.

Just to say nothing in the code making live hard for people trying to 
understand the code is something I would like to avoid.

Regards
Harald


On 30.01.24 04:21, Haixu Cui wrote:
> .   .      .    .    .   .   .   .   .   .
> Delay + A +      + B  +    + C + D + E + F + A +
>       .   .      .    .    .   .   .   .   .   .
>    ___.   .      .    .    .   .   .___.___.   .
> CS#   |___.______.____.____.___.___|   .   |___._____________
>       .   .      .    .    .   .   .   .   .   .
>       .   .      .    .    .   .   .   .   .   .
> SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______
>
>
> NOTE: 1st transfer has two words, the delay betweent these two words 
> are 'B' in the diagram.
>
> A => struct spi_device -> cs_setup
> B => max{struct spi_transfer -> word_delay,
>          struct spi_device -> word_delay}
>     Note: spi_device and spi_transfer both have word_delay, Linux
>          choose the bigger one, refer to _spi_xfer_word_delay_update
>          function
> C => struct spi_transfer -> delay
> D => struct spi_device -> cs_hold
> E => struct spi_device -> cs_inactive
> F => struct spi_transfer -> cs_change_delay
>
> So the corresponding relationship:
> A <===> cs_setup_ns (after CS asserted)
> B <===> word_delay_ns (no matter with CS)
> C+D <===> cs_delay_hold_ns (before CS deasserted)
> E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two 
> values also recommend in Linux driver to be added up)


