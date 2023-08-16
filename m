Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A04577E65A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjHPQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjHPQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:26:50 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B996272E;
        Wed, 16 Aug 2023 09:26:45 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEYAZD013861;
        Wed, 16 Aug 2023 16:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=6xJYfzKpt32yVToesh9xtDAWjrudVT3keM2ecZdPiwA=;
 b=NIUQJ7Qhxj8OcIZGgvBCLUO4JyzvaBgEOyOsbhnY4e4v5tTA+e+cVJR3OQ9VwtgSvPOi
 saQAwFSMvvdOu6SpWAeK9klRl/34jfC2rhnzVFfgu6Ng7ecEluJmepkkKWWODG5CykF7
 ycOV0ygZuZHxMXrgLO5AlNI1R64kvqxCfBIT2gTU6F0Uft82171+QYCeprAnTDeTfS8x
 elIAbKlLBTMDF+78SSGlh+e0hjBS1gitc7kBcq+a1wUWeB+dwCmm8Q0xlbP1SZsKu0+u
 gtXfv+kjbUqL46A1ue+yAj2DkltdUGrY1d0UvQtoNx5oUi77I5LSbz7Oh5DNkK3SuHGk zA== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sh0b7h3m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:26:27 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8106C80171E;
        Wed, 16 Aug 2023 16:26:25 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 16 Aug 2023 04:26:11 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 16 Aug 2023 04:26:11 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 16 Aug 2023 16:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVlwEMsSldtGgsYnLtXbmqZLeMKDv9vAJA1ZwlLcczSX7QV7hdcgPe0r+KxswsM3ZAuZNqWL7YSXMlGd/Qa6/ne2ObTt80XhJTJC3TPyFUNVyKKUhH5f1HMHyoTBdaE4W7Ie+5BjFmkeT7dtEv/r9aXuayH6VGLWPCvlTwuOORygMf2m5+UzsJmsWWsSChMBOi08NbedNGhSA+K4nRAgnQQjqcFS4LU+sOrmdeM6EMffLr+YREENrHZBlOnTyCHVtwls2tixyoN+3HO2DBCvioxtEC4bxMnCkA/A5K5/bxa7cPO5eGldIkSdp2M/ByMJJREij3bE6IdnvO4wazd2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xJYfzKpt32yVToesh9xtDAWjrudVT3keM2ecZdPiwA=;
 b=YPmX1sXMfyKTG9D7O80W+rjtnLQpW8y+f6l+TQCHwcHfp9bGtwMeh5MG8js1qmjz9JJbhN+ND3Rt4URFOu38vO6WhwxZRFDTTsMYHHYHyogNX/fiEhy5IrtdI7OiArs9Cq5Ru/7bt/DeL/CZa9+Qgl9KHQKtN396Vo2C71fHWcePaK2+M7xChdjSxoHKQWN2wPPfM0pOyzSCUqIe5bVeaxn0vO84WdFUSKM9Glx3JTu3Dwz2X+/Ku+Fk9uPy7LbeVCnWoabDuF90NbJnnqaLgwpXFK5C0MY28mUI3DJhyTV4EuuSa7fCS0+oHCdQtHURM9a6GsHcS/OgT5NaAGoDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 LV8PR84MB3435.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 16:26:09 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:26:09 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
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
Subject: Re: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Thread-Topic: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Thread-Index: AQHZxX8HpW6LUsgbvEOsz6jyREjpq6/Yue2AgBQj+oA=
Date:   Wed, 16 Aug 2023 16:26:09 +0000
Message-ID: <AF599C90-1257-4C13-AF60-8680A812421A@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-4-nick.hawkins@hpe.com>
 <20230803-balance-octopus-3d36f784f776@spud>
