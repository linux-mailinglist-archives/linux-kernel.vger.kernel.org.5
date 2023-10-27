Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB07D8EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjJ0G25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345315AbjJ0G2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:28:54 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF231BB;
        Thu, 26 Oct 2023 23:28:40 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QL6OQP007652;
        Fri, 27 Oct 2023 06:28:15 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tywqm92ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE6Z9y7/hCmdaVpQBfSIQ3yi4ooE2LI1AJ04680mxZ0Ha/TYLwknSqDID9LsWT5fECAICvVJDGex1750xWHxm9H0Rzz4HeN4XNgoMAvTofr8D/jpXxD8z8SaqyScHQoDR7ISFR6gJgMAfKu4G2qdEeaf+/28CAD+MvAJkRtbqwBNL5LLAuhIQLaU3Msj7nhKsfAFA8lhc1A48/u5iSuKf6kdEiAglph5AychaiAOAUhExEGqtTDnY4QqyOeSNQf8f29ZrvHAuWSbBJ5vYw2agt0eFpUyaykqpdF+bYuPbsjPQHHqk5lIcwF+xHijyDwJjTEtxflXKp8wdwVrSbqqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaH5rN5sWId5OwaQsed7wER9u7G9/CZdNqWaDCZQQJA=;
 b=Ivq7cg5GOnTEragpMROq4AWEenMnwmkHGfJCJy0TN7TJjhMwnVRHwnaYY/HxHYDIxVqD/KwRJA9k7noQeChfm0bnLRp5Lj1kieACUURZykpTVQX3EIcxvhidJJwSr740n6s+n01ISO8JrYXmxhzIjS8NnrBlXpzNAcTNehIwR5vdwvanYbi22X426uvs1EbUtqkRz981UjriM1utXVz6Ijyi6zEWG5mP1/VjsnQta7Jwb+8sHmowU6pqCQtkIL0eAkXBn4arGSq5Cd2STL73hoappks6NIKbvZkvrwgn28HOf2sF9xoNf8V5v1K8KCpb3kcLSKQTXD0LN+QCTxFGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaH5rN5sWId5OwaQsed7wER9u7G9/CZdNqWaDCZQQJA=;
 b=Vt6LB/7YXfdU4Esw0lUJy7dNRKzU+oqjIYjuxZCmLaiZZplF1XQnud+WVXdDLgA1fbv4tqQnllT3jpqGZC73YIIy5x+k4DXxBJ9wBC8WWS7zlvrNZ0Os7rKX8ImA/EqnqZhxedD/hKGJC5et17CtDUsxAHcZIV3JoT74nLYLmCvwvq1bNNodjjkZO7l/EpZhwe5Xs9ovq4Xc0czeQZfOStxBUFQtqqJkjkuexIglT668SHenE69kqKywthNfco6Fz0PmXy3l4Q+LDOfg6rmg+ge9L8Dk4lJkHTHe4J8nAtcbwYkWDfqNaXd7EWhd0GVScSejx2O8Npu+wGKJW0F7LQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8876.eurprd03.prod.outlook.com (2603:10a6:150:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:28:09 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:28:09 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v5 1/5] firmware: arm_scmi: Add optional flags to extended names
 helper
Thread-Topic: [RFC v5 1/5] firmware: arm_scmi: Add optional flags to extended
 names helper
