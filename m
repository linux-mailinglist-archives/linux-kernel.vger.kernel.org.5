Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8907D5EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjJXXnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344668AbjJXXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:43:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405510CF;
        Tue, 24 Oct 2023 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698191009; x=1729727009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RI+7AKQVSShu9vDU6up4rkxEK6yCHVPdqWLUtbszfAI=;
  b=MltJx7jTRXrJQoUdOBXDiM9m8pHyJ+VuY1wOXcjwdIZojbtzp+jZsfhx
   Vo6RJ+SR4Oi5axwv3nk4p6Iy9MGM6OZd8DIKvug5t0zN9GXMo5PULkR+n
   937tw+Xv28VVLA89408XP7UKR3iq3bFHj0t0tMvYLd7/XVeqq/NM99suD
   rbq7k3eKDBwIvnIrQXvK0Etmqyg0dlu+eU26S0kLeY1HKMyceiR3E0Hjp
   qEHMW9veDic4DtWpYxE2FY5cGAMoEnzGAAAnz8NpLdKVLBSvXns9CnaFO
   X/zV3JkOhb3ihWdziUuiwyhlVu0LCDhQYHgsej6Q1MTebdYV22P7DAgRD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453670027"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="453670027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 16:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="787948741"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="787948741"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 16:43:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 16:43:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 16:43:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 16:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9+pfuW1B/BXQbVSWJqyt8Dhff/u9ecvXZSdseWODzE4dsB4ORFOjmKlaADCenp9NqTcmPiI1lOgiLNut8UAbYHmueYAsurZeozbKl+dOaZezv2znswiWO//HB/yOEw81+53S78C6ZFlah6qcL/ALzBWrb1ItWCoPjF0MOPaJNF4Ahq2ImueiL5NVA41XkVC++HlqNpfOs9BGIo2VJ/05C+n0imrJIcGaVxYQ7uwnA7PCtXETi3SaMBX2dqV7V8ZImXTPfuAvnE+KShqLMOxVURAW0b1GzeoBup2V/P5j0gSGLEg+UTqcCVc//ukHmKJNfPEjTwBDQ6FPcr371aihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI+7AKQVSShu9vDU6up4rkxEK6yCHVPdqWLUtbszfAI=;
 b=N9H23C7Tm7HQJoyKTz+fAk0q5t1kQhvw5KyqW9XIlY+egRNdnVeAygyr0E0RimEX70WkghMnloCrLDsiqzM+UnLIaNCdJ7GjcmdGhONWtBqhuroduMFYLxoNG5spUtDYhw7E/m0y/QO0aOKPZg/AhUlme4q8oSBfG1w9+8mtRCy6Hl1TRKVwGahrCP2xcTiiKkbAXqAgVMWFGPJ6VNIwXVU+OTG2S9nk2jGCMwurLEB3abvlCLsUq9s7GBZOBbPiNxLrstoVOaP0MQTBm/j1F0MltpC1iXTQPzc673tc+nqQldW5l7U9ZQSOIXtJvmazOOFmM13jhmv5t2pBVWyHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 23:43:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 23:43:24 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Moger, Babu" <bmoger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Topic: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Index: AQHaBqYtRjw2ybQBRkugDlcC/RU7LLBZk/+AgAAA4eA=
Date:   Tue, 24 Oct 2023 23:43:23 +0000
Message-ID: <SJ1PR11MB60838985036B7A3F2296448FFCDFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231024181600.8270-1-tony.luck@intel.com>
 <2504daf3-16fa-9474-e9c5-cd6aa99d4776@amd.com>