In-Reply-To: <20230803-balance-octopus-3d36f784f776@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|LV8PR84MB3435:EE_
x-ms-office365-filtering-correlation-id: 4eb16425-4acb-4518-69a7-08db9e757fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1dAq1SvUtOxALShAd1I8RnWMIv+X2sajKEn0eLE8TGTrl9NRyDrw/ONhGXocIPJN3XDaGdU5mV2PFGQRqnWGYFDJCtWRFcEhBhe2i5D8sFzKKZvi61QA3A4yLg5vh6ZbxBJZ+Opx9c4jUIdQr/EVfjwasnOkb8yBuwdbAXKeChpPPh8M4B3rBM3SLqyJAYpOJG51Xs3HpoYhl3FIFOjdAQ5EzjB/Mxr6LIlHJ8wdw9ePbNYAWl5A8StPq2gctvL0C/rA/liiP8u+f5IhRtY6pV+fDYVhDlsVIu8VfQYOMBCNx+qG7dbGKyo5tdzyv3MgwJm7nILTepTjdp773tN3ft7uNgQfCv1Z8apel0fjewv2R2ZjTv1Mi/cpmPulP+CBEcGgM2Ewags0KIkP7Z1EN+MdIE+y7HX/QOTFLdWM8vQzHMQCSpstaHV58V6EEa+8yeDeGvaG02W3IuAkajXKoGPXXKaFScngvipBdRzXXzjhZZ0QZqSLI4hgh7EKv39jFIxNmsZTQ4ysGvhWSRUjX/CUY+JqiNuFYTVhg7HDD5qjdKvmzR79zsrZAWjb+XRDU/xQs0K4yL7n81iltbYhGbWk+IWF/9NrjanXJdPTz0s0et/Cso2JOhvTMuc8CpVl3NqIcs6cVyeqOrF4avVSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(6916009)(66946007)(91956017)(64756008)(66476007)(66556008)(66446008)(122000001)(41300700001)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(478600001)(7416002)(86362001)(6512007)(33656002)(6506007)(36756003)(71200400001)(2616005)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTg3aGgrNkdTWVNkVHFtM3Qvbmh6ei9TTUhDZ3NRWVFuMWtHbWRQSGw5dlVy?=
 =?utf-8?B?aG53MDR6K1I2MzVGV0w3N0RnaC9FbGlDQU5WdkhGUnhRVUgwc0ZEMFBwTE5O?=
 =?utf-8?B?VEtybVpPVTlhZEZ2RjNRbjA0TGl3VFdOSW9USTJKR1JrY1JSVVdxdmhwRjZR?=
 =?utf-8?B?WmkyK29ueFcrUmpLdTlYUmhpYm45UjdxQndrVUZCRnNabVNBRldJN3BWeGlr?=
 =?utf-8?B?UWpJV2FrYVhKcXp2VFA4WkpBQnYyTzFEczFJZDZBZVdtMHUreUNKLzlXNmV3?=
 =?utf-8?B?Qm1HVTR4ci9tYWVEVnM5MGp5ZVpSYTdjUFd2dGt3czg3aTdqTnlCVGFsUHdL?=
 =?utf-8?B?MWt1d3dIdTFORjkzUlIrWjJaZkRhMEI0SmtLQTBCY2JzUTYxRzVPQkY3MTli?=
 =?utf-8?B?MVBUOUY4RWdtK2hteXRJNDF0SHZlbCtaOEdYYys0WHhtOGZFNVQ3VExNL0VW?=
 =?utf-8?B?Nlp4RUlYNzF6a2hGUXRJcEZQbUZhdDd2M3g5bFNwTCtRS3lLYmRUUXN1OFVh?=
 =?utf-8?B?QUV5ZUIzQWdRZUxMK0ZRY1cvZ1I2NXd4QW43SjNxQUNic1dqTzd4L1NMQm4x?=
 =?utf-8?B?Y2ttK0FZUHdsWmxzNFFUUUp6b2M1Tk5ETEZ5T1J2cDcxckRBSzQ2TWl4UUJX?=
 =?utf-8?B?ZmFUMXl3YzFxTDZHQWc1U1pjRkhnT3N5YkNjaVFwc05NN2tRZDNOdXZDYXVZ?=
 =?utf-8?B?aThjSjlBN0UxL0dRUjhDb0I2T3Y5c2diYjhya2VPc1hEdC8vb3AzMHZMZ1Vr?=
 =?utf-8?B?MHZnYlMvTEZsbSswcUdwVHdoZVd2d3UyYUd0V3dibjFIY3Q3STdFU2NjTE5n?=
 =?utf-8?B?MEowNWxVNGxlKzNOMThodnpwRlprMkVhR1VoemxqQlBwZzNCNCs0LzEvRGY0?=
 =?utf-8?B?NmpXTllST0dlVEhCWnRrcWlUOTFNdXNuTUcvOTVscHNhT3JLYjV2UjdlWW9h?=
 =?utf-8?B?UkN3YXd5b0RucDd2ZmFIN2NGYWUybUc4TDBROTB5bWpMT1RGSWdFV2NZNWFC?=
 =?utf-8?B?RFJyc1BkTjFHd3FCRGxMbEVkeDFMM3RtWlA3YmpCeEg5RG1wUmRJTTJ4cnF1?=
 =?utf-8?B?SkhBeDZZTlRyVUQ3VzRBR25GWjY3TlQvZW9naU91cFh3eG1kTFlpNEFYQ0ZR?=
 =?utf-8?B?b2luMUVoNVBFemFBL1JDb0dkUkRxOGxsUEo5bEJyUzZSdnB1K0RQeEduQXN4?=
 =?utf-8?B?d0JCWmY2Uy9uOTEzRWRGZ052ZnA0cTJISFZFbjR1VUR5Vm4xU0FhTis3NDlH?=
 =?utf-8?B?ZDhvNjVrYUQrS3hHR2dGd3cwZjdJWE1QY0Y0ditBM1lkRnZlUm4wcXVGMmlr?=
 =?utf-8?B?SiszQ2pkaHVzb2grWmY4RjhvRHZoMkxDRlhsWWNlQzBKbDBHYitpV2FzcGVm?=
 =?utf-8?B?T25IK3JMNk5qQmxjbU9HRHJwbjl4eG9MRlVBamVxbTVyTExvTitWTHM3cTYx?=
 =?utf-8?B?TExVZk9aRkhMTnBhMlpNQUhWYWZuaGhFSXNibzFvNXNKazFxTUpES0hNZkRm?=
 =?utf-8?B?VTVTWVdQOWxVMCsrUGh0bCtkTWVnNklLNWw5bEk0R1dXanNkZGpGY1FDU2dW?=
 =?utf-8?B?bnl6aG9seUIxT2RvRHR5N0JTQzE2eW5XcjlRZWFaVVJGMEN4dyt0eTRnYjdS?=
 =?utf-8?B?cXY5S0FCOG1ZRXprUmRJTEhGSERSMnJhUGtxcGdjRVZycjNpVEpTQzh2enNY?=
 =?utf-8?B?NjR5UkpNeDhkV3BjcmdnTVhxWWdsdWljbWdDRmMrcU1PYUNodmZuOVBQbGpB?=
 =?utf-8?B?MXJFQlVzK09BSDAzcDREc01ubnlnMHNvZGtIVmUzSWplbVFiVlBhUXE5ejZ1?=
 =?utf-8?B?Skcxb3RvV0duM1QzV2g4Wk5waFRHMllVbUlleWRhcWE2dEFxdEY0eFlWVjc5?=
 =?utf-8?B?TWcyUU1oaTJ4WWhpS3MxUWhlampOblpETzF5TE95YlU2ZnBLUXlMM2U4TTQv?=
 =?utf-8?B?ZlBJQkNYT09wbEkwWW4zZnNqbjJvdjgwQzRwYlArWWtSdmt0QVJwK0FsanZU?=
 =?utf-8?B?WWNFVkloUjY4TkpHUFRCUGtONEkyNXpiL0FaRStMV09zQ2RKekJSOVF1ZGIr?=
 =?utf-8?B?UWV4L2ZoUEpGQ0s4MFFjWWUwdThNcW9OSlBYcGdDZDJLWWZtN2NVdG55Sk9w?=
 =?utf-8?B?NVV4eWo3SzVuZ1ozOHhBOWtDczZack9uOGZQcnRvd0g2UUdlRDBpY2UvejJS?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87F190B00CDDEB4C92C3EB03CF82850C@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb16425-4acb-4518-69a7-08db9e757fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 16:26:09.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dc5DJGbfbuNJNKyczbwR1hZ8f/X4s09QpMWl1Oo2wEMW1lAaD0iL18rnUXOALMkUAGjqOZjlDDMi3ckekyLCgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3435
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: dSR5KYVvFcTTZ80Fdk_Tt9rBz7GOSAIr
X-Proofpoint-GUID: dSR5KYVvFcTTZ80Fdk_Tt9rBz7GOSAIr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160143
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

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gSSB3aWxsIHByb3ZpZGUgYW4g
ZXhwbGFuYXRpb24gYmVsb3cuDQoNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyBIUEUgR1hQIDgw
Mi4zIDEwLzEwMC8xMDAwVCBFdGhlcm5ldCBVbmlmZWQgTUFDIGNvbnRyb2xsZXIuDQo+ID4gKyBE
ZXZpY2Ugbm9kZSBvZiB0aGUgY29udHJvbGxlciBoYXMgZm9sbG93aW5nIHByb3BlcnRpZXMuDQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgY29tcGF0aWJsZToNCj4gPiArIGNvbnN0OiBo
cGUsZ3hwLXVtYWMNCj4gPiArDQoNCg0KPiA+ICsgdXNlLW5jc2k6DQo+ID4gKyB0eXBlOiBib29s
ZWFuDQo+ID4gKyBkZXNjcmlwdGlvbjoNCj4gPiArIEluZGljYXRlcyBpZiB0aGUgZGV2aWNlIHNo
b3VsZCB1c2UgTkNTSSAoTmV0d29yayBDb250cm9sbGVkDQo+ID4gKyBTaWRlYmFuZCBJbnRlcmZh
Y2UpLg0KDQoNCj4gSG93IGlzIG9uZSBzdXBwb3NlZCB0byBrbm93IGlmIHRoZSBkZXZpY2Ugc2hv
dWxkIHVzZSBOQ1NJPyBJZiB0aGUNCj4gcHJvcGVydHkgaXMgcHJlc2VudCBkb2VzIHRoYXQgbWVh
biB0aGF0IHRoZSBtYWMgaGFyZHdhcmUgc3VwcG9ydHMNCj4gaXQ/IE9yIGlzIGl0IGRldGVybWlu
ZWQgYnkgd2hhdCBib2FyZCB0aGlzIG1hYyBpcyBvbj8NCj4gT3IgaXMgdGhpcyBzb2Z0d2FyZSBj
b25maWd1cmF0aW9uPw0KDQpIaSBDb25vciwNCg0KVGhlcmUgYXJlIHR3byBNQUMncyBhdmFpbGFi
bGUgaW4gdGhlIEFTSUMgYnV0IG9ubHkgb25lIGNhbiBzdXBwb3J0DQpOQ1NJLiBFdmVuIHRob3Vn
aCBpdCBzdXBwb3J0cyBOQ1NJIGRvZXMgbm90IG1lYW4gdGhlIGJvYXJkIGhhcw0KYmVlbiBwaHlz
aWNhbGx5IHdpcmVkIHRvIHN1cHBvcnQgaXQuIEluIHRlcm1zIG9mIHRoZSBkZXZpY2UgdHJlZSBJ
IHdvdWxkDQpleHBlY3QgdGhlICJ1c2UtbmNzaSIgdG8gYmUgcHJlc2VudCBpbiB0aGUgZHRzIGJv
YXJkIHNwZWNpZmljIGZpbGUuDQoNClRoZXJlIHdpbGwgYmUgaGFyZHdhcmUgY29uZmlndXJhdGlv
bnMgd2hlcmUgYm90aCBNQUMwIGFuZCBNQUMxDQp3aWxsIGJlIHVzaW5nIHRoZSBTRVJERVMgY29u
bmVjdGlvbnMuIEluIHRoYXQgY2FzZSB0aGVyZSB3aWxsIGJlIG5vDQpOQ1NJIGF2YWlsYWJsZS4N
Cg0KSXMgYSBiZXR0ZXIgZGVzY3JpcHRpb24gbmVlZGVkIGhlcmUgdG8gZXhwbGFpbiB0aGlzPw0K
DQpUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg0KDQoNCg==
