Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50075EACF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXF2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:28:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D3E0;
        Sun, 23 Jul 2023 22:28:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NNKU27011026;
        Mon, 24 Jul 2023 05:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gRGIihPb+jcMLR96NuByficCt4X6Id1mpKBF6Z9b2Z4=;
 b=VROclBC3XP0pioMXX34BeP9WlmLECOdzOPdBl/BWoizab87zBsL6HL7arhUfpt9nrqHl
 lpQ2XMCUNc/fAqkWAj9ebEe0oSRnZEsw5m8ETSTb9ufgbDxHCR3xZD+3VTg1a72YVLG3
 UimcGeNzDvJDSifWmZ+qvo34onlPgt1kTY5A9CrkNGbNywgaiQ2KWdSWSTGli2naaa3H
 3e6rGAIVzMl1Q1StUMkiWocd4YBffaw1iYZRTHvsZsnHnL2HP4nQ1lbUI6Cd7OS1uhF5
 jyocMoiKNLl7tVvMs4LpHp+CSOXKRoTUt1oJWDgvVFEuSW6FwRnkknTjt9Fp2F5bG39P ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtsvdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 05:28:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36O4Pl2H040850;
        Mon, 24 Jul 2023 05:28:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3fk1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 05:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC2H/yxT5u6kRMQWFj1/GiTZft8ZnhuTn2BkUi+gDnFdmgKTc2+MfAyVTFUfag3YMEUhk4eFWQnsI3hn94/8vEm9BG4jJSUk6fiz8Wr2h++3pRo4iOkw0kPlJCJzjaeeYx1nm7CHpK2V/O0aKJgAGyoYrVJxGNHnpm9JmAPeuDAGXvg2uS7rvUsBVedCbRkg/YSKI1uuRwszDqVWzJ26zlfojUb/Bb1OTEbM5qM+1NfVUCHjevNMw70H1NikTlYA3RHR/Z3qco0BsV0nhPCQ6pEsps/yk2qiqcygG2iH8Bq0OGJRejTQB3PIHb2zOOpcJhNUBq8vWsPIyPmul0Kl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRGIihPb+jcMLR96NuByficCt4X6Id1mpKBF6Z9b2Z4=;
 b=VEaYgIxpxiwxmWycOBgMlXuVRYRRmA2vHjy5f/TSZNtTdKVV+AIKWjeLrSadwf8g4Df3eqGxE2h3iDLRE+0Z2iH1BTsJbQeVM/OOTvqJWKUYFHf03Wslw7GQd+elPB3X6S9W3tbyQ2pxP3qhzjr9I2rzDVUSmuls7Mo4EhDQgnWffEQwX0mDSxKnVEKzWF+BRXMcmE6HSaifFDTa+BdCVloziGqK9Eie2O8e57YHbwCbhY7mCPdZK6L4ScrgQRciRJhdTTzPok/N/nfnXP/XY7VNHO8Sz/+d8A2LU241ZfFUKu9Du6xFGb8pFrAFHAszDrtFrf/0ff8oYl0RKjEJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRGIihPb+jcMLR96NuByficCt4X6Id1mpKBF6Z9b2Z4=;
 b=zTmUNy/WAtpczPY9472pXbWPn1OIUMbyAerLsiMJkFEDEsFRR5aw5/8k3Nkgy9tfV0NfeLA+3h63J/ISBRN9/WET+LE9ZTn01DXNMTT/19PfrOPcf8VLpJoDxUOHwZwhCD41VyJrKGDOcclOp1t73+5GVXKF/zC8N8eG/Q6Rx3Y=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by DM4PR10MB6885.namprd10.prod.outlook.com (2603:10b6:8:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 05:27:48 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::cb07:180e:e081:39eb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::cb07:180e:e081:39eb%7]) with mapi id 15.20.6609.022; Mon, 24 Jul 2023
 05:27:47 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     "dianders@chromium.org" <dianders@chromium.org>
CC:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: VM Boot Hangs with Commit "Revert "scsi: core: run queue if SCSI
 device queue isn't ready and queue is idle"" on linux-5.4.y
Thread-Topic: VM Boot Hangs with Commit "Revert "scsi: core: run queue if SCSI
 device queue isn't ready and queue is idle"" on linux-5.4.y
