Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8878B0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjH1Mra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjH1MrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:47:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE95120;
        Mon, 28 Aug 2023 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693226813; x=1724762813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YZF/L1rbuZ1D6GboGpvucZTdMMe29GK+dze3rGB1eg4=;
  b=Z24REnOFIT/r8+gGItPkEFvQGJ9OuphWl6r3DaX6rMjeHCFn2jQ2OzzN
   mR7PKZMvdnREOhYSaCX/gwoIZAV8OEaJlLFI8afsjdImELLN9Zh8ZE7ot
   bIGVfCg/RfU9u/wKCY8LiW+/SeHX8dkXnFrC9PXrH6YhJiOnrPtjTJ5Dz
   PZhpJWJoIw+euftLLCW8P5zZN/tUl4wWpV5yzqIdDw7yK3HTrr1Em76lb
   Q5AxuRtYV4nG7rdHVKw9xCPgwLMQGjRS4p2VRRUE9A3SPph+XLBjU1Al8
   dbpyKGBsQSbKejUOaXpo9vO2XF9RL6ajqD7fUpRgCNqAwa1TamaKAeZ4d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441437716"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="441437716"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="767665381"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="767665381"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 05:46:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:46:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:46:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 05:46:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 05:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly1VOq6E7IED3LbSyX7b4hjF6/QhL3rhvl6O5XkG83R5cAomJH3sdxXJyC5RFcBU3ND0XPEm7yNWxGhLA0H+LNwXwVipoA7YnqaHIN6iqsPDCy47xIefVeWmcIBcrMWVk2rtPuPj7vRyRofufXF/CabCRQHDpEpo1Eyi9agtNLNl/fyZAPf4eZZCseonhvlK7x0irW/mK0lirrQhI+JumvUWPJjSOgGqp1st5stpoBC4ODXbVJ365m5rFMwOikiLrsDxWk7nfB5bduWoziR5sVCqqVrU/r/AY3zLcPiX6AiJbgMSrrOF3hnwUQ4B68WT7L3rPhv1f21u/cv8n5i8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZF/L1rbuZ1D6GboGpvucZTdMMe29GK+dze3rGB1eg4=;
 b=b6asgn2xp5Rw+Kq63QjapB8opCQF0390pUyrhEoGAQ3bN+CEo9bVykHOFaajxTGrL/nrhtuAJEorEhvf0vlVYbwWs1oP70SOLgNmyJU/Kmrsiajrpz7JN2WbkZ1M8mG1qVHTxQ4fbpjZQzx1L6Nmhb8OdBKjsaBpo7pV9CEg9oQIbO3rNhvaM5ErZfsQisFhrSUeZbHd4miTEIm7e4CwY/eb3kfSo/HnuliuAwWTMTU3ETKmJUSvUNC/Gj4zVYA92Opa60WpZjIHIMjrswq8Ps6cVYW0I08e+ODrIx51JBJrTlYhIP/s+XoRBdAP/EilGs3/cDIkv5qBPYvMbEdeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:46:32 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:46:32 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "arnd@kernel.org" <arnd@kernel.org>,
        "shahar.s.matityahu@intel.com" <shahar.s.matityahu@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>
