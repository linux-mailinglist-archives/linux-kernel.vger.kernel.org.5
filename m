Return-Path: <linux-kernel+bounces-104057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FD87C85A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F971C221E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61DDF4D;
	Fri, 15 Mar 2024 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oSAh9TKd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KFmbrKiF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA79DDBE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478087; cv=fail; b=BiYS083Lq8PG0BLV8Xin3nTYBSMCyIYyS0yrguEg7i9YH1VDLaszZTQ2kcTh/+8mRL7kefdG3GOtqSpSW+QJ5PrpjjQiOiAKT2BBRiPns3xkHLwnMh6EkoJG+RuIUWlYA98HQTeYEcd6+FL/PSqvhHgHxU+h6EfAGNEYVU6CBuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478087; c=relaxed/simple;
	bh=ZypRYTH72QWIFrurq4MfsBbzyVgbBXGw9BcDbg1lK58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fyfk+jX9tpGK97mIjvfH9SldYX9/z1jHxoEVJzF/y3y1+QtqF7jAbgIYcXYfN+xxMTttIi+lUNckcc2TCfSkx0vFPKZQuOkLTAzlaGOHQ1/dT6g1FDnQ1+wFzWHby41Z4PWVNZgYwWJ/qyz9I0jWSVDheyTgrDN0gwwL5N0G1b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oSAh9TKd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KFmbrKiF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42F1EJ7b018610;
	Fri, 15 Mar 2024 04:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZypRYTH72QWIFrurq4MfsBbzyVgbBXGw9BcDbg1lK58=;
 b=oSAh9TKdyJMb2nTKfmsrp3I/x9a0xkdjVtljtFVuBbX+vXzkCAyuY/Av2uYSF/0Y+Pio
 hZ3dTD0GphCYNddWxCAxK3Usg7vc9E74B3KCck/F4NfvbeCcc1OSnFzadTRshJvOX++C
 uvRV3FxVfY3LUJ5VHy1iPNg19AnIjsnaNCuBI+UeIC6ut5OI3zLyLwTMODEG4cgOn3NU
 y6qXrV4L1Uf0tjM8pxJ+hWSNoUiXo5Nk9noK4s/ip9q0ywLAsy8pxKDDlCfwIKfTehVO
 EEpF8dOd68tNeq8wnhJGVrjOV3/JcMN8qbK31m0WjoJh7tWjmCiLlzsT6wF0+KHuqHPm SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abhu83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 04:47:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42F4WHTi033761;
	Fri, 15 Mar 2024 04:47:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b3d03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 04:47:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLsPV1tPmr+eDjCfSIA8cBh/a7j5W60fmKox2fCmyH3ELjKhDnrH0FukYAMQXHIM9E3DeBcxhqujpisDcZ9RBis83R1Ts8FcvbkOrxiq95N834x4XqUCH6Kj4EbncpuL6vQUBkoNMqcd8bDaxfZ2rgcgwIr+AVie07yibPKw8tF2u1M1T8LXIB+VOskHvtMP0eRF75ApeRN/8H2dDPTV5pIrKSMxer2vMrSNrGOEG2ycG6cOl36UesXxwfZdNJmoD1nm3Wjmq0tWIlFBuWc+T+ixz2hb95OsgIcBmiEcLd92LLniwTu4NFtxXkvkUfkVuLLc31ljw8Vz+jjUXEiivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZypRYTH72QWIFrurq4MfsBbzyVgbBXGw9BcDbg1lK58=;
 b=DGQFsn7bSNMtgZ8IrUo0f2ia4ck3iVyb/j7kVR/ZJ45N6ySNpmBcb5RBP7X2UcXV+27Z9uVmAWnF80IRomGzqYBeDSxP2i/AdJqjd6bzSV9p14P70Oju8a3+ejrtMTQxI5fiNVgZ3vBsKaw5V5D1/IIZodpMCXHQjMyA/6aRJgggeOoQPE+d3Be51Qbdyn3i2Zt9gN2xDfs6rXPs2uef53sSQQdcECDFQGWol0vqe3SyUZWehuTHz6erJxF9GaTjhnF4TAnRipYQwBuPmrlUJGsgV8xzQjdTynuEdUJGZEb/BhfhrqU9zrJ3OSGtN+L9F+SGeKm9DulxiPsDg0LZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZypRYTH72QWIFrurq4MfsBbzyVgbBXGw9BcDbg1lK58=;
 b=KFmbrKiFPNTQPQqAz1g+4EYnsSk5273vOKdE3rfuWpfqMxzXHv/dcRJeWuGGSR0cSGHRD9YdHq0zrGIy7wUutJldvxnWMUE+UYtpAFVaRjWKf7LLsSTpLX6evLCLDNG+qoVYi8txc/tu66D79ovl98ySUMTfNpIVGoFjNVYekVg=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 04:47:47 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 04:47:47 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>,
        Eric Sedlar
	<eric.sedlar@oracle.com>,
        Andrew Brownsword <andrew.brownsword@oracle.com>,
        Craig Schelp <craig.schelp@oracle.com>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Topic: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Index: AQHadjilIjzOVMIJj0qYATgIHVicxLE3ioOAgAAES4CAAKyNAA==
