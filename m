Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC47D4968
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjJXIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjJXIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:09:40 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68621735
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:09:28 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39O7tRJv003528;
        Tue, 24 Oct 2023 10:09:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from
        :to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        STMicroelectronics; bh=FZG/jXhqP3EP9pX1HfSdTtCiH7gxjykocELDktXgk
        sE=; b=JmalHcPjW7cjsegxwOe5rNk71co1wFNn5u9nivthSY6RbyI5fQRHEzg79
        2TKLK1f9Ieel2uRqtgIga2LCJmWeW1NnLUfwcoBSdAsvRc9HjOkfcqi0wBHORZ27
        NKb4WDtgw4Rg3wWU/cehttvQ5/8U+LcKl5hl52mKp1MyBKeJ+/b/JY6gQltKZcdy
        6nRjDX9XnMT0mn7oc54rhHOsUSIXVOcznP5dvQ3E2wJAvhQJr6CKuFwhzWwEtqub
        q68kD2NRCm2Z2GRZN/Yuj8V026+ectJH2Dg5YNYcKUe050n7WaIAFqf9y3b4DBGQ
        rFEXZ/XXMSutm0ZXESQkt0RbPh1BA==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tv5ywkerr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 10:09:19 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy3LZlOtedlmsoU8BMzk0M0j0c1DbpuXV7Z1aukFYZ/MaOB5jiN/gTc1+fm5hxyhoU/walAYr8P+qB6d5XCI0odkny7HotwarieJU8+R1/VJ07HpV06B6YDHfWWxb3FP/ISQreCXq4HrdCie1e81uSP46hWzatC2JhAYIFlavGAFX+v2Vn0EomGwIvgGdTn5k5GIMU9rtI3Bo4pklH3qH7RPFiBePqaIc3unydhm4ACWqS5HwuwxCKnql80bRuYWERsSfK1CrOLXD5Nb+k8fKxkovinhZ+BZ6ZtqwGAgAksW2aO13Pc8FogvFzFXhr91ngHTkESkW/pINl4LRFXJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZG/jXhqP3EP9pX1HfSdTtCiH7gxjykocELDktXgksE=;
 b=VE3fedxO95xP8jUZtwoJlOtmZaxDL+8SLlQb+DTLpZD/6uke4OeysgyoweFE4dDbfvYn9rf41hHApiGVLOSZNb71nQJNPfLeiDNJtuVyHdBqxF+JvkE5WvjqezyjZtKJ+UUPkeoWR6QT0hlUMQeUsssPpmuG7cAFQ/BHX5HBgMhbWp3eYDdih0CRH7ll46EZ41ygtjLdiGPMooEWfLEXra615VDh6bfhJL/rAJKGqMFFgz3J8tuuhIoy0xkrHz6RMB34hbJe6yXEhvWnmJttFqBUH1S1DL5UjNv53EiJ7mWDGdBZqWfttmRpQbZCARegl4sMD83iVJfMcxJj5a6P6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:158::12)
 by AS8PR10MB5808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:523::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 08:09:16 +0000
Received: from PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3dc1:6c90:973a:a056]) by PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3dc1:6c90:973a:a056%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 08:09:16 +0000
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
To:     Divin Raj <divin.raj@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiang Xiao <xiaoxiang@xiaomi.com>,
        "wendy.liang@xilinx.com" <wendy.liang@xilinx.com>,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        Tanmay Shah <tanmays@xilinx.com>
CC:     "Diego.Sueiro@arm.com" <Diego.Sueiro@arm.com>,
        "Rahul.Singh@arm.com" <Rahul.Singh@arm.com>
