Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738537FD8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjK2N4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjK2N4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:56:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758DC8F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701266179; x=1732802179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zuLx/H06h/tJd2BL1sZLrdfT001X9/L5UrJFQKvnvK0=;
  b=HZVSoLfWh3VDUlVt9WXkq5oH/eHB4gC0y6or54RW31o/kMsYZnzNrRmN
   5aU/r2BSbP5VsLJ+jrJHGxLouBPS6GQ33nNtGrG5wByKJrsTDRdikPC5n
   y1s8llmVK8iBNoEnwDX3L/vzFjBpcpG4zgmMwQ1t0T59+ZmWHdUpSP/Ct
   RgR8IZctayvFENha5E7uUqnHQ/vmcwHAeFUHMopipMnkng6+GqEI6nmrq
   gtnsJJr262IiVdFxsZL+BvgYvQi3oUUeJo5+wXEyHxrzH7tN+ooy9Fs5w
   tP771Qz3pUwWp6WS1tkf0iPKyqmbOIZXPGxYl8Diryjk/IJewW0MVylZv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="51833"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="51833"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745267025"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="745267025"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 05:56:17 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 05:56:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 05:56:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 05:56:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2khAOxp/cGQAaPsJgkaw8eVhOIAL8bkYAitk0D4q3VVR6+ObotunHgpRVLbguogH2DZkcm4IxP1tBKMhlYOK8nCoMxqyCQAwmd7Uu3VhMVcRHHkTovs3OBxHE7IbWtdXgoJHOH+j/BkK2BgEgExbGk9qycF3ShXSu3e4/r275wc6jOHMubO7ErlKO3W7jq3IbzixsUDT6tUJX1UFWkRZIJkGlH/PVFChX9ge5DRng9YE1FomNW4tNYr5EbKYXrgvsA7Q65bbbkGj/LCi2CuIISv19LoQlzXFa7A5OVouPikvrDoHDYlLiy5pcQOBX77YJ3mVhxfeAguu/Em2zUvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuLx/H06h/tJd2BL1sZLrdfT001X9/L5UrJFQKvnvK0=;
 b=PqvNgGmRDEAy2GrwBGha7Y8aHh2LS0bs50ONNQXQ80fbtA5xOnbExLCbWIiZ95hCHMK+VBjYDNpN4HSsEZTZO55yY6yWFnteib2zLOrpRdj9MuvOe4KMBxV0DCeFyhz/ik+ZvsvsgoKaicJ1DmfqS5J//9eU023HoPWJuacVFY7/HdR6tWvk28/Q7lqSGsM9bkE+UHHI1Pwr6zdP0qL0ClsIAiJvdlClZIo2wzX+SgmxYc0wbl1W0htKqImiG3w8ibXCezUWkDmRoQqOGA6HyqjbrvQs0RQ0uvYNOR2338EVO2olK0U2mMESM8bxsAxas1NLJO0axD5ubts1CmM3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by SJ1PR11MB6227.namprd11.prod.outlook.com (2603:10b6:a03:45a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 13:56:14 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:56:14 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Thread-Topic: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Thread-Index: AQHaIfdexoS2VwuEC0a0G/ZumI2RtrCROyQAgAAUvsA=
Date:   Wed, 29 Nov 2023 13:56:14 +0000
Message-ID: <DM6PR11MB4316ADCA488BE6C5BF85B8618D83A@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
 <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
 <954c8f3f-8093-42bb-b817-c9050d27ca3f@kernel.org>
