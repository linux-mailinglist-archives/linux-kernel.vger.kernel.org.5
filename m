Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882275C3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGUJ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjGUJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:58:23 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C7CFC;
        Fri, 21 Jul 2023 02:58:22 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L8cQ1O001459;
        Fri, 21 Jul 2023 02:58:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=qKIz+9c2m7iun3ANg93o9PxWL6cPoDNcL7LS4B8+bB8=; b=
        SvrrEfGe8RsvKfYMgInWh47Tntk6l8kduN0K2jXqewgpAsBjba0dGIf9561VFHUz
        pHcC14Dc6z9vkW4UBjkkbFLd7Wpxkh1ShDSKf7f1NrOj5EXtTJci9hjZGySTk8MD
        L/DF8tf2/NCpyODKhVZR/t6jtUJtIIky0UiPsQEm0Jd1XSLLY0XnesI4JPumiEU1
        m5P0XmAdfVVjcIIe6+0CL/ayswivus0JPNOuyQXPrUN5zaD2AeM+ltsZYQLkp6Cx
        XBGReJg2yxMoXu+aXNOMk4MGkG476enE3I6jo1ZbMHELcx8sPu/fVsZJh/Qd0SU3
        r+hh635lWE6x9MI3qEQyTw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rupqydkxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfoZxn1JjLIlyqEQv/tA0SnM7DGdFyRmZpYBDtUl4TPaQ+zJh3sumI8BALeHA088/tj+pWesH2Gn+tTUlJ6NoFTcaKwvNUz+N1TK0KarUboWmoe6ywHdlwZxbIjBp4dAntfD/NX4Uy47M1Puj00UVZWrm9uQU0Qat8KQupUSctc0drIKsCXkUGzDAiQ37xHWqIEw9woIdgJjBv+4ot/bbU9RXR0TfVXpk9qVCbwWk68F0vlrF/56cu0vhTO64yiTDsURpTPmDMYWx99uILftWbEHEPKhOnpDHX0TfOpbxWfcmch7324WZMxziAPscxJiX8CYW1Hsq2GVEhBiWp5g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKIz+9c2m7iun3ANg93o9PxWL6cPoDNcL7LS4B8+bB8=;
 b=d7ZM0ulGOQvTS0j4twbmWsOo0/+9br52SgQU3k97usV804DPG12HTtjmrBI/ajmEoKWTCXSjG/u7wC6XXXbbpq2z1LYWRmAY/FsjIaf2jnWkQKl/Ht+o9z2SMx2Ux57+MKNlo8fcJBncGRDXKHMtL50vXnqPqVoQ4EJFkm/ZYjl02X5s+EUe9/IINbzbY0khpWCGpamLpJCH4oQ9pmWF/OPPwKtMsFBmyVoiFi6pbf2z2FlDFUPLACOe2TW4+HFqPixsOQ/R2JUoned76fhPCmKu2uznd+yLENJ2YUrQ7QsfkDR6LPcxog2FhkdWpUuP0/UPUh5iltdMrkzvoj4WZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:58:15 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 09:58:15 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Thread-Topic: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Thread-Index: AQHZu67AcgeVg8NpVU6sDsseuKM3QK/D6aGAgAAAxwCAAABzoIAABo4AgAAAquCAAABwgIAAAFcwgAADLICAAATUIA==
Date:   Fri, 21 Jul 2023 09:58:14 +0000
Message-ID: <PH0PR11MB51911D9FF0CB5290370D4BDFF13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
 <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
 <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
 <PH0PR11MB51918208B7FE0413548F2DE5F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <846fad90-04b1-53e7-0f9d-1c243bbc6e92@linaro.org>
 <PH0PR11MB5191D789F87D7C9546F192D0F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <b4b56478-ac36-7fad-f771-8d545c022f57@linaro.org>
