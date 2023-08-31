Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1185E78F18A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbjHaQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbjHaQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:56:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4ACFF;
        Thu, 31 Aug 2023 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693500989; x=1725036989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=drcxr5wsk67vkQwLsFyB0a5czcr51joFeNFCClvaK3g=;
  b=bUeEtak7ph6vBbxCz4x1SUCLNw1RfFc+QoVyvCz+iQbdXVjLmGz4fpV6
   Kzb3W46MEMhzl9yKFYw8VKmRWqO9G4JXrHEYoKPmLd16gEQLm6dESFXzs
   FSfNXWrw9ZngjHbsgbE9fpGxLpqAP++FOx6lcTyYPu/hZC0rLXzStdaD8
   3Qngpaj5gJlgmIvHlSN9y4nLIYjf7C/fWtzCM6r6kjzIjIT87QgqygOea
   ypizBbnstc32LIXURtNp94DBne9raNTyG5g/d+wl86X/jomVGJI/lTHAl
   8T6vEq6/h5Gj54bU4BDkZ+bGd/l+JmCQt2LWmp7RnjBHuwHm+AiLBaOei
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442396558"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442396558"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829774961"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="829774961"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 09:56:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 09:56:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 09:56:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 09:56:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 09:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+PeMhhuUwQ7Z2TLqzWt1s/6k0JgCLIoJb7+zk3Oo0Ah5hP2Or3HSziC0QU0UDLJZLOQFpogNQsXD7allbCMHIT9d1dca9573+ppt6JjiWGE4nzsabKZkEGBDXWrK7oidarqYFsLTrKix1bbENYH05clUH5P9xt45acaemYqL60fUVo6GbMborRSkw65U0sJzFx63awdvGm/tJtlZQoDp2zb+DsrKLX3Smw9lguNYYUUShsOZYrcXmtmNLdT+TFF04Ug1NoE/I9yzQUMLOHivrrAIs4w5oTMOF0ZgIC7dEmL0XUDhJkCHEr478Zjcuq90pnVBpy2+MnFml7q2Wukfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drcxr5wsk67vkQwLsFyB0a5czcr51joFeNFCClvaK3g=;
 b=Ej5EmIs/v1xka+xIrgkf4w1uWxB5oQr3Qkavp+oEJ/g/8WWMBOMv0maUYaGcoTupFrO6OwaceB02a4NsO6sL3bE4lZPtJJYF3i+WZQ59IvPljbT7a8/yLef1LG/6mKek6IwddhXJT3CaYjXbnIgpHV4gfbs+mqVP9zrj1o4sTSCUBbu+vZmRqjbYYW2NKeQo/wuWJL3dBS1Z8wUJzqV9uqY0x7anlWrNx5JFw/dSYNuhYLa3zjhmp4DeStoDtlAJK1dC+rSThTXJt6Se3mTFezmXDwHHxVvHvM7R7jdvv/txUwefhuGxeiIyU/tXVmwjQsqZVy/Nyp4U8KvYoxprLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.37; Thu, 31 Aug
 2023 16:56:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6534:8c04:b4c8:33d4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6534:8c04:b4c8:33d4%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 16:56:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Will Deacon <will@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: RE: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Thread-Topic: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Thread-Index: AQHZ27tynYIMz8EETkKRL7NcVJj6jrAEoDcg
Date:   Thu, 31 Aug 2023 16:56:25 +0000
Message-ID: <SJ1PR11MB6083A4F9312C34F69DBA8EEDFCE5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
 <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
 <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
 <20230830221814.GB30121@willie-the-truck>
 <d1c8c0fa-815f-6804-e4e5-89a5259e4bb1@linux.alibaba.com>
