Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6097749DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjHHUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjHHUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:05:37 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BE995D9;
        Tue,  8 Aug 2023 11:25:56 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 378E6eOw003021;
        Tue, 8 Aug 2023 18:25:40 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3sbpek1ayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm1xO9o/0faYpe/b8ttcyEIxbtB+BqwbBULgLtVgLnWaNyuH7oczShozymmK3g/VxieFQNsgbKjSNZ12QAaxCkZ5c+Io0G4FZJVOrkTZP4ZKZTBnV/j+t8hQj5SQuVhiHtkANsAOVuynM2c0IX29sFAEmY/B4U5QhsOm3xm/pMes9tKiEPjJfdLEchAPe/vonAZsAV3ere62GBwPpRlJWwOiiGCaltJeWC8bwLs7ohaDeLDAWwD6omWQ1J61lmSmirPCV4ZcviJPDss5NZYGzxikD5vKBenGIVNp3yuyXlkHBYCCKH4QWPNoaHPxQFCnJLxIPls0cCHbHviWwuq80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaH5rN5sWId5OwaQsed7wER9u7G9/CZdNqWaDCZQQJA=;
 b=PY4km3YboOW91K5olEAD9X/uELWEnZnlSHjZVSMy9BH0L/jHrDjGQXbQfDR/9q8b1XSpeLg2Bt/LetblXSm5j0azgEBpJagmF03ZMoNs54oqRQvlU9gKxw0BZv/sGd5EfoGRA4HM3TNvrR6RLhRAnzDUNNfiGQIGWDJSWSppghgwrNc+lt51+oN+sqnSaMjqycS1VpLjzrc4Ey7Uiv1VzH0y9pqnWdpVoc9p2UJnWsEpBX/wGzkvHjkuUoeOrC5nuCzA9ja+C5Q5XVFPrtVe/+xVKlwFzJ6tqMK7JniBTR+HbxDTZS/lQk9k5xbGYjOr5DA5/vcKLZhu4qNZLjW61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaH5rN5sWId5OwaQsed7wER9u7G9/CZdNqWaDCZQQJA=;
 b=iHfOIw+qJ7S/Xux5Nbhx3Nl9FooWw0kkrajPAWJoaPIFIvsLVXpmMVTknkY5JXm4X4tAWzVWKYhdQ1tAQ+DVVTSf7WNRTImXy5JrA90OyTwKJwC/nW+tncK/6eguivTFmID/Y26EG09guomdlR3NhiXWYpjGVHJUOqBQXcx2gQ8TlrbB/xYjpvmNpkJ0o6xaV5Ves8Xk8NDw2coUNmeXyNn6DyLJTx0dqZ46zRoO1HBEbgdZWPLx/5KdLa7SJw/tACmA0w6qrSfaPAyREDmwdJTMIPRZF3rGy40F4/qlCdeusYoD+YD8C8Pdd/k7XZ17a8Osa3rHFaMKOj8EMLQXbg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS4PR03MB8458.eurprd03.prod.outlook.com (2603:10a6:20b:519::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:25:35 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:25:35 +0000
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
Subject: [PATCH v4 1/4] firmware: arm_scmi: Add optional flags to extended
 names helper
Thread-Topic: [PATCH v4 1/4] firmware: arm_scmi: Add optional flags to
 extended names helper
Thread-Index: AQHZyiW5rkl1KYxbi0Wgd/91X3ABeg==
Date:   Tue, 8 Aug 2023 18:25:35 +0000
Message-ID: <318eb79c7e1ddb1f964a901e778a0475bf18c85b.1691518313.git.oleksii_moisieiev@epam.com>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1691518313.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS4PR03MB8458:EE_
x-ms-office365-filtering-correlation-id: 7f130943-ae34-4d59-7275-08db983cdbb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHRHvAN4xfiBrM41iJSHkpeSywR837AuRs83aAZVH0AWGOsHzcFp7pZDvfavWazIy0jMKNU3BTZ65MrBt/fAJKUOmVuLZxb/CAXt8q6zF/9fWJqJi3+pbXsgMYjnNT1IjJPv/qkV+HAC27RETT9672CSYPEneG3moXDxH71QpD2aD6vsvJIQXiNvOERl8TIPkTYl/UOfm+GptkeV7BpNVFt/PkT3o6QYNu6kV9kprsNlQCtcfHO7ttOiYHRmUPlUzc2S+qyUC8IClgFdAuH6lPtKdLWd7tECV3CrNUfupaWGLUwiO/ZhWFw33cdyzQU6RAwQA/RTNPWik/KSTkSlNZxA9VLWsicdpABx9Aek8/ZQEGkb0MYC+qB+4aNPn6q9gjDEt+1Wrl5bPvUNfiM0N3NtvbfSyg1u1UkOdCgnUmXegGxj1SLcakgCmE99OBqysCrSrpRykCgI6lFsKZOHwjIHyLCBSNo0IuYWl+CPEgDBB6HPbP0Awt3SWzYVlwfbz+T7v27yAv2bmwEX4zj3w48cMXpMXUuAOhTczmmZXbc39YwN4f7yxSESszlW9Qcmx2tHCtn36MQLyOE6kodQULgNKGlYTEx3BwGqinnX73lvsNlqbhuZPtJ7HPVycHH8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1800799003)(186006)(7416002)(38070700005)(8936002)(8676002)(5660300002)(64756008)(4326008)(6916009)(41300700001)(316002)(83380400001)(86362001)(2906002)(6512007)(6486002)(71200400001)(2616005)(6506007)(26005)(36756003)(76116006)(66476007)(91956017)(66556008)(66946007)(66446008)(478600001)(122000001)(54906003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1jkEJ8og7DIZMAtuX5HVBTQzFBn8ihwT0ZIWlSA9VdNSZ12UQQEyPJcbFX?=
 =?iso-8859-1?Q?IrmmSzgHlFCujiR0R/IVmeA/vfkion6LjL1dlZLgQRftPz1aQFbNoQAP39?=
 =?iso-8859-1?Q?NAnbinHzYumYT+RY/t0VEqLKG6YZdSuNDGJIzyvGZAwvvOMyrKXp6HNH3s?=
 =?iso-8859-1?Q?wZQRgEsT7lYTNeqbr5Ww0otMJgJGtYDeHm162AEn1/Qo9f6UiIaGjTzHqZ?=
 =?iso-8859-1?Q?yvMFiKLVga890O+oaq5FY9DIkYfnpPc5tLHQFl8VIKV44W0zIV0o6S8clK?=
 =?iso-8859-1?Q?uYmvZsHVB77+9RuytK22JjdObMmImiMJnmEmULEcFL6BQJggxjBZdPITje?=
 =?iso-8859-1?Q?2pcUdQZiUhC/v6qdEM2MOwn5Cb+pm5hV7KP77LDXcsnopmL6EzR48TF8+v?=
 =?iso-8859-1?Q?t41UgPXCAXgxI0wd8U+bJ+C/sCjmdMTdSdLvhQ2FYOBuaVPH7q2EOW4eUS?=
 =?iso-8859-1?Q?/LHu4OYkDr0AnLC5XjNzBqkmp14EPejrrBg04ymV/1IBzeLOLl9qCoGskj?=
 =?iso-8859-1?Q?41HSGT5PH9grmPFf6fFQfk+l4Kd+N2mNEupRPIcNaVlewP8UG5EfIgSjH6?=
 =?iso-8859-1?Q?9h9E5BuyppOQQma6/6eZLP5nzBmNoisMKjBKRe6LuG6BO9sk2ShMr/HNuq?=
 =?iso-8859-1?Q?4HzfpnFzMz7taZMWzA3yGFbsp8cFgAKo5AxzwmmuS/jAkFX1AzVsTj5Mko?=
 =?iso-8859-1?Q?W0NcyU4nt7V49n8BjE9q0PVLllV5qRoZuRYa3aUgEaH59PPW1La1JZhaty?=
 =?iso-8859-1?Q?m1QlDrCnvHbdYOKrk/TKNpxd8akAUNm12uU1WcllAO4fH8UbaZW+1+t4oh?=
 =?iso-8859-1?Q?457kRm4QyUleuULHFpcyUjeuo7hpRJFqOisSqlUH/RGyeeeoxIslSpQ8bU?=
 =?iso-8859-1?Q?esowV4Iwyzn1seOZ4unnz4ffIrWlVlR48M0XoFcwFXSuQFja6H1OvSHf6M?=
 =?iso-8859-1?Q?Ynau0o2FJkBh5J2MwrdGTgwLKPHlVaqpyZhmXs/XmdNv19fau8bHUENLha?=
 =?iso-8859-1?Q?iWzHKwqApaFeVlpsk1ItEKRbAHfseLpibOkl+CTZ5t1GpyXhibUJ+zd3UC?=
 =?iso-8859-1?Q?K5jIlS5OTgofhm1Af1m99jYL/Eagtfldx5GLMEQkMF2U8nLRZbVl2TORYU?=
 =?iso-8859-1?Q?HLithGiwR7UqFdPsJRuORuvBYjnOGHO/jcjP8yOWcYeeZowxuOVhQJY0Uh?=
 =?iso-8859-1?Q?Z6+gtA0Jq8vOFAWm3A65unCrX4AjSdT1qhK1zGVrjgXOqXp/QEYYVolwmK?=
 =?iso-8859-1?Q?D95r2WRmICl8YYwxm366j/iMKt9n+724Xr0x9G2Yc3kR6/9eoeAmzNM/ou?=
 =?iso-8859-1?Q?SWtn1hLKJIr2gKQ1UKmlderBc4TKZrLWhIm+y/dDDway9K9cU9kCUOzaT4?=
 =?iso-8859-1?Q?0iZ/cvsc6D337V6RaX6W7xscwjGCiVeqAd36vrWMBwtEE4Wn2mj6y71tFy?=
 =?iso-8859-1?Q?6QasJl1L3UqGpaw5qIhrsbHNQT5DnQSFRmCs5GbcGdbuZ+fF45YKh3Khsn?=
 =?iso-8859-1?Q?gL22lQNliPWSkw4893+dBYUjad2mH+EIA2+ifiUOU+z4QIDGo3aet2xUo8?=
 =?iso-8859-1?Q?Svk4eQ1meMZiBCCFr7HulHssANxqjMBmwtRWCCU0RoFTf40N+FivNAFvf8?=
 =?iso-8859-1?Q?mA/L435H4b0wpvm6BMlLer7/HU3qW29jcaOKggMwZ5ngY74Y0YGI5IlQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f130943-ae34-4d59-7275-08db983cdbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 18:25:35.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSLfYJ1pUEQnctTvE7pQL5SDVVkwJlwr+v2rvT4p3KSPODfem3TrPGOXIZ9AfXCd4dTlRa8J9q6Mv8SUWkpMj/W0GRRASyOat5XdrVYE4A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8458
X-Proofpoint-ORIG-GUID: TsTa_T6U3ZHwAWEuMa_mFDjaKvI4kGFf
X-Proofpoint-GUID: TsTa_T6U3ZHwAWEuMa_mFDjaKvI4kGFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080163
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