Date: Fri, 15 Mar 2024 04:47:47 +0000
Message-ID: <67F8113C-8E0F-4560-8967-FFF9ABF4FBEF@oracle.com>
References: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
 <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
 <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com>
 <ce99c89d-f7ed-4d9d-b04d-4699245c55d1@intel.com>
In-Reply-To: <ce99c89d-f7ed-4d9d-b04d-4699245c55d1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|SA3PR10MB6998:EE_
x-ms-office365-filtering-correlation-id: 79ba17d5-eed7-49be-435e-08dc44ab0fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6BBepBoFC6M+xj2aFEfFI6eQ3uYHQkekHQY5XJz7An54FUdDnVEumQLB2g2WeGSXmpCl3sZrrjVplI4bGQMAuCkw0r6n4j3sKUTZBVPHmt29O71deapxsMZAEwksVzAnbfq5ZKQCqeyKHiw8mDOKf81LuY59XkTRSMl9orEPkL8p+VlNtMIFqoa9YD7rTqHQTG2Hv10P9P6F+wZElvCDhTS5XStKf23fcygvb8jLrRAEdAYj86SF1zEqNoY/NbI5+798OXLrDkM9yg6T3vY1c66b4ZJ+mPeg/jPeW0I00679oQZLYc5mIQ+ObukgwsWUU8AFGVtg9Z2h2tPTp4NzuX4vM+t7cpwB2q+HWy/RDFyStlYvPNWIEscohPs9IlznW930as3PhYPaLEast10Q0TY3YDOvW6khYc3Ln6CvTWgitaf+pmcN5SbXpkilwo1jj05jfEPlljxA3h18AbpdJHdmejliBI29CvyGjrJ2DCC4D4GiLJo98cPgB3eQu7S8T6MRFHNKyuN74lnl8LGFl7l0qLE6il2ce1mfAQyXDfrGs9/Pfi3jRR3CmXmRlqNFegqvItaSFRkoHeWA+oBTPrFkwex0zHh4Q/YzOsWuChktHbuJ/My+t6XNxI6q73x2TjfObrF6JhYjEj/+r25XPT1n8J7wT9jeJ2zA+Gmxx9s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OGpscWxRUFcxTW1IMlJrTkZIK0JLTlVNbXMvUjhpcnZJSWlnS1lyYU9PMURk?=
 =?utf-8?B?VGFET29ncXRud1VCSVZEWUt0UEJQbHNVd1hQWS9UQjNsQlhCWi9FcHNhYWEy?=
 =?utf-8?B?b1JxTUxtRWNqeGx6alRtWE0xWjZHWEt6Sm8wZUJSdWYrejUzeTliMlY5b2NW?=
 =?utf-8?B?d1VGclRRYVY2WHUzTDFZMHM1OUNHOS9meEJkRU05WmFGeldQTGt0WjZaNkQ0?=
 =?utf-8?B?dWNCaDJ5c0JVVjJ1ZGZXcVREdndqYkpLR1h6M1hVc3pSREMraUJZT29xYVRu?=
 =?utf-8?B?ME9Ud1UvQTMvSUJ6U0hINVdQUFlFR0hjbmpicFB5a3JTVXlLcThRcUVkTkFk?=
 =?utf-8?B?cUtaUjFvVGpQUzU2OWRDVGtCNjZaV0lpeG1MTjJvZ2k2OVZHbWxuTHJleUNn?=
 =?utf-8?B?dExnS003TFJVdWx0TDlDb1ZHNDhzMEdtQzlzd2l0UUZHVW1HbVRGNDVXZXI0?=
 =?utf-8?B?Uk1jRVVNK1FHVDdIMldvUXJkU1N6TGZOV2JOUFNveVA1RmxJWW9lNUo2bFlB?=
 =?utf-8?B?VWVWZ2YzL0FFVGhJNnhMNzVUNDBJc2VqUlA4Q3dhQmk3Wk1kNDE0Y2RIcTlu?=
 =?utf-8?B?WDVOZEZoRmtlNVBtMWF2RmVTV09ELzM1TmtReitFck1jZXB2Uy9SaFN5TFZt?=
 =?utf-8?B?UTA0SFVsVkhyc1U0VStNcEM5MnRDR2pIdFZTQzdNZVNIRWRNd1poWXN5MmpS?=
 =?utf-8?B?UjI5RGIwd1NkdzBwSHNzdytxZnZYazcvNW5TQnFldEFDMWJ2TGxveW9mV2Jm?=
 =?utf-8?B?QTJoRlFXU05QZ25nMEp3ME14VnBCRFRBcWN5eDZrczZrUmRCQnAxZkhEbEJK?=
 =?utf-8?B?dUY1bXRObG5Oa3JMeUkyM0JSdzFQM1gvSXh0b0J3bWorVjhSRmFYanlNUG42?=
 =?utf-8?B?dkV0bGkydVhjVnhwSVdoazVOWEx5OU5hVXdzVmlXMnZkZUl3aHRYME5zMDVM?=
 =?utf-8?B?NGhNWFhMbFQ4RE16QlZrS0NoOWwxQStMczhaTnkxejVrRWk5M0ZRRE9YZ2Ix?=
 =?utf-8?B?WitoNXBSUjlxbW0xY1JCTHJ5dWtxZU1BeWJBeXlZWGl1Qnl0bTN1YlVSdFZL?=
 =?utf-8?B?ODZNQUJsS3VVUzFKdGVVNTJFQkxZM1djaWFZcllLak00b0k4S0JYd3NsZEY0?=
 =?utf-8?B?Rk9qalhGZHY2UWxaYjltQ01KalBBZVZCZU5pTFljTUtnTDg5OWdkbmJEQ1l2?=
 =?utf-8?B?TGI4YUt4eVFXM1FTUmpPSGRGc2RJSjRnSEo0cTNYdDAvbWx2c3BUNndyTjg4?=
 =?utf-8?B?MHhucXJ2Zk1IclBkSTR1YVJ4MDNEL3pET1lJRHZyTitQTEpYekoxVm5JOVhm?=
 =?utf-8?B?a3AyRTVhOHdtdjBPNGRnTkJtUU9BaDNLanUxS3FFMXorWUViSmdyaVh6OHJI?=
 =?utf-8?B?WE1UNVlOWEJ5SENqTnF1bzNicGV5SlprSUxrTkkrdTFRRjJWSFFqaEFaOFU3?=
 =?utf-8?B?UmZveTk0S1l3SnpEeDJHODNna091WHRqbnhscldQcndDNWpRdDg2eS84cmVx?=
 =?utf-8?B?OEFSSnVRRFRpMmc1R3V3Y3VjWFRmUWZyL2tqYXhFckRTZ3QrZmJTVVFtampR?=
 =?utf-8?B?SUdzZ1hjZURGMXpnMnhXbU13bGdBL1haTGtCTmpjdXpQZjBtNWxSWXNnMisr?=
 =?utf-8?B?dGQ0eGpoNEJHV2R6VCtIbmhVWGNHMnh1ekdtTEZaSTg1Vmo5azd2ejFvLzZF?=
 =?utf-8?B?ZkprL28xNVZEVHdBY3JWODZEVzNlQjN1bVl2Z2ZmWFZFQURyeTdqMEZIT2FL?=
 =?utf-8?B?N2NwWTZ0SVpCeUI1WUNXakszRnVJZ1lOVWlROGEvNlN5ZDBnMnNxWGdsUndy?=
 =?utf-8?B?Y09qWmRaUlB6MDJPMXpSVWI0TFRSaVZrQlpUY1IzeWl1bU1Ja0YrQUhiWjla?=
 =?utf-8?B?c1A4VTE1cnhDcjJiMUIwQU9XbEg2eWVGNW1LbEpLSThVVExQZHNob09ESXpM?=
 =?utf-8?B?R2ZNWkZodFNNOHowb0cyRlJoK21Wc04yb0ZRWXIvTXJBM2RrYWRaTVQxNHE5?=
 =?utf-8?B?ZkFmRGRxcWxyeDJwYkJ6VEZ0VTZHc3dITmN4aHBrODhyS0pCZUV6cG5mVEUy?=
 =?utf-8?B?S2pVQXM3VTI2U3pUMDhRNDMyaVRLY0JTQ1FERCtlVi9NMW1UR05TMGc2VXBu?=
 =?utf-8?B?cThZTmNkaGpmbTFOZ0szRzZOWmV6SFJnem5UbzA5dm1qNUVSMnorcURCdzBU?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <185386E9399AC043B0479E674D7DCBE2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XICM9N2OQwbigTDIx4TNHn/cOoYnv4VLuRXm3QN5Amf3q1mHzbo8Z+FxSdpcdmdz1M9VlT56+z4vbb3VMxk1UY8LMuqmujBgrIRcrnLiMgyf8C2k+I6YVGaxvJC1cYS9rUO5xKhPlDwtdUO/XIP1lFqNkhVYlc4w+3iOostEBBaiEf+IpcZTZRpwxjLfvgIhxegb+8pFxwS2EMx7f3rorfKXCHb2Fm/R4/tS3KYmnsYGl8EvMfbrCvD2ldb8NhMImq8uXUsll+GA9muCVVZW+mRXJiaYvvXjkl7gRhiUlUfWPjqG/LJCDQG599dNEGPtLm+2QqAnxc6wH/LiqfZVSkSwcbrRGBn8wpQhXdBoetBUcqMmlcLJCXh7Zst0zhoVoKcoJiUV5RLgypvPMCgB0Yf/T/zHxxQ0Fqsst1Mpht/CH3J3ctxw7K7ERu9SmZNutLzTLXClESHXfv6u2Gvlfzs81ioVUe2aP8Wqi54Qxg5gajMBWXEZU91d6Wne5OO/aU8Vju4XIBNWthRiU4vbtlwxm3dMAAnkl3DoFScjEGPNyHKu/hZDys7VwIIK1YNrRGqLgxwZdIr07C6aoEFN8xvQf30UUnOLe86GPBZe3Aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ba17d5-eed7-49be-435e-08dc44ab0fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 04:47:47.3160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgt8TYHdQOCMd1uJoVDupIFcyO8KrfymDxF6qrmf0c7+GsGAoR8EIwE7eO1TzrdSFC1zuym5bzdRLIpCKDYVc/etzOYC2MFUr80s7VLvw2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150036
