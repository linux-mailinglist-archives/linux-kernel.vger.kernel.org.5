Return-Path: <linux-kernel+bounces-111945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDDA887317
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5F41F2532E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4F664D9;
	Fri, 22 Mar 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NVK0EK0v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VaSzej+4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62E664BF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132118; cv=fail; b=HNVv3kD0c/Bs8Xo5MCUjdn88hTZpULaAYVbkENFR6YuexamZT+JSUOxT1pW27v4uFFbThbSdDVq9gUDFdFeBk5J/zr3Qop1FAzHDfQVqYTmek+5JD4H0n/X5S4fH7wAKwjIWLJsKasvJMvA+VksWRJ9CWjxu2RkQ9cPw9qInfvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132118; c=relaxed/simple;
	bh=kytrevySTEeYhWE4rJVAywJGO0yHb7s93A4gSxv6Ztw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxTQsWshEgUqBukl2IVgL6Vj67hqUZQBJkopTgB9Sp33ISyONGm1/XnnXWDluOpNTKd9cHprUKFX9XoqZ9V0YyqerhY8Q/ee/tRFZQ006Hf7nb/L87Eqxu/8D/414nUF4osLJt0kPv3XfrngS3vTKfGPn/Paq6vivwbag0jlIy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NVK0EK0v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VaSzej+4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDK2m6006285;
	Fri, 22 Mar 2024 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kytrevySTEeYhWE4rJVAywJGO0yHb7s93A4gSxv6Ztw=;
 b=NVK0EK0vHRnZ5AeXPbqpla2Jv8oxONpp+oWql+7XnhPrQYYAPNIcUgzoDM4uX+AoIZ3j
 0Eda4JNWY625vmj2XIMEJjwB1+34uSXbfmuI7aj4hDzeNdXpNmaAjKdzwHpdf2rUoFBO
 U7wRdLQZ/knM6ZRbBzDaOHgZAVrt+VINpTNpfbCCjhc+vwgYWekg/L0m8WpfC3987oG/
 kevTod+rzRuQuPCRZlJQtEbTCw8HK6M1DhT4HD7N47Xe5OGcFZlg5yuBBrvvJxdPorht
 BQ6UVlZE9KwkYhvfvUFluuSJ7yO69VsZMnbvVfVeBxPDTY6EMthNENrhUTJQk7h9YFZO PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvm9qbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 18:28:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MIJ4xK004204;
	Fri, 22 Mar 2024 18:28:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvmc8jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 18:28:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7vx5zGM0FStBXyOz3GxsS1AHFGZT/1nw0Ql8Hih54b9hQw6sXVPBAm0gHYxRPjO0Y9LKIlVmYe3bpKj3xfR5jJaog0IwTNoDT0HsXON7uLU9AKEY75lG7KEEpXqDjyy38XM8pNq7uA+oZjR8Emnk91GZC9lUPbHqJZYJQ0BNRTQKtEruzZx4tKRuYmM86D35L5ERpzPnIMwXD4QdsGsF4AtwcabeuYBSv7srvhc9sJAPspzMP5JHnAkYwtgBMIivSRyb7MmahlkPXBka7r+lg/VgSg341cR/QpfEg5DugijSggQ0ZKE5DyFKozyE+mOzawbIyOCgfNL4blq6pZsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kytrevySTEeYhWE4rJVAywJGO0yHb7s93A4gSxv6Ztw=;
 b=F3O2jdthnUSMmtACpMYphaI7xIJqImq677MdTp0kF3g3rmLEhIeUiey1dG8NFfssjDE/ZoEnakjn+JcxWRVimYcZ3FAHPZfag1kyl/BLd4c0i649ZYNgmnb5lLXSX2dw0VMOss/l2JwKLY3mv+t0R5uYW/OEbtylEwt90zd/DY7d8Ugr7uxxLjF74CWhk1F6V/x4VG6hHFi/m545i8Fp6IrK5ph9cL+TkRe6pDSuRpA9f7il+1pDSQosLE3RlP19gtUc6M8XDB0ldKUEhG+dVTs63/gJAlilvBDtozSaUvubcINNMZzO6UQonK8iw8MpeN69u6ngebTNsMVw1VBdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kytrevySTEeYhWE4rJVAywJGO0yHb7s93A4gSxv6Ztw=;
 b=VaSzej+4Ge7uLxQ/xmbKqfp4nIjJbPyPmBPMXmTMtBqn7SDWsKTMNUqcnprNvoMnPFICBKcedQpXZBucysDmNERc0WlecM8VZsB/WAM55Ch5i2Q3hVhNzJdgzPzNuPoDOJMiUKzJVDUljG5/60Eqx1FbbcAANbOwuCQf+P3ICSU=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by DS0PR10MB7955.namprd10.prod.outlook.com (2603:10b6:8:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 18:28:24 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::2c16:18f6:a8e2:4caa]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::2c16:18f6:a8e2:4caa%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 18:28:24 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before
 XSAVE
