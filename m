Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9E78B1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjH1Nbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjH1Nb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:31:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD79A7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693229483; x=1724765483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J72EpWDi0LCxhyHiPaW/x1LkUzmNo9YrygOLW5vOnsg=;
  b=kBM7j7jUmkxGzsnN1fLMMQ1oqRKO/yMDU2IYVc795ZNjKMApn7LVg+Fe
   tWNB/ho80CeJsYLsmpj6TKMwicOxDgxCZcRw1FXWtFVvqpSFQHlpgdmfu
   L+eUnX9Gw0n5aGPhYdec103c9MMotJo2fdwlKadhmRfpkxBYAUe/+aDeg
   fVX/Lw5/CXGQBdcffDACkhBoGS0S/q2GrN5j59hcn1SbOGVm74u929aPI
   MSnylmkUvLzX6zSmvaZ2NCanEtfFTojsKfzJOWwwfYWZBwQejg3Wu+VYO
   WPv3zdir7CLcpLL1lfa0rRGywxYITVuxSmd+vGd4AbqEU8URiCSFncM4J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372510185"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="372510185"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 06:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="852859185"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="852859185"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2023 06:31:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 06:31:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 06:31:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 06:31:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsJKbs+GHyIWe5ppXBZRwq9ORBEkIsjz/bDdOL3bGV92sHpLus6R4E+c1SJt0x4sskt85q74x7fZJxsYVcQ8+p7Ro0My8Xy2DmkN+zUNIf5x0CppZA8RzqSQF8pDCTt6IIQDPhD4oMnss9ZiqQfOL+vqjEks3LrxEmkaBhY9rMAtcVnQdmty68ACW0YNBnWYbZv22Py2Rpmqaj3MAg0iWbDtAh1aA48A9sMw/4518Czlorok9QQJMTM8FKDygcMqRIKfOWscJQjCg8bRDhDR4DtZ8mu0PhlvhOZDmJ0fSNG1X1jo1wojCKPx8kqymy5vYMAXDeNvpF8pQTzQKhiaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J72EpWDi0LCxhyHiPaW/x1LkUzmNo9YrygOLW5vOnsg=;
 b=IIE9xTRqz+eH3K9GMKA2n/CXVOcGeYtmcK8jjlPFMlqSLKQwLGa8/Uv7nQkHLR4s5kegMx35A5rvLpinDXljVM7rr24zs/y5u618uge4JIcz6yXf37HX8yBLVrTBXO+A+7tj21rR2OPymp/npznUJchy3fGQNbcKyrlTE0Hix5yQF9tLAIuDADegc2YIJVdtq9xa6X+pqJ0HOQM7IqRsVnv5DilzTWnnjh2Nn8ymkAsc5ONLGtZeCviPJVWB57+ea+2x8GNoloS4a7iVmtRXmMn86WcujToFF6t+SieoX+x2I2DKfQFAvut9PsGFhXExarlyrDlFaN4uOyMCDvR7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) by
 LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:31:17 +0000
