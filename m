Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B37D71AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjJYQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJYQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:28:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0B91;
        Wed, 25 Oct 2023 09:27:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwaXG006392;
        Wed, 25 Oct 2023 16:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=s3iXSuoN+Nrtwmk/qhXPLfSjAxVSkRnaOAmY6u47Dek=;
 b=OQNRGSNWiPMUBIb+tPgDhdH1Pq0ktSakGgNLtYqqDrRAP8mvsLSDdGfFkOhjXmGkbA3W
 SHX7QJDW4G8OeT4s9qQx6mMf9MqhzfP8RUAkVgzoCi2mVYc8V8dydfZ0nmHd0bZooWV3
 7tO9ElEoZw7L7d5Z8T1qg717DlajqaaBD8j0BIuJQmFxt/fqj3SATQglA5D3PQ5mhrMS
 miofyu3dlqPCJDnRIREQ/tVYhxHvDKZvwoRKZpgEoKpY4TiYeOl1OKGXw4zVtzDq93Y0
 oTcbfez4HGonh/6PfjqArXAhgF3EMjquOlX3e6Yooa7gj05vKb0SpiVKCScvnoWkmgC+ vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581r7pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 16:27:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PFRPtI014193;
        Wed, 25 Oct 2023 16:27:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfm5dkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 16:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i79ANDKzdx8o7gLEj3zloU7t4rUmS6oVTkrRYobRXD/TLmck9cZQkaeVHNAkq3FDnmugT0IywqttdMxUCfZ2oeXkzpMKLggSpRzNj8qC/L+Rn9KF4ZpZSzWXmzxRKfYDeF54NkNbiKh4rFA99yVQu2O9EkrXKLJUm2mb+TmuPbesTmwacRTliH6SAgJz7QiobIpkYxodZ0wpr8Lgmw48bcyx7QCwVbQzeWd3r4LMmXaPpAueyCYl+em3oCTccAvB6ROmC3jK7B7NpqSGQX1ZSRHCRCJLHsOQ4FKNN1aGNYMRs+UU91+E/4AJ1x7EPEhkLJYXDbqim5vcJqd2A7hA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3iXSuoN+Nrtwmk/qhXPLfSjAxVSkRnaOAmY6u47Dek=;
 b=PxET1q6JDDcJS9mN1GCAgMx6hCv4NG/f65dk8H7jDCFr2TCOPI6cdOJx/xuIzaT7LQx8blzw81nbYI5HIrDbenlNoFpy/iMOsEIjliU7DdqJOG3YG/lMBY4nPonerfbRsS1uDc4/x/TPxU0gCwTQ4kA9G7CAVuukLe5frOob1lvH2ICZYf81DjASEsrC6avl39S8g1P4RndGiMH69fyp6eMdk+kwkofEjgkV4E1DkUY/3ooEsdDwN6emfD7DdvKdOC52L4YuzjD44jkPvBHEoHgXwyvevkSlRnnd5GJ2sMYOqWL23AAdNL5GVe0KR2HtXP1TeSbfDdyS4bYMOzO4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3iXSuoN+Nrtwmk/qhXPLfSjAxVSkRnaOAmY6u47Dek=;
 b=m9Z9zdOR8FrWnlq2GfhJAgqw8l1gQWA5SjNPoCS5dYLOlOX5to1YCG7Z08UGXc2OYg3nITUjXRHZkar9fxGzpcIG3fyI7PF4dfG6lfub0QsbMmgv6VrDRX9qsCHDBfdiTsj0/JCsKIPdr1PdsBFoo2AebMnvH8gvloKxvMJ8JP8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM4PR10MB6014.namprd10.prod.outlook.com (2603:10b6:8:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 16:27:52 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 16:27:52 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v3] ima: detect changes to the backing overlay file
