Return-Path: <linux-kernel+bounces-117880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D088B1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53506B35295
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9EA3F9FC;
	Mon, 25 Mar 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+j1Ig/z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T/cX3Pmm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD43EA95;
	Mon, 25 Mar 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396981; cv=fail; b=SrnC33lejcvVS+sMgLanxxCRwNffeWmPHljYGh18AYwXPQlbOpJbaKDPxFqDmw4vU/X5zLSnkOxysD3wCqzNnNeapovJaMvdqw+DlFJv7SCh3zgeuudUMtcGWR60tmjZQAMoFLYsRvXi2ZFzFuoiJBriKA9mVy255i1b9em0J+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396981; c=relaxed/simple;
	bh=BlY8fH8IXpDPZ4M90BJmWvk8bM9jHDyTdM9pT4CcX70=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=lLwg60G3NjOEVxqk1L87RUPQSg3p/PCMK7rRfL7u+BsWixhPUAEYaqC1jCsuZ+Tx+nQtJrFw1j5mwR+0R7Et8veJgj83uNWOEBD7y3Yh+pLo/tWZwRRMwNqrI5AP10XSaWHv3DhqAnfbJC0mxJVXgNOQdFdPCEMtQDzf2AmkxHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+j1Ig/z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T/cX3Pmm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PHUCAL020692;
	Mon, 25 Mar 2024 20:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=RlWXeZ5PRbIqeva++MU5Cv76Iw7Gj1ObsdMnCRUP8ec=;
 b=L+j1Ig/zKUINBJ0n91R6Zmp1enJ5MImWhXmR9pjorcI5Q1byihR239lK2qFBCVyUqO/e
 jyXe7KadAjV9MmzjRcTsgQOF/RTIDSp0XK3M/0qeYEkCwW5bj5amZ/kCkDUq3S9VWcCk
 VmZUXs2DH6n/sFfhU7Y3syhJZS5QVGfzH1RPhUmRNKqjmlZEMJnR41H9ygYJIDYtU3IW
 elnzW9Zt3nrDZ3Yk7tswiO4BbF1/MMFk/BVwVfSRASEXv+jlUchvH89VnYIIdvJvSaVI
 Ydo5KH3v2FbmLS0MAErotf0vkhgZEsCBMvyYbCcbFDCKphflfDLc+ITThdI9/0jtHFcN pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppukjxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:02:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PJsHLl020216;
	Mon, 25 Mar 2024 20:02:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh60e8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqbIq9SVVZqY23gBi61281Y/xG/qmmnyBkz23NeLUr+Ph0YE8H3qmF8P4Svz2oBKeNYcXmaMcfShbIuUAGC0mExG3da+r7gdbjt0mwsDOSZfufJhx6yVgyJGrK15YCeF396go0M98rCcVDqX3P3MMYV+/uI/EAUDe43q3+WtdXOE4ss/RxWLh0YOCNFCbdd9A5MVzB6zBCFf7rucpMEfAW7cb9IWO1MRXEIS2y2bdtcs0V9de0yw3NNL/oteYr9USd936NMDVzV+qeRKjA8LCnzw/V1tMdOcskXwKRDYpoXLDzo57Z7mtYpTHJdjVCSUB5Bl2sPVVXssnclF9h5/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlWXeZ5PRbIqeva++MU5Cv76Iw7Gj1ObsdMnCRUP8ec=;
 b=RRUF0LkewpR7oLUlznMSxaHctfW/ciCZdHZhm9io6IrIv0TG5CQjvSQIKIgR+Tz0OB7vFAqvRjhSeCQPgzvPhOhVNmfXgVi8obv/rqGCxeKlRzG+l/lcz2qyFmJaNQ9dCWzcindn98kyo8mJi59tX+NcLYZFOKU/rxIfmu36zxfzAWWGOhDxCWQJTIyDhPFVVIQBZyuZv3tgXu+ayFjgDzGQT34Soou4As/2ZtpnANkaSTXVHzmaQCOrWXr85wyMOiaAmPi4KqXIkCY4TUq3eoFIZ6Sp72C8ZtVe3LgKCS0HRnHaMjXU4dGwPCgSz/TBeDUQimEM/XQMj6ZfDQgC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlWXeZ5PRbIqeva++MU5Cv76Iw7Gj1ObsdMnCRUP8ec=;
 b=T/cX3PmmLJQThEnjNcFtqW5CMFCnE90wyeTl0SaLEycypy/1ZuuYaVy5tqieIo9I4NJho5+qqGwVcy9AZ4aZfBPO+Yh8PDULv5utIjBViuu07jgMD8tjxpc15LdXtzuU9H0//mYosMEW9Kybme1zZqcJws2HdDDcR7ULWmnfOyM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:02:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 20:02:25 +0000
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche
 <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] NCQ Priority sysfs sttributes for libsas
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com> (Igor Pylypiv's
	message of "Thu, 7 Mar 2024 13:44:11 -0800")