Thread-Index: Adm975R3wcEYFNNIfUub2EUAbYr3tw==
Date:   Mon, 24 Jul 2023 05:27:46 +0000
Message-ID: <D98ED975-F617-4885-8D3F-DCFDC524E933@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|DM4PR10MB6885:EE_
x-ms-office365-filtering-correlation-id: 22054b2e-a591-44a5-6bd5-08db8c06b6f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8VrJPYp51xcAVgvtrvz3U2g+LMQyqajxdCvE/fppUQx/ft425xfC/1HV8YOzEdiwqL8XohvXzb0N3eqekAL7W25JT3fKYuwkVnwX53aLAkTVqRp2FmnjljF401sTsdge2glqi+Z8gldqaspxG6zRE4ghDTKybIkYTMgUNlonAnJj017/FHcLOc1K+NMQD4XuGeZM4CyDqQaBWZUgF13qrrUNM9RhdjY0x12+Cy/EISU3LM0qE/bFRJN+JtKW4/LaY9SB9U5ijjnSgExldOfdyDyzLSNXkEiurfG8A4Eq/k/nEstdOZN6HhnjGneCNgnQRf0t0eL9dnjE4iQWLWr5TAhc6CC4mwCVvqq8fDp8NL07xGe5ncNPBYnyGbFFhIMWdGOZkZhvN3p0l2yFonRrRMEzqcJ69zzHQejEtaBNHdGiY3TPCUQ76JCDiig+uhhz2offEP2JhwJf7NHjWx0HGvQKt2nY0Swp7b4Nzcmw2oRn1J81f1Lwlv2HUqqyzwlgp6WDWDLVfNyOu5fH2vowSC6b2T1a8Ebo+4gPne1FV23+V9l+YAvjsHQZkNk7EakxwBAGCWexZUjVU+21xP4soFgwClUUXJPzj3rh0ZZKiDWA7MggzDXh+XTqVd9moSWsSx4SelZGPIWyaTyfzpTQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(6512007)(71200400001)(38070700005)(4326008)(66446008)(66476007)(64756008)(66556008)(6916009)(76116006)(6486002)(36756003)(478600001)(54906003)(316002)(86362001)(66946007)(6506007)(2616005)(186003)(122000001)(38100700002)(83380400001)(33656002)(5660300002)(8676002)(2906002)(41300700001)(8936002)(26005)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21aWXkrdmtTOC9WMXdLSjdqSG1SN1MxbWpGaE5DWklkeTZzQmpSM2VsZk05?=
 =?utf-8?B?ZDdmRitOSE5waGdVb0pYSTVJMW90T2VUWXExTllaZTMrTUlnMnloM2hzL2hS?=
 =?utf-8?B?Y0FHa29OWkpXNEYrR3E1QUhyeXJUYzJzd21nWWtCbzd2QlRmcnoyWU5CVVJ6?=
 =?utf-8?B?dkVteC84bk5ZcFlqd0tvZDd5MWNPWmwzenRYVlpCbG5mS3JiR1dQL0xMeW90?=
 =?utf-8?B?RDlsTFplM0hFazFReEVFeGVRQVEweUZqZHBBTnIxMXpycXNnaU1zakYwZytu?=
 =?utf-8?B?RlJiWjhSVTFyK3pVR0VhMUxEYndOMXl3cnRSSlVOY3N5TzZIOVhVNytPbjdq?=
 =?utf-8?B?alFPdmZ3N245QWtLQTZ1WEViQzA4NUxzK2pHNzh1T3gxSVdHQU9uaWhhZTBJ?=
 =?utf-8?B?YWk2RmlJZXpGRVA2V1lhemRjckc2N3VtdUwvK01HRnp1c1RZRDQybVp4T1d3?=
 =?utf-8?B?YXMveis4ZW0wZVp0aUV5b3pETVVmcDlkRUZCRUJ1TzU3R1Q3WTJyemE2emhB?=
 =?utf-8?B?NGVyNCtVMldEbCt3dWM3STVERG4xVXhya0dKaFB2UXZRaU9UV21rczVRTHBD?=
 =?utf-8?B?ci9BWWFkdlZiU2FkeXBlb3MxaDJlbXpDTldxVU0rOVdLeWcvOG9ibWd6c0tH?=
 =?utf-8?B?emxnTHFJN2I4Ym9rYnFRNXkzSkM1L1FTMVdHaDdFVEVmWjB6Qk5BNnZ6OTBL?=
 =?utf-8?B?ODRhUS9UTnY1QXg3TVNyRDk4WDlPNUNyVUlRNEU0TjRSU0UvSDh2Y0ovVVBN?=
 =?utf-8?B?bHFrS2JkV2Rqb1MzUnRSMFZRMHYvWDBkaFpCREdMajBYUThrMTlSTFI5NzVl?=
 =?utf-8?B?bm5SRkpLVnJ1R3Mza0hmWWY4UUJSQ2w4SEF4ait4U3Y3dklKaTBPR0RtRWJW?=
 =?utf-8?B?Q3dScHFvY2RvaThZSDZsQ1ZLblZTTTBPL3RwcGpaZlhRaFpuaUI1TXVHK25D?=
 =?utf-8?B?RWplY2dZdjNNMTBXcW01YTNWdTlDTitNR3UrUWNaU0VWUHp2WUovZVVKNWZa?=
 =?utf-8?B?djVaTWgxOHE4M2pZM0hFbW5LMFVNVGpFcFlqbHl3V0JHVWwrVTBHWFhPL2Rp?=
 =?utf-8?B?bDl1b3lCTXRBcEZBU1VZOHJDOVUxalZ2d3gyRlZISkttYUgxSXlxcU1Wbkhl?=
 =?utf-8?B?T01HalNOWUF0UTl5KzdiYU94N05sUGhiUDNoNG04Z3Y2L2Y2WHdDMkJyd0w4?=
 =?utf-8?B?ck9PVWhGMlNNVWlzSDRGNlAvZWhLWTg2eUtJTFlCRVpaQStjUzM3MVBzTytZ?=
 =?utf-8?B?bXZTdVc0UWwyQkxzTk1INXZGUTVjdmVjMXN2NDBHdEhCNC9yZjhaKzVNR2Nr?=
 =?utf-8?B?SHVJbFJGZWdpeVZaODQxcVhaV1kxVHFSSEdoRHFTM2lOWERlYWVYRENVMUYz?=
 =?utf-8?B?RG9WVWJiS05lVzN3cjZ0RzdUTUgyYkt0cFRYekxyV3RPWExxSy9UeDVFY1pF?=
 =?utf-8?B?SHl1cEtHMmNjbWNMSkxLUlNQbWhGSi9tei95aEExYnFOenljSE9xZ0RRZC9E?=
 =?utf-8?B?SkFjRVJBMDYvOVEwR2o3c2tQb2VFQ3JEK3FNNG5nWnhHYTh6ZTNWeTg0WUtH?=
 =?utf-8?B?UjVmYi9TOUpZbHFqMmk0eGp4ckRjSCtTQ210dGlQazlZbDFaN1BXeHVldjRI?=
 =?utf-8?B?dmhqcC9ubkt1T2xVNUlrRFVqTC9VaGg0eEFYSkNKSFIzTHAvZlo5ckVwV2hC?=
 =?utf-8?B?UXhtVE9Hamd4NHZKRTdrdXlRdithNFJrVzJpbUQ3RkNCSlNYMUV1QktTT1Qr?=
 =?utf-8?B?bnNqMTFkNDVNRDkvWVlxUGYyZ05rd0FvUjErdS9NbmtTVDljWWl0Nll1eE1j?=
 =?utf-8?B?ODdRZmVWazI3aU5PZjBCaEExLzhFUGpJY09XWmZORDl3MThBMm9qTHB2OXll?=
 =?utf-8?B?anBmWlVqcHN4TWZFVWJhMDhoMEZ1WVhyeTVwZS9pbVJyY2szcXdoZUpMa2NU?=
 =?utf-8?B?bXpQUmIwVWpxNUR2aDQzQm5Bb29qT2lGUTU2dEVUblg1UlZheTV2d2hHS3Rz?=
 =?utf-8?B?ZnRxREc0amJsRW9idTFYZ251Z1BPMUNLR014TFloVzg1Z1lEdHF4RmVWSlAv?=
 =?utf-8?B?eFFNQmFMSmZzYmdlaTBKWXlmOEpwdFcwRndZS1VkKzRFbWo4MVNsdTJsMXRi?=
 =?utf-8?B?dTBMY3NRWmZmREhNTkc3a0NJMkwrRitsQVdEd2psak9uSnBhSWx0bmUrMkhs?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7856436EE434654E8D8E98EF7856E8F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1HE3eix+oUr2OlORGetLvYfT0Qfc9b/UmfIYOpaT6pF8tOnErlSypk7hZA2rc6IaXDU0KJY1jzaRw9PKZX446OctLAZLVenusM3Gqv12nXuEnbncnnu0TS//9Am9aTfKRner4yau/Tx9uXnxDeylhXDsR3xoDQc4p/WlCza+OrVBrs2yvfTXwrmgmzySDKR/EpAh10VG4KW2clBxzC+C7qyFP+YxUI4cVM12fWqEjZt952qzNuo5BQTUXwYklrrR8tb7WARLh7tQqOskluqD3DDHV0mrVjhOdBIBLK89t6sX7GaiirY5eSgnxihCsZ0X6FGOYOInO4WQX1/jX8Bgni70KAAkQ414S/t6FC464Wtgk2xeoJO6j3phJPBAkaXRe5rTVMHi4zOJWonC5vYj8PbDzcXEF8APBJfjv/9VcYnBvlUav4wxQWEJEPTk0Zmk3jgk+ytB3LT7HisZTu/B4e7nUVQ0b6MgZUjU7lJ9xltj3TD9hbj349CCTf5PCDqn0PDuFoAOc7UA9mvge/HSQ2GP2aZnbdmjTR3JTNOq0vpFfEHGjwkWsOs5XO9GUQSncVpPvtdH78nAFvxDpSBIpzYoxgLySG3nnp37XniqJF0FhfzPjng3224Tin5FIV6J9Z/LIPgq5AHCsbyYUTnavaydXQrCL8faHiCv6wGdUHwoMhOyVikJkVGwMcI4lopI9R3dKJNDOc04uomo8i4ysoLugYjD4asWkjwmITwgpzGI4SvyQVQkFN5+K5c8Qtf6VcrnNxrWwzdZKxYNelas916GUL/5exBNZU8bUi9E2xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22054b2e-a591-44a5-6bd5-08db8c06b6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 05:27:47.0002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uerxHHKNObEhkdjBTOqk1IE6O29SQuXrPpxAp+LfKVVe/dmn/Yup91zSnxpb5a36n0j+//66M1DPuoY79OSE4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240049
