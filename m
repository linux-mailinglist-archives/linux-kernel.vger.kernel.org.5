Return-Path: <linux-kernel+bounces-82580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A735C8686A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A5C1F23650
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37044FC0C;
	Tue, 27 Feb 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxBci9bD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f8PXAaun"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECA37E;
	Tue, 27 Feb 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999990; cv=fail; b=tiQNSIQLd4BYT3J3lXiyZ852Z7unPKZAEro5k09abyi5YtnMLgFEJu9ZWVdW5a8KSp0xLRMGrEMRM1iELkwVN7M+Na0IDnk/o+ppBP/y5C/sMSnPxtq8jabWtWRh8USIg8vhiKxzgztMe5g2B/0X+624Ng8bRotJBOxw4/2IuE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999990; c=relaxed/simple;
	bh=ZKvgEG0kbKdB28FZhp+9eRNSemZeDSYkjo7+P/Jl3pk=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=hUytJlavWxueUu0cxzFXlaQqjw2xVkEplRNQJMFthimhMeGZ0Z+JRWB7af2UVVPD5OVIo9LCukHnlgJLGF5HvAFbtdzS3HNcj/jsWEYMUEMr9yoAbVbJ70RJx4Kw/dlHxGJUwMAUQBkOuBmcGLwYFwqXK8rBaqSemGaYJFI6Ifc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BxBci9bD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f8PXAaun; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1Ee3R024810;
	Tue, 27 Feb 2024 02:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9PgoldvMSfcWBYDRn+PYGwYhWOKpHMd8Iv+hw7RVjK0=;
 b=BxBci9bDIB/jUmx1Ti8mdCOIGjPHSGi6wNS/P9PcrFQcAbcizxk1w/qSu3ucIOURcOIa
 Z59dykNiuZ0FaTo/1LRyip/i6rGEZI9AnSgBv35O3bQ4bMKu4NKD+0Vzz8mgPOjzAaE/
 0HhnMZ+HUEXEAaar+bBlucZqniivvxpKRIz3E3TZMdW91szD9QkeVLjCT18lZ7An8GRF
 lwe15XrH46PnBlbDmPj5RyinfAQeWxY2dIQAn9PjpeeEGTRx3mjlgjwlWhCYQUegdbs/
 V4WMtzbWwLxQjuREgUBCXcd6pwpaS0Wg7E6XIL0zE77PqWiW9UcaTMGhb5sL8rpZCrQi 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u5y1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:13:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0OGR9015456;
	Tue, 27 Feb 2024 02:13:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6qbae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOdZQrBEuYvxSZPtt4j+paOPTJ+/+7985TLoMiKvxcnAyqh9zacpCn7E8Abz9H2zLtmfWushIpOHXZ9CQKgJgd2E4pWIxZXG0ezU0vg3YKgkThOh9tgtbR1SaV91oUluozlsI0R5mKs9A/Ji7FduBJwFKiRyszDm6+CQB0fTsS3mJBbVr6gUWyxNHHPJnr5ZBXbkyh9rEY3eUWs6chHrhhbZKcN441OaTNfgmtU/J6xCor8knyskf6t8or+OzVXg/uA1rOkXo7rroFdtJsu5sZKLAPU7QHUKiuPXnUZXk88ojssY641oIEgZ1/F4zpGUzbFXdf1k8ptoqrjRH+mb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PgoldvMSfcWBYDRn+PYGwYhWOKpHMd8Iv+hw7RVjK0=;
 b=h2h1oUVAbpVJzSQo2+bwxkhFY65uRV/AehMPggrH6fewqaoV1UoDPPBRP9hwn8EHWg4ow0nH7K0cT8RKpqm8NWtnaLYM74TaVJqowroK2zxx4iN60Q3xZUcblNWAwM6yY7Q3iTfkYpi7fYYY5bh+Qwk/x3IEvWMPxBK1RaTqmUXUsBcj8ZZYEqICBv4LqK7acSBDuZUiCNv8g2rCjWqMpQLWhcbKrRTSxcQ3a75ksalpK+PCjLDqp4xgrBwxHrWyMF/ZZj/TrFBoyczYWL5epPv2eiEj1Dxbj4qC0XkEGyXumBlcygBx+0T6kwYRfPmR7lfOyPU68rNUDz+z14iEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PgoldvMSfcWBYDRn+PYGwYhWOKpHMd8Iv+hw7RVjK0=;
 b=f8PXAaunIpekbfM5x117UXe6BDMdnhVxDNNBUNcjoo+y1L1Tqz7c7XDMqByNvObwZfFY7RhY0/4wJe818sky7Ut18K+YIdb4DS4lDspJD/F7/uvfvYOcQkWLFViMa0zYC1kVt4OEBidveqKkUN8h45ssqS1ryakE/rjbiByJHpw=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by BL3PR10MB6066.namprd10.prod.outlook.com (2603:10b6:208:3b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 02:12:59 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:12:59 +0000
To: simone.p.weiss@posteo.com
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru
 <sudarsana.kalluru@qlogic.com>,
        "James E . J . Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: Remove further unnecessary struct declaration
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6hu64fi.fsf@ca-mkp.ca.oracle.com>
References: <20240217191409.6260-1-simone.p.weiss@posteo.com>
Date: Mon, 26 Feb 2024 21:12:57 -0500
In-Reply-To: <20240217191409.6260-1-simone.p.weiss@posteo.com> (simone p.
	weiss's message of "Sat, 17 Feb 2024 19:14:09 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|BL3PR10MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b69e20b-0eed-41bd-2072-08dc37399ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EeIxYWg6H100ZSytzxLmmOVwr8Q/0VZJbSQozu6GsEOHHBeyMG2oPRPXTfmQ8Ysb1+VDMpaBIFraXfdWY9OJHLGoeWf3I9xOiU5Dck7saE3hI3I7Uqrk//e62Q9itEbKIK5NFuR+fIPeb2khluiJfwfUxMQv3VNzCkFynoK6kr4Bl5FckddemnIp2AWz4gr3FwpC5bik42KKZ/DZIUdvmqoQZyPfUYc9+pysJ8mQ+GMRApEXS+Rg5RY9+l8yRsTD1piUYkRl/g3dBz1VgHh3Qv903xdkci+LOa0QDhWk/oeF2E32dy0reF+nWc1a1g7a8i4O2/7FMJsBU5EH8o6nMEpKRnT0kutw5PNwK3VIY53QLEizU7j3m2Gbn+hKUz2Rym+z7T1HjBqBfK6vR399YHGWIGfyBjIxIzlbtcQjdsMWq/mZSKwtsmaYSfFiB6TmYLn2eDzewFi6CnPVSjr5HJyG1AUmTWLYvjG9rOYRA33SD2OTfqqYGZaWVMdewaEgnLg/V//1ZmotM4sELnzURIDq1RYoilEccYTOmD3tYk34z3rMU+FldWC89S84IgGefySYoEx10fYn25DbjV5zj3srecws1b5UHS1loCd8rFp8zjztJOwbylvZ2Aeq0bJspOru2psSEvFajrL6yovZjQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fdYIweRyQD6vh/dQK3EjXfAf6LFuFezudq7NHsI1VimrvUnnZxTJDwwISZvY?=
 =?us-ascii?Q?HH3MBrL0kt1BksBQPgC0c/XBt+zMJH74qIFnz9vuM+nwWWPzsfHFCroep05A?=
 =?us-ascii?Q?M3Iwz875VbKS/JY7iVHIlEzk9Lfn3M1N/RyUzrokBPHCiDu1aul/oSt2FJyP?=
 =?us-ascii?Q?7uDJa8rOIoWels65JwTTEa1d+XEeSc9wKJoSD9jyPU0jPMTK7ta7mVigz8iV?=
 =?us-ascii?Q?WNH3ZOunSQJHS6UrswzOhLD6Mc5Gg0tbe0Dcx0Yki/E+OgG+FQq2R5QW1ck8?=
 =?us-ascii?Q?/c6OjqvjprtNiUgmO9pTcPYmDEk1glY5b8DO3gh/PAbvnuQb1c5aqXS3ogR5?=
 =?us-ascii?Q?xhCJHMSRij4/UrwskVwObuu41swtx79Y0NCNkVp/YAG1WNLI2/uO8h5onxOw?=
 =?us-ascii?Q?b/sdSuV6ZtlSdj+APHK9SumMjNSEuWdMpqw9Hwj6lB3a1LuACYfTduGyPyJ/?=
 =?us-ascii?Q?T7Z5JE6JQ3x31d7vRGMyhRZwyUhc52uhicDmKxB/Z8XKBBCgb+lnilNc/V7G?=
 =?us-ascii?Q?km6zoZqn1IINthgTsmeM1OkAEuiCZX4OpMe8kWbiS3GuWIJYOGlu9BRpA153?=
 =?us-ascii?Q?2n8lPlOO8BdhqdjLypQ2B2iHjcohY/K6bdDFRwKWBqS0if2204u7HJPSkP7F?=
 =?us-ascii?Q?xj746zCkO0Qu01pbfI84n/9WCTV/uWkaQ4pSroRwrvqcaTv6+tjDsNdtS0GZ?=
 =?us-ascii?Q?9zThm0/UOL/AVAMaZfVboXH08qdRy+eKn/slQYudL6F0ajbyWYBdfLZxYmph?=
 =?us-ascii?Q?VUS9B8E8st5RFyaLxHeqnbn4/9ZP/gQX27xCE8HazywFPEdPaMAbJUg9qDAO?=
 =?us-ascii?Q?KfkqgaiNoCrLMaWeYrYUDsxjhYVABdjHpR/LGfsrdNPIUsW7yZBmO/ClGtRJ?=
 =?us-ascii?Q?yrecH2i0XM6AjPtw07zL9tyeqGlijY7ykAABFMBYQ+mx7bHzNGxu/gPME/nV?=
 =?us-ascii?Q?4jExllQDohzhJ5ZSvQL1oS6foxKMsL//usdQZUeAVR4UU8S+kbpQYjtB4AKv?=
 =?us-ascii?Q?anaIkrgDe1TcmiboC8FGtvb6l9O6akIo9I9VpiBlPWbWGE7JkTy68T1S/DU8?=
 =?us-ascii?Q?UyS46NQVOQrQNUJGY02uh2Q3FRFoLFBUT0vkSFMB8Rw3vwtx0pYpzUVnbhXi?=
 =?us-ascii?Q?oi5c/Sj9NGkvRTITHiupKF1hx4XoV/6SvvlyKRJoHefUCb0uD4zOzHBeiEmK?=
 =?us-ascii?Q?avSR0W9D3Y/4Yy5I2hAjPK7tXbZt2gCFfbzjvpRlbIrauRfLq5Wa+YSwfTpG?=
 =?us-ascii?Q?JKPU5yzu+TJRgd1kYiiocGoH3YycZnRVDEyaoWd7mBG5QECc4yNWXk+nqxU9?=
 =?us-ascii?Q?/D4MRVyKJAXvuYSEF57HBABMkJ6CAeZt0nmaBUIB51Ec1QlBJ8s748PZ7/Tt?=
 =?us-ascii?Q?LQn5YVMr4eQcdJcfiTdyhlhiMuKbMmkQQkMEzcSNmhtE1dPekMBnongs5uIU?=
 =?us-ascii?Q?fs7cyrpYNxUBWHqwaumukD0MwyVm7cJ+Ev9XTJhBoZjaa1lMoCqz3erfPIni?=
 =?us-ascii?Q?oS+n7aXEB1no8SeNl0KMte3OJwoGAAQ3V3NVDg0vzxU4gP0VS81XZQw2AWOx?=
 =?us-ascii?Q?VioPCUsQnZE1F3iROhA7v680/vN6RwBjL46Dk0IBmVsEdIWum9mA5hC4Pv7O?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5lkuRfjPLPQ3noX8qwm3i/M05EEYbSP7YBRFURlf8onV9rz3rHXjC+XYL5M99KfgW+gSiX2jkU/sFrxK4Ab+Daao4ozQyQnn9hib5kRqJFdmSW/UyXMavLjVKdefh+8huj8muq2ecz+6SldGPmFFXqg+Cdfpv1INOwWd9TGPlCf06+J9GuSgxeMeiiIe9PnI/J3NzUzp0crHudDVn09PfA2AWpzsTWvEYzkzsXQCiCF69N1Be9WdS2nPQqR26hfMu32Ry3hJfRdPV2YhoQw79llEH8obGzCXj3nPVfMXO0P98ZCQx6qf6Xir7KYzpVWaz0UmOJlxhHsKbidikSWcARvrsWKcjn5qqKsUU5/ekKAR5dE9Hp7BWx5pmRZhgB8Kln1gkOoTxM7wM5+uGHQ+wWv5/Xsi1kwkUIZe2iWg1Fqsh4cPpAoEoY+Cv48Y78CybeNQu6wYOaDxZmcafe/J6i05uoUZTdj8LQlu3eI0yz+2iSgghLKsIv2wlvdbmrzo6407UbDBZ4IzzKfakTkbm6aLvi/NzPaoVOKnO5asQf0k+hf3IK5ZHIjgMFkSYPbEWjUofGMqQm+NMFPO1of/3An7IAjAsOr1vVeOvNrMCik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b69e20b-0eed-41bd-2072-08dc37399ece
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:12:59.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLUO3XhIR7Gn5MzkD/O+sB2ukGGSqrgVwqQNieSrlSbL+bLpw/qOnjF7NqHloIQvLjoLe2uf/AxDJfXSdundOvUrFnM9RRyBlXS2JM5ax0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270016
X-Proofpoint-GUID: bYADxyOlPs2Bge0eo18FM7suIyk2YzCC
X-Proofpoint-ORIG-GUID: bYADxyOlPs2Bge0eo18FM7suIyk2YzCC


Simone,

> With Commit c3b0d087763f9833 ("scsi: bfa: Remove unnecessary struct
> declarations") duplicated struct declarions for struct bfa_fcs_s and
> struct bfa_fcs_fabric_s where already removed.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