X-Proofpoint-GUID: KmG06dv9NU6wEqjDGcff_pERBbBubc0b
X-Proofpoint-ORIG-GUID: KmG06dv9NU6wEqjDGcff_pERBbBubc0b

DQo+IE9uIE1hciAxNCwgMjAyNCwgYXQgMTE6MzDigK9BTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzLzE0LzI0IDExOjE0LCBBcnVuYSBSYW1h
a3Jpc2huYSB3cm90ZToNCj4+IEkgdGhvdWdodCB0aGUgUEtSVSB2YWx1ZSBiZWluZyByZXNldCBp
biB0aGUgc2lnbmFsIGhhbmRsZXIgd2FzIHN1cHBvc2VkIA0KPj4gdG8gYmUgdGhlIGRlZmF1bHQg
YmVoYXZpb3IuIEluIHdoaWNoIGNhc2UsIHRoaXMgaXMgYSBidWcuDQo+PiANCj4+ICJTaWduYWwg
SGFuZGxlciBCZWhhdmlvcg0KPj4gRWFjaCB0aW1lIGEgc2lnbmFsIGhhbmRsZXIgaXMgaW52b2tl
ZCAoaW5jbHVkaW5nIG5lc3RlZCBzaWduYWxzKSwNCj4+IHRoZSB0aHJlYWQgaXMgdGVtcG9yYXJp
bHkgZ2l2ZW4gYSBuZXcsIGRlZmF1bHQgc2V0IG9mIHByb3RlY3Rpb24NCj4+IGtleSByaWdodHMg
dGhhdCBvdmVycmlkZSB0aGUgcmlnaHRzIGZyb20gdGhlIGludGVycnVwdGVkIGNvbnRleHQu4oCd
DQo+PiANCj4+IChSZWY6IGh0dHBzOi8vbWFuNy5vcmcvbGludXgvbWFuLXBhZ2VzL21hbjcvcGtl
eXMuNy5odG1sKQ0KPiANCj4gQXMgdGhlIHBlcnNvbiB3aG8gd3JvdGUgdGhvc2Ugd29yZHMsIEkg
Y2FuIGhvbmVzdGx5IHNheSB0aGF0IHRoZXJlIHdlcmUNCj4gKlpFUk8qIGNvbnNpZGVyYXRpb25z
IGZvciB3aGF0IHRoZSBrZXJuZWwncyBwZXJtaXNzaW9ucyB3ZXJlIHdoaWxlDQo+IHNldHRpbmcg
dXAgdGhlIGZyYW1lLiAgSSB3YXMgYXNzdW1pbmcgdGhlbiBhbmQgYXNzdW1lIHRvIHRoaXMgZGF5
IHRoYXQNCj4gaXQncyBwcmFjdGljYWxseSBpbXBvc3NpYmxlIHRvIHR1cm4gb2ZmIHBrZXktMCB3
cml0ZXMgYW5kIGdldCBzYW5lIGJlaGF2aW9yLg0KPiANCj4gSWYgd2Ugd2FudCB0byBsYXd5ZXIt
d29yZCB0aGUgbWFucGFnZSwgSSdsbCBqdXN0IGFyZ3VlIHRoYXQgIkVhY2ggdGltZSBhDQo+IHNp
Z25hbCBoYW5kbGVyIGlzIGludm9rZWQiIGxpdGVyYWxseSBkb2Vzbid0IGFwcGx5IHVudGlsIHRo
ZSBtb21lbnQgdGhhdA0KPiBSSVAgaXMgcG9pbnRpbmcgYmFjayB0byB1c2Vyc3BhY2UuIDopDQo+
IA0KPiBJZiB0aGlzIGlzIHRydWx5IGFib3V0IHRoZSBtYW5wYWdlLCB0aGVuIEknbGwgaGFwcGls
eSBhbWVuZCB0aGUgbWFucGFnZQ0KPiB0byBzYXksICJkb24ndCB0dXJuIG9mZiBwa2V5IDAgYWNj
ZXNzIG9yIGVsc2UiLiAgSSdkICpNVUNIKiByYXRoZXIgZG8NCj4gdGhhdCB0aGFuIGFkZCBtb3Jl
IHBrZXkgbXVuZ2luZyB0byB0aGUga2VybmVsLg0KPiANCg0KSXTigJlzIG5vdCBhYm91dCB0aGUg
bWFuIHBhZ2UgLSBpdCdzIGp1c3QgdGhhdCwgbXkgdW5kZXJzdGFuZGluZyBvZiB0aGlzIGZsb3cg
YW5kIHRoaXMgdXNlIGNhc2Ugc3RlbXMgZnJvbSB0aGVyZS4gSSB0aGluayB3ZSBhc3N1bWVkIHRo
YXQgd2UgY2FuIHR1cm4gb2ZmIHBrZXkgMCBhbmQgc3RpbGwgYmUgYWJsZSB0byBzZXQgdXAgdGhl
IGFsdCBzaWcgc3RhY2sgKGFuZCBoYXZlIHRoZSBrZXJuZWwgcmVzZXQgaXQgdG8gaW5pdF9wa3J1
IGFueXdheSkgLSBhbmQgd2hlbiB0aGF0IGRpZG7igJl0IHdvcmssIGl0IHNlZW1lZCBsaWtlIGEg
YnVnLiA6KSANCg0KPiBJbiBvdGhlciB3b3JkcywgeW91J3JlIG5vdCBnb2luZyB0byBzcHVyIG1l
IGludG8gYWN0aW9uIG15IHRod2FwcGluZyBtZQ0KPiB3aXRoIHRoZSBtYW5wYWdlIHRoYXQgSSB3
cm90ZS4gIFlvdSd2ZSBnb3QgdG8gY29udmluY2UgbWUgdGhhdCB5b3VyIG5ldw0KPiB1c2UgY2Fz
ZSBpcyB2YWxpZCwgdGhpcyBpcyB0aGUgYmVzdCB3YXkgdG8gc3VwcG9ydCB5b3VyIG5ldyB1c2Ug
Y2FzZSwNCj4gYW5kIHRoYXQgeW91ciBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgbmV3IGZlYXR1cmUg
aXMgc2FuZS4NCj4gDQo+IA0KDQpNYXR0aGlhcy9FcmljLA0KQ2FuIHlvdSBwbGVhc2UgdGFsayBh
Ym91dCB0aGUgdXNlIGNhc2UgaW4gZ3JlYXRlciBkZXRhaWw/DQoNClRoYW5rcywNCkFydW5hDQoN
Cg==

