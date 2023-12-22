Return-Path: <linux-kernel+bounces-10085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CA81CFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C671F2432E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF782F503;
	Fri, 22 Dec 2023 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="q7bgAlF2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dPOQ9bJ4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i7sr+qgS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4D1EB43;
	Fri, 22 Dec 2023 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4j9p011869;
	Fri, 22 Dec 2023 14:40:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=d7HUG01PTEby22jv83n1INHf+TkZdfgEQpJ3ZTcuOCc=; b=
	q7bgAlF2ljnAYn2TQx3T4Oowej3aDiJkqr/m4F2y82va6nq06KSZlbVZ86EMz4w1
	IL9LsojutRPB5uUJwHSVRX+nctjDM+6qtqS12sTv+LxvTw7KwioccxrQcWQ3NIgr
	HQXiPjkcbzrO1JnfvEeHekF/eBcEokeTxeu21lujTr/X962QaU4NJEuzee19EzR4
	m5jDOZXOz+MAmgMmpMyPqmoEP8PSG3iHeQ5ELdnZqsx9lj8r6Ye6V2dwGhXDcmVS
	M+AtlRnwjdZbIxD7NNC2VaSA+0SWost1CjyiY05oJLseFYZPrzMw6Fbv8QAw99Wg
	l0iNzV6dN6rj3krQDfFP8w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpvrfab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703284828; bh=d7HUG01PTEby22jv83n1INHf+TkZdfgEQpJ3ZTcuOCc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=dPOQ9bJ4AgSONXBWPCH6Pfc8ciiEtZFGH7JDoEUs2nEb4eOSLeQmkjTz5q1gMjwpi
	 DMsnLHuC3V84W702KHvoEZx7RdN/DWRQt+d63zl18AYhrRGQopEq8J3rXJRApDmGIB
	 WeGeWfn5EtLw7eLF3vLlQ8P9e8DLPSF1UGItN4CUdvtfDyLpOSypdEr7bxLwai2KgU
	 g3I8BnC3LuuoNxzFzrZG3raxxZMHlmnb5l8LfeaB6TkXsbe50VWEDMiNZHOBvAIuXG
	 TwQxBdL3qd5FcFAm7JMBckHvTk2Buzke0OoNYj6qwhCnNCku/uZhIZOhMUSnEgMQOP
	 ha58HD5ruknhg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6944C403B9;
	Fri, 22 Dec 2023 22:40:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 282C5A009D;
	Fri, 22 Dec 2023 22:40:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=i7sr+qgS;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AEDC4401C6;
	Fri, 22 Dec 2023 22:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAYq+ApGwRpRXXPYI+md4WtJqbTyExXjVzus82jer1Lu3gKsbcXYgEJ4bfFreT0e4EihBagi6p+gliHf7kVI50w1JPy7IaW99RI6+tQbMqd0UncIcKqO/hQafbR8Yqz/EWDtJt6NU/sK+UNKnjUNhT8MQT4DGhVCkAc56Kx1PzHCIP83TLrVNqv35SfYUmaPr4VKKW+LqcFSVTvDdVdn/paNUN6pIercldDEw6dHUAubIpP9BPgQNIfNFCRJGCU/1UxDi+aURCtcWUEuXdjP4G8gkRXNeNU8e1L1AUilwFQW6QWoDWQNIjHNqJ3bwwwe0sQrmoFITZ4kjICkhjIjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7HUG01PTEby22jv83n1INHf+TkZdfgEQpJ3ZTcuOCc=;
 b=QYVSGkSgQJy2p7Zxar7oueVTNCJC82k+JzCEtn9mr5zKMDDW4q1lve3AmR0NAiHwPUt+BbaF+/2TAK4Ubs3wYjXGmPIOVJfpGfFHUR6kRchw2bMOAsX/uAFd3klOegGZhigvjcUYVf2n7irq+oIscIakCCCfm4BNkJdyREa5ukooePpN3JCNmPEt2tWshEwa9lNMQTC2Yuo4ez/WifX+g4UF28Rc45oY/RdISphb3xy4hSbr8KeEwaVjdU9/NrwDCaBSHpCGr454pVoDcFRBxi/yayqDRRYjB6M3VA3Jn2AFragvjhEXGIYXvn3dsCmLaGWc2slZJAEKmr9Kzvc30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7HUG01PTEby22jv83n1INHf+TkZdfgEQpJ3ZTcuOCc=;
 b=i7sr+qgSkEXXCrSIdxI3lSucdWCcsgxWfgfKbxjx2NLWWchIy7/ResXh5uE/sgUR2VX8FvMp1B0iLWYc/vyfthJkMesdoAKH1cvKhyozxHDS/ardE3ZG6GY8SAyTD80fOZzvVFa4djVz77dE2bJLeY8ESRVi2dDfI1c28MHfVBE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:40:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:40:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Badhri Jagan Sridharan <badhri@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "raychi@google.com" <raychi@google.com>,
        "royluo@google.com" <royluo@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: dwc3: Refactor usb-psy init
