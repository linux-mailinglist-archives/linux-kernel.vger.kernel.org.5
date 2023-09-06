Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC177793FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbjIFO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjIFO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:56:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA068172C;
        Wed,  6 Sep 2023 07:55:52 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Egmfh018988;
        Wed, 6 Sep 2023 14:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=DhtlG4tI78AhxTCLtFlWb0FfER1U06XRxygJKPXShLM=;
 b=Cg1InBlZPTcdtBEwC10m+Q+mc9l6Aw2mhgLcqy4uMQQGE9DbiiQvkAPTA3RpTta8lTPI
 5lEHdkkleE0hLCJSZ6wpTwrrMoSA8Ckvwm9qk46yoh/Arp3dQPqO3jL7zOYD7D79TBuY
 ui3HM0YL0p8Gym6P3BXChKtPknGaYD7zxadafEqc0Y+GiTaS9LcH3dtks26yFe8iE4f/
 lVmiktNzXM5DWZlWTUS/VkU6xoT1MBEtZzU9xx0D2gpJpTPcs8ZBc5jak4rQNpVfylP7
 3GZw4LC4ol7ZtyQq1HH2tmwdFEWQyE1ZE2Mr0Y29ZcJ+PlORtwVfuecqrdTBhj/UHDZK 2Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxudvgfdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 14:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZTpnasT2dZ8sCyJ3kZsBFl77ldhi3HLpM+vlleDaMr5RfwnauSFBdlOzmHoTvbJojSPFAndHYZr7nS7wP7XH0NdBr+W1zPgR9tL7LNFakbLw/B0qVjNqB3XwfhlkXBZKA/mFOmY2tSpaMMkeVSqU8lLY80VldpXTyzrZE1rsMLa+JY1Jc3SifLGlYZX2sL3mm3cGBTy27WoHSmCaHsDqBQbTo5Co8iMU0ZseG9czT/z7zKuBA3tCAFyWc86ymc6BvlIIFSKEreyac9N5qcb+EWUX73Zc5eWdkWW2jrWicnwvO89JuJn8ioufTeBisuOnd9izQX3Cal5FCiIJzIKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhtlG4tI78AhxTCLtFlWb0FfER1U06XRxygJKPXShLM=;
 b=gxOsEgoiPlvy/fYUplwnbAHumjzWaQp7RJtkj15GQ3vz2ldNgx75i24QaZ/10yVPfoL1DKZuo4QnfBjY3UCfcTjii28zIKqVkreTirqrUz1pTx7WzCylw553jyqB5UfwZJfxC4pt/bVfcu6J/aP/pWBuvdwWyZ5yJxhpxiP9P2ZKNjOxTOGVTvE9Z5ab+Drcyyn1juThS4j60V1HXIVGH8r5OxY+yvg8W7QXsYilBPMhKlrA/9h2xCpcpouAc5ChT6oS4owvKYXr12KbtF1LQiRTP4whTPQngr0UuuNDlWzimd1z1+ATldHzaDew7QhHgjVE2A6M9yHz0qg/A/BpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by CH3PR15MB5991.namprd15.prod.outlook.com (2603:10b6:610:162::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:55:25 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::2f2a:b3fe:b586:16a]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::2f2a:b3fe:b586:16a%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:55:25 +0000
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v1 1/1] iio: pressure: dps310: Adjust
 Timeout Settings
Thread-Index: AQHZ2qTH2tZ1gfQHSkyFOqkUpy6dN7AJBSCAgASWGQA=
Date:   Wed, 6 Sep 2023 14:55:25 +0000
Message-ID: <D273D407-B2EE-4089-95C9-43CF937B91EB@us.ibm.com>
References: <20230829180222.3431926-1-lakshmiy@us.ibm.com>
 <20230829180222.3431926-2-lakshmiy@us.ibm.com>
 <20230903125309.12c59189@jic23-huawei>
