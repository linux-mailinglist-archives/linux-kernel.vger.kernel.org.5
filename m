Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559CF786785
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbjHXGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjHXGas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:30:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5C170A;
        Wed, 23 Aug 2023 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692858638; x=1724394638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nQQaDg09vZ0M2IG3QZHi3J160Tfsz2aOhkTVPHklBqI=;
  b=ZTqTBY9BlrGq+YiW6XHQ1WegYbfF7diy0FzMityURmYWZw2Ox99IYkk5
   cnA8rWSPGtIH+HPQS2pQl3nJ215PI3JRoWyX8p0QeDaibFqisIZKX2ugD
   2Q6pKZlPRp2HjE4M59WNupwiAtE/KzxHKuTCzkttxAPrcfLZSWYFARe/E
   pk7yBuOW3wIMvrKKTZ5/8Q+loBW4P9x444FKGf4XJxq+0c+6kbuAJnQFA
   G4Nm2l7sUQvXe0Hg3f7AtjUmpH+bnBJN5bfrL5cwBIKdEFMDpE5nZWrQM
   EDqxjVaS1ZVQ6mVAczKiCPKIZkwkQoRg8Hpb1pYDlpxH/tDKxloGXeZTe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405357033"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405357033"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 23:30:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="1067712281"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067712281"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2023 23:30:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 23:30:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 23:30:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 23:30:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 23:30:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDQsNoH6ZjDzgzkUXMP8u5mWLH/wmlAf/KejSD/BiNtH/VjO3VHPJ/HV3qF/v9yDXPLHS5BeAeH/HH23TdTUwEXTe4qD3pEu29trRprmQiF4IQ46Tybtizn4JvGNImGb7IW0lBiQBLay0Us1H/FXBVWnklzjND0SSgUcbnai0D5NcEHUoPodd+cXshDozby7LCii9qH6eLqMmBDf6dUzNLQD8Jdd5fuvQPesQhAwqFvdLw+arSBWg3FgxQLjonmJtRE9M76DfD8i89SrHIPbstxs5rXS7Iho0dbL6dUQ4OqCa/4r+FQCtvJxDADU9b7YPFUTthIQhad3WWtD/dUC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQQaDg09vZ0M2IG3QZHi3J160Tfsz2aOhkTVPHklBqI=;
 b=VNWMr2SMuG+D6pop9aYBX7lR3TLS6AybyErcHJRmLoSfzfrJzeIctTUoHw2dm893txEjMHvQCaW2Xhlgn4TNVjWww7T6cpIZJX1FMU9H0FZQK/x2YfO9BzRH+poz52bGRBcojMUTCilod1nGChgP1+HzJJ1afcpnbNd1S6mC0txwZWzPKyNy1YGFkNdN8l8GXM8SQgg5j/gefDRm0C2soiWTi1lFoy+dds0CSTnk8jTl6ram3osOBT7wIw236dRwp8bUgCj3Tg5neXJp6wa5AcDiIaFTAem4HQrkoDKNs2GKzbv0jZaYIo+7F5tOe6KvNHpDUlEcqL7/30xcn5Y+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB5706.namprd11.prod.outlook.com (2603:10b6:610:ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 06:30:35 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 06:30:35 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "smarter3@gmail.com" <smarter3@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "Kumar, Vinay" <vinay.kumar@intel.com>
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
Thread-Topic: [PATCH] intel_idle: Add RaptorLake support
Thread-Index: AQHZK9QM69Ctt/8BWU2kz43rXhq0Oq6l6maAgU1oRgCAAOTNgIAAEvuAgAYG2gA=
Date:   Thu, 24 Aug 2023 06:30:34 +0000
Message-ID: <f493c62fcfced4df8240e3386ca132e58364b9f7.camel@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
         <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
         <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
         <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
         <5799076a-7fbe-cba9-5c6a-73de83351a3a@gmail.com>
In-Reply-To: <5799076a-7fbe-cba9-5c6a-73de83351a3a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB5706:EE_
x-ms-office365-filtering-correlation-id: d9b86215-e106-4b29-e0f2-08dba46b9fa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+aHTeBDwaGNPzGirJGk4XOhUL4sGrKGMJfS6Vq575YMfEnvOARq0nNvEjH88ws03Hrp+9xMncAIGz6KarqYQCv1EOe1s7m5rgEPWISSb0vmXt5ufrP9HB3XtFHqriTVw45h2EC1nXfg16jGB6Gch5egxn0/+TPsZjzTXoxR845EmjCHf6OUr6lDAjzIaer/umPtfwkYfp/2kxL0JamqdpJC6nWhtZsZMS2uZ/UUg1VLYN8Aro18JgVycYeMgzs+/Ln0edGEPFDZOlt9n3TR0CzcMX71cm3BdG1aS9j7qHm3/zSrlnUa7uzudNidQEVWmCQ9APHQu88d8XKka+CaLBTa488MoCVhJ1qpVpJTMnFlTjTN3FWE9W/lL5fO1yRv76RtrGoJAbQP0ZtZW7TrMKQLPEzICO0iL3S+lQFcb98KgK0SdAfVWh+Raojb8j1ZoTGKvVNa4dO2YPvN+z1sAxfjOWzv4F67HpNqA2k2HjEgdalBxmS04UKCMsrzQV6Jw6qkqCKhjffS5q8C3ilen5SYtHJ5rZRpc3UY2yRJtqZIlz1IzIidecgKqeJSVNwJkvdqE7v/ZEMfVbiYIlMgxffEkheMuXKZ+ed6+I4ARmITBCb1/Y6KA0wXxb25P+SG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(26005)(71200400001)(38070700005)(38100700002)(82960400001)(122000001)(66556008)(66476007)(66946007)(54906003)(64756008)(66446008)(76116006)(316002)(110136005)(91956017)(478600001)(41300700001)(53546011)(2906002)(6512007)(6506007)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFRRVy9ScDcwdWZuQlcwaTRhNGlaaDMwV3JCVGJHajBOaEtNSVNjYkZNR1ky?=
 =?utf-8?B?WXArZHAvazdiYnNpWWdCQ3UrYU5hZWNJRmYrd09XMnE2ZDM2UGIrcko4YWJ5?=
 =?utf-8?B?ZHhoU09hRTFTenFPc3RlUXB1eGJCTkFsWWcwN3I0MlpVa3c1MFRFeHZUWHFY?=
 =?utf-8?B?Qm92bGNPZHd2ZjhQOFhYSlFKVURQR2VuK05XVG1YSlVreE5YaWU3OHVBZ2RP?=
 =?utf-8?B?U3pITGxwWmxyUzFoelJiekozTC9PNXVGa25GcnY2eEhEYnFsbXRabWN0NVFy?=
 =?utf-8?B?TW4zdVZRd1huRGhSdUpNa0piWlUzVUIzYVd4N2V2RXNleGU1WWNqRHhPZWR0?=
 =?utf-8?B?RjFpWmszaFROTzVUSVNvMjJXVlBLQ0pRNG0rRWRnNG13WW9YVEI5M0xvdGNs?=
 =?utf-8?B?N3VKRTZ2UUpGdTh2WGZMVHdXajlGM2NxMjBrUE5PdW1jelZHQlhQdk0zcVpw?=
 =?utf-8?B?UzVWQ3c5NmgyMVRmOVBvajZLWThkUElLeXJ1bkk3S21VRHhsU2dib2w0dHpp?=
 =?utf-8?B?VjZJRm85OUJWbHc1QkFRbFZ4dkhQa0duTE1mZ0ZoUDJMZi9aTmNWVFRrUWhv?=
 =?utf-8?B?SThYcmE3NGxXNWNUVGRKYWtHL3E2cDl1eUJaTVIrbUVZalBsR2hlMldGK21P?=
 =?utf-8?B?UVF0NWp0OWNTVURkSFZDeGpGaXZFSEVEYTJhaWtjNUZjZmF5RjJJclRWK3Bh?=
 =?utf-8?B?S1o2RUkyTkRoWHRXbFlpUUE4OFRGVUorUjVQd2F3RWl2QVd2MGdrTk9uQmts?=
 =?utf-8?B?eCtjd1BlaWgzejAxQklJSlV0emprRDhoeDdQMC9KWjRjenRiWXF5MHBDR3FL?=
 =?utf-8?B?bkVKc2FwejBnbS80b1B1VC9TQUk0ZVQ3aTJvTWcwaGlueWhCMUpyUitFbVlp?=
 =?utf-8?B?YlNTWEdWamowL3RMTjZCQWg3Vk01dkp0OEN0bUxDU2ZDZHBrYkdmRHgvNjR2?=
 =?utf-8?B?enN1UC9hdFdod1JXVWtjTVhJZ1lNOXFOdFpaR1lING5vUjZ2TTI5bmVsSGNZ?=
 =?utf-8?B?RmRkbGtQUUVpZlk3MjRpSmVhRW0zc3NqRG1RVmlFc2VyNDRYb044bDVYWXNT?=
 =?utf-8?B?dEhiUGJtSFJVTjBjdFpNc3MyMDEvNzUyVzFvTm8zUHRCNzRwWDhZcUdFTUc1?=
 =?utf-8?B?dkNFZWduTGl6STNSeHJ0dG5qZEhUK2ZMZjM0QkdnMVFFU2RyRzVOODQrbTFt?=
 =?utf-8?B?b1NDMEgrNnhpSGtyc1BFRW1iKzc0ZkMxU2JYMG9DNTRFSmtjRm5VaDU4ZXBs?=
 =?utf-8?B?WjdEWXlwMGZBT1hzRlFGcjJFeWhQSUp2Zk42aEU5cG56bzh1aUxWN2xWbU5C?=
 =?utf-8?B?MmhWUE5URjd5bGJOdjh3LzVhY1pPNjJoQndVUEVLQ2hnQUJXcGRuSHgrMnhp?=
 =?utf-8?B?cldrWFNBQld6ZWtvYWxsWFV3dWNnMFM3bWlTWDF2Ui90MkUwOGtkUnoyeHhp?=
 =?utf-8?B?dHR6aGpUQXBWU0wvRzR0MWZSSVJBZ0owcVJ2UGZWTnhweUdBMlFmS1pRaDdj?=
 =?utf-8?B?N0FCSGlhWHdRMEIrYm1tdUoxa1BWdWRvVHNuZ0d6OGxFd2lldXB5eXdTZUZF?=
 =?utf-8?B?TnBYYVh2akEwMFpyMmhseTVRZVNxR0NBZEJFYXNGKzVDWlduNE9zZVVRdzlO?=
 =?utf-8?B?aEdaQTlTbEt4WFZNRGJxNXgyZHpUajZzYVY3MU40c0kvYlV5c21JT1gxS1Nk?=
 =?utf-8?B?M3pEdkdhL1VYREVqelFlZTVPeWF4L3lyTUZQUXk4eUREb2crV3UzaEFhbDhH?=
 =?utf-8?B?anpoSkZNbE44aFhxa1dreDY0RktreTdYU2hVOTVEQlJNeGdHR2ZqZVVYN1Z4?=
 =?utf-8?B?YkFNODlhNEdEeUI5UGY4MTd4MURTTTJHSFk4b0NNSUVlZVpGWGdLa2ZQR2pZ?=
 =?utf-8?B?emFkNlMrQTRYN3Z3L3crYzBPenV4b3J2TVlLQVF6Tlp4ZXY5L0JISTdLbjhS?=
 =?utf-8?B?a0pYTnF0N215NHE4RE80NjFHbFRYS2J0UTBPbFdxSlVzS2Rxb29CV3JNZ3Nu?=
 =?utf-8?B?eE11MExaSStFazFLVVFSQXhDTFVnZW8xUDRaR09MM1Rwc3pJNnZaRlNOY1hE?=
 =?utf-8?B?Z3lUVkFpQWR1Z1VaY3oyWUg2UlErdjFEZitYQ09GODZjNG15UmdTZUNueDhk?=
 =?utf-8?B?Vlg4VzNhanRsNURJUGxMMUdHMUZoc1VNckhkMWZFTTloZTBoY0dURFIrWjBs?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2970DF2B15DCA4CA7878832C98B01CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b86215-e106-4b29-e0f2-08dba46b9fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 06:30:34.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5zh7r6S60jTlI02iJTqbpFZkZBqxjQ+rsgNtWuW+O6jB1Jt1F4cquXbz214fBdft0sRnzlmDBBpIpEJZln11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA4LTIwIGF0IDEyOjI4ICswMjAwLCBHdWlsbGF1bWUgTWFydHJlcyB3cm90
ZToNCj4gDQo+IA0KPiBMZSAyMC8wOC8yMDIzIMOgIDExOjIwLCBaaGFuZywgUnVpIGEgw6ljcml0
wqA6DQo+ID4gT24gU2F0LCAyMDIzLTA4LTE5IGF0IDIxOjQxICswMjAwLCBHdWlsbGF1bWUgTWFy
dHJlcyB3cm90ZToNCj4gPiA+IE9uIDEvMTkvMjMgMTc6MTMsIFpoYW5nLCBSdWkgd3JvdGU6DQo+
ID4gPiA+IE9uIFRodSwgMjAyMy0wMS0xOSBhdCAwODowMiArMDEwMCwgw4FsdmFybyBGZXJuw6Fu
ZGV6IFJvamFzDQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBSYXB0
b3JMYWtlIHN1cHBvcnQgdG8gdGhlIGludGVsX2lkbGUgZHJpdmVyLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFNpbmNlIFJhcHRvckxha2UgYW5kIEFsZGVyTGFrZSBDLXN0YXRlIGFyZSBjaGFyYWN0
ZXJpc3RpY3MNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBzYW1lLA0KPiA+ID4gPiA+IHdlIHVz
ZQ0KPiA+ID4gPiA+IEFsZGVyTGFrZSBDLXN0YXRlcyB0YWJsZXMgZm9yIFJhcHRvckxha2UgYXMg
d2VsbC4NCj4gPiA+ID4gDQo+ID4gPiA+IFJQTCBhbmQgQURMIGhhdmUgc2FtZSBjc3RhdGVzIGFu
ZCB1c2UgdGhlIHNhbWUgbXdhaXQgaGludHMsIGJ1dA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gbGF0
ZW5jeSBvZiBlYWNoIGMtc3RhdGUgYXJlIHN0aWxsIGRpZmZlcmVudCBvbiBkaWZmZXJlbnQNCj4g
PiA+ID4gcGxhdGZvcm1zLg0KPiA+ID4gPiBTbyB3ZSBjYW4gbm90IGp1c3QgZHVwbGljYXRlIHRo
ZSBBREwgdGFibGUgb24gUlBMLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlcmUgaXMgYW4gZWZmb3J0
IG9uZ29pbmcgdGhhdCBtZWFzdXJlcyB0aGUgbGF0ZW5jeSBvZiBlYWNoDQo+ID4gPiA+IGNzdGF0
ZSBvbiB0aGUgUlBMIHBsYXRmb3Jtcy4gQW5kIGJhc2VkIG9uIHRoZSBtZWFzdXJlbWVudA0KPiA+
ID4gPiByZXN1bHQsDQo+ID4gPiA+IHdlDQo+ID4gPiA+IGNhbiBkZWNpZGUgaWYgYSBuZXcgY3Vz
dG9tIHRhYmxlIGlzIG5lZWRlZCBvciB3ZSBjYW4ganVzdCBjb3B5DQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBwcmV2aW91cyBwbGF0Zm9ybS4gSG9wZWZ1bGx5IHdlIHdpbGwgaGF2ZSBhIHBhdGNoIGlu
IGEgY291cGxlDQo+ID4gPiA+IG9mDQo+ID4gPiA+IHdlZWtzLg0KPiA+ID4gDQo+ID4gPiBIaSwg
SSBqdXN0IHN0dW1ibGVkIHVwb24gdGhpcyBwYXRjaCBzZXJpZXMgYXMgSSB3YXMgd29uZGVyaW5n
DQo+ID4gPiBhYm91dA0KPiA+ID4gdGhlDQo+ID4gPiBsYWNrIG9mIHN1cHBvcnQgZm9yIFJhcHRv
ciBMYWtlIGluIGludGVsX2lkbGUuDQo+ID4gDQo+ID4gaW50ZWxfaWRsZSBzdXBwb3J0IGZvciBS
YXB0b3JMYWtlLCBhbmQgYWxzbyBvdGhlciBwbGF0Zm9ybXMgdGhhdA0KPiA+IGRvbid0DQo+ID4g
aGF2ZSBhIGN1c3RvbSB0YWJsZSwgaXMgYWx3YXlzIHRoZXJlIGFzIGxvbmcgYXMgd2UgaGF2ZSBC
SU9TDQo+ID4gc3VwcG9ydC4NCj4gPiBUaGUgY3VzdG9tIHRhYmxlIGlzIGp1c3QgYW4gb3B0aW1p
emF0aW9uLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24sIEkgbWlnaHQgYmUgbWlz
aW50ZXJwcmV0aW5nIHRoZSBlZmZlY3Qgb2YNCj4gdGhpcyBwYXRjaCB0aGVuLiBJIGNhbiByZXBv
cnQgdGhhdCBvbiBhIFRoaW5rcGFkIFAxIEdlbiA2IHVzaW5nIGENCj4gc3RvY2sNCj4gNi40LjEx
IGtlcm5lbCwgdGhlIGxpc3Qgb2YgQy1zdGF0ZXMgbG9va3MgbGlrZSB0aGlzOg0KPiANCj4gJCBj
YXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVpZGxlL3N0YXRlKi9uYW1lDQo+IFBP
TEwNCj4gQzFfQUNQSQ0KPiBDMl9BQ1BJDQo+IEMzX0FDUEkNCj4gDQo+IFdoZXJlYXMgd2l0aCB0
aGlzIHBhdGNoIHRoZXkgbG9vayBsaWtlIHRoaXM6DQo+IA0KPiAkIGNhdCAvc3lzL2RldmljZXMv
c3lzdGVtL2NwdS9jcHUwL2NwdWlkbGUvc3RhdGUqL25hbWUNCj4gUE9MTA0KPiBDMUUNCj4gQzYN
Cj4gQzgNCj4gQzEwDQoNClllYWgsIGJvdGggb2YgdGhlbSBsb29rcyByZWFzb25hYmxlLg0KDQo+
IA0KPiBOZWl0aGVyIG9mIHdoaWNoIGxvb2tzIHF1aXRlIGNvbXBsZXRlDQoNClllYWgsIGNwdSBj
YW4gc3VwcG9ydCBtb3JlIGNzdGF0ZXMgYnV0DQogICBBQ1BJIGNhbiBleHBvc2UgMyBkaWZmZXJl
bnQgY3N0YXRlcyBvbmx5Lg0KICAgY3VzdG9tIHRhYmxlIGNhbiBleHBvc2UgbW9yZSwgYnV0IHRo
ZXJlIGlzIG5vIG5lZWQgdG8gZG8gc28uIFRvIGdldA0KYmV0dGVyIFBuUCwgb25seSBwYXJ0IG9m
IHRoZW0gYXJlIGFjdHVhbGx5IG5lZWRlZC4NCg0KPiAgKGFuZA0KPiAvc3lzL21vZHVsZS9pbnRl
bF9pZGxlL3BhcmFtZXRlcnMvbWF4X2NzdGF0ZSBpcyBzZXQgdG8gOSkuDQoNCglzdGF0aWMgaW50
IG1heF9jc3RhdGUgPSBDUFVJRExFX1NUQVRFX01BWCAtIDE7DQoNClNvIDkgaXMgdGhlIGRlZmF1
bHQgdmFsdWUgd2hlbiB0aGUgaW50ZWxfaWRsZS5tYXhfY3N0YXRlIHBhcmFtZXRlciBpcw0Kbm90
IHNldC4NCg0KPiAgSXMgdGhpcw0KPiBzb21ldGhpbmcgSSBzaG91bGQgb3BlbiBhIGJ1ZyByZXBv
cnQgYWJvdXQ/DQo+IA0KVEJILCBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbSBoZXJlLg0KDQp0aGFu
a3MsDQpydWkNCg==
