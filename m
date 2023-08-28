Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8478A58A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjH1GMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjH1GLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:11:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67887122;
        Sun, 27 Aug 2023 23:11:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S58iss008619;
        Mon, 28 Aug 2023 06:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=5EnDIpD58MQjb8GmShKqGpjcAAtxTc/UiNVzu6MCc7Q=;
 b=TZl5mZgS/59JuK2wL+JD4yWec7V791iQw4oWkZoFDMX/y8IO52FVzq5HquxikJ1gVKgF
 hnOYp/N/Zuq+FxyerOZlM1mI1XI6fFxoCBsPGGoye0Lep44qJ5WxIrWgG12QBDD6qiCJ
 prB9oj7FMeTClFzuqXD3kaO+iHpdWuliG5vXyjQn340TXihZTw1zMD9IZ1TZy6G14N6l
 cELM94Pn/Uqgk5P5uCy+52AI1E5auayUtR9oLnBwdp4nhFnpWDkxI++C5i4J3rsSPQmQ
 lf0SiAfFyEuR2AStaS1pbFPsYRiBx/4/VWyOmwt+eXYiuV+c+Bc5j5KGllOA9j80QVIU 4g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqapfjtvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNqNwmwHP/zbR3ftn/LzZ9b/5fqpxpQ7U+CkikFXX69RTqx9EiX1lAG/xY5juvd1KU0NRumlSUl6++A1sw9/sex92NfNuzx2fiqeSY/n1IXQ7mXotK7QW2NrcykJj/7ZvsBqo7e4HaKgrh/LS4r/mgg81M5bwgR+wDDGmRIYUsRRWS4cHvoulMoeP6vvHfgk4sx40+FV0tsfAxiVIChCjMx3VGchsSq2PTxZ2o4va0YBHdDrgn2bN3u54j5vFFI+K8I9rnJzC1lxr1WzaLNy9Z+m8nWuYqXzgFUnvIqDjkHSTgFoulO0upbPjZepwJvSh3NIYskrIwOed78dOJ4I+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EnDIpD58MQjb8GmShKqGpjcAAtxTc/UiNVzu6MCc7Q=;
 b=HIaU0ynRAqG0WWJDXw4wJwbmpN1KtCAv42GeRgSSjxlS9ZXdc1UFLgx0fQIG/QKkzN/zZNbM0n7EehkRBuerbOW/WPE5uAqXDgThF28Oz2VJ+WtCXvhcLq/Xtiwp8ORTgN2i77RH7gYMivdcU8GFKxCF04hCd4ZLWLgLOj2NSgGyB9GCDNOLvNd1+sk2md0AgX07IBDrAb9wLZG5aAElEj28jB7/d3csOb3w0QhdLMuJm6gW6HqnRNhp16MoXKxg+6IjsHXzuz6d7ykUz+nlBQRQSt6ZwRAuRiLl11HMhnhbMiAwecP7dOx6LJfLLzNcXwbqIxuEwoZIoJVOi/Wm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BYAPR02MB4839.namprd02.prod.outlook.com (2603:10b6:a03:51::18)
 by DS7PR02MB9580.namprd02.prod.outlook.com (2603:10b6:8:e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:11:35 +0000
Received: from BYAPR02MB4839.namprd02.prod.outlook.com
 ([fe80::3f10:e59:1021:6558]) by BYAPR02MB4839.namprd02.prod.outlook.com
 ([fe80::3f10:e59:1021:6558%5]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:11:35 +0000
From:   Rocky Liao <rjliao@qti.qualcomm.com>
To:     "Rocky Liao (QUIC)" <quic_rjliao@quicinc.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [PATCH v1] Bluetooth: btusb: add shutdown function for QCA6174
Thread-Topic: [PATCH v1] Bluetooth: btusb: add shutdown function for QCA6174
Thread-Index: AQHZyPrzKtu0m8KOY0eFOa/6uwPNzq//Wt5Q
Date:   Mon, 28 Aug 2023 06:11:34 +0000
Message-ID: <BYAPR02MB4839DEB37CF4094145A74D8FE1E0A@BYAPR02MB4839.namprd02.prod.outlook.com>
References: <20230807064626.980-1-quic_rjliao@quicinc.com>
In-Reply-To: <20230807064626.980-1-quic_rjliao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4839:EE_|DS7PR02MB9580:EE_
x-ms-office365-filtering-correlation-id: 32813264-5411-469d-7079-08dba78da1ab
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OUvhXmtMfI7m7F1k1oLVzJbVbltYSsSN1zpdzIKoRpCvCHKM2y+rOOhKpQSieTPfiq1jxxOYRtsKlp7PvjOIqu3W7sqzX1HJNHdN0lEM25S9cJ3v+tCu3SnoZLzRPkefMtxeXaNBy1VfzAtTiRt4sHZlnTUZsvYvyu3qfIU52rVSMY5fEDywkcUXxxQw81v8kY9AiWM3sV09wgrkJ61+CQ5i1D/fgzDqtfBZ4q5jmghATJengAlzZ2ep6RE4siK6fPt3eFCvgaiBOT0/eo2Qzs0mN4LDEPV3UD3p51Nff3ye0qZYhT4gEFKMTZGWjRfQhRQtoldu6rI8MT7uP5XCIUBm78N5RyvS5T6gV+cD6wxJ1tJZysJPfLBzLKIq0H8IS3aoLv3hmfw5JEAwB2GfWu+17uNNHTdVm4dPLP2P4Esg5WXtNtvIVJJzrw1CbKPiWkcdFCgnRV8DFjEVM2iblNz8wsVcyJG7GsGAsFhaEXxJvUoPeX7NEeoK8EX42Tj9u9UbOYOzkhO92IVJPSLxffYTFtLA/5biTAvHv59T2M5o/NufDncQHv9u27PeS0FjJ+30+/eRPCS/YuaWzkQTwRXCuMBffXTpndxmMCYxRQWaR9xpjqlNT0Wvlv5JyuTh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4839.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(186009)(451199024)(1800799009)(478600001)(33656002)(110136005)(4326008)(54906003)(76116006)(66946007)(8936002)(71200400001)(7696005)(122000001)(38100700002)(86362001)(38070700005)(26005)(53546011)(6506007)(66476007)(64756008)(41300700001)(66556008)(66446008)(8676002)(316002)(83380400001)(9686003)(2906002)(5660300002)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iJDLscttGQVT253mSq7VVHvK9blqZPJmObr8b7vezgp9R4JLNfC15hXzIDLo?=
 =?us-ascii?Q?kW8qeidU1sQLUOTq1SAFFMrlOZlX9SKKo+mF/5w2lnDTA28EjmgZFAY2hLQw?=
 =?us-ascii?Q?YNWAW/HrSCiWfS4X/m0vE9OWjnlvpZkCgCDURKg6nFeAlCkh0Kb/jqs7wV+W?=
 =?us-ascii?Q?jvfsXJVojjA6C9MDXa/tQDkLDRVMJ5z8dC3DMBYblWJN0hzEr572UyjxB8Ia?=
 =?us-ascii?Q?JP7CJZIgBhuATrLUqNaXL7kEEFfgKhN/kAbTFBCubonX077kAclSg//Fy7Tb?=
 =?us-ascii?Q?maPa5y9F1x9OjGwzMb+hQh8wI8qR3W7i7AlB5WmfYAjlJqYbC83V9Lbbsdu0?=
 =?us-ascii?Q?AqVRqPWrUfJR1qBtSgp8opY38GnJv+nO6C/aahoMVsz3GC9iYIZOZZyNxoeC?=
 =?us-ascii?Q?x5J4rwJ8N5qF9mDBsLqzN7cmJU8Ij6+GGk+oK8VxcaesF9tvI/2h5w57vq79?=
 =?us-ascii?Q?u4VafYtXRtJvm6zS0wNT3B2KQSgZK7FWmpfoRv3nwXJJr/vmPNOLYn6NP5OE?=
 =?us-ascii?Q?fvdj9kLd7PEGBtbQQYBSk/Xt/UH/Js6otbmtaO2Ig1NwCdAvhzvnW0/vAo2f?=
 =?us-ascii?Q?X+aRfe+xdrOV9GpUqPDe+JiW6ir57aCxOtgJBb+uifuIDlm2kTRFYS4Fjoig?=
 =?us-ascii?Q?LEv8nz6aC5Iv1A8XXJNbZPYKrTN8WHCuTJ96A2Ul2kHlVDyQvVk2pfQxTfm6?=
 =?us-ascii?Q?mejZUQ+HtXVfBgC3RirXRthpOK692erB8Lh+TfW6y6Wm4lsieaVmXMEEF7eK?=
 =?us-ascii?Q?xTqbDFC7eEHFPajrTyZXU/oQMw6hK/U+Dk9JfG8W3NoFsfvg/+z/0ssz7Hjx?=
 =?us-ascii?Q?vwkFFU1FqIbGseV3JKtDfjMhM8TF5y5J2mC2b1VMfqSUDZxeCzKCOjxGAbM2?=
 =?us-ascii?Q?d9frrsEq8odRT2+di/l+tTNwwMUYwcx9hVtyku5dqgkZtMjq4NxuTYZCLTPc?=
 =?us-ascii?Q?TRnrcWD9j5EWPurokXrJSlusm3XOcslInQShFarAjR74iZGnG9FIMAlG2eSL?=
 =?us-ascii?Q?P4+Ov84TXHZnHpXOr8S7zZ3tmCfEvFkfOeN8NyQwUyxrm8GdylDhtpf8PO1B?=
 =?us-ascii?Q?OfrBuHBJx62uvsuRaKNunnpkg7KDmZQQt0BXtJqg5+hKuqQJv0WQZHtVCliX?=
 =?us-ascii?Q?viq7/Qz305pBh4A8SlkTBOk0vqZfAll1F0EeTyCiXQJDc0BlDeAUj/e8FwdF?=
 =?us-ascii?Q?Pin8LIIRsEqIQ1j5q7/N7rUUdswW+vv9g1D5VX2INzCKwqb6Mte/Iy1bNl8S?=
 =?us-ascii?Q?kEFetEq+ch93dD5cHxA4QKSfk++HpAHzYzOBAjl1jr4K+FN8mpgtPSj0SuFD?=
 =?us-ascii?Q?cE35F5PEjp48CZXqOzo2RGuUNXO1G1I6oeL/Tw9OpjLh76CQMez6iyZV27AD?=
 =?us-ascii?Q?FwIwyUTwriqLPzxNMh5J2DCS345oxv0H5jOj9Vxew+d3evs+zZJQyAOhv+Jc?=
 =?us-ascii?Q?NwEzAPkOnVuPnEW3AMt2WDlQQUEuAskOezNvR+xrYGD2ShseZNZpy7IX/IgA?=
 =?us-ascii?Q?riSbg4LEgnckzXAKwm81B4ufH1vPD5Sr6j60uVDFlrU9Sr7yVEmUFP09e/6O?=
 =?us-ascii?Q?JATgNg3wSySFg80IjdRM6DdKkDCoX6AYcxQ13ANR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p+T+XMDUOyP+vm0SCPQMGDr3DbnG8acI/hE73fVNG9fa0IHs4GlcB6H8qYZKePxfdTE2Fkk/fwwIOCh0Ir3rJ56gRYVUi9e2kDUC9n+T/DK4k0CawGfDXlrWnl+GATmQyJCrWi25zMM5c5gls1VP3nPe2f1oefst4SCjXot2IOzgaH6v3Nkb2dfJ4aVrPX0Er7OxJ0/Xg81Xm8q9013wr3uawjaLPEZR9DlgTrVk8la49MYA96eS05js18Z1E139SJrkMSg3DH+taJZf2CQQcw9XxtXwQZfybuL08g0kQ8OIP0fLsHczAFUaoTIrlali0YZvh5cEpIfCPPfBJomaGglimnJjkk/v9y5sV80vIpPNIa03FZ7ydGUPtDPlNCckJOLroF1BoXsJ2Er/G1CSNO/zRcgybxagCFGbHPLcpgEGzG2q5O6Br5N5Wh6mI0FkO3PQQL7njuOh5q3D9yQ1mXKsZhj9Q//3K5z1H9+bjGwcW5+VC0gHmnp5r8prXa1ThBkMyue/qvqg8wiZOsR1mkOSe7ZYRPeUYvWQQ+AdZdMnBwrEoUJbIM4q1AIIWtisFznnKUB9vVJdPaqooMwFcLfwjUf74t2HlMpxOQwcPOz6kFvncPof10AdIIDfwRx9DGwnNIjnrVX+ddWGHKg7XbVSA3VkNfoXBW0VpB4LCwU4jTSWYYxEv+NlwKvnqM3QhYcytx+AuTUxHHdBuK1G0fD61HY69nNNF/5sOSXZqv9mBNc0n+KVmm/w/6sI2PUHDa3p80sIQEeMxd0uvx2RCVoVL5w3HwxdcSIDUYR+LouB7w6pmIpOR8yheD/c9Tv0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4839.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32813264-5411-469d-7079-08dba78da1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 06:11:34.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRTsUOOZ4mkopgX3zewdnyXeyznJDHl8u4hdPoIU49Rx/oP/HuEsgSYABZB/fHo3e5BZFn4EVJOqX6xRZcOLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9580
X-Proofpoint-ORIG-GUID: ynoLVdB5l43fbMTrCZ9RN7DyjrSud86M
X-Proofpoint-GUID: ynoLVdB5l43fbMTrCZ9RN7DyjrSud86M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_02,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=965 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

Could you please help to merge this patch?

Thanks,
Rocky
-----Original Message-----
From: Rocky Liao (QUIC) <quic_rjliao@quicinc.com>=20
Sent: Monday, August 7, 2023 2:46 PM
To: marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org; linux-bluetooth@vger.kernel.org; linux-ar=
m-msm@vger.kernel.org; Rocky Liao (QUIC) <quic_rjliao@quicinc.com>
Subject: [PATCH v1] Bluetooth: btusb: add shutdown function for QCA6174

We should send hci reset command before bt turn off, which can reset bt fir=
mware status.

Signed-off-by: Rocky Liao <quic_rjliao@quicinc.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index 1b=
b3b09013b0..ac4d8cf831df 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4419,6 +4419,7 @@ static int btusb_probe(struct usb_interface *intf,
=20
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb =3D btusb_setup_qca;
+		hdev->shutdown =3D btusb_shutdown_qca;
 		hdev->set_bdaddr =3D btusb_set_bdaddr_ath3012;
 		hdev->cmd_timeout =3D btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
--
2.38.1.windows.1

