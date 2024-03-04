Return-Path: <linux-kernel+bounces-90185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC286FB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2401F22BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F617553;
	Mon,  4 Mar 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LN7cHH+1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pGxVWLmB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79098EEBF;
	Mon,  4 Mar 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540214; cv=fail; b=pFb5iqGAqJxEjhw2JJpl5z8ukelqlb5egXjZbaUJo2/qdESz4koQI1R2sOoLw6yoKbZe4xWYc6hZUPBJgjXmB5wC4blxi8a7oBfIY4xjbG7KAhd0BgS3S+yGb08NWSUwL9dtd1GCK3xck5MwSQxCCsw9D5xqVAIXKbZClO+iEiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540214; c=relaxed/simple;
	bh=3cfHu5DvwQEP6vfIpGR9a6G9vTV7T4yBNz5sDN+BUHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtlSQLt5vaRw/JT2BQO1HIOgcdMYkLnw464/3w2MPF/okzfoWadYHTMzwXGNt7Aqd8USajN6aAgZQjiyOQQMNcTr3GQ3s0XZbm1xKak3UG0iYYVt4kXQzhWFoWZwzFuFJ1KtQh5HluZ5zz2lNPHyLfRssbwSlSKc83dORZlic+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LN7cHH+1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pGxVWLmB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247hoLi031605;
	Mon, 4 Mar 2024 08:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=LN7cHH+18eMVwPuo2kXn83G4pwSgtFEpxseqvVcxlz3RfGlQ7vmHbSyo2wTF+nBOqd2R
 L2LMTJGDg92OTXGLkrvJXOqiC7jhLZjibEiXmahyDNvZXjyIOhrUxAWAl3p6+1kIjE1g
 tISugoCjJicES9NC8mQYUWgI3yMA/ipAEkwU/PdeaCz7f+h2Et8mqlEaauhoWaKIMQ1o
 4H9EiMBqLSL0hodbFspFPOCrxB/P9zVAyVkRWvi7fI5ApN5rcRT8epaP9dnIC4FERqYC
 O6xGL519v6svZHtOQCTjczCUsEN7oAEqthM8ZjthZTxnRYHFoiiuENniXlpPL+RPcn9x QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw42jus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:16:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4247Uu6o017031;
	Mon, 4 Mar 2024 08:16:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5dqyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+NgKbfbhvUFKyGxarms/K5IdUB/5IWDI7xkyo03frCnSunm0/HE7BONxL6LKcA+1WFmk2Bhz8So7LuJuCYrmrbCpub6pbr6SWwPu8Hf/D7+3IRcPnWXwx44heVF2WpY8ZZZOEyJ83OlMfIaKLxC6rFr3DM5jWf2dN7gAD38ZQgFCEunSOkr8/f9fvDM32aVb+jYO8ArOurIhz5AqEOBlJ7Hzg81/bnibPLXSWIteXibAhRw2DYFt8L3nIRgEAomlDEHHTWfArYMQF1CDKkNo1hvcnO5gKI8Or7L4WVpfIh9VsH/JgpClHuU47/O/U5EnbMokz+32ee0j7uX9BGi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=iEMCuA7Y/dVUGG53KXTlS6ikEWtm4qyOSpUq5kfwvN1MacY6Ty8pjgklP2bUBCojvQ/rRfTbHFN22mccrtVGOBh0zu+jQeWM+r9Kvbtr/CIaLVli/iRu7g/GHwxmraCtTwGCm+ka5TMDQqes6Ai7sXSdkN+Mf0KRpJ4gCm+Rck/g9MyVWV/5fOdvf/kyrZ+0rmagbc8EbFF9pp7F6LQ0QE7a5R8WjSqK2bhDQZ/4Jgh7zg14xCDpMc4eWDbY1PViGfpE9bkuRyfmzAW10hya1rwLeAlcubLEInLgTkD9mkV1Gf/T9YbjeGdxJgBsMxOI78xoHzUqSZydUyZudWjeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=pGxVWLmBQ6M1IT9LDMcNvhR7WeCMDfuNj+78FVgoW4UBkbAv3uZE26Vn+d3gA86M45YjUGIZoPTPWLIq0sMM9RkstpamdYjaeCAHMyqpG0tzVdM5+QokWo/lia5616clig6cukb7xUJqpc4pMByHuwONpvk4XGGBDjevP0nA/Us=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:16:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:16:28 +0000