Subject: Re: [PATCH] iwlwifi: dbg_ini: fix structure packing
Thread-Topic: [PATCH] iwlwifi: dbg_ini: fix structure packing
Thread-Index: AQHZoDGDEMNCBenVxkGs8KxHo49PwLAAGvIA
Date:   Mon, 28 Aug 2023 12:46:31 +0000
Message-ID: <96166c759e97d23014c0d0bf86299eb132633493.camel@intel.com>
References: <20230616090343.2454061-1-arnd@kernel.org>
In-Reply-To: <20230616090343.2454061-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SN7PR11MB6728:EE_
x-ms-office365-filtering-correlation-id: c94fedec-8dab-470b-a06e-08dba7c4ce55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6AbMqyYx7VKeUhJI7nYNQd4SPY7LjnrMQc6qoqT7xCRCBccEClQjVaMdDvc1Ilw7JSEMoITGSJw3SRxlLfzxnz+CwNeZRp0VUYoCx7vk76h0vf/J8EntTxCfpmw62HndZpZsJM4rNBzOX4ofzfcA7Q0FDWFtfBjnHEKjrOEKqgYiInlkoFcqUUksMvfY3TQoZw8obUecKMUuUMhX4FykMsb7zhq6faXBFLWjUxWfAbZkHzntx2ElLccXs1jxFnqhfcZtJ+wm23SO6qpHbwFSW2eOeYcwtIINiAv2YhSWgU7cmt+3MEAoo6By02zEhzaBuYcU2QAxXwucDSUZIeJrAAwXVFzD6SWRxcbJ53jPhCzu3EQbKES9LW9Kxq3ZSSjtKXnqvpiaHIPNKQ0s6myx86J51Xzm7meZTRqv1gWfiIgXIlNhc6GpcDgKjedhmzzS1lLe0Ba1XxeFKVw/yHEopMCdgJ9e2esmMcTVp7r2r6qaS5R5tGwzLInBa4ZQvlSKUGDVOCnlxJrmEu+lSW70ha+EdS2xf1DKCwndiWGmihU5vRo3aZWL5+yQY1mEMCyTf0mTxQU1Y7Y8LZPBrhoRKSWG0Qz/t+wWMQVyePilsIUxr7FHBbH5msuy6ufDn23
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(186009)(1800799009)(451199024)(71200400001)(6486002)(6512007)(6506007)(36756003)(86362001)(82960400001)(38100700002)(38070700005)(122000001)(107886003)(2616005)(83380400001)(2906002)(26005)(478600001)(91956017)(110136005)(76116006)(66556008)(41300700001)(66476007)(66946007)(8676002)(8936002)(5660300002)(316002)(54906003)(6636002)(66446008)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFBdXVYQUthQnVHTGRueC9aczl5SlZSV1E2NXJkYVFsdytLR255VUxiNk9q?=
 =?utf-8?B?U0kyQ3Q0eHRHZ2JXYTMwZzdjMzlkUFNGbHVDQVNEcjRhbzlqVlNuNXozREtH?=
 =?utf-8?B?MGUrNkVWQnY3WnZXU1pmd1N3VmVoMUxkcERQNGNsUnRMK3B4ekZ6dnU0bTZH?=
 =?utf-8?B?bUoxNFFFUTg2SlpoV1d6c01zZjlvdEV4cXloL1U0cFFlVC9tZTFRTk45Mk5z?=
 =?utf-8?B?SGoyY1JCSHd2RCs4akw1V1E5THh3VFlUZ29mVWd5Q0o1MjBXZnBSWHZVUjUz?=
 =?utf-8?B?MGNUWHlpeTltQmFvYi9hWGdhMnV6M2hlc01DU2RWMXErOFdmMG1ZeTMyWjZ1?=
 =?utf-8?B?ZHM3NUEyTFp6UllBdDVOeEtEeUVpU1EwaFJwTThSc2hhTjhxREx2VGFIRzQz?=
 =?utf-8?B?c2h5OGc3Zyt1YitIVy9IQVZ1T20wZERvS3haRnFhTExpaUlabHI3VUdLVDZp?=
 =?utf-8?B?eWVaZnc5eWhZbXhIbHZhaHhJWXdIQ1V6cEpiajF2K0N4cUlXS25VeGs3d0dX?=
 =?utf-8?B?bmtUYktoNFVLaVRTYU5HdjhlSG0rSU5tdTlaWVVXeko5UUdjNHVGZXAvSmFz?=
 =?utf-8?B?cnZEWDNnSlNEU2N5b0xObnYvZnlkbE0wbWlDMDkyMGxWTjJMN0lkMEdKTXdH?=
 =?utf-8?B?Mk03WVg3ZXFnUERKbVlscDVEQWMrSHV0TlJveDE0VllnYnJIRlVjTEdBV0Y4?=
 =?utf-8?B?T21MK2szN09JWUpSZ0tYUk41amtGSkJRdkdPTlpud0NQdW1EQ3JCOTJzZzNp?=
 =?utf-8?B?dmhraTJXWlY0bW1WZHF4YnVLdGViWW5jQWhnZG1uVEhpRjF1UndJSEtVeXRH?=
 =?utf-8?B?S0VhVFM4ak1aVTZnTHVxQlF3YkFtNVg5M29FeEdxUGNtY3dPYzFkbmFtTkpO?=
 =?utf-8?B?VkRyQlUzeGF0U09JRWUxckdCMXZ0KzloODRFL0VuODV5RVg3R1lEMy9UWEZE?=
 =?utf-8?B?STArdzVzQ0Z1L0dnWHJ0V0xNQUxxMC9oREZvQUV5MlVWUmdaQUxmTVIvRWZR?=
 =?utf-8?B?QWZ4UFg0RXV5ZmFXb2c5SGJzSjNEazl6VGlnR0U4b2FRS1d5SU5FTFRYK2Fx?=
 =?utf-8?B?TVBjbVFnN0JpVURhVXY4VitTN3lpUHBSeXhiN1ZjR2tHWkp4WGkxMTZTZkpF?=
 =?utf-8?B?aDMxNVdwQWFHL1ZYMFUvbFU4NXFmRHpxeDlJZ1ZKU1dFUi9HaDl3djVyTHp2?=
 =?utf-8?B?TTZITnBnNndyOXByOGhIekRsM1JlaTJjQ3A2ODJ5SDExSWJDNHZpRXM2djVm?=
 =?utf-8?B?UlFaZmxUNUljZy9FVmxxeDYrZ013Szh6TDF0YVdkRzhWQW5XTmZFZ1pXSFhn?=
 =?utf-8?B?WTRHQjRFNFI5RE5KQUNQMzlqV1RkUzkzM21KbDNKdHphZXhoc1hVT3A4M3pa?=
 =?utf-8?B?VXE2NlVmZE9QVFVSU1FXcmNiaXJYRnNFYnAzSFkvVlBRZTdzaVpxajRBbGJk?=
 =?utf-8?B?SkYySWo5d1B1Mk1VdXM4YXl6L1NnN1hTN0d0NlZEU2lxR2JONDZtckVTeXBn?=
 =?utf-8?B?K0ZzU0FGVzVvdzBXVFE5TGUwRzdOcGM3U2lkVjNjWlpNTytjUis1RnJIRExZ?=
 =?utf-8?B?ZmxPUjAwemZyS2xmM2tVb2hkL3QybkdsY2xaTnVVZkZXaGJUZ3gvaTdqTUR5?=
 =?utf-8?B?MjNWRFFuRG5HY0JXYklMWlN1UzJvc25BN1VKSUhtRU5KSVhxQWJRU0lFOTVr?=
 =?utf-8?B?Q2RvQ1JGeTFGdXlHbk4yV3dDNVRMZTdDS1FJUk9NWm9ibFZ3cDdMbGk1VU1n?=
 =?utf-8?B?ekV6VEN1azU4MGoxM1M3SVdEUEFxVVN3ak9yQ2t2a0ZXaXBCVW1QUzAzRW1y?=
 =?utf-8?B?bWYxS3hNUUhSSmwzZnFONGwyUDFpM0xRRVBBQmZFQU5kYTQvL05ML3Y1WUo2?=
 =?utf-8?B?ZEIyVlJnYzkwZXVvRCtmK1pLbGtlcHFiM0xjUzRZUDl0VUFQSldxbGpwclJ3?=
 =?utf-8?B?aEZzdDBmRWdHQlpkT3lyMlR4ZUx5QWw1TUNkNE9xaVdzbnNqdlk4YThBWGZB?=
 =?utf-8?B?SE0rS0IwekhuWG1BZjdXZzkyeGE2MTFmSHBjblRwbVUzOEQySzM0Snc4bmZZ?=
 =?utf-8?B?VEVhaEYvWlNnQWJ4VVdaZmM3UzVsbS93VGF0OXVXQ1V3QWlESUsyNFkzQUVC?=
 =?utf-8?B?Y29MYWkxWmVJbWtOaVdScGtOSFU1d2xJVkpNc0JtMkVEUkg1bk4vZnBJa005?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C58DA4DD079FA4CB261FE40FE775606@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94fedec-8dab-470b-a06e-08dba7c4ce55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:46:31.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ky07+fNJB/KcGR4GXxcVBLKS/++ee0PagFVoQqxKbMhZjXGtifCuxa+RSH4TSTHlHom+pfqDk3rCfMDhSslUMk5lZoc0fo5MWwEvQFo6y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDExOjAzICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiANCj4gVGhlIGl3bF9md19p