In-Reply-To: <20230903125309.12c59189@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|CH3PR15MB5991:EE_
x-ms-office365-filtering-correlation-id: c6419065-383d-46d9-5d61-08dbaee94d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gUPPupXp7IhDaQA3K/bi1nj2TN4LKenN7xPxF6t432jGQZdVbWP31i4YIQK3muCoBVy09Qa4OuffHmD2x3curRT0DS9S43AlGhehYzB1oynK2zl3n5QvPzo7M2ICMA2o/ShfTEucFkeN+CdyFdoCHaOYrTg/oDJaAoDskqBbU0tL4jnSFrwPQDs7lcr4rQtNB9IvnBNaKA7gLG3gB124OEuHrCuqDrjFoh0abWsvoC/ulmN4hwOwqQGzeYDLWOX5Txpr6ZCxCGRgu/9VfvuqM5OcbZMDFnB9r2FTuiCMXlpfwfYhAw8SzzG8WsEg9fZd5SuDOFewEkFeUwmc3BHn0bP9ts3WZd8OFYrsPk7u5QcIL8nWCeVyujO2XdKSjAAmgdBhkjEaBiJI+WN9GV6GxfBm3ZKh31Dzu9gUGdkN1Qypu1Q6a9fzhaJvKz35rXw22c/ASzVdAFDRA48BmcaUN5ZLIOxapvuunCeqYveoSJveU4eWGr2rg+2V4TuP91i/hmuuYP3cAuXe3pwfxWA+VcQTB7QBj0uMXdItu1WEAgzYNV5+TjyndzywEvydWfwjeUOrtxQmYGrdmgrtad0w7dYmnML2e9FHiuXE9RQRrgI9UkC7pqxjwzgrnbHTaYBXFHI9fEV7cuB3QXozJHsIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199024)(1800799009)(186009)(478600001)(71200400001)(6486002)(6512007)(91956017)(6506007)(316002)(6916009)(4326008)(2616005)(8676002)(8936002)(41300700001)(2906002)(83380400001)(5660300002)(66946007)(122000001)(38100700002)(33656002)(54906003)(66556008)(76116006)(66476007)(64756008)(66446008)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFJkVW9XWkRONFlGTE5KWktLaTlMdnNDSXByczZnNUsvbHJGdDJMK1BYYzF6?=
 =?utf-8?B?bzFRb2ltUEZNci94YzA4MWNkc3VhakVZN2hOYmJmNXdQWTU5aTUwcEM3ditr?=
 =?utf-8?B?b3FEaHFiV1R0d1dhVytNQzZvWEw1eFNEdUFQVDQvT3dDbFlmczN3SVNBQ0xI?=
 =?utf-8?B?VmQ4RXYvb08xTmVybTJUUllFQlZIcGdwM24rNWFUM2piQWw1bU5iTWo4VEVM?=
 =?utf-8?B?VTRmK2pRVVMzK09oYlh2UktlUE1sUG5WVytTM0VaN2xmM0VuMy9Tc251NFFt?=
 =?utf-8?B?Q0hFR1VPNHBLWXVpSFlFNkRnK1VOZ2h3a2ExbkVHK2JUWjU4Ti9WMnprNVAx?=
 =?utf-8?B?U2JkZDFOcEVteHN3eU9wTitzMTRLZzMwSlVhUThQZEIrS05adlk3V1V2c2xa?=
 =?utf-8?B?dFZPY1dvZ3RuU3hEVk9yUVhKYmRnc0hLZ3piT2Q4aGk3eTM5cEFCNmFudml4?=
 =?utf-8?B?Z2tCYTNrZm9qaGFUNklPN0VFbVUwQ21WL0VCT2lqQnRReDl4T0RsZUZiT2E1?=
 =?utf-8?B?ZnZHYmx6NEI0RFJ1YURXSzBhUjdHeGx2VFBKR1A0b0N0V216bXRQd2s4QnU3?=
 =?utf-8?B?VEQrYWVhdVIzdzN0U1grbWZCNzlPcVhIVERmUUJkV0E5VHJzQnBWK0tNT3l3?=
 =?utf-8?B?dnB4U3E3L2d1a1ljYTg3NmdjZG8vQmNlYTdGUEd1RWdEU3hobFN3MERESE93?=
 =?utf-8?B?Q3hyOGIzRHRYZmY1YXhiQlNaeHFmVzNCUy9qVEZqaHoya1ZuRmkvTlRrUnFv?=
 =?utf-8?B?V3QzS3FQNGJ2Zk9KSktVRmgvQ01ib2lCdHkyM2hQZU5iV1prek5VL2h6K1dN?=
 =?utf-8?B?ZnRpZ0IwQnNmaWs4TDFxT1h0NlRYTHlLb1p6SURGTU0vRVpJUklvVWRRQ2dG?=
 =?utf-8?B?WGdwc0FqelVwNC8wVnBCTng3ZmhuV1BJMEZETEs1YWw4MW1DaDJhdTZ5bFk2?=
 =?utf-8?B?TTlDcGVPLzNNbFRiYSt1VzU0MWhWcVRGSk1yY05xUFpGSE9qUERNVEl4bW4v?=
 =?utf-8?B?eWQyTGpZK3JQVUpqdUxkejlmU1kzSzZpNDk0RUIyTWNiY1UzVlRLUVFNOEVE?=
 =?utf-8?B?UHJ6S3BZY1BhN0ZlWEJaU0JUSnk3WmJLQUdoTDZQc1BDSGFWbkwrOW1Xc0N5?=
 =?utf-8?B?cHVJOFg2Q1JpYTJza05oSkJ4MmU4QUY3RGZWandzYWkwK3JwbTFYaVp2dFBR?=
 =?utf-8?B?VUR0NWVTOWlBVWVOa081NUN6Wnk5dk8vSEs3SDRIZ1AwOHhRdEY1YUhBdkNa?=
 =?utf-8?B?WGhYTkRLTWF2eUllNHErMU16VGxHcXMrdHdKa25aWXlHSFFrSFIvM3FKYng2?=
 =?utf-8?B?K0YzMW91K1MweklNWkxoZzlGVE5mcjEzMWZDQk5taC85UmlaL0hsNHExdngr?=
 =?utf-8?B?eWsrUnRMN3BlcHVaTWJlUGVWNlVwYjcyV0hSS3UvMDlLNVVkZHVja2I0VGty?=
 =?utf-8?B?dHV3ckVlS1BjOE9uQ0QxM3hiTzh0ZHVSUDRTTE5nR29JcUhmaHMzbFRhT3J1?=
 =?utf-8?B?UFFJY3h2V1AyMGtwUVZ6MkpjYUJLZ3UvV2xMU1hzem1LWDRzeGNwT3Z1bTNL?=
 =?utf-8?B?RVZjeTQ5UWhwY21vU1FBUHJZRWxuamlhNSt2NlpIUm9oaHhZaHFwU3FDLzRn?=
 =?utf-8?B?QWVpL2lRcHRYM04rRGJkTHRoSFlzVFBrZFZVOWEwbWx1M3d3L2lOWU1CZlRB?=
 =?utf-8?B?RnZuTmV5LzFMOHE5QVRndTdsNmtFUGN3end1dmFFVk9WTUtESEFOcmZHazFr?=
 =?utf-8?B?UmRGTVFJL2EzWDhaSGNCT2VXRnpkRUpLb09OcFN0b0JSaUNXMGJxMG5Lc2xu?=
 =?utf-8?B?V3ZyV3FuS2VUNTdzRExsMGxoenZGRHk5UmNtRnh5MDV6VTU4bW5iOHMzU2ZJ?=
 =?utf-8?B?MjRURWY2Slo1ZTBnai91ZkZlUkFVUXd0Z01YU0NkcCtENlFoN2JnSVNRL0xU?=
 =?utf-8?B?MmgyQ1IvQkZaenBncFBkUW91eTVvcUo0WnNTMWEwdWk2Q252c3ZYMHYyYy9z?=
 =?utf-8?B?RXA1SFFrK3E4L1ZsYTZRbHZZNW0rUUxJeGJCZUo4bmtLSExRam9JR3o2aXdv?=
 =?utf-8?B?d3lNd0VhSHJmYUhWazRXTlB3cDEzQ1czR3JvbTF2TExGQ1JoL2x2SEluVzN1?=
 =?utf-8?B?RjVtSnd4SGMzZUFxdEMyMm9YSkQzWUNnUVdWVlBCOXlSRVA0Z3U5bGJPbTh4?=
 =?utf-8?B?WGgxOFlCRnl5Mk1semxncS9Cc0U5RlE3ZVBOcW9qSWY0a3p5d2JvU2RyV2E2?=
 =?utf-8?B?U2xuM20vU1VtTkYyanJJT0VPZitRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DCC5365A4D0F14995CE47248354E8A6@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6419065-383d-46d9-5d61-08dbaee94d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 14:55:25.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao1nyBX6/oJiYdiQUDIVs+WbNbdv0I4F2PGZC8jE66LH9Vr/ZFXmHbOrOD3nVc3aUIeGVSjC/dSZNSodMdmOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5991
