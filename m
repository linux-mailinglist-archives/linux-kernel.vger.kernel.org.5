Return-Path: <linux-kernel+bounces-73791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22085CB43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EDA284366
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E6154433;
	Tue, 20 Feb 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8r5bhHu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K+cUTS7i"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D4152DE4;
	Tue, 20 Feb 2024 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469899; cv=fail; b=clvxUFU7HLGF1AcBEcS3GhpqVkTs4+6UCEhdyvZSnfRwwlP1ycr1Oify3ytJK0Q/FJSr1tdK2h6/7l6eFnHupD2TvhtJ/yc0XmSq4VY1zzOBh/ZAji52fjqAfP9jO5JaOekUWSRDAVrRGYEqKNGcCvZiv6PDgRgu8ibnoMxpaEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469899; c=relaxed/simple;
	bh=Cqpg6+eE0BPz5fF6ykpLZ9YoKXHzJQ5sB1fudvnuP0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKE5Lw/5Ek+39dhrVoIt7ySo9xsynmpOEJhlnpN/fiWKIdSqNZ73XfEsQDPnKJLfIax6U/01/zcLO3Jl+7Fffe+fTYBQf1Yqwv+a9ocb0olorMPifkaFIEEUORPOjRU9YOEpBKKWuilPWlan8YTwpxoM+mo6Jk4uJelP05mYifs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8r5bhHu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K+cUTS7i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKSidf016782;
	Tue, 20 Feb 2024 22:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NA2VBQzKrD8Ck19OA+qjcAE9XRJhIjO6SRN6PmVkQP4=;
 b=A8r5bhHus+9wD3s4hRkgFswE3fM7+UV3XBgSFa1LFjGGdlX7+13nM93pf1xN3QCgjgqh
 Bx59Gpi2ar8JQSPmtBotuNRoA7Us3idNP0Ec0QOph1GbmoikWe2ukxMDpZxfyeLcR6vi
 imIW8H2O2nPh77t0pbGvZIOKioI06Y8W8k8nH8ycPU5tOntubFwzHp91iQBz9vmGXwsP
 uC963F/VgaFkLW4LufoGclNbehBmg1nmQFJi2bLSUy1Ddx1JQeOUvj0jwf2ogQh269wq
 j5SizCwS44QR91dEYJUmU2qDhtvaY7Z9oXzzjGhwSNmux5KRdwmacY3oGnrmimZD3O7K gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu08kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:58:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLULYY021335;
	Tue, 20 Feb 2024 22:58:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88apjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4v1CM7V+kOHnjMGPzFj2nQ2foZlqqTXsusMFoll3GOqUbCqsOm2nuY8d8W0ygcd5FLutO2ErPCAvfltN3ifTQBjrCsPNkkr6tOmAdG8I1KiPyG4C7SjGt+3nHvDSJbfWYJ1ZdKvwy+4V4OeA6/gN9Tx53DCZejFL4Fy+/HA1OJOOxvDy/OXZJPKNDX9mpHs+AaIjS2zb5DEyd+9ZG/S/sSHzcHOWblzrhXiTqaICPgDkifly8uMxE+Pa2i9EbcPJ0662MXxIyAK66/9tGl2F7dDp3cGxZOMVAYprqq6/iPfIQMe18TaEChLFAmT/5RAOrUnh0lr++DPI+NR2uzlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA2VBQzKrD8Ck19OA+qjcAE9XRJhIjO6SRN6PmVkQP4=;
 b=kmHMJZCgE70kg9z1ioHpW339hKoy9oDAAAQ9xgDUL9akmSOUisPt5hQzIlBQVc3ETEXoc8LbjFBz91jbIrbGOX79xvsS47VacJajcdqrGi90mE4wxcCvS63GHQr5IE1xEDpDfIdh0YyCirq4f/mWJxorY82+RsyHXf1aCwVS72n53VOkVAlyzG1w8XFH1VJ4wsKl46a1fyWXnNnU0nMFIW3Jxfke8+cVvkpdo71J/0FEtY8OBhFnXmes5jGgNBNC1bh/NLuNl6oLZfO3lJKqchQuNcwylwEBX8OzUF7mNvocIdfC7DBETkRJnN4+ai9u8GJPt5Epo3pDWH1cXkHnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA2VBQzKrD8Ck19OA+qjcAE9XRJhIjO6SRN6PmVkQP4=;
 b=K+cUTS7iJ5mO91DMse/jHWc4XjWqcYLP2KBuGJoZ66uXJx5X70PyfBNN+UVgU+bRILdTV4WeH1qJLjTETGRCWLyF7CvvqIyu1hDndBfuabK/h3/gKe5ceeFmOZ8lHDnAhiudS4npYtT8xuvkFp70J1kLzkcC0Af6kDHssWEn/YY=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM6PR10MB4364.namprd10.prod.outlook.com (2603:10b6:5:223::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 22:58:02 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c%5]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:58:02 +0000
