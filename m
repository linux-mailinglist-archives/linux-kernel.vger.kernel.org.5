Return-Path: <linux-kernel+bounces-85520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C393086B6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE4C1F23F74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4D40855;
	Wed, 28 Feb 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n4XQxUJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QgByUmu0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4879B6D;
	Wed, 28 Feb 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144250; cv=fail; b=l+JtlNZpoSrNFTdtymC8z5Bcx1zS9IYDOwLnsUw1l2BmxXCdAygWmqs6MDMZz5MR+RNldnKwgXdgKswwC/zh08OpyBy40xnSXhHRVi4RoZ4iQr3BOFN5PkBRJqeVIw5Bei/w47Yp/sdoTvebik7gV5qI2CPoI8nfvlKNd79AqX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144250; c=relaxed/simple;
	bh=TuKPnqYzVWvL4Ru48lq7thTwk7BcA+X3NtKsf/gi7cY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3TgmkH/S7OR1cxg3+WP7BYKg25iZ4kurqtGpw+FIAKm6CUB/n0Fg6bKx2efpRKvhdOvCvFHbDo25Zn4XZTDqIEEUSzxWYMpMr/n3JLV3I1uBKAnukxVWmwgTPCw5D8lVmudzO6THOALw4oE0tPogFJqfO5qeXAkSHW6baxut6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n4XQxUJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QgByUmu0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEElH5012890;
	Wed, 28 Feb 2024 18:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=x6Sl0KfCAseqoNY1sFeu3km1rrgivJ/2SXKHP51OgXA=;
 b=n4XQxUJigTE/QfKGtBvjxycZ4s8VCeJaP3PVu5NkWj58xBifSTZinatkz9G6bMoeRGBI
 aH0iyDVrs09vBDKTbMfFIdmUzTEBsmjWIHb2T1GoEJeZT/Hgg74O8NwGaJfLL6bJwqyX
 EMoYcRzAqDLja99nOL1+/Q9kTrX4mufrhmsHe5Oe/vrQ6m/+QJBhw37P69s+zaWu/5AB
 8V3sUFKHnnrbTb/CSdd0mnYVAnIZsVQxArkovvmYGK08652uaskDcOJmFEvMSOmnST+/
 8u2d4Con3X2TQriujltW9MPw4ZKK/GUp3bMad6lbCCkiYaRFhnt9A6s2SxA7dZtgOhmH /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784k9h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:16:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SID2U2019271;
	Wed, 28 Feb 2024 18:16:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdn4c29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIFDExdSR+CJngIoCjavmkXcZczhDcgTF5EDHVBYmi50PaBySeKUCK/MXRQrFW6Q8AG70gty1jbqOaKrVt/SX9dO/2Sxak7id+kWg1RnOW1TTpBBLgA9NbVnTlqY2t5em/7QdsMoRKr+acscGlv8Tt/NUvqeIOCm8zlG2Mt7wBhMAqiI9GcuzbLY1K/8Q9bZ7jlP64N3oX4rX+Exy2WUZ/E6ES4zLW3KTdW3q8yYvcQ+NemJ+u7rFW2KxYJJKiKlHD40F58J8bK/4cBpsD9GFilzKvm98cWvB+ruD4akOJk2d1dHkuBqaz5UaWZP6e+nO5+rMaRMHJ0OmAxDF1Oqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6Sl0KfCAseqoNY1sFeu3km1rrgivJ/2SXKHP51OgXA=;
 b=U8hJ6GIDoCdrcZ5YJUncj8R/h2gci5wXMJl+/FUvW3EmpvxVyzSkxwSwqBPtLSqoiLgKAn/UnOL0SwmTlGIMITkAUl3kO+38so8dtlrzUacQdfS+BuPgnIsg3W92+DPeMHFfAWqxm8mSQNMdIuJgzUr86zphWZv7h9IwnUP+kreKMQW9nB0R+B7CXj4/TruvOIRegeNhV/4/ESMsl7C3Qf6Orky0yubOYKLs79aWBeuKz+FciRDxc5LOW8DSIIubI1bXdGszPc+0DT73Ni3YYzC9zsLZ8Mf/zHMrQCR7tSc2D5kfR8KSsS2IUWX9e+PaKRWvp2FSGuT6X3opAu1Y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6Sl0KfCAseqoNY1sFeu3km1rrgivJ/2SXKHP51OgXA=;
 b=QgByUmu0OYGFDJn5jNa6FSL8vBxHPlWFK7VKD5/tsImFDjKTe3qt7jwXcTFUoawpxtEU6Svzq07FhO5Tu+pwuRZNEkhlH3/INSfpuhGeFK1dth0Vh086CqFE7qbcrOENszP444BG89sEWxnxgprzNbunEi02nX/bsHg8WNuISx0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:16:55 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 18:16:54 +0000