Subject: RE: [PATCH 0/3] Enhance virtio rpmsg bus driver buffer allocation
Thread-Topic: [PATCH 0/3] Enhance virtio rpmsg bus driver buffer allocation
Thread-Index: AQHaBZ3fFFLNMEEnaUGHPB+ziXQxUbBYjNrQ
Date:   Tue, 24 Oct 2023 08:09:15 +0000
Message-ID: <PAXPR10MB471839BB322991A4788E6CD4F1DFA@PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM>
References: <1af16ff8-5706-45e5-9737-05da39957c95@arm.com>
In-Reply-To: <1af16ff8-5706-45e5-9737-05da39957c95@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2023-10-24T08:09:14Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=d676a2f2-fe0b-4453-83bd-f04aa6505f81;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4718:EE_|AS8PR10MB5808:EE_
x-ms-office365-filtering-correlation-id: 94968dd4-4c2a-44ed-c885-08dbd468840b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kFcV4fSqEwGWOlW0fGAgipU1J8+vTlNIYxALSImGBDIGY9eJGLBEdHm8fTwtHrW2INlx3+bn5N/0/tlZfUauJsq8fz8dDlZ96SfkbJz3nDS5wQQbh1UgXC30QtZ4OyLT0SLokQAQ1G5AuIFd9x9g40l/N/3AfKCGBpLSb4CsraFPezMdz2Bi2RDY263Gqx8411cry81rgUxrIMJIddHfRAby3J/gQpMN644VNA9nGTTdXjO1O4kUIjMnDrlDEwm/UZ6vTNgMp7a9FMITns6eASiMhocRPmwslLo0n/IvWS3pApLDEVUgLYDJTCEZKayxnWjTceL+KyubyLh4a7uaH2KVVSFUTReIPFeCVWHk0ryqCjpBKa0vMK5vrQ7kNQUs9+0srWTN38Fpx4rmQhRvbJ43EHeC3dFd5zIngMdkVg4NXiHFuzN73kNHysUB7i3LepOe40Aq4pTNDEFseM+m0GzZk3ZHjxlBu/5J/fgz/INlx+YBBmNpf4iLDABVjlwoMMt/CpIjYfBQWttNR4/rVzFJ3P46879GLyGUmUJaBOJUJwnstGA7Bezi2ynpu6Y64w+S9x1SO4Fx+lETr1+WLYmIdhcsdl2nFrIctoxCfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(38070700009)(6506007)(2906002)(38100700002)(7416002)(41300700001)(86362001)(52536014)(7696005)(26005)(4326008)(122000001)(83380400001)(8676002)(9686003)(66556008)(33656002)(8936002)(71200400001)(316002)(5660300002)(478600001)(76116006)(66946007)(110136005)(64756008)(66446008)(966005)(66476007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3Q3YUVMSS9FUldFek5BVDY3NWdKbHRpSFBXOG9zOUJCSGZmRit2YTUwN0FH?=
 =?utf-8?B?UHhNODZSUmNWbmd1am82RndCUmdVcmpFS3pFS0lHTjFUYTJFa1RCU0I3MEMw?=
 =?utf-8?B?bld1QTlFc3NoejNQZUxMa05YQlQzOUJFT3MvYkJRQmRMdllZRXkvVGlvU0ky?=
 =?utf-8?B?emFLaVNIZzdxRlhvMUNKZ20ycXIxVVNRcXBrdHo2STNacFdaU2ZEVi9xUzY4?=
 =?utf-8?B?bXBXRjN5YzkzajMwWmhvL0NHSms5QURFN2hIZzN5WU5xeWZZRlJHaEE2UnJm?=
 =?utf-8?B?M0xSdy85T1RldjNseGRuQ0ErKzkxcER2UlJQZXlxdVdOSGZsaGZYL0hTUkVC?=
 =?utf-8?B?eUpnM3BLdWdMZFl0dzhpU3NsZyt2SEVCRnhmTGFoZU1YMjZud082Z294dDZp?=
 =?utf-8?B?K2QrYzRFNTRLYXJyNmlKNXo1V3ZRckhxZHN1dUl5czlqWjJVNEQ2NlJGNDlE?=
 =?utf-8?B?bE1RZmtVTjFZZzl3OUVmcXNIT0RQeEtRQ0U2QVVGMUpCS29STlFPdVp3OENv?=
 =?utf-8?B?d0NmQ2lqWG54c3BaeHRhN0NYV2MwdjJrdlg1WWprRmhSaC9GSFpIdTFBZjhF?=
 =?utf-8?B?bk13clB5VUt4MEp6NytwRDROcDJFZldHLy9MVXV3cFluQ2pZYXpGc2hFdFdz?=
 =?utf-8?B?VWV4QjdYT1A2dGE1MUVDOU9wZStnVWJTZUtMNmlvbUtiNGlqNHJ1bFJVSWps?=
 =?utf-8?B?ZWVySlJUWHVOTmZhcCtqaVBSVGFSUDdSeUpWOTVQcFNoakl5TkpKR0kyV04r?=
 =?utf-8?B?cGFocnRhSCtzbHU0eUdSdUt3RHpYRGMvdnpOOW52Ykp4cytSWmpJTWRzd0FP?=
 =?utf-8?B?RU93TTJvL2NZeXhDR0hVNW5EdHdPWXVFcjd6VWJ4YjFMV1ZqNHBDRlhvOUR6?=
 =?utf-8?B?VmZKZUFKdHZ1dFFSck5DbUFwaTBiaHIxYk9WdzBLaGhaZWhvYnBlY3FZZkdk?=
 =?utf-8?B?N25hSElTUHBTeDBDelRSWWNKWEY2VjlxdDdFNGIrT0U4RVcyeHRjSkxkTXBF?=
 =?utf-8?B?S1Q4aXcrVUwxM2dxbXdNR0F0dUcyaklzdFNaTXNYamZ2TmNJVGxHcG12N25M?=
 =?utf-8?B?dWtjN2hOMmd0YnNjL1hJdUpQbmhld1oxMUpwOG1aTTJGRWUrNGl2YVhqMHFI?=
 =?utf-8?B?OWp4UWRBYzlhN1RMWE1uaGdsS3cvQzdKMTlOTkUwd2pQOTE1Y1pONEdrWkpo?=
 =?utf-8?B?OXZtV05mcEUzVmI5VHdUVUpMNFNteVkwc282MGQxMWlhSHRqaElaN3dmUERk?=
 =?utf-8?B?YnJLTjhJdldZNnBRQ3dJYXZuSm1RZVdCS0EvYUpMY0J1Z1Q3TTZ0ZTROZlNw?=
 =?utf-8?B?UitMblRGK3Iva0wva1ZxbXRJcE1nZlp4N0MzbEpUUjlKeTU4K0FkRXg4MDRo?=
 =?utf-8?B?TlBlVnk4Nk9STWswMFQwR1lLWVplWm8wTUN0YVVtVGUwRjZrampqaUpDaHVu?=
 =?utf-8?B?eEtWUmFkTmRma0h2ODlCRWF1UnJUOEdxLzJraXgrYkh4UWZTTmM1b0ltL3FQ?=
 =?utf-8?B?KzlWRVlrZ2s0TCtIN1lYWHZ4ZnhZOVV4TTFoQW5sOHNvTkpiMmVYc3BDeG5p?=
 =?utf-8?B?aWdleGk0NDZzVmYzenJBQ2h4dVR4cWpQNHJvdExPeUtZclpqNnlESlBMOFpH?=
 =?utf-8?B?V1lBQm9ObVNLM1JnNzcxZGpnbzVDcVNiZjBiQWpoQnkwUDhJNTFVMStjc1RB?=
 =?utf-8?B?ZjBPVlRkbTFCYmtGdzNCdEx1WmRUM1Noc0liRWJJeGFha3ZXYitDc2lsRFQw?=
 =?utf-8?B?a2RhSnhua0dWNHE0MnIvQWtVOHJqK3p5N24wYjNCWDIzM2hvb1VNc3pZNkxL?=
 =?utf-8?B?b25CT1Vsay9BMXhWQUNXNDhZWERUdkZyL0t3cUpQRVBzVUZLTW0xNmtUOU05?=
 =?utf-8?B?TGtMV0IwdUtPRGhiTlB2R1FoandEUS9veE1LUHI3d3Vrd1ZTT2FMQTVkUCtj?=
 =?utf-8?B?WHZxTjRFM0xsNHk1UTZXMXRwc0Q2dlRSNTBLRDRiNTZwY3J1Y3p3UktTMDFD?=
 =?utf-8?B?a2xlT2Ywb2JUYlBnMGF3a1BTbWROTGtkbWpMbThPdDcwN1VNSFFDRzZvbG45?=
 =?utf-8?B?SVZUSERieDhBWWpsMTd2cWJkbE9ua0tORHpBTmNLYThBcEMwa0lPdUV1MFBI?=
 =?utf-8?Q?dyY22NIcNMoNSN5kfWYLZCSLj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94968dd4-4c2a-44ed-c885-08dbd468840b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 08:09:15.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AhECir9F9A0VAp0JiXHMfZKTe7S078V5O8nubQCOUbgjE5ddPWfF+wLEd8bMDnn9zVyqOkCHwz28OuxQA2jcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5808
X-Proofpoint-ORIG-GUID: _dEYBB61u3Kgj2s5psL1r_MCrTmEaHQ1
X-Proofpoint-GUID: _dEYBB61u3Kgj2s5psL1r_MCrTmEaHQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=630 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310240068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gRGl2aW4sDQoNClRoaXMgZGV2ZWxvcG1lbnQgaXMgY3VycmVudGx5IG9uIGhvbGQsIGJ1
dCBzZXZlcmFsIHBlb3BsZSBzZWVtIGludGVyZXN0ZWQgaW4gaXQuDQpJIHN1Z2dlc3QgdGhhdCB5
b3UgcmVwbHkgZGlyZWN0bHkgdG8gdGhlIGVtYWlsIHRocmVhZCB0byBjb250aW51ZSB0aGUgZGlz
Y3Vzc2lvbiBhbmQgYWRkcmVzcyB0aGUgcmVtb3RlcHJvYyBtYWlsaW5nIGxpc3QNCg0KUmVnYXJk
cywNCkFybmF1ZA0KDQo+RnJvbTogRGl2aW4gUmFqIDxkaXZpbi5yYWpAYXJtLmNvbT4gDQo+U2Vu
dDogTW9uZGF5LCBPY3RvYmVyIDIzLCAyMDIzIDEyOjQ0IFBNDQo+VG86IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFhpYW5nIFhpYW8gPHhpYW94aWFuZ0B4aWFvbWkuY29tPjsgd2VuZHku
bGlhbmdAeGlsaW54LmNvbTsgT2hhZCBCZW4gQ29oZW4gPG9oYWRAd2l6ZXJ5LmNvbT47IEJqb3Ju
IEFuZGVyc3NvbiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+OyBBcm5hdWQgPlBPVUxJUVVF
TiA8YXJuYXVkLnBvdWxpcXVlbkBzdC5jb20+OyB4aWFuZyB4aWFvIDx4aWFveGlhbmc3ODEyMTZA
Z21haWwuY29tPg0KPkNjOiBEaWVnby5TdWVpcm9AYXJtLmNvbTsgUmFodWwuU2luZ2hAYXJtLmNv
bQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBFbmhhbmNlIHZpcnRpbyBycG1zZyBidXMgZHJp
dmVyIGJ1ZmZlciBhbGxvY2F0aW9uDQoNCj5IZWxsbyBhbGwsIA0KPkkgYW0gcmVhY2hpbmcgb3V0
IHdpdGggcmVmZXJlbmNlIHRvIHRoZSBwYXRjaCBkaXNjdXNzZWQgaGVyZTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL0NBSDJDZmItc3YzU0FMOGJjY3pDLURjM19yNThNWVpDUzdzN3pHdG4x
UWZvM21tQnFWZ0BtYWlsLmdtYWlsLmNvbS8NCj5JJ3ZlIGJlZW4ga2Vlbmx5IGZvbGxvd2luZyB0
aGUgZGV2ZWxvcG1lbnRzIGFyb3VuZCBlbmhhbmNpbmcgYnVmZmVyIGFsbG9jYXRpb24gc3RyYXRl
Z2llcywgZXNwZWNpYWxseSB0aG9zZSBmb2N1c2VkIG9uIGR5bmFtaWMgYnVmZmVyIHNpemluZyBh
bmQgdGhlIGNvbnNpZGVyYXRpb25zIGZvciBzeXN0ZW1zIHVuZGVyIHZhcnlpbmcgbWVtb3J5ID5j
b25zdHJhaW50cy4gVGhpcyB3b3JrIGlzIGhpZ2hseSByZWxldmFudCB0byBzZXZlcmFsIHByb2pl
Y3RzIEkgYW0gaW52b2x2ZWQgaW4sIGFuZCBJIGFtIHF1aXRlIGludGVyZXN0ZWQgaW4gaXRzIHBy
b2dyZXNzaW9uLiBNYXkgSSBraW5kbHkgcmVxdWVzdCBhbiB1cGRhdGUgb24gdGhlIGN1cnJlbnQg
cGhhc2Ugb2YgdGhlc2UgaW5pdGlhdGl2ZXM/ID5BZGRpdGlvbmFsbHksIEkgYW0gZWFnZXIgdG8g
a25vdyBpZiB0aGVyZSB3b3VsZCBiZSBhbiBvcHBvcnR1bml0eSBmb3IgbWUgdG8gY29udHJpYnV0
ZSB0byBlbmhhbmNpbmcgdGhlIHBhdGNoLCBwb3NzaWJseSBieSB3b3JraW5nIG9uIGltcHJvdmVt
ZW50cyBvciBhc3Npc3RpbmcgaW4gdmVyaWZpY2F0aW9uIHByb2Nlc3Nlcy4NCj5GdXJ0aGVybW9y
ZSwgaWYgdGhlcmUgYXJlIGFueSBjb25kZW5zZWQgcmVzb3VyY2VzLCBzdW1tYXJpZXMsIG9yIHNw
ZWNpZmljIHRocmVhZHMgdGhhdCBlbmNhcHN1bGF0ZSByZWNlbnQgYWR2YW5jZW1lbnRzIG9yIGRp
c2N1c3Npb25zIG9uIHRoaXMgdG9waWMsIEkgd291bGQgYmUgZ3JhdGVmdWwgdG8gcmVjZWl2ZSBk
aXJlY3Rpb25zIHRvIHRoZW0uDQo+SSBhcHByZWNpYXRlIGV2ZXJ5b25lJ3MgZGVkaWNhdGVkIGVm
Zm9ydHMgYW5kIGludmFsdWFibGUgY29udHJpYnV0aW9ucyB0byB0aGlzIGFyZWEgb2YgZGV2ZWxv
cG1lbnQuIExvb2tpbmcgZm9yd2FyZCB0byB0aGUgdXBkYXRlcy4NCj5SZWdhcmRzIERpdmluIA0K
PklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0
YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgPmRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkg
b3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRo
ZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuIA0KDQpTVCBSZXN0cmljdGVk
DQo=
