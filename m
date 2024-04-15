Return-Path: <linux-kernel+bounces-145758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720258A5A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9438B1C224FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B64155A58;
	Mon, 15 Apr 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GfL1w1hK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gxoT2RSb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234E155A26
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208473; cv=fail; b=GTHpCKvvFFfrlysizCnsfumefuSBLMqlarutXKKFqUZu5FkdskJSkaAJ6STX+8UfpG87rGFuS57kp2ris0ms9NvDm1JTAaYJcxl6aQvKCScBYcBbn6CsTbbsLZ5fSeEdijSJMfF48vifLIUoW43e+tTenuYBDLeYaZZ8uAY/ons=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208473; c=relaxed/simple;
	bh=iU+Xj+IaKi2k5JxsmZu7QWsrsy72FL9SD3fMV7CMy8M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rvA0gWiaZihaQl5mQiOiKGgiTMphOHXBDisv3kkqWk1rgyGp4AwdQ5MCRF1x7lX20dQeGJ5dJgAX30tDcPCnG2+u0kDj+XUu6FfcnRSujlTIHM1m7RY0JDXBZ9lWt8QxlzrfFXUxU4SOozhIo2gVsZhF3573d8bqC8DK0aXm8Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GfL1w1hK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gxoT2RSb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FJ0Djs027764;
	Mon, 15 Apr 2024 19:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TktEf++OBoPFHQ1mzq2wGhGqBwTzrmW0bLDNqOe5hLM=;
 b=GfL1w1hK/ykxyJaWNrGWKMKSXSxmrYQCoFy4fbPQlzv3veiMMuc6qpGNDdBnE53bTNAV
 KqAQcYwM4tDSY5jZhcNlJkhewBZUufrb/TZsmyTDaLdCvznLsvE7joZOd6R3nIgQiZbN
 uP+xTw7kh557TVWOXKgE6IZtVEjOZlRZd9z5kZCWKG8nUP7HmkNo6X/0mkdJ8WQAECU7
 UwVvX8NKYAKE5MQDfhKa/v7g6Pr5BK5ooRw0GZ+VuiW5ofZS/lLr/0s+dG0n9pFpI6jZ
 xVvoPmOu8d52raNdETMlPTsC9vlc5VxIY7hzfuvsiyJo3Zu+G2ubN7yk5QsOuoOr2AoL qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbkgkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:14:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FJ1XG7014297;
	Mon, 15 Apr 2024 19:14:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggcfe9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af+6tD0HfMpds59CnGGM1T8jwBM0OjL+MXFKW8+TzhDg6FyTYKc2WcRVO/g6K0VX8CJoS1zGRuVgW7JwORn2M/ITsJCjP53pmcQeeY/hl6RsRkoEQnO5HjEG7c1USC9LnOuhKeq+PXKFpduXKMECrPrm1QR+/4EVTkFW7W3lZOPaqlsM7NKOTtAE7JkAgJcUlj+JVGjqj4utnTWU/3AobjQ/Bl3XSoOWoXB6kP4Jccq+1vhiU9mdZkWWrsNxu6Y81nP0J9LKjhwkj4LmW4Hkw8oCfAby7dNzQzevXnTfPz2QW+LEPCTNlnAVMrL5QNzbTXMpGOOXZ8Xu/ablHw4X8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TktEf++OBoPFHQ1mzq2wGhGqBwTzrmW0bLDNqOe5hLM=;
 b=McauTzYLsapQIl8d8uTmJZJ20e76VTYpUr51szStzmIPnfGY6z6Y1NSk9prfBB8859JfS6+ffQ3tsi/j1XBRauBqtgcX+4DqAatr2FFEtQP3Ocgo2Syv8kU0QW8LoHyoZx0zm7e0jIvo7FRdSebOno+FOOqC8C1MGefD1HYiVS7l6NCsuSjA7jpltE1GzxwfnrV5AzJTi8zIt72UKooMq2rjVLh46F86veaQMGXQdVpBDTmM6zZxhikTSfJrL1Jxmxwp5d1rmFlF0ofWv6PFbNnKfwcu6BNajSgqGbR6G9YQyrQg31K3oYiuCOwfXwYA2C1SxO4bJzBAqAwOe6tAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TktEf++OBoPFHQ1mzq2wGhGqBwTzrmW0bLDNqOe5hLM=;
 b=gxoT2RSbymIdCoN5wNW9Z0CEacOAC4GbZqbG0xNYN1HOpQR+RUMkZQYrUIyv8gA2uFhvr2SIOXy3sMhBAwPW6NCcb2fcfRGFozWbL8Thdiug1nYkWX3fA8ALsXv/DrcB9XZlqh2TAwcdwuFPacYIS73i2iEjBl1wmioKeyNh7nY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:14:12 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 19:14:12 +0000