In-Reply-To: <954c8f3f-8093-42bb-b817-c9050d27ca3f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|SJ1PR11MB6227:EE_
x-ms-office365-filtering-correlation-id: a7f93c6a-9b39-48ce-34fd-08dbf0e2f3c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTdPPiz6eTQvm9u6rlzrRXvn3VdUrV3FU4MX4U1MR5V7CcO1IBgZ/dOc7qvK2aHDfHz5rTqjWXQ0OjljOxAB+2lJ3SCswiLD7JZ2CubMEoZWF7kChI0SO+RtoDMouCn/fBeGMoIYF0iLUA53xyi/GvQDS6dbjKFsHyivzi8/sNl7aoG9ibgmzhuFief6L2Tb31BAPWd8CynGzrMkifqd6vVaIDBcH4twjwfmb8zyQdQBey1chbTKmSF9qb91BU0o9ATb2xxKXIRSD8qhbCDMEazGzZLyXViJgwUylnogEl53i1shNN6/WAlYeEiBy47t+ghWG5/X6xwBQQXQzyHy7COvE5AiV9bj0G5xS/H4wQfKKREQNJSD1DDiSPjAyx9UKkiKCB9HFHxdJUMywgTNKpEJlgM7qFCPtCxljtnpgwmKOn3EqY3UE1H3pcGuQ5aojpg8ghe9H9BM+9JIl1yoaXBNMHbDZfZbSYCQxAUMLBmXU4l+ZT4FStOd2nuSbg78URWHKzjg5UN/ldw8kunNNCokPhGZg9WQ7CRykIIpKcs1d5aDtZsgnaXt1KJAv5NW82F+IhFxCDQT0OMHCH+9MQgF+woGP6EwHgrq5YB7WN1pc502y8JZ5QE4w2lYXFj0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(122000001)(38100700002)(7696005)(82960400001)(55016003)(8936002)(71200400001)(8676002)(53546011)(4326008)(86362001)(6506007)(54906003)(66946007)(66476007)(66556008)(76116006)(66446008)(5660300002)(52536014)(478600001)(316002)(6916009)(64756008)(2906002)(33656002)(38070700009)(41300700001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2xEUXdlM05DRW5UTEttZS9tVkY2ZGlVN2Q5N3U0YjhHb1hHMkpQUndKUXhD?=
 =?utf-8?B?a2xxY3VSa0tob0lla3dYampnb215WmIyZ1Rrdms3TksvcHQ4ejhZaXk0QllH?=
 =?utf-8?B?QVZVdFFyU0Y4M1dCNUtPVTJzR0hsUmJJTk4zVXJOZkJtODJKaUlCRzlobDI2?=
 =?utf-8?B?cEZLR3ErTGFMZVVwejAzcGRLbmJSSDBLN1Zjbm9JY0FORGdPQkNQb1lzTnpF?=
 =?utf-8?B?Qyt2cU1rNXRwSU1lYTgybEZkbm0xZXRVRGRBNlVlSWlaQ2xkUk5vZ3BkTEp1?=
 =?utf-8?B?bWpjTFNHREpTOGdTMzJCNnFWQWhtbzBKUm9FOEtNM0tSQzBtRFQ5VTJNU1BH?=
 =?utf-8?B?dnpWT1ExRUpUK1N0dlBGLzZDVG8wQUoyWEUzc3ZoQy80QW5xaG16UFU3STd1?=
 =?utf-8?B?eExGay9SeitGMTcxcUV3TGtjWUFhRWs5V1lLR0ZiYXZUT2RlcEhQMG1BOHI5?=
 =?utf-8?B?Q0ErNHNHMUdGSHhSYjFUbUVOZ2JFcWc4ZlFRSEx1eFgzWDAzR2NhNXJzQXlz?=
 =?utf-8?B?KzVpZVhub29aMlV0b2hiVDd3aEl6UlRoZ29QcFVRcHhlSEx1VnF6N1lGeGx4?=
 =?utf-8?B?UU1WYThITFJGYXQ3dFNSQkF3VjdjN04xSEljaGRERXJ0eWpDTTBoek5iZWxZ?=
 =?utf-8?B?UkwxUUQ3eURRWXlUZTNQVGRFZ01aMHR3RTc3M1J1elMxNm5TL3E3ZUNMSisw?=
 =?utf-8?B?NkNSN2xhM3h1ZU9Ec002Uy9rTUdEWU5adTVyNmpNKzluODkwUzVlc1ZNZlli?=
 =?utf-8?B?Rng2cjMyVU1OcGR4elg3eFA4WDBMM0dldS9FNUdWamkrQVl1VnhLMlAxbFNr?=
 =?utf-8?B?U0w1NkdQSGM3VjFUYnlCeGhkaGppdXE2V093ZEFGdjdjUUk2VGhGWDJGZnRL?=
 =?utf-8?B?V0ovYXRYSzdRMjZrK2N1dUVSc0djSzVnbmVjcU52ZTRjaWducm0xd3BwWWRz?=
 =?utf-8?B?WElXVTJabSsyMDRqV2pLeUNhVDc3TGZTY2xWZWsrYlhISnp1bUNEeG5ERVZv?=
 =?utf-8?B?V2hqR2dETC94aGlIek5BQVNMZE1RNTVIZEZOMkUzdTBBemZURzQ0elVoOENN?=
 =?utf-8?B?QmZXcW5zay9mQXgvTCtxeXFiSXl5TDVUK1gwRnU0djZxaGhIdHArdE5vM29q?=
 =?utf-8?B?bCtTRWhTL2NaQlZRcU1XTFNFelBKZ3RxYUtBT0N6Uzc4MUxtYnB5Z2FDM2w0?=
 =?utf-8?B?ZUh4M3A3TjAzMVRndWt6V1UxdlAzK3FrNFJBeDlOa242OWFlMTBNRk15d0t4?=
 =?utf-8?B?U2R6UldpYWc3RDBjOUpmanJGM3dHSjErNmNxRHd4SVN3L2phUVlwMm9JbTJP?=
 =?utf-8?B?RnQ0ZWNzUGxNR3ozZHlwcXFzVmZublRDbyt1MDBUekhIc3hodUUvZ01uYUJt?=
 =?utf-8?B?K1FpTWJWRldwcjJUdzZ4ZXdWejVuZUdDbGRIZXp0UU9zMUZwM3lML0xnVzJw?=
 =?utf-8?B?dXJKa3V1Z2JUU254clBSb3VOdmJNSFNSVzNiKzlQWUhtNzhTdkdwQVB4Q0RC?=
 =?utf-8?B?WXNUbzROZFcyVGt1T3A4YWM3M1VObTNmTXVXdUtDUDZGMllIQ0RwVE5JSEI2?=
 =?utf-8?B?cW1YaXBrKzhUMFlvZlJGVGtHRVFnb1NsOVJCUnVjS2YzOThkNjNjZVBUUTFx?=
 =?utf-8?B?VlRqam43ZnVPUTdCb0ZxOXFnSE5SQkZya3ROa2VUeElWN08vS3NXNC94QWxt?=
 =?utf-8?B?bkVRTHFqdVllbjEvZ014VWNUVlFKL3RKZGRlWlNTcVlIQnlVM3pwMGRGbHpN?=
 =?utf-8?B?bFo1SjRHSk1iaTVaRVlLbzVHbmI1OU9ZR0Z3TXFDTnlMNFV0L3BuU280bnNv?=
 =?utf-8?B?aWwxaTNLNU5BOHhzREkva1VzeDd1bW5HZkpud3ExMGxhSjRKKzVUVlM0RnJz?=
 =?utf-8?B?eld5V2JyRForT0NYSkMzRWhnUGhPL1BEeUYvNVpjNnZMRC9CY0ovamUxWEpq?=
 =?utf-8?B?Zi9Pay8yS1dJa2ZWUGxqenVKNXBVYzEyQURwcE9LdldsNlRiUVNJbGVQRHU4?=
 =?utf-8?B?SXVIS0w3b2FIUSs2aHFLK1ladEYwdmNHZTQrQkVpYnZheGN3OFNKL2VZQUxH?=
 =?utf-8?B?b203MzlNak1CcGxzVXRac3kzYnpiNlZBQXZxTVZ3ckVTeW9pUVZjaStXNmtS?=
 =?utf-8?Q?mmXMqq7hFjpTwqlRp83zqxOhP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f93c6a-9b39-48ce-34fd-08dbf0e2f3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 13:56:14.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pw+zxGnKkBByks1tyPLpgGVq3d7mPcLBSr1P4ZwtfxWlwiO4CoyjVS55vCdcQm14GJsFTYkumNNBydWRrIbkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IE9uIDI4LzEx
LzIwMjMgMTM6MzQsIFdlbnRvbmcgV3Ugd3JvdGU6DQo+ID4gVGhlIHByb3RvY29sIHVzZWQgZm9y
IHRoZSBJVlNDIGRldmljZSB0byBjb21tdW5pY2F0ZSB3aXRoIEhPU1QgaXMgTUVJLg0KPiA+IFRo
ZSBNRUkgaGFyZHdhcmUgaW50ZXJmYWNlcyBmb3IgdGhlIElWU0MgZGV2aWNlIGFyZSBpbXBsZW1l
bnRlZC4NCj4gPg0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgREVGSU5FX1NJTVBMRV9ERVZf
UE1fT1BTKG1laV92c2NfcG1fb3BzLCBtZWlfdnNjX3N1c3BlbmQsDQo+ID4gK21laV92c2NfcmVz
dW1lKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG1laV92c2Nf
ZHJ2ID0gew0KPiA+ICsJLnByb2JlID0gbWVpX3ZzY19wcm9iZSwNCj4gPiArCS5yZW1vdmUgPSBt
ZWlfdnNjX3JlbW92ZSwNCj4gPiArCS5kcml2ZXIgPSB7DQo+ID4gKwkJLm5hbWUgPSAiaW50ZWxf
dnNjIiwNCj4gPiArCQkucG0gPSAmbWVpX3ZzY19wbV9vcHMsDQo+ID4gKwkJLnByb2JlX3R5cGUg
PSBQUk9CRV9QUkVGRVJfQVNZTkNIUk9OT1VTLA0KPiA+ICsJfSwNCj4gPiArfTsNCj4gPiArbW9k
dWxlX3BsYXRmb3JtX2RyaXZlcihtZWlfdnNjX2Rydik7DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVU
SE9SKCJXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4iKTsNCj4gPiArTU9EVUxFX0FV
VEhPUigiWmhpZmVuZyBXYW5nIDx6aGlmZW5nLndhbmdAaW50ZWwuY29tPiIpOw0KPiA+ICtNT0RV
TEVfREVTQ1JJUFRJT04oIkludGVsIFZpc3VhbCBTZW5zaW5nIENvbnRyb2xsZXIgSW50ZXJmYWNl
Iik7DQo+ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06aW50ZWxfdnNjIik7DQo+IA0KPiBZb3Ug
c2hvdWxkIG5vdCBuZWVkIE1PRFVMRV9BTElBUygpIGluIG5vcm1hbCBjYXNlcy4gSWYgeW91IG5l
ZWQgaXQsIHVzdWFsbHkgaXQNCj4gbWVhbnMgeW91ciBkZXZpY2UgSUQgdGFibGUgaXMgd3Jvbmcg
KGUuZy4gbWlzc2VzIGVpdGhlciBlbnRyaWVzIG9yDQo+IE1PRFVMRV9ERVZJQ0VfVEFCTEUoKSku
IE1PRFVMRV9BTElBUygpIGlzIG5vdCBhIHN1YnN0aXR1dGUgZm9yIGluY29tcGxldGUNCj4gSUQg
dGFibGUuDQoNCkFncmVlLCBJIGZvcmdvdCB0aGUgaWQgdGFibGUgYW5kIGl0IHdpbGwgYmUgYWRk
ZWQgaW4gbmV4dCB2ZXJzaW9uLCB0aGFua3MNCg0KI2RlZmluZSBNRUlfVlNDX0RSVl9OQU1FCQki
aW50ZWxfdnNjIg0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBtZWlf
dnNjX2lkX3RhYmxlW10gPSB7DQoJeyBNRUlfVlNDX0RSVl9OQU1FIH0sDQoJeyAvKiBzZW50aW5l
bCAqLyB9DQp9Ow0KTU9EVUxFX0RFVklDRV9UQUJMRShwbGF0Zm9ybSwgbWVpX3ZzY19pZF90YWJs
ZSk7DQoNCnN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG1laV92c2NfZHJ2ID0gew0KCS5w
cm9iZSA9IG1laV92c2NfcHJvYmUsDQoJLnJlbW92ZSA9IG1laV92c2NfcmVtb3ZlLA0KCS5pZF90
YWJsZSA9IG1laV92c2NfaWRfdGFibGUsDQoJLmRyaXZlciA9IHsNCgkJLm5hbWUgPSBNRUlfVlND
X0RSVl9OQU1FLA0KCQkucG0gPSAmbWVpX3ZzY19wbV9vcHMsDQoJCS5wcm9iZV90eXBlID0gUFJP
QkVfUFJFRkVSX0FTWU5DSFJPTk9VUywNCgl9LA0KfTsNCm1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIo
bWVpX3ZzY19kcnYpOw0KDQpNT0RVTEVfQVVUSE9SKCJXZW50b25nIFd1IDx3ZW50b25nLnd1QGlu
dGVsLmNvbT4iKTsNCk1PRFVMRV9BVVRIT1IoIlpoaWZlbmcgV2FuZyA8emhpZmVuZy53YW5nQGlu
dGVsLmNvbT4iKTsNCk1PRFVMRV9ERVNDUklQVElPTigiSW50ZWwgVmlzdWFsIFNlbnNpbmcgQ29u
dHJvbGxlciBJbnRlcmZhY2UiKTsNCk1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCk1PRFVMRV9JTVBP
UlRfTlMoVlNDX1RQKTsNCg0KQlIsDQpXZW50b25nDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg==