Thread-Topic: [PATCH v1 1/2] usb: dwc3: Refactor usb-psy init
Thread-Index: AQHaL9ITcdRgPEa6PUa4BddeQ2A5ObC18A0A
Date: Fri, 22 Dec 2023 22:40:23 +0000
Message-ID: <20231222224022.f57nlj35d2n6azp5@synopsys.com>
References: <20231216034335.242168-1-badhri@google.com>
In-Reply-To: <20231216034335.242168-1-badhri@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB7518:EE_
x-ms-office365-filtering-correlation-id: f18bfe84-940a-4f74-28bc-08dc033efc80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TktxgiQWhXbj17vfsyBoQnk61YM5OwakSn9hsFgRK6uzPcL2ySd0E9o5QgkfIK9zxlfR234DSHlh2dTqtBGyfr45js+1E+40X1PugozbMQj87GoOli0pa0lnD7JtfPcz7CBylhzaK+XlTQUKjr9rGMNe9hlqPSi5+lcDFdkGS1dpUgjhFZbGS3C5d8VrcsHbCC1XTDf+0CMhUVLqQgL7TDfGotOcWXaIfDgLJyfcb3r+xZz2rr8UeXwGYWdGKtrHW6RWYkF/pAZ2osZDMcigGqoD5+gPnT5ZL30QTePHdOC+B7YjRGA1kfYzonvyLdvHzb/l8A7UKN4w6YWsdVJYRQMumKwekJWvVQwVVJQTdqzGqavNWl9qhZprUCguD7uNOeVeeVuRlB0PpT6+25Tw8cC2MSX+RFZhCc7udS3teAwWel6Ap6h47KYZpMZzlN8oIqeN6EXwi87ln/7kWlgN5zLmsshv+A0Ge8pSKvXgd52iNfyOUVZ38Sc9VmLaCBsXVGGOYe4mDZbmFzc4uooVSmNL001ZGaRlylSULNqOOaPPtGq5s6SwdWX10ufLaMU+7MCDQpeiiqpOd9/5mwu1Sh6FwHq7WocJ1ooEYyIncRSZ8UmRgVA9Ttvhcz76CuTD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(76116006)(64756008)(6916009)(316002)(5660300002)(8936002)(66446008)(54906003)(66946007)(66476007)(8676002)(66556008)(1076003)(2616005)(83380400001)(26005)(6506007)(38100700002)(478600001)(122000001)(4326008)(6486002)(71200400001)(36756003)(38070700009)(2906002)(6512007)(41300700001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dENSTCtOd0lKVnZkZ1Rac1pQdktjejFKdU95MEZqS2gvSURrQ3IwOHU1R3Vz?=
 =?utf-8?B?cm85LzZLZTBtQThSZ05pYnczeGdEZjNnd0JucFZEdjJuL2FLY2p6VU5jMHhj?=
 =?utf-8?B?ZW55QmFJYm9yeFhYWHdiSlNGUjFqSDNqODBRbnJsU0tud2NtTXo3aWdRQm9M?=
 =?utf-8?B?RkkrVmpxZFRCRnF5czduWEtNbmVnWE5nTEpvdTVyZTFLQVRoWGZkRWpkSTYy?=
 =?utf-8?B?TDNybUdFcm5FNW0rN29sUW1zVkgyV0syVEpxQ2pHVCsyMFNLWWNsT3ZsZ0RU?=
 =?utf-8?B?TnBXTi9qcnhlQ2pDbjQ3VTBJR2ovRS9abk05b21CNzZCenRkb3h0enBsMlhQ?=
 =?utf-8?B?Kzl3d211bGp2Um9pNERSWTZNb1d6OXdqRW9sbEdZZmY4V3dodWNSSEwxYnZJ?=
 =?utf-8?B?dFhpU3c0QitFa29zdm5zVXQ3SUR5dHozem0wSFEyUkQwY2ZtclcrMW5pRHdy?=
 =?utf-8?B?cWZlcFR5aWJqdmQwV1NKY0tZVHJEc0toQUF1NFd3dlc3eUU5YmNIZkFIa1Fp?=
 =?utf-8?B?TStDZkRob0J2QitFWXNmSFVYd0ZIK3ZZMVlDZ2FtMFZiUjJLQXJNQmVaY0dJ?=
 =?utf-8?B?emxhaU1GNUJrTDRHUndQL0xkbkErdlcrMGVGbDVuRDFkSmlPSDJSYXJ1akJJ?=
 =?utf-8?B?Q2JqaUhUM1VBTVJRckdkYVB5N2t1MTBqTkY5aDBrdjE2RVNDY0p0RDRBYjVE?=
 =?utf-8?B?U0p6Z1NudzBic1pzYS85c3puUFBia1dhbE4zZDEwdXduUHlpVnRNUWFiei9S?=
 =?utf-8?B?SFRXTEtBdUc5dVN2WlBIZk1VWmpmRlh5REllN28vL255UlVadVF0cUl1M3ZM?=
 =?utf-8?B?bkxlLyt5dk5RaTFyTVV6a3pXWFFXVC9jNnJhWTdxRDRHcU10bnRva1dNQkF2?=
 =?utf-8?B?MXdURlY1Sk5DZlF4cXFlckpHbmhlbDduTmFTRmZqTGdYSWZuSjY4MlRqSU9F?=
 =?utf-8?B?cStEazB6SHVyUzYyT3JyNHU4U1Jzb3JSZGxqNUdLUVNMRnRZdmdqWi8vS3ds?=
 =?utf-8?B?aCtpWGpsOFFTeTV5cnM0YUhZbFR4Q1ZaMGM2cDNyd25HeW5DSzVzUGprbUJK?=
 =?utf-8?B?bUFLOHg4YnBWQjlGZ09Qb0k2WmFCQ3JVeXMwaGFkV25aS1hRYktIeEQ2T3VF?=
 =?utf-8?B?Z29RV0Z0N1Z4SCt5Y2kydlVRU2ZJZnJ6cmVqUkhadVFVL0UySUM1TmttMVRr?=
 =?utf-8?B?RTNxY1ZJNklYc2xTb2JOdndRaXlnUU41Q1pmYVNhVHpLdkZYQkVCRTF5a3JK?=
 =?utf-8?B?OWVzWWhLK3p3dEJEZFY2TU9CSEpqN2dVMG00K2tVU1NxSnlpNCs4T0V0dlVH?=
 =?utf-8?B?UXphVFBaNzhiQ3cvV2x2MG1mcWFEeHJCVk5lUllaSkRKS3lkWHFUVUh0aGpW?=
 =?utf-8?B?eHU5eUlRZTRINzVXK2Fra1NSSW9hSnViUER6SzZTYmpsOGlTeFp2cStqTm5V?=
 =?utf-8?B?bUNQaFRnajFPZEdKbkdEbUYwZ3ZwbDBOUzBkaUdONjhwalEyOVZXc1dHTnRU?=
 =?utf-8?B?eExjOEVoNHhxWStETXVWSzRESmIwUEZFcW1Cb2doYkFLQlgyQWJIOGczRisx?=
 =?utf-8?B?QVgvc3JlcHg1cWtnd3BJeGp6RE85d082L0dWZm4wYTVDUHZWRTFFK1FKbkMy?=
 =?utf-8?B?VWYxZmNYQXNvdkhyRnVscm12d2F3MmZ5S3RPTFJONXZvdmJFbHNXd25KSC9C?=
 =?utf-8?B?T2k5YnlyMVVZN25scGF6V0J3ZjlxRlR3NGhPOHFDeEVlSHhSckg2QklwN0tP?=
 =?utf-8?B?cGZIbERvNXBDTXRjelBYakFySkNkSm5KWkNkK1J0WVdTNkZ3WUlmMHVTQVMz?=
 =?utf-8?B?TVlLRGYveWxqNHE1VlJPZENhdmwreTVvTnlyNkZ5VU5hMjY2aEorS1llMVp5?=
 =?utf-8?B?Q1pjWS94QkJNcmwrUW51d0NxeU1PQ3Jvd2VyRDhINzcxT2NZUCt0MVJ6TjVp?=
 =?utf-8?B?ZEJKTGZ6T3pkZEhTZTBSck1GZGd1dlJlbTNYQk5hTU5FNmt4aEdNREQvT09m?=
 =?utf-8?B?cjNObTBmSHVwT0UwY3BOQVh4dkhOOEEzN0FZWFNTRHMwc29nNnhVRGtzMEdY?=
 =?utf-8?B?dXJhaHBMd0Npam8zOU5IL3gyT0l1Mk4ycTBIbFhWL2paSll2UHdtU2dESzZl?=
 =?utf-8?Q?YdvEDxfoJCldby2hkls7WiLGo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D944BD370070449960E882FD12D13F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6KfizLPf/ilEJIKhTt/abtV3xTVJ/R3EqgdKJr33QcdS1Ve6hNZzihxzSEE0LdkjOZOUFBFtOb8iXSj1UuizVbtzqdde7QALplCmbhxsWYWFGEIwWl9j7x8pEkO8jxMw7NQQlH4FGspax4+0N+MlLlvSG8XCo4UQOUau/bY2uNkbb5GT8IO0nTl2tvyh0SHJvy7qOLgSgP5gFTgmPJ16ArJPzlVzEFSd3OnH4+/f5JEi5eEs0CcPK06EsCNUVuztiAIy0U8bOlSNVr21fLgrAcg21w0mDYP5nKNazrSx29rHYm1yXybjhoqRWkgl9Hzcb7SRsshBLYRSVVQiS2rQvPbO7IkLPuPomr2D7yWWWET1CRSsXhWV5F07Vk7vDdaHhvwF6yFWLPx/l1K8k+fg/1GWN/n/Ut3FTEsivzt87bVsgvQuC0LRgoRRNGYFgo+W2LNelvQj6w0OaZ+TcQDYJuidm93kktFr6BR/E8BWRP6ipcXJxqNQglPFQkDE8qxH3s5WNBfcBYlIqj/guJJ5zHB5eP+NyDgG0IFZU8zKlXRt/P31My3Pb6c6MVzZJyD7mRT3GAHH6bDUD9hpxEEkUzblVWN72gqD1VTmBk6MdAJDaoUO2pL/GF146CnDoBYqH9vGK2pD4s60mI4rAvR1lg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18bfe84-940a-4f74-28bc-08dc033efc80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:40:23.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrnokwQgsMtvMBpUrSpLxRGqePYcnU9WQ8sIInWRAtXb14OlJNMKrHie/RDaCthiIwe2hH4+6UPh24HSJs9ZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Proofpoint-ORIG-GUID: 52UQ2JjuCS6xIo3A5X79bGDATXALKACQ
X-Proofpoint-GUID: 52UQ2JjuCS6xIo3A5X79bGDATXALKACQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220168

T24gU2F0LCBEZWMgMTYsIDIwMjMsIEJhZGhyaSBKYWdhbiBTcmlkaGFyYW4gd3JvdGU6DQo+IE1v
dmUgdXNiLXBzeSBpbml0IHRvIGR3YzNfcG9wdWxhdGVfdXNiX3BzeSgpIHNvIHRoYXQgZ2FkZ2V0
IGNhbiByZS11c2UNCj4gaXQgdG8gcmV0cnkgc2V0dGluZyB1cCB1c2ItcHN5IHdoZW4gbnVsbC4N
Cj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiA2ZjA3NjRiNWFkZWEg
KCJ1c2I6IGR3YzM6IGFkZCBhIHBvd2VyIHN1cHBseSBmb3IgY3VycmVudCBjb250cm9sIikNCg0K
VGhpcyBpcyBub3QgYSBmaXguIEl0IHNob3VsZG4ndCBnbyB0byBzdGFibGUuDQoNCj4gU2lnbmVk
LW9mZi1ieTogQmFkaHJpIEphZ2FuIFNyaWRoYXJhbiA8YmFkaHJpQGdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAyNCArKysrKysrKysrKysrKysrLS0tLS0t
LS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXgg
YjEwMWRiZjhjNWRjLi5hOTM0MjViOWMxYzAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xNDk1LDYg
KzE0OTUsMTkgQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX2V4aXRfbW9kZShzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiAgCWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsN
Cj4gIH0NCj4gIA0KPiArdm9pZCBkd2MzX3BvcHVsYXRlX3VzYl9wc3koc3RydWN0IGR3YzMgKmR3
YykNCj4gK3sNCj4gKwljb25zdCBjaGFyICp1c2JfcHN5X25hbWU7DQo+ICsJaW50IHJldDsNCj4g
Kw0KPiArCWlmIChkd2MtPnVzYl9wc3kpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCXJldCA9IGRl
dmljZV9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkd2MtPmRldiwgInVzYi1wc3ktbmFtZSIsICZ1c2Jf
cHN5X25hbWUpOw0KPiArCWlmIChyZXQgPj0gMCkNCj4gKwkJZHdjLT51c2JfcHN5ID0gcG93ZXJf
c3VwcGx5X2dldF9ieV9uYW1lKHVzYl9wc3lfbmFtZSk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2
b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlzdHJ1
Y3QgZGV2aWNlCQkqZGV2ID0gZHdjLT5kZXY7DQo+IEBAIC0xNTEwLDggKzE1MjMsNiBAQCBzdGF0
aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJdTgJCQl0
eF90aHJfbnVtX3BrdF9wcmQgPSAwOw0KPiAgCXU4CQkJdHhfbWF4X2J1cnN0X3ByZCA9IDA7DQo+
ICAJdTgJCQl0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiAtCWNvbnN0IGNoYXIJCSp1c2JfcHN5
X25hbWU7DQo+IC0JaW50CQkJcmV0Ow0KPiAgDQo+ICAJLyogZGVmYXVsdCB0byBoaWdoZXN0IHBv
c3NpYmxlIHRocmVzaG9sZCAqLw0KPiAgCWxwbV9ueWV0X3RocmVzaG9sZCA9IDB4ZjsNCj4gQEAg
LTE1NDQsMTIgKzE1NTUsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJZWxzZQ0KPiAgCQlkd2MtPnN5c2RldiA9IGR3Yy0+ZGV2Ow0KPiAg
DQo+IC0JcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfc3RyaW5nKGRldiwgInVzYi1wc3ktbmFt
ZSIsICZ1c2JfcHN5X25hbWUpOw0KPiAtCWlmIChyZXQgPj0gMCkgew0KPiAtCQlkd2MtPnVzYl9w
c3kgPSBwb3dlcl9zdXBwbHlfZ2V0X2J5X25hbWUodXNiX3BzeV9uYW1lKTsNCj4gLQkJaWYgKCFk
d2MtPnVzYl9wc3kpDQo+IC0JCQlkZXZfZXJyKGRldiwgImNvdWxkbid0IGdldCB1c2IgcG93ZXIg
c3VwcGx5XG4iKTsNCj4gLQl9DQo+ICsJZHdjM19wb3B1bGF0ZV91c2JfcHN5KGR3Yyk7DQo+ICsJ
aWYgKCFkd2MtPnVzYl9wc3kpDQo+ICsJCWRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IHVzYiBw
b3dlciBzdXBwbHlcbiIpOw0KPiAgDQo+ICAJZHdjLT5oYXNfbHBtX2VycmF0dW0gPSBkZXZpY2Vf
cHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gIAkJCQkic25wcyxoYXMtbHBtLWVycmF0dW0iKTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gaW5kZXggZWZlNmNhZjRkMGU4Li42YzY1ZDc2ZTZmZTIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oDQo+IEBAIC0xNTI2LDYgKzE1MjYsNyBAQCBzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3Bh
cmFtcyB7DQo+ICB2b2lkIGR3YzNfc2V0X3BydGNhcChzdHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9k
ZSk7DQo+ICB2b2lkIGR3YzNfc2V0X21vZGUoc3RydWN0IGR3YzMgKmR3YywgdTMyIG1vZGUpOw0K
PiAgdTMyIGR3YzNfY29yZV9maWZvX3NwYWNlKHN0cnVjdCBkd2MzX2VwICpkZXAsIHU4IHR5cGUp
Ow0KPiArdm9pZCBkd2MzX3BvcHVsYXRlX3VzYl9wc3koc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICAN
Cj4gICNkZWZpbmUgRFdDM19JUF9JUyhfaXApCQkJCQkJCVwNCj4gIAkoZHdjLT5pcCA9PSBfaXAj
I19JUCkNCj4gDQo+IGJhc2UtY29tbWl0OiA1MTkyMDIwNzY3NGU5ZTM0NzVhOTFkMjA5MTU4Mzg4
OTc5MmRmOTlhDQo+IC0tIA0KPiAyLjQzLjAuNDcyLmczMTU1OTQ2YzNhLWdvb2cNCj4gDQoNCldo
eSBkbyB3ZSB3YW50IHRvIHJldHJ5IGFnYWluPyBQZXJoYXBzIHRoZSBkd2MzIG5lZWRzIHRvIHdh
aXQgZm9yIHRoZQ0KcG93ZXIgc3VwcGx5IGF2YWlsYWJsZSBieSB1c2luZyAtRVBST0JFX0RFRkVS
UkVEPw0KDQpCUiwNClRoaW5o

