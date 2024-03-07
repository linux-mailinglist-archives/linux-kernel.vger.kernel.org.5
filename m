Return-Path: <linux-kernel+bounces-95565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77682874F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A1E1F234CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798712C531;
	Thu,  7 Mar 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avzTPkCv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m8msBu8q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201C12A154;
	Thu,  7 Mar 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816648; cv=fail; b=stArhjDXhlfOzGj1zlNdWnf2pWMRLDATQmR/Qq7KDjyykfSZ1EsNsoaeQ02Vj8nuyi0YL7vy2rJT13u/F6R8DjEg2E+5xdis0kaj1j/fi5MYIiua/XLO6ZX+dg2XLjfcpbF3+STYz/2NTK5A61S/GhD38ahtPY6yCDHGaRPgD0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816648; c=relaxed/simple;
	bh=9BDruaWuO0r7+PFYmNRNdjP1FFHyMlq3l/o3+CY9520=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kNzPUMBpR3YcNzbt4d8bimx7C+eFR6y+qhitC3ijfXI7ld68gANRdfsdYjgrV0M1rssVNsVrweZLkKmm78OUzD3XL/ea1plNZG+e6dfp5fY4CAoel4DMStfUEkRtf1QmIsyyUWmCBg8Qziv7HQfb3gzAbWtyzhs6mcr1Rc3Mm+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=avzTPkCv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m8msBu8q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n1LP019127;
	Thu, 7 Mar 2024 13:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kp4NcfQDoTMlwlaO7gQW3cVCrZyjHtpy1/q+AopxSZ0=;
 b=avzTPkCvHrlgvD30IrHDrHg6R2u00JD8KYQZKGu8mSBLQPQGHlkaCbGQDy5ciItxalTo
 hH4vx1if5C+U2oT2N9uJCpXcWzjYlErDzS9K7sEfgGtNE/Csf1ewDiFbjNUa7+/DXw0d
 9zWgw5O+cuIeYi7zaBz3Hji9QEP7FkQpuOqjwwehlkDegjpiaUGg8Y41QB/uPzW2gEJI
 BQi3Yv/rYu3n+R5tWsE9AIQBTCX2x4kR+m3RTDMaKVdUxcdGIaxZ61C5n9/LTMxCTJt5
 tgc6Qt3C5W39EuHv8VzmSFC/mvMR7t2i3kexKFW6eEifC4cWw58W3rSb6/xvrOc3BuHD RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dm2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 13:02:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427BVRLV031985;
	Thu, 7 Mar 2024 13:02:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb68p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 13:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlToNqntDNB7iVpWidTjsMILatr4OFWlDdF0wg/s6fvjEvsvfaUaBrAbbmRTCxXd994hL+WAnyGW/8s+4DPjReBCxk93yJB4Q9uY7tGicSkfe7IbP0gGKiPV6XB28hyzJqcqVNMhfdG2jKE5nHGC8oJVuH/SdJt02CMRA2arCX3YsFxxnNku9yA+VkFsSLYdFZeS1QTbIVMFgJk1BAaVz19f0NwEfq/dvRgh/TLZNuEsHRj1ArExNfNtIB8Jcs5pXIBehSggNqiyclB+nq7aSpkaL7qdO+ybUyNW1CloBAg++NlY5Z0xX7bwht+db1JsXH0cyUFvi8n0prkzSig9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp4NcfQDoTMlwlaO7gQW3cVCrZyjHtpy1/q+AopxSZ0=;
 b=ksFfvTl8CIOLeHOagSvTqX+xQeSKdAAtcK9CnepdbsJYPS02H3zEqSS8MW5diE18eXDYoRMApM9xqDDwS0IRua3QtQh4X/j7ooj41nqg0R3GbdAXaMEplSO+opUgEg9kGEJiCX6PZeSoZPeqHcebrIwRQS7YwYweje/Lm4ygpdmrbJSevNoAMnZDtSuiaNtD05qcY1RPzio18odEmoylBKSlHrvj7FtC/LNSjaat+wHZRfzai5YsRTDRAk8vLEIUPb17uIww1Qygcn3JROi1kyiCJIna1QPJ9tCgZo3qXJat+xVraQFV7iBfWTCt6w2FmPidhtqsTm9XrVA9/q1SnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp4NcfQDoTMlwlaO7gQW3cVCrZyjHtpy1/q+AopxSZ0=;
 b=m8msBu8q70GRVbr9cZWxgKYUK16TzJQkd/aWLSWSXPlP9OWRT/ZiJa8NxV7elSIDYA2G7J03kNZa/i4yeoaVzbMU7kIW5cnfqYwkhAi3QRkabD9rgrE/hTyETa0uDXkhhEe82xJDDx7gu3gOdj9YURu7tg4Yq/qgcy+CqSBSfBU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7495.namprd10.prod.outlook.com (2603:10b6:610:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 13:02:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 13:02:19 +0000
Message-ID: <85ffb1f4-75d9-4ac5-9be4-9f80b122679d@oracle.com>
Date: Thu, 7 Mar 2024 13:02:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] perf vendor events arm64:: Add i.MX95 DDR
 Performance Monitor metrics
