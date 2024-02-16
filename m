Return-Path: <linux-kernel+bounces-69386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379A85884D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9D628D481
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47414601E;
	Fri, 16 Feb 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9sHVNly";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bL9Y+58i"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F714600A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120852; cv=fail; b=lwGgaBAusDTpe8bv4vZKwNDMX9y1C7zIMRuKx7LAV0IOWV4FMGzyRPuMg8vX2qfl9T1IwCMo7Ey3O8DPhvbUdlmCKFngX2legnlD8240meUqd9tl4xE1ypgzT0lkCplarOFs3xQiLPca5bGXfqTgQ3Nlk3J4bfpAVBoorBdnvV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120852; c=relaxed/simple;
	bh=7PREaFfEML/TbM8lGTl8wKpK4kXiG0YdrXPGh8CxWls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWLJJlLw8jZ4tBOkyFuNU5YsxiBSLUoGduIvMOZlabJsylN25n3YWOx4ChIMQaBn4AdSN/xwxDD9ZzFMdOb7NlIRDlSE/nAhbKUI5+x5Ai2Rv8jy5WOVSVLxhaIsJdGUfzHaWG9Y6q4wamsoAorukvSNi606gzHGRVg7zKdzTnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S9sHVNly; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bL9Y+58i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKE6xM002367;
	Fri, 16 Feb 2024 22:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mb0LR285/z7odUkeM5z168UJStt9TMu/tJWTvZwdTxw=;
 b=S9sHVNlyDK0azqzMZE4EcnQnfpA5+/2V3K0qD9Y3kqhVUPspxa6QR2tMPlpsFmLSjlc6
 o05pRFCuQV0WHs4Dgg3Wzmgrki8gcHTLUskN7R1U1h+Sd5e6HlbMfUP3iKVaZNAkmbQw
 +FPuGZLAfRbwrlWHMIbsiiQN6KbGuc4Ts5Dj9V18l3L3MDYkfWE50tqfODQcCoQW04Fr
 2eGKacam7R92+Rl/FzH8pXgsrdT0GN8qrE5kkSRnSg8fe8fGO8xXwb/u4w04/ViDpRf/
 GZMjNNeBBTUT9pRQxywZx4YTNdChAS6Xv+3YuiHXDiDQ+Q7RbANchKjgxV8UuX45CfCf zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppp7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 22:00:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKGuvt015011;
	Fri, 16 Feb 2024 22:00:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcfnma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 22:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBBOwH3NdWvYXnjWmwt4VEsE53KdLoux4BJC0id3D27Hv+1seB9RkI8OICpkOOtPZr35rGMmZgCwaw71QLAaRJVdzoODouoGSjNIiKqxsAY0IIwBcoVaiA013VuWR6z+IfNdjYzAMH8ual50QcBZJW2XZJX9SEXNKqvMo7e6MRuhdF7PKE71dQE8vFYfbTpuIQTLETL7sew20q2ij2rFD+vaT2BvbPsAnndD3T93fKzljdV8kYwIneaZbvUvjjCg/8GCotb5ys1Q0GxO2mQXO67vSaVJz3TDq9k2MQdLXcl+6jxU3KYF+q0VdRETgtN5mTrn0VHNkt4c8fCrV9TZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb0LR285/z7odUkeM5z168UJStt9TMu/tJWTvZwdTxw=;
 b=OaY7KTdYd2MQPICwa6EQtYRtRB7pImUeiBXm3WQCO31gpPPRv+dNVunoD2G8w7N49DxV0HDXk/mx2OJ/x4POr87cSqgXuRbssP7pe/3G9OgVuOP4WGNYG1ohVZOaBJdRTlkkhQvTnzFa1pYOXNCENzaSoRAaq94ngPO8LEZZsdvfE1hkHwrea3Ofu3FuLUMgHCH7hKRV9Og3IDtGxdmI9zE8sZzSb2SFIKtmK27edwrSMbFtNZZy1JVRSEKhhgvP6WdXSaF6SrUXQPFqNlGcE7Dh6YbbvdOgPpcX9HVLMsii7NaqAkOke9V1bZZodq5aHI5QuoIZneR78fPQOjf5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb0LR285/z7odUkeM5z168UJStt9TMu/tJWTvZwdTxw=;
 b=bL9Y+58i+iXU+npQ1oMBJF45c3t22zPLQHD0jWSslHw6jdv7RT6IzaAdsucxX42g48aZ808fjoqxilAUrOc61hbHjtNWZQSPTWllRi3Hhz9I6pjt9fTmDfxqrPaP4ONpbHY6k9Mu4VYv/CclUcpHKGQ1+sNN/N2sQw6pphIxofY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 22:00:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:00:33 +0000