Message-ID: <9258b13f-e48c-42cd-8b54-26de16785aa0@oracle.com>
Date: Wed, 28 Feb 2024 23:46:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/52] 4.19.308-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240227131548.514622258@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: acf50fb4-a682-4511-24d8-08dc388970f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MBWTBuQoKGKa6dp1RBDtwyfG3pXDW3idwcPJxfvzDSZX4+Ve0Dy+VzqbIgVMc0cWZ217mna3iEtd5Pfox1YK/fTQqgn/XUoXBljOtgr5oCHPYMpJD9ZeRdACJBIl3+/hWFGxQ73uzud/PXjJlCCim6IsKK2PDStQg8TUhnfSdQux1cWgf7JBxAXZdf9BlPu60ZitI/nKvdI7V7V3pAbO4F1ysAaBcFSniWesmBhHDzA/JpaPEJEqIhii5KnEdriVAoBP7AOkU9S9In08Zgy4r/l7Sk7N2tfhvaaTUk7kyeTOx6etfYPDS2PE7mIN7hIRyZZBjLucHRFBlfYq3NcSfeNfkCsEcZ5SAS9vOF253MezgNCEDBxOSBKS/whtKcHvs+KQqs31JN5Ak0aGsC4legjQVAsqUY6WI8lPijzPDwIOxBRlNsNOCZpvAAPcJ6UClfYwzkBiQJFefXRZb6jf3aV/qziLzgFn5gDF6Bq2KtAm17gQgE1VWf4QOPep5v6ewAZR/kACQCB4sQD+MG/LbpdKs1teImV5itya2hSvGMGp1cR5to9c91x5+VTvNUeL8nhbEq8zF7vDFuMw5knSJMLGwbmRqUCoDbxEe77SXhpNW6y7sjTbslczAP8U3C3g
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eE44RlJGQWFqMm1TaDk5cUdIa1hkNGdYUUhqdFhZMnRYZ3JvQmFQT0Iza3hs?=
 =?utf-8?B?dTlqUXMvc0xBZ0hLSFZUSlNtSDBCUGEzS2UrTUl0MUpCQi82Rmc4d0h4NFo3?=
 =?utf-8?B?RTNuazhKL0JHeVczR2dnNVhhQ0VsM1hqditvQ1NnMVdWVjFNZG9SWWkwTlZC?=
 =?utf-8?B?Vk9raGZuOEhuR2UvSkRnUk5uVE1yNzVUY0cvY1FpOElMNW5DZ3hPVmpVMUd5?=
 =?utf-8?B?aTJDM3JaRC9MSGVyOGdIbkdLK2cxd1hYYU10MEcvOEErK2dVbm9DMm0xektw?=
 =?utf-8?B?MWc2aEZyeklIMnYzckJZbGFWUEt4b3JjMnF5ZXFBclpXTGRkRXQwS1RPaVkr?=
 =?utf-8?B?K0tHR1RyYTVlVFZUNWtTK2JJZDF1Y2hPbHB2OWVMdU9TcmlJT0syUUdLNEtv?=
 =?utf-8?B?ZUM4U25OZXFLd05LZWFVaFQwT29xa0dLcDFTZmRGSXJzb2phQ292VTRRK3I3?=
 =?utf-8?B?NUlkNHY4cHdTWWNyeGh6T3l5c0NPNmFPZlY2N1ZMZ21KUFJ6eVhqcmZKTUk4?=
 =?utf-8?B?TWNSdkp2S1ZrWUp6T0FmemozVHplTVh2OS9XQlpwbmFiRlNBV0k1dERieWt4?=
 =?utf-8?B?ZG1KWEhZRFdDVWZCeFNrZ3dGcTRyM1I3K3pxK3JDL0xsNXUrTHl6ZTFXQzRj?=
 =?utf-8?B?QXNlZi93YmIxT3RRRk4rUHZKVmpTdGpSQTUyc1o5RnlZQ2JxRmVmS0w1NlIw?=
 =?utf-8?B?ejhnODBXMGNMSjNJL0ZKS1l4SUpFUTlYNkJCZmJtaisrLzFiRlErWVRMS2gy?=
 =?utf-8?B?VEJ0OVhoZjcyazRoM2t3YTVwRkxJM2FDVWlCVU1KZjB5SFZoRU1veTE4b0tU?=
 =?utf-8?B?QU9Hc3hGUXJJV0hLVUFQa0hmaldvQnRncUVGOGoydVZKbmNaOTJ4QXd5M3hG?=
 =?utf-8?B?UkpjTHY4OWtab0g2czJGSzBmRjhCYkNBZ2dzOWZwQnFTcjNnbnNTTmZIWUlQ?=
 =?utf-8?B?a0t5cEVmTEdxbTg1cXcvb3BDMThUbm8vYlpBdVFTVi9ibFNFYjNwK1Rzc1hp?=
 =?utf-8?B?TE55RzRnRzhFN0xyRHdpSmdqVFNEd1U4b0RBRkhIMmxvbjB4eGpkSG9uMGtp?=
 =?utf-8?B?TEpzaWNNUHNLVjYxeit6V2FGNndrUENvS2NOVHV5NXVtZVY4ODluM1RrOUNv?=
 =?utf-8?B?SS93eUU2WEU0akVTSEx3VGRNUjk0L3luVS9RMjlwRVBVb3RCRlNsTGFCL0ZG?=
 =?utf-8?B?ZXJaWHRYMkZXaTRpcU1EYXEvSDM1WGdrT01HM1NSYmdQQW9veHZIeitKaEc5?=
 =?utf-8?B?YnVFYmNEcERNc3FtUUlGQWZYU2IvT3JFNC9kSHM4b3l6NFh6ZnBZejFkYytZ?=
 =?utf-8?B?UDVWaEIyR1pyMnFFcisxWjdaRDZCZXJncms3bEM5ZUoyY1l4T3pERFRKWDly?=
 =?utf-8?B?OFRiZ1NIWEhzbE5YcUxzZytIUWtvTE82N2ZDZFhIOVh4ZWdXOUhQR085R25a?=
 =?utf-8?B?L2FHQ3pJMjdMNnFjK1dQRHhOSmo2dCtWT3NxRDU0Z0JmQ2FXUUVVbERyMmNI?=
 =?utf-8?B?YlF1QW5mT0RDdzFGdTVCOWMzZzZZSHdqYTNrcFRlZDFud3dvcXR0dCtiRERz?=
 =?utf-8?B?UjdVZ0h4ZlZTeXEydSswWFFjbGtGNWMzVVNEMWdieHArUHI2SmJiZG52NE9j?=
 =?utf-8?B?ZitlTUl4L3IzajVudEh1cHJGbWRoL0RrUTJFVlF2ZFM4dHBiZlNYb2dhOEIw?=
 =?utf-8?B?TmhXUi9EcFRBdVFYb2Z6YTUrcnJEWDNjQ2pyUDZlRUVreUYvMzhyaE5JZzlp?=
 =?utf-8?B?VVhnd1lUL0U1d1Y2czF6Z2d0d25obURXNHBiejdscW9lN1ZWc0IrdUxVSUNu?=
 =?utf-8?B?bnhvZDNzVW96Qm5TQllvUnBUMVk4WWZlaXNDTGVUNmdjbWtja0QrbmRRZGhH?=
 =?utf-8?B?aWZ2TlpVZFR2U0owSUpabkZmdHRPTDl2NnVpVXdrVEFvRWlvSWFOaXRMK01Z?=
 =?utf-8?B?NW0wRDFuaENUMEE4Ym1EU084YnJjOXRhVFJxd2g3WDlTeUhjWms4OTJvQkZZ?=
 =?utf-8?B?NlgzdTArRkJCR2xiS2krU1l5MHhHQlN1QmJEOXYwNFhjbytHTi91a3pqOHMr?=
 =?utf-8?B?cFpBTlVoK0hwNjcwWnptNGlvOFpnNzFSeFdjWis2SmZlM1ZMV3dBci90SUtJ?=
 =?utf-8?B?UHhoajdSRDZTcVZvNWFWNzRweElDOUR0Um0wY0d4L20wZTM4MVp6Z0E5UFRM?=
 =?utf-8?Q?zbN6kd9+6rQj38Ls7xsjeeM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TtkqcNn2iqIiw18L8uW2X7HNzvVYXcQY9QEf+Hp0+ldNgvwtmlGzqIiOMb7PhMYU6/x/whUrsp/Qhy6kyUfwAERnX/2rqMCEfsZxy685LhtvQ+4fQZ/AyG8A9FlO0nIottKJGHj+e7lmXDy7lu+w9lwXhbiw9O5VWkDs3zNWTcN+9qA87T42URuMDHtaCKGq0vpPsapRcwaSCWfTW+WRZhohvvkucXJMnz0hDF9BZqQztdNK6OdcDVcvJhQr76DwykYkHTLYmwAjkF5/Eb0T0BU2RjLHDNox6GVfemsZ4VuUDwRWJU+5uANv+4hzQKpjpYL3YEdLgNPYvOFQheWBECmknjjuch3ANXPcHUmcjcNg06sIJZJjTK9z/0hRQH8BM967Wl22ougPQfr/eJAqunmMPkp1Kxu0Cbo/mtTCvKkLsOiqsHHYBaHHXzE8hAlL0IAw0+U728K5W5l/9auOgwsiHs6mMC0vE31gS4Y7lMrpMaPQizVBemyITCIFr/6Cd4IQMSEaYXSxjjOo5L8Q0phpwfQ6KDLg8chfoOMKST1N0rVBT4jKaEUmLFsPVlZzU7OpO0EM5ayXQyC1iKFSJTVMnG0cJCGONt4faU20lTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf50fb4-a682-4511-24d8-08dc388970f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:16:53.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQFykY/LtZAxb3GjpE5G0JJRwUtVV1k41lOji7VLQqW5xLuwV42/G7IqevdvEvPSaZQXGc5bVyL9eQOZYewTpDYrnNOiuGrzINf9zaDFn2a8nPGJe7+zHovl9QA6bWVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280144
X-Proofpoint-GUID: _RsvTVF9scnkEU7jnnnBx7fir8ZtHkGX
X-Proofpoint-ORIG-GUID: _RsvTVF9scnkEU7jnnnBx7fir8ZtHkGX

Hi Greg,

On 27/02/24 18:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.308 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.308-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

