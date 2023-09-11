Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E508679C47F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjILEHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjILEHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:07:05 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C61B470F;
        Mon, 11 Sep 2023 18:28:51 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BIOcVr029738;
        Mon, 11 Sep 2023 21:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=BuAVc2HOCGp25QCta9Ohq8WIcaILQhb4U694dmymVnI=;
 b=NtWNHqpqX0r8o0lHaQV5NXm3ZHaaijNHo1uYR0eL677dPLTwIHnwuJfbQUo5KQMFgxs6
 /i6vmZbIBF7TT7oO4brKxDAc4f0VS6cDp11x2RL8D/VjGKBiyKZ4izO423SCDkCTeB2M
 KxRjyeBxvesX48R+4pAsHbzaItayaiTOY5w1jmo+wD0w8dy8BU0f7VwxFq+gfWnreK6l
 W1CZhbmvLLR0mgmA0QTOErRPgqkDGpWKvZGGg6Lh4TYPG+GQC15m4hOW9PDAkh3jrbOc
 MwQ9Ds7WzYjZqb0hEmehkDtorHZ8qVz0VP45MJ5IhGEUIFjVHt/iY1qOwJshfrmYEzD6 Eg== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t21eywe4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:13:01 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id BDC1D805E5F;
        Mon, 11 Sep 2023 21:12:57 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 11 Sep 2023 09:12:57 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 11 Sep 2023 09:12:57 -1200
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 11 Sep 2023 09:12:57 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIVWvzScNBVTk4TmQ59HKSPelQtBLsoB74ICU96dsbcalEUKQNuXMQj8ldw8eoJXEfezxYLrxWej7d30CTAnlT/WJ6OA51u2N1QOR30FQ+AAvP/peOUOdZHMF9ZNwTmTwK1KGzRrjKUww0ctgXDKfhNm/HQQF5x/ugKsugZBVA8EZlkzImetriYCI5HY8biZyXS3y8LzLjw9Buvtd624ZBBVEk0lu27CW9yhCByWMWFXstOYxLbMqbX7epo86CHYEfRAdyHWD7y/jaqU/CCwqG1wJeQErIN3gJ7NfJK7uicP/z9s7T6aZP0MohA6NPo3b3udeTl27zvqT3N9YOQG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuAVc2HOCGp25QCta9Ohq8WIcaILQhb4U694dmymVnI=;
 b=WxC77qYjgEcGoEqpG1wShZN/cFgaTdxnfl90lEDXKyVb1m7Vt+J+/JGIqkvkDyKuQ5gM3QiXTy0TFXwdxx5yyKy+zOesGqcsZdQIt/2YUXpLqI5qOFei7LCmEDpT6zT911tajBQjsag72iUyVNjEWGfrc3+5mCvtCKx5kBHuWRZiOqiBAhEcxqHBFruXWJZKDbBBJhVxRbCA7NNh2Pduxnt9R+Y4vuEqMqTk8cb+KMqo9i+9BddGRIvnbJqTozOcKmcijj3MSPCW+4Bo+6vkt4FHnNNZ1QdRabxCVXARwnrP6eI62c7RxdYegGYtzXxYtar8YM5JtILDESv9bsDFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH7PR84MB1510.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 21:12:55 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 21:12:54 +0000
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
Thread-Index: AQHZ0Ixvto7vnAASrEiTAeghAafYu6/tuDUAgAJzHICAAGX0gIAFz7wAgABkmgCABKKvcIAOvqCAgAvNn4A=
Date:   Mon, 11 Sep 2023 21:12:54 +0000
Message-ID: <3DB6DD63-C8AB-4009-8AF8-79290054AC5C@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
 <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
 <CF9BD927-B788-4554-B246-D5CC6D06258F@hpe.com>
 <befbee5a-7b11-4948-a837-6311dd4d7276@lunn.ch>
 <DM4PR84MB1927E85827B5450F1952E58A88E3A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <729dcda6-2d2c-4054-a570-17cdf6e4e57b@lunn.ch>