Message-ID: <71760ed4-e80d-493a-95ea-2545414b1aba@oracle.com>
Date: Mon, 15 Apr 2024 12:14:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/hugetlb: convert dissolve_free_huge_pages() to
 folios
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
 <Zh1xslaqduUr4MHF@fedora> <6eec8880-798c-4835-becf-976cbf8fe72f@oracle.com>
Content-Language: en-US
In-Reply-To: <6eec8880-798c-4835-becf-976cbf8fe72f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 142a0079-7b76-432d-9947-08dc5d803bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	82U2NgyaCGp3vm1atP1PvS5V8dAYzqH0rB30lwiMrXc74D12XeGZ5E9Rn/TZ7CpqVHV/KzryRHfw54k5+S4kuy6g5kmcMoQRdnI6c529ZTXw10NPDHUbrA7ZgJYBDJbqbjpdCjXs77zJ13HQo8FthFKMWGvMixgUG+o/tSe7uGleCh4LCtCLaYGv806trpGluOD4a+pjrpOlX1DpPcfCY2Z8Z88lae+IACMVCPPSIGmsUaOKKHMRr+G2sXdTP9LfDae9pKjhiff8CFnbtSAR20mm4fhTAPlhqAjnBXdsdjDVNE9YWU9isfW5CneK6kjAAU3jkKX5Ju8t7jsCPKZQ/bS2Y7I3Zqn5L8ZlIByW/juBsgEB16L5OmlAimscpKnpIPZl/QOqm44C/CpCRj4xPUCmnaDw70sMT4IaT1LxXoD5sm4yCWPzjgSjcLDjybvifJnyCOFEeHbbHKEkBO1jMLqQvMNztxa9uz3NW+HUeyI+3LUKQG8v7jQacGZRBvsIN6ixt8eAdxRbpQmBGWHW8O8WifEva4/2q527D+vUxbmphdA62RoWytxQR+S9SVHXG3bj04PyBW/EyN3i6eiu629ILZdiYfboFkh8lzyRsJEKkdI/IXkOYZOPlYcKGEViBMQ2z9PKwrYKpgnNZxW2Ou6p2of8buqZ9/1PW2q6EOc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0RnU3FRMkRpSUJlQVVJRDJCd2d6NG1XbjNVN3hWV01XNHZvNlVhTWNwaVd2?=
 =?utf-8?B?TzN3TnlJSlZiSmZMUzl6U2l6elFvdVhuWi9SeVNyUTZFZ2lrZ3dKYmFlZmlQ?=
 =?utf-8?B?SW9YZzhVUDN1VzlSdFlGamhBMExEVU5PeVVTNXdHbEpjZm9aNDBPUDlPTUZO?=
 =?utf-8?B?ZUxTWW8wemhNMTkreUh5Vi81dGJLRDU0dEZQcXo1ZDByeHRXT1l5OWFIZTgv?=
 =?utf-8?B?Ukp6cy9SWnI1d3N2WEZwMkRGSnZVd3BxRk1zWTVUb0xQYS8zOXVzU0VqODlG?=
 =?utf-8?B?UUlnczdIZEVUTWFFSzVHbTJnU3NPbTE5eSt3T0xudmtFcjlvMFg3MFdUZ0Fa?=
 =?utf-8?B?YnQzbHF5OTYzeXhjL1BwT2RJa1VEYTFiM2Nsc0ZkT1BJQzJmL2RUMGdPZ2Q1?=
 =?utf-8?B?SDA5R3Z6NHlFWmdrV1VaVENaK0ZzZGRKUzFrOTNVV2tYckRvTlRVY1JRUWt2?=
 =?utf-8?B?NG51WkhJM3pmUWxNWml2OUV0Qm1ua3VPT1VNemRldE5VWDJUMDRzTmdxRGV1?=
 =?utf-8?B?bzJEQnR5a3dWbFBTRkplWjJsNFBNZmdCYm1jbFc0R1o5N2dhQWl4RTZXd2d5?=
 =?utf-8?B?MDVMZnU1d2Rpdkl6dG9Ca1lTT0NzSE10dkFXRGVISmt6RjNKVzZCZVBENE5K?=
 =?utf-8?B?cm1lK1RWdHpDb1dpd1Bvd3EwM3RZMUl0N2lFRjVqbTg5ekdrQ2pkMUdkNnBP?=
 =?utf-8?B?WkRNNlJCYUNzWGRjUGtXeWF0VkR2U3VJRk1xODNyQk5FdDhaNDJzaDhpZ2Qz?=
 =?utf-8?B?b0JxcVU4UUUxWStUK3BFaCsrTmFSUEFJWVFQUU0yVmVsYzBYTitnYU9QSnBP?=
 =?utf-8?B?amhWNGRmYnNWMUQ2dGRmUVR3WTVuS0tJTC9pbU9rb1NNYll5bm5TVXRDWTh0?=
 =?utf-8?B?RGhnWDVncW5zZ2VLVm92WXRNSUZjZ2pnTzZvMkdXNSt4Tk43M0w1WGZiSFBO?=
 =?utf-8?B?bFRGSmZwb09nYmNUc3I0alVrQ2Vzd1BEY21COE05dDA2MWs5SEZIREV4N0ty?=
 =?utf-8?B?QWMzdENoMjR2OS9JMktXTGNackM3cUxVR2tSNkRneStkd2hiNk5YUXJWUU1G?=
 =?utf-8?B?WmRIcDRUb1ZPU0tJVGZjWmRBc1phZGhYUTRhaTlPbC9LVHBoRFdYZDhuQUxu?=
 =?utf-8?B?OXNnSmtDSWJVQVBOWHF2cFluZVVkYTFTYURTS1Rub3QxaDFkdWlhTENoRjQr?=
 =?utf-8?B?Z0svMFNMSVNWREp0bHpqeW95Ylc4a1FzUnFOREE4dHJ3bHJMa2Z1bFdnbldz?=
 =?utf-8?B?NFBWeFlReDAxMkRQRXVlN1dXS1hCdWNkVlE0UURQT0hIeVQ0UjVkOWlGeWRV?=
 =?utf-8?B?NCs3QnFQSVJKZkszWmNvcHJFZGlBNVU2SENKQ0phUkNCdzNybU1jTC9TMXNS?=
 =?utf-8?B?UmN4bjFpcVphUXBhUVJHVHNBblJ1NG1nNW10dzVMMEFVOGg4Z0xXMWdJeGoz?=
 =?utf-8?B?L0dPalk5TjBXUmhDZkdOOWxXNUk2bldKZDcwTXNxbDJzMWxMZzdRdWVpWlhB?=
 =?utf-8?B?YTlScERhczBPOGlXbHhBcjBHd3hjNGYxN29SVm5ISnY4cDYrVmRxT3V2SmJh?=
 =?utf-8?B?TG9tWXl1RG1iK0RDR0NFOHUzVEpiTEE0U3BSZTFReFNjeFBVRWxpOWpWSnNM?=
 =?utf-8?B?U3VvaTJqU2lpbG1uQkZtR3RRK2M4VXRNMnA3NjdLZWp0RFh6ZXIrUnU5R1M1?=
 =?utf-8?B?UTd4eW9iQWJNci9vNE5wV0w5a0UwTTdkU0NDNm5sRHBwZFBZNWRWSDltdSsx?=
 =?utf-8?B?ZnJtSFkyMDcrZVZhUDd6Um5SU3pmR0M0VzExdzExVkx2ckIzSWd2emtYRWx5?=
 =?utf-8?B?Wm5zU3FzaTJWWG1lcXN2RE5aQkUxUHgzMjZKdlFDQ0s3R0xBalMxUjVsRU1k?=
 =?utf-8?B?cmpXVFNPSW16OWZBQ2pkd2plaDVDOW5ReVhpbmV6SEpKSSt0bWw4TWx4eW1Y?=
 =?utf-8?B?L0JmSHYwN3V1cTFwS0dKdTdIUjZpM083V1BkNnhDQVpSd2t6TW5tNnluenhM?=
 =?utf-8?B?K1NrVkdNQjNuSTFkeFVPM3pja0JBZVNzTGFCdFFCL3JmVG1oc1QzaWlES3Rt?=
 =?utf-8?B?dEJXV0hjcEplWkdCRjloTGpTRVdJTWR1eWE4NzI0L3YyQzZaT3FSNDZxZGRQ?=
 =?utf-8?B?Z3FuSUtJakticmtoUTF2QnV0QzRMSzBYV1dhQmZqVFV4dnhiOVpaRmtNZ2xv?=
 =?utf-8?Q?1fO6o7QwsU27BWtykkPqAxw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mah/iDagKr9VJm+4cQWqMRjTku9jv+4UPDi+QjJfcGhPclio5aEXO2qU/wic3g+TrxA2ws0Ke3Eukl+lQLEhGwHKQt5U8G/+KjON9Hgke1pz4JA3hgjMISR8fsDrqz6j6SfCvm9oTapxGlBmQL2HBkIx4z/dFLnzPh7wqqZP23OOHUvVn/OCXmKRW/7unrVA5FLLV0lKH+csjEMKtZqr8K+ADLYn29o5px0C/ORKyBZnnrq/wriP3mgVdwd3H4LhnoBf5QGwNtXPwjZt6OCw2M7SvWeuEeRnREq2BisNRQTcGHcWHd5w9WNEm1TIIptBsrHSJngYdiWDLFaXCpxSZPBFa14bdmbpJhCEeRudRPuJCtC8R7aDnWBlolu0kczc0gQxtvlTeArWT1U8vP6uOlYb5QXIrBpXPjTMPwHTBa34nK+mMnVLu7f1gP1XcaZm0epzbvvqxrJVAvkmBLHiiNsasP49xVFbeUP5IxX6NPl0VLX4J3JmdfYmOzBjoV7jfvvapKy9oHfxBZW9e96YSS3ZuGsB0auMzAV6H57ZErjbzVMl73Cw0q+yAurIysmSdAVaRf+xEccWqD/WmCuSla6Ee5N2CdWEB+KeJaTVIkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142a0079-7b76-432d-9947-08dc5d803bc2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:14:12.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ON3sAGZDJpwU6fR30/xkCdbLGG5N2c+BrXJSqg5AgabytWYlQ+AKiuJhZoDJigC5JF9EwXyQnqNejVl+4F+vvUwp1IioxQwS+O7xHVZkzzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_16,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150127
