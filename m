Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6247CB39C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjJPUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjJPUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:02:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E826A1;
        Mon, 16 Oct 2023 13:01:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GJOYWm008890;
        Mon, 16 Oct 2023 20:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=999pAvpi9YaTsy07eEIYbezULMxiF5ZaWIsqxLpeFZ4=;
 b=Whn9yPabNkKkdvKNdk/xHa513dj7z231D9hDSVAJeAv710bv1c6YJd6amfSqiY7Wqmo0
 Py4xtMP79suiPx3ZJgxU5DXxOdAy/3ROSVdUgkjPH9C6/XYg+XiQh9bN232365KAxW1w
 AOsSuFo7kivaOJD544/lvq491KJBPh5V9J3zq4hW2bYUkYWqqVy8DfqC3TLLqeY5Gj2A
 8LKKHvMVqsCSkxuoG6Z6UdeL+UiwGN48uvhhqmBot/Nxgmbrq++nObNwtAKCXVY1fuwF
 OxZokQS6bLGlPJZIAQ3khBhwwwIK18k0NX+0GV2CgREo6Q6DqCbaRiQE+3Ug5vzWsf1B KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28kqck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:01:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GILQ5e021595;
        Mon, 16 Oct 2023 20:01:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg503760-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW634oIDtavD6yMTpUQn5N16tBckJNbMMAGiVEOohthFGx1LGiycwQcNuZoPAoDfEew2jtNDLov/ZdUHam3I9ZO3MHsNyx4r0i5i5XR9Lm0KKqyx7JpuAqHdStGA4mdSet+wAq3QmT4V8WLrpCGVtef1vy+63vFIzi74LilWjW3yes5iTyU0BiqB+SkxY1vFiRRPfe1UcP6ZgJPPdy1Lyg8IMb+yijDDvOwzE2q+sihFZdl4SzbV3mkqmgjgHhcSWstAlecrZHmFqMi/QnETjmWSGycPAVMPOcMI3HqbeeplT3lGA1EUsvfGl5QsqaBpBaDExZFexEybYthrfU4lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=999pAvpi9YaTsy07eEIYbezULMxiF5ZaWIsqxLpeFZ4=;
 b=FxD+uiO1ceVzHrFf2sOZc+kkwYsNWzK6tY3WbyAUhaUFU5IGSKpeBbQvb4+qQX//gNyHqNEfiTcvS8b4YVZdyEKNAOhYyRLfPzaYT3zMLz8ZljMcDyK3gRCBKb/B+urs2cje+iRcNCMwXo3GEJyT0xFfNqBSKZuTITJoA+VUIYfhwq5Yg+CDbPoxockR9J8/2F4m7qtfGNicxMagnkQrd+IhnMtjbAhP48snl9csUn3dfAqs7Bhx1TcNXQfEOQ43XkWLdOEkkR0Erqiqc8Gao84MgPgFpTjQKTv8f7qT5rGempMUHH1Kn8u6/6EWIPJzA3+qniv+65yDmJr4M4tWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=999pAvpi9YaTsy07eEIYbezULMxiF5ZaWIsqxLpeFZ4=;
 b=U/OM7Ob+hffpTudO1YEDnfEqeOE44EUG/LnzeDzNv7QPPNa34ipsXVu1pRzABVLlrG0XDsvn42H3IaBIpoI+abeb30BAogjsY1HxUZ9l6JrbXv3kHfXfmtFIIHHEkZB1EgxURDJqkg2YzpoCtcz7U0vLQYHah9vNyilUSQKa7Kk=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 16 Oct
 2023 20:01:22 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::20af:f699:b807:af2a]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::20af:f699:b807:af2a%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 20:01:22 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Thread-Topic: [PATCH V2] Consider inflight IO in io accounting for high
 latency devices
