Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC97F91BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 08:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKZHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 02:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 02:25:47 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81617101;
        Sat, 25 Nov 2023 23:25:53 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AQ7P248007054;
        Sun, 26 Nov 2023 07:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=k6nYmP8h/gYIxP7D7eSSGq0ugzWtEGEF66F+9K3z0GE=; b=
        dbF/j0yw/CaEIfoxUaFaw0FFzb92DsCfmb0R6Lkc7GsaKIDjQpuVbkn6IpFBl7rP
        KTYxs1vCExermo0l868Dxj44dAtGDUx2+m5EXiiph4mByQzWVJDlLGvOW8IlpNDZ
        X5d8L+Y+hszCz5EijadoQOKRCk1sef7NymuA9WKJTAd0IWG/ePA50d/x2iq8/5JL
        3G/+JQ4UND9u9FfVrQOz/iBhcqLkWGuHtyNV3dYDOkYZd3GxKrAhGfVTYGk4kajz
        IyoQWl78ZT5/pQeMwQVox2czMH2C0HE/2iX+j3GnxG6N5UVxtYabtHmk+2ZxHgvz
        mIIDf+JQgcUd9r3SfHIoAw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uk64xgrw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 07:25:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD3G9exXaOK/OB3G2WtI/8gyd5m+xsSjQVdKjF7B2dRB5eqIJuCgz5V+FcJLIOxdBwE8c2Qovkakcx668+qcF/Oq85h4kv6u15rYuQs+IIZgIqWPzgqehptMUDKs3hwVz8Bm5Qf61C4M5f+I9EhDwr6qfg2uNFVX6UrJqXiv1iyI6gdS0jGqbK+qWxw6HxmnUYMnCy4vKfmPnfWDMSFkWtC/F+uXAJKaADye4jp88XkKDlsEKOB016k7q/GrjbQcIVgyPITJwDo0MDSmACM9YZg8BQ7APPSwIpmBUYYWDc2QiO0LTp82U4+PPeG0f9mRpQn8i0e7o7NVee6xKe/XTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6nYmP8h/gYIxP7D7eSSGq0ugzWtEGEF66F+9K3z0GE=;
 b=K6B4VbI3cAunDYYPPz0JwU8dkVZ01KAq6iRwbf96vZdYYWNBz7VQqrjt/cybDfeDIJJ93hprj91bjELK4DrZ0XTP5DGGy1mNrbLDsnuRgkLEV2YssvDTOpZbNLBFMeSY+ZjcZgSQPzJITKOuJeyCU+Q3xGt5R6jbzAFlDSayfJ1IuFR9bv6orR2T+chjufUQtni8FeVI6kwbqz8juH1tMD6Q628NYFln+9qBto/gSsfO4nvq9UAuaubKd665y5IVWeh9VOPQA24FtUiELrP24xgtR8TEtvHvlQElhnRFR+D4QwlOB09uoJrWRtFxXpbG6qzA41N7PVtlPlfzsbBOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sun, 26 Nov
 2023 07:25:09 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::cc54:6503:20fd:46d5]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::cc54:6503:20fd:46d5%7]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 07:25:09 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Thread-Topic: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Thread-Index: AQHaHVFRLDt9h0WjjkGvj0A7QVrUS7CJVtuAgALe1PA=
Date:   Sun, 26 Nov 2023 07:25:08 +0000
Message-ID: <PH0PR11MB51929193317D75141C28059BECBEA@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231122143603.85297-1-sxwjean@me.com>
 <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