bmlfZXJyb3JfZHVtcF9yYW5nZSBzdHJ1Y3R1cmUgaGFzIGNvbmZsaWN0aW5nIGFsaWdubWVudA0K
PiByZXF1aXJlbWVudHMgZm9yIHRoZSBpbm5lciB1bmlvbiBhbmQgdGhlIG91dGVyIHN0cnVjdDoN
Cj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL2Z3L2RiZy5jOjk6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZncvZXJyb3ItZHVtcC5oOjMxMjoyOiBlcnJvcjogZmllbGTCoCB3aXRoaW4gJ3N0cnVjdCBpd2xf
ZndfaW5pX2Vycm9yX2R1bXBfcmFuZ2UnIGlzIGxlc3MgYWxpZ25lZCB0aGFuICd1bmlvbiBpd2xf
ZndfaW5pX2Vycm9yX2R1bXBfcmFuZ2U6Oihhbm9ueW1vdXMgYXQNCj4gZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9lcnJvci1kdW1wLmg6MzEyOjIpJyBhbmQgaXMgdXN1YWxs
eSBkdWUgdG8gJ3N0cnVjdCBpd2xfZndfaW5pX2Vycm9yX2R1bXBfcmFuZ2UnIGJlaW5nIHBhY2tl
ZCwgd2hpY2ggY2FuIGxlYWQgdG8gdW5hbGlnbmVkIGFjY2Vzc2VzIFstV2Vycm9yLC1XdW5hbGln
bmVkLWFjY2Vzc10NCj4gwqDCoMKgwqDCoMKgwqAgdW5pb24gew0KPiANCj4gQXMgdGhlIG9yaWdp
bmFsIGludGVudGlvbiB3YXMgYXBwYXJlbnRseSB0byBtYWtlIHRoZSBlbnRpcmUgc3RydWN0dXJl
DQo+IHVuYWxpZ25lZCwgbWFyayB0aGUgaW5uZXJtb3N0IG1lbWJlcnMgdGhlIHNhbWUgd2F5IHNv
IHRoZSB1bmlvbg0KPiBiZWNvbWVzIHBhY2tlZCBhcyB3ZWxsLg0KPiANCj4gRml4ZXM6IDk3MzE5
MzU1NGNhZTYgKCJpd2x3aWZpOiBkYmdfaW5pOiBkdW1wIGhlYWRlcnMgY2xlYW51cCIpDQo+IFNp
Z25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvZXJyb3ItZHVtcC5oIHwgNiArKyst
LS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
ZXJyb3ItZHVtcC5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9lcnJv
ci1kdW1wLmgNCj4gaW5kZXggZjVlMDg5ODhkYzdiZi4uMDZkNmY3ZjY2NDMwOCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9lcnJvci1kdW1wLmgN
Cj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9lcnJvci1kdW1w
LmgNCj4gQEAgLTMxMCw5ICszMTAsOSBAQCBzdHJ1Y3QgaXdsX2Z3X2luaV9maWZvX2hkciB7DQo+
IMKgc3RydWN0IGl3bF9md19pbmlfZXJyb3JfZHVtcF9yYW5nZSB7DQo+IMKgwqDCoMKgwqDCoMKg
wqBfX2xlMzIgcmFuZ2VfZGF0YV9zaXplOw0KPiDCoMKgwqDCoMKgwqDCoMKgdW5pb24gew0KPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19sZTMyIGludGVybmFsX2Jhc2VfYWRkcjsN
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fbGU2NCBkcmFtX2Jhc2VfYWRkcjsN
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fbGUzMiBwYWdlX251bTsNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fbGUzMiBpbnRlcm5hbF9iYXNlX2FkZHIgX19w
YWNrZWQ7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2xlNjQgZHJhbV9iYXNl
X2FkZHIgX19wYWNrZWQ7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2xlMzIg
cGFnZV9udW0gX19wYWNrZWQ7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IGl3bF9md19pbmlfZmlmb19oZHIgZmlmb19oZHI7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGl3bF9jbWRfaGVhZGVyIGZ3X3BrdF9oZHI7DQo+IMKgwqDCoMKg
wqDCoMKgwqB9Ow0KDQpBY2tlZC1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1h
bkBpbnRlbC5jb20+DQoNCg0K