Message-ID: <df199132-a825-442b-95fd-0cd6c0ab19d5@oracle.com>
Date: Mon, 4 Mar 2024 08:16:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes
 group
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240302201636.1228331-1-ipylypiv@google.com>
 <20240302201636.1228331-4-ipylypiv@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b05e842-d135-4568-9a03-08dc3c2363e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BH1vrp9rJEo2YD5v08cf3ud7EDgAQrwwVi23FgFSiWEYN/GtypXqOPS1J2DdAaE4hFruyNBcWdHDeThCARefuJiFKv7Bxs4aWqqJZF5vEAnzMk4gE2iIDMCkzsT+atqzSK1DpgCHz0c8hoJXxdt5ispbymGP0Ds6fEUQrfscU6RVahIvcGT4mCn2h2ri/wgrN+wHbJCjLvb1ZTlZzuSxNi4neWUQlI4y2QkV3AGxwW/Ywp99O4AHolIAwk6kBu0pQOXcD+EUhK7SRJccT768ZhelPwfBTb9CWfIOX4bQbp1N9NkR/0j5X41KE6K+x/3wgMzSnRuglXoU2awUYs6q0zdpZF8le87YItmmhu9ykJn5WVbFeR7tQHUb7m+YrLlMjdEHLxm7LXfFb+SdBcwFAjgoYLUKuCvtpcazokSkpl56vjSw4c2nK8xoG1IMVfDsh+lQYbf6IUYm86P2T/xuxTpk+SdMX5zEpCAAaKGEQcFgEDl3mruDMzy7Y2iSmrnZ+4vItP+/JYNR74NrnSWomOEym+mQrOv+xWhPxLYZgdwAqlG3yzqDNeDA8K4409TY6fU7andneO6+VEJTKk+VmUsYwGJMY3UruaLp84LD4W9BRJ3Rv8lFuOo8UXi3SYqDOuU0ZdKYn+Emocww7RPOBav+wBoLxInPVfIAgCI17eOca6t1tBB2a4l/+wUhJAiIvw39ZH9T+EAwG516DCu2uw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SisyVVk0ZzZodjZqek1HMHYxckhQbzNoZFhoalkxc0I5Ty9tT2xhL3VGSFhR?=
 =?utf-8?B?Wkd6eEUvTVp4MWp0TnQxYUZ2ckhGL0w5NmM4WFBQQmVUYlBFYmFxWGp3bGsz?=
 =?utf-8?B?eVpXNmRjQWx2Rndqb3g5OGc3QzFGVkExU25tY1V6d1hMM2FXT3FxMU5QRjUr?=
 =?utf-8?B?TUZwRU5Vc0VKQUhYempFTWlIUjhJa1VKd0NneUkvdEg2eGorUGluc2htbHpl?=
 =?utf-8?B?U0VsWk16WkVUa01FZ1NKVkdybHVveFlVOHVZUE9zM2lxV3BQdFhlbDVkakJ2?=
 =?utf-8?B?dzROUTBZcmhnaTUrL1VvVTgxTnBwL2hqbVoyclV3RUF4eHdsRVphdTdlQXli?=
 =?utf-8?B?UUpRenJlaUp1NkVvbzNhL2FCRUFWK3lLdG51d1ZzWm5hcHI4cUsvTmVSQUhK?=
 =?utf-8?B?TWtNVm11UWFSM21udkc2MDZ3MGZSZGtVekZ3eXVxRHlOY3E1V2tJdUtOZWtE?=
 =?utf-8?B?TEhjQnMrU09HSlpXQTBCRi9GT3JUWmhqYWgxK3NneURZL3NvaG9mU25IOXVZ?=
 =?utf-8?B?Tk9CWFl0cFJtV0dCb3c2U0kwSjRRN2lEcTVkVStmaGNmalFRR0lSa0FpWXNn?=
 =?utf-8?B?VzZ2clYwUEZ4S0dIVDYxcWtMQmNiN2pGdE9tb09sdW1Da1BLTW5SWG5za0lF?=
 =?utf-8?B?OHBaTTJPVC9CZmZpRG9nR0VPdk8rUUFsekFMV3FhaWVYRlVHSDkyRFdabG05?=
 =?utf-8?B?T3hiVHZBVFR1VEkwYk5xWHpjdlhEWVJuZmJzSDdibWRkeEgvUTJVNHlJVEI1?=
 =?utf-8?B?L21PdXAxckVoRlp4dVIvSTYvMmRrUzR0bkhKa2ZwQ1JHQytZL0cwVjRWYUZQ?=
 =?utf-8?B?bUtuQ3NqM1dKZHZkMmNhOGpLZ0hOYTZ0YUNjT09OYnFtV0djNFVsY202MFVL?=
 =?utf-8?B?TVk0UC96K0dXVGhSVW40RC9FNXh4ckFMRXV6NHpIeW00M3N6MmtKVFNNcVF5?=
 =?utf-8?B?NDBaWEtNODNCWis0VE5FUHo2VU1wb0ZQRW82UUNKN2dSNEJIWXZnS2NROTVw?=
 =?utf-8?B?UjVDTUN1NFYyWC8vSFVzNnJ6RGVGUWtmZHJDMGgwbzBPTmQvYzQ3NFM1bTVI?=
 =?utf-8?B?bzVPVktxWkNqYlA3cjdKcE4xK1FSUjllYjZhV0ErUnV1RElFcURDdWRkMVpR?=
 =?utf-8?B?ZzBick5ZUkM3UWNkemhobU9pajQ3dUZ2SUI5YTB3ZzZJdFl3UFRlQVMzMFp1?=
 =?utf-8?B?czhYWEIzdXB4RGhuaVRxaFdiQnJaYWxRZVE5ZTFETExYbURTSUlHZk12VE1Q?=
 =?utf-8?B?ODA1cnJPNWNORjdSQS9lS2xNUjVHZ1kyVDEyMFRjWXRvQ3lYQklLdzBNZ1d2?=
 =?utf-8?B?Nzl3SlFkZm1ncUpITTZEbk8weU92a3gvOG1XeGJWQXNxWWFOeDJVWUZJMFlM?=
 =?utf-8?B?bkdob2R2U1ZYajJoVEY0TzBjVG94ZWkzVHZVNkdWUUN0QUZ2MmFBS1FuczBD?=
 =?utf-8?B?cEMwY1Z2OG00RXJrUzZLSi9paGxCa1cyd05nMTQrdzJKNWlRcm82QUsrNzI1?=
 =?utf-8?B?SUZLY0V3eTFZVHN5VS9VL3JKaTI5VWNlL3plejVicE1MZE1sNXVyV2VxdTNT?=
 =?utf-8?B?UkZjN2lGb2c5RzlsUHN0bStGSC9YZjlIazB1bml2enlyWnBpd1ZyZjVEL0h4?=
 =?utf-8?B?ZVlpaXdHQVFBbFNidGlqeHpJd2pBMHQwRlVOcU1FZnpiOFdJSUljaVhnMVZp?=
 =?utf-8?B?RERyRE5FQ213RDBNZW1EUGNaTGZ0bmd0UkRpRnE3YVZoZDU5VGg3ZFJvN3pS?=
 =?utf-8?B?cVNVN2lTL1R3ZVc2NDJlaEhUZHVPeC9hMElqd3R6WkJCbkNUeEZ4UjZ1WWRR?=
 =?utf-8?B?dm53QUY3bmJraFBxV083a095d01uYmlsWUNlYVU2YnZpMFdyaVNDWmxYdFFB?=
 =?utf-8?B?d205Ty9RYm9IWHZ4VUNGT3JNR2tnUmtpdUVqdUlSdHJ1VDBMclllVWViajB5?=
 =?utf-8?B?SnZHRkF3SngxbkpCSWoydjByRzFuK2VnQjhOeVJlQnJONENOYVRTb2lVVHRm?=
 =?utf-8?B?UDNXeVRoSVg2dnoybXVhYVZXOTBtMkVxMWg4dE1MZE9qNVRWUVNHa3ZZNmhD?=
 =?utf-8?B?ajlUazNGdFJXREJaZ2greTZRNS81aHdhOXFVQmtyTGpZRDBIOWNYVXR3NlI3?=
 =?utf-8?Q?ktNfB8JPeRuRqwP6NPO99N7D5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cWVqHjPnhFTE+WST/91kuiv41QiqVKfmOc4m7qcTQB4oqBlFQt8NjyZGgSV2N8f5jg56wYBUyp+Lg/d4zracfLh/iU/RCm/zU6YYJJ/qb7Dx/3ZtSaXVnHJu8hJyFnqFUSXX93Z+dZTy/4XTROnACSVYGUeeznsE7W+IX2gLD3I+UjdFLV/PdtEc9nmZZvsGtHNt5bGEiMT/UBnV6Wxsw++2m3GEmIFll26ECyarr/AUE/3ZR2bD+vrqCVS++HuTbpm0a6gk15ZCeYW+9Relj6pGVr+onHashijoXjFFuZOaCqTuUYSOjt9IHXAyDf/wAtJUgW4vfdRjuwTkGXsziVq0e6wQzSzkTM7sTPxVha72t/akmitdfvagWghdRqrt/nFEP3MCuEz0vRq0/LxJ01NY2UfaqvrHYmImNhZe7U6mHW2HZl+YAnfWcHr+vhg8uf6A/LlRwsS4OisYuuG29o3ZX5tpZ8x/jNorMGW+nBFBc/r7Cmwkek/TXywk8lZe8gFitZS//abxxqBc/rsN2LriX/lIp90D1IkFjuBxzAL1W4WtYYG1Q4dkVq5FuhJER31NMyCR362Ao1pRpfKnznu6jVW23xiiemt2NUDoAdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b05e842-d135-4568-9a03-08dc3c2363e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:16:27.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUgdvOUHRXteiLo1+vX5gjyF7T3bYCYZtvasFM6Onn1zkCgqpkvnJNBhfQq9Yhl/D+Ee0ldnCNICKwrLvvN6xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040062
X-Proofpoint-ORIG-GUID: Ob0DmHweYq3M1qizheAd3OsmLAvkA9N-
X-Proofpoint-GUID: Ob0DmHweYq3M1qizheAd3OsmLAvkA9N-

On 02/03/2024 20:16, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