Message-ID: <657ade76-98c5-4f93-9716-b471b31d07e2@oracle.com>
Date: Tue, 20 Feb 2024 14:57:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CZA9CM3PDILC.82JMLUWMB6B7@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM6PR10MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 264e1b28-2192-4e6d-49b2-08dc32676446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OQ5SlDDIAE2xwvZSOHoDPM/a4VCsEMjUX8FocEkmKxx4TJ1iHQgj7Yx4L/gORz3HGlkve65Alhc2mwett5SsC+gKX9Y9u/8v10TqNNt2qMxk2LueSsOTeajTkKNAStcA+yHi6JOVR3EYn3raQucKqlN41ta5R7ZRq6PS7TU3cA1KVbftiNT/Rj78e76sNcyO41FAZI3Ykz9xt3UKBLWwoBV1QdUvc9KhYAD4ktEojChMPwyMLFKQoJVQyE1OzZw9VleqLnTihA95jYBxc/vGQMwbBvJ9q1YnNEWg45L0KNVCTm3WB5aq4F/fLaXHu0LJrY67DrjNMFwypANFx+AyW8sESab7OJjkqjCP4RcDuT7hMVHVlJxKw5EIouNp2/KjVaHh3OxyG12O2/XwC5Kz8lvuJDoj6sczRJFSTnzKKpoMyHwVmhf4JCFDbU0RYPWbbRpo84XLBhYI4hlE92GV3uGVlenzm6vSyMFTsibhdlJaVpSYp4A6ur70fxrCR+A72zbq1B/1PdVTEO1fqGZPiKURdxdjN6jVen38HqUdit8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXl5QTVQU0N1OXJIMHpRU2x3eUlHOS9uQTNMaklxSFpvY0tJMnJLWis2Uld1?=
 =?utf-8?B?RHFka0lkbU1BdC83QTRrTXVld1FkVXV3V2JrcjJUNnJwT2VuS3lTY0pUNTdM?=
 =?utf-8?B?aFlubjR0RlIrczJ1VEd6VUlKWEVmdDdURWkvaDNvSmU1UzNSeEt1dzF5d2gx?=
 =?utf-8?B?YnY3K0d6NXE2QjB6NEhlWGJ3ZjFqOHJDWGZZVlhVb04vOUZpSVY1cWFVcHhD?=
 =?utf-8?B?TnFhTGNjQ2RlM1Y5VFZtaTJhenFDSE5GUDg2bmNWNm92V2NtMFFIMjZhV0lr?=
 =?utf-8?B?R0FhVy92b2lEUXZVK0ZuM3VOZjRkSytZeEVOMlJNQnhFS2NOdXI2b292Y3VY?=
 =?utf-8?B?WThDWVFEOUNDYk5uV050d2hvaFZzN2F4WmlxODYyRllveDltZElmbkx5a2JY?=
 =?utf-8?B?OURzNjljTENOZHl1aHRLZUVrL1JvdnpNNS9LQUMyMkh1b3BkMzZDWjRWTWhW?=
 =?utf-8?B?R1IvWjRtdVAyTEZrMzhpS0I3cVY1RjVJZWxtSXU1VHpaVFgxVFd0Ui9vNk9Y?=
 =?utf-8?B?cWlJTGVpemVlOXVjY2RaSUhZS2xHQS9nL05SS1d3ZHVHZGRXSHFXdjh4bVJi?=
 =?utf-8?B?d3phemx5b2lPdUU4RFNMRldJNEhDM0krK2NKU2lHUXdSVVNvRzJCQVNtWkdw?=
 =?utf-8?B?WFpnYjhpcys4ZnltTWNaK29JYUhzQVJ0TWJad3l2U0ZTc0IrR2FmTVdkKzlL?=
 =?utf-8?B?Y0tpSk56dlMxSWxDU3p6VDZSdDYvWGoyYkRHR09iRHBrRkZYMk1USENXUkpU?=
 =?utf-8?B?WDJUU0hRVjdJRUNaRXVLYkJnaVR1eG1RMUFZMXRhRWs3MG9wUVVaZUhsYlZh?=
 =?utf-8?B?UFE1Y3FmcWtLVG93T09DTlI5cWZPdUFQTnpURkpLVVRBd2lzVVg4MG16MFlp?=
 =?utf-8?B?OEc1NEpkeUZhNko2Y2ZEbklWOElHY0g2bFpEb0VrSlFsRGRXdEg3UzZPMkpV?=
 =?utf-8?B?bEh3ektDaVliZkRRQmtVTEkyc05TUlZmeW83SW0yYVdZTyt4RjVYYlpEWDNF?=
 =?utf-8?B?Z2dHVmsrVmpuZnl1U0FUV01PeXd3V0ltdWJpaDJWbzE0SDl6dUgwL0gwQnZq?=
 =?utf-8?B?NlBwVzc4a1ZDREJ3YW5zRW5VUFJsUWRWWUFhOFF5b2kxaVcvMDVPK1dnR1lq?=
 =?utf-8?B?cnVpRnFMaUpmQnF1NGlxOUpWTERxVzhkVDBEUUp6aERYYlY1RXEwRGxkQVAy?=
 =?utf-8?B?YnNuTEJpa210SFpyRVJtOThrQnc2NEpHeGdZYjBPMk53c3Jzcnl3TFZydFFX?=
 =?utf-8?B?dml2QWFtemZ5VmlvdWdEdC9GZzlCRXJaOU4zbVRxZTltSEFkUmg0eHhoOFlz?=
 =?utf-8?B?VGNZeEtRT2E1THlWSUl0bjF1Z3cxTmZFYi9kY3JoSEFSbVkvZHM4QkhMY1oy?=
 =?utf-8?B?RWpGaTlnK3VkQ0pUQUVEcVpTMlk5OUx2ak5aK2ZNYWI5MkQ4d1F3cExRSE9T?=
 =?utf-8?B?WlBqTTVYVGl1RjBKZFptcTJwb0JZbnc4dkNtYXhpVGxuTTFKUEdveWNLZU1O?=
 =?utf-8?B?Tk5yUHAxRWVTeEYxZC9lODVHcjl3amNpTEZpeTIzYmErU0ppOWdtZHBRQ1Qx?=
 =?utf-8?B?R3BrcE5EUnNyN3BhR1NERDY5REYvTkFTWkdKK3luRW9hbG1qaUxhMmxpeXBk?=
 =?utf-8?B?OUgzQ0J0dktzZFRSbERxNGQ2N1FkeEttTjB4RHZqNURuNHRCRTlDZnJGYnlQ?=
 =?utf-8?B?N3JLY3VuSE1na0xRbE5wTngwSFU4Slg1cVFUZHFHSVV1aWhzalhTZUdQR3Q4?=
 =?utf-8?B?YmUwTCtGcXFjcjN4V3FMR3JsM0ZFWUMyQ2ZrTHgvTmpuamN2Z3dKYmNFYTFM?=
 =?utf-8?B?RHpaN1oweFlybWh4WVl6Y1VtUzk5ZWxFZ1c3dThlTk11VERRTktMVDA1dm5q?=
 =?utf-8?B?d2lBOFZlNFRLbVJVTkFRV1BJc1V6RjJyUHh5ZEU2akVwdDdHbTRMWXpKTFdj?=
 =?utf-8?B?RmxMcUJJMWJXd1ZQY2VHYW0yRHp3d21SYlRDdXcwMFFncUVaSHUyOVFhRzlO?=
 =?utf-8?B?OUVHNmozV3RQMTlWazc1K2ZTeXBQWHdmd0FHZGRWZ0J6V1ZLdE05VFlrek1i?=
 =?utf-8?B?SllnVW9Sdys2YUx1RFMzQVY1cURESkNlWnUxNjJRVWw1aDQvNDFqSVI0RnRF?=
 =?utf-8?B?QnBQL29xQklwTllOKzRPT1NrYjdhOTNldVgwZ1UzMDdGZ0pqTlNTK0lmZXlR?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qNLDkB3ebB1/rI4PMWz8orX72TYXQoxwL88M9uWFNW3iKQfc9a4Ja0mjjdDmGr+hzG9qtlW1xnd+6Fnxdk0pCsWePE6NbhJHpUFAdGD9nI9tUQ1p/Ox9wgZHgTUJKYj+mBquiBqmILNpxcB8dB+A+iFKvAOWmkphTkqFYnCe+JBRPJOQmEQWYE7YAVSb7bT912m9HhpAss8SzEetAuOvh475Z827zCf0vXiFbpcv2eAC5AGHfUb1GYMalECxUC7lkadM11D1yfO+ElDYp6cBIymooZ1V57l7mEps8f5IlqLkR0U37NyhMJuti7+k8/Pua+rmFA25QznAD/h3HlHBUE1Ws7yFWRvrCJyGTu2cHTi316FZAq2Ps5/7vx17cPyFko07WqFRfsrOodVgzEo7EkPLC2vj4F4Qy09GkWFuhAupQ+jbNgpVAmpfdQjXLzvLwXKySXbsCVni+1ddMirqaWdwoJryxLTm/3PvBaph3wkbT91HB+tsZi0BAqifOo1OzAXKg9zqhr080iKwhpsK3DJTw3WV6UyrZGzJ6glLFPWEfUdW1fI8O4VF8x25xy5f2iEo8fZlD9/xfV4v7gwfMLtSYFN2kkevqIaw2u19gTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264e1b28-2192-4e6d-49b2-08dc32676446
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:58:02.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfFTPOOLTKBilppjOrVE9NXVstVBbdpSy5kP+hfwPlYhJYE/5gt4SmZ2iBnTASRotjosrbYlmS3SPAobClvN6i+e3sS0/Ne+85qBlIRfSR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=890 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200164
X-Proofpoint-GUID: hCxxQJNxNPUv714ZDlYlm7TdQ7LwIWFg
X-Proofpoint-ORIG-GUID: hCxxQJNxNPUv714ZDlYlm7TdQ7LwIWFg

On 2/20/24 2:26 PM, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
>> for (i = 0; i <= MAX_LOCALITY; i++)
>> 	__tpm_tis_relinquish_locality(priv, i);
> 
> I'm pretty unfamiliar with Intel TXT so asking a dummy question:
> if Intel TXT uses locality 2 I suppose we should not try to
> relinquish it, or?

The TPM has five localities (0 - 4). Localities 1 - 4 are for DRTM 
support. For TXT, locality 4 is hard wired to the CPU - nothing else can 
touch it. Locality 3 is only ever accessible when the CPU is executing 
an AC (Authenticated Code) module. That leaves 1 and 2 for the DRTM 
software environment to use. If the DRTM software opens 1 or 2, it 
should close them before exiting the DRTM.

> 
> AFAIK, we don't have a symbol called MAX_LOCALITY.

Daniel added it in the patch set.

Thanks
Ross

> 
> BR, Jarkko


