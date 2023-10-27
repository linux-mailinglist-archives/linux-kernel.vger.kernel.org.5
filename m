Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40947D8EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjJ0G2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjJ0G2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:28:36 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CD1A1;
        Thu, 26 Oct 2023 23:28:33 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QImrEI030740;
        Fri, 27 Oct 2023 06:28:18 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3tywqjs3s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeMsslROfxilkcuLh+fg0XB2rPoc2qAnnHjcwYBPOxVC24Izxk+HAwfw86D2aUgWp6879ucq/hdgk6WMD3URoBuUdvQBzxpQ5xQHPPijjc/V2PyBJ3WUHvQqh0agm8NIlDBaqHlowyBN9WMGoqQPD7c+eDxxLeChRqgeums2TR19NG7yUVFpSomFxAsgWB1sA6f/kqyv1YTV4oul6H9VaD6kXzWxIG/+3zT75jUJWxEMQizbMiSiE6kM37emc9bvjyFMP71JSQ2wHJ8i7jBoYoQfg54bfVbsRokjwmwSGeSVl2dxpjorfAhbZavgEtxySAGcESlRj4MDQSNjrCFBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX/pUmFRfFtpnXc18StYNQ5BMGvgO5nozsyBZdbaWVk=;
 b=S0YOl4VWmWLZ/dzijm+gUHss7I+jp/CSmYu+7vr8SPS3k/Ynzx2depZcPH51aiBZ13Y2FmfCfGRz6SRNrnBee38WnJl4BlU/nKyFHeRLSesQ5JS1TkA2BKpVKOlHqeIIfeenAQVpd7fmwyij//qrBMa8Ys9CsQVhg3tNdT4S9VcxkZjkNT0IDrEsguNPAdV8IsO/r3GPp5N4g9uydNjqWDVFl7YZuFvQw4+PCv3iDpdyPD/jo98u7GQLZgoZfV/hkTX5THhMOYw9WHvkMuBvO/maOsZGo1lPkMCRqojMAQwWh1gaKCURWKdJOuvsOMpciUGaSqGigtfKUi0iRvdm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX/pUmFRfFtpnXc18StYNQ5BMGvgO5nozsyBZdbaWVk=;
 b=C9aiADKoblbKCy4RTeL96A05VOIywlFUklXjvx04FpdyQiTwpzD6dbW6zuuwgUChAOwEkFnlLR1oatc/7HpOR9lh/eCyJZ6YDqqjjQK6TNxd1caQXZD1NUl3cCrd+DH+IWPCPmmB8kT/34ng0ZX1RUcNsxrzULBIpSwH33ibDNdRtv/+qjQzmztoSsj24HROau8ivKlB81WC3JZQue8UPKOPFi7vG/BxQB4DIDKCxe7QppAXLAlhoJX9J+VbFBt5xqeAyXrYZ1hxAyk+Vr1e2ZS1n+tEFeMS4evUD8s5zKCBHmK4tJtcBoZUnXt5K85zA8vFj2yyi4yh+EISP0qBZg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8876.eurprd03.prod.outlook.com (2603:10a6:150:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:28:10 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:28:10 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v5 2/5] drivers: firmware: scmi: Introduce scmi_get_max_msg_size
 function
Thread-Topic: [RFC v5 2/5] drivers: firmware: scmi: Introduce
 scmi_get_max_msg_size function