Thread-Topic: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0
 before XSAVE
Thread-Index: AQHafG9UBhVMcTr0lU6QlR+7RegrZLFEFIgA
Date: Fri, 22 Mar 2024 18:28:24 +0000
Message-ID: <CC80AED2-E5A5-4E09-BCBB-4F9EAD0AD0AC@oracle.com>
References: <20240321215622.3396410-1-aruna.ramakrishna@oracle.com>
 <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
 <5b536d60-d130-4061-984e-3b83a3cab092@intel.com>
In-Reply-To: <5b536d60-d130-4061-984e-3b83a3cab092@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|DS0PR10MB7955:EE_
x-ms-office365-filtering-correlation-id: c0c8c6c0-d773-464d-a2e4-08dc4a9ddc77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WFFhgs01zcy60LZF6LQwBYxxHNwACwkKLRVvOXMoRH1lP7j+z7cJMZ59ZY1wfTpZnrFpcvK6QIsSq+O/Oon4+Rst4DaQATl8xj7VdElozNx+B23XK3Zk+lEI0fHelQvI+60zzPx4Wtxj4d+84a+7eHkMbjZ1cZqKfBCGkBSivwiXB8hNWS7PTYjquPujU2XlzOP7hpKh1UeM5QLpUnqHYoVfjjYh2WxRGOocF6syvPoqTSmWWkIMGFfvckIM35n8p32hwpbRrND6zTZfR2ALkFby9TkTqY40ArkPRLNvbF2QT1p8KW/nvOs5iZEARfbaMYLWH/ypXRYnM+tzmWtGkjrxaFjs8YqYnsFuw7yC5RPTn5/GhZDLMEeIzTeqZgZo+NPhlsMgjfAIrAkN6C9I6oMZ3ub8F9HHWyxhJGOXBUIMERzdC419nRqmzXFcMITXcbuYEE/V6zOu86/fcWeond2Hb680x7ecc9LT3VhNrg4PYHc2lylqUmOggY+UQShGezGDdaUizDo3jzIgPAW5UKjooMvZB4sgKSsftxjqU/YYA377js5KYfFcqkCgF98UzQmS5HniXisHOi2k0S9sfuB+zvv6DFlvddn5+g91wUpcb8xGxjROkwZDuWWcjXT2LkS1hcbzIkgPXjup+l+sTKOY6qBSlxxi5AE+0HkowZwelLlZasnewe1hIfN+HcKeXabX/6o3LstblYpLe46/v1w3JAwSU/WYxBLzxhK3fCo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Wlh5SUZrUjBoTnUxQ1oycllXMTRWYkRRYUZKSkdpYVBHa0pqbnYwWTlpblBS?=
 =?utf-8?B?SzhyanBBVVJWMDlnRGd1U21MTmtGbUs0cnpyVDBPTlZlcVpZL1hibWoxSHZM?=
 =?utf-8?B?WldJSDE0cjVjS2k3M25hb3pkUU03NldBbnR6dlRLNk5NbjVuZGw5dmJMSGQ5?=
 =?utf-8?B?b0ozNkNtOGpodW1sQTF3cEgrQjFSUlA4THROaVo3cE1hQ3dCNkdYMFkvRWR3?=
 =?utf-8?B?c3hXM0o5NjhMMnFsclVxSEVCUnJGb3dpVlgwUnl4cWIwNjkwTHhvRGQzZXJS?=
 =?utf-8?B?L3RFTDhoUUxZS1pIeFRBZS9MaWJRc2wxL3cwNisvS0tuQ1JNQUNuZHdyRkI5?=
 =?utf-8?B?Mk9sSGc5bTBYNEJUMGQrZ2xjQTNobXVrYnhaTlNZV0VmMWs1Q3J5ZHI3TGpH?=
 =?utf-8?B?QWRkS2tnVlErWEhwUUFGekFTV0JrSk1ETDBrNnc5Q2RmZDg4UWNEV0RybUNK?=
 =?utf-8?B?QVhxTVZGNjQ4N1IxSk5RVGZmdWJQV0RXY3FKNGNFWUw0amdvWEFNZkJIclZL?=
 =?utf-8?B?NUJNQlpuNUN2bk1xdHY0bUVJSGlTN0x4c1dIWnJjMm83eUticzZ4VGUyVDNK?=
 =?utf-8?B?bktLNlQzbFVtN3ZUc25JYnVkQjkrUVh2SDFxTy82Nm5yVUdJZnVmQlBQS0hO?=
 =?utf-8?B?VmVCaVY1YUwvREpyWU1xL0FiYlFPMHJQYnBPejdSL2Vwd0Rpb05sWm55S3h0?=
 =?utf-8?B?eTVtRTUya2FweHN4eDhOSEZWaXhEb2tVdEFvSGFyVkRjNWZ4bFJtZmQ4MDNI?=
 =?utf-8?B?KzA4RC9MUGkrdGEzSTlyRUpYS2FlM3lLamd1c2VZaSs5bCtpMTJSd3ZaZThh?=
 =?utf-8?B?R2JrOWJmTXpza2NXZWExczJZYnY1SnhNcmJrMkp6SWlLRzNjSlI0NWJUZnVD?=
 =?utf-8?B?S3NvNng4V0xrNlRORWtkbm1BWmhORW4wc3FBT01TT1YwejROellObEovZE1l?=
 =?utf-8?B?MlB4RHIxaDNSaFVKTkFXY2t4UnpSM2pJdmYyUVhNbzRvUDg0c1hKaGViR3pD?=
 =?utf-8?B?ZnZyWjFqOW5jUldUQnpNSmhtRmJKYUVPQ3I1aEwrZi8ydS9hQmFwa1RRRlg1?=
 =?utf-8?B?bkhpM1ppWm5pT25iTS9UcjZEdm56UGMrSEdLRG1ZcjljcFY4bWpWZWF1UXRl?=
 =?utf-8?B?VVBwSmQyTlFtdDE5SDU4YjZzeTZUcmNYWmpMU25vVzZZdTlZTXhUNnRGVUdw?=
 =?utf-8?B?SmRoWnlJZFdKckw5c3RveGF1TllSQU5RSi9tT3RPRHJMMGsrWHBxMkM1MmVy?=
 =?utf-8?B?NStzN2VvZjFrQ2lVREhuU21vT2txTGtNMUU2eVRRMEZsTTNvQ1pyRitzK056?=
 =?utf-8?B?ckw5ZWJidmlnTVJLMm5Za3BoYXNxWUJCR1RhcnhLUkhITWkwSTMveFpTSjVD?=
 =?utf-8?B?WlNUS2w4cjM1ZEc5ZU9tYXJTYnNXVnVieTlEaGJweDRmZ2Q5b2VFbUFiRnVa?=
 =?utf-8?B?bko4LzVBeUFzMzQ5MExvbEwraFMzL3RlUzR6TXBuMEdpbjdzMG9FbkFGWUl3?=
 =?utf-8?B?SHh2ZW11WEdHNkJ2OGJqd3NyY05TdFc2djRxRklMd1lLNHN4U05PRGVvY0ow?=
 =?utf-8?B?VmIzY0FVMDR5VXpJSEpVU1c0RjlldU1jTHZnWVhZYU4zZnJnSCtqR3FRS2tK?=
 =?utf-8?B?aWNyTFA4RXNQYW82eHRmMUk2eFlKaEZlaXNNUnU1SUs4dmFSYlBOUURCK1l0?=
 =?utf-8?B?Y01qLzVudU1YOXBIOTAvTFVmQXVOcEV1RVE3UDZXblZHRUNRNVl4NmVSbWQv?=
 =?utf-8?B?ZHhja29xaGhqTit5dDhKc2xDVnZ1YVBNRGtBU2pMK1kzS0s0VUdEUGNXbmlM?=
 =?utf-8?B?ZHJFVWlaZ2ovTFVQUXBJWG1INjFrcjFOcExpa3ZJNmFaa3BEem1jT3d4T2pD?=
 =?utf-8?B?Q25JbGswYnNOVjh0Snd4SGlsN3hrRkNRTWdoZDZFelNzTnNhUW1tTzU3ZEgz?=
 =?utf-8?B?Slo1N3VaeEEzMFoxbU4rbVJtekNOZUZCZmkxd3YwQ1hIRlV4Q3J3cTVTVnhy?=
 =?utf-8?B?UGl1YjloWUNObWZldlFsSWppc1V5eGRGbWdSWG9jTXNadUxKMitxUE82Y3Nz?=
 =?utf-8?B?SU9IL2FKb2grcHFnS1F3Q01rVm85eHpYY2ZVNE5kUDFMbW14TzlGQmJCMWZZ?=
 =?utf-8?B?N0hQc1V2UExxbCtSK05KWlkwSkpwbVlCNFBkaXFpeFBwMXBGMWtVcngzd3ZW?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF1F268F6F2C744B0C8791CCD86DD3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AV7K9XenJ8W02po4lGh5qOfY4dwCY4eFXRbe0Q9ggVH7RoCOt0b6LqAGC70rnmDDIR9rp1ETCH3rYMwM5v6aVSJsA78HdUYMV3PJ7NDXYT3pS7zAjkr7fNLRuoOP2I7vrz93VbAHLByy8LR6uzSg2LsVB0hoHiPYkjrGY5YVw4CYLw/QSsrFjeB9npF5H3Hs/YaYgXripAc2ca/c56AY8b5eg0rjYpjrVW8kteQkXKHNj7/4tFQKqmF28XoIg4PVPivur9Art4yFDpC1MWT889DdrNKN+PkMh4UjtpRbnSWaQS6EVf9N8oov7odll8gZvAMnRhce4xNX4qIWGVrfZjIZGqOULxupb8jy8Z0mV8+Rw+3mmr1vKTvwdM3ZIGYq20F5OHx9KAxN5uS9A33KM0D1hhzR/n+5GPbNlNI7BWj1FHtXyl3fi0rlDQRY/CIqYGmpAYT3sxFRSnlLtfNo7qzlvO4tNT8BzPleGs+FY8R27B9oT6f2bLCMEr2QepVP5VGNmovJo3i3r1yjyWu7LB9NyMLU1gIAjFX1yqM6UVM6hnMELUvGHU9y83CXEmnFdg1Z96RjIsKtth7OaOiUXdLn42TyQy5+LY5cxA2KH4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c8c6c0-d773-464d-a2e4-08dc4a9ddc77
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 18:28:24.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN00+TgZX/B9wU084Fwjc7ZaYNe23OTSGyQ/sMZHKYYXJj7w6LT/XT4vsOAEayc5awHEfWLu4kVB2cZ+j5vPYj4OzHoLMyXTDPBe31Jv97U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220133
X-Proofpoint-GUID: jdiGpM3hRtuqT4Cnpa2PbFT6O0xBWSdv
X-Proofpoint-ORIG-GUID: jdiGpM3hRtuqT4Cnpa2PbFT6O0xBWSdv