Thread-Topic: [PATCH v3] ima: detect changes to the backing overlay file
Thread-Index: AQHaB1EKBAitqnRS3kK+mlIGVgRDjrBasbYA
Date:   Wed, 25 Oct 2023 16:27:52 +0000
Message-ID: <485C9C57-ABF1-4618-81D1-345597A1B9FA@oracle.com>
References: <20231025143906.133218-1-zohar@linux.ibm.com>
In-Reply-To: <20231025143906.133218-1-zohar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DM4PR10MB6014:EE_
x-ms-office365-filtering-correlation-id: 13a79a83-768b-4185-9b2c-08dbd57755dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1x+w5PSKmkH+WjXK/W5Uhm8ap810PE/5YXBb2DwiaA0kJFyUJs/ifkNaqeFqi/M9pD4O5iugr9KrFbPgvEgDcYYPF+vTO/r8ws3tJhqwo63e7h3w9mQrs/w/Mh3rEkfAANCbQ8uBuyeorzTt2WJDE44PoQKBA97yN9JNkXuP00hhjYPV896rklHyqMue2cOaeNO3AdtDQMKCN2Ok6TEecVpR0RF+jLOZoB9ohn7k2CRFpiGvVojf8na1ZMfFs5EjDbHNuVBmSmhY8d9WnMA/NacnXTcTjTCOMqR57bnT9VNK+C6OZu7OjVSjxxIl4+s/z/RGuSHeyoyCnQNvIy3s8XVIrjYdZZbApp16w2PgJ559CegNeqUyZRaC7FF9TwQZK+jdoXcGQWbvQeZRpjZ+aPPKDJ4kCjc+V6HSiQgLli0PXK+R4BWCdx9EPFapa7U3hY0KGNUKAfs2tnH4qCSQ+oSvjRFp7742G+hBjuxqCmD+Y/fCipldqD1R6PrQyMc11jGFyF5gqc/v1zzfN4/RfU5phwLtMZYa/++W68ezWlyYQFfD0yuznkBuAPwjdwrw+dlnqNuDiZYIJ1Kt8nInb02jy+eAth9zEDJw7+N9jO/Hsi3FnrWrUM9xLJIIkeUOgRBqXkbEGg/ASpHvpQsgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(4744005)(6486002)(8676002)(8936002)(38070700009)(71200400001)(66446008)(66476007)(76116006)(54906003)(66946007)(64756008)(91956017)(66556008)(86362001)(478600001)(5660300002)(6916009)(44832011)(41300700001)(316002)(4326008)(2906002)(33656002)(6512007)(6506007)(53546011)(122000001)(36756003)(38100700002)(2616005)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0F2dW9oR2NROG1yREFrZkZRZTgxTEdDRExQVHFQd0JCVWx2SGR6L0Rzb1Ny?=
 =?utf-8?B?WDZYM2x3bXJnR1dydWc4MXcvV0dlSzhuaVFxUnNqYmY3Ly8wd1Rka2U0UnRv?=
 =?utf-8?B?a1h3WE1TejVhbUQ5Z1puY2FJQUIzNlp1VlVEeGg1eEZLdEsyQjlETHdDUUpL?=
 =?utf-8?B?dkFucWl0MVRLUGY5OTgxMHpHTHlGYUkrd2thRmRqRmdkbHVtbGV0Umw1d1R5?=
 =?utf-8?B?aXZyRFVpZnJocW5sa3c2K24wUVhadkZ5c3hxYWxGTXFBcEVRM3FDRXZpYTlJ?=
 =?utf-8?B?MGEyMGlPVThzRkRmRTRPc2M0NTRacGkzU3VQaU1Sb1A5eEdubno2RlBqbUdP?=
 =?utf-8?B?UXZucTA4OTJiTC9BWVVpa0QwNkNHQTQ0ajQxaCtQQUpLVld5VktzeU1JVm5a?=
 =?utf-8?B?bUUwTGsrbVNVTTJEN1FXWFVMVWt6eEVnOEtyZHU3REdrMjNod040QnhLejFr?=
 =?utf-8?B?UXZteG9Xc1N4aHlWOGpNeG1vNjJTbmIzRThwc0hlbTcvQnNzRmdKblRVL0wy?=
 =?utf-8?B?cmRaRE1XbzhaMS9QRktNNlB0Wlp4NkVsTlY3d25Zclp6dkhQRFBDRUJraUtr?=
 =?utf-8?B?U3ZreHZpK1Q4cnhmbXBZZHhqdmo4ZGszMzdRUnA5OTRITXh2S3orcElhR3lp?=
 =?utf-8?B?bCthQ1JIR1l3dURmZFV3dWcvOE1XWEpQL08xdGRnekl5Z05WZWE4Z3pNWXJY?=
 =?utf-8?B?SFR6Qy9oTXVQUTFoNDVCVmtHTEpwLzVjK1hCK1drY1MxNnJPZ0VXazFvc1RS?=
 =?utf-8?B?VGdNZHNxaDZ4UTNheHZBT2hodklyelUwaG5FN085cGhQNTZzUnNYTnVXWXdS?=
 =?utf-8?B?UmZWWTkyRms2MENyOGlyYXRaWCs2UlE4WCsxL2VVMVZqdjZDaUt1bEJoZWgy?=
 =?utf-8?B?cEhOK2pjRnlrMCs3RzMzVWliVlJRWmMzMzlBWk1RcW14S01nb0IreTBHMDUz?=
 =?utf-8?B?dDJqWHNQdW14a0NJQVYzdVpaaVNFNFpoWWY4K3U1ejFpNUVnTXc5L2diOTcy?=
 =?utf-8?B?czFMSDArRHhiSHRTdTJIc0k3VE1NNEl4ZnFheUc1bEJaYXlXaC9vSzZwc0xH?=
 =?utf-8?B?bmt1V1ZnazlRd3RIWC91VGs1MHRCTFNhd1p5ZUVwelJQeFBxRCtYamlFN1g3?=
 =?utf-8?B?NkhMakxaWGZZdVJUS3Z6eGhpbzlPK3FrZnhKandrU0lMdStUTXpxa2hrdzJG?=
 =?utf-8?B?L0pQby85Q0ZxR2pWaXZDREE4cGtHeVRDUnEvYUVRaW4vQmwvcU1Vbk4wVndB?=
 =?utf-8?B?clVsdDJKVzdPMlhydk1TdjhSNUZvY1djNUg3QVV5bXRXREs4eW42TmRVbjBD?=
 =?utf-8?B?aERFWnNKUlF1MXNYZUZPQzIxL25jQ0syYitoUkgzdm9lMmkrWmVGQkpqMU5X?=
 =?utf-8?B?eTFVcVRxN3E1aXo5RkRHbjRFZ0cxWG9MSU1MTGx4SEpScDlhdGxLYUUyUUdo?=
 =?utf-8?B?QnUwZ0lIbXpSU25HYy9abkpkdytiSC9ZQ1NyRTZVejQzbUU1UjVWbXF3Z0lh?=
 =?utf-8?B?QW5sSzZPNGJ5ZGxTOFlFYURkc0RWS3hsVE91Z2s3UkREYVZiS1VteU1EYm5w?=
 =?utf-8?B?ZklkVFM0dkZqRDg3NDEraWw1QysvaWFNY0MrTGFEaDZaRm9yeFQreTE2TU9G?=
 =?utf-8?B?Y1psYWQxaDNNaWtza29pRmNaOHpkK3hVMnFLU0Y2N3dtV01vL0VLN0k0UlFY?=
 =?utf-8?B?OGdsbXp1aUcwNG9JVXZoK01PcjdWSGdqaXduSU8wSDRDZGxtWEFUeG0vbkcy?=
 =?utf-8?B?RFBUeklkTzE0SVhqVSt6eVN3RzFoQkdvbVk2eHVJbnpLb1QxVFF5KzBSRG8w?=
 =?utf-8?B?aUJPVFpnU2g1R2dLeFF5SFJZUjJYY2JncWFBVmsxWUdmTmZyb2lDRUsxcTBq?=
 =?utf-8?B?Q3d4QnpuRHV0OEY1UGpqVk1OUlNuRUgvR0JrdGh5Ymt4b3BDeXVNbHA1QXBC?=
 =?utf-8?B?ZHVVRkpWdFFJeTBQWXFSUGE2bEpkM2pmZE9qWTgycHlkSDkvUGQxUm5uY2p0?=
 =?utf-8?B?bERMUktzSWJWRlhQQ3FYSTFCbzZ0M2hPWWkweHNKcDBxWStKbDVuc1FUdVJ5?=
 =?utf-8?B?VjM2a3YyT0Q4eHNhRldZZWt5Z20vUVdUMEJhNUg4NHZaZFAvRno0b0hKbFZM?=
 =?utf-8?B?L2ZRbWpGanYwWHV1dFVGcjdDZis3dmR2aW8vVTdjZWx0MFlLSTBvb3VkTWN5?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BFD1923A3177B47A4F01DC68D8E286C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iF2crUDpCMyNUB77YIjU95BOtYlu0Ecf/67WULlzf6k9Lcqv4HFRxFl72CNGlHJvPUVFRMD5826TnkKl+mrjUYRqr8ei8hw6m2svWKvfPeiiF+vmegbpuOmM4dGUCu7d4hMaeqIataBtXuBiPyHYRRHAtpljNrMg998bE5k6ce+PNLYz6YG59WTRJ9pErOfVlT+raAH/Hlx2lP3Q4s69I2vEQv2BR5ZVr2JkGZQgy8q3NM3dMT2LzJEb9H0/dypZAH/nKr3CeJR8LMs4VTBGDxfVa1OQasKmWbi/MqjWtEaGJKOK06FOXJH3sqx9ZQN2fWEGucMwi/Ky3YwDo9FKlfkTejtzMsGwl2jSN0hyl3ZQjYPoZHzKsM8EMwLiZL+WDkbcPunHKLtlqDnwdlOib80C+UpnrD4q6VYr0xRuJYid0gntTEeIJ1bcysyeLeGCE7ds4sEFTmEUXQ1gfYDoPhttFfRlfaL84N99idqMdBeG8jAoekhDhNN6svhF+yn5iEzRVwvCldxHLM71C7/3s9UQ3jClRGkxLz9yWjxYHM56midWfY7iOPTeS3ETmBXQIwuOq+mn4H+9GwCuSgtsTvVzvYnn/Wxhi81hv56Sr+uI/XekpF/tjepNTASSQ5x6AXgUHQKmmX7+SOtU9Hg2ugMIGidjZflrmqTf7CIu/2bilFtSdTO7mOuPdrhfw54bgwbjAXPKHmyBAvELB8WalgCkJBnHLBD24TExJPaZyBNq1sUliKDXJziQKrj6U6wgvSoM5kMQWBDkDJYE5Lobmyo4oVvxNUiTzKgYXxwVdOoUN5weONrYl4+5Z5nKejOi151sXXtHNNMLB9JOjZ5M4mjhb14R2mPpfR2wqSRob48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a79a83-768b-4185-9b2c-08dbd57755dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 16:27:52.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hs8dEbHgFvHDwsKQyyWPELD6n27SyBdcEppdYjrAo6Pfa0TJhmxACL8kEbWf9DOcC8+FDYApG7YGZB8CaV2SIZsuO/I5u1mzUPbT65rjAO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250142