In-Reply-To: <d1c8c0fa-815f-6804-e4e5-89a5259e4bb1@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: c25d309f-3f42-4de9-a377-08dbaa43362f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gw5a0Fm7Rzl5B1cXfc4EHRp+MNEr0iicQgm+Hd9hxEvCE3iMXJGKFB+Ao4OXU1uVpnn8QZjTYrp5ySa8hFJndgyMU8eSXCpd98M2F/NzsFXjWSDfn16uWnvftyVARyY4tbY3WdSJSA5oCt28cXdsYjepFp93EKHO2xD2Yy9mHuOcTuCX8TR057OhYvNxNhYWzrCaNWmGeERoROgi+VP36SZyhpIEXOWycsxNhbwJFrmMAsoxMWicV8QER8FdMIANEBBLsCcXe2tBH2ZQEz15s1kBJ/H0yR0cS2BHc6rz6IHFmfPCXDk7AASTghSLnuI6zkVT8lw1wZygE3YzQdILYruZvo4Bv6eyLTM94KIjkmPJnxPEwTuzuFAaDS3aVGdB9Ld4FWs3IX6/NfVJ3JPObd5wFUCQXh/cJnP/JD8lBFSnB+eT+uGAMrWkkl0uMgCRt6JI1S/1GqptlC1p6Us1N5tIHFTsJl0t7vGtD3uX09UV4CXY1S/pQX0SAAyUHUhypsSn/n2kEaOQ14zoDiDU3z4Wr/LYKCUuKF0t6vLiXtel7hmvQC4VQx6vucBZlnUiCkKYzVTuyZkd01pr3eP65g39GB5odxrusgxJQ9Z+4+LMveOYw6xddJ/i3pjWo27u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(186009)(1800799009)(451199024)(71200400001)(26005)(55016003)(5660300002)(52536014)(7416002)(82960400001)(316002)(86362001)(83380400001)(122000001)(66946007)(76116006)(38070700005)(38100700002)(64756008)(66556008)(66476007)(54906003)(66446008)(110136005)(4744005)(9686003)(478600001)(41300700001)(8936002)(8676002)(4326008)(6506007)(7696005)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3UzZjFMelNkTGlqTjl0K3VhTWdadE90TmF3L1gwaVhHc0FYcm5aZTUwTGNP?=
 =?utf-8?B?Tm96MlVDWUc3NEtTUjFsMFdROVFISjBTaWdiMmxtUUJJWk5OUHJWRGdyc1Yr?=
 =?utf-8?B?UkF5M1NVMW11NkU4MXlUaHdBeGErU0NmUWFLTkFBelhKbjN6bVRWUGY0U2VU?=
 =?utf-8?B?bER4MEtJa0d6KzN3YWUzK0JkSlMySFBVMElYNVdHVmpvMzU0Nlo2aHJKckVD?=
 =?utf-8?B?WVFFRkNPdFk4MHhDU29uZjRlUkllajRTOUVkbnVKRldtQXVLM3Bzb1ZkOWVZ?=
 =?utf-8?B?c2JieDMrVnByWEFpdTFYNGRUb0VHVzAyUWRsWGVnc3QzNTd3SlZLSTFpTzhT?=
 =?utf-8?B?MWNyREZpZitKZ1lORS9QY3h3L1h2MitoWDZsQ202bGpxQVNwTSt4bGs0bVdo?=
 =?utf-8?B?SW9ZbVcwMC9VQmt4dUw4TCtvREllWWpURllOU05nR1N0d29SbS9QN3ZrSkNu?=
 =?utf-8?B?czFoUU83dktIY2J0cDlFakY3VWZiTlNldnNJTHdCWHp4YmVnMmtFUHVQS0dC?=
 =?utf-8?B?RE9vb1F5SUV0ZmhyZWxxSVQ3NHA1YkI1ZmxUMkJyckNUMUxsWVZpem5vSGNV?=
 =?utf-8?B?REdEWFA5c3NOa1NENmxBM3VXVkZHQ29odS9sNVUvb1Z5Qm9FbDRnV1ppdHdD?=
 =?utf-8?B?NGxEQzFSckFNb0RzWkxGYk9DbXIvNEhZYVhMTno3TGhyVVVEazg3NGt4cHh6?=
 =?utf-8?B?eXNERmhYdWpGYUkxQXVncWFkNWdNamRlOTJKcC80WkJjY2tyVlJsbDZXT2lk?=
 =?utf-8?B?VEJkQ2o2RTRpdWJ1R0pwRHhmbUZQejB4NnlFU0FxUVU4SThnYUZzdDFIWFEy?=
 =?utf-8?B?MTEzcy9ZR2prRUdLYkY5ejBYVURiQWNDQkhBMG01WDdEQnBhV3VtUno2VTVn?=
 =?utf-8?B?aXRaQndEdjkyZC9Kd1lUYk04R2R4R0dFVnhqUnNqR2RSTlBTZmUzbDY3ejRu?=
 =?utf-8?B?U0xESXg0YUlaOGU4TCtRNGwrRkRXTjBnTkpwTXZmZndtTkZscTNqa0JOdWRY?=
 =?utf-8?B?d09SZVdzbjFhQk01Y1dKYUl1VkN3SUJPMDBhcmg5TGRJdlRMdytHc0dpemQ1?=
 =?utf-8?B?bnE4bXE0Y0xtV3o5dkh4U0s1eDdsaXlaNGVVT2Y4YVBwSGhkekZjNk1qanhx?=
 =?utf-8?B?UWtSR1R3bkhJc3k5NktTNXFFTEVwdnp0U0pDU0VsU3RMK25JTFk3Q0lKek1k?=
 =?utf-8?B?bEIxLzVQSWRKTHM2d2REN1o5OVRKVnN5Ty9zOE5iSnNMS3ZYbnJxa1Q3SzRE?=
 =?utf-8?B?elhUTHJyR2MvTElVblVWZ0h4V0dGTDNwWkplU0RaK1pReEVaSkZyYTZicUdZ?=
 =?utf-8?B?S1V5WUxVbjFSajVFZ0tJaUJCSGd3TUVCRHpCMDFiVi9XSksvT25ldC8vTEZs?=
 =?utf-8?B?SWlXa09KV0RhQ0QzSlF1dUZKZXJlR3lVdUcvUVUrU2FWeDZRRHFlTXV1dnow?=
 =?utf-8?B?TU5CSUVVWmhIQ2s3eStpSjFjZ2ZmUjZwdGRjMmY2QTUvYTlXNzdxKzhRemtF?=
 =?utf-8?B?eXlhZStGVXZIWTBqWHN4ajBRMFJqcFlldTBLVGgyaHVEbFJFTmdkckVmQ01w?=
 =?utf-8?B?dVVGQUU1OG1yZGU2UXhFbGd2THRVSVBBL0tTNEJyWnV5UjdJV3B0N2t1Z1NR?=
 =?utf-8?B?aVBsQTdJYUdseUtRRHMzY3ExbnhkRVk4dWVNRnRuNU1GcU00N2NOY2xnb3J6?=
 =?utf-8?B?SnFqRzRGenM3TXp4bTlQN25mRnA1QkdpbERVVWJ4ZFNxRTVVZ05WMG5wRi93?=
 =?utf-8?B?amhZdXNNQitqc0NiQ09Ta2E1VExOSUNiclVEVWVPWXZON0ttVkIrWWxwRzNL?=
 =?utf-8?B?OVNtTGs4R2czR3dMZzR3SEJHWGY4alBtR000MlhscXBndlFLdG5LRGtsbUJJ?=
 =?utf-8?B?TFNxT0JxMWs2RXIvbk8xa2I0NU5vcVhJZkdVUy9DUmRNbkJKdk5HTVpCZTZD?=
 =?utf-8?B?OU9yamlWdllkWk1ZTmtkWE9XY1FtN3hpVUFNR09kWDZGbjZuNWl1UGRMV0wz?=
 =?utf-8?B?ZGRDSTA1ZjVrYW5ZRWdobVpFbTBaejZteDAwa0d0SzFXeTlyMzBOV0FUZ0Jm?=
 =?utf-8?B?VEN3c2ZLRHJaOXBXUGdMZ2s4Q1NML0l0REdxNlhOWnBsdjRDOG95RkF5emVv?=
 =?utf-8?Q?OJ64=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25d309f-3f42-4de9-a377-08dbaa43362f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 16:56:25.1470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jruK2ZkIB4SM6qGsuThYB7wn6yvK9vXYDlQFJk7QflU5AueN1Q/CzdILhoS0q+ylxOcZvebn4JOogW3c2S6H4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiArIEBUb255IGZvciBFUlNUDQo+IEkgZm91bmQgdGhhdCBhZnRlciAvZGV2L21jZWxvZyBkcml2
ZXIgZGVwcmVjYXRlZCwgYm90aCB4ODYgYW5kIEFSTTY0IHBsYXRmb3JtIGRvZXMgbm90DQo+IHN1
cHBvcnQgdG8gY29sbGVjdCBNQ0UgcmVjb3JkIG9mIHByZXZpb3VzIGJvb3QgaW4gcGVyc2lzdGVu
dCBzdG9yYWdlIHZpYSBBUEVJIEVSU1QuDQo+IEkgcHJvcG9zZSB0byBhZGQgYSBtZWNoYW5pc20g
dG8gZG8gaXQgZm9yIHJhc2RhZW1vbi4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24/DQoNCkFQ
RUkgRVJTVCBzdG9yZWQgcmVjb3JkcyBzaG91bGQgYmUgYXZhaWxhYmxlIGluIC9zeXMvZnMvcHN0
b3JlIGFmdGVyIHRoZSBzeXN0ZW0gcmVib290cy4NCg0KQ2FuIHJhc2RhZW1vbiBjb2xsZWN0IHRo
ZW0gZnJvbSB0aGVyZT8NCg0KLVRvbnkNCg==