X-Proofpoint-ORIG-GUID: bkd733F0lEoXfxPWZnXyQPDg5DgHCRAY
X-Proofpoint-GUID: bkd733F0lEoXfxPWZnXyQPDg5DgHCRAY
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v1 1/1] iio: pressure: dps310: Adjust Timeout Settings
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4ZXM6IDdiNGFiNGFiY2VhNCAoImlpbzogcHJlc3N1cmU6IGRwczMxMDogUmVzZXQgY2hpcCBh
ZnRlciB0aW1lb3V0IikNCg0KVGhhbmtzLA0KTGFrc2htaQ0KDQrvu79PbiA5LzMvMjMsIDY6NTIg
QU0sICJKb25hdGhhbiBDYW1lcm9uIiA8amljMjNAa2VybmVsLm9yZyA8bWFpbHRvOmppYzIzQGtl
cm5lbC5vcmc+PiB3cm90ZToNCg0KDQpPbiBUdWUsIDI5IEF1ZyAyMDIzIDEzOjAyOjIyIC0wNTAw
DQpMYWtzaG1pIFlhZGxhcGF0aSA8bGFrc2htaXlAdXMuaWJtLmNvbSA8bWFpbHRvOmxha3NobWl5
QHVzLmlibS5jb20+PiB3cm90ZToNCg0KDQo+IFRoZSBEUFMzMTAgc2Vuc29yIGNoaXAgaGFzIGJl
ZW4gZW5jb3VudGVyaW5nIGludGVybWl0dGVudCBlcnJvcnMgd2hpbGUNCj4gcmVhZGluZyB0aGUg
c2Vuc29yIGRldmljZSBhY3Jvc3MgdmFyaW91cyBzeXN0ZW0gZGVzaWducy4gVGhpcyBpc3N1ZSBj
YXVzZXMNCj4gdGhlIGNoaXAgdG8gYmVjb21lICJzdHVjaywiIHByZXZlbnRpbmcgdGhlIGluZGlj
YXRpb24gb2YgInJlYWR5IiBzdGF0dXMNCj4gZm9yIHByZXNzdXJlIGFuZCB0ZW1wZXJhdHVyZSBt
ZWFzdXJlbWVudHMgaW4gdGhlIE1FQVNfQ0ZHIHJlZ2lzdGVyLg0KPiANCj4gVG8gYWRkcmVzcyB0
aGlzIGlzc3VlLCB0aGlzIGNvbW1pdCBmaXhlcyB0aGUgdGltZW91dCBzZXR0aW5ncyB0byBpbXBy
b3ZlDQo+IHNlbnNvciBzdGFiaWxpdHk6DQo+IC0gQWZ0ZXIgc2VuZGluZyBhIHJlc2V0IGNvbW1h
bmQgdG8gdGhlIGNoaXAsIHRoZSB0aW1lb3V0IGhhcyBiZWVuIGV4dGVuZGVkDQo+IGZyb20gMi41
IG1zIHRvIDE1IG1zLCBhbGlnbmluZyB3aXRoIHRoZSBEUFMzMTAgc3BlY2lmaWNhdGlvbi4NCj4g
LSBUaGUgcmVhZCB0aW1lb3V0IHZhbHVlIG9mIHRoZSBNRUFTX0NGRyByZWdpc3RlciBoYXMgYmVl
biBhZGp1c3RlZCBmcm9tDQo+IDIwbXMgdG8gMzBtcyB0byBtYXRjaCB0aGUgc3BlY2lmaWNhdGlv
bi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExha3NobWkgWWFkbGFwYXRpIDxsYWtzaG1peUB1cy5p
Ym0uY29tIDxtYWlsdG86bGFrc2htaXlAdXMuaWJtLmNvbT4+DQpIaSBMYWtzaG1pLA0KDQoNClRo
aXMgc2VlbXMgcmVhc29uYWJsZSB0byBtZSwgYnV0IGFzIHdlIHByb2JhYmx5IHdhbnQgdG8gYmFj
a3BvcnQgaXQgdG8NCnN0YWJsZSBrZXJuZWxzLCBwbGVhc2UgY291bGQgeW91IGZpZ3VyZSBvdXQg
YW4gYXBwcm9wcmlhdGUgRml4ZXMgdGFnLg0KDQoNCkZpbmUgdG8ganVzdCByZXBseSB0byB0aGlz
IGVtYWlsIHdpdGggdGhlIHRhZyByYXRoZXIgdGhhbiByZXNlbmQuDQoNCg0KVGhhbmtzDQoNCg0K
Sm9uYXRoYW4NCg0KDQo+IC0tLQ0KPiBkcml2ZXJzL2lpby9wcmVzc3VyZS9kcHMzMTAuYyB8IDgg
KysrKy0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9wcmVzc3VyZS9kcHMzMTAuYyBiL2Ry
aXZlcnMvaWlvL3ByZXNzdXJlL2RwczMxMC5jDQo+IGluZGV4IGIxMGRiZjVjZjQ5NC4uMWZmMDkx
YjJmNzY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9wcmVzc3VyZS9kcHMzMTAuYw0KPiAr
KysgYi9kcml2ZXJzL2lpby9wcmVzc3VyZS9kcHMzMTAuYw0KPiBAQCAtNTcsOCArNTcsOCBAQA0K
PiAjZGVmaW5lIERQUzMxMF9SRVNFVF9NQUdJQyAweDA5DQo+ICNkZWZpbmUgRFBTMzEwX0NPRUZf
QkFTRSAweDEwDQo+IA0KPiAtLyogTWFrZSBzdXJlIHNsZWVwIHRpbWUgaXMgPD0gMjBtcyBmb3Ig
dXNsZWVwX3JhbmdlICovDQo+IC0jZGVmaW5lIERQUzMxMF9QT0xMX1NMRUVQX1VTKHQpIG1pbigy
MDAwMCwgKHQpIC8gOCkNCj4gKy8qIE1ha2Ugc3VyZSBzbGVlcCB0aW1lIGlzIDw9IDMwbXMgZm9y
IHVzbGVlcF9yYW5nZSAqLw0KPiArI2RlZmluZSBEUFMzMTBfUE9MTF9TTEVFUF9VUyh0KSBtaW4o
MzAwMDAsICh0KSAvIDgpDQo+IC8qIFNpbGVudGx5IGhhbmRsZSBlcnJvciBpbiByYXRlIHZhbHVl
IGhlcmUgKi8NCj4gI2RlZmluZSBEUFMzMTBfUE9MTF9USU1FT1VUX1VTKHJjKSAoKHJjKSA8PSAw
ID8gMTAwMDAwMCA6IDEwMDAwMDAgLyAocmMpKQ0KPiANCj4gQEAgLTQwMiw4ICs0MDIsOCBAQCBz
dGF0aWMgaW50IGRwczMxMF9yZXNldF93YWl0KHN0cnVjdCBkcHMzMTBfZGF0YSAqZGF0YSkNCj4g
aWYgKHJjKQ0KPiByZXR1cm4gcmM7DQo+IA0KPiAtIC8qIFdhaXQgZm9yIGRldmljZSBjaGlwIGFj
Y2VzczogMi41bXMgaW4gc3BlY2lmaWNhdGlvbiAqLw0KPiAtIHVzbGVlcF9yYW5nZSgyNTAwLCAx
MjAwMCk7DQo+ICsgLyogV2FpdCBmb3IgZGV2aWNlIGNoaXAgYWNjZXNzOiAxNW1zIGluIHNwZWNp
ZmljYXRpb24gKi8NCj4gKyB1c2xlZXBfcmFuZ2UoMTUwMDAsIDU1MDAwKTsNCj4gcmV0dXJuIDA7
DQo+IH0NCj4gDQoNCg0KDQoNCg0K