In-Reply-To: <b4b56478-ac36-7fad-f771-8d545c022f57@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|SN7PR11MB8027:EE_
x-ms-office365-filtering-correlation-id: 4d3d8b06-0dbc-4112-d8a1-08db89d1005e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peOCWM/GpRgoDu/sG246TOOi+L/ftuRxO7fe0UctY3SMmAmeMxoxgMqqhZToRSn5zYJV/jP28QG90jdPHvGDGChlN14CuqAzW6IDjqJN1pSWmQyl3hRy4rSqXjF+VsTsv38yC6uObvtLGzNfrJknPNNTigoCXbUnpNNQGZ0KHL1/stEwPri67oldJFJshC7Oe5l9Ct6ukFUv3mR/ARzPVOCZi2iMMOZiW0HyYxEN+rgo6zj+oiFozTfVVjKUN/O+/UDp5/gTcQm9P4eCZjNIWSuH74kWtKIssHETtylRkcsCxNzkePDDavzhbI7r28ZTopl95LVzrYOoi9ULUsp/Bo/Y7RtW9opvyXJylpmXHYWAYBt2yFKL8isw1mv4+SOiQvi+MdYgpnSs+M7s/fycakL3RekgCVj538W26ZVbqRdcvQpP/LLy9JoV/OQFr0n6oWUT9BwmKWTEnUHFiYIt4Hya9SA0rS2LowPQm7kpj9W7W5krJk4IFX7q+3V0FAWjo7eXkdSN4ylhVh98Vuq7BMy9cFMy1/gYbnkw7iErmeM0cWYfZmCbFS+XKZ/NkZjLZSX8PnI5YoF2KuoGp8Z6a7PhcjQ4CfFAsn3UtjYBhEp8KhoeHne9KaytLp6b/Zgna/+1DjZpOVMn0Gt0iETLyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39850400004)(396003)(136003)(451199021)(2906002)(9686003)(38070700005)(86362001)(186003)(53546011)(6506007)(71200400001)(83380400001)(122000001)(26005)(38100700002)(55016003)(966005)(478600001)(33656002)(110136005)(7696005)(66446008)(84970400001)(316002)(66556008)(41300700001)(66476007)(64756008)(4326008)(52536014)(8676002)(8936002)(5660300002)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRFUkNUaFhuOEh3emxGVVlXc1dGVHRYQmtoU3JZV3loYzVCNUtxU2wyc3pS?=
 =?utf-8?B?RHhKQUZaZHFhdkNDODEvSndKT1l2T3N1VTcwMk9qYWlndzBiRHZjQkI4NUI2?=
 =?utf-8?B?aWJZSjJUeWk1dTZHSnEzQk9SdzRacE85Zlp0OGplSXZWR004U2g5SkZMa0Jy?=
 =?utf-8?B?bHZ6bk5mV3V2akpUdVcrNDFLMFFzWWlSRXdNRVR6L3B2KzArK2l5SUlOMk1q?=
 =?utf-8?B?VmoxTWRSaXdYOGFwbzYrRHJaR3Z6TXVtR2tsL2ZqZURUTHY5UUdzVXR6T0lO?=
 =?utf-8?B?SlgzbFhCaEVPYndZWDlJWTNwc3RYb2kzUjNPR0lPcnVTenpTaERqU3ZHTkJY?=
 =?utf-8?B?ZGtyckdCSG4rUjROc3FyNCtDNGh2ZlJYT0hMcGR6Qyt1RHpiQkVZVmxUWlFL?=
 =?utf-8?B?V0VYNXptSng5MS8rTmhKTWk3YVhSbkFCT2JLQkYrNjhqcnNzamhnYlg0R1I1?=
 =?utf-8?B?dUFuVVczRG11ZGYvdUFMN0Y2cDdDY2FjOWFmL00zN0ZBaXpJaFVsVVNwWEQy?=
 =?utf-8?B?UzFSbDVVSjRGdWpOOURtSFl2TmMrQU1PVGxyTlQxS0dUNmR1TDl0M0FmODln?=
 =?utf-8?B?WG9oSGlMTEFhOVZLN0F0ZUpySCtmdGpDYkt3b2tqNGFzdzhOS3R0anZucEpP?=
 =?utf-8?B?VmwzbDg3L1puVy8yUjlENlE0aGkrTkFVZWE4VEp4UkgrdWdBSkhUK3puMzFi?=
 =?utf-8?B?U3M4Mmljemtrc2hVWVRSa2hMeW5TUi9EcFdUUlQwUmV1UE91UnhRckdWaWVh?=
 =?utf-8?B?VnVRUjg5QSt2dHZsbElnVVN2bzlSWllaSmFjMHA5OTMxd2l3L3BnRnJKSXFJ?=
 =?utf-8?B?b2JxLzZSRlFxUFUzUUUySU5aNkpCdE1SRUlXc010bTB6aENja3FyT25Gd1V2?=
 =?utf-8?B?RWpTWGRucXBoK2Y2My9qNDlHTjNHOG43Mk1ZZ1V4dHVjL1FkMUtBdXVqaVZD?=
 =?utf-8?B?dFVEMGtNdlpJb0llWFA5Kzhad0VMTitFUlFUajRwM0dLUWJuTHRvQ0FSbFZj?=
 =?utf-8?B?dC9ScDFETVc4TUxob1kzU3FBRElhelRCWkdlZEx1SFNtYU9TV0poTjNvM0dB?=
 =?utf-8?B?am5QTFAxU1VERzRqRjFSOHVyTGFYbStaMVFWUnZ3NWFIcGE1V0E4emF0Q1U4?=
 =?utf-8?B?RnlJWjFuenc5SVAzMTA5UjdHOVovakdqYzJrdkNLRW9LQjN2cE42UjZiS3U2?=
 =?utf-8?B?NzV3THc1dkpUc0dYMks2cCtiSW92V3duaktzY2VJMXZHMFdFVTNFc0xJc0xC?=
 =?utf-8?B?VWsxaVdGaXo5WmtzKzF5Zlhxd0xuZTA2UTQzSzFuR1RuQTBZSFdySzZVSmxt?=
 =?utf-8?B?S3I3bHlVVlpaTVFXS0ZsUWNHN24rYkhyKzl6N2VDMFBTMVNYdHhSSERhaTZU?=
 =?utf-8?B?WU94aTZuNWNwVStpcjd1QXpFaUhHNno4ZHZ4U1NhZTVhbjVVTU1lcnFqdFVB?=
 =?utf-8?B?K1lqN3gzSk9CMGZQL1lEYnhhdU56VWRIcmZNS3NxZ2FWdjVPeXJXdkN5UExC?=
 =?utf-8?B?b0hSbEgyUWQ0b0pIMW1QOVVhRGRZVHdqNFJYU2w4d1RsWnk0cDd0S3loMXQ5?=
 =?utf-8?B?VEMxUUZtQ3pWQ1pLWGZ2cjJReXVpeTBoU0gxVkwvaisyNlR4V1drNldJYllN?=
 =?utf-8?B?Q3NBdmlqTThOeFRsMXpXcTliMkdpZmsvWTlCR0M0alpsVXNES1piYmZTeUZu?=
 =?utf-8?B?M0k0R2F4ajh4eGtiUU9yVitzVTZxaDZhVHNxK1ZGM3g2ZFpKbnJhWW9xRHlp?=
 =?utf-8?B?QzVEU3lYUUhpcmVIY3NhS0NlWk1ZaEx0UU5rWVc0MlVoVmVnazhYUHNLUkYv?=
 =?utf-8?B?UnNYRktObytmUUN0REVJVWVDY0dsNjdCYUN3U2lNaWFudGIzaEgyZFZnWlJk?=
 =?utf-8?B?WEthWGFrcXhwYm9qU1NaNFFCR2N6dTBEK3ppMm9UQW1LVWdkWThkWFBvQXZR?=
 =?utf-8?B?TUJKWnM1R3NrVzhoM3NxSDY1a3JOMzBOYzQ0eCtYbG9YZzRuaG1reEMvdHVY?=
 =?utf-8?B?TDg1SUFkTk9aeFZiNTRwMVJOSWYxQ1FHRE10WXh5Q2FTNE1wNGx0Skg3Mksr?=
 =?utf-8?B?bUZjMGk4ek1jRDNabkFFRHE3N1NXRWlZRWlxZ3YyaWhQdi9NYXFZRms3L2s3?=
 =?utf-8?Q?QtSZ8xa2Xwh9/S8HyeGsN/I4+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3d8b06-0dbc-4112-d8a1-08db89d1005e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 09:58:14.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl6APjSPwX/IPmYvyYLRDHMY9prm4F37qwcJ/CQpFJpGGkxwg36Gw4vo4kJu+gJO67s1yfXiwNVI+PPWBRZyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-Proofpoint-GUID: DGXh9YjUNqqgfsXoQ5DvVQlz-72xDDT4