Received: from DM8PR11MB5608.namprd11.prod.outlook.com
 ([fe80::7c76:b797:1cec:b206]) by DM8PR11MB5608.namprd11.prod.outlook.com
 ([fe80::7c76:b797:1cec:b206%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 13:31:17 +0000
From:   "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Nikula, Jarkko" <jarkko.nikula@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v1] mtd: spi-nor: macronix: Add support for MX77U25650F
Thread-Topic: [PATCH v1] mtd: spi-nor: macronix: Add support for MX77U25650F
Thread-Index: AQHZukezhnuwLSWDtEONN1YsR0u8b6/BNBsAgAqMA5CANC8EMA==
Date:   Mon, 28 Aug 2023 13:31:17 +0000
Message-ID: <DM8PR11MB56083DF77695E0CB25EA7587A5E0A@DM8PR11MB5608.namprd11.prod.outlook.com>
References: <20230719132700.15274-1-mahesh.r.vaidya@intel.com>
 <b6725f64-7d08-5966-e0bc-17c5b2e846ad@linaro.org>
 <SJ0PR11MB561367FC6A2A9984E636A25DA500A@SJ0PR11MB5613.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB561367FC6A2A9984E636A25DA500A@SJ0PR11MB5613.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tudor.ambarus@linaro.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5608:EE_|LV8PR11MB8559:EE_
x-ms-office365-filtering-correlation-id: 596a1c92-301c-4e5e-5678-08dba7cb0f28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4zGWtAy3Ez8Fvmf41qJ7Bu/1CcEnsu/YmHiS0Rpk964wxS/H3SHPyz0pA65is8LoT5Sy78WYmK7hpA4bOoCRF9kkQBwl0h/6Ee2RnopI0kT5WI55jSRg0max9YgPk1C3kQYBnkNDfJFncS8snzPHo8kK5HMY6/4AIVhyBwF1VKRNqppl0nO29F+EMEnLuUYV+jYsYS6kKZHQz9DN5lP7o4ZT5v/6r4bPpEbO9wudTzNPK6w19Ukmyp/vGpimndwsce/8xa7y2v+5vnBuvq6Y+rzi44se/IgHodKoCnougCVS99AUZJ49Wp7at/RtlYVJtlIWIhsbwr9LGx4tTD6udbZsBmkxbNV/6/VM/+qR5bS/9Hutu4ocQOF1kcmrGllu0DmAe/ImADseNGuY9O0l1JAhmVHKDjjLQq4BPXiTrndgJerx8zzeGfiVyN9AvifikaTbOyNUpAiFaRhNwG9ubHAtE3pMlscq2811P4iQsVPMZsNgQ6jlYTvfEsS7G76LtrARhsBh32vVyR2kTNKtJyrhaU9VM7JGE/A9JsGQJMfnILP2UhGd0QwyY2JNRZ+HD9ADFnWZkpKf4GcPgRmeBw5lYgey71b2hsBmZBwabLQlNSOfdLLSRWXHjz2DR/E1xXmzC9kWI4QWPFvopfmFNvZmPzJ1bsGEBrUu530Zds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(66446008)(110136005)(54906003)(66946007)(66556008)(64756008)(33656002)(66476007)(316002)(76116006)(5660300002)(52536014)(966005)(41300700001)(6506007)(7696005)(53546011)(26005)(9686003)(55236004)(55016003)(38070700005)(38100700002)(122000001)(478600001)(83380400001)(82960400001)(71200400001)(86362001)(473944003)(414714003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNiZ0VTWnFtYklwRHpINmtvdTEvK1VOTld3YmovaytKUS9za0crcWVWSHBp?=
 =?utf-8?B?bzErY1I4dFJsMksxZVl5NFd4MjNKR05aVDduSVR3R0t6dWYrblhvdXRNSmFq?=
 =?utf-8?B?RU5PcmNlSnJ2emVhUEptZlI2bURhVEFKNCt3cWMya0UxWDczQmtUdFJPbng3?=
 =?utf-8?B?N3RRcEIvang0VVUvNG9uVUZiUlNSMzZPVE9XUGZnZkFTNEFhV0ZqMlMwOHRZ?=
 =?utf-8?B?RDI2RWxMeElQWG9nMEIvWGFlUTh5eFpHQlF2a21XVUt0WTRFckV3S1lHL3ZU?=
 =?utf-8?B?T29jYWU4TCtrbVRLZGNXSWRJV2haaktyZ1BVSE4raE40Q244eEQxR0hBditB?=
 =?utf-8?B?K0kvUDNkOGR1NFBNMGZEY0NyUDdzQXorZ0RGbEtObDZXUFVVMHd5UlZIVXhI?=
 =?utf-8?B?K2xLNCtFRk95ZmtwczVZanU3aWU5ZHhIMkZmbitsdnZSbHJ4SHQ2bVFBZW9J?=
 =?utf-8?B?ekJRcXFjWm1YajV4bTJyQU1TMGcxLzlMamNWd3lsQlE4TDJzQ1JzTFlnOHJa?=
 =?utf-8?B?Vy8yemMxWGRwU1BVTzJ6TUJiZWFYWHBYZEY3dXpULzN6Tjd5Q2RheWt1eVVE?=
 =?utf-8?B?WFhocVM0MUxxK1V5bmI0TmJ2SmlKNjhGSFBxclJlK0N6WWhKOC9CS1BySm9w?=
 =?utf-8?B?eklzVGpWQlpWTnRCVSt2eHFNakV4S1MycWtKUWNneTQ0VkpMNlJqM0xnSVJF?=
 =?utf-8?B?S3k3YTR1T0F3bVJaWUZQWXkxU1B4V1VmM2ZhbmJqVkxxY21xdEkxZlFZOVVW?=
 =?utf-8?B?YWwzMjNCUE5zeUQ0NE1pMHNlR2RVODkwb1c5Rk1FVWFtQzd2U0w0NnZnOXoz?=
 =?utf-8?B?ekpGTy9RZU44Q1RNWGo0Sjdkdmh3M1ROOFZYTVlqSlFqRVVYemNXQmtGRXJu?=
 =?utf-8?B?ajBXTld1UkwwR1ZUWGpST2w1eGloWUlLeUF6VGVWZ01vbDNhQ2cwQzNxMmhV?=
 =?utf-8?B?TWx2UmZhcHNVcFE4ZU1DRFRUOVpEQnM5YzkvZjZEZE5pYURMTzlSdHBBTDlz?=
 =?utf-8?B?SW04YmVBMFpHRUl0Q1VKUnBMTFM1OUlOUFhVNCt0SmNydVJraERBeWQvZmJP?=
 =?utf-8?B?YTNJZnMyTHNod3hkNFdCRVdJUmNHekRCQ0E4OW44OG5HZDQ5eEVFczJTTENZ?=
 =?utf-8?B?b20yQ1RMZEYxMjNjK0VMdE9PTUpsL1RjMklrVTNUMU52K0V1QjFOanlwOEw3?=
 =?utf-8?B?VXY0U0dQa1JpY1laMy9SQXJzT0dOR0RHS0J6emNJUWkvc2FrSENFbmpOK3dS?=
 =?utf-8?B?Y01YS21SazlPb1hkMjMrckg0QUZZYWIyM3k3VFBmSjR0NHQ1ZGRZbW05bW5v?=
 =?utf-8?B?MjR2UnA0aEZleUNadXN4WFJZLzZjM2Fjek1aRENLL0lFMUVSTklCbWpXb0sv?=
 =?utf-8?B?anpRWURaVERhYmxlVG1OYk10bjNNUFgxRUJ2RW40Rjd2SWUzQWVGUms1cVFW?=
 =?utf-8?B?NGhSbHdOckFQbWNDbjFCSGIyZTlvQWNIWkNyamhRRlJtWHI1Q01xY0tzSjc1?=
 =?utf-8?B?Uk5UTXNRN3pqNlVPbWhud29jQVZZYWxkNnl4TkE0aE91c3hSTTV4VjVHOEtZ?=
 =?utf-8?B?ZUFVbmdUeXM3VUxnZDJwZUxUWDVUR2Npbm5ENnFZZUQ2RHZtSEttNUhPcHJj?=
 =?utf-8?B?V2k0UEJnMmVIaWVsMWNLYUpiUXcyVDFXcDAweWo5RWQ1Ym94M0ZkVlQ0ZXFo?=
 =?utf-8?B?YkxNeWpmbXdhaE5acDNSNXJ1VmlmZXJ6Vk9BenZkejFjOURDWGZmeUNPbWhr?=
 =?utf-8?B?TWx2RnRMODJ5WmhGQWgzYytvWk1idVowZWd0S0QvK1NzajJmcU9kQW9jV2J1?=
 =?utf-8?B?V05sY2tXbUJLNm5NT3dCYTVua3ZpOEkvejFFOHJDNjltTTJLL2laYk9yMlRE?=
 =?utf-8?B?ZXNZaXZkM1RqNnlBTHF5T0JJcVJnVXdJSy9uckw1N01VcXAzWUlhUXQ1SWVk?=
 =?utf-8?B?U2dSM1Q0T09GdDJBdm5YOCszeDlEWkw1cTdqQkV3KythWm1UQytTdGxIbjIr?=
 =?utf-8?B?Zi9DcEhjWWJLSU16Y0lxVjlCZjcxcDNTankraXplZWdUUHk3WHZzQmY3QllC?=
 =?utf-8?B?NWl2ZEs5K0E4VFcrbDZtZHQ2NWt3S0tjcEFSMFpSRkVmbVNSRXhoYit4b0FU?=
 =?utf-8?Q?qTxgvpiT3vwUHIkdGZvcfIs7O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a1c92-301c-4e5e-5678-08dba7cb0f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 13:31:17.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bM0ofFCt+sCazqQV0IOD8Occm0JFlmchjknxZnsczIvDP1HJmniDhBi5W6thw0fv9B0hyu8dCSwZLbyi+Fymqox1JQGpC1kXDe+7bUoKrHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmFpZHlhLCBNYWhlc2gg
Ug0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjYsIDIwMjMgMTo1NSBQTQ0KPiBUbzogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPjsgcHJhdHl1c2hAa2VybmVsLm9yZzsN
Cj4gbWljaGFlbEB3YWxsZS5jYzsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgcmljaGFyZEBu
b2QuYXQ7DQo+IHZpZ25lc2hyQHRpLmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbTsgTmlrdWxhLCBKYXJra28NCj4gPGphcmtrby5uaWt1bGFAaW50ZWwuY29t
PjsgWmhvdSwgRnVyb25nIDxmdXJvbmcuemhvdUBpbnRlbC5jb20+OyBTYW5nYW5uYXZhciwNCj4g
TWFsbGlrYXJqdW5hcHBhIDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsg
U3Jpa2FuZGFuLCBOYW5kaGluaQ0KPiA8bmFuZGhpbmkuc3Jpa2FuZGFuQGludGVsLmNvbT47IEEs
IFJhc2htaSA8UmFzaG1pLkFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYxXSBt
dGQ6IHNwaS1ub3I6IG1hY3Jvbml4OiBBZGQgc3VwcG9ydCBmb3IgTVg3N1UyNTY1MEYNCj4gDQo+
IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFR1ZG9yIEFt
YmFydXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEp1
bHkgMTksIDIwMjMgODo0OSBQTQ0KPiA+IFRvOiBWYWlkeWEsIE1haGVzaCBSIDxtYWhlc2guci52
YWlkeWFAaW50ZWwuY29tPjsgcHJhdHl1c2hAa2VybmVsLm9yZzsNCj4gPiBtaWNoYWVsQHdhbGxl
LmNjOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOyByaWNoYXJkQG5vZC5hdDsNCj4gPiB2aWdu
ZXNockB0aS5jb207IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogYW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tOyBOaWt1bGEsIEphcmtrbw0KPiA+IDxqYXJra28ubmlrdWxhQGludGVsLmNvbT47IFpo
b3UsIEZ1cm9uZyA8ZnVyb25nLnpob3VAaW50ZWwuY29tPjsNCj4gPiBTYW5nYW5uYXZhciwgTWFs
bGlrYXJqdW5hcHBhIDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsNCj4g
PiBTcmlrYW5kYW4sIE5hbmRoaW5pIDxuYW5kaGluaS5zcmlrYW5kYW5AaW50ZWwuY29tPjsgQSwg
UmFzaG1pDQo+ID4gPHJhc2htaS5hQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxXSBtdGQ6IHNwaS1ub3I6IG1hY3Jvbml4OiBBZGQgc3VwcG9ydCBmb3INCj4gPiBNWDc3VTI1
NjUwRg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBPbiA3LzE5LzIzIDE0OjI3LCBtYWhlc2guci52
YWlkeWFAaW50ZWwuY29tIHdyb3RlOg0KPiA+ID4gRnJvbTogTWFoZXNoIFIgVmFpZHlhIDxtYWhl
c2guci52YWlkeWFAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IFRoZSBNWDc3MjU2NTBGIGlzIHBy
b2R1Y3Rpb24gY2hpcCBmb3IgbmV3IGRlc2lnbiBmcm9tIE1hY3Jvbml4IHdpdGgNCj4gPiA+IGEg
bGVzc2VyIG1lbW9yeSBvZiAyNTZNYml0IHdpdGggdW5pcXVlIHNlY3VyaXR5IGZlYXR1cmVzIGxp
a2UNCj4gPiA+IFBlcm1hbmVudA0KPiA+ID4gNCBJL08gUlBNQywgU2VjdXJlZCA4SyBPVFAgc3Vw
cG9ydC4NCj4gPiA+DQo+ID4gPiBWYWxpZGF0ZWQgYnkgcmVhZCwgZXJhc2UsIHdyaXRlIGFuZCBy
ZWFkIGJhY2suDQo+ID4gPiBUZXN0ZWQgb24gSW50ZWwgUlBMLCBQQVNTLg0KPiA+ID4gVGVzdGVk
LWJ5OiBNYWhlc2ggUiBWYWlkeWEgPG1haGVzaC5yLnZhaWR5YUBpbnRlbC5jb20+DQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogTWFoZXNoIFIgVmFpZHlhIDxtYWhlc2guci52YWlkeWFAaW50
ZWwuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tdGQvc3Bp
LW5vci9tYWNyb25peC5jIHwgMyArKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWFj
cm9uaXguYw0KPiA+ID4gYi9kcml2ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMgaW5kZXggMDQ4
ODgyNThlODkxLi45OTU5MzZiYTU4ZTINCj4gPiA+IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9tYWNyb25peC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L21hY3Jvbml4LmMNCj4gPiA+IEBAIC0xMDMsNiArMTAzLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBmbGFzaF9pbmZvIG1hY3Jvbml4X25vcl9wYXJ0c1tdID0gew0KPiA+ID4gIAl7ICJteDY2dTJn
NDVnIiwJIElORk8oMHhjMjI1M2MsIDAsIDY0ICogMTAyNCwgNDA5NikNCj4gPiA+ICAJCU5PX1NG
RFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwNCj4gPiBTUElfTk9SX1FVQURf
UkVBRCkNCj4gPiA+ICAJCUZJWFVQX0ZMQUdTKFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gPiA+
ICsJeyAibXg3N3UyNTY1MGYiLCAgSU5GTygweGMyNzUzOSwgMCwgNjQgKiAxMDI0LCA1MTIpDQo+
ID4gPiArCQlOT19TRkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8DQo+ID4g
U1BJX05PUl9RVUFEX1JFQUQpDQo+ID4gPiArCQlGSVhVUF9GTEFHUyhTUElfTk9SXzRCX09QQ09E
RVMpIH0sDQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4NCj4gPiBEb2VzIHRoaXMgZmxhc2ggc3VwcG9y
dCBTRkRQIHRhYmxlcz8gSGVyZSdzIGhvdyB5b3UgY2FuIGRldGVybWluZSB0aGF0Og0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiA+IG10ZC9jb3Zlci4xNjg2NTU3MTM5Lmdp
dC5UYWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tLw0KPiA+DQo+ID4gSWYgeWVzLCB0aGVuIHlv
dSBjb3VsZCB1c2UgdGhlIGdlbmVyaWMgc3BpLW5vciBkcml2ZXIsIHRodXMgeW91IHdvbid0DQo+
ID4gbmVlZCB0byBleHBsaWNpdGx5IGRlZmluZSBhIGZsYXNoIGVudHJ5LA0KPiA+IFNlZToNCj4g
PiA3NzNiYmUxMDQ0OTcgbXRkOiBzcGktbm9yOiBhZGQgZ2VuZXJpYyBmbGFzaCBkcml2ZXINCj4g
DQo+IFN1cmUsIHdlIHdpbGwgY2hlY2sgb24gdGhpcyBmbGFzaCBhbmQgdXBkYXRlIG9uIHRoZSBT
RkRQIHN1cHBvcnQuDQoNCkhpIEBUdWRvciBBbWJhcnVzLA0KVmVyeSBzb3JyeSBmb3IgdGhlIGRl
bGF5IGluIG91ciByZXNwb25zZS4NCldlIGhhdmUgY2hlY2tlZCBhbmQgdmFsaWRhdGVkIHRvIGNv
bmZpcm0gdGhhdCB0aGlzIGZsYXNoIE1YNzdVMjU2NTBGIGRvZXMgc3VwcG9ydCBTRkRQIHRhYmxl
cy4NCkJlbG93IGFyZSB0aGUgdGVzdCByZXN1bHQgbG9ncyBleGVjdXRlZCB3aXRoIHRoZSBTRkRQ
IHN1cHBvcnQgaW5kaWNhdGluZyB3cml0ZS9yZWFkIGJlaW5nIHN1Y2Nlc3NmdWwuDQpXaXRoIHRo
aXMsIEkgdGhpbmsgd2UgY2FuIGNsb3NlIHRoaXMgcmV2aWV3L21haWwgY2hhaW4uIFBsZWFzZSBh
ZHZpc2Ugb3RoZXJ3aXNlLg0KDQpURVNUIExPR1MgYmVsb3ctOg0KDQpzcGktbm9yIGluZm86DQp1
c2VyQGxvY2FsaG9zdDovc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkwLjAvc3BpLW5vciQgY2F0IHBh
cnRuYW1lDQpzcGktbm9yLWdlbmVyaWMNCnVzZXJAbG9jYWxob3N0Oi9zeXMvYnVzL3NwaS9kZXZp
Y2VzL3NwaTAuMC9zcGktbm9yJCBjYXQgamVkZWNfaWQNCmMyNzUzOWMyNzUzOQ0KdXNlckBsb2Nh
bGhvc3Q6L3N5cy9idXMvc3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3IkIHh4ZCBzZmRwDQowMDAw
MDAwMDogNTM0NiA0NDUwIDA2MDEgMDNmZiAwMDA2IDAxMTAgMzAwMCAwMGZmIA0KMDAwMDAwMTA6
IGMyMDAgMDEwNCAxMDAxIDAwZmYgMDMwMCAwMTAyIDAwMDEgMDBmZiANCjAwMDAwMDIwOiA4NDAw
IDAxMDIgYzAwMCAwMGZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgDQowMDAwMDAzMDogZTUyMCBmM2Zm
IGZmZmYgZmYwZiA0NGViIDA4NmIgMDgzYiAwNGJiDQowMDAwMDA0MDogZWVmZiBmZmZmIGZmZmYg
MDBmZiBmZmZmIDAwZmYgMGMyMCAwZjUyDQowMDAwMDA1MDogMTBkOCAwMGZmIDgzNDEgYmQwMCA4
MmE3IDA0ZGIgNDQwMyAzNzM4DQowMDAwMDA2MDogMzBiMCAzMGIwIGY3YTkgZDU1YyAwMDllIDI5
ZmYgZjA1MCBmOTg1DQowMDAwMDA3MDogZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
ZiBmZmZmIA0KMDAwMDAwODA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
ZiANCjAwMDAwMDkwOiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgDQow
MDAwMDBhMDogZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIA0KMDAwMDAw
YjA6IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiANCjAwMDAwMGMwOiA3
ZjBmIGYwZmYgMjE1YyBkY2ZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgDQowMDAwMDBkMDogZmZmZiBm
ZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmDQowMDAwMDBlMDogZmZmZiBmZmZmIGZm
ZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmDQowMDAwMDBmMDogZmZmZiBmZmZmIGZmZmYgZmZm
ZiBmZmZmIGZmZmYgZmZmZiBmZmZmIA0KMDAwMDAxMDA6IDNjOWIgOTZmMCBjNWE0IGMyZmYgZmZm
ZiBmZmZmIGZmZmYgZmZmZiANCjAwMDAwMTEwOiAwMDIwIDUwMTYgOWRmOSBjMDY0IGZlY2YgZmZm
ZiBmZmZmIGZmZmYNCg0KDQptdGQgaW5mbzoNCnVzZXJAbG9jYWxob3N0On4kIHN1ZG8gbXRkX2Rl
YnVnIGluZm8gL2Rldi9tdGQwDQptdGQudHlwZSA9IE1URF9OT1JGTEFTSA0KbXRkLmZsYWdzID0g
TVREX0NBUF9OT1JGTEFTSA0KbXRkLnNpemUgPSAzMzU1NDQzMiAoMzJNKQ0KbXRkLmVyYXNlc2l6
ZSA9IDQwOTYgKDRLKQ0KbXRkLndyaXRlc2l6ZSA9IDENCm10ZC5vb2JzaXplID0gMA0KcmVnaW9u
cyA9IDANCg0KbXRkIHJlYWQgd3JpdGUgdGVzdDoNCnVzZXJAbG9jYWxob3N0On4kIHN1ZG8gbXRk
X2RlYnVnIHdyaXRlIC9kZXYvbXRkMCAweDAwMjgwMDAgMTg1NzEgcXNwaV93cml0ZQ0KQ29waWVk
IDE4NTcxIGJ5dGVzIGZyb20gcXNwaV93cml0ZSB0byBhZGRyZXNzIDB4MDAwMjgwMDAgaW4gZmxh
c2gNCnVzZXJAbG9jYWxob3N0On4kIHN1ZG8gbXRkX2RlYnVnIHJlYWQgL2Rldi9tdGQwIDB4MDAy
ODAwMCAxODU3MSBxc3BpX3JlYWQNCkNvcGllZCAxODU3MSBieXRlcyBmcm9tIGFkZHJlc3MgMHgw
MDAyODAwMCBpbiBmbGFzaCB0byBxc3BpX3JlYWQNCg0KdXNlckBsb2NhbGhvc3Q6fiQgbWQ1c3Vt
IHFzcGlfd3JpdGUgcXNwaV9yZWFkDQowYzg2YTg2YzE2OWE4YTI5Njk2MDg4OGE3OGI3NWNiYSAg
cXNwaV93cml0ZQ0KMGM4NmE4NmMxNjlhOGEyOTY5NjA4ODhhNzhiNzVjYmEgIHFzcGlfcmVhZA0K
DQp1c2VyQGxvY2FsaG9zdDp+JCBzaGExc3VtIHFzcGlfd3JpdGUgcXNwaV9yZWFkDQoxMzIxYmVm
ZTdjODJiZDc0ODhkNWJlOTMzY2NiNmM0NDU5YzMyMDdlICBxc3BpX3dyaXRlDQoxMzIxYmVmZTdj
ODJiZDc0ODhkNWJlOTMzY2NiNmM0NDU5YzMyMDdlICBxc3BpX3JlYWQNCg0KbXRkX2VyYXNlIHRl
c3QgKGFsbCBidXQgb25lIHNlY3Rvcik6DQp1c2VyQGxvY2FsaG9zdDp+JCBzdWRvIG10ZF9kZWJ1
ZyBlcmFzZSAvZGV2L210ZDAgMCAzMjUwNTg1Ng0KRXJhc2VkIDMyNTA1ODU2IGJ5dGVzIGZyb20g
YWRkcmVzcyAweDAwMDAwMDAwIGluIGZsYXNoLg0KDQoNCg==
