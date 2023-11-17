Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164F7EEECB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKQJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:37:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C04B7;
        Fri, 17 Nov 2023 01:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700213853; x=1731749853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tyisxbEoYx59Y87JRoe1aoln+Wtlc1wuTAsuq//QprM=;
  b=YVrF6dL9eABRpwyTIP4ZX6KW6y2MaRe4vFDWRZseTsJRofg1UJqpk9c1
   hf6VdklZiKKKDX7xOIp3GCvfoveQU7638AWEw/yPzRgd72686oKYHPd1V
   jmHrdxmWIzeKLESlB+acA122SP/1kdxJFlFRIK3izZGsMDD37KusDEwwq
   +lHEaL34wtNk7f3552G64BOwpnWwnz5bklR40KeEu4IC6lHQmDI+fSCuH
   7dCkE23MsLkc7abvvIUnGjkrMNWs+JmpLIE2JqA2b66IQ8xDJ065wNQCl
   1HhKy4FATYFqn6Qni26Pzj2leIvA9B5cA21trAIOn062FJxvfy0c9yJu3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12815092"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12815092"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="759122130"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="759122130"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 01:37:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 01:37:16 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 01:37:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 01:37:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 01:37:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz1zMeUlmGhRvWC83Rn5EOUnffuzTtCLv5VGjKjA9SFDlxENgmXTYRTIJ/N4KhFdnH9YT09UeP8o7GINlI9oPTGuoh1TPUdweqGI3UkRKEjK+RGCaMzSvEWpk4AX9ReH2GbQgTVKrDzQtAa+HcoIEWQfk09DBVco8Yg51Gu8pzJ0wJqoqozAVtngFRO5bTpQAMAnAGuwE1ZUBtldnElKcwywsMxFs0U+uRp+hfWcZm7RBbJ5/1J/CSztlabQRXPhLoxTcq8TMAyhBEhbv79JyiKRf3zsTlZpnibEYomQbzYXjWb/rY9HJl9tmkgoHVCrBCwwrlqW7IN1eXOPODJCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyisxbEoYx59Y87JRoe1aoln+Wtlc1wuTAsuq//QprM=;
 b=VX87U3LOTyTjMHAzvfk1IzkO8heOxM7g6AJlZGVeao/yBL8fedF8GQkcw35jnpeh0b8CV5953Oe6WjulFCxy/pan+BzFbi49H5yezge0JQhuUzFsL7stHiWIaM/hGTZ+kkBevutkQbI180Zr9ByZHrheDiCMUUWWoJc/vRrPCTyaZ2/dyTM0UDi+L1Pwxt+A6xA3VDUsQQgz/pHp5yHM25vTADr/idcuo2e2gQ/sOwzJTKzA9rt9QaMzDJIrfplP8IEh5u/xv3YWZDhRL2bGeYLah8TNEbRlbp/j8YWEeubFcI0oSs4tEU2f8hvOhmMmTeT9+ZMXzuyzWXmHO1vGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 09:37:13 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 09:37:12 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     "bhe@redhat.com" <bhe@redhat.com>, lkp <lkp@intel.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Thread-Topic: [PATCH 2/7] kexec_file: print out debugging message if required
Thread-Index: AQHaGAd8uTpdBZJ0kk6jR34p1+k6J7B+PPOAgAAE/wA=
Date:   Fri, 17 Nov 2023 09:37:12 +0000
Message-ID: <39ccb4fda795a76996cf6d1c3b25909692358211.camel@intel.com>
References: <20231114153253.241262-3-bhe@redhat.com>
         <202311160431.BXPc7NO9-lkp@intel.com> <ZVcvBft/T3cbRBWr@MiWiFi-R3L-srv>