X-Proofpoint-ORIG-GUID: DGXh9YjUNqqgfsXoQ5DvVQlz-72xDDT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=796
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307210089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMjEsIDIwMjMgNTozNiBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT47IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW3YyIFBBVENIXSBhcm02NDogZHRzOiBzdHJhdGl4MTA6IGFkZCBuZXcg
Y29tcGF0aWJsZSBmb3IgSW50ZWwNCj4gU29DRlBHQSBTdHJhdGl4MTAgcGxhdGZvcm0NCj4gDQo+
IENBVVRJT046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFj
Y291bnQhDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IE9uIDIxLzA3LzIwMjMgMTE6MjksIExpLCBNZW5nIHdyb3RlOg0KPiA+Pj4+Pj4gTkFL
LCBkb24ndCBmYWtlIHJldmlld3MuIFRoaXMgdmVyeSBpbXBvbGl0ZSBhbmQgZGVzdHJveXMgZW50
aXJlIHRydXN0Lg0KPiA+Pj4+Pj4gVGhlIG1vZGVsIG9mIHVwc3RyZWFtIGNvbGxhYm9yYXRpb24g
ZGVwZW5kcyBvbiB0aGUgdHJ1c3QsIHdoaWNoDQo+ID4+Pj4+PiBpcyBub3cgZ29uZSBmb3IgV2lu
ZHJpdmVyLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gTm8hIEkgZG9uJ3QgZmFrZSBhIHRh
Zy4NCj4gPj4+Pg0KPiA+Pj4+IFJlYWxseT8gVGhlbiBJIGFzayBzZWNvbmQgdGltZSAtIGZyb20g
d2hlcmUgZGlkIHlvdSBnZXQgaXQ/IFByb3ZpZGUgYSBsaW5rLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDcxODAzMDg1MS4yMDE0MzA2LTEt
TWVuZy5MaUB3aW5kcmkNCj4gPj4+IHZlDQo+ID4+PiByLmNvbS9ULw0KPiA+Pg0KPiA+PiBTbyB3
aGVyZSBpcyBpdD8gWW91IHBvaW50ZWQgdG8geW91ciBlbWFpbC4gV2hlcmUgaXMgdGhlIHRhZz8N
Cj4gPj4NCj4gPg0KPiA+IFNvcnJ5ISBNYXliZSBJIGhhdmUgd3JvbmcgdW5kZXJzdGFuZGluZyBh
Ym91dCBUQUcuDQo+ID4gRnJvbSBteSBwZXJzcGVjdGl2ZSwgSWYgcmV2aWV3ZXJzIGFzayBxdWVz
dGlvbiBvciBnaXZlIHNvbWUgYWR2aWNlcyB0byB0aGUNCj4gcGF0Y2gsIEkgbmVlZCB0byBhZGQg
dGhlIHRhZyB0byB2Mi4NCj4gDQo+IFRoaXMgaXMgc29tZSBjcmF6eSBpZGVhLiBTbyB5b3Ugd2Fu
dCB0byBzcHJpbmtsZSBzb21lIHRhZ3MsIGp1c3QgYmVjYXVzZQ0KPiBzb21lb25lIGRpc2FncmVl
cyB3aXRoIHlvdXIgcGF0Y2ggYW5kIGV4cGxpY2l0bHkgZ2l2ZXMgeW91IGEgTkFLLCB3aGljaCBt
ZWFucw0KPiBOT1QtQWNrLCBOb3QtYWNrbm93bGVkZ2UsIG5vdCBhY2NlcHRlZCwgbm90IGluIGdv
b2Qgc2hhcGUuDQo+IA0KPiBJIGFjdHVhbGx5IHdvbmRlciB3aHkgYWRkaW5nIGFuIGFja25vd2xl
ZGdpbmcgdGFnIGZvciB0aGUgcGF0Y2gsIGlmIEkgZGlzYWdyZWVkDQo+IGFuZCBnYXZlIHlvdSBO
QUsuIEZvbGxvd2luZyB5b3VyIGxvZ2ljLCB0aGlzIHNob3VsZCBiZSBhIE5BSyB0YWcuIFRoaXMg
SSBjb3VsZA0KPiB1bmRlcnN0YW5kLiBCdXQgZ2l2aW5nIGFja25vd2xlZGdlIHdoZW4gSSBjbGVh
cmx5IHNhaWQgcGF0Y2ggaXMgd3Jvbmc/DQo+IA0KDQpWZXJ5IHNvcnJ5IGZvciB3YXN0aW5nIHlv
dXIgdGltZSBiZWNhdXNlIG9mIGxhY2sgb2YgdW5kZXJzdGFuZGluZyBhYm91dCB1cHN0cmVhbSBy
dWxlcy4NCkFuZCB0aGFua3MgZm9yIG1hbnkgZXhwbGFuYXRpb25zIHBhdGllbnRseSwgdGhpcyB3
aWxsIGhlbHAgbWUgbWFrZSBwcm9ncmVzcy4NCg0KPiBSZWFkIGFsbCBwcm9jZXNzIGRvY3VtZW50
cyBiZWZvcmUgc3VibWl0dGluZyBuZXcgcGF0Y2hlczoNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9y
Zy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy8NCj4gDQoNCk9rISBJIHdpbGwgY2hlY2sgdGhlc2Ug
ZG9jcy4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gPiBJZiBpdCBpcyBub3QgYWxsb3dlZCwgSSBh
cG9sb2dpemUgZm9yIHRoYXQuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