X-Proofpoint-ORIG-GUID: Fg30MAIQVEobJHaHV2B4zaoZMJFOUnnA
X-Proofpoint-GUID: Fg30MAIQVEobJHaHV2B4zaoZMJFOUnnA
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG91Z2xhcywNCg0KV2Ugb2JzZXJ2ZWQgbGludXgtc3RhYmxlIHY1LjQgVk0gYm9vdCBoYW5n
cywgYnV0IHByb2JhYmx5IG9ubHkgMSBpbiB0aG91c2FuZHMgb2YgYm9vdHMgKGxlc3MgdGhhbiAx
MCwwMDAgYm9vdHMpLiAgV2Ugc3RhcnRlZCAxNiBWTXMgb24gYSBCYXJlIE1ldGFsIHdpdGggbG9v
cCByZWJvb3RzLCBJIGNob3NlIDEwLDAwMCBib290cyBhcyBhIHRocmVzaG9sZCwgYW5kIGJpc2Vj
dGVkIGl0LiBBZnRlciBhIHBhaW5mdWwgYmlzZWN0aW9uLCBJIGZvdW5kIHRoZSBjdWxwcml0IGNv
bW1pdCA1NzhjOGYwOWMwNGIgKOKAnFJldmVydCBzY3NpOiBjb3JlOiBydW4gcXVldWUgaWYgU0NT
SSBkZXZpY2UgcXVldWUgaXNudCByZWFkeSBhbmQgcXVldWUgaXMgaWRsZeKAnSkuIFRoaXMgY29t
bWl0IGFjdHVhbGx5IHdhcyBtZXJnZWQgdG8gdjUuOCB0aGUgMXN0IHRpbWUuIEl0J3MgYSBzZXJp
ZXMgb2YgcGF0Y2ggc2V0IChodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1ibG9j
ay9tc2c1MTg2Ni5odG1sKS4gQWN0dWFsbHksIGluIHRoZSA0LXBhdGNoIHNlcmllcywgMiBvZiB0
aGVtIGhhdmUgYWxyZWFkeSBiZWVuIGJhY2twb3J0ZWQgdG8gbGludXgtc3RhYmxlIHY1LjQsIGJ1
dCBub3QgYXQgdGhlIHNhbWUgdGltZToNCg0KMSkgYWIzY2VlMzc2MmU1ICjigJxibGstbXE6IElu
IGJsa19tcV9kaXNwYXRjaF9ycV9saXN0KCkgbm8gYnVkZ2V0IGlzIGEgcmVhc29uIHRvIGtpY2vi
gJ0pIGluIHRhZyB2NS40Ljg2DQoyKSA1NzhjOGYwOWMwNGIgKOKAnFJldmVydCBzY3NpOiBjb3Jl
OiBydW4gcXVldWUgaWYgU0NTSSBkZXZpY2UgcXVldWUgaXNudCByZWFkeSBhbmQgcXVldWUgaXMg
aWRsZeKAnSkgaW4gdGFnIHY1LjQuMjM1LCBpdOKAmXMgYmFja3BvcnRlZCBhcyBzdGFibGUgZGVw
ZW5kZW5jeSBmb3IgYW5vdGhlciBjb21taXQgDQoNCglTaWduZWQtb2ZmLWJ5OiBEb3VnbGFzIEFu
ZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQoJUmV2aWV3ZWQtYnk6IE1pbmcgTGVpIDxt
aW5nLmxlaUByZWRoYXQuY29tPg0KCUFja2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KCVNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9l
QGtlcm5lbC5kaz4NCglTdGFibGUtZGVwLW9mOiBjMzFlNzZiY2MzNzkgKCJibGstbXE6IHJlbW92
ZSBzdGFsZSBjb21tZW50IGZvciBibGtfbXFfc2NoZWRfbWFya19yZXN0YXJ0X2hjdHjigJ0pDQoJ
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPg0KDQpBbmQgSSB0
cmllZCBiYWNrcG9ydGluZyB0aGUgb3RoZXIgMiBwYXRjaGVzIHRvIHY1LjQsIHRoZSBpc3N1ZSBp
cyBzdGlsbCByZXByb2R1Y2libGUuDQoNCkkgdGVzdGVkIG11bHRpcGxlIGtlcm5lbHMsIHRoZSBp
c3N1ZSBpcyBub3QgcmVwcm9kdWNpYmxlIHdpdGhpbiAxMCwwMDAgYm9vdHMgaW4gdGhlIGZvbGxv
d2luZyBrZXJuZWxzOg0KMSkgTGludXggdjUuOQ0KMikgTGludXggdjUuNC4yNDkgKyByZXZlcnQg
b2YgNTc4YzhmMDljMDRiICjigJxSZXZlcnQgc2NzaTogY29yZTogcnVuIHF1ZXVlIGlmIFNDU0kg
ZGV2aWNlIHF1ZXVlIGlzbnQgcmVhZHkgYW5kIHF1ZXVlIGlzIGlkbGXigJ0pDQoNCk5vdCBleGFj
dGx5IHN1cmUgaG93IHRoaXMgY29tbWl0IGlzIGFmZmVjdGluZyBsaW51eC1zdGFibGUgdjUuNCwg
YnV0IEkgc3VzcGVjdCBzb21lIHByZXJlcXVpc2l0ZSBjb21taXRzIGFyZSBtaXNzaW5nIHdoaWNo
IGxlYWQgdG8gYm9vdCBoYW5ncyBvbiBsaW51eC1zdGFibGUgdjUuNCBidXQgbm90IG9uIGhpZ2hl
ciByZWxlYXNlcy4gQ291bGQgeW91IHRha2UgYSBsb29rIGF0IHRoaXMgaXNzdWUgYW5kIHNoYXJl
IHlvdXIgaW5zaWdodD8gDQoNCkhlcmUgaXMgdGhlIGNhbGwgdHJhY2U6DQpbICAzNjkuODUwNjgx
XSBJTkZPOiB0YXNrIHN5c3RlbWQtdWRldmQ6MzEzIGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjIg
c2Vjb25kcy4NClsgIDM2OS44NTIxODBdICAgICAgIE5vdCB0YWludGVkIDUuNC4yNDgtbWFzdGVy
LjIwMjMwNjA4LmVsOC5kZXYueDg2XzY0ICMxDQpbICAzNjkuODUzNjMxXSAiZWNobyAwID4gL3By
b2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tfdGltZW91dF9zZWNzIiBkaXNhYmxlcyB0aGlzIG1lc3Nh
Z2UuDQpbICAzNjkuODU1NDA2XSBzeXN0ZW1kLXVkZXZkICAgRCAgICAwICAgMzEzICAgIDI4MiAw
eDgwMDA0MTA2DQpbICAzNjkuODU2NjYyXSBDYWxsIFRyYWNlOg0KWyAgMzY5Ljg1NzI3Nl0gIF9f
c2NoZWR1bGUrMHgyMTMvMHg1NzANClsgIDM2OS44NTgwMTddICBzY2hlZHVsZSsweDQyLzB4YjAN
ClsgIDM2OS44NTg2OTldICBpb19zY2hlZHVsZSsweDQ1LzB4NzANClsgIDM2OS44NTk2NzFdICB3
YWl0X29uX3BhZ2VfYml0X2NvbW1vbisweDEzMS8weDM4MA0KWyAgMzY5Ljg2MDg4NF0gID8gZmlu
ZF9nZXRfZW50cmllcysweDFhOS8weDI2MA0KWyAgMzY5Ljg2MjAxMV0gID8gX19maWxlbWFwX3Nl
dF93Yl9lcnIrMHg3MC8weDcwDQpbICAzNjkuODYzMjM5XSAgX19sb2NrX3BhZ2UrMHg0NC8weDUw
DQpbICAzNjkuODY0MTIyXSAgdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFuZ2UrMHg0NjMvMHg4YTAN
ClsgIDM2OS44NjU1MTZdICA/IHBhZ2V2ZWNfbG9va3VwX3JhbmdlX3RhZysweDI4LzB4NDANClsg
IDM2OS44NjY4OTFdICA/IGZyZWVfY3B1bWFza192YXIrMHg5LzB4MTANClsgIDM2OS44Njc5MDld
ICA/IG1hcmtfYnVmZmVyX2FzeW5jX3dyaXRlKzB4MzAvMHgzMA0KWyAgMzY5Ljg2OTAxOV0gID8g
Z2V0X2tzbV9wYWdlKzB4ZjYvMHgyMTANClsgIDM2OS44Njk5MzZdICA/IGZyZWVfY3B1bWFza192
YXIrMHg5LzB4MTANClsgIDM2OS44NzEwMjBdICA/IG9uX2VhY2hfY3B1X2NvbmRfbWFzaysweGIx
LzB4MTMwDQpbICAzNjkuODcyMDYyXSAgdHJ1bmNhdGVfaW5vZGVfcGFnZXMrMHgxNS8weDIwDQpb
ICAzNjkuODcyNzM5XSAgX19ibGtkZXZfcHV0KzB4YTcvMHgyMjANClsgIDM2OS44NzM0MDhdICA/
IGV4aXRfbW1hcCsweDEyMS8weDFiMA0KWyAgMzY5Ljg3NDA5Ml0gIGJsa2Rldl9wdXQrMHg0ZS8w
eGUwDQpbICAzNjkuODc0Njc0XSAgYmxrZGV2X2Nsb3NlKzB4MjYvMHgzMA0KWyAgMzY5Ljg3NTI4
MV0gIF9fZnB1dCsweGNjLzB4MjYwDQpbICAzNjkuODc1Nzg3XSAgX19fX2ZwdXQrMHhlLzB4MTAN
ClsgIDM2OS44NzYyOThdICB0YXNrX3dvcmtfcnVuKzB4OGIvMHhiMA0KWyAgMzY5Ljg3Njg5Ml0g
IGRvX2V4aXQrMHgxZmYvMHg0MjANClsgIDM2OS44Nzc0MTRdICBkb19ncm91cF9leGl0KzB4M2Iv
MHhiMA0KWyAgMzY5Ljg3Nzk4OV0gIGdldF9zaWduYWwrMHgxNjkvMHg4YjANClsgIDM2OS44Nzg1
NDldICBkb19zaWduYWwrMHgyYS8weDEwMA0KWyAgMzY5Ljg3OTEzMF0gID8gX192ZnNfcmVhZCsw
eDI5LzB4NDANClsgIDM2OS44Nzk3MTNdICA/IHZmc19yZWFkKzB4YWEvMHgxNjANClsgIDM2OS44
ODAyODFdICA/IGtzeXNfcmVhZCsweDY3LzB4ZTANClsgIDM2OS44ODA4NThdICBwcmVwYXJlX2V4
aXRfdG9fdXNlcm1vZGUrMHgxMmIvMHgxYTANClsgIDM2OS44ODE2MTRdICBkb19zeXNjYWxsXzY0
KzB4OGUvMHgxMDANClsgIDM2OS44ODIxOTldICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg1Yy8weGMxDQpbICAzNjkuODgzMDU2XSBSSVA6IDAwMzM6MHg3ZjZkNDY2ZGU4YzINClsg
IDM2OS44ODM2NjRdIENvZGU6IEJhZCBSSVAgdmFsdWUuDQpbICAzNjkuODg0MjE3XSBSU1A6IDAw
MmI6MDAwMDdmZmZmZmFkYjU1OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAw
MDAwMDAwDQpbICAzNjkuODg1NDMzXSBSQVg6IGZmZmZmZmZmZmZmZmZmZmMgUkJYOiAwMDAwNTVi
MGIzYzQwYWIwIFJDWDogMDAwMDdmNmQ0NjZkZThjMg0KWyAgMzY5Ljg4NjU1Ml0gUkRYOiAwMDAw
MDAwMDAwMDAwMjAwIFJTSTogMDAwMDU1YjBiM2M0MGFkOCBSREk6IDAwMDAwMDAwMDAwMDAwMGYN
ClsgIDM2OS44ODc2OTJdIFJCUDogMDAwMDU1YjBiM2MzZGQyMCBSMDg6IDAwMDA1NWIwYjNjNDBh
YjAgUjA5OiAwMDAwMDAwMDAwMDAwMDAxDQpbICAzNjkuODg4ODQyXSBSMTA6IDAwMDAwMDAwMDAw
MDAwMDEgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwNDAwMA0KWyAgMzY5
Ljg4OTk2M10gUjEzOiAwMDAwMDAwMDAwMDAwMjAwIFIxNDogMDAwMDU1YjBiM2MzZGQ3MCBSMTU6
IDAwMDA1NWIwYjNjNDBhYzgNClsgIDM2OS44OTE1MjldIElORk86IHRhc2sgc3lzdGVtZC11ZGV2
ZDozMTUgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMiBzZWNvbmRzLg0KWyAgMzY5Ljg5MzE4Ml0g
ICAgICAgTm90IHRhaW50ZWQgNS40LjI0OC1tYXN0ZXIuMjAyMzA2MDguZWw4LmRldi54ODZfNjQg
IzENClsgIDM2OS44OTQ1NTddICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190
aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4NClsgIDM2OS44OTYzMThdIHN5c3Rl
bWQtdWRldmQgICBEICAgIDAgICAzMTUgICAgMjgyIDB4ODAwMDQxMDYNClsgIDM2OS44OTc1OTZd
IENhbGwgVHJhY2U6DQpbICAzNjkuODk4MTk3XSAgX19zY2hlZHVsZSsweDIxMy8weDU3MA0KWyAg
MzY5Ljg5OTA2OF0gIHNjaGVkdWxlKzB4NDIvMHhiMA0KWyAgMzY5Ljg5OTgxM10gIGlvX3NjaGVk
dWxlKzB4NDUvMHg3MA0KWyAgMzY5LjkwMDY0MF0gIHdhaXRfb25fcGFnZV9iaXRfY29tbW9uKzB4
MTMxLzB4MzgwDQpbICAzNjkuOTAxNzExXSAgPyBmaW5kX2dldF9lbnRyaWVzKzB4MWE5LzB4MjYw
DQpbICAzNjkuOTAyNjg4XSAgPyBfX2ZpbGVtYXBfc2V0X3diX2VycisweDcwLzB4NzANClsgIDM2
OS45MDM3MTBdICBfX2xvY2tfcGFnZSsweDQ0LzB4NTANClsgIDM2OS45MDQ1MDRdICB0cnVuY2F0
ZV9pbm9kZV9wYWdlc19yYW5nZSsweDQ2My8weDhhMA0KWyAgMzY5LjkwNTY0OF0gID8gZmluZF9n
ZXRfcGFnZXNfcmFuZ2VfdGFnKzB4N2UvMHgyZDANClsgIDM2OS45MDY3NzddICA/IHBhZ2V2ZWNf
bG9va3VwX3JhbmdlX3RhZysweDI4LzB4NDANClsgIDM2OS45MDc4ODFdICA/IGZyZWVfY3B1bWFz
a192YXIrMHg5LzB4MTANClsgIDM2OS45MDg4MTZdICA/IG1hcmtfYnVmZmVyX2FzeW5jX3dyaXRl
KzB4MzAvMHgzMA0KWyAgMzY5LjkwOTgzNl0gID8gZ2V0X2tzbV9wYWdlKzB4ZjAvMHgyMTANClsg
IDM2OS45MTA3MzhdICA/IF9feDY0X3N5c19mc29wZW4rMHgxNjAvMHgxNjANClsgIDM2OS45MTE3
NDNdICA/IGZyZWVfY3B1bWFza192YXIrMHg5LzB4MTANClsgIDM2OS45MTI2OTRdICA/IG9uX2Vh
Y2hfY3B1X2NvbmRfbWFzaysweGIxLzB4MTMwDQpbICAzNjkuOTEzNzYzXSAgdHJ1bmNhdGVfaW5v
ZGVfcGFnZXMrMHgxNS8weDIwDQpbICAzNjkuOTE0NzQ3XSAgX19ibGtkZXZfcHV0KzB4YTcvMHgy
MjANClsgIDM2OS45MTU1NjVdICA/IGV4aXRfbW1hcCsweDEyMS8weDFiMA0KWyAgMzY5LjkxNjQw
N10gIGJsa2Rldl9wdXQrMHg0ZS8weGUwDQpbICAzNjkuOTE3MTYzXSAgYmxrZGV2X2Nsb3NlKzB4
MjYvMHgzMA0KWyAgMzY5LjkxNzk2MF0gIF9fZnB1dCsweGNjLzB4MjYwDQpbICAzNjkuOTE4NjY5
XSAgX19fX2ZwdXQrMHhlLzB4MTANClsgIDM2OS45MTkzNjJdICB0YXNrX3dvcmtfcnVuKzB4OGIv
MHhiMA0KWyAgMzY5LjkyMDE4NV0gIGRvX2V4aXQrMHgxZmYvMHg0MjANClsgIDM2OS45MjA5NTNd
ICBkb19ncm91cF9leGl0KzB4M2IvMHhiMA0KWyAgMzY5LjkyMTc3Nl0gIGdldF9zaWduYWwrMHgx
NjkvMHg4YjANClsgIDM2OS45MjI1OTddICBkb19zaWduYWwrMHgyYS8weDEwMA0KWyAgMzY5Ljky
MzQ2Nl0gID8gX192ZnNfcmVhZCsweDI5LzB4NDANClsgIDM2OS45MjQ0MjRdICA/IHZmc19yZWFk
KzB4YWEvMHgxNjANClsgIDM2OS45MjUyNTZdICA/IGtzeXNfcmVhZCsweDY3LzB4ZTANClsgIDM2
OS45MjYwODVdICBwcmVwYXJlX2V4aXRfdG9fdXNlcm1vZGUrMHgxMmIvMHgxYTANClsgIDM2OS45
MjcyMDRdICBkb19zeXNjYWxsXzY0KzB4OGUvMHgxMDANClsgIDM2OS45MjgwNjNdICBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg1Yy8weGMxDQpbICAzNjkuOTI5MjM4XSBSSVA6IDAw
MzM6MHg3ZjZkNDY2ZGU4YzINClsgIDM2OS45MzAwNTZdIENvZGU6IEJhZCBSSVAgdmFsdWUuDQpb
ICAzNjkuOTMwNzk5XSBSU1A6IDAwMmI6MDAwMDdmZmZmZmFkYjUxOCBFRkxBR1M6IDAwMDAwMjQ2
IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAzNjkuOTMyNDk2XSBSQVg6IGZmZmZmZmZm
ZmZmZmZmZmMgUkJYOiAwMDAwNTViMGIzYzNkZDMwIFJDWDogMDAwMDdmNmQ0NjZkZThjMg0KWyAg
MzY5LjkzNDExOV0gUkRYOiAwMDAwMDAwMDAwMDAwMDQwIFJTSTogMDAwMDU1YjBiM2MzZGQ1OCBS
REk6IDAwMDAwMDAwMDAwMDAwMGUNClsgIDM2OS45MzU3MDBdIFJCUDogMDAwMDU1YjBiM2MzZGJl
MCBSMDg6IDAwMDA1NWIwYjNjM2RkMzAgUjA5OiAwMDAwMDAwMDAwMDAwMDAxDQpbICAzNjkuOTM3
MzAwXSBSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAw
MDAwMDJlNmRmMDAwMA0KWyAgMzY5LjkzODg3M10gUjEzOiAwMDAwMDAwMDAwMDAwMDQwIFIxNDog
MDAwMDU1YjBiM2MzZGMzMCBSMTU6IDAwMDA1NWIwYjNjM2RkNDgNCg0KVGhhbmtzLA0KU2hlcnJ5