Thread-Index: AQHaCJ7BGAyc1OF/JE+gASJoTLvwfw==
Date:   Fri, 27 Oct 2023 06:28:09 +0000
Message-ID: <fdfedf6dd0196afd887049877eae9fce0fe63eb2.1698353854.git.oleksii_moisieiev@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1698353854.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8876:EE_
x-ms-office365-filtering-correlation-id: 48077160-9de9-44f2-2ca2-08dbd6b5e3bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWMJJYxPxTE+4QRYSzLpobI0h/toDlIlt4gGqMEalYNxrzl/Vapwch710BHZJX/ktFUitXli8hSBJZPKl7ahzMnQxkbkWZDYbBa1743QuJ0AofohAAEAWvWTkg8AwSlyzBJBX+tdG9Ix17XTjGbCynARvgpUz/A+Ncn8+8vo+r5gmPViLNIoUCMm6DzIthHUCyv1RWEa4nD2ecS0MfCip0CCJVhrqL/8Mx+QkT61njINaJcBIDCUi1FEeTWC/0y9NXAnaC8lrfXSPwzGYSCbItlnSqb4K40wEn21W+80mLgnRJ9T/u0bcFcYCmgSYs8fQEThI1GtiPl72Y4nzsHuaY6rBzeaopx96cMZHDPhhsCAiuvM/3Zx/izDmXg+AZpfrOYgik2kMtLmfO5WC04znS3b91NGyzWeFYF2rN6VZ7RnOxboDEt30QBT3HUDquzW8GYdep3HFA1c/VzDbhxKRlHPBbh5K+FBb+rOz8cFP4LTCplAz6z4P5YVg4Wnq13EXWv1TCRAuyNf+YdWGG0wWOuxO/zfCM1KJyYLWUj0HiPc2lBXUZn1e0l18o65gG971IRByO1+Iei3UbHymzIYOs5eDrOd3F12ADhpdNbRH8Rd9NEhmNq6/ZI46YNg5Tcc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(478600001)(6486002)(83380400001)(36756003)(86362001)(8936002)(7416002)(4326008)(8676002)(26005)(5660300002)(38070700009)(41300700001)(2616005)(66476007)(66556008)(66446008)(64756008)(66946007)(54906003)(91956017)(6916009)(316002)(76116006)(38100700002)(6512007)(122000001)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fmTm4Qr63sIyXY/CkOPkfYpWj6zXZGiZI5OYxKFJDzpZcbrQh15MZP0Btc?=
 =?iso-8859-1?Q?6bFY1pqkn0LLuzDOOLpCB4KIqHaFEO0f6Ado5VZ3v122lXMPEMHV30MzcQ?=
 =?iso-8859-1?Q?mIMwfoqOR9Bu7hSoJm63dXIVt8keSEPDX2qCtfyV0X1ttlKYy/hz/C/Jiv?=
 =?iso-8859-1?Q?kgcUuwQByisNS/xkA9KhBQHvr7MgT59B/ybvg+SlkIv9XzkT9ohLzcvKh+?=
 =?iso-8859-1?Q?FZlOiv63bzro6WMAYCZXR1SbfxZomy2PUTza8JN2ADX4nASR+i7FvUXJy1?=
 =?iso-8859-1?Q?Uo+PfGg8pgOiJs3Mg4vJKEW7d4mc5sZ3dEBlSx6f5IesrIAN26bwZqCSN/?=
 =?iso-8859-1?Q?wLv4LahD15JzKUlccEKAen9ZoQ1fJryPo/YVHqWOR3E2lYISz/7d6+BdQV?=
 =?iso-8859-1?Q?6nG2EaGwv2q7xBFhNeYLR8y2Ji8B9Fs6DGDR5CasRN7iCUHO70yT1jJtsF?=
 =?iso-8859-1?Q?44kIiAR1M/3/+kqwBvII1RAaDKE98GtPdDaDY/YUt9eL40xxk02aXktLDs?=
 =?iso-8859-1?Q?aX4ViMCBVL8IHygR9LyOro69pMER77cZ6dkLMksZp+3KsAuQWnL22Z+Y4f?=
 =?iso-8859-1?Q?8c1k4KP46w0I/PLg6CiWHLM47I3urXQmI/5K+CWVlO/d1QDXSJY1ld9KDq?=
 =?iso-8859-1?Q?GCP94orI6JHG/VUI85FNu3r8OLUN7sK0xNm+eBbVKAyI2xxko1jB4yUQzM?=
 =?iso-8859-1?Q?VhNJKkzu0nCWe5fM7wBj+zI8o0ULHzEoa95/c9Vv1Ta8890HCt5j0llVSs?=
 =?iso-8859-1?Q?xp6HXZg/mrEhku+SEVIjaCAmgMd5oomxp3jwDRI/qtj9XNwqtBl4RPnOpx?=
 =?iso-8859-1?Q?SEmUMW8pK/w60doL4CaoRSxW6pHGzPsd4G+sPov8PZZtduMoE2Ddd08wgI?=
 =?iso-8859-1?Q?KxcaQ/z0tX3/lK+vqArnvaZIJLlNngMBEhnEWKnYd3vOsQiEeDtiIFIk6W?=
 =?iso-8859-1?Q?ZqbpvMJvYVnUf+08EYBFjTXQGLIR8QzL6rjRZY4fzZU4qrEV6q0B7M4qKH?=
 =?iso-8859-1?Q?VlB4GWPkJxtdrbepvXgq956HZrYk+HjieIc2s4jNbFWdPW+ZSrqmGXcZln?=
 =?iso-8859-1?Q?5X1wbfKJBs/7xHbD/tXHwzuWPVobs81SIBTX83dcKTH7H9ciFm28G5bNpw?=
 =?iso-8859-1?Q?f8rBzvhBHThYXf9tsMbZSGz8szRg5X3/+h+dLo2EFBTCaXzAYhjen8zIn+?=
 =?iso-8859-1?Q?rCCoFdIDjDnQk+7Q6d48NdESlq1wDJf0D14Q4UMrs0vQHpjJ1Fzw8ca9l6?=
 =?iso-8859-1?Q?ajjSaFK6WRj1FYCdHSWa+HJie0N88o2xCigg4U2t9Uyrw8uoDTcWSiLaSp?=
 =?iso-8859-1?Q?epmY+TViKdB+Eej6M9qiu/7F06rWm71jek3P964+w0Hwzxy0gneCwKHHuW?=
 =?iso-8859-1?Q?GU8RqT1TZGqiaBI8Q/fT5XFdaL7spyjbdkinAYEdfX7T3fBAUQxKwRUxOn?=
 =?iso-8859-1?Q?JkxCsUh8px2+5uh8MJuLAJxLnWsifHhawDw3Wvwp6tDlVzmJEzcZl2kYQx?=
 =?iso-8859-1?Q?wSsbvu7vDNfhIgOHw72lfrH0sW1ktFpndg3g+A5vyLM1pa+6Tron7/cxc+?=
 =?iso-8859-1?Q?hnDHpqFnQCmdSdNn6mAcSGNooodsEjIKIhtrHT2pz6gwd1rr/hHeTo5olu?=
 =?iso-8859-1?Q?+//ih2knoORd7Jusa8bAFl4vPVYrnchW4dBB5x8ZCTdmMp7bN19aoB3w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48077160-9de9-44f2-2ca2-08dbd6b5e3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:28:10.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UTKFYD92fNyNNuzxlSeyDG8ZZSdTn7KUebG7TonqS6SeG+KsfGTiCuoCcOlI1p2aMSImEEVA65QSG3l3qhj+evcCTxkMwNuOFXiNKs6DB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8876
