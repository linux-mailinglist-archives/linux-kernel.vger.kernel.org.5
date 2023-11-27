Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CF27F9FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjK0Ml7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjK0Ml4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:41:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607F18A;
        Mon, 27 Nov 2023 04:42:02 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARA2Dbh012315;
        Mon, 27 Nov 2023 12:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=zSrKjavtzafXJWgrRhuTBqhCfecvAtl45Y2RTvDEEvc=;
 b=IxpdAG3NdLxElFVnckwKEoD3Nza2Ij7+X8G8A4Nd+mboVRsTFAkSpsBRQF9YGtHFcakX
 mqe9k5DqWrjt+/5GY9uclhjhRuqnv727rigzbi9TLyvfWX5b4nW7SNn06loWxPxEjb2y
 MVg98XysKBS0+NZtVr5+Eu9vc4WBG9X5iSfat2hndFnzdB7697nl1ccc9TVyZkkjTIMA
 t4WpdkRG7PRTPrXgjUtw5k5yQhA9Uu1TNZnTRxZozzhU6UWfBIOf3xDVMa0XqfqV2yQ3
 TmKcRcixkQlmHaR3mKK21gegGcdqVSWicEX2I8dXHNoKUEddkYSYyhsS85RBBHhKr1Js OQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9adm4ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu19Vf8+IdylPF6yPZoSVfag+F+D89vlbzt4FOK3ncR0qH6FnVfvzID2AvaK1rBk6u+QUaMaWD+YLJQTJm4gJQ/iygk2xbw2vYJxNE9bxVFpgUtXtz7osxFQwqVVJUE3xrRo1ao34042m+GEGGczPedDUGPq7K29y2wGQrlZ4J3p0R5AbaFNJkdLDv6lDGegkzN7MUwwFlWtzPR2ZJ2IdlwBZ8OgyiY+cb+H4nfg7SfSfC4Ks2w6fF+wGYkigJEDmmPLBK2UiY5/VY7v762R4TWP8drLt+Nmh0Yr5eGlOw12HYWZ2bj1ePJoQv8vZ/EJ+rZZqv4ej3hwEPk7p10cIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSrKjavtzafXJWgrRhuTBqhCfecvAtl45Y2RTvDEEvc=;
 b=R0pViDiydXP3HKD5FWwBOrH9xgtU+oRIVr5UZ2KDbwlXZYPRjThEUBXeo7J2b4FCHpLgC70MCJuTG71fEzUk6QXus0nRBfn4gIUhE1rFjEdOOUS+94TYGD+Ca6HT68mMNtFM23b7H4PDQOrGfm6blAEtBIQBt8WxDqCrW4QVwzqT6A5Iow/On48Fcshnk34RKHsdT4z+0AeRLtnhhqvyTNiFf+CZPIB3Dl6xkNcbfx+TYDwXN1t7W8HtZrwI6yRiThKqTKAFWaix5N+sgekgDlQE7Kpc5k1jrri7kjkZcm7j9rlP7MJKdMoDcI+BNff4BUThJB1znxm3W340sUmgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB7758.namprd02.prod.outlook.com (2603:10b6:a03:320::24)
 by PH0PR02MB7702.namprd02.prod.outlook.com (2603:10b6:510:56::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 12:41:55 +0000
Received: from SJ0PR02MB7758.namprd02.prod.outlook.com
 ([fe80::f5c0:572f:81cd:dc40]) by SJ0PR02MB7758.namprd02.prod.outlook.com
 ([fe80::f5c0:572f:81cd:dc40%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 12:41:55 +0000
From:   Viken Dadhaniya <vdadhani@qti.qualcomm.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-sm@vger.kernel.org" <linux-arm-sm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Chandana Kishori Chiluveru (QUIC)" <quic_cchiluve@quicinc.com>,
        "quic_dkammath@quicinc.com" <quic_dkammath@quicinc.com>
Subject: RE: [PATCH 1/1] arm64: dts: qcom: sc7280: add slimbus DT node
Thread-Topic: [PATCH 1/1] arm64: dts: qcom: sc7280: add slimbus DT node
Thread-Index: AQHaGLwveN3HGJSDXUe1mHWAERd0LbCGzz0AgAdcsDA=
Date:   Mon, 27 Nov 2023 12:41:55 +0000
Message-ID: <SJ0PR02MB7758DFA250A0EB0BE8189C1AEBBDA@SJ0PR02MB7758.namprd02.prod.outlook.com>
References: <20231116183909.32179-1-quic_vdadhani@quicinc.com>
 <35ca2ef2-7613-4ddb-b863-2e429337fee3@linaro.org>
In-Reply-To: <35ca2ef2-7613-4ddb-b863-2e429337fee3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB7758:EE_|PH0PR02MB7702:EE_
x-ms-office365-filtering-correlation-id: 97d5ac0d-20d7-4e98-a83e-08dbef463cef
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkWvcbAKEQoE7ByWGcWNQzbi9SZC100DjGL/KOMS4MRpoj6c32Kbpn07oTcaFwGDntAF0Ub2/clRCq1P7IIE8raJkfj513PG2Oj1Du7Y2QZEXdX1ZoaBoCS2SeAiqizyNY444idYAmIVKHnKI+3NNrhZKy4SKDCln6YpB9pS7v3xY5/B/Dyr4p+E9XGlvHM1T45rbSUCxRC/3ZuvSVlyhJXiKi9wRWuG0Nd74BuiRZY9nUaG2F65/qEqQEQYR8JlfUvX0zlLj8sRNANcdzyEEFkkcLrbj1kiSK7TYiaAua1w9KjTGUpNKuXH/XHTw8toGE1vYyXYBt6sxbboRCBK6XpcOCsvhuRGhUcuWWNH2Nw/SHkFTnakvqM/En50VRg+yxx3+0AE8IR940s0qvRb0e5UQ8mkFqhePYJ6CeAw8rYEX9tjvlKXdI8pzBvAyHZNHRwRTHggPG8Io3Kz6G4+z7qAQSnxZLV1al3OBCPqNSa5eK/J4evyfHmXMCk0FDGhD4tffEoJl9FdxStpMgEdT0seQQ9YK5WPAms/T3GR+AuxV8MNATXVP13oFu8ncO8vT8msPYIVW0UG74hiCuZDtBdizcJi4MbiRsPlTYUPo7dLlmjfLgjUstSZUmxhv2WRHwiJpJWANsvzOCYM2+IUZ8u6BUJw7HvhXh7db3i65VY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7758.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(316002)(53546011)(9686003)(71200400001)(86362001)(6506007)(7696005)(26005)(107886003)(110136005)(76116006)(33656002)(478600001)(83380400001)(122000001)(38100700002)(66476007)(66946007)(66556008)(38070700009)(66446008)(64756008)(54906003)(5660300002)(2906002)(55016003)(41300700001)(4326008)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0w2SXY0R1ZzS1A4c2Q2MXdFVmo3QUhhdyszOVRoRHdqRkk2dWJQZVg0WHpH?=
 =?utf-8?B?SXhaaEhNYXA2YzVyT2NKdkpkYTBVQ251eHNwUWt4OWdrM0pnc1ZRTWZHWVpK?=
 =?utf-8?B?emYyK0wyTEdEUlU0VFozSWR2NWNuUGhlUmlhTEZnMnE1VkVsc1ZLcnpXSW1Z?=
 =?utf-8?B?QU5hUlNKSmQ0VFB2TSt5QllmdXRUbnMxT1ZVR2wzZWUxMXRmbGFXNlJuRjJm?=
 =?utf-8?B?YW1Mbmk0VkxzaW53dVZXMlU4UWdRRXRRQmgzQ0w1OGFjTnJ5aSt0Vk15U3ZE?=
 =?utf-8?B?Q2VtdldmdzRyQUVpOTNJZmxrSjB0ZHRIUzZLNG9vUDYrWElTU2hUTFViYTF0?=
 =?utf-8?B?S2N6UkxNTWtlSnFKenI1VytSSFYvRGVJTDBtUWxnSGlZTlNlaTZONC9mekdl?=
 =?utf-8?B?SE8xUVlCR2VKL0IydVc2dXZ1U01rKzh0c0o4aytWaTFhZk4vRE4rY0RLUGlL?=
 =?utf-8?B?R1pXaWxCaUxvM1FIYUw0bVVGc1RCNzR6ZEFkR01EaGVXa3dna3JqMDg1bGd0?=
 =?utf-8?B?NEJwZDBaQXlVOThjNjduMDdxNG1tL0NnbnNWK1BHWnp1MFJnWE1TWTJqSURh?=
 =?utf-8?B?WmZub25RWlNLeUVjMlRWSFZzeFRIeVN4WW8wdDhMNFpxeTREdnd2d1BVRTNN?=
 =?utf-8?B?VzdqckMwajFZWUlyOHQ2MndpY0RsUmU3T0p5Qy8zeUp0ZDlIaWZsbHlJNU8r?=
 =?utf-8?B?RDFJWksrckFYbjlNY0tNaGN1czR5MDhTNVUxdWF3RnZrT0VJaUVFYWZPSnhh?=
 =?utf-8?B?VzFTUUNyNlRIUmZ0ejhJOXZsc1F0Qm5jcWxPQXdNT0RlMXlpeGZ3VHQ5MXBV?=
 =?utf-8?B?ZnlLbmZZeEI3QzJCb0VobW9HUmM2c3hDMXpDUnluTlFiOWtXWVlTblpXa1By?=
 =?utf-8?B?amtHbEhOaXFMaCtiSFNwRmphVGdnamhRbXQ4cEZ1d3VOQzBmR1BmeDBzVXVp?=
 =?utf-8?B?NVk2L1RrOGlSRGErTGQvQVgrdHd2bUYwZXdtMW9sYmtIS09sWjZJdFJuSVg3?=
 =?utf-8?B?S2dXY0JFZmNiSDNEcExodjJqcDNIeVJkcEw5VVV6SEYvNVM4QnlJRWVlWVUx?=
 =?utf-8?B?eS82bXQrYS82UzRRbTcycG02Yis1Vy9sYVNyWHlUZGRKcGNUeUw2TUlxdlhG?=
 =?utf-8?B?dno0VkIrVm80blYzbXdMMEQ5TGpMQWd3UGo0djRmZ1loQkg2R2tlOU1OZDFP?=
 =?utf-8?B?bktmTExDbW9tTEk0T25UT3Q5VUovbWVacWVwR1ZoVjdiVUdiSDlVaUNDM0d4?=
 =?utf-8?B?OC9RTmF6TlozRTNCYURSRnZ3Vk5NZHBNelR1WVdJbmJ3M3Q1dmRCOHFra1Jj?=
 =?utf-8?B?N1Bmc2V1MmhxK1JuMitFNTFHT2NCbG5tQnJncHNWdk91VW44SjBtVURrbVA2?=
 =?utf-8?B?RFZmLzhnaEJrQkNmMEp1MFFFbVU1L3Q5d1VVZnhXcW96NjJaeXdhVEc1bnRL?=
 =?utf-8?B?QXhERFVBL091RUc2cDRSd2h5VWZkVVFLZFFkMGhWMW15UTFRdGVIY0JrWDZU?=
 =?utf-8?B?YXZPcW9EbmlsUU9MM2YyWm1qMDE4bHVTRXJBZVMra3k2WkNleEU4cnU5OW12?=
 =?utf-8?B?MzFhS1lqWXd0c2FMZUEyV29CdCtCZ2o4aEpKM2VuMW93R29oSFV2c3ZDMHB1?=
 =?utf-8?B?OTdjeDVHbFBtQlVONzBxWnVickV2ZS9GY20rRDRLWkJDbWxTUEZBeE9hWE83?=
 =?utf-8?B?a29waEpWUXBIcDdiSmNXTW1udEo0ekF0MFNYN0t6OHVLKzArMGtjczVFZVBS?=
 =?utf-8?B?SXNDVC9STzRGOVVEZHNTUGQ2M010Rkh2V01qWnovcks5c3d5ZmZyczllcHJU?=
 =?utf-8?B?QXVrOUp0SzhiMVAvWFo2VlNqaFFQNXlmTlN3b0xaTEFBSnBVZ1FjMUpqMTZY?=
 =?utf-8?B?Y0ltTnliWTU2ekdzaGRsR1dsVkVPRUtxM09IQWI3MEhyc1pobHV4VEpGRXVr?=
 =?utf-8?B?SUZQOXhmci83MUdoYW81RjE3WEhmWkt1eUttbm42Y3B5V3RJZ0FjZjZmZjgx?=
 =?utf-8?B?TmlZMW5FeGN5dzhtbWx1U0EyWUxlY2RSZUZiSk5sLzZQVHZmRUVGbHBTaDdx?=
 =?utf-8?B?cnNQakJMTm4zN3hrcWltYVc4YlpWR2hqTEUrLzRsblZ1bXNIaXMzdGlkWmtl?=
 =?utf-8?Q?Ex9BYPPR5C2+d/icKKEm46AXy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pJVn8ytB+/vD5OWjH1dA2Dia8zBLnlLyPMAg4+tT7RdFTzDM4CNvuk+Juit5RaLjIU3ddRPdIwC6Wo/6sGnzZOX19pp2BV4HzrUmvqKT27nV4IKnIZFAxPKeC+lWH6s0D+F+eGP5M16qrBI50auumPcEnNk7aKhwnOLoi1Jsg5sj/9WfgZRacPYz1A4OJORlakI+mm6816Bhep79/NWe4cOoqbzv1n6oDLMhAvaB2JA2tp0D1oce3Gz2GdAOuZs1sazBfnoKD7LdavpQYw1sTfKqS3O4cHrmaucbtte9cwSnYMSomuh91RgEmsQxxM/FIdr1ioks5jkie1KEO7FAR0bPZl3rdj2m2cPa3EMi9ETnKlF/aUqdgI1u64sFovQtXyiM1kllWWvtbXiyF7D/p3+azrhdRfo3iB9BomCmSGYQ0rZtiDwg8qkXo2rmR/NO7a9IWE8+oxt7XjBDoh2XNp1IDlBPDDZGikFtIAz3NS/LhV87yoRt7mAmnRlzfsLpmvvIadepyCJvfuxdO8OmJfD+CPEXeuMGk07a/kuiHN6xRdmlwLf5RaOV+aNRXHpa/9iMNN82dnlHDXZA5E1z6D4nDmN46NkskPs/Pt+hldG9nBkrvnD8PWC3NGLEzAOlZQEq25HF6bYfx4dDsSbF6laC4R3RGVlHgNAX7fS5bdDcfAqckGpcH8CzSdzqqRG4+0ExwG6yOhmz0AV7p39V/yBwPRf3XXihykTscLoiJ3BeXiN/PnONMa5xFewzguFc63NNCryDwrRaqVZGlS2udEe6kNjg92I1AFsPoAbfgnQKn4FXz4jasCuzPD8ITfFnYR8YBgdDPthsCye2SbacDw==
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7758.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d5ac0d-20d7-4e98-a83e-08dbef463cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 12:41:55.1601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0f9r3aPRbdg8+NAxoLZzVLvrtEGEnkH/1RhhRdYnbATMSm7RQXnIz6eNTPQxpcozSiUmtoPSfpcdSI2KyyAi13RmWjwSX65P3srKwpf7MMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7702
X-Proofpoint-ORIG-GUID: 1NQB8Acc2xbSQZK_dFvBUQpiIIZJ3Pza
X-Proofpoint-GUID: 1NQB8Acc2xbSQZK_dFvBUQpiIIZJ3Pza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29ucmFkIER5YmNpbyA8
a29ucmFkLmR5YmNpb0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjMs
IDIwMjMgMTo0MyBBTQ0KPiBUbzogVmlrZW4gRGFkaGFuaXlhIChRVUlDKSA8cXVpY192ZGFkaGFu
aUBxdWljaW5jLmNvbT47DQo+IGFuZGVyc3NvbkBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5v
cmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgbGludXgtYXJtLXNtQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHZuaXZhcnRoQHF1
aWNpbmMuY29tOyBtc2F2YWxpeUBxdWljaW5jLmNvbTsgdnRhbnVrdUBxdWljaW5jLmNvbTsNCj4g
Y2NoaWx1dmVAcXVpY2luYy5jb207IGRrYW1tYXRoQHF1aWNpbmMuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS8xXSBhcm02NDogZHRzOiBxY29tOiBzYzcyODA6IGFkZCBzbGltYnVzIERUIG5v
ZGUNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2Yg
UXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mDQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywg
YW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gT24gMTEvMTYvMjMgMTk6MzksIFZpa2Vu
IERhZGhhbml5YSB3cm90ZToNCj4gPiBBZGQgc2xpbWJ1cyBEVCBub2RlIHRvIGVuYWJsZSBzbGlt
YnVzIHVzZWNhc2Ugb24gQmx1ZXRvb3RoIGZvciBhdWRpbw0KPiA+IHN0cmVhbWluZyBhbmQgcGxh
eWJhY2suDQo+IEhvdyBjYW4gSSB0ZXN0IHRoaXM/DQoNCldlIGNhbiB1c2UgUkIzIGJvYXJkIGFu
ZCB2YWxpZGF0ZSBwbGF5YmFjayBvdmVyIEJULg0KDQo+IA0KPiA+DQo+ID4gQmFzZWQgb24gcmVx
dWlyZW1lbnQsIGNsaWVudCB0ZWFtIGNhbiBlbmFibGUgc2xpbWJ1cyBub2RlIG9uIHRhcmdldA0K
PiA+IHNwZWNpZmljIGR0IGZpbGUuDQo+IFlvdSBjYW4gZXZlbiBlbmFibGUgaXQgaWYgeW91J3Jl
IG5vdCBwYXJ0IG9mIHRoZSBjbGllbnQgdGVhbSENCj4gVGhpcyBwYXJhZ3JhcGggaXMgYSBiaXQg
b2J2aW91cyBmb3Igd2hhdCBpdCBkZXNjcmliZXMNCg0KVXBkYXRlZCBjb21taXQgbXNnIGFuZCB1
cGxvYWRlZCB2Mi4NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpa2VuIERhZGhhbml5
YSA8cXVpY192ZGFkaGFuaUBxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvcWNvbS9zYzcyODAuZHRzaSB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC5kdHNpDQo+ID4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLmR0c2kNCj4gPiBpbmRleCAwNGJmODViMDM5OWEuLmZi
YTM1MjUwNGYzZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M3
MjgwLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLmR0c2kN
Cj4gPiBAQCAtMjUyOCw2ICsyNTI4LDMxIEBADQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gICAgICAgICAgICAgICB9Ow0KPiA+DQo+ID4gKyAgICAg
ICAgICAgICBzbGltYmFtOiBkbWEtY29udHJvbGxlckAzYTg0MDAwIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJxY29tLGJhbS12MS43LjAiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MDNhODQwMDAgMHgwIDB4MjAwMDA+Ow0KPiAweDAg
LT4gMCB0byBiZSBjb25zaXN0ZW50IHdpdGggb3RoZXIgbm9kZXMNCg0KRG9uZS4NCg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgI2RtYS1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2NCBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gaW50ZXJydXB0cyBzaG91bGQgY29tZSBhZnRlciByZWcNCg0KRG9uZS4NCg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgcWNvbSxjb250cm9sbGVkLXJlbW90ZWx5Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBudW0tY2hhbm5lbHMgID0gPDMxPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgcWNvbSxlZSA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcWNv
bSxudW0tZWVzID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpb21tdXMgPSA8JmFw
cHNfc21tdSAweDE4MjYgMHgwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgc2xpbV9tc206IHNsaW0tbmdkQDNhYzAwMDAgew0KPiBzbGltX21zbSAtPiBzbGltDQoNCkRv
bmUuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicWNvbSxz
bGltLW5nZC12MS41LjAiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4
MDNhYzAwMDAgMHgwIDB4MmMwMDA+Ow0KPiBkaXR0bw0KDQpEb25lLg0KDQo+IA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+IHRoZXNlIHR3byBwcm9wZXJ0aWVzIHNob3Vs
ZCBnbyBiZWZvcmUgdGhlIHN0YXR1cyBwcm9wZXJ0eQ0KDQpEb25lLg0KDQo+IA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTYzIElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBkbWFzID0gPCZzbGltYmFtIDM+LCA8
JnNsaW1iYW0gND47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGRtYS1uYW1lcyA9ICJyeCIs
ICJ0eCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlvbW11cyA9IDwmYXBwc19zbW11IDB4
MTgyNiAweDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiA+ICsgICAgICAgICAgICAgfTsNCj4gS29ucmFkDQo=