In-Reply-To: <ZVcvBft/T3cbRBWr@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|CYXPR11MB8755:EE_
x-ms-office365-filtering-correlation-id: 552b4d05-70d5-4828-0d4e-08dbe750c702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wv6ZgxOIrLJ5RSj8/lk+FydfcmV9fy7939TCh8kNZ9I/vyWcUnP8Jp/6MOReI0xPmmgQ6VXrojpG85vUxo6ogW6CtnWv/supU0T6vs8wmUKJFbZec2xjKpar5jDWnoJQHsuEM2PpCMg28hUHMDtdXAeHbUlGBcRtBVe16Pwv64Gb3uKMCi37WAH6aI3Zb6O42LyZsHR7Se0ov2Nw4VF+R87vlYoQ+MWwvHVLlLWohN8iCDPzLjrzJJw+6B9h2Y1zj8DGnfKpnaijmzZgcGVmRs/0Z0XxzM5hupmCgA6K/71RI1kiD59GuB0cyGd14kDM3fvOF6+8ma2s7CajtNZ5wzehzPGxG6zErDMuI+8ns/hXsnEha9rDYGN+ehyRzKJGG1SKiakYFTcFk9KYOzYVu9MkC0bu5ZJhShTEtDJaT5ywaOwiKRckeO8DjCbAkUwOxAaxhTeBU0X14FoYRtugujFhj6pcHLhTfNDKtmyG/eNAAVSAzZFJE7cdVqcgwpu+oAYF/B61aeMppdCM93ZIqRWUGsfmDvkhKK53W5exmAjS2S8USc+W6f0qGBDmTXr1dvcXTcKuiR1GCJcpxeUQqFNMqAyJHhAnvC4vFBlc+lftsre5OxQbeHk9jJBx/FyxTedQFrGGPDNKHFeYYuPGbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(26005)(8676002)(4326008)(8936002)(6506007)(6512007)(83380400001)(122000001)(82960400001)(38100700002)(71200400001)(6486002)(966005)(478600001)(316002)(91956017)(110136005)(66476007)(76116006)(66556008)(66446008)(64756008)(54906003)(66946007)(6636002)(2906002)(4001150100001)(36756003)(38070700009)(41300700001)(5660300002)(7416002)(15650500001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3VuRFVBU1ZuckdxaFNXWllwb29WZFR5WXRoWDhiMzFNTEI2enRKcVJlc0dJ?=
 =?utf-8?B?bEJxSVorOFh6WEhuV3NEbUtwUzVVeFVvajhaQks0d25vRTEwZDFMVUZKR3N6?=
 =?utf-8?B?ckE3ZThJcktFbGt1bTBvYnY0eFJRdUZqMnZTeVhzSzZpeUZqckFTelZSdUov?=
 =?utf-8?B?eWQ4cVJ4Uk82cXhMa2xRdkVjV25NbDFQSTRWTEdVdGl6c2h2Q2Q2SHcrSmhG?=
 =?utf-8?B?ZlMrdFNvQndwN2lsc2tKMmVvZFlTUmFIaERHVXdseVlaazcxM1ZFQzFPcXRB?=
 =?utf-8?B?alJmOWd2MlpJWlM4YmhsdytrMmxFeFpXQ3RHaHhFbGJtNzBJdHE3bmQ5b0Z4?=
 =?utf-8?B?ZmFQUDdBcWFRZ1V2UklSN3hGekE5VnBDb2ZkS3BRQVpzWGQ3Z05MUTZlblds?=
 =?utf-8?B?T3RzYnNLaTBVWUI5clpsb1RWRkx3UU15c1dBcWtGaVRxemhST2FtL0ZRMlFU?=
 =?utf-8?B?S2hVbCtkZXd2MU9DMlR3VVEvY3dSYlZGOHNuQ3FXNy83U2p5b29sMmw0WWEx?=
 =?utf-8?B?R3Z2YVBOUytnSVh6a0xHTUEyb0JpdytPd0MxWm8yQjFIbEw5NVdqRXVCbUE5?=
 =?utf-8?B?YWxveWtJUW9Kd1NFSVA1MS9ZZmxLck9xTGhiTnpTcmdhRGw2MHJZSk5xUHRV?=
 =?utf-8?B?UUo5dWdEOFFXNTBHeGppTWlKTG94b3pxMUpPNkdxc1NKYnBidHVhNStaMjBQ?=
 =?utf-8?B?bEtmZHFrckNOYWZPYXJ0RzlvQkxqOVlLZnFTVUFFYXhLem9YekFtN3V6NklZ?=
 =?utf-8?B?UWxBeDEvNTVmRkM2S1QySjdFdkdtbkR1eThrUSt6K0xMeG9SNUplanpWZjg4?=
 =?utf-8?B?c3ZFYitLT1pLNUN6c3FKT2FPeExId3NiQW9KVnlPRmZNdmZxUzVEMDl5ckdm?=
 =?utf-8?B?em1DTzZjNlVDNG11dWFVcVUxWTA0TndCL1paNk1DOXd5amUxTU51TFprdW4z?=
 =?utf-8?B?WlVJcGcrdE9EaHd2L01hVEd4MEJhTmZ1R2Q3RkJJRnVHRjFwV3B6ZFBKalpx?=
 =?utf-8?B?SHNBVGhKL0RlZ2NXWU9lTjAvL1I2MVIzMDZrb0VCdkZZeTZxdmFDb25DbHFI?=
 =?utf-8?B?YmlJYmE5RUlvTEUvbzZIOEtnaW5ITTRSZjFEWHU2TitPM2dVUGVNdnd1NWVv?=
 =?utf-8?B?UU9mVXo3dTZKdVVCbllYNHQ4OWJ5bnpicG5yeGMyZWV2bFp1dDJucFJxc1NK?=
 =?utf-8?B?RXBjUU04bEV5eVl4aHRLRmRGV0RLaVZJOWhtRmRJSkVqOXNkUHUwS0YrR080?=
 =?utf-8?B?QkhkVFp3cVZpcCtVd1Jna3BINWpYZVZCNFgxSGhMWGd0RldNV2lkcWVkMU40?=
 =?utf-8?B?ZTkzOEJOUXhvbkJBNkdaVVVkNkRaSmVZTkpzZ1JXWFdreHNra2xLNGRUeXR2?=
 =?utf-8?B?b1U0ZkJHc3JrV2J5eUtVMmJNa1c2RFlScXN4a05uUnoyWm8xSlc0Q1NsblJh?=
 =?utf-8?B?OTU3MTJUcFd4NjRPT2F6LzlZakJ4ZG9ZYmg0WUNNWTQ3cGF6N1ZYSlNpSnBV?=
 =?utf-8?B?SnUvc2ZMaVRMdWIwLzdUcXN3RHZRYThBM24zVlVaNmpsKzFZNUhudHV3MnRH?=
 =?utf-8?B?S1RjYzJNcjdYSFV2eE9XZ0M2ZDh6b0NZd25NamJTZHkxU1pYRnFTVUtvVVk5?=
 =?utf-8?B?eFdDRDNQZEVvdjhYSFhXSHphcWNpN0lxSmE4dmtTb3FKUUNlZlZGcFRqU3Jq?=
 =?utf-8?B?WEdQYkxXT2VyTS9lMTcxYWxwbTRNeG1ZK2FyTzNrVUc5SzVPYUYyNlpZWXhU?=
 =?utf-8?B?OHFCT0VvMmpKNlBnVHFvYVl4VGE1dnptczhzMSt2NzIwUlp2MmVpcjhzajd6?=
 =?utf-8?B?ejd1dnBFaWNSVkNRN0p4azlHZHRaV2lzZC9ka2V3OTJhS1FUOXVIaFE3cHN4?=
 =?utf-8?B?dSt0ZGNVMHRVQ0VrM0VpYlhiT2xaU0t4dUNnNjhKTllzTDVubFljbnZyaGZ2?=
 =?utf-8?B?M3hVZkl6OXBKNVplRWdyL3NhS1o2RDR5bUlPYm9Ea0F6d29kTFh5YXZIdkFE?=
 =?utf-8?B?bm11M3BqL204dHhub2ZlTkpKNmE4YStTYlFOZ2tUSWdwNHMvTkl6NnRqdk9k?=
 =?utf-8?B?RE5Sc2pBb1IzUFZwYXczNTN2dloxemxJQ0J5VU43MmdsQXExa1RWZ0UxYzkw?=
 =?utf-8?B?b2I1TjEvYmdyc0UxVW5YdzJwWnR3SHhXTEtyUk5Yd0F2bXB0bVhTWTlGVURZ?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1128A5AE47EA34A8E025581EC198CC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552b4d05-70d5-4828-0d4e-08dbe750c702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 09:37:12.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9a0kwpCkWPsPyOWCwPhNU1TiI/FSaz2SCuvCW+bfE4OYtAORheeqaeguJJLpcv1X+ru2/m9Qns/xlqmWvkSzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvcXVhbiwNCg0KT24gRnJpLCAyMDIzLTExLTE3IGF0IDE3OjE0ICswODAwLCBCYW9xdWFu
IEhlIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIDExLzE2LzIzIGF0IDA1OjA0YW0sIGtlcm5lbCB0
ZXN0IHJvYm90IHdyb3RlOg0KPiA+IEhpIEJhb3F1YW4sDQo+ID4gDQo+ID4ga2VybmVsIHRlc3Qg
cm9ib3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yczoNCj4gPiANCj4gPiBbYXV0
byBidWlsZCB0ZXN0IEVSUk9SIG9uIGFybTY0L2Zvci1uZXh0L2NvcmVdDQo+ID4gW2Fsc28gYnVp
bGQgdGVzdCBFUlJPUiBvbiB0aXAveDg2L2NvcmUgcG93ZXJwYy9uZXh0IHBvd2VycGMvZml4ZXMg
bGludXMvbWFzdGVyIHY2LjctcmMxIG5leHQtMjAyMzExMTVdDQo+ID4gW0lmIHlvdXIgcGF0Y2gg
aXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90ZS4N
Cj4gPiBBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNl
JyBhcyBkb2N1bWVudGVkIGluDQo+ID4gaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1mb3Jt
YXQtcGF0Y2gjX2Jhc2VfdHJlZV9pbmZvcm1hdGlvbl0NCj4gPiANCj4gPiB1cmw6wqDCoMKgIGh0
dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvQmFvcXVhbi1IZS9r
ZXhlY19maWxlLWFkZC1rZXhlY19maWxlLWZsYWctdG8tY29udHJvbC1kZWJ1Zy1wcmludGluZy8y
MDIzMTExNC0yMzQwMDMNCj4gPiBiYXNlOsKgwqAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtNjQvbGludXguZ2l0wqBmb3ItbmV4dC9jb3JlDQo+ID4g
cGF0Y2ggbGluazrCoMKgwqAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMTExNDE1MzI1
My4yNDEyNjItMy1iaGUlNDByZWRoYXQuY29tDQo+ID4gcGF0Y2ggc3ViamVjdDogW1BBVENIIDIv
N10ga2V4ZWNfZmlsZTogcHJpbnQgb3V0IGRlYnVnZ2luZyBtZXNzYWdlIGlmIHJlcXVpcmVkDQo+
ID4gY29uZmlnOiBoZXhhZ29uLWNvbWV0X2RlZmNvbmZpZyAoaHR0cHM6Ly9kb3dubG9hZC4wMS5v
cmcvMGRheS1jaS9hcmNoaXZlLzIwMjMxMTE2LzIwMjMxMTE2MDQzMS5CWFBjN05POS1sa3BAaW50
ZWwuY29tL2NvbmZpZykNCj4gPiBjb21waWxlcjogY2xhbmcgdmVyc2lvbiAxNi4wLjQgKGh0dHBz
Oi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC5naXTCoGFlNDIxOTZiYzQ5M2ZmZTg3N2E3
ZTNkZmY4YmUzMjAzNWRlYTRkMDcpDQo+ID4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxk
KTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMTExNi8yMDIz
MTExNjA0MzEuQlhQYzdOTzktbGtwQGludGVsLmNvbS9yZXByb2R1Y2UpDQo+ID4gDQo+IA0KPiBU
aGFua3MgZm9yIHJlcG9ydGluZy4NCj4gDQo+IEkgbWV0IGJlbG93IGZhaWx1cmUgd2hlbiBmb2xs
b3dpbmcgdGhlIHN0ZXBzIG9mIHByb3ZpZGVkIHJlcHJvZHVjZXIuDQo+IENvdWxkIGFueW9uZSBo
ZWxwIGNoZWNrIHdoYXQncyB3cm9uZyB3aXRoIHRoYXQ/DQoNClNvcnJ5IHRoaXMgc2VlbXMgdG8g
YmUgYSBidWcgaW4gdGhlIHJlcHJvZHVjZXIuIENvdWxkIHlvdSBwbGVhc2UgY2hhbmdlDQp0aGUg
Y29tcGlsZXIgcGFyYW1ldGVyIHRvICJDT01QSUxFUj1jbGFuZy0xNiIgYW5kIHJlcnVuIHRoZSBj
b21tYW5kPyBXZQ0Kd2lsbCBmaXggdGhlIGlzc3VlIEFTQVAuDQoNClRoYW5rcywNCll1amllDQoN
Cj4gW3Jvb3RAfiBsaW51eF0jIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5IENPTVBJ
TEVSPWNsYW5nIH4vYmluL21ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9aGV4YWdvbiBv
bGRkZWZjb25maWcNCj4gQ29tcGlsZXIgd2lsbCBiZSBpbnN0YWxsZWQgaW4gL3Jvb3QvMGRheQ0K
PiBsZnRwZ2V0IC1jIGh0dHBzOi8vY2RuLmtlcm5lbC5vcmcvcHViL3Rvb2xzL2xsdm0vZmlsZXMv
DQo+IGdldDE6IC9wdWIvdG9vbHMvbGx2bS9maWxlcy86IGZpbGVzLzogSXMgYSBkaXJlY3RvcnkN
Cj4gRmFpbGVkIHRvIGRvd25sb2FkIGh0dHBzOi8vY2RuLmtlcm5lbC5vcmcvcHViL3Rvb2xzL2xs
dm0vZmlsZXMvDQo+IGNsYW5nIGNyb3NzdG9vbCBpbnN0YWxsIGZhaWxlZA0KPiBJbnN0YWxsIGNs
YW5nIGNvbXBpbGVyIGZhaWxlZA0KPiBzZXR1cF9jcm9zc3Rvb2wgZmFpbGVkDQoNCg0K