X-Proofpoint-ORIG-GUID: u7Z1UhWjkLw-3Sk9MmdHCSbvWhpievYS
X-Proofpoint-GUID: u7Z1UhWjkLw-3Sk9MmdHCSbvWhpievYS

On 4/15/24 12:06 PM, Sidhartha Kumar wrote:
> On 4/15/24 11:28 AM, Vishal Moola wrote:
>> On Fri, Apr 12, 2024 at 11:21:38AM -0700, Sidhartha Kumar wrote:
>>> Allows us to rename dissolve_free_huge_pages() to
>>> dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
>>> directly and use page_folio() to convert the caller in mm/memory-failure.
>>>
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>> ---
>>>
>>> v1 -> v2:
>>>     - Change additional comments which reference hugepages to
>>>       hugetlb folios per Miaohe Lin.
>>>     - introduce patch 2
>>>
>>>   include/linux/hugetlb.h |  4 ++--
>>>   mm/hugetlb.c            | 17 ++++++++---------
>>>   mm/memory-failure.c     |  8 ++++----
>>>   3 files changed, 14 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 3f3e628802792..f4191b10345d6 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -861,7 +861,7 @@ static inline int hstate_index(struct hstate *h)
>>>       return h - hstates;
>>>   }
>>> -extern int dissolve_free_huge_page(struct page *page);
>>> +extern int dissolve_free_hugetlb_folio(struct folio *folio);
>>
>> You could drop the extern here as we don't need it anymore. Aside from that
>> LGTM.
>>
>> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>
> Hi Andrew,
> 
> Could this diff be folded in this patch to remove the extern per Vishal.
> 
> Thanks,
> Sid
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f4191b10345d6..4cd7895590b6c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -862,7 +862,7 @@ static inline int hstate_index(struct hstate *h)
>   }
> 
>   extern int dissolve_free_hugetlb_folio(struct folio *folio);
> -extern int dissolve_free_huge_pages(unsigned long start_pfn,
> +int dissolve_free_huge_pages(unsigned long start_pfn,
>                                      unsigned long end_pfn);
> 
>   #ifdef CONFIG_MEMORY_FAILURE
> 

Sorry, that diff is wrong, it should be:

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f4191b10345d6..8968e8a3a205d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -861,7 +861,7 @@ static inline int hstate_index(struct hstate *h)
         return h - hstates;
  }

-extern int dissolve_free_hugetlb_folio(struct folio *folio);
+int dissolve_free_hugetlb_folio(struct folio *folio);
  extern int dissolve_free_huge_pages(unsigned long start_pfn,
                                     unsigned long end_pfn);