In-Reply-To: <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|SN7PR11MB8068:EE_
x-ms-office365-filtering-correlation-id: f0fb22fe-eecc-4595-081d-08dbee50d1c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuB8JeTvjkBVqT1IJ6hFXYpJfjv1dIHp1sDnuPegleyFqLk6OluazEQQeoYQPGwh5L3Ixz98Vvk/4UxQiQSj3XJIfcJt97uHeC6R+eA4Xl2sWipvrco8GsY+g3BdaYcNiN1/Fxq/fa6dGArEw+H1yFTISSPAAA/ZI3uWTXW8ZjUotzvRC3Mzt3WAoLfQL7DtAmGt5IBuO714nqO0c5lD28ktsVHO9HMRCr1Y5a2GmYD0n9Rtq5Mh4gN19a4TBxuRr/CU82x2hyfGzHohAvb/6mt/UUMrAGSXdnnhpi+PDs36sjOqJp6yA/cd2RLq5Ekjtn3cHUZcs48y4G9FlsfJMWub7sisMJQzlD49qeCT9rIQOoFusrp0CZBj6IBi+SQiTsbATtarnjxEimTPWgAda+svC5rr0uB/isTE2yX+BkCj/TmrZ5Y/Z7pNC15gPssUfGgy/rqGub363lGxt8ZbpRgW3sBkFpON32mcY0k/tc8dNADjIKrfq+Uno7ODPzmL8tetuoaDhTkHOGZbv6h4HKEk2ulH6H3XWFwuhxIAYzXhUOO1HD7u08eFQroaP2NL/alZcW68bAYLAv7tfcKZgYdr3APDcQpyws1uY/Pyx9FFUmHCePRPeaMP31pON/fQLoyYuxCnRRADsZBdQBfo6Car4eDZS5whAmro1cQW9Vkl3NGFsyA8x8+I7SNt919j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39840400004)(366004)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(52536014)(66946007)(8936002)(8676002)(4326008)(478600001)(966005)(110136005)(5660300002)(7416002)(86362001)(41300700001)(33656002)(122000001)(2906002)(38100700002)(71200400001)(7696005)(6506007)(9686003)(53546011)(83380400001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ujg1YmJ4UXNoT3k2LzM4WGZlMVg1bitNN2N0a3lYNWRsQkU3bVZUdTFHcnc5?=
 =?utf-8?B?QjJYa05HZ3hjSDZ4eUJKQ0hDOWZGSkY3eTFBZGRDRytLc0g0V1V3S1V4TFND?=
 =?utf-8?B?R1F5cE96aE5BU1JYS0xkRjhEUS9iMTVIN2tMS0NtbkJGeFYrNXE3SU5YWDVr?=
 =?utf-8?B?SS9seG1LZUdmZGhSRE9oRUsyMW9ONmlNUnM3R1MvUmRwR2VTZDhnblBlNE9w?=
 =?utf-8?B?RDVMQUFHUUhmZTFiaWtlY056RDRmV1JCbWZrNnhuMnFISlJlaUtpbEsycUwy?=
 =?utf-8?B?ekQvajRpdm5WVHZ1SHUrNUdkWVVGa3o2MFo2cTdjbXp2SDhiL05MTGFvdmta?=
 =?utf-8?B?T3NwTkJyQlE5T2tLM0lmd0dvdVNhNFZhd3BQMVBBMEJsVXdlSG9PdGxOeUhR?=
 =?utf-8?B?YXdTWVVIVmVlUUJiTUpnV0l6ZlFTeXpZbkhiQUl4dndnTWZ1SUpLSmcyaG82?=
 =?utf-8?B?UTFkam9iblhocG5Hd2NHTnR2QWVKVDdYcDZvcnZSOTVZUGtwUlJlRW1lZzlk?=
 =?utf-8?B?dmF6VkVpU2FEUnFoVExRYkpJY0xVaDc2Y0NxeTk2MVliRHBHcHlvQ1FwTkc4?=
 =?utf-8?B?NW9xeFJxN2xad0RPN0tBS3o1eEpSVFlodE9SSG92aXRMWmYwbGZ5YXQrMWNm?=
 =?utf-8?B?eUs0WHBDWGkveHNuYUJOTm96Nk9qWG1vMnREc0tYVFp5bDhWOE95cDRsK29r?=
 =?utf-8?B?b0wwcjE5UFg2SWhtelFvSDRpWEJXUHZCUGYxVFNLYkx5Z09GYmVBTkNsN0JD?=
 =?utf-8?B?dG44UlozanJvZ2NHcG0xRVFaVWxTNTJleWQvT1dlbTRiT1N4Z1RqQmRZbThq?=
 =?utf-8?B?eHJreDhQY1FNUWxlZjFqbWV3NGdRbk0rVGNEYkdrWmJoSjhzMVZ0QWlVUFpO?=
 =?utf-8?B?bFV6RW92TUkzRitxZlgvUEdqVUNCMzB1TnNmdEpSdjBDS3F4VHlVUlNPcUhL?=
 =?utf-8?B?SWU5dXFIcThHeW8ycVdIcmMrbnJzbm9QWE5RUHEwc25MZ2dEY216SEkvQnI3?=
 =?utf-8?B?UnhMbFF5QTRSOG03d25mOGlqU0ZqWXJUa1h3d3JmaEZkaEdsekVWUm1vN3ZC?=
 =?utf-8?B?aHBuZGRlaFRuMXFEMVl2TXoyZG9URlh6ZFBidnYwdlFtOXkwUEF6SzNKS2dH?=
 =?utf-8?B?VUJMYklCaDlIWGxySkd1eHNTTGVjbFYrODRMSFR5N3BwZVZuUzc4ZXY2bXV4?=
 =?utf-8?B?TWx5ZUg0ZERlRStzTDFUa09HYlZtNTRFb0o0SUQ2TDhrYUNDMTJ5RnFWYU1m?=
 =?utf-8?B?L0prTDRjdzhIalU5MitUZUg2aDlFTHB3NFQyTmxkRUVIeURLN0hJMDVyOEI5?=
 =?utf-8?B?SmJhZXlRQmVxMExXUlF4dXpSQldKT3BnY2p1UTJ0YWhwandnVlhsTnJGYTRj?=
 =?utf-8?B?NWV3NnErZXR1S2o1VGFqOE0zQjQxdk0yREJ1ZGxIZlFWVWxydjlsMnBoUGtn?=
 =?utf-8?B?ZUZSMS92cEt4ZUFVT2F0alNFYUFqd3g3elJhRFJubHdUZEFzVkN6NkU3TlRp?=
 =?utf-8?B?RTh1dnFoTEFMT2MyZDM0Q2RLcVRmSXZXWDNnbTNJTHhDbWE0SjRMVHhobGVk?=
 =?utf-8?B?LzBCVGZYVUZsM0xETDIwbmM0QVNEWERSYkRzdmJENldJcTNiVjNEcnI5ZU16?=
 =?utf-8?B?cTZFeHh1SWVwTnl2NTQ3Z29jelg0a2FoM3FybUo3VDVGZUlkdXFscmNuaTBD?=
 =?utf-8?B?VkJPSkEyN0tSckNObC9rM2lvcTFIUDFFUFdFa3kyZ2FubnVlNUVHbGRTczU0?=
 =?utf-8?B?SjdTa0lXVkVVSmVDUVFXZGx1OFJYbStnQWd2Q1hrdGJyYUFtYjFzSkk1Tzll?=
 =?utf-8?B?NWtYUTk4VVQ1bnFaNUkvaWhVRDR0T3pwUGJab2d1bmZHZnVQcEtIRUs5MGV1?=
 =?utf-8?B?NTAwNWczbEpGQ2JrTUphYmJCN01YQjMrVHVQSWtnSTczK0dVME5CSEFqTUhk?=
 =?utf-8?B?NnI0OVhtYklkWkZPdTkvRUlEUWdEQk5KQTArUXJMRkdJcWxSdTBYcDd1Tld3?=
 =?utf-8?B?TjM1NlRCSlJ3R1Zld0lZTzhqUDVWQjlCVEI1NlhGQ2F2NkQvVStRbWE2TGVV?=
 =?utf-8?B?Z2NnYWtIYllXWmdpbVJveFhsWXBrVTcvd3ZHclNXaVM2RytNcXl0K1NvTUo2?=
 =?utf-8?B?bnZ6aTRwKzhSN0hkckZ1NkZWUm85QmM2TjdUR0RIV0drVWpPVTlOMUZybW5J?=
 =?utf-8?B?RGZjVm5TZ3BjRGY3QlhDVXBVelpoV04yZXc5ZnN4L1VXMWZuR09iOTJvQU5z?=
 =?utf-8?B?OTVvOVFYNXVVa2M1NGdKbFc5R2pnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb22fe-eecc-4595-081d-08dbee50d1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2023 07:25:08.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGYxQjGrb+VeQpXGOKzkhaRYGseS1GkTf6n814kzMpjWcwZ4JCalZLqwkN70iHcbaewP6anSxV70BnAAzBP+tHRqq25CA3pWwcHarwec1J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-Proofpoint-ORIG-GUID: 4syeXIrN3pC010SLhKJOthYkgUeHyXet
X-Proofpoint-GUID: 4syeXIrN3pC010SLhKJOthYkgUeHyXet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311260050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmxhc3RpbWlsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZs
YXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIg
MjQsIDIwMjMgNzoyNCBQTQ0KPiBUbzogc3h3amVhbkBtZS5jb207IDQyLmh5ZXlvb0BnbWFpbC5j
b207IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiBDYzogY2xAbGludXguY29tOyBwZW5iZXJnQGtlcm5l
bC5vcmc7IHJpZW50amVzQGdvb2dsZS5jb207IGlhbWpvb25zb28ua2ltQGxnZS5jb207DQo+IGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc7IHJvbWFuLmd1c2hjaGluQGxpbnV4LmRldjsgY29yYmV0
QGx3bi5uZXQ7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBTb25nLCBYaW9uZ3dlaQ0KPiA8WGlvbmd3ZWkuU29uZ0B3aW5kcml2ZXIu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBEb2N1bWVudGF0aW9uOiBrZXJuZWwtcGFy
YW1ldGVyczogcmVtb3ZlIHNsYWJfbWF4X29yZGVyIGFuZA0KPiBub2FsaWVuY2FjaGUNCj4gDQo+
IA0KPiBPbiAxMS8yMi8yMyAxNTozNiwgc3h3amVhbkBtZS5jb20gd3JvdGU6DQo+ID4gRnJvbTog
WGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiA+DQo+ID4gU2lu
Y2Ugc2xhYiBhbGxvY2F0b3IgaGFzIGFscmVhZHkgYmVlbiByZW1vdmVkLiBUaGVyZSBpcyBubyB1
c2VycyBhYm91dA0KPiA+IHNsYWJfbWF4X29yZGVyIGFuZCBub2FsaWVuY2FjaGUsIHNvIGxldCdz
IHJlbW92ZSB0aGVtLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlvbmd3ZWkgU29uZyA8eGlv
bmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBIeWVvbmdnb24gWW9v
IDw0Mi5oeWV5b29AZ21haWwuY29tPiBzdWdnZXN0ZWQgdGhhdCBub2FsaWVuY2FjaGUgc2hvdWxk
IGJlDQo+ID4gcmVtb3ZlZCB0b28uIEhlcmUgYWRkaW5nIHRoaXMgY2hhbmdlLiBUaGUgcGF0Y2gg
aXMgYmFzZWQgb24gWzFdLg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3ZiYWJrYS9saW51eC5naXQvbG9nLz9oPXNsYWItcmVtb3Zl
LQ0KPiBzbGFiLXYycjENCj4gPg0KPiA+IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1tbS8yMDIzMTEyMDA5MTIxNC4xNTA1MDItMS0NCj4gc3h3amVhbkBtZS5jb20vVC8jbTU1ZWJi
NDU4NTFiYzg2ZDY1MGJhZjY1ZGZlODI5NmQzM2M1YjExMjYNCj4gPiAtLS0NCj4gPiAgRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgfCAxMCAtLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0Rv
Y3VtZW50YXRpb24vYWRtaW4tDQo+IGd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IGlu
ZGV4IDY1NzMxYjA2MGUzZi4uZDU2YTViZWVmZTI0IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50
YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiBAQCAtMzc0MCwx
MCArMzc0MCw2IEBADQo+ID4gICAgICAgbm81bHZsICAgICAgICAgIFtYODYtNjQsUklTQ1ZdIERp
c2FibGUgNS1sZXZlbCBwYWdpbmcgbW9kZS4gRm9yY2VzDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIGtlcm5lbCB0byB1c2UgNC1sZXZlbCBwYWdpbmcgaW5zdGVhZC4NCj4gPg0KPiA+IC0gICAg
IG5vYWxpZW5jYWNoZSAgICBbTU0sIE5VTUEsIFNMQUJdIERpc2FibGVzIHRoZSBhbGxvY2F0aW9u
IG9mIGFsaWVuDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGNhY2hlcyBpbiB0aGUgc2xhYiBh
bGxvY2F0b3IuICBTYXZlcyBwZXItbm9kZSBtZW1vcnksDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgIGJ1dCB3aWxsIGltcGFjdCBwZXJmb3JtYW5jZS4NCj4gDQo+IE5vIHF1ZXN0aW9uIGFib3V0
IHRoaXMgb25lLCBjYW4gYmUgZGVsZXRlZC4NCj4gDQo+ID4gLQ0KPiA+ICAgICAgIG5vYWxpZ24g
ICAgICAgICBbS05MLEFSTV0NCj4gPg0KPiA+ICAgICAgIG5vYWx0aW5zdHIgICAgICBbUzM5MF0g
RGlzYWJsZXMgYWx0ZXJuYXRpdmUgaW5zdHJ1Y3Rpb25zIHBhdGNoaW5nDQo+ID4gQEAgLTU4ODcs
MTIgKzU4ODMsNiBAQA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBvd24uDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIEZvciBtb3JlIGluZm9ybWF0aW9uIHNlZSBEb2N1bWVudGF0aW9uL21t
L3NsdWIucnN0Lg0KPiA+DQo+ID4gLSAgICAgc2xhYl9tYXhfb3JkZXI9IFtNTSwgU0xBQl0NCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgRGV0ZXJtaW5lcyB0aGUgbWF4aW11bSBhbGxvd2VkIG9y
ZGVyIGZvciBzbGFicy4NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgQSBoaWdoIHNldHRpbmcg
bWF5IGNhdXNlIE9PTXMgZHVlIHRvIG1lbW9yeQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBm
cmFnbWVudGF0aW9uLiAgRGVmYXVsdHMgdG8gMSBmb3Igc3lzdGVtcyB3aXRoDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgIG1vcmUgdGhhbiAzMk1CIG9mIFJBTSwgMCBvdGhlcndpc2UuDQo+IA0K
PiBJIHRoaW5rIGhlcmUgd2Ugc2hvdWxkIGNvbnNpZGVyIHRoZSBsb25nLXRlcm0gcGxhbiBmaXJz
dC4gSXQncyBhIGJpdA0KPiB1bmZvcnR1bmF0ZSAoaW4gaGluZHNpZ2h0KSBTTFVCIGJyb3VnaHQg
aXRzIG93biBwcmVmaXggb2YgcGFyYW1ldGVycywgZXZlbg0KPiBpZiBzb21lIGJlY2FtZSBpbnRl
cmNoYW5nZWFibGUgYWxpYXNlcyBsYXRlciAoc2xhYi9zbHViX25vbWVyZ2UpLCBzb21lIG5vdC4N
Cj4gSSB0aGluayBpdCB3b3VsZCBiZSBiZXN0IHRvIHVuaWZ5IHRoZW0sIGFuZCBjb25zaWRlciB0
aGUgc3RyaW5nICJzbHViIiBhbg0KPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgb2YgdGhlIGdlbmVy
YWwgInNsYWIgYWxsb2NhdG9yIiB0ZXJtIGdvaW5nIGZvcndhcmQuDQo+IA0KPiBTbyB3aGF0IEkn
ZCBwcm9wb3NlIGlzIHRoYXQgd2UgY2hhbmdlIGFsbCBwYXJhbWV0ZXJzIHRvIGFjY2VwdCBhDQo+
ICJzbGFiXyRwYXJhbSIgYXMgYSBwcmltYXJ5IGFuZCBkb2N1bWVudGVkIG5hbWUgKGFuZCB0aGUg
ZGVzY3JpcHRpb24gY2FuDQo+IGNvbnRhaW4ganVzdCBbTU1dIHRhZywgbm8gW1NMQUJdIG9yIFtT
TFVCXSBuZWVkZWQpLCB3aXRoICJzbHViXyRwYXJhbSIgaXMNCj4gYWxzbyBhY2NlcHRlZCBhcyBh
biBhbGlhcyB3aGVyZSBpdCBleGlzdHMgdG9kYXksIGFuZCB0aGVyZSdzIGp1c3QgYSBub3RlDQo+
IHRoYXQgdGhlIHNsdWJfJHBhcmFtIG5hbWUgaXMgYWxzbyBhY2NlcHRlZCBpbiB0aGUgZGVzY3Jp
cHRpb24gb2YgdGhlDQo+IGNhbm9uaWNhbCBwYXJhbWV0ZXIsIG5vdCBpbiBhIHNlcGFyYXRlIGRl
c2NyaXB0aW9uLiBUaGVuIG1heWJlIGluIGEgZmV3DQo+IHllYXJzIHdlIGNhbiBtYXJrIHRoZSBv
bGQgbmFtZXMgYXMgZGVwcmVjYXRlZCBhbmQgc3RhcnQgaXNzdWluZyBsb3cta2V5DQo+IHdhcm5p
bmdzICh3aGlsZSBzdGlsbCBhY2NlcHRpbmcgdGhlbSksIGFuZCBpbiAxMCB5ZWFycyBtYXliZSBy
ZW1vdmUgdGhlbQ0KPiBjb21wbGV0ZWx5LiBUaG91Z2h0cz8NCg0KU29ycnksIEkgZGlkbid0IGtu
b3cgdGhlIFNMVUIgaGlzdG9yeSwgdGhhbmtzIGZvciB0aGUgY29tbWVudHMgYW5kIHByb3Bvc2Fs
LiANCg0KRGlkIHlvdSBtZWFuIHRoZSByb3VnaCBkaWZmIGJlbG93Pw0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgYi9Eb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KaW5kZXggNjU3MzFiMDYw
ZTNmLi5kYjZkMmViZTdjN2QgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9r
ZXJuZWwtcGFyYW1ldGVycy50eHQNCkBAIC01ODcxLDEwICs1ODcxLDEyIEBADQogICAgICAgICBz
bHJhbT0gICAgICAgICAgW0hXLE1URF0NCg0KICAgICAgICAgc2xhYl9tZXJnZSAgICAgIFtNTV0N
CisgICAgICAgc2x1Yl9tZXJnZSAgICAgIFtNTV0NCiAgICAgICAgICAgICAgICAgICAgICAgICBF
bmFibGUgbWVyZ2luZyBvZiBzbGFicyB3aXRoIHNpbWlsYXIgc2l6ZSB3aGVuIHRoZQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgIGtlcm5lbCBpcyBidWlsdCB3aXRob3V0IENPTkZJR19TTEFCX01F
UkdFX0RFRkFVTFQuDQoNCiAgICAgICAgIHNsYWJfbm9tZXJnZSAgICBbTU1dDQorICAgICAgIHNs
dWJfbm9tZXJnZSAgICBbTU1dDQogICAgICAgICAgICAgICAgICAgICAgICAgRGlzYWJsZSBtZXJn
aW5nIG9mIHNsYWJzIHdpdGggc2ltaWxhciBzaXplLiBNYXkgYmUNCiAgICAgICAgICAgICAgICAg
ICAgICAgICBuZWNlc3NhcnkgaWYgdGhlcmUgaXMgc29tZSByZWFzb24gdG8gZGlzdGluZ3Vpc2gN
CiAgICAgICAgICAgICAgICAgICAgICAgICBhbGxvY3MgdG8gZGlmZmVyZW50IHNsYWJzLCBlc3Bl
Y2lhbGx5IGluIGhhcmRlbmVkDQpAQCAtNTg4NywxMiArNTg4OSw2IEBADQogICAgICAgICAgICAg
ICAgICAgICAgICAgb3duLg0KICAgICAgICAgICAgICAgICAgICAgICAgIEZvciBtb3JlIGluZm9y
bWF0aW9uIHNlZSBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KDQotICAgICAgIHNsYWJfbWF4
X29yZGVyPSBbTU0sIFNMQUJdDQotICAgICAgICAgICAgICAgICAgICAgICBEZXRlcm1pbmVzIHRo
ZSBtYXhpbXVtIGFsbG93ZWQgb3JkZXIgZm9yIHNsYWJzLg0KLSAgICAgICAgICAgICAgICAgICAg
ICAgQSBoaWdoIHNldHRpbmcgbWF5IGNhdXNlIE9PTXMgZHVlIHRvIG1lbW9yeQ0KLSAgICAgICAg
ICAgICAgICAgICAgICAgZnJhZ21lbnRhdGlvbi4gIERlZmF1bHRzIHRvIDEgZm9yIHN5c3RlbXMg
d2l0aA0KLSAgICAgICAgICAgICAgICAgICAgICAgbW9yZSB0aGFuIDMyTUIgb2YgUkFNLCAwIG90
aGVyd2lzZS4NCi0NCiAgICAgICAgIHNsdWJfZGVidWdbPW9wdGlvbnNbLHNsYWJzXVs7W29wdGlv
bnNbLHNsYWJzXV0uLi5dICAgICAgW01NLCBTTFVCXQ0KICAgICAgICAgICAgICAgICAgICAgICAg
IEVuYWJsaW5nIHNsdWJfZGVidWcgYWxsb3dzIG9uZSB0byBkZXRlcm1pbmUgdGhlDQogICAgICAg
ICAgICAgICAgICAgICAgICAgY3VscHJpdCBpZiBzbGFiIG9iamVjdHMgYmVjb21lIGNvcnJ1cHRl
ZC4gRW5hYmxpbmcNCkBAIC01OTAxLDEzICs1ODk3LDE1IEBADQogICAgICAgICAgICAgICAgICAg
ICAgICAgbGFzdCBhbGxvYyAvIGZyZWUuIEZvciBtb3JlIGluZm9ybWF0aW9uIHNlZQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgIERvY3VtZW50YXRpb24vbW0vc2x1Yi5yc3QuDQoNCi0gICAgICAg
c2x1Yl9tYXhfb3JkZXI9IFtNTSwgU0xVQl0NCisgICAgICAgc2xhYl9tYXhfb3JkZXI9IFtNTV0N
CisgICAgICAgc2x1Yl9tYXhfb3JkZXI9IFtNTV0NCiAgICAgICAgICAgICAgICAgICAgICAgICBE
ZXRlcm1pbmVzIHRoZSBtYXhpbXVtIGFsbG93ZWQgb3JkZXIgZm9yIHNsYWJzLg0KICAgICAgICAg
ICAgICAgICAgICAgICAgIEEgaGlnaCBzZXR0aW5nIG1heSBjYXVzZSBPT01zIGR1ZSB0byBtZW1v
cnkNCiAgICAgICAgICAgICAgICAgICAgICAgICBmcmFnbWVudGF0aW9uLiBGb3IgbW9yZSBpbmZv
cm1hdGlvbiBzZWUNCiAgICAgICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3Ns
dWIucnN0Lg0KDQotICAgICAgIHNsdWJfbWluX29iamVjdHM9ICAgICAgIFtNTSwgU0xVQl0NCisg
ICAgICAgc2xhYl9taW5fb2JqZWN0cz0gICAgICAgW01NXQ0KKyAgICAgICBzbHViX21pbl9vYmpl
Y3RzPSAgICAgICBbTU1dDQogICAgICAgICAgICAgICAgICAgICAgICAgVGhlIG1pbmltdW0gbnVt
YmVyIG9mIG9iamVjdHMgcGVyIHNsYWIuIFNMVUIgd2lsbA0KICAgICAgICAgICAgICAgICAgICAg
ICAgIGluY3JlYXNlIHRoZSBzbGFiIG9yZGVyIHVwIHRvIHNsdWJfbWF4X29yZGVyIHRvDQogICAg
ICAgICAgICAgICAgICAgICAgICAgZ2VuZXJhdGUgYSBzdWZmaWNpZW50bHkgbGFyZ2Ugc2xhYiBh
YmxlIHRvIGNvbnRhaW4NCkBAIC01OTE2LDE4ICs1OTE0LDEyIEBADQogICAgICAgICAgICAgICAg
ICAgICAgICAgYW5kIHRoZSBsZXNzIGZyZXF1ZW50bHkgbG9ja3MgbmVlZCB0byBiZSBhY3F1aXJl
ZC4NCiAgICAgICAgICAgICAgICAgICAgICAgICBGb3IgbW9yZSBpbmZvcm1hdGlvbiBzZWUgRG9j
dW1lbnRhdGlvbi9tbS9zbHViLnJzdC4NCg0KLSAgICAgICBzbHViX21pbl9vcmRlcj0gW01NLCBT
TFVCXQ0KKyAgICAgICBzbHViX21pbl9vcmRlcj0gW01NXQ0KKyAgICAgICBzbGFiX21pbl9vcmRl
cj0gW01NXQ0KICAgICAgICAgICAgICAgICAgICAgICAgIERldGVybWluZXMgdGhlIG1pbmltdW0g
cGFnZSBvcmRlciBmb3Igc2xhYnMuDQpNdXN0IGJlDQogICAgICAgICAgICAgICAgICAgICAgICAg
bG93ZXIgdGhhbiBzbHViX21heF9vcmRlci4NCiAgICAgICAgICAgICAgICAgICAgICAgICBGb3Ig
bW9yZSBpbmZvcm1hdGlvbiBzZWUgRG9jdW1lbnRhdGlvbi9tbS9zbHViLnJzdC4NCg0KLSAgICAg
ICBzbHViX21lcmdlICAgICAgW01NLCBTTFVCXQ0KLSAgICAgICAgICAgICAgICAgICAgICAgU2Ft
ZSB3aXRoIHNsYWJfbWVyZ2UuDQotDQotICAgICAgIHNsdWJfbm9tZXJnZSAgICBbTU0sIFNMVUJd
DQotICAgICAgICAgICAgICAgICAgICAgICBTYW1lIHdpdGggc2xhYl9ub21lcmdlLiBUaGlzIGlz
IHN1cHBvcnRlZCBmb3INCmxlZ2FjeS4NCi0gICAgICAgICAgICAgICAgICAgICAgIFNlZSBzbGFi
X25vbWVyZ2UgZm9yIG1vcmUgaW5mb3JtYXRpb24uDQotDQogICAgICAgICBzbWFydDI9ICAgICAg
ICAgW0hXXQ0KICAgICAgICAgICAgICAgICAgICAgICAgIEZvcm1hdDogPGlvMT5bLDxpbzI+Wywu
Li4sPGlvOD5dXQ0KDQpJZiBzbyBJIHRoaW5rIHdlIHNob3VsZCB1c2Ugc2xhYl8mcGFyYW0gaW4g
bW0vc2x1Yi5jLiBXaGVuIGhpdHRpbmcgInNsdWJfJHBhcmFtIg0Kd2UgbmVlZCB0byBhc3NpZ24g
dGhlIHZhbHVlIHRvICJzbGFiXyZwYXJhbSIgbGlrZSAic2xhYl9ub21lcmdlIiwgcmlnaHQ/DQoN
ClJlZ2FyZHMsDQpYaW9uZ3dlaQ0K
