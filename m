Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78927E436A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbjKGP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjKGP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:28:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA51E9E;
        Tue,  7 Nov 2023 07:28:27 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7DMUQU000318;
        Tue, 7 Nov 2023 15:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=Y7KI2XH+TfgDyWpYc1giNv5Bm8dq//FyAMqqrMxIW+4=;
 b=bT2oJKclYRRuthvW/O29Hocr8PCZ0QQVEvYzYaRDAXyTrPvvJr5Z1+pgUWI4xErR1P8R
 MxyzPixxoReeTnFQKo7ZIMEIjdcTcOsKwi0g4Tzncbas7COp7/TbeJodXZs2EKDKyVMV
 IrEONCUlUZJEBMxATPMdbYvWE1V5ttZ8QiuRmPIxaLOruePqIKgYuLQPeUlxnaGscO1z
 eZkJCgllhVBtUtU2U8zolCeQosrQIg5GwSjH1yQUF1cwX8ph/NnkY2djh81JPoC3BRwL
 wjknDZIyVmHOA4ZK7bQ1clqehAKZCLZKO6U2SmqBTlGwpOqtTvTwUOWbh3L2z0CBlSZC eA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer3tdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 15:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYMW7cDIFNW51bUUmK4edHuqiHoJEln/phXwFkaBn0HufLEsMefdAD97Pl0EUN9+AqrGL3LFLpB3i7yr2feerXlRBsb4gH3JuL0SjzXTQOem11zU5PPeLT9OEeydKSGvZG3dvhHX3v8gaf1XsPiByqEjgQYiUAQwiI1rBxF0QcQa+d9BYxKx4nEwkOZB9UkqeeUZBxzBly1v2d8smV0Z6jQZje0UvoUv4cwbLJO71JlTiui1VYXTYvOojubKJkC9xe4NkDHgdqqgUJ2mxDQbFzlE35rta6sBU0FFMRF4kyLqFASsy0JgsNGeYkjc0LR0B8S74Hy9IficHoyauCsm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7KI2XH+TfgDyWpYc1giNv5Bm8dq//FyAMqqrMxIW+4=;
 b=Nit1Tya7kHLmuLEer6i9YBOGq34BXn9Vvl8rTvD0b85wpCAL+fNiihyhFGtWKnWcXZztYbML9JaHd6kCo2SJLiMGyiW4TeCetswzkHzhxVm/W40RZuxryVROHYRR0xevctpIoba+9SsOAGVpxl4ft7KwGlLilx+UGXGAoXFabofb4OFevz3xkilnAEFP0SJ/znMr5FqxbklirEy075txLyIW5iVwbhPGh2gkrVeM81OP2v6MlOjZlpkY5cZrEQmvs5m+Hvjxctl/728/vGcI7wOMV7bRRVjidMyU7Ewj4h9KSV1Sht5c9Q+IW9tVEzwIMv+l9PYpL6klDSMreS6TzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8806.namprd02.prod.outlook.com
 (2603:10b6:806:201::10) by CO1PR02MB8588.namprd02.prod.outlook.com
 (2603:10b6:303:15f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 15:27:54 +0000
Received: from SN4PR0201MB8806.namprd02.prod.outlook.com
 ([fe80::d713:e09e:4143:92dd]) by SN4PR0201MB8806.namprd02.prod.outlook.com
 ([fe80::d713:e09e:4143:92dd%3]) with mapi id 15.20.6954.021; Tue, 7 Nov 2023
 15:27:54 +0000
From:   "Atul Dhudase (QUIC)" <quic_adhudase@quicinc.com>
To:     "Mukesh Ojha (QUIC)" <quic_mojha@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Atul Dhudase (QUIC)" <quic_adhudase@quicinc.com>,
        "Bjorn Andersson (QUIC)" <quic_bjorande@quicinc.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Thread-Topic: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Thread-Index: AQHaDkSlN33zVerUsUeQmDcdfHLBebBo/MiAgAPi2gCAAPvgAIABAR8AgAAkyHA=
Date:   Tue, 7 Nov 2023 15:27:54 +0000
Message-ID: <SN4PR0201MB8806AF236D696E15CDC6400CF9A9A@SN4PR0201MB8806.namprd02.prod.outlook.com>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
 <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
 <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
 <d1e3adb5-b179-a119-fc0c-f92c2b84c7c2@quicinc.com>
In-Reply-To: <d1e3adb5-b179-a119-fc0c-f92c2b84c7c2@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0201MB8806:EE_|CO1PR02MB8588:EE_
x-ms-office365-filtering-correlation-id: 2171a658-a24f-4ef9-797c-08dbdfa61cba
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZdYZ7mwN0J5hXKYjoxjjYUQImDBrCPhY2W3sXr/BIwKVRMNgdvoCk+Wkl2DWucE3mrpMMIVj+Gvxi1QTGv2VLwocRIggt2UODLOdo7ttC90P3RkH4/yKIhwRHPHyfn2qYglN4t9Xtyvjf3zAJo/E/5qaZ41HQ4qnYKSR0TUMEV6wiGkO5xYnjYYNkLXMKTmAsSGIUsg5m2oM8mXKWfQcWu7CO5Iwi9GcLDDLrblyfpHzQSgDc+gHjci4D7e3CToMo+N2FJeBBsOvpr6uOlq0uqRP7nD5iyXoN2EGo0qpV/AvXn6Wl/va69FAVfVwX4O9uiX8HUz8XQSsJdENpzsXKYuB+sfzkdTsPsIL1x+SrmqsYoSP3rr/kMg9RsbwMh0TfWdblSRHcRnZVUFyXYndU6o0O8R2ClrNb38AVnWa09/t1V6RxVdxbZAro5PtArI46V7wdRxil+mP1+cKrYqLVjzv3wqVyCrd5GsYLOX5Y4auj75xwGFYBEhk7qCEyt7jnjh85IOKVAyPgskgUGIFiogRwtpBSHPMsK4hw0+A8WDp5vXnasdeB2R5/SWL5etO4ujztrpP0SdVuRF2lVrseIe2W+JIqKLFg7m3WlXQQDpRzKvaYQyiQf4vfv86f7D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8806.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(316002)(478600001)(71200400001)(76116006)(66446008)(54906003)(6636002)(64756008)(66556008)(26005)(66946007)(7696005)(53546011)(6506007)(9686003)(110136005)(4326008)(8936002)(52536014)(8676002)(2906002)(5660300002)(41300700001)(66476007)(33656002)(86362001)(38070700009)(83380400001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnp6a3R6c1dlVkpWVjByZk9ZNDNtY1dSUmhoU05uZ0diam1OWk5YWXhrT056?=
 =?utf-8?B?VnN2VjFjdFh0RFJ6ZEplamxISUdnbU9lVUMxUkgvaGQ0UW45ODlIb2MwWWhs?=
 =?utf-8?B?ZWcxZVhjSmtBQlBycUtRVnlPOUdLSDF0c1R0NVJ4ZStVTXd5T1NyRmpjTGlN?=
 =?utf-8?B?bTJmdWkxalVxMU0vOVk0QXlBWTBaTG9PcjlvTHNpcG9sVlc2c21JVDVlUW80?=
 =?utf-8?B?c08xbFNJbW5VQTJhUWgvOXdJbFVmR3puLzJPUWtXTGtsOXQrSE5GcHd2RHNp?=
 =?utf-8?B?SGE3UDQ0WDczb0FhRC9DYURmWm9mU041aEVVWlBYUlFRQ1JKTGNZc0dWS1VS?=
 =?utf-8?B?SDVRamQ5cTJFUExPdzZOb2ZOQlpaVzZwMWY3bTd2d0VHR3lGb2R5cC9abVo4?=
 =?utf-8?B?eldmSk5NUmtiemwzZTVlcFpyRGY2NElDNDJwWUE2bFprdnRXTmpHb0FUSk1t?=
 =?utf-8?B?LzN0VW4xSUxjRE5KQjBzdDFBL1p1MVhYc1lKYXRDWStlcTcxbGFSdWF0MXpu?=
 =?utf-8?B?R05tSXlvaFphTlg3bFc2bjQyTk5YK3N5TytNM0JQYWkyNUg0YU1kTVpyWVZR?=
 =?utf-8?B?OFdDc256MlRjY0d5d2JETEpIL1YxRmtLek1OaldadzZlVzhSb0J4K1kxKzFm?=
 =?utf-8?B?bFY1ZFNDSzlhSURGZ2VYc01rTmp2SmViZDVzZ0xLb2ZZd3pIeG5rTk9UczEz?=
 =?utf-8?B?akpyYjBsMmNWQitaSUJSbWVNd0VuTVpjZEtCZTMvdHZ4Sk5OekdPcWUzNE93?=
 =?utf-8?B?ei83ajlzUDA0SXFoNWZOMHBwa01icXFacHdSNGFubWtGMlc0MWxIUlp2cjMr?=
 =?utf-8?B?SGNXZHN6bUV5RVdlYXduTVEycEtkN3JRTmVCNXVML0QxM0puL3hrN2FRUGJ3?=
 =?utf-8?B?M0xQZUpDY2k1YWdSRUdmV21oWmhNa1VUbEg4eDlEVWh6VGFsU0hLQWxsc2ZN?=
 =?utf-8?B?VFFLN1RnOW9sWnRUdXRtSlRGR3B5U1J2bmR2Z0h5Umh0eVJvZTduZHlrbWZo?=
 =?utf-8?B?SG5ZNnBreHNsRktWTWNpeEFpb2dWVlhNR0s5RUZyMUpldk1FSVFsL1I1eVkr?=
 =?utf-8?B?VXBwSVc3NlVDSmxVckt3MHNKaEJncXBNZTlUc0V1NXhoK3F2cEFQVXpEU3Q3?=
 =?utf-8?B?ZXdKZVZFeEpnZEIwVk85dGVocHovYnc0WmdwaGpNS3N4NHp1YWhZSUN2WjNt?=
 =?utf-8?B?U0FKaGJFdVZKTU10c2g4RSt3R0pnVnQydHZtYWQzaW5URUMwY0hrM3o4allV?=
 =?utf-8?B?WG5aY3dHd3JrN2s5T3hFdjJQZFhzWGtCRzk4MjB1N3hVQnI1bFlBb2oweCtE?=
 =?utf-8?B?bWRMTG5lRzBlUWZXSnVRc0xnc25OQXZ5ZXh2SVQ1TG84WFBzMldzRmM2Q1pr?=
 =?utf-8?B?ZitiSW8xRno0WVhoNUpRUi91V21lR0Z5UWJBVGxRd3dvazFwUlZQQ0xlazBU?=
 =?utf-8?B?WFc3elROeWxzelpFcU9EVjhLNnRXTUI5d28xRlVDV0x3OW1ha3RIb1ptSlFW?=
 =?utf-8?B?OG9hdkxLQmlRSG10MkZEdXhBK1NRcUl5VUFmbkRQckVsaDhJOUxPaXJtdm9l?=
 =?utf-8?B?NjllN014QllNMzkzaVJsdlFVZWRzV2hiV0g3aDU2SGNKNUlvL1hyUWJ1d1hh?=
 =?utf-8?B?eFBsc0t1YXpnTnpGQ1Z5dnlkd0lIVmZpSkpCcE5VaEVza25NOGhsWFZTQkZ0?=
 =?utf-8?B?ZmMzc3pXcUdNRDRSd3A5WjgvQUM4MmtRNjA4RTRXOXVsQ1pJOVhhRWgxKytr?=
 =?utf-8?B?NCtxRkd1ZUNwYnJCQTRsVzZVSnNtVGd6RUlJY2VkTlN6eUtqSncrUDJEbktj?=
 =?utf-8?B?NDVrWWdPQlRRL0hFQzdkb0UrYk13Z2RmQSswZDFGR1BaVWE5c3dqQnQwYXBK?=
 =?utf-8?B?cGV3UFpGdHFnaDd1QTI4M3ljekVsRFlnQkd4d3ExUFRzK1AxUExKbU0yd3Jz?=
 =?utf-8?B?U3BOQVRwMVF4Smo5L1NSUmQydFY4WlRHV0p2Szg2ZCtVMmQyOHg1ejU1SE5Q?=
 =?utf-8?B?MDluUjJ1SjByY050dXhqcC9rbFVCNVdTZDgyODVlcVVlM29leDR2ZXh2Qjl6?=
 =?utf-8?B?OWhkaXl5SitKNWJ5dm1JTStmdTNPZVRZcWRLQllCMzRHZmh6TGFERGlZM2c5?=
 =?utf-8?Q?IigpbZqOoV46wcCT3pPlajqlH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i1Ng58jqtcpSVY9rmNRZ0XY/yTCsGvn4yNuF/1bi/mN++cun8nT6okDQPrj9Exbz5GJIm7ROv8vMH3BOkDzYpxH4XDOXYv3l7gSQmhoU2ExGq9cBBd1GhbbBUMEsEoEatznGiFYeC7jdw38Uk0IgrvSHu4jh/Z7DhH7Dzg4osJ5neaQESaB9lDL/qi8qmLA4VHuy+dENYX2pV611xhnJpaeQGtZlSPLF9RKmcIGxT2qjcExhs1fktRj/SoGJ6wiW5xAP+UiMNhXS6aRF9Q4iaFy19hpmpL33Lrv0+fOVqAMMcabUN3Z5eUMRCd/hFCm+dB7zyj80sVpOmd1krvrd9z3L0sINFTpMVQjRKQnmEL8/3qmc/mjl5Neg2KpY/Y7WYiY3I6fujVSSLggCOOxzvoCnTc8QZG8LZ7dK6DnU+aiCUg6RDQn5B7UgjX/heCuSyx9xS3X8h1rxN517ObQQBOL3hws/9qimR0bfVZJIobZL+xBgFI9WFEcMkpKlNaFi0i6VhgnNc8j3Su/+PMOZhQV+dcxqJyTte1TGiwz0nNHIIMJKg1vuJIWMbVn7MyyS2UqlvkS7xi20OcaYV/bx00tjcAb9iw837pnNBfZgqBz6nP/9A2ysg7XkcimxtpjY9ZfhHOKBF1muYxvgC/F6LhPAYTDO1AFqqxJ6B2n6oumSY1SJjSRwpSUyHOxkNPzb1wnI/IHi8dXcxbh7/3r+Z7HUxvRpCvaMetr4BgWKivt9A+wVxSUaovyeVm9FBT4AIsPWxnO8YZy0c55OwhZAtNWocDHlkx2lnruz/nq3m1Ei7AfpK8mbVNq2HdfmSxhtjBt9NOFb6zufa8cJJmpmLIseTZJQpMlKaTGuC/6+GvB0k6v9coDLknHcVpZaK/YSC+30uzxVldNgp8mgbEGcQNpikc1r/sTuktic9Cj564w=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2171a658-a24f-4ef9-797c-08dbdfa61cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 15:27:54.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIeNCxCkzTUvD/jXcEz6D+3cg2YgoMOtnBX88UuoQP+wDnRtp5/+jHoP40El4JLIPjm30RbLtUFa8YpYINHcVrsvnnzMcREVdxUA985Tixw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8588
X-Proofpoint-ORIG-GUID: n4T86ylHI8bNp-wa3Fyz9-7HRs7EoVnM
X-Proofpoint-GUID: n4T86ylHI8bNp-wa3Fyz9-7HRs7EoVnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_07,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDExLzcvMjAyMyA2OjQ2IFBNLCBNdWtlc2ggT2poYSB3cm90ZToNCj4gT24gMTEv
Ny8yMDIzIDM6MjUgQU0sIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiBRdW90aW5nIE11a2VzaCBP
amhhICgyMDIzLTExLTA1IDIyOjU0OjI4KQ0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAxMS80LzIwMjMg
MTowMyBBTSwgQmpvcm4gQW5kZXJzc29uIHdyb3RlOg0KPiA+Pj4gT24gRnJpLCBOb3YgMDMsIDIw
MjMgYXQgMDQ6Mjc6MTJQTSArMDUzMCwgQXR1bCBEaHVkYXNlIHdyb3RlOg0KPiA+Pj4+IFdoaWxl
IHByb2dyYW1taW5nIGRpc19jYXBfYWxsb2MgYW5kIHJldGFpbl9vbl9wYywgc2V0IGEgYml0IA0K
PiA+Pj4+IGNvcnJlc3BvbmRpbmcgdG8gYSBzcGVjaWZpYyBTQ0lEIHdpdGhvdXQgZGlzdHVyYmlu
ZyB0aGUgDQo+ID4+Pj4gcHJldmlvdXNseSBjb25maWd1cmVkIGJpdHMuDQo+ID4+Pj4NCj4gPj4+
DQo+ID4+PiBBcyBmYXIgYXMgSSBjYW4gc2VlLCB0aGUgb25seSBpbnZvY2F0aW9uIG9mIA0KPiA+
Pj4gX3Fjb21fbGxjY19jZmdfcHJvZ3JhbSgpIGNvbWVzIGZyb20gcWNvbV9sbGNjX2NmZ19wcm9n
cmFtKCksIHdoaWNoIA0KPiA+Pj4gaXMgb25seSBjYWxsZWQgb25jZSwgZnJvbSBxY29tX2xsY2Nf
cHJvYmUoKSwgYW5kIGhlcmUgYWxzbyBzZWVtcyANCj4gPj4+IHRvIG9ubHkgYmUgdGhlIHNpbmds
ZSB3cml0ZSB0byB0aGVzZSB0d28gcmVnaXN0ZXJzLg0KPiA+Pg0KPiA+PiBJdCBkb2VzIG5vdCBs
b29rIHRvIGJlIHNpbmdsZSB3cml0ZSBidXQgdGhlIHdyaXRlIGlzIGZvciBlYWNoIHNsaWNlIA0K
PiA+PiBpbiB0aGUgc2FtZSByZWdpc3RlciB3aGljaCB3YXMgb3ZlcnJpZGluZyBvdGhlciBzbGlj
ZXMgdmFsdWVzLg0KPiA+DQo+ID4gQ2FuIHlvdSBhZGQgdGhhdCBkZXRhaWwgdG8gdGhlIGNvbW1p
dCB0ZXh0PyBXaGF0J3MgdGhlIHNlcmlvdXNuZXNzIA0KPiA+IG9mIHRoZSBpc3N1ZT8gV2h5IHNo
b3VsZCBpdCBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZT8gSXMgc29tZXRoaW5nIA0KPiA+IHNlcmlv
dXNseSBicm9rZW4gYmVjYXVzZSBhIHNsaWNlIGNvbmZpZ3VyYXRpb24gaXMgb3ZlcndyaXR0ZW4/
IERvZXMgDQo+ID4gaXQgbWVhbiB0aGF0IHNvbWUgYWxsb2NhdGlvbiBtYWRlIGluIGEgc2xpY2Ug
aXMgYmVpbmcgbG9zdCBvdmVyIA0KPiA+IHBvd2VyIGNvbGxhcHNlIChwYykgd2hlbiBpdCBzaG91
bGRuJ3QgYmU/DQo+IA0KPiBAQXR1bCB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IHRleHQgYXMgcGVy
IHN1Z2dlc3Rpb24uDQo+IA0KPiBBbmQgeWVzLCB3aXRob3V0IHRoaXMgY2hhbmdlLCByZXRlbnRp
b24gZmVhdHVyZSB3aWxsIG5vdCB3b3JrIHByb3Blcmx5Lg0KPiANCj4gLU11a2VzaA0KDQpEb2Vz
IHRoaXMgY29tbWl0IHRleHQgbWFrZSBzZW5zZT8gSWYgc28sIEkgd2lsbCB1cGRhdGUgcGF0Y2gg
YWNjb3JkaW5nbHkuDQoNCldoZW4gY29uZmlndXJpbmcgY2FwYWNpdHkgYmFzZWQgYWxsb2NhdGlv
biBhbmQgcG93ZXIgY29sbGFwc2UgcmV0ZW50aW9uLCB3cml0aW5nIHRvIHRoZSBzYW1lIHJlZ2lz
dGVyIGZvciBlYWNoIHNsaWNlIGNhdXNlZCBvdmVyd3JpdGluZyBvZiB0aGUgdmFsdWVzIGZvciBv
dGhlciBzbGljZXMsIGxlYWRpbmcgdG8gbWlzY29uZmlndXJhdGlvbiBmb3IgbWFqb3JpdHkgb2Yg
dGhlIHNsaWNlcy4NClRvIGFkZHJlc3MgdGhpcywgb25seSBtb2RpZnkgdGhlIGJpdHMgYXNzb2Np
YXRlZCB3aXRoIGVhY2ggc2xpY2Ugd2hpbGUgcmV0YWluaW5nIHRoZSB2YWx1ZXMgb2YgdGhlIHJl
bWFpbmluZyBiaXRzLCBhcyB0aGV5IHdlcmUgcHJpb3IgdG8gdGhlIExpbnV4IGNvbmZpZ3VyYXRp
b24uDQoNClRoYW5rcywNCkF0dWwNCg==