To: Xu Yang <xu.yang_2@nxp.com>, Frank.li@nxp.com, will@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, imx@lists.linux.dev
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-7-xu.yang_2@nxp.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240307095730.3792680-7-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 40442c00-3613-44e4-941f-08dc3ea6d1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bTZ7DwKZRkYrYUzBzZBZZuZzAkjuqihlOr0iO/eKztk3HWMWwHs2mE/KKcXdkoRwRnP/S5l25+iIs7AJKqdicTZbWIAwkZdf279z7Dn0rRarKfo6o9v9p3QU2yTvPJmgeupMPexrXjnS0yARvHBipKGm9Vn0i9Gm6/qBdOdQzKdPcleLP4GMZY3bTIzG77M9f6NvufXZkO8D7AW58BvhBj3UTYYCzbLUZOHJBmgUo0erC29lPs6RjTBlah0SiQw3KF7TYHDDQOHuq/tysNTPrvCdJ01T6sJqsa7HMZJc+fuLunOuFTOcDT16v6K9hXwj0unQqvS329jOmNbuef6vcLpz7iunc3yRunK8nC55I0v69jypQhT6Q5nNaw5tghPoiZ+FlINc+Zoc48j6YFqQCu3ZRuB22LxSlp58lWFJ0W5A4QsEHXdBZ6Kp2B8qKxFnARuldYUUuV7kX8TbzU4JFqisZRSy3s0A63RsOufH1/6vXDes5TKtTUvXgAI8UXulXSkTXr77L8BNmEMxfmAA+K7rC9R8Pl/lUAXndxg6zOmNYnpMLfOPsYox9rJGEjmlOVrEzkoNaPYxBVH7ibjDbh4T5UrHsHKrOjTUFUBy3AWjYkckOc4HEJTyRgChgOC8ybv3IknrVThX/f+pTk0DMA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUFpM29zU3NycTFtTzlrS2NGZStvblJWd3EvaDA2cTg0bndqR0lFK1N6cmY0?=
 =?utf-8?B?bml1V0dkSCtNcyt2UW5QUFBOT20xb2ZWdUY4WHJWekFIMVk1UDlqaWxBUWgv?=
 =?utf-8?B?RkRMZUhRZHBlTnhTVCs2VEJHWEowYXhSY2lFck11Ykxhd0ZtU1ViWk15UjUv?=
 =?utf-8?B?dEp5MFdmeURrMXlQR25LcGdwSE9rR1RYbXpXeXZTMWFScU04TmZialM5Wk9K?=
 =?utf-8?B?ZllJWmRpRy9oM05Gd0F0WU5vUjluUVFLbUxqdzJOMzRvMXhDVUV0WDJKQStP?=
 =?utf-8?B?VFRKTmtQalZqZmhreUw1aG9GQ3dHZmU1WXVmM0pRSUYyY25KbHIrc1Z3bVFx?=
 =?utf-8?B?bFNsR09qZHJuR0NOQkxqdURUbi9kWEhXNGNsTHZVTXUzOWVZNE9CQmpmaFBq?=
 =?utf-8?B?eGtFaDVWcGhWMzZGakI5cUh3TDNrZllYaVNSRllIMWNQK0c3a3E5YkhoMVJD?=
 =?utf-8?B?M0ZRYWpCck5kNE1WeE9uSEg5SjNLdTZjNFEzeXMxZ3FoTmgrQ0ZicjRBU09Y?=
 =?utf-8?B?TlczYVRSYlFmMm9kUVQ2eTJuWUI5aldsMEtBeWJ1L2huOHhNeVZHQVZKbE1I?=
 =?utf-8?B?UDRrSWh0M1lFQWhFNi9TU1dhVEhyU2dBY1V2V2JYZFlyazRnT1N1TndhWkJ4?=
 =?utf-8?B?T3NwdFNFcWF3dWNOcHdzMzVmOTZsRWVsSmdiYzd5N0FGenpUK25hNlFqdi9H?=
 =?utf-8?B?UHBwVWxnYmxQYU1sR1RHeWtPaVg0STVyQlRoMWpkVkZrTWJPMTlqd2hPNkdk?=
 =?utf-8?B?WkdFZE1SamllYnNvZU1rY2ZaanE1R1J1TUFlL3g2UlB6M2dBYzVuT1orNnJK?=
 =?utf-8?B?a1BzcGl5U0p2ckVyVlR5V29ackpDZkFIaGNEYUpXRXdhZE9pVVdqZkdPMVRu?=
 =?utf-8?B?clNRWjcrM0NOTGVUZFUzbTNvQlpKMTF3N2I2Q3Q5Nk5KRHZYakRRTTlFVENu?=
 =?utf-8?B?a1ZsTWtaUFBSM1BrVVhKT3RLeU51aGtXUG5ra051amRpL1Q0Z0gxUlNDNjhQ?=
 =?utf-8?B?NEE5YmxHMGVEUGV5VUh0VEhreDdOblNpZnB6OTNOYnFKaUp4YWJlUW5NM2dZ?=
 =?utf-8?B?UjdaR0gvVFdNS2RNOHp5cUtjZUIvbDJRczEzMURwNkJ2dVhMdi9LS2dFcVIv?=
 =?utf-8?B?SDVhbnRhcXhvS3BzVGgxd25FUW11alFoQ1lxd0R1SlRxQXIrdDIwMU84dHhB?=
 =?utf-8?B?N0tQOEZlTlRSVmZ5R2l2Y2ZHTXdPSUhCZDNvSm9McjZROFpLNTMrSWRHUC9I?=
 =?utf-8?B?N2hyaWVtUGFNU2dRMWlNWVQ5MDhmekRndUN0YytieEYybFBSOGk4aDc1TG0r?=
 =?utf-8?B?VGwxNEZSYVpqb01ZNitPNit3a1NHbmZCdzd5aDJzUUpzbXYxOWdxNlY1M3FC?=
 =?utf-8?B?eGJ6RzdiZmovWEpOR2pIMXUwRUQ2V3ZXTUdpNHEwaC9vZlFPVmVYeWpTYUFz?=
 =?utf-8?B?UkNac1VLaU9tWHZ2OEgrVWgxVkJBZEJPTU0wek9PUnUxL1VkTUFzUE5VR25k?=
 =?utf-8?B?amJTdmZWc3VFdlhwMFNpS3JTSk42RVB6NFZjbWk1aFpkVlRjY2xCYUd4WmNP?=
 =?utf-8?B?NEFaSEFDa0xEM042aHdQSW9LdjNQYU9UWWkrWmErcE1oODUzQmRiWjB1NHIy?=
 =?utf-8?B?UytoUEFkZTh4VldmQ2pGMnZ0STZBcFlsNEsxQ09PYUEyRzhEZ0w1U1dFK01y?=
 =?utf-8?B?azZ1Z0lxRWl1eFdnNG8zMFBpQlorQ2lXYWhteGF4SmJ2WTBsVTdtTHFoRnFJ?=
 =?utf-8?B?VG1jTlBjZmdRVDJGdk9CT282WjJiWXVKZkFtZHBXSWRRVlZKQkFNY1IrTzdp?=
 =?utf-8?B?ZCtHRC9iSnpaU3Q3bTVOTHl0OGZ1Y3dOVkRnM2ZQM2t1SWxTMDhQNk8yNWlj?=
 =?utf-8?B?L2YzSHdMUGp0SHVmbkpwajZqMzhRNHZYV3kyWFZqUXk2UUhYV0FRbXllbXRY?=
 =?utf-8?B?clZ2RUF2KzhHMHhsRWhWVzhxeDlOVDRBWWZaKzdBbGZZb0tDaUZtV0FaMmNl?=
 =?utf-8?B?NnRPZzhkRTVvR05Oa2Y3RWZOYTRyM245T3RsdFFYbWJYSU5FaHI5eXBsVG9R?=
 =?utf-8?B?NTZEWG9GcDRkNy9xTHB3QktRWnNDbEtvTVlNSFhiaEpTSm1RdW5XWnFaaFYr?=
 =?utf-8?B?NUlkcDVVYUk1MFd1ODZzS1MzM1hSVTZGODA1Nkw5aDBxd09YL3ZVQ29IeVh6?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CqovrHxpQSL8jDC0cvMMFemPHCDLGIAmXxS/AB3R6L/cSOHYIPkrlwoSzq9FQvdRM8NtbNW/03Nd2XFIodVszg374dtGOqyFzLfqsgyO0wsR822bItVGdh8USf0O6jh8inxwVi9vVB0eCdZkGygTp82Vz4c9DVW7Gl9YKqQxtY1QpScPCrdR/iTqR9cw3qdV1dlxxguBFz8viTqyP171HcUVnoUmwKpOnZO/MrPdPRaJGiA4kMu6hsJumZ/41e1RNovjAf455gOKdL+GZgbTzoJjM0uIepLw62koqOHIquYCzVufIH1tKz1DqtA6FaGnweUHnfIRttDjDQoXtU5mevKh+MGn2GLXBIhlVhtg5ONjftRXW4jxEp7h0sYsdP1Cv+EWeaKWfaDKhm5QOfTj1YTgwmt6AZbvbTwEfAzf4VU/CCtCHjNU0T2cqXRC1oIi8T22g7GJwLxYfXhMVAdAJAQ19pYhhppWjVKaCh0h2kGsthSxflstmuvYRYRgZg8iwhwXfUmS8p3894bbr8DtS0XTFsvwJrjWjKWbMlflBL3+Fjn/xcQPelTmcjquhph25j+EcMiDSmysQ3N93prqLn0a9Fd1zyz/EkSxvy1tqEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40442c00-3613-44e4-941f-08dc3ea6d1d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:02:18.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHktPmVa6cxVmo38Pt0ErnUgqIDwGprOI4q3h3NUENUu+Jpev9eZ/NIgUDRtka5rx/ctV1IsrEOujKI8tdQQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-GUID: n-6QZKdnaBOYuzKzpsmEyIQDMkjOlv4b
X-Proofpoint-ORIG-GUID: n-6QZKdnaBOYuzKzpsmEyIQDMkjOlv4b

On 07/03/2024 09:57, Xu Yang wrote:
> Add JSON metrics for i.MX95 DDR Performance Monitor.
> 
> Reviewed-by: Ian Rogers<irogers@google.com>
> Reviewed-by: Frank Li<Frank.Li@nxp.com>
> Signed-off-by: Xu Yang<xu.yang_2@nxp.com>

FWIW, Please note that I gave a RB tag here:
https://lore.kernel.org/linux-perf-users/dd69cee0-ac14-4e20-9255-367240b1dbc8@oracle.com/