Thread-Index: AQHaCJ7AzVEsErsWcEuaiaf9wSr68Q==
Date:   Fri, 27 Oct 2023 06:28:09 +0000
Message-ID: <318eb79c7e1ddb1f964a901e778a0475bf18c85b.1698353854.git.oleksii_moisieiev@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1698353854.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8876:EE_
x-ms-office365-filtering-correlation-id: a6ed3b69-e123-4019-de96-08dbd6b5e350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyWZU/njM6rH2NQUOUqUShlnr45DnPz2r/GgyLKMbRjFCmmC5m+bLPgbndfKBl/HyrULPsuc4P8gNnzGo2MtvpeEooaU09o3CrvgT2C3H+TcbmWCD5Fx8p8qmiodsIHjcQOMyBcqN/VX4vgcdyoH4q+Z/DLakH9O68przhzzIMGPWP0cFoQHyLetuZ0bah/qD3uh/VuAOituGul8he7zVgjldpZWvoXQNLPwnssb1eJxDt5a2ExYsFnSF3vwNH4BlwKXzOIHADFfLfA9g0jvsjWb36el53sNHCS/PkDuVYQYsKu3wzJpNkOiynuhMK3f2ACU1LKdM/9m1F0CdEGCXEawcXhgskixZ/Mcv7eYi+M90SA9ufwzge8dYCk/W3eOUAsQFwW/C92+t+D8MwgrMha22acVW9bciueVSoSKjoZ4kBu3QomCckvIsl3+khfSj1L+aeXSWzG5PxGwU0AoowhX8Ygoevn6+p4Lv4RcZax/CO9dUyUxBcujZ0UyYg/TvcCRHXh5Roog4ICetLD5tOjalLP3gVmQwZ8beWZa+kmJPznnnFYG/z2X5n7Jd7G+DRLv9zlb4s2lCAEARCCouIlDbJzMrDIXdXBuV+WE701thljMVy+3wCN0SHYX3r4g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(478600001)(6486002)(83380400001)(36756003)(86362001)(8936002)(7416002)(4326008)(8676002)(26005)(5660300002)(38070700009)(41300700001)(2616005)(66476007)(66556008)(66446008)(64756008)(66946007)(54906003)(91956017)(6916009)(316002)(76116006)(38100700002)(6512007)(122000001)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X6i5UJAHpSRWtppo5y3kKL+0E8jRAWmW03VDPBWNaGr1rekS1BEzbcczus?=
 =?iso-8859-1?Q?97YNdP9SaklsqaJTk0/7zlL4h82GRuDNdFfLl8nLmKVJhiMRwQ7cgT5Yqs?=
 =?iso-8859-1?Q?w12nMvItFWn0VOcxKULNLrONV/umJm78vaUF4Wh3HMNtFp876mDZPRB8sJ?=
 =?iso-8859-1?Q?63i1+C0DCkxGfvjX3czV1nvvJkXhRSRNa6y020qZcT7gD8SrhBcsNl4g0a?=
 =?iso-8859-1?Q?Jod128rFmCjO+lLLNjvb78u1dbNKTWqgmXTwfSxV1HoCRtz0EPCrBYWA9x?=
 =?iso-8859-1?Q?9Rpe8a2YiqznZnMgPtWgqKJA44+0dCtrMk8Ncf1zJ0/OD3sPPbDfg5YihY?=
 =?iso-8859-1?Q?IsLyuXL8gFErk0Kq2nM87TLX+oKlrN/ZQTaGWI+DFVac2ecE+PbuKNjmNF?=
 =?iso-8859-1?Q?/eu/RB7iwuLLb2Nh2oxwhUwTJn1NzUAt4ecVV3Ef9RbkMR8HZR4UXg2vFw?=
 =?iso-8859-1?Q?fvP9LaM+w13P9GxmUXuAYgWfoTx8NYb17ues09GYL5MCJH/WfT5H2unNs3?=
 =?iso-8859-1?Q?6eLQ+IotlEygvBPJWwa47vwg6mDu9SqVin7RgsUEHBZN2r/vZ/co7N1T8s?=
 =?iso-8859-1?Q?AmMOkFHOH4zL1nDW+44qKvRUj2jq0foII+cZ6P1CJSnoQFXXr5y6wO4wus?=
 =?iso-8859-1?Q?s6qqHFpEltgJly9q21uaPaz1h2mrAJXp4UlvP8irQsptdgvCazyB/m5G+X?=
 =?iso-8859-1?Q?X2EI0kdA0bFyCu568K8bKe0g3W3O9yEG783xsdBETNEZFTp4iJoaeRbKcm?=
 =?iso-8859-1?Q?nAFlQC2EJP+ToqD3/e8a77UGhp5jo4yNZKrrAFH6NNUP9kKTsNpVby/aTL?=
 =?iso-8859-1?Q?NIiZJvlgTL3P0Gysav7v3Grlt1YjhKCQvHCs2xrOmfDgww3Xff8L1m+Y/f?=
 =?iso-8859-1?Q?uSC2ZcPtBbvLM26Togzl3nIhk9zXWHrMz6qXhZpuu5ar1N1sCW44Cm2zQh?=
 =?iso-8859-1?Q?WQ9tIv876RUf2WytpGDCXhZi0CdBGxVp0KwzzbiOefhPBbdlTYMOKwhO8Z?=
 =?iso-8859-1?Q?WK1RGTCw7dlmKCWFaXkHF16a2BWNui/GzthAWY1Lx5KWh9fCNKfIKWLtsC?=
 =?iso-8859-1?Q?vDDeXTA5eEe7YF96sj+1K28FkyvJ0+Y6Q/wJWuRkerXwvryIcKXE6CIlTr?=
 =?iso-8859-1?Q?PaqOm5AeGlwgHVPB2IU6nBul0KXrgwPhn1AVrv6sUrpUtEwbrm20dJldZy?=
 =?iso-8859-1?Q?yUvoVBGYjPYe+JTrqpgfvnY2eaf4q0+3OQPUiLf+5hfE/2ki/vVgj8x5c7?=
 =?iso-8859-1?Q?MRBNzrvj41fOwr6mD8cqhFVyHU7IuXxGXp2q/6SSrVylA+pNq6tyvaGW3M?=
 =?iso-8859-1?Q?HZjvBNvnex3skFGBpI15Kc0on8MxYlaCCG4/Us9TRVtxE82mBX8vIj8S+Z?=
 =?iso-8859-1?Q?GVKnr6ZnUiFyrox0Cpzsn0lo2Sb4WAR7TpBh7dSZgRSXpCopcfh7BWkr7Z?=
 =?iso-8859-1?Q?NJzgExTXdLURw3FtfN1TMsAHWu0AgqP00TQ4EwqcC9A4bwDK8KKJVPNBvO?=
 =?iso-8859-1?Q?qjgfMNGnpll0ARlShsJH3DD0yTLZ3wrN/38G3WlIcQoP/Jm3Jy66/dea2a?=
 =?iso-8859-1?Q?HrPq2PMXLTt6qEv/2mcc1sXQSFTJNyrsAzSm4Cnd52nDVS7gr72QXracYc?=
 =?iso-8859-1?Q?IDbwSHRdVG4hCU50mhnJIKeWU55AZq8aep9/rtpFmPGG0bD0cL2GVpGw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ed3b69-e123-4019-de96-08dbd6b5e350
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:28:09.3773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNeXCKdn2RJca+JxkjnGyo6EL7aJgM1STkEXE+b4F6dgp30Wze//NHDWONBJYggp0G+52XAyjq1acLrfaKXsNcXN4iFsdDx+2r+LOuuDe1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8876
X-Proofpoint-ORIG-GUID: mph7srOMVquastlWr0Hbj4y-eFyNGCiV
X-Proofpoint-GUID: mph7srOMVquastlWr0Hbj4y-eFyNGCiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_03,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310270057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Marussi <cristian.marussi@arm.com>