DQo+IE9uIE1hciAyMiwgMjAyNCwgYXQgODo0MOKAr0FNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDMvMjEvMjQgMTQ6NTYsIEFydW5hIFJhbWFr
cmlzaG5hIHdyb3RlOg0KPj4gKy8qDQo+PiArICogRW5zdXJlIHRoYXQgdGhlIGJvdGggdGhlIGN1
cnJlbnQgc3RhY2sgYW5kIHRoZSBhbHRlcm5hdGUgc2lnbmFsDQo+PiArICogc3RhY2sgaXMgd3Jp
dGVhYmxlLiBUaGUgYWx0ZXJuYXRlIHN0YWNrIG11c3QgYmUgYWNjZXNzaWJsZSBieSB0aGUNCj4+
ICsgKiBpbml0IFBLUlUgdmFsdWUuDQo+PiArICovDQo+PiArc3RhdGljIGlubGluZSB1MzIgc2ln
X3ByZXBhcmVfcGtydSh2b2lkKQ0KPj4gK3sNCj4+ICsgdTMyIGN1cnJlbnRfcGtydSA9IHJlYWRf
cGtydSgpOw0KPj4gKyB1MzIgaW5pdF9wa3J1X3NuYXBzaG90ID0gcGtydV9nZXRfaW5pdF92YWx1
ZSgpOw0KPj4gKw0KPj4gKyB3cml0ZV9wa3J1KGN1cnJlbnRfcGtydSAmIGluaXRfcGtydV9zbmFw
c2hvdCk7DQo+PiArIHJldHVybiBjdXJyZW50X3BrcnU7DQo+PiArfQ0KPiANCj4gVGhhdCBjb21t
ZW50IGlzIHF1aXRlIG1pc2xlYWRpbmcuICBUaGlzIGNvZGUgaGFzICpaRVJPKiBrbm93bGVkZ2Ug
b2YgdGhlDQo+IHBlcm1pc3Npb25zIG9uIGVpdGhlciB0aGUgY3VycmVudCBvciBhbHRlcm5hdGUg
c3RhY2suICBJdCBfYXNzdW1lc18gdGhhdA0KPiB0aGUgY3VycmVudCBQS1JVIHBlcm1pc3Npb25z
IGFsbG93IHdyaXRlcyB0byB0aGUgY3VycmVudCBzdGFjayBhbmQNCj4gX2Fzc3VtZXNfIHRoYXQg
dGhlIGluaXQgUEtSVSB2YWx1ZSBjYW4gd3JpdGUgdG8gdGhlIGFsdGVybmF0aXZlIHN0YWNrLg0K
PiANCj4gVGhvc2UgYXJlbid0IGJhZCBhc3N1bXB0aW9ucywgYnV0IHRoZXkgX2FyZV8gYXNzdW1w
dGlvbnMgYW5kIG5lZWQgdG8gYmUNCj4gY2xlYXJseSBjYWxsZWQgb3V0IGFzIHN1Y2guDQo+IA0K
PiBUaGUgJyYnIG9wZXJhdGlvbiBsb29rcyByYXRoZXIgcmFuZG9tIGFuZCBuZWVkcyBhbiBleHBs
YW5hdGlvbi4gIFdoYXQgaXMNCj4gdGhhdCBsb2dpY2FsbHkgdHJ5aW5nIHRvIGRvPyAgSXQncyB0
cnlpbmcgdG8gY2xlYXIgYml0cyBpbiB0aGUgb2xkDQo+IChwcmUtc2lnbmFsKSBQS1JVIHZhbHVl
IHNvIHRoYXQgaXQgZ2FpbnMgd3JpdGUgYWNjZXNzIHRvIHRoZSBhbHQgc3RhY2suDQo+IFBsZWFz
ZSBzYXkgdGhhdC4NCj4gDQo+IFdoaWNoIGxlYWRzIG1lIHRvIGFzazogV2h5IGJvdGhlciB3aXRo
IHRoZSAnJic/ICBJdCB3b3VsZCBiZSBzaW1wbGVyIHRvLA0KPiBmb3IgaW5zdGFuY2UsIGp1c3Qg
d3Jwa3J1KDApLiAgV2hhdCBpcyBiZWluZyB3cml0dGVuIHRvIHRoZSBvbGQgc3RhY2sgYXQNCj4g
dGhpcyBwb2ludD8NCg0KUmlnaHQuIFRoaXMgd29ya3Mgb25seSBmb3IgdGhlIHZlcnkgc3BlY2lm
aWMgdXNlIGNhc2Ugd2hlcmUgdGhlIGFsdCBzdGFjaw0KaXMgcHJvdGVjdGVkIGJ5IGluaXRfcGty
dSBhbmQgdGhlIGN1cnJlbnQgZXhlY3V0aW9uIHN0YWNrIGlzIHByb3RlY3RlZCBieQ0KdGhlIHRo
cmVhZOKAmXMgUEtSVS4gSWYgdGhvc2UgYXNzdW1wdGlvbnMgZG8gbm90IGhvbGQgZm9yIGFuIGFw
cGxpY2F0aW9uLA0KdGhlbiBpdCB3b3VsZCBzdGlsbCBydW4gaW50byB0aGUgc2FtZSBpc3N1ZS4g
DQoNCkkgd2FzbuKAmXQgc3VyZSBpZiBlbmFibGluZyBhbGwgcGtleXMgYmVmb3JlIFhTQVZFIC0g
aS5lLiB3cnBrcnUoMCkgLSB3aWxsIGJlDQphY2NlcHRhYmxlIGZyb20gYSBzZWN1cml0eSBzdGFu
ZHBvaW50LiBJZiBpdCBpcywgdGhhdCBzZWVtcyBsaWtlIGEgbW9yZQ0KZ2VuZXJpYyBzb2x1dGlv
biB0aGFuIHdoYXTigJlzIGluIHRoaXMgcGF0Y2guIA0KDQo+IA0KPiBJIGFsc28gZGlzbGlrZSBz
b21ldGhpbmcgYmVpbmcgY2FsbGVkICdjdXJyZW50X3BrcnUnIHdoZW4gaXQncyBjbGVhcmx5DQo+
IHRoZSBvbGQgdmFsdWUgYnkgdGhlIHRpbWUgaXQgaXMgcmV0dXJuZWQuDQo+IA0KPj4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBzaWdfcmVzdG9yZV9wa3J1KHUzMiBwa3J1KQ0KPj4gK3sNCj4+ICsgd3Jp
dGVfcGtydShwa3J1KTsNCj4+ICt9DQo+IA0KPiBUaGlzIHNlZW1zIGxpa2UgdW5uZWNlc3Nhcnkg
YWJzdHJhY3Rpb24uDQoNClllYWguIEp1c3QgdHJ5aW5nIHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0
aGUgcHJlcC9yZXN0b3Jl4oCmDQoNCkkgY2FuIHJlbW92ZSB0aGlzLg0KDQpUaGFua3MsDQpBcnVu
YQ==