In-Reply-To: <2504daf3-16fa-9474-e9c5-cd6aa99d4776@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5181:EE_
x-ms-office365-filtering-correlation-id: f5a424c3-4ea7-40d5-a8ca-08dbd4eb0340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LntJ4I1tURZOBWo6KCSet0UaTK2iy84YU3Ay39HkXPIQvhkXOoED2mH1ItnfgsTpdfg2poilaS++fn2U8B9In0RZU2R2lN9dGfm97qSveEW/HxLV5nKc/LDAF8H1ceQsRMAfmRDklrn7mVP7Fq/aDfD+ROw/Qfr1aKeHAGONnhI6N0TnD7tldRM24C0q27JryzP0+T3KydCblLTBMeLlSqAnBcKHG14L+AyfxbZKqX9TPvfULBU77n3K84XXibC9td/QL8n9tXe6NgjOomPBLYQKXuFFB75dH9zUEBbDMay4OxqXunJEiiKsp0uVZX9Nz/RidfBN0NwB3guNuUE1WJ3kO0rH4A9v4zYqhpGIfLo0C9Zfz438mIcutNkRpWo5a7Mt4hIbLtR22sA0dyJcl4CvvqxKCjO8tqCp1hXkhI73z6zgwjo3cDqlDgOiXgcIk9tn+KOqRQbiyiD5/fLF2hKlcpZRXTTFRd3rquzGbrUvUnhCii3YF/OeZbxDI0oBB+1K8LKDOiArTzJYPJw/8YEqy4jM2V8GWrV89gFhdpVwkgl6vAVR9xRk73cmelBmFlG5olPn1tNPRM0clRmo8TGq6QwIdtvMaX4dDiSDC0LiWnQi6Xw0t14sUFaqHFmnqfXYOHRL2Pys5HpadWtyag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(921008)(38070700009)(2906002)(55016003)(52536014)(41300700001)(38100700002)(5660300002)(4326008)(8676002)(8936002)(64756008)(7416002)(316002)(66446008)(110136005)(86362001)(54906003)(478600001)(7696005)(33656002)(71200400001)(9686003)(26005)(82960400001)(66476007)(76116006)(6506007)(66946007)(122000001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm5tK1dRWUZhckJ5dkgwY0s3THBvbm0xcTA3cmJ1RTVuR0sweEEvd005aUJa?=
 =?utf-8?B?SG5NQzhxSnlNemUwL3Y4UHVaQ2JsZHh0ZWJYZ2VFVURZSTNIYzZQZ1lPamc2?=
 =?utf-8?B?ckNEZHhyaVpOVm5iUmFLTDcreUVabFhKTWZqTER5eldRUkRESG9wT0VETnB0?=
 =?utf-8?B?VFQ2UlF2d2pMcjZUM29GM2U5cFIwZzhJOWFZYVZLNHNhc3pQbkJkNllpaXI1?=
 =?utf-8?B?MkdTMTVzNkYvY0dVL1Q3dWVhTDVJMUtyakpZOWZMcWFac00yVzY0eGFpRmxM?=
 =?utf-8?B?ZFgzbk9sVGRTUStlbVZlaFo1Y0swQ2M2Q1lhdEY4UkxMRDcwOTBxMUtkanpX?=
 =?utf-8?B?S3J1aWZhYTZqT3ZkU2h1RURQUDljeHFpcURyemdlaU1qOEc2bUxiOExHOXhl?=
 =?utf-8?B?S0kxWWR1VEpKWC9LeWFZS3JraUJnaGVrbFI5bElPcCtVOUhRSmdCckVjOHIw?=
 =?utf-8?B?OHRFeXo3L1ZScDE4K3VnbnJIdEZnVVE5OGdDSE5rWThLSnhZVWcwdHJURUo5?=
 =?utf-8?B?dGdUb0hGQVNDUmJKQ2pZS21Hbk9QRWVLMjV2RStucGFHM3JYZHN4ci85Z1Nh?=
 =?utf-8?B?b0lwbmVVZDlsTFArcFdhOUk3KzlFdm5BUVp3cFNVT0ZFSjZFeVpiTk8wSXk4?=
 =?utf-8?B?RE1heXZSQ0FET1JqVjBreXpFcDdxSnNsd0xIWXBmNEN0aVloU2paWStMSHJl?=
 =?utf-8?B?bkI3RnFoeUVBR3J4RmNRUjJrN2NELzhyN0tMRTI3alRPQ2lJdjJWOGx4MzFi?=
 =?utf-8?B?UzFtZzdRT1pBN1lYYjduamhidUgxR010NGt6bHk1dVhNUk9oa1U2MHpiblBj?=
 =?utf-8?B?KzBhUFlpcEgweFJORVoweFFtQ1hIL2dFMmR5dS9reStkeEFzTkk2b2I3VHls?=
 =?utf-8?B?dDU0RWRuL1Y5UDFCLzhsVFJIQzgyMnpIR3hBMDI0MkozY0lqUXhUYlFWKzZn?=
 =?utf-8?B?U0tlYnVlSTV2ZTRMS2hPRnhSUjhlS1pJaFhGSC90WkNjakQ4dVgxM0NuUDkr?=
 =?utf-8?B?RVRESUdYN0d0U3lNNVl6Y0lPNlRMTG1tMCt3WmhtVnl1RitOWVdISnp4L3g4?=
 =?utf-8?B?TVJlM2l3d2duMGExUXJuVEcrNUZwUWFsaDhtMFJqZ1QxRThFY2RSdnl3Unk0?=
 =?utf-8?B?d1ZzY1VPak5HRVJuUFZPZ2pTQ0ljcFVPWnlSQkh6VFU0WlM5UHR0bzFHM1RG?=
 =?utf-8?B?RzFSZ2MydVN6SWVuZWRidmoyZ2VqYkhrUENuZ3hTV1BGbmtoY1NqWTRDNERm?=
 =?utf-8?B?dzQ2b0N4RkVWMGdQSmRZZm54U0ZOK1Q0OVFvTTNMUVUwb1d2WmFvY3BkYVln?=
 =?utf-8?B?VmZLVHlBd3plVlVXKzBqTWN3TlhNOGUyVHFHMTBhTENpSXZ6bVZmOFh4bDNL?=
 =?utf-8?B?UG5sTmxHMDdYNTlkQTk1Q25pUjJndXE4OFBzVFZUYXRMNnd0eVhHZTJvVUVQ?=
 =?utf-8?B?QTA5dHhHZ3o4a3ZjV29KaHFCazM2M2ZRckVZTXJDSzlHSjBkYVkwSm1vWnR0?=
 =?utf-8?B?bGlPbnRmVjVEZS94Z1lZSTFTbHNCN21UbTU3OTUvT0NRckRHdWRQek5OMk1p?=
 =?utf-8?B?dW5ZTkJudE5IeE0vbDk5OWZ6QXZUNCthYWZ3OExtdCtEd1NXRExCUjJqbFpD?=
 =?utf-8?B?VS9qRWdjbVpwcEtycllOYk4rMDFNaUVlUFJWMmkyNktJWG90RUdKVmNDM01s?=
 =?utf-8?B?N1ZHVEJlcVhTSUNtdkpQY2UzQWp3UDBSZkcwdlJJMjkzQ21aZm1SUE1TR3R0?=
 =?utf-8?B?T3FVUHk2eXcxbzBXWnBYTFZINnZBQzVRNVh6OEZMNUM1SUgyTDJ0aWEyVEVi?=
 =?utf-8?B?NDZZdGN2Sm1md25PbXVtK0hEQXlzOEVrVHlCY2FJLzVlYUowSkQxYnNkQjU4?=
 =?utf-8?B?akNHcHk1RjZQQUxTZnQvaUFLOHQzRStFaDJteFhRRG5TOVpKNDNEbzJ6KzA1?=
 =?utf-8?B?R05pbTI3enZ2Z2xDcVoyNGhQUjJwSDg4WHJWcG9ETnJuaHppSDZxS05XbGFL?=
 =?utf-8?B?SjJsSmw0RXRXUjdMdXdxL1lDQno4eUwzWUhiM2t2NngyZE1yZ3c1NlExQWww?=
 =?utf-8?B?Z3JNYTRqTEYwWUIwVGhzZzk2SWtMRHpIenNGeXhONzVYMC9PM0FsMHJyWkw2?=
 =?utf-8?Q?jiWyCg8X6+C/Nvn1zeptkIYDz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a424c3-4ea7-40d5-a8ca-08dbd4eb0340
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 23:43:23.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72mNaOREyor+2DNLsbAeRO6nMl2BWTYf+9+Ozb0unuZreJhYHFX0wnjZFjgLuaQX3F8t1VSsPV66cE3ZsPtKgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJcyB0aGlzIGN1c3RvbWVyIHJlcXVpcmVtZW50ID8NCg0KQW55IGN1c3RvbWVyIHVzaW5nIHRo
ZSBtYmFfTUJwcyBmZWVkYmFjayBtb3VudCBvcHRpb24gd2lsbCBuZWVkIHRoaXMNCm9uIHBsYXRm
b3JtcyB0aGF0IGRvbid0IHN1cHBvcnQgbG9jYWwgYmFuZHdpZHRoIG1lYXN1cmVtZW50Lg0KDQo+
IFdoYXQgZG8geW91IG1lYW4gYnkgIiBJZiBsb2NhbCBiYW5kd2lkdGggbWVhc3VyZW1lbnQgaXMg
bm90IGF2YWlsYWJsZSIgPw0KPiBJcyB0aGUgaGFyZHdhcmUgc3VwcG9ydHMgb25seSB0b3RhbCBi
YW5kd2lkdGggYW5kIG5vdCBsb2NhbD8NCg0KVGhlcmUncyBnb2luZyB0byBiZSBhbiBJbnRlbCBD
UFUgdGhhdCB3aWxsIG9ubHkgcHJvdmlkZSAidG90YWwiIGJhbmR3aWR0aC4NCg0KVGhlIENQVUlE
IGVudW1lcmF0aW9uIGluIChDUFVJRC4oRUFYPTBGSCwgRUNYPTFIKSApLkVEWHsyfQ0Kd2lsbCBi
ZSAiMCIgaW5kaWNhdGluZyB0aGF0IHRoZSBsb2NhbCBtYm0gbW9uaXRvciBldmVudCBpcyBub3Qg
c3VwcG9ydGVkLg0KDQo+IEl0IGNhbiBnZXQgcmVhbCB1Z2x5IGlmIHdlIHRyeSB0byBoYW5kbGUg
b25lIHNwZWNpYWwgY2FzZS4NCg0KSGFyZCB0byBwcmVkaWN0IHRoZSBmdXR1cmUgKEkgZGlkbid0
IHNlZSB0aGlzIGNvbWluZywgb3IgSSdkIGhhdmUgaGFkIFZpa2FzDQppbXBsZW1lbnQgdGhlIGZh
bGxiYWNrIGluIHRoZSBvcmlnaW5hbCBtYmFfTUJwcyBjb2RlKS4gQnV0IEkgZG9uJ3QgYmVsaWV2
ZQ0KdGhpcyB3aWxsIGJlIGEgb25lLW9mZiBzcGVjaWFsIGNhc2UuDQoNCkknbSBhbHNvIHdvbmRl
cmluZyB3aHkgdGhpcyBmZWVkYmFjayBsb29wIHBpY2tlZCAibG9jYWwiIHJhdGhlciB0aGFuICJ0
b3RhbCIuDQpJIGR1ZyBpbnRvIHRoZSBlLW1haWwgYXJjaGl2ZXMsIGFuZCBJIGRvbid0IHNlZSBh
bnkgZGlzY3Vzc2lvbi4gVGhlcmUncyBqdXN0DQphbiBSRkMgc2VyaWVzLCBhbmQgdGhlbiB0aGUg
djIgc2VyaWVzIHdhcyBhcHBsaWVkIHdpdGggYSBmZXcgc21hbGwgc3VnZ2VzdGlvbnMNCmZyb20g
VGhvbWFzIHRvIG1ha2UgdGhpbmdzIGNsZWFuZXIuLg0KDQotVG9ueQ0KDQo=
