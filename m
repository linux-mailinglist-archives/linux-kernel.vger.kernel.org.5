Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667D978142A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379924AbjHRULp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379940AbjHRULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:11:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA633C06;
        Fri, 18 Aug 2023 13:11:29 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IJUX3g008625;
        Fri, 18 Aug 2023 20:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=W/EOyQz2SK/L9nyANzwRavjHXH3IzRN7xw0E5nQnlWg=;
 b=fCL9YodghbO0aIdiERuE/nUgTUhKO1f8xdoBrPwlsMTe4uclE+rxD7SaiLvIdLV+cii2
 RDgPfEX/JTzu+3nx9RscPGpPxHQFKvoA+76IVmCY0u9Ua6Q+cl9ToFkVstvaeyCRJzpy
 zYkKJglKUl60najWoTKctTWdrPVOV4ix8+q4WjSuUOCaOpWvskM/kmplOjmbXiAyDc4g
 PbGW5GhGq8InBZh+khXToWcS6V70qfVwSsk+701yzPkHuZKUcSfu3hLLq2vxx88FXSC3
 iz0rFpKn6DvvRWAt6F8zd5NG+MqYfHSaWN63HDoDS5lWexTv5Xrxn9AUUGtjhk0iAO5I Sg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3shn5h71ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 20:11:12 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id F1C2CD2F8;
        Fri, 18 Aug 2023 20:11:10 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 18 Aug 2023 08:11:10 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 18 Aug 2023 08:11:10 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 18 Aug 2023 08:11:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwFb6di+1nr32BjTfLkuuwmgQUJLqtOsz1Sv4huq7LF0cek5ZvMeBcz+GAoiF6Q7uVwQBRGfY2rKa28/5RmarUuzHosqMxPByc+WGS7KhrcKyYf+4lWvBPiJqYU9kQNTWOQdtMhQV26WXIGlFwItHvWCYgYeC4lxcOIPh6Dq1264OortKM4JQ2f5LO8+LYO4I7c8OH/NT4t75u7RmopNpr1Ux23R5GIcbsVjw1Erj7hRpO1F63rgBEl/ze6YD2SENs2MZ0v9ZZpi5wqUYt/wMTR9tH3QaHDd/svkcrB0y+XvuzOXd1J9nGI2GbZ9bJIJ2U3Ce03n6MAx2cKpNWIXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/EOyQz2SK/L9nyANzwRavjHXH3IzRN7xw0E5nQnlWg=;
 b=SYuA0sw+mLNftyfyuxH5l+H6AUbGLBWW6fCcrTOeun5KF+VoZYOtIgJSMY+3xyajQwTiIr0+ZWRNJmsBRU0xZ0ZCsXjVmUKX2dywGC8UlRAJ7+DMJ/MLMrFFJ+equ1BweieSGcDyryzCA8nLOG3TgeX0jymT6dj5hSlRjyuTFb6NbzXTbyoX5OhHks0e5DweFhhHwAlkaANGmvXVJ45jci3TyoMNoF6evZwIeIkaLg5XhHMLHaiXNHMY9VsVX6UQLYc23UGcLTeaNU2H/8DAhF9Jigy+c5CMaaEeqDFEyfqrvQYL+2uGZUqmB6odnGtAnm8HNwZhmUKY9Djki7f1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::9)
 by PH0PR84MB1647.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 20:11:06 +0000
