Return-Path: <linux-kernel+bounces-157919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3DB8B1896
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232E828694D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8D134BC;
	Thu, 25 Apr 2024 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCKzfBaa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RG0eL3+D"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B901125AC;
	Thu, 25 Apr 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010128; cv=fail; b=WvKCRHlJDD7TpNs9w0cS7jnICqBqwCX/r/HZN+6LpOk3hkVDp2wCIl65bV43iGhH1OdKA9Ly5WKPabK5OIuDrztOZYWlDAXMiDraucrdcK50p+x+e9ePwE8dRfmPd6u8ayGwHIYqtOFTGPbqYlFN7XTQ1zk96uyibslViDJI8y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010128; c=relaxed/simple;
	bh=cblTtpROwPZ19vdJ94n0w1OP3uWR8YSeQo9mwAb/oyI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=aoq8y2NiygwDnIbLewLxnCYdbKEhDzthNpv/0K4tI0GwqY7oU0IzDVa0pAPSWV7OQc/fwewAgG5vKBZLUkGnCXamZ9Xfquk+jKNV4OwmbdkW+PejHmjKKFciDduXHOYchzJheHJ8qFyexCBwTmOw3DKmPsG+E7W163Swf23Svb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nCKzfBaa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RG0eL3+D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0iT6s006388;
	Thu, 25 Apr 2024 01:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Dvg0twKMH1TKdnslbbMNSHaw0TiP1wk+lP3BTii+5DQ=;
 b=nCKzfBaaiWpengFIrxLjIiU9ZkYDIlyzarf/0enj2zEePHNHTx+ywsZtj88rWHvaiqxp
 BkNDHvBl7Jd5rK395rE1yMqoi9mUEGg7gugiNl0qFhbyD14WjqtOXkAFkSIrFjbTLtpB
 ITKpCDxAx6L+7J1eCRUetwdQr1W4TWSVH3JU7UnPAmFDI/vl1tfmTRfBRVnGt1iMJ4ET
 pDj3RHyR9XCR5xFnjXDf+wIJHcsezcAhggRwks2KjBYiFnf0a4y11OUlU1EhxQ/MTkLK
 enF0JKDyaOEYFxXXVHxg+hyMzTj0iD8DuLs6dYvn06aBSGGqVmtmVzlwbIm4vz8rFiYQ ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2j7w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:55:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ONXDHE030835;
	Thu, 25 Apr 2024 01:55:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm459ph88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPmYEs5GbtqJcTqZIpbw2RNt5h+Go/v+vLYsQAWahMQBUB83Iek2FHpwl/HZ2EESaWo3Zc5jlp6Rw+cPtz+GizLkV+XRFG3XnNeZt676oBp+juarTGcFiENUdQqw5WgP4S8FCnBhO8L7y5cT5t8nY437/HQ+h3OB+xdDY9L02vv5myDx+2Do6JvI56Bj2RMBw3EWAOfth2DlqnjUDlLkfuYQGI/3V8J7prQ51l6jWwLOkjI8L37fCEnf45FYjknHCMZHth3opUwpj82VEwjPmYYJTm99zV+FqERfEhz30e3Y0T8YPJ/iVnPWcbkLCSht10LMJNUzWvaGVZ/ixgeBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvg0twKMH1TKdnslbbMNSHaw0TiP1wk+lP3BTii+5DQ=;
 b=ffIlLafQyMXFJwhAlDQLrfr4B63FInMOE0fY5OCK2rCsbmyQIinqCB1oK3Vu0JHCBJ+lJYNAymjO5a896B/YttBi1MAUfmRGie3ZYuS65Wzuo6jzbfEQBQbGHVt66XUGtPDazUwNIXUYOQSJ0njaCGvz7BHI5NycJQRUA2UVlpoEb6Ygjre34Wwm9sMe7fMr8M4NjckvS2y519QM8xwGYYDb1ZcPyO007/oVArFQkj2CmM+BBqynLKu6orPvEHhTVGnbulsYRB8E98FDNyq3XJl8klQPqu+ZJ6wIsSsYUzzUMEZrdoCTR/4lbKGdpH4phDXjz+CysJUN8w0oFCUVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvg0twKMH1TKdnslbbMNSHaw0TiP1wk+lP3BTii+5DQ=;
 b=RG0eL3+Dp40X5t4v6z49TCB7qeaFxKHOmukiaQCawFkFRqIsEPVKX78EiZWtoNrEkN89WJ72NSuvfJvuuo47geBByP+g/Klb/JN7++XXZHZlZgtwWMQ2CVVVmy0L4VNXIHNpSHEinYoFaWZWI9lfTAYhkoVocyvYPUxauKddijE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6675.namprd10.prod.outlook.com (2603:10b6:510:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 01:55:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 01:55:04 +0000
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Charles Bertsch
 <cbertsch@cox.net>,
        Justin Stitt <justinstitt@google.com>,
        Bart Van
 Assche <bvanassche@acm.org>,
        Andy Shevchenko <andy@kernel.org>,
        Sathya
 Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
 <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit
 Saxena <sumit.saxena@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Himanshu Madhani
 <himanshu.madhani@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 0/5] scsi: Avoid possible run-time warning with long
 manufacturer strings
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240410021833.work.750-kees@kernel.org> (Kees Cook's message of
	"Tue, 9 Apr 2024 19:31:49 -0700")