X-Proofpoint-GUID: Ia-1mDgvCKRQgMxCz0pythj_chJ1wzbr
X-Proofpoint-ORIG-GUID: Ia-1mDgvCKRQgMxCz0pythj_chJ1wzbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_03,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current SCMI implementation supports only receiving arrays from the
SCMI server and provides helpers to process received data. It uses
msg_max_size value to determine maximum message size that can be
transmitted via selected protocol. When sending arrays to SCMI server
this value should be checked by the Client driver to prevent
overflowing protocol buffers.
That's why scmi_get_max_msg_size call was introduced.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 drivers/firmware/arm_scmi/common.h |  3 +++
 drivers/firmware/arm_scmi/driver.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi=
/common.h
index c46dc5215af7..3db97f59bc59 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -286,6 +286,9 @@ int scmi_xfer_raw_inflight_register(const struct scmi_h=
andle *handle,
 int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
 					    struct scmi_xfer *xfer,
 					    unsigned int timeout_ms);
+
+int scmi_get_max_msg_size(const struct scmi_protocol_handle *ph);
+
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index 729201d8f935..f15e9b2b21f3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1152,6 +1152,22 @@ int scmi_xfer_raw_wait_for_message_response(struct s=
cmi_chan_info *cinfo,
 	return ret;
 }
=20
+/**
+ * scmi_get_max_msg_size  - An helper to get currently configured
+ * maximum message size.
+ *
+ * @ph: SCMI protocol handle
+ *
+ * Return: Maximum message size for the current protocol.
+ */
+int scmi_get_max_msg_size(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi =3D ph_to_pi(ph);
+	struct scmi_info *info =3D handle_to_scmi_info(pi->handle);
+
+	return info->desc->max_msg_size;
+}
+
 /**
  * do_xfer() - Do one transfer
  *
--=20
2.25.1