Received: from MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3f85:d893:5637:278e]) by MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3f85:d893:5637:278e%3]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 20:11:05 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Topic: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Index: AQHZ0Ixvto7vnAASrEiTAeghAafYu6/tuDUAgAJzHIA=
Date:   Fri, 18 Aug 2023 20:11:05 +0000
Message-ID: <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
In-Reply-To: <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1914:EE_|PH0PR84MB1647:EE_
x-ms-office365-filtering-correlation-id: 9a37fd0b-99e7-4828-7670-08dba0274115
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwbbJdQrWE4Q47aHfOEY23xyDAMywzeVVPQZFNbJ5ILW8y0nsZjLrXCbk8eCIp++eMaNOpdrQ5C2Eqc5ao17OvaJDuH23Y5jepkDBExis5WLQsS8kaFsZw3z3RXE7giFZFUCTu1F3RVP8QTy9ZsOqL7J/MG8l9BvXx+iomXWhUOz7Wq9nvzVkPu1Drl71OcDyjUiZ8AjmrVvdjg0SGPD0ANBQRljuD0iDSk6QxzMKToJk1lGxcUBcVwxh02PopzCONe+UXIIytsZACyeB7yWQYF0bDDjMLZjNWPYWg6vREKbbZxSJ/Mm6IobpS7FH3eYN48bagN4yyxkMs20QkVfngaFQAfkocMqesrh5MS3uE0A7bj88g2RWeFRlEHIZxLyFz18MHtE29s3VLvQv1f6G2ZSEkzy5AE4e237gN6VwHuwjZmEspA/U5taxYdj/Vt2hLapXSt84DYZ/K5Qk5FxzOJqCRIoSYRmt3Dtbe8yLa+SZfLpdgTEO9EPaNfNW3iW7lrDxc3qHzUXam9aPaNEq9OYYs9cWoiy6CtlQmFODhvmvHAyNyLuJ6KgANqP8Nqr2HKEXaMz6cyTYGpSAO9x8cOygujJosQFeHfPi952I+GRUeIT6ODP0aQpuQg348EUusy6VaUPLvsW1vy1ZkxQNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(4744005)(7416002)(2906002)(83380400001)(6486002)(478600001)(316002)(71200400001)(66476007)(66946007)(6506007)(6916009)(64756008)(66556008)(91956017)(66446008)(76116006)(5660300002)(2616005)(6512007)(8936002)(41300700001)(8676002)(4326008)(54906003)(86362001)(36756003)(33656002)(38100700002)(38070700005)(122000001)(82960400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWh6ZGRmcmI5QUY0bm45bHppVGdHUVBkaW45TWFuS09OUXVZTFJzYnJCQjhZ?=
 =?utf-8?B?cE95SVlsUXJrWk5ZRGRhMnJFOTh4K0ZrM0lIcjdXMlg2bFVLY1JKQ3BBVUkz?=
 =?utf-8?B?OTRxdVoxTDBMWmE3TXVsSWcxcytOVnozUHRkVUtRUkpPMGw5WHBET1NxOUFn?=
 =?utf-8?B?WnpHck9qazd1TWlza3J5dkN6VlJNVXdxWHI5blIrVUU1SFJHbWQ2azBtb3hO?=
 =?utf-8?B?b2x0UjJFUUFzbUN0VzhhaFZOY1dPeDNlc2JiZ2dPRTZXa29rS2R3WnJKMklz?=
 =?utf-8?B?cjgxeWg1cnBpODkzRUdFRFJjOUhWWEF2cVNSQysyZFZpN0RSZVRKem5IVHYv?=
 =?utf-8?B?SUFmUnhQZEpDbGhpQU5JR0VsMEtTRkVBeTZmNWZSOUI0L3Z6YTg0RUZjR3cw?=
 =?utf-8?B?MHcrdzg5WWdzS0tRQ2VBYi9KdlZSN2hJSS9zckpiaDhzMmdOcWFJb0RiQTNQ?=
 =?utf-8?B?bDRsK2RWV1JQT3FYakpIUUl4cXpNMlJHaVkyb2ZnVGJpZXJua3JQeGZXdDhN?=
 =?utf-8?B?QjYrT1FCT1NoUGdzREt0WGlzYytkWnVhbnd0ZVJoZkg5VldBSHhha0x2cDFF?=
 =?utf-8?B?cHNwbjNFSFpOMnE2ZlVJb2kvVFdXNEFUbk1uYVJXUWxvOG9CaFJPbjhpQ05q?=
 =?utf-8?B?MUtXRFJKYnZCRmw3S2Rha3VjMXNpbmJqUE1lVHVId05rT3VVN1pVM0NrZVZQ?=
 =?utf-8?B?d0hHOFJRd1lmS0xyL0d5YXNqb3F6emRUbEE1TUd1SVNvaG1FM2I0T3YrOW9r?=
 =?utf-8?B?L2ZzUHZvamwzeW1BaWVBcFVPRTFZY3cwNlhUZDI3VFRZYjhMRWdWeDZJU1pl?=
 =?utf-8?B?SThuVGVYcFBzS1IvT2RqOVFobXVMN1A4NU8yQjF4RDkxaVhlMkhuWWZVaU0r?=
 =?utf-8?B?V0hFWHNzaCtVRTRQaFRPS1FxUWEyOVAwOS9pSFFmUXRxQUQ4NVFxR3c4aXNv?=
 =?utf-8?B?TzFFbWdUUTV2U0UyUGI4V0xzdmdvcjluSzJHNHNaWWpPZU5yWkVOQUs1WTFH?=
 =?utf-8?B?MXNVaW9zdHE4aTRvemw4bUlnYXpMUUR4N0phNkpUQnB0RFBuc1lMTnJ6SWNU?=
 =?utf-8?B?bDNQckEzWjM4NkhHZENjcExhTFdtVmhMbzlud1hKQUtPSU1FNzlaTTB0bWZi?=
 =?utf-8?B?SVhsM1I2R0pzV1BGK1VFdDhieENiYkgvSVVzRWdmSnFyNUxqSjZQRzRTQzBi?=
 =?utf-8?B?TDhKUnVUbkRRK1ZDaDNJanBsZDNjTGZ3bkJJTU4xWE80Y2FSWXlvS0YxMHRQ?=
 =?utf-8?B?SVVaWmF5ZHNCTTN3ZzZsTVBtVTI5dnRpM1JrZHBPb1VpNm0wUnMvZXRsVG5N?=
 =?utf-8?B?ckZFcFJ2TGQyTkJZVE1RZndaeExkZkhMSVIyVzZWZ2VXSUVMb2Q0SGtwWWFj?=
 =?utf-8?B?V053MmNaTkh1Zm9USmY1NEowakZrdWNuR1BLb2RMSXovVkJmM0pWR2hxTmhO?=
 =?utf-8?B?aXVISGVscnVBUHY2RytoSG5ZNFZwUU1RdU9JeitCQnpGUkNNNXlxd1pvajU5?=
 =?utf-8?B?QmtZdmxiZ1lPMlNIZzRRYTg3cnFkQ2pHeTJvMVB3enk2WmdjVDhlWW0xbjJQ?=
 =?utf-8?B?QlNlUlUydHFIZFVBTG9iYWx4SncyOFJ1bjNSczdRRWpReU9tVEFTYXVLdjdK?=
 =?utf-8?B?SnlRSzQzNnB1S2lsWTBMK2xFTmhkSUY3UzdCNWlxM2ZoVUhvU2RrUFc3Q0RO?=
 =?utf-8?B?eTBQVFFnSmhwS1c5c0gyUFk5TmswUXZmTmlVdHdES2tCQ1ZITGxnOWlOcFdy?=
 =?utf-8?B?SUJHSWUwQ0w5c3FJQVFsLzNCbGxpVllRYzQyZjFkOENvbUhsdWNXRURXalBs?=
 =?utf-8?B?WHlVdlRGY2NjVUd6TExRMERmUkRpL2drOFp1dDUyQ3FEZEliS0pFWml6WEh5?=
 =?utf-8?B?eHJRa3JxV3BnQ0hoaC9nZGNVQWJuZW9OQThwVkFUcHMvZVZOZ0NCUGRsT1hR?=
 =?utf-8?B?eE9VdmRvWUtVL3pjeVAvU3dybFBBaGxnMkdodEtxOGdXUHlLZ01jVWFPVTVs?=
 =?utf-8?B?KzFodzJtVEFZYmVnaW1kbW1VSEdCVGg3NHg5QUVMc0tmZ3FTVkJvMlVML1ox?=
 =?utf-8?B?TjZkU054dkwyYzFPZGVuektPbTd2Vk9aQWx2MThaRTJneWlBRnlDZjVXcWdw?=
 =?utf-8?B?aEQ3UE96MExXZnFiT2tLajcyUEllSXhicG1PeHpkVGdKQWZUbTNtbXFpTTYz?=
 =?utf-8?B?T2FPZ09tRHBIWDhKaEZ6ZS9XQlFSZHJvaEpZNlQ3ZTZMS1lRSkwvcUhnZ1ZJ?=
 =?utf-8?B?aWFRRVhVb05uVkNTQVFaWnZsNUJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FA8331DFE3A8943982D568AE0774279@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a37fd0b-99e7-4828-7670-08dba0274115
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 20:11:05.8593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Huq4N4+X9zXVSUVSGpQ6ADRXBfA+b62i5tiQnkB1ovMFdVtrceUK/EJ4Env9qlAhCDo4aa0ey5pCBo6NXcCYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1647
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: FJntL7voDYBIxWvvVtPrM6qsHeVUfH1s
X-Proofpoint-GUID: FJntL7voDYBIxWvvVtPrM6qsHeVUfH1s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_25,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=903 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0K77u/DQo+ID4gKyBsZW5ndGggPSAxNTE0Ow0KPiA+ICsgfQ0KPiA+ICsNCj4g
PiArIG1lbXNldChwZnJhbWUsIDAsIFVNQUNfTUFYX0ZSQU1FX1NJWkUpOw0KPiA+ICsgbWVtY3B5
KHBmcmFtZSwgc2tiLT5kYXRhLCBsZW5ndGgpOw0KDQoNCj4gSXMgdGhpcyBjYWNoZWQgb3IgdW5j
YWNoZWQgbWVtb3J5PyB1bmNhY2hlZCBpcyBleHBhbnNpdmUgc28geW91IHdhbnQNCj4gdG8gYXZv
aWQgdG91Y2hpbmcgaXQgdHdpY2UuIERlcGVuZGluZyBvbiBob3cgYnVzeSB5b3VyIGNhY2hlIGlz
LA0KPiB0b3VjaGluZyBpdCB0d2ljZSBtaWdodCBjYXVzZSBpdCB0byBleHBlbGxlZCBmcm9tIEwx
IG9uIHRoZSBmaXJzdA0KPiB3cml0ZSwgc28geW91IGNvdWxkIGJlIHdyaXRpbmcgdG8gTDIgdHdp
Y2UgZm9yIG5vIHJlYXNvbi4gRG8gdGhlIG1hdGgNCj4gYW5kIGNhbGN1bGF0ZSB0aGUgdGFpbCBz
cGFjZSB5b3UgbmVlZCB0byB6ZXJvLg0KDQo+IEkgd291bGQgYWxzbyBzdWdnZXN0IHlvdSBsb29r
IGF0IHRoZSBwYWdlIHBvb2wgY29kZSBhbmQgdXNlIHRoYXQgZm9yDQo+IGFsbCB5b3UgYnVmZmVy
IGhhbmRsaW5nLiBJdCBpcyBsaWtlbHkgdG8gYmUgbW9yZSBlZmZpY2llbnQgdGhhbiB3aGF0DQo+
IHlvdSBoYXZlIGhlcmUuDQoNCldvdWxkIHRoaXMgYmUgdGhlICNpbmNsdWRlIDxsaW51eC9kbWFw
b29sLmg+IGxpYnJhcnk/DQoNClRoYW5rIHlvdSBmb3IgdGhlIGFzc2lzdGFuY2UsDQoNCi1OaWNr
IEhhd2tpbnMNCg0K