In-Reply-To: <729dcda6-2d2c-4054-a570-17cdf6e4e57b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.76.23082700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH7PR84MB1510:EE_
x-ms-office365-filtering-correlation-id: f748c2c3-0aaf-4e54-3b61-08dbb30bdd81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENYm97tm+JzNMDnsXrF1veZH8jI1aokCDbzTDH/CdiTP3MwWvEIOtEP1MpoDZkOsUgTBOT/apI/o32Y32V0IF9DDJvi3AjEPYv8wR+9g2G1OTHm9u4Nq576XEUHC9/PdidBru9gajB0dHjhBsrPJfcg0peFvnS4CsOs0swR9zxTwTj5Mfi0HD6t+z9Np/G/1OXw6eNdehh4UcuHqnqATz8VktgBQO6GLuBUB1Ue/cmj7+0h8AFIJRaLyUxKMyXiFhpJi2pHru9axcEU+44qj7W6x51ui05PscvjnGzfwHkz6exFsYMWZemTLC++GX+d83KCrz6QDHESp/Dv9Yeq+0f5ya8H0smrwPs4lpUEWc9+9PLz5WQtVPF4Ds77yJphsQASwGZf/ps5KpI4+GVW+uVEidMNr7f+pMQDY7wK9QmC8RybvfU+msZNp1XgtlM1eJomsGpOWalU3y+/aE58qWa8YW9fLMxBLld0VPMSBGrWTU2+hQUyUbm5gCVMY/spl8Tida+mkxJ44x4lSLNAjZ7q84TKi1V+0BfAnDFZb9eB/4cOPGW39OzJkkBfc6dPfmZGlrc6oB42s05mmGKcNYjDVlwcpZH3TYIHqib/BSurOZj8syed3W2bjmOcpcvxxTpZPNDeMqcPBBnMYbSWfCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(5660300002)(64756008)(54906003)(66446008)(41300700001)(4326008)(8676002)(8936002)(66476007)(6916009)(66946007)(316002)(66556008)(91956017)(76116006)(122000001)(478600001)(36756003)(71200400001)(2616005)(33656002)(7416002)(6486002)(6506007)(2906002)(86362001)(82960400001)(38070700005)(38100700002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1RVR0xjWTdPU1BQT2Z5Vkxza1lldy9EVmJ0bERjVElSMnZCSmZ5a0tockxH?=
 =?utf-8?B?UkxOZ1NqdjhZUlRFNWI0dzlZSG81R1BOaFEvZmo3MmFqclVtbW51aDFlMHpJ?=
 =?utf-8?B?MFRzcXgvN1AwNm41eHVHQWlGcVV3bE9NUXhSMnpSZTM5OVExOStQSk04ZENV?=
 =?utf-8?B?SlhiWHp1eGw2UVgraXVVWm9jWWhRWW9ZRFlqWkIyZ056dTN3dFZlbXZjcjBr?=
 =?utf-8?B?eGx3TVJwT0JpNVFPYVE1SGNwNUJBN3FHcnZaa2s1Z2xrR0tXYldSMlV2TzU5?=
 =?utf-8?B?Q3E3YytRNGR3TkREOWIwNHVWN3FpdVZIeHhLRDlqSmJKQk4vMTZ3NWVUT2Y0?=
 =?utf-8?B?MFErTDd1SkhCcTZ3L0puR0dxYmxIT01nVTZKeE9TOXEyMFF6Z1JxaDRwTVgx?=
 =?utf-8?B?bmQ3WXhIZGFpdmYzVTlzTDZ0Z2xvMm1DYUFGbnFlS1ZsM0Z3VXRtTUtFa0VR?=
 =?utf-8?B?L2JqYUpsbUxhckdZSDk5V3VRK2xITk9yUHUzMXY0T29WRThWTHNzN2lqcU9P?=
 =?utf-8?B?aloxRnBYNnJ5MEZrWGJ5S3gzY21IanYrMnhnVWhLeWtFZ2I3WTFUVG1YWnNS?=
 =?utf-8?B?SFNic2xucDJBU2VKc2VaMEw4eEc4ZzB2LzdZRmdNWWh2SnlKNWVYNSt3U2Zm?=
 =?utf-8?B?RkV3WERYUmloTlExajFOUTQxYnRNMGRSeVgyL1NMa0VkcTBORENqNUhYZ1NN?=
 =?utf-8?B?bTB6QnFIcVplbzBiL2ZKTldiN0IrNHRZQVo1Szl2K1d6NTFxVVd3alNyNWNF?=
 =?utf-8?B?b3VLSmRlOUpiVHV1VTZZSEpINlFVM3phNVdZU1NKR0hwdWVKRGtlc0hZM1Nt?=
 =?utf-8?B?Qkl3QU1MZFNsTGc1cktVbUtpUXJTVDVaZWppR2gyZHd0eDN1OFJjWDRycnov?=
 =?utf-8?B?dGNJcnNDSkVUT3RCSlRheXRJUEVXdUQzcGR1T2Z1MkN5QXVnZHVPcnRVZHpQ?=
 =?utf-8?B?alNVeEdpS3lISVZ1WkJ4bVIvQUl5NSt1KzRpUDNhdW5PRzdjSlBRZDZSa29v?=
 =?utf-8?B?K3poQVI2Ym1wdSs0Mk1WZ1NyYitwVGE2SWVBcmJlVGxqek1kV29ZUGNJN1R0?=
 =?utf-8?B?VGg3R3laTmlqMHdUL0F3dGJKSmQ3bUZEVHUxTUhJaU80bXJJMFZLdEQxdElV?=
 =?utf-8?B?Qkx1ZksrWUxQU1pJUnpSSDBicUNidUg1aEo2aEQwK0svT1JsZWR2TkYxUTdK?=
 =?utf-8?B?SnVQVll6Q0xERmQ0WnJQM0VGa25hbVc0NS8ycDdCZnFyR2dONGRFRjBMUEhv?=
 =?utf-8?B?bTZpenlINXlvTm9ITGhPOWlud3dNclRKeStZNkhqQjAxcnlxQzcvVmlSS3Az?=
 =?utf-8?B?NzNqcjJsK2NGUGdPWTZtZjdicTVjbGMwRkxySElLcHdlNktqQThZM3dUanJY?=
 =?utf-8?B?NU1iVEhGczF1TldQTFpuSjU1Z3p1N1cyOG4rK0VvcFJvRFpybGx4c1JiZU9u?=
 =?utf-8?B?ZEVCaEYwMlpHcXJjbmZEUW5vMzZKQmZpaFkwVC9TdWxmWGRuRWVQNkRISkZB?=
 =?utf-8?B?UmR0bGdta2xnc3BzU3ZKVXhQZFBwNmZnMUxWL0NBVEhjUkZ0aUxnV3V3aTYw?=
 =?utf-8?B?dzgwNnE2VDVoYnpuUlFHcXpWVVlFejNsQ2s3R2hVMTNNR0h0Y0VsdllqSFR6?=
 =?utf-8?B?ZTVsTkc1ME1xZzhQRU1HZS9FZ1hBM0dPdXo4M0syaXhRMk5Ec3BSYWdMcDll?=
 =?utf-8?B?ZHJkalk0d1dCNXNYMm1ONCtuTnNUb2dkU3VoeTM4Vnl3c0Y0UE40aE5lQ2Rw?=
 =?utf-8?B?anNUUmtXb3ZpZUEyRFYrenQ2clRqelNiMjIrbUtzemRIY2orRkRON0JWZkQr?=
 =?utf-8?B?MU9zTWZTdXZhWUpNZXpKdHFTUWk1ZEtlME9FZm1LV1BKRTJOZklnSXM2dU1w?=
 =?utf-8?B?djdYc25ZU2hYMnQ5WmY2aXFkTW1YVEZpcmpPSyszaUtqYXp2N3ZsTm5vN0tU?=
 =?utf-8?B?VjZCdTFFZis5K0gzdG02RE1pSG9SZkVML3hONzF6UmVNQ2JWQXNIZk8wZ1F4?=
 =?utf-8?B?RitlajRTaE1zVUxaMElkSkJRbGcxL3BTVENtZE44MktER3lZL0VJS1U4Yk51?=
 =?utf-8?B?Tk1RYmdPdVpReFM3RDdZNmZ1TXdkbEc0R0VsQlRpbkk2cUlCZjkwWTRXQTZn?=
 =?utf-8?B?Tm5NSWdWY0NIZE9kZXRVaERWMnh6U2Q4aHZSWnQ1eEtvVDJGZUlaYzdFRk9S?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07F20AC5ADBEC54882DCA75D5A39E07D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f748c2c3-0aaf-4e54-3b61-08dbb30bdd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 21:12:54.4720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jt4DOw/H5J6MX/Pa6HaLQPqjRxB7D5HT1lGZjgWY7gt4r8V7TDLLikIm6U7fKl3aWuqgyxoV0YAtx+2y2q/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1510
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 6d6DOpJOC_NqLeoy-PKjDpbfi_7-uL_9
X-Proofpoint-GUID: 6d6DOpJOC_NqLeoy-PKjDpbfi_7-uL_9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=876 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gSSBoYXZlIGJlZW4gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93IGV4YWN0bHkgSSBjYW4g
dHJhbnNsYXRlIHRoZSBjdXJyZW50IGNvZGUNCj4gPiBvdmVyIHRvIHVzaW5nIHRoZSBwYWdlIHBv
b2wgYXBpIG92ZXIgdGhlIHBhc3Qgd2Vlay4gSXQgc2VlbXMgbGlrZSBpdCBpcyBxdWlldA0KPiA+
IGEgY29tcGxleCBjaGFuZ2UuIEFzIHRoZSBkcml2ZXIgc2VlbXMgdG8gYmUga2VlcGluZyB1cCB3
aXRoIG91cg0KPiA+IHBlcmZvcm1hbmNlIHJlcXVpcmVtZW50cyB3b3VsZCBpdCBiZSBhY2NlcHRh
YmxlIHRvIG1hcmsgdGhpcyBhcyBhDQoNCg0KPiBJdHMgbm90IGp1c3QgcGVyZm9ybWFuY2UuIFVz
aW5nIHdlbGwgZGVidWdnZWQgYW5kIHNoYXJlZCBjb3JlIGNvZGUNCj4gbWVhbnMgbGVzcyBidWdz
IGluIHlvdXIgZHJpdmVyLiBJdCBtYWtlcyBtYWludGVuYW5jZSBzaW1wbGVyIHNpbmNlDQo+IHRo
ZXJlIGFyZSBtb3JlIHBlb3BsZSB3aG8gdW5kZXJzdGFuZCB0aGUgcGFnZSBwb29sIGNvZGUgdGhh
biB3aGF0IHlvdQ0KPiBoYXZlIGluIHlvdXIgZHJpdmVyIGFuZCBpdCBtYWtlcyB5b3VyIGRyaXZl
ciBtb3JlIGxpa2Ugb3RoZXIgZHJpdmVycy4NCg0KDQo+IFNvIG92ZXJhbGwgeW91IHdpbGwgZW5k
IHVwIHdpdGggYSBiZXR0ZXIgcXVhbGl0eSBkcml2ZXIgYnkgYWRhcHRpbmcNCj4gdGhlIHBhZ2Ug
cG9vbCBjb2RlLg0KDQpHcmVldGluZ3MgQW5kcmV3LA0KDQpJbiB0aGF0IGNhc2UgSSB3aWxsIGNv
bnRpbnVlIHRvIGF0dGVtcHQgdG8gdHJ5IGFuZCBhZG9wdCB0aGUgcGFnZSBwb29sDQpBUEkuIElu
IGFsbCB0aGUgZXhhbXBsZXMgd2l0aCBwYWdlIHBvb2wgSFcgcmluZ3MgaXQgYXBwZWFycyB0aGV5
IGFyZQ0KdXNpbmcgYWxsb2NfZXRoZXJkZXZfbXFzLiBBcmUgdGhlcmUgYW55IEhXIHJlcXVpcmVt
ZW50cyB0byB1c2UgdGhpcw0KbGlicmFyeT8gSWYgdGhlcmUgYXJlIG5vbmUgd2hhdCBpcyB0aGUg
dHlwaWNhbCBudW1iZXIgZm9yIHJ4IGFuZCB0eA0KcXVldWVzPw0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBhc3Npc3RhbmNlLA0KDQotTmljayBIYXdraW5zDQoNCg0KDQo=