Thread-Index: AQHZ/hoaiR7GZT8ggkid9oX8ZtKxUrBM2paw
Date:   Mon, 16 Oct 2023 20:01:22 +0000
Message-ID: <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
In-Reply-To: <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4563:EE_|CH2PR10MB4166:EE_
x-ms-office365-filtering-correlation-id: 1b7ae75e-00b8-48d0-ef28-08dbce82abaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNLFTfAKVlipMicVbEbPgV7IhKvmsJ6sz9aZG/36E3TKafXLY216sJK5l96//7FdHa8x5TnoOa5u6NyrlQS/+WOJPXICtmosvOzbL3zl8MwyUC7a4Dr3Y+3V+BPsD7VIB1KmDlwR2MlLoeXS64olNW9hqB/PsE/dVCMwgP4Pf+/K4WBX8CqIlSUMMD4Buj+0PvlbkBqCzqLVyERMfcJ8olAHkPUnKPY3AxzDEa3P5Xe/7k3LS3ul28pXebJEzaA48t5OIinRx0m8bRKcE6RT5w057lUu515UlDDYWUI0mrjHGhiba7jOlYnM/ceVJLqxYpQTyTqYWYRdxZ0/Is/+EN8fcLuWDLFyGXl2AZhXYozIACHsRNitCcaSNql0hHQOtMOdSYDpJaDaqgTAJlQUEdUCl2wrKZeaHa7KZVByO7uaJEVMIbs54tsJD8j1tKBabnJyAngr/o8nu24qzSr861HbAF3ZrcJYTCQyqGfPTUfhdwIauqEEuqEJeGAKZv3sk48NONgjBNJpSmkL4K0aoBXAakgy+dMJ/q+owviCAkDsgrplRlKru43F3CipCdXOjhcMfa+XLi6zbrMdoC0KpClobNyKlyn1q2vEZqeMWBJefkuvH2Qddorg95v7vgbG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(41300700001)(66556008)(316002)(8936002)(8676002)(110136005)(66946007)(76116006)(64756008)(66446008)(66476007)(52536014)(83380400001)(55016003)(53546011)(7696005)(6506007)(38100700002)(38070700005)(86362001)(9686003)(122000001)(26005)(5660300002)(44832011)(2906002)(71200400001)(33656002)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qy9EWUs1N3A1YUp6aFlwa1dzSlFLU2lPdkdYKzNzd2RqbVhFaDRJU2J5RHFy?=
 =?utf-8?B?VE9IS2RJSGFneEI4ODhJcVpEcXA2YmhvSlB0Q3BYK2hDQjV6cEFrMmF5eHFX?=
 =?utf-8?B?dkJ4THQ2SHJtbis2UVRJWVFtUmZ2SHliNHNJNzBMVm1qbERLZ0dFNTFrMFZx?=
 =?utf-8?B?RE5oN2xIcXViSnRSVU4rSG9CdDdZZ1ppU1p5aVhicDBSZ0ZOckVzOXArWEMz?=
 =?utf-8?B?dlFUZlAzWm9zUk1qRGQ5RjhMRnMzZVFvVFZOTWV5VnF4aXpjRG5mL21SQTBH?=
 =?utf-8?B?N1VNL1FxYTVwQktrdW4wSnpCMytCSnFRRzdXSDRWalJqT2VHbTRJaDRlb0d1?=
 =?utf-8?B?bkErOHVxb0VXYXhsTDhSRTJaUW5rTVhxUDk3bXF3SlpYTWFGTjhzS1Nla29x?=
 =?utf-8?B?SHJhTmtTQlJrcHlMWHdLKzk5VlFic3VaRHVHSkMzNTJROFNJeDdhbEdWSW5D?=
 =?utf-8?B?b3J1d1N4UEdFMUV6TnZIaXRvUElaSWdrcWhwWGdzdFlaNWNiYkVDQzd4TEJ3?=
 =?utf-8?B?amQ2ek5oQnVka1JGS0dZaXhXdzZ0cHd1MjJGUnJEalk1UG40QWRKTGdpcklT?=
 =?utf-8?B?NmYvTlRYRW41N3ZKbXBidWliNGhEZDIxUFFYaE5hcWZ2UnBidXVuV3dKS3FP?=
 =?utf-8?B?ZHg1RDE5YjY3MzQ2cVVOU3pCWEpjTXRLdzNLOTdxTTZ1czFTaXhjb0c3SUZP?=
 =?utf-8?B?bmpCUU9pbUtxdGV2VzgvUGE1S0JNQng4aSs0ZXY2a2MwcEhTRHFRejdqZnl3?=
 =?utf-8?B?aGhYWGtIV21oR2xESk1ITUpacGNiY2t3d3c4M0lLaDFwcW1jb1k5VnpTSVpB?=
 =?utf-8?B?TG5tL3BYbVFON2RWMUZRR1Bpa0pxYTZpcUFndzlDUzJlcFR6Rnk4Qzhydllk?=
 =?utf-8?B?YjdOMFZGV21VeVhWc0lqak84bzVTVG5KMU1nNHdtRTY1Y2RuNFR0RFFxNDU0?=
 =?utf-8?B?eDFoRVNGU2tnZVpFeUhrRVVUVGd0Y2dHMExzaG50UEwvajhCRHlkNHdxaE1q?=
 =?utf-8?B?SkhncUZEdnZ0SC9QaWphMUd5QjJscnFmL2lzcDdYeGlHWk1FN0V0OUoyMDJB?=
 =?utf-8?B?b2pXdUJpSGZLY0I2cFBEY3VxeEErT05sV2VQVERHYmk4bU9BWDVHRi8zRDJU?=
 =?utf-8?B?cEszRG91NmFQNUhTU2tFQ0Q2UWZNVmZLTFRKcnZsZjFTMTZvZVRpanFFVXMr?=
 =?utf-8?B?R1EyZXNnMGhOWmowQ2taSXNZNWRJeW5lRERjd3hnYlREWnEvNEZTWjhEdUtQ?=
 =?utf-8?B?NHh5R2RWZFdXSkl3bFZncDh0TlVUZ0xGVC8ra2Vaajk5WXFtWnRsWTU3ekpm?=
 =?utf-8?B?OS9JYUc5ZUVZVW5LK1BWUzJBZUtzejBWQkxYRmk5UkJMY2tYTzlObWpvTTdm?=
 =?utf-8?B?S3NaWTd3UmE1ekcxNHpUcmRvWlhaamRhdzkwR0Erd0dDWVNxNU1ldWw0NlI1?=
 =?utf-8?B?cFNDU0lRWWlaRThnSEl2endsaDBrelQvK1BySDczOEZEMGh2VjZkNFhWT2VE?=
 =?utf-8?B?QVVEem01OTRLQ28wdnEyeTFiSGtmTXdrOVlxOXgzT0dTeG41VWhQejVZeFJF?=
 =?utf-8?B?OTBwYS9Jejc3eHRKUnQ5Z1BjS2ZlU1g4UGE5U0FEbEQ0QnViRFdzcDlpeWZu?=
 =?utf-8?B?NUxYRWlqT2ZoSndTZDBlVXJoaElJYnNuc01HSjJJZVkzeENHWmoxZEM1Ky82?=
 =?utf-8?B?cHNiZytuekpUZkp3amZiY3I0eTF4YjlhRGpQQkNSREFUblBNcGxaTE45MW9u?=
 =?utf-8?B?Mjd4NVlXU0drSVdUQ1oxR1ZFUlhpemdPMVUvZU5CeGNMUjMwbGN6bzlHWmpP?=
 =?utf-8?B?eDJuR2hicG1JQ0tLSmprazI3UjN4SVN6dloyN3hmalY2aCtFdGNaWVgxQUdl?=
 =?utf-8?B?TGlJQTVYL05QNlZvVEhTNG1CTDA3Y0J2ZVR6Z0paUkdQK2RaRVZ1OFlocW5m?=
 =?utf-8?B?MndoSWVWSlJNWUI5eGFETTN5dU5Fc1RvYzNEK2hKSmV4UHNobTFicFM0WG1C?=
 =?utf-8?B?bU9mQjFDZk9SQ1NmMVZxeVRhcmtEK3B6cnM2VkJVd1EwSGhLLzErZEt0aHg3?=
 =?utf-8?B?cldESEh5Q0FHbjZVTVVoaktkNHllUlYvbVNEMUxLWDFwWkswVjYvYitkSlZZ?=
 =?utf-8?Q?/pfFG5HKrMMq8MXh9KTXoKn9Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yFmlzGGSWH8ZqypUTIyooK79MkYGioXFROH1GX9+aYMtoUY1ywdsiiXvwTQBNfBqiSLY0qblGqyhvyowuFnkJm6+MUrjoqzuJxX9ttvwVr7OESTnH6bIlbd9b3Td2wOJkocbpxrXvCbMCokiRpgMmp8aRAZnemDFZXe1CDAeETa+t+PRC3BDZ5Y4Yucdxh6BAI2ekXxnZBI+UXXuW6k+OG7x17BgNkF//pZAp1YcRqdBTBZLII8ac3qinevGi+FNu60R964pyEeoas5oDewPjhTlndGY8ZklQ5OULO8NTnNuVBFmNrxNlZLBmiXjVtIVkD+wZEJ9qQiNOK41zZNqjfIssEG6vG7TPOd/IufiMe4V7SbcWCK90D67xUT6Bm/zN0/q0mtQbjJvABWBUlsRtzM1Lr6OGAAk/de0fNbajGweKsXRxkcKqWyouToWOPpPcrDg0rh5/aFIJOiBuGGeTO5qZ4fPsKgaX1YJmDFjj/LO8UZg3FDO6OKpoBfYEmXo9sRi1iaysaUOE87o4NH69MyY/4waE/yhH33pfO5k90bGbJBQVwM1LULY60uQCDSYo8587QPCT6JQVLCtauX8OIgQuSxfx4BCxvAsvSyuV4/LQIwnM/D7K3MsytjEcbGultZ0PRzjl7DG6AA2ToMBzTBq3ivkQ7h0efaglkI7fZ6ofODxnf5oKRLbkhiv/mQkham6llpTI5TBGNFv2OFTmjHvQblxRYvOgQpvHHcqy1KijwZjPCEm/gEegDGSEdcBb+toMrFL28xm99p0oUklFprMSGG4XYqC6Df4ndNX3l9e5lv7NrU5bWlTBN8aIL8X
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ae75e-00b8-48d0-ef28-08dbce82abaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 20:01:22.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtDDp2pw2A58nthQ6EqmiiVvJ+EB9xUlvZRtLIIEeIAcByJpzJO/HDcogZ5HtZBQpv0dgNb81DLDe9tri34wFbc+iqs4xmSpFNYJc/cewa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160174
X-Proofpoint-ORIG-GUID: 3rPa8MLdl_eWxzRFJZ7Z9orqFeF9lFBk
X-Proofpoint-GUID: 3rPa8MLdl_eWxzRFJZ7Z9orqFeF9lFBk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydCwNCg0KICAgVGhhbmtzIGZvciB5b3VyIHJldmlldy4gQ2FuIHlvdSBwbGVhc2Ugc2Vl
IG15IGlubGluZSBjb21tZW50cz8NCg0KUmVnYXJkcywNCkd1bGFtIE1vaGFtZWQuDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVA
YWNtLm9yZz4gDQpTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxNCwgMjAyMyAyOjQzIEFNDQpUbzog
R3VsYW0gTW9oYW1lZCA8Z3VsYW0ubW9oYW1lZEBvcmFjbGUuY29tPjsgYXhib2VAa2VybmVsLmRr
OyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIENvbnNpZGVyIGluZmxpZ2h0IElPIGluIGlvIGFj
Y291bnRpbmcgZm9yIGhpZ2ggbGF0ZW5jeSBkZXZpY2VzDQoNCk9uIDEwLzEzLzIzIDEyOjU1LCBH
dWxhbSBNb2hhbWVkIHdyb3RlOg0KPiBAQCAtMTAxNSw3ICsxMDE4LDEzIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBibGtfYWNjb3VudF9pb19zdGFydChzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiAgIAkJ
CXJlcS0+cGFydCA9IHJlcS0+cS0+ZGlzay0+cGFydDA7DQo+ICAgDQo+ICAgCQlwYXJ0X3N0YXRf
bG9jaygpOw0KPiAtCQl1cGRhdGVfaW9fdGlja3MocmVxLT5wYXJ0LCBqaWZmaWVzLCBmYWxzZSk7
DQo+ICsNCj4gKwkJaWYgKHJlcS0+cS0+bnJfaHdfcXVldWVzID09IDEpIHsNCj4gKwkJCWhjdHgg
PSB4YV9sb2FkKCZyZXEtPnEtPmhjdHhfdGFibGUsIDApOw0KPiArCQkJaW5mbGlnaHQgPSBibGtf
bXFfaGN0eF9oYXNfdGFncyhoY3R4KTsNCj4gKwkJfQ0KPiArDQo+ICsJCXVwZGF0ZV9pb190aWNr
cyhyZXEtPnBhcnQsIGppZmZpZXMsIGluZmxpZ2h0KTsNCj4gICAJCXBhcnRfc3RhdF91bmxvY2so
KTsNCj4gICAJfQ0KPiAgIH0NCg0KYmxrX2FjY291bnRfaW9fc3RhcnQoKSBpcyBjYWxsZWQgYnkg
YmxrX21xX2Jpb190b19yZXF1ZXN0KCkuIFNvIGlmIEkvTyBzdGF0aXN0aWNzIGFyZSBlbmFibGVk
IGFuZCBpZiB0aGVyZSBpcyBvbmx5IGEgc2luZ2xlIGhhcmR3YXJlIHF1ZXVlLA0KYmxrX21xX2hj
dHhfaGFzX3RhZ3MoKSB3aWxsIGJlIGNhbGxlZCBldmVyeSB0aW1lIGEgYmlvIGlzIHN1Ym1pdHRl
ZD8NClRoZSBibGtfbXFfaGN0eF9oYXNfdGFncygpIGZ1bmN0aW9uIGl0ZXJhdGVzIG92ZXIgYWxs
IHRhZ3MuIEkgd291bGQgYmUgc3VycHJpc2VkIGlmIGFueW9uZSB3b3VsZCBjb25zaWRlciB0aGUg
b3ZlcmhlYWQgb2YgdGhpcyBhcHByb2FjaCBhY2NlcHRhYmxlLg0KDQpbR1VMQU1dOiBZZXMsIGl0
IHdpbGwgYmUgY2FsbGVkIGZvciBldmVyeSBzdWJtaXR0ZWQgYmlvIGJ1dCBmb3IgdGhlIGhpZ2gg
bGF0ZW5jeSBkZXZpY2VzIGl0IHdpbGwgbm90IGhhdmUgbXVjaCBpbXBhY3QuIFRoaXMgaXMgaW5k
aWNhdGVkIGJ5IHRoZSBsYXRlbmN5IGZpZ3VyZXMgSSBwcm92aWRlZCBpbiB0aGUgcmV2aWV3IG1h
aWwsIHdpdGggYW5kIHdpdGhvdXQgb3VyIHBhdGNoLg0KDQpUaGFua3MsDQoNCkJhcnQuDQo=