Message-ID: <71db0ad0-a385-8572-7bea-bb11f76a6345@oracle.com>
Date: Fri, 16 Feb 2024 14:00:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/6] mm/migrate_device: convert
 __migrate_device_pages() to folios
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, apopple@nvidia.com
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
 <20240216211320.222431-4-sidhartha.kumar@oracle.com>
 <Zc_Z1PT20tNlsiFf@casper.infradead.org>
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Zc_Z1PT20tNlsiFf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3643b4d7-232b-4fe6-8a46-08dc2f3ab2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4/5R6b0fWg4qhCbh+xMl30O8aCg3ls6lb15KgkJ5rIoYGM3TGqfDtefVjgaya8K6dbnRICgvP/tiT470fFchgxYfjfYv1KoppjQiTR+FJ/Ar1VhcaFDvzj+gHvsEllaruWytLAiGj8OwLxApXFyXi4EX0S8RQT3MWhC1jEuVdqhz04BaNwsjHmGGeA7GZ4ezXhEg4Ox0muVpmB+4TfAYsptQRcCFkIokuKQqRet9E1VxYmaud/q5cKRnoUZA2ysm70zE3U1bSE+7NCCtDStDnO7P5BMg4Sz9rSVUHLwz1BChmccVRNXTJlc/7zlobVIjhO204pUvFBmPhD/8q+iBkuYKePB0lRnjf1glILZJqyVMXVOXnpon93h2kdBrBPQNc084QFk2m4V5KERn2hc4pnP6C5/tg3TuzdVaVxLXTzFf/n4I36+mEvfvV6bK+f7RvPtm/15PUVzZukkJVhG/DprViamqdHbqJv0AGoH4YmUsQxj+fVmC+DKyvVHY5/5ZBUjPzw7SCszG+5RbzpNVDqSSs2aGzYVjs9Kg2bEl4HVACWpCf+npdfaZWzzYqHHU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(38100700002)(83380400001)(41300700001)(6916009)(8676002)(6486002)(4326008)(5660300002)(66946007)(44832011)(2906002)(6506007)(6512007)(66556008)(478600001)(316002)(53546011)(66476007)(36756003)(86362001)(31696002)(8936002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWpJYkowM1RGeW8rU0lQSXBTbk1qS0NVRTAzM0pJTTEyWmxmWDFCWi9nUkNO?=
 =?utf-8?B?ZUdZbEdDUkF6b3VuY211UkdmOW1LMlIxbTltTi9NMnU2elZsZitxZzJENDRz?=
 =?utf-8?B?a2NUQ1pHTGlGdTVER2txOE5CTmwrbnMySlBZTlRqNGdMSFJMdFFTa0xHUFkx?=
 =?utf-8?B?NzhXZktLSXVsZkRYZlZhSUh3ZVFaN25FR3FXdE1MRG55SGZ3Tkp2MWRkK1ND?=
 =?utf-8?B?dDErZjlIenhwMFM4QzBLdHNrS21LZzVpMEtkRFBTU0h1ZzVKVDlzeXpQMDg5?=
 =?utf-8?B?QmdVenZhVzhVU3Z6TTU2VG5JRisrRjNIOWFhTzlaVUtSTVBDV2JIcGlpdzYv?=
 =?utf-8?B?SlJzcFdoMjZuOGZESytwUE5aOE5TbHdnOVFOMmhCV2s0NUY5eFBkU0UvWkIv?=
 =?utf-8?B?WlZ0bzNoYXBsMGgwZzlob1VHWjB5VGc5TThzS3YyRlFiVGZlMnhLYVQ4T1dm?=
 =?utf-8?B?dXUyL1F4NnhGdDhjRitjRVBPUVphNFRHNENQaENyUGpSaytvaDFnOVRmdEFU?=
 =?utf-8?B?VkFTS1V0c3Evbk9HTkdyWjZFT0U5VEVDa25ZaXZpRXhDZThoM24yUmdqKy9X?=
 =?utf-8?B?VHoxSmNZUjZuT3ExQk1semo5VUtPTktWczNBRCt1amp2TjlaRFVteFd3cWJW?=
 =?utf-8?B?THQ2Tk1kaXlaS0xtYjYvN0VoYWxmN2I2TFNVbGowYWlyWFdQUjE0a3dXWkNs?=
 =?utf-8?B?U2VvbS90MjVuVVl5YzZoOTJmZVNoK3dpTkZOeWUyb3hMRW1GODFudHNhTnNM?=
 =?utf-8?B?a3hkV1Q1UHM5OE82SXUzTHY1U0JSNXM2bWNwazNmbEs4eCt2Rml2d3luT1FQ?=
 =?utf-8?B?aVRKQ3YyWndPdXcxUnM2WDlaTWFMYlBqd0JLMkhuYStqKytQSXVjcDhFd1h0?=
 =?utf-8?B?YkZERzdKQ2dwa29SNEpjd2YwU3Q1NXo0RjVzV1hjSXB0Q2p3TkxESVNlUTZj?=
 =?utf-8?B?SFdUZTVPV0Yzb0wySXdubU41d0lISGZZR2lNMWgyMERScTdnUitsSXBTNU5Y?=
 =?utf-8?B?TUhVQ1RTTXFhQmt3cjdXclZPL2gwVTFzN3FBcDFacmZNM1M4eGU5a3RTN0dB?=
 =?utf-8?B?Q3hSVENlNE9jTkRpZHY0N0N4YVFCUUl6MzVqUkFoT2h4V3B1dUNlQ04rQkFl?=
 =?utf-8?B?QUhEMDl6b1N3MENuaERIZWNrQ29ra0QvTlFOR1UyeVYvcFJnMWpXR2NxQ3BY?=
 =?utf-8?B?cUxrU21DZDBaNU5USXpPckp3dnRaVFVlK0hPbmJGR2szUUdaUjNac21DNlJ2?=
 =?utf-8?B?c1UzR054VjM4TXJQcDRSS1N2alFIcGp0REpJWXAvTHYvWUN5cGJOUm5mei90?=
 =?utf-8?B?TENuZHphNXc0OVRiaUJ2c1RQaGlsMkFuU1YvcUtESitXOEZZYlFOMGNuUmlj?=
 =?utf-8?B?dnJ5ejVmK3N0VVgvbnp5NklBYXRRVVptQ2tDbkE0eFNBT3lMamtPellNbFM1?=
 =?utf-8?B?Q2JTTDc1VUhudTNEeDRpSUlqZVJYaHd5clkxbDVtazc1Tysxdk5IMksvVWx4?=
 =?utf-8?B?dEQrS29SSmdYN09obW5nQll4NHQ1WkpBMW80VkJIVjlzTkw4cm5qNC91eFNP?=
 =?utf-8?B?TGd6YUlVclEwVmlEdEVrWTV2SUNPYXljcDdodnlzQ1pZaXlsTm1WRkRVbE1q?=
 =?utf-8?B?M2pyc3lTN1V6dG14a1ByZXNpT1FNU1NaZHdBZERHRnZTL1o4WitqdW10ZVJ5?=
 =?utf-8?B?RFFGSjlVUEZ1M3czZUl3SXAycGIzVWhTbE5BU0tCczhyYTNsMmpTaEI4Q3Zp?=
 =?utf-8?B?NGpQUUVQa2xFODIxazZlVjNJVFJpN1pTRVgwdzVncGNHR0wyME52UXNqZU1j?=
 =?utf-8?B?N2lxb3pqVVpGSFV6M2Y4Tms4ZmsyZVZwS3JtcGhxVC9NVWpncWpLVHlMNHdR?=
 =?utf-8?B?MUZBRHB2VHlBNjBqYTlPdlJRdTJ1NnhvYWhkR2Nza3VxY2YveXZoSkVsM1Bw?=
 =?utf-8?B?S2pNNG1lQ09idjZ4SWFvZzFrdUROUDFhRTM0MzVnNXdienFmR0xPbDBQaTJ3?=
 =?utf-8?B?ZkhpSGxJR3diL0RIcXVnZHFWR3RXWThUWDFqai82cXVYaXFsa2FSVnJQNisz?=
 =?utf-8?B?OEVYZ0Y3MkNoVCtKREd6Y1ZtRHU4eEtsY3NVUkdKOHBuS0U5SHlYL0xoa0FL?=
 =?utf-8?B?MUErRDh6WXljRG9kMmx5NncwZnF3NllSVUg3L0syOUtXUGhnaFMrSmZMZUlT?=
 =?utf-8?Q?ZVkkL1jDoByWSraXGaCtcNI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qf3Zb+QK//AHyycJ9WBMewlV/+ue1I3cDai6rzY8UTPzeTaBktWuK+P/Kko63NAeZdOIeTTn8BpdOtqPquE+ZFrS23CAngl6SB35uzlAsDEL8pH7Yg1HT+NCShASYKYG0H+NJgUit77T3BANZaC1qotjpsmlU2NaQfkBy7cimrruNgR8vZ6uo01rMu2wRP/o5ObFeHfntfh7MbyJzNHmqifYhHfPz+e0B2sYtfe84MvjrEQ8xfJQDWRL2fxNnnLh+Xczo3Te281sUz+nJOk57a2xEnxTwnapY140IObsZS8l1hx/oPyl7hN0xZOH+1FGrnFDZfTkz/uYWxSu81qATQwP7hDq5BUAfRAYnnpj77EIofTD2YEEMQEmkypPVmeWyo0YaBjlZbeHi6vd25wVMZGxaO/vle4xUbp1yiVywviQq6+nUdEZhRYZtkc7r+xzkiSPmhluJbeDl5yIx9QrO0g/wQuDvoT/q5NY0yTjmZ6XzfYGgo3Hyd8Im1yzdpUdc+8kFen4myI3bLg5SA7wWvFlDXyugl+gyXi7i6k4A34dv1xyKIBlw+iSXaFPsvqfKmQGxNrJg2+YBE+1XGLR/IaC/H8a4GY12PIILXu1aDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3643b4d7-232b-4fe6-8a46-08dc2f3ab2bd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:00:33.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaHAlwYOZB6vR4nzf5AWXUjQ4YAObS8hgrilSe+eEzA9Qt19UlQc00TuH5lumfDgdDDKZxJ8/CA0zOY1f12wA78PP1KPJRNibiOexaKzmE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160173
X-Proofpoint-ORIG-GUID: Xne2anwvDyNg7ov0bASGvLVkWpXSSDUF
X-Proofpoint-GUID: Xne2anwvDyNg7ov0bASGvLVkWpXSSDUF

On 2/16/24 1:55 PM, Matthew Wilcox wrote:
> On Fri, Feb 16, 2024 at 01:13:18PM -0800, Sidhartha Kumar wrote:
>> Use migrate_pfn_to_folio() so we can work with folios directly in
>> __migrate_device_pages().
> 
> i don't understand why this would be correct if we have multipage
> folios.
> 

Alistair mentioned that he is working on order > 0 device page support so I was 
under the impression that currently device pages are only order 0.

Thanks,
Sid

>> @@ -719,33 +719,29 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>   					migrate->pgmap_owner);
>>   				mmu_notifier_invalidate_range_start(&range);
>>   			}
>> -			migrate_vma_insert_page(migrate, addr, newpage,
>> +			migrate_vma_insert_page(migrate, addr, &dst->page,
> 
> seems to me that a migration pfn is going to refer to a precise page.
> now you're telling it to insert the head page of the folio.  isn't this
> wrong?
> 
>> @@ -753,13 +749,11 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>   			continue;
>>   		}
>>   
>> -		if (migrate && migrate->fault_page == page)
>> -			r = migrate_folio_extra(mapping, page_folio(newpage),
>> -						page_folio(page),
>> -						MIGRATE_SYNC_NO_COPY, 1);
>> +		if (migrate && migrate->fault_page == &src->page)
> 
> shouldn't this rather be "page_folio(migrate->fault_page) == src"?
> ie we're looking for two pages from the same folio, rather than the page
> being the same as the head page of the folio?
> 