Organization: Oracle Corporation
Message-ID: <yq134seaxmq.fsf@ca-mkp.ca.oracle.com>
References: <20240307214418.3812290-1-ipylypiv@google.com>
Date: Mon, 25 Mar 2024 16:02:23 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0032.namprd07.prod.outlook.com
 (2603:10b6:510:e::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7352:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EFhz9JR+vRSjMemzFr/9pg7LaZvyZ2PcGp3O0v/1buCW5gKF0p9fhxT4YFjOYa8GU6qZGTG/auDYm34MEO72g1QcyB7VJ4Wki8tmr0C1PGgZmQ96eH8ZRgk6nDDFqpmGfdmx4BePFM4oBfqZixCW8s6vyuwGNm8a9n2Lo1O1H7nQLXboeB/Se7n9u/857/ZU+aqAk3K8fN5OlJcaCxlV4GaBzvnv2iKcGA7MfZDd0jkzXG6w/xc/Bq1oS1qgecTwefJSXY1wBGrDOK+5PBrK75eF2MiWCpjzfXQpsFZpJktzRyImaqOC+8X2gvUnoCeLGTyOYwkihrVJI3cCJJQZyZvC5TGakAk2036lS4/azqJosVsI/0B1NcfzsbOy1iPOwgWcH/g0hxK0ZPSTE4g98/ANJIDrNvEVhP7DZmn17oe0YmSjgaQ7lyACBKr2ZhXkkY+SfMgo6j7JAWmP1SS52t+qIVJH/ilJMwNlwDvHOMbYeU89xK9TzoKLHUoy0SwNrwM+AayIVyq5N7GzQXzGtoz2UrS2m5AMW0QgOipbrwuEvhHAs8cG1yB/sewUXpV+BBrOa8c9xdh86BRw7KKQ3RdTIXAZzeN5Dy1iINkFFz8tsRKnFm21vyYfCCHzu1sjyQgf9DgUFGIRK3q4qZmyeP013HZoEouPmvJSOatov6M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Nu/cBLvte+6biAPirbxeCC44rvmCeVhU1eJHRhyIofYW1xFr7/dt1QGnpMjM?=
 =?us-ascii?Q?wSQAjb5m0BnfYOcobpMAGCWXBrxYpLGX/edjNVsrVURSceSYzJR2bIM8YrW6?=
 =?us-ascii?Q?GFtsFgGgAx3sqCb2JC1iy6noQABdMbRLE8zf9pHvnfY49654Kw2+6Piy7d2w?=
 =?us-ascii?Q?GOkOjfGrJn0t5mJOQ3GL2/WBl+FV6wgcOGWapBDSyzPfzJJ2R9VgA8flwrlB?=
 =?us-ascii?Q?7x3O4KL3NHhPSuTgl31EQD/r232+LYpD4JfRKeQnWwnU6WLI9ITDdj/qEDpH?=
 =?us-ascii?Q?QgKAaAcYtVIsFKaRNVthSrE0b9kDdxejZbyYl124EavSJdvutWoKsjs6DUt5?=
 =?us-ascii?Q?FHMtX/O8lJgw5M5KNqPYgPwa+C1g6OINRZu12DZXw7eAvSTDgDUQI+sS42EY?=
 =?us-ascii?Q?dFIGxL6Jl+s1FYtvv9aSmDXMiHrk04GaojrzeD7H/hlVQupftrqbpSJ7Tu+s?=
 =?us-ascii?Q?k1cicPGzT3j12CKIHRgJ5a7k7FenBLA2Gp/Ld4vvlH/vP0+PaKPQHi4J0ZmQ?=
 =?us-ascii?Q?uMPjKGLM6pLYUBNkEXPf2HH/wszUFVpI1esPmjLmxQHG3IGZnXdisPXjbn3X?=
 =?us-ascii?Q?kO7dFQQhmGumh9BtT3nsDgwlMHWSNwfMImX79gnMo1gmwBUofmTr6XLlzm/k?=
 =?us-ascii?Q?X3K898nTSEsAXlWTw8X0HuKR1hXW0sFBP8EQlR7sXT+y49qXC0EY+/h8Ua/3?=
 =?us-ascii?Q?e1+TAtER69UuLdwlSF7p5kuZdHJrDozGrjSJio05ZSrNi9HP3JIKSbu3oD+N?=
 =?us-ascii?Q?KV8c/FCCLjH/ic94kFSW3j60FhOeMEu7eoB8JiHqsmeC75a+fUTX7LcWBqzE?=
 =?us-ascii?Q?NzNzvbDMOKb7d/qoD06t5WRNGfYYK8e81eOV1PWuaYT9IhtocA0lLOV90Nbs?=
 =?us-ascii?Q?9OcCpr95KpunKeKHn8PNgqCDVmgA53g8dhiI4SiIImBen4otUQedzCwJiir9?=
 =?us-ascii?Q?pWoQJmn3xV2rzuQRKD4n/f6BE+ZjPUmpcWbQv4kYE56JH71T3u560lKwpA+6?=
 =?us-ascii?Q?1myVmNPg1Mhg/Yyej8vt+OUHxUKYYaRZSTuVNwNkDg2IfN9ET5KwY3qz/abW?=
 =?us-ascii?Q?AYWdmCl7th5V/eLhKQDMPhnkEW6ykME1Nf2RtuTgIM1RRlToAIMoWO9+Qkqt?=
 =?us-ascii?Q?jDTnqXAzrfigL6ED8ZhiEVHXwf3V4+yzbWLJOwWFql0O6PXF6RaGUGmS6r2b?=
 =?us-ascii?Q?hYylPlgigl9JIf5DlzGkuxqH7gC72IUGsOjhzgdJrb6XzB/VP2vLTbcMUi2g?=
 =?us-ascii?Q?5mRRTuXyAfAkcEJPd+526UCKPFYD8aQXItAuAvM1Lvg6MQ/D7kci3vZ7JvIo?=
 =?us-ascii?Q?AL1IrapMA8HKAdZ/Xsyj+NrOh/yOUctqKrAPrQ6mXbJS0duaacawQ78OKwpx?=
 =?us-ascii?Q?acdmiMo6DM+6E0CLSnPQrZJ72aXBiFGjyDpOswTmgTnFQaNRhLOLv23fXIzk?=
 =?us-ascii?Q?n0hS3+4frF84Khd6aNJ6Q4at73owvwqt0LEPjuqPBek/vKeG1kKDwGs+nRL+?=
 =?us-ascii?Q?xGheSasYovo4X4kkDZZIA28kydg9DCe06eWFcLXJA5hxSmZ5M50392hv1DPY?=
 =?us-ascii?Q?QpsULskb55xpUC/gqureFTEgT7x7X27cUdmMwtKLLEo8p1f2deuvseZnMElp?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FL4AEi/mgF4PqVH4Qk7TJps7DypvpWCy2ZxnDfWP5hYo3o5UeMMBblJXTfJZ6xB4hO+DITnU7e07hq7OGr0CvolccwUOJRlLTyG5FoDhfPnZeh6BBamhlhn0a/vF/oswVHXXr8gN2QRlI7sxq83zhAZ8CCICGr+lx96HDHkiCCH19AYESETBOnMl70+AbZmUYg7SM9wKUNsaplQGtdQ5/bYVtt13SdRs0bBgKOeb5qNCQJpLjk8qzssOpFyJ/kToHfB9gQxb6zvsVqCHhD84OZIKzopAKflvFSIXfcVaIpeK5+HF2Ri0inqtYeQZds4schMoOCpUbI4DAkYkeJIwzUTwyTX73ijUa4dDg3Pxx38SOqCJatGpr11hv7VUkW1wpPnXCxBHu8pc9PnnBJ81x9wxYufIZHHIl74Q0RdNZsH0AEWBrPSMz5b+sVogDPC+CUCx/t0WnY/7CzfJs+b+h0Uv8F5p3cVCAZh2aeqMijKRDLp6J/z++p1W5gYYfKwrsLraTkdf18QCxL3kn3G0zrESyxt9ZLsXLDvQdwDABH8Mzu6g9eeWhmW94sZ4r0QLJHyRbq25KJ2KN/9O4zrdkja2ca1gDkpw0Ii8MqasKOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa5aee-7c93-4a37-959d-08dc4d067d78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 20:02:25.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXCVwnTOT4MTBGBSkFeLudm50KuM7vMLPr7RUcgpiCey3GJK3mAAUkh/GoAaGqEB9SYrVZHLFHc5tLUz/Us3ajjn5cIbiBY0O8p5XQzV7Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=922
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250122
X-Proofpoint-ORIG-GUID: TXDlKYUVyXLHekRysUzEBCxNZ5dBDkcU
X-Proofpoint-GUID: TXDlKYUVyXLHekRysUzEBCxNZ5dBDkcU


Igor,

> This patch series adds ncq_prio_supported and ncq_prio_enable sysfs
> attributes for libsas managed SATA devices. Existing libata sysfs
> attributes cannot be used directly because the ata_port location is
> different for libsas.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