Organization: Oracle Corporation
Message-ID: <yq134ra6wui.fsf@ca-mkp.ca.oracle.com>
References: <20240410021833.work.750-kees@kernel.org>
Date: Wed, 24 Apr 2024 21:55:02 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 271f98f1-b581-4559-a0f8-08dc64cab9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|1800799015|376005|7416005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uA7qQaoZ2CaSl1u5qVJP79V2cHDQx7QXMLR20uY4lt8sN2Kp34vbviMnG/37?=
 =?us-ascii?Q?AvEm68hxtqZpUylCTUpOkePsWlnNdhiYpixEs+hjSO6TWjYu/mib550DRtAI?=
 =?us-ascii?Q?pJB4uHUUW2asuGo4aRUkjzPDLALImi06MFFT5B8UK6MZmBQE8rGD1MhYxm16?=
 =?us-ascii?Q?WIro23171seyKnkSYorC0BllZU58etOJkGsYqnSTx8EGvTyafJ63YHdelDc5?=
 =?us-ascii?Q?JXkRFLovZNImMVOJk0VeNa8XFvBKc9Gd+IHnOE10WFPQe1ITVUreg/F0UVGI?=
 =?us-ascii?Q?eXFERaih3QtT27SAYnr9araCHqwk3uKhjAgY0cxbCqIby8ccSrOez31qGSwx?=
 =?us-ascii?Q?t7aX6mCt/GR3N8vvkdf4WaEAf0fqjs+wBNWZaKIlhQdUEVUEfOcyBkBzUCw2?=
 =?us-ascii?Q?jY47nL4ii/xEN3buMo+FFL+q5SpyAIO8RsI+U9TcH05FuH2vQzI9SCfM8hfO?=
 =?us-ascii?Q?W8mWagImXeMBYjMHoxL8ymD76u3HWd4Y+bf6UGb83EYfrSuBb8+J5aWiR2rL?=
 =?us-ascii?Q?3XKHrHIoErzXUZGpNQGjbBXWCuHScM2cM05/Rb1RjvNGeuAx3v5VcXsPEV2H?=
 =?us-ascii?Q?ApfT344RGfmZuWKH6OhyrHth5G+rlJvf68hEPNrqOWwmq7i/LV14z3ACwKNq?=
 =?us-ascii?Q?SzMCR87bmozZ7rPG/f95/A9qQ0d72OtgOnpVXFD5EHm6zTV329Wq/gPAtlSY?=
 =?us-ascii?Q?3S16F8TmGn2SKi1j7K1+WmX6MepIxuLzKwpBIcHCtQdY0pSfCU8jAFdoNxL6?=
 =?us-ascii?Q?xSyNEZTqpTV3KEpNUvaWGqVs4/VCaXr1dvRJfDQy0+Mj/IjEPVHFX2xVyG9F?=
 =?us-ascii?Q?kYPm+Im9Buyuzi21boA0WEeMApBGp09wcgKNz5tcDL9HbSw5kttfVcCmubKk?=
 =?us-ascii?Q?0YvPVC3EN+V4J1JaplKTe6nXo+ywWch7NGlEcLTem8/msMjh0xlC16E8R270?=
 =?us-ascii?Q?JkrAiEczxSFHIrXr42+Okd8e0xfx4+ER52XFjZtxGvT9VK8oHfZYx+vSje4x?=
 =?us-ascii?Q?bA00YOndQ69E3/2xKzkNKQ61vCIkIa29X8PiiQzhFZFAzD25LOvIwWebJQlK?=
 =?us-ascii?Q?TwzbYoyzyer4X2qzzc6VPCuEertJn7GmtwnYZkPmqYzVfWz+XwMioJyuC9e+?=
 =?us-ascii?Q?B5Zj14KRKsBvEXHXW6zLt7EE32KPDzDEy7TXcMSqqu+TlSWcMwPBn5FnkT4B?=
 =?us-ascii?Q?6t3ulLn647rQEER+FuDQWqdV+EvkXFmdxCcQ8TzftbL0+KAp0Gpgx7DUKbDC?=
 =?us-ascii?Q?PEE+ZxkGbpIL3gRaBd8+BRtWaA8g2on+J3cRvmQzNsHJH9gsX73o33P+mIQT?=
 =?us-ascii?Q?7vIh4u1aLXMeJb7SgltSsIonu8V+1H570jOk2591En9ZIg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xO26881TwKKpQ5vh+zVOYiMP0+4h50eXSr+zc/T2Ntcm8o4oW4VQ2pRHepPZ?=
 =?us-ascii?Q?nda1KO3yPBkxE1a7C1098f1DoNjlLenZJP0K6lmwj60TgXDfiy/WCFwTN4bY?=
 =?us-ascii?Q?30eHaLS2lMO5D1W0xnbiP2aGbg9OJOXnqEDdhzsAAGj07ay7nDtH/HDBmXh2?=
 =?us-ascii?Q?gIuHZEYKpjfXYimq58sDGmZ1Zt2UPI80u16SM1gRGkSvzoxtZLdVoaFpzouT?=
 =?us-ascii?Q?//lodzuI3+sHjXloChuUQfK/pJHstknF++KUI8ZI4aAQq0DMr+nH31F8MyF6?=
 =?us-ascii?Q?FnFawIJOg6UYStvF504TxaaOXC8RTE2pxnIgLkjBx1k9CP+gW8cIAijA/+s9?=
 =?us-ascii?Q?yUnZqREuH9Ba/0bPzbMnIFGkBazsJRVG5tRHNsn4zwyBhWNVIN1ONPyXTgf7?=
 =?us-ascii?Q?gDYmmakdMw29l9XbmtS9nWNELMgfa6XYqb9zaiZG1U6Mt2cQWfJBYe1to5J3?=
 =?us-ascii?Q?tzMHGPeyOMfrsEeD+h1WRl67wqiJ1Y07nQRj0f3Q0VasqIhEJSchpp5jq5jl?=
 =?us-ascii?Q?ZORVlby16Wk1r1a4P+iAyx+rqW2Eocl/wy1YlOCr14CEyKwvYgNX9jR1/z/4?=
 =?us-ascii?Q?2Dr3LYTzUG+v7phfytRTUvCkt7Lf3Cbzj+2K/siP92I2ME+4IkJe7tdJr6tD?=
 =?us-ascii?Q?BkQKejDo+fP81+yGLkbpp4ljXxEy13wgaVcLujnYd26IaQM625LDeDmNesGI?=
 =?us-ascii?Q?leI2/TfC90qA0gAhFvmwpj9BOuhx7kWFXjDQHZ89B0SLX08GMNgEV3+NNRHi?=
 =?us-ascii?Q?fquJ1QBVRyKg/6Jq/y9gEEop+QE+FWBJN2SEygT81CHaoDYDmW13QUBRNtVJ?=
 =?us-ascii?Q?c+miO7gDmTJ02GO+Gk2BwQ4ekjIsxpwijqhPmqqGHnG7CrKhrq301sYTYuuz?=
 =?us-ascii?Q?itG5dAqMgpxmFfv/qBUQ+FbQPN9TWVyNnuRQLrp/sflSUHUtREkmY7br7YZ1?=
 =?us-ascii?Q?xhY7c3Rich7Gs9cvApoks/R7etmMDO77nOof1vu1bDeyJLfVMAoT3sgAioRm?=
 =?us-ascii?Q?dn1C/LzqbunQm+lz3O10QuW++cOg5H5RrDzXUA10N/8E8/CqA2RXqlmvrZ7l?=
 =?us-ascii?Q?Xgu9lmYkmBTW5OCtzLTas3m+Yw0MrK+Lu8cjHLggrHZVtZT7bxKWwnIvSqXf?=
 =?us-ascii?Q?eViASEsD/pcZhAFTeI467hs4RlS1QuqTuXH1wGxS5KGYHM6iC07jXj0LXq85?=
 =?us-ascii?Q?Obzr/ejpHBq1UpTMc9wbV8ykCGKSnyIC5fscLnvDnDbgJiH88jyGdId5PZI9?=
 =?us-ascii?Q?TKgLX651sOtyFIwTo8G23yASjRW706PWkToLksldOHBEgUbHQhu0C45Nw1r6?=
 =?us-ascii?Q?NfFyUnq9aWeVeQLFK5hnbl/mCiYdlhgmMZbiUhzGnMUe7Ys1cxHeYrCO+2my?=
 =?us-ascii?Q?BhpaTnIFJdFtm18vgEkRp4Z6YWJB+d6bSWf3z1u+5R2yNEX1BppowWIU8Vu/?=
 =?us-ascii?Q?O5W3BCaq1871CLjYke7+zzNxGWa1ywn4ccV3cWySsg+Aw8TrFbiAJ7fx98MG?=
 =?us-ascii?Q?1mrRVCA8zwoBneczZdiT8OdsgphvPqace4fFWdV2MfzeyBOWitFKcVJgEUzy?=
 =?us-ascii?Q?yPzH1s6D1cNxfJNMpQGW48+/Kt2v/b1WGwU7dDrU4scoewh3w6hasfFR4JoD?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rbv5cCIQ9KW1sbMN4YNP/jcHpRB5kO/hBFq09PwfbKJrgu4gKp0VDc9ZXCYv9M7z6bls2RJ8aQMsaOmLPkQ0f36NVQSerpqe9dvu0w7Snh8eF731ez9dPsfO9QiT7npFivBfN5wlhW8RadoucA/wHpxh5tJS6gO/xRi66nY6ENX4GMpsXBkkBIkCYYVmolDf+1tCyTrTu7GMrvo/jgI1DaJWozVB/66pdcf6lToFu2oh2NJSYMOxgGi+h/MZiwQ24hZR/4CbGY3aeFod0gosc9RDqCSu71kRze7vrKjR5Ju6dJI7Eb4HgXpxecHknqzcVG3Gpl3IPyIgRBNwGn14xeqoB0Pm/5gR2ch0k6sUogK4mA4hvweR3rmjXf6Bfd0dsnDXP8n+839tZiJv4by1JkRX1y/fvVre2r16lPXSkXxoF9CExF+6asZLMb0i5EmD9g16m35igtFLLrdJ+++rKmC65e0bCuI+vfhDplFXWIzLTCZuOCNUwfdnlYc1wG4/GQkF/T8V8qNrRGpIqLqB0doARAR0EMgkAdvhcByA5afKBsWtDwt6bijiDkvktUPTJS2PuZbmjqVburyOjV7hwfbPTcX5ehpStulrG+id6ws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271f98f1-b581-4559-a0f8-08dc64cab9f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:55:04.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srDw638wtjUF//3l6Xwy6GQyhYSdDMzJyyXV/vgil+LZWWT3cPiLp8DaeJTAgLbccNln1eHPwkFc1iA5JQFvLh9oav5WzTlDGi8ommBJl7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250012
X-Proofpoint-GUID: uzuW8DMwkG-0qo7nxBZElM5TZemk8c5v
X-Proofpoint-ORIG-GUID: uzuW8DMwkG-0qo7nxBZElM5TZemk8c5v


Kees,

> This series fixes all 4 of the instances I could find in the SCSI
> subsystem.

Looks OK to me.

Minor nit: I do find it a bit odd to think of a string as "memory".
Maybe that's just because I am so used to always having to distinguish
between fixed length strings and NUL-terminated strings in the storage
protocols and hardware programming interfaces. But both types are
definitely referred to as "strings" colloquially and not so much
"memory".

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