X-Proofpoint-GUID: vlcZQRaibhqUw4YExOc0_sa6Qi8xzarb
X-Proofpoint-ORIG-GUID: vlcZQRaibhqUw4YExOc0_sa6Qi8xzarb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI1LCAyMDIzLCBhdCA4OjM5IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IENvbW1pdCAxOGI0NGJjNWE2NzIgKCJvdmw6IEFsd2F5
cyByZWV2YWx1YXRlIHRoZSBmaWxlIHNpZ25hdHVyZSBmb3INCj4gSU1BIikgZm9yY2VkIHNpZ25h
dHVyZSByZS1ldmF1bGF0aW9uIG9uIGV2ZXJ5IGZpbGUgYWNjZXNzLg0KPiANCj4gSW5zdGVhZCBv
ZiBhbHdheXMgcmUtZXZhbHVhdGluZyB0aGUgZmlsZSdzIGludGVncml0eSwgZGV0ZWN0IGEgY2hh
bmdlDQo+IHRvIHRoZSBiYWNraW5nIGZpbGUsIGJ5IGNvbXBhcmluZyB0aGUgY2FjaGVkIGZpbGUg
bWV0YWRhdGEgd2l0aCB0aGUNCj4gYmFja2luZyBmaWxlJ3MgbWV0YWRhdGEuICBWZXJpZnlpbmcg
anVzdCB0aGUgaV92ZXJzaW9uIGhhcyBub3QgY2hhbmdlZA0KPiBpcyBpbnN1ZmZpY2llbnQuICBJ
biBhZGRpdGlvbiBzYXZlIGFuZCBjb21wYXJlIHRoZSBpX2lubyBhbmQgc19kZXYNCj4gYXMgd2Vs
bC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+
DQoNCkkgcmFuIHRoZSBmaWxlIGludGVncml0eSB0ZXN0cyB0aGF0IG9yaWdpbmFsbHkgdW5jb3Zl
cmVkIHRoZSBuZWVkIGZvciANCiJDb21taXQgMThiNDRiYzVhNjcyICgib3ZsOiBBbHdheXMgcmVl
dmFsdWF0ZSB0aGUgZmlsZSBzaWduYXR1cmUgZm9yIA0KSU1B4oCdKS4gV2hlbiB0aGUgYmFja2lu
ZyBmaWxlIGlzIGNoYW5nZWQsIGZpbGUgaW50ZWdyaXR5IHJlbWFpbnMuICBGb3IgdGhhdCANCnBh
cnQsIGZlZWwgZnJlZSB0byBhZGQ6DQoNClRlc3RlZC1ieTogRXJpYyBTbm93YmVyZyA8ZXJpYy5z
bm93YmVyZ0BvcmFjbGUuY29tPg0KDQo=