Some recently added SCMI protocols needs an additional flags parameter to
be able to properly configure the command used to query the extended name
of a resource.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c     | 2 +-
 drivers/firmware/arm_scmi/driver.c    | 7 +++++--
 drivers/firmware/arm_scmi/perf.c      | 3 ++-
 drivers/firmware/arm_scmi/power.c     | 2 +-
 drivers/firmware/arm_scmi/powercap.c  | 2 +-
 drivers/firmware/arm_scmi/protocols.h | 3 ++-
 drivers/firmware/arm_scmi/reset.c     | 3 ++-
 drivers/firmware/arm_scmi/sensors.c   | 2 +-
 drivers/firmware/arm_scmi/voltage.c   | 2 +-
 9 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/=
clock.c
index 96060bf90a24..e6e087686e8c 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -169,7 +169,7 @@ static int scmi_clock_attributes_get(const struct scmi_=
protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x2) {
 		if (SUPPORTS_EXTENDED_NAMES(attributes))
 			ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
-						    clk->name,
+						    NULL, clk->name,
 						    SCMI_MAX_STR_SIZE);
=20
 		if (SUPPORTS_RATE_CHANGED_NOTIF(attributes))
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index e7d97b59963b..729201d8f935 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1438,6 +1438,7 @@ struct scmi_msg_resp_domain_name_get {
  * @ph: A protocol handle reference.
  * @cmd_id: The specific command ID to use.
  * @res_id: The specific resource ID to use.
+ * @flags: A pointer to specific flags to use, if any.
  * @name: A pointer to the preallocated area where the retrieved name will=
 be
  *	  stored as a NULL terminated string.
  * @len: The len in bytes of the @name char array.
@@ -1445,8 +1446,8 @@ struct scmi_msg_resp_domain_name_get {
  * Return: 0 on Succcess
  */
 static int scmi_common_extended_name_get(const struct scmi_protocol_handle=
 *ph,
-					 u8 cmd_id, u32 res_id, char *name,
-					 size_t len)
+					 u8 cmd_id, u32 res_id, u32 *flags,
+					 char *name, size_t len)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -1458,6 +1459,8 @@ static int scmi_common_extended_name_get(const struct=
 scmi_protocol_handle *ph,
 		goto out;
=20
 	put_unaligned_le32(res_id, t->tx.buf);
+	if (flags)
+		put_unaligned_le32(*flags, t->tx.buf + sizeof(res_id));
 	resp =3D t->rx.buf;
=20
 	ret =3D ph->xops->do_xfer(ph, t);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/p=
erf.c
index ecf5c4de851b..d85d4a0e3605 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -237,7 +237,8 @@ scmi_perf_domain_attributes_get(const struct scmi_proto=
col_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    NULL, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
=20
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/=
power.c
index 356e83631664..077767d6e902 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -133,7 +133,7 @@ scmi_power_domain_attributes_get(const struct scmi_prot=
ocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags)) {
 		ph->hops->extended_name_get(ph, POWER_DOMAIN_NAME_GET,
-					    domain, dom_info->name,
+					    domain, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 	}
=20
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_sc=
mi/powercap.c
index 83b90bde755c..e7ea9210aae1 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -268,7 +268,7 @@ scmi_powercap_domain_attributes_get(const struct scmi_p=
rotocol_handle *ph,
 	 */
 	if (!ret && SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, POWERCAP_DOMAIN_NAME_GET,
-					    domain, dom_info->name,
+					    domain, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
=20
 	return ret;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_s=
cmi/protocols.h
index 78e1a01eb656..b3c6314bb4b8 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -256,7 +256,8 @@ struct scmi_fc_info {
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
-				 u8 cmd_id, u32 res_id, char *name, size_t len);
+				 u8 cmd_id, u32 res_id, u32 *flags, char *name,
+				 size_t len);
 	void *(*iter_response_init)(const struct scmi_protocol_handle *ph,
 				    struct scmi_iterator_ops *ops,
 				    unsigned int max_resources, u8 msg_id,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/=
reset.c
index e9afa8cab730..7217fd7c6afa 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -128,7 +128,8 @@ scmi_reset_domain_attributes_get(const struct scmi_prot=
ocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(attributes))
 		ph->hops->extended_name_get(ph, RESET_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    NULL, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
=20
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scm=
i/sensors.c
index 0b5853fa9d87..9952a7bc6682 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -644,7 +644,7 @@ iter_sens_descr_process_response(const struct scmi_prot=
ocol_handle *ph,
 	if (PROTOCOL_REV_MAJOR(si->version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(attrl))
 		ph->hops->extended_name_get(ph, SENSOR_NAME_GET, s->id,
-					    s->name, SCMI_MAX_STR_SIZE);
+					    NULL, s->name, SCMI_MAX_STR_SIZE);
=20
 	if (s->extended_scalar_attrs) {
 		s->sensor_power =3D le32_to_cpu(sdesc->power);
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scm=
i/voltage.c
index eaa8d944926a..36e2df77738c 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -242,7 +242,7 @@ static int scmi_voltage_descriptors_get(const struct sc=
mi_protocol_handle *ph,
 			if (SUPPORTS_EXTENDED_NAMES(attributes))
 				ph->hops->extended_name_get(ph,
 							VOLTAGE_DOMAIN_NAME_GET,
-							v->id, v->name,
+							v->id, NULL, v->name,
 							SCMI_MAX_STR_SIZE);
 			if (SUPPORTS_ASYNC_LEVEL_SET(attributes))
 				v->async_level_set =3D true;
--=20
2.25.1
