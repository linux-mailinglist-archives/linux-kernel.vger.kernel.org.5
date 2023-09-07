Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84379773D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjIGQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbjIGQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5795C93E3;
        Thu,  7 Sep 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694103602; x=1725639602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uAWHLVg1qfsQr0lppp73XqZT9ttK0k7h98NBg8HAtgI=;
  b=AUwMkgzwv4Zh2BSkJu9Zth87SmNcF9+Iy/+AIzXpjVNfSHnaU9zjx6rX
   bELmnbzQncte0zzxVJxo1T6ZF3/kA/D/zYPMBiN6HEsW9xpplTbpZmTyc
   bGygoTxB3tuJLXY0GTX8kQJ0KA3ggmLq5CBjSEptkNOOC7UbpQE16yhOt
   Wld5TskpoIqjSdY4gZUy+TvE1pG3hRtnkdKcFmrlkHfIO0pkTmBjtR4Hg
   HOnuBfGj08YfuspvwNERCYLPHSsBktX73YtLggPn530FZkx24f+dpheWd
   ln5fyO600oNzfYOSqEGzdpwsnPO9cXJ0ZBxTkYbXkoT1t3aQRoR957tpk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="381209252"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="381209252"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 09:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="742076980"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="742076980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 09:19:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 09:19:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 09:19:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 09:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYM5Z+OaLduQdrLDKxw3NZ7zwrJJIsGdXqzyaBZ96G7PqJbFh/LkGmO222pGuAK2VbFsJnk9ofhL8nTiXvtDXnXfT8Vo2ACg7PQMlFp8NtxL7/J54xh6LQPHUa5B3r9MuByzBY+BcCmTCmf4SG0Hkp5f7ILk99p/JOSJWXaCK+dHrcd/ss5B9o3KXPhmerjrWvfwQ+yGfn6OOXVP9w3pRMTv7hBpLPHXNZjTDFFmZDtiaNbBsyfAY3L3cu2bvkoAAwHKR2YQrR/zua1PPpb4gBYM7CpInhGkZTZ+7drG6AKYn6SeJBfXRuNjbq5ho0tyo49pWBQhTOH/vJq7zRDvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RISBtQcTAwv8A5xS2dx6TStYjtcN4WAF+2LIL4evQbc=;
 b=DxWJjwmdBkpg1exjXCoUVVrYw4iC67MVG+nAuqQWaVKWkWdwaVy837whVryN22ak88oNv5SjENS9OHM25iIJXYykjUoeS9mP6UHVtfUrZFrngumB1Af70bKJAcjGfbEdkanTKiNVu1GlfFr53QfkiGpe0d+I2IGCXwZ8k8U+z0DWI1uiac+vAA2rhU+Z34w6AGXdOfNHNikfbxpsI4vXbnl+ihXo3Kir0vztvSQcWO4QHf/0khn7sjE8Wt/1B9PKj0dMRm/klSM5fompN3ml7LPfVXddmQrh9+O7KxtcRNTadwIgcm1hBBk02MsOQj93sSzpAob9UWhmHdKV3F5VBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CYYPR11MB8358.namprd11.prod.outlook.com (2603:10b6:930:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 16:19:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%6]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 16:19:37 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Topic: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Index: AQHZ2tLQzZViQZuDwEGXIVxBB0yNB7AO4J8AgAC3GnA=
Date:   Thu, 7 Sep 2023 16:19:37 +0000
Message-ID: <SJ1PR11MB60839EB5CC3D172D864DF7A7FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9MmIyMmI5YzItN2VmYy00ZmE4LWI2NzEtMGNh?=
 =?iso-2022-jp?B?NDA0OTJkOTU5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDktMDdUMDQ6NTA6MzJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CYYPR11MB8358:EE_
x-ms-office365-filtering-correlation-id: 91d9cdeb-c212-4e8a-166a-08dbafbe3b19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FrjnczZ4tsyo5K5iaKIWwQipy/trTtDVOD59rIlTAFVm0p3u4QpoXLs8TnM82bUeiKwes6vENWxDSx2Djz2/g6PmFRFnDj4k6ItK5WV7/aRp/0tF/xgMG96d2iUzzC+/MYsX18+E3DUB/qdAibab2sKZ7KTK2W7+2pxG3oza0y4phW9PJ/NcW4lm2sZE+dzXV7OKfZvUHNctWPIC4TM1keOreDKySS3wpIONvocGDAeRyvE47T5ltkjgt+umQE2SHBdK8In+GNS20aRsHnhxMiepYTHDjr5ZZAkTHKN1DDfrG9WR3r5974usBiw7NybGeAjMmsoGDvd3xJifh0Wc5/qvjlyxEQDDMc4hYc5fdRkGrQfCPU1JgaBfBpcbj9G6Vu//tKKspGIqfMwVHZER6a7fIt0v0+UEZe3TYS6F14FUek0Ix7cNrRWbHre2CTsOVg1GpEuae5Fy54ImmkTw6/BAm6szpRct5d0rK++2FwLguvhkl8J1vAXZWDS29cQ3/LefHWbZSjqiDiHVhbl6AvyqLUfVnQ78ooHHmj5isRLZxN4ImQzKZapqDi1h91SD9PctR6lqV0rzcKTryTrrpBD+vVBdGHsG7SGg0uZtmZyWiWCjA9eHZVmrL5EGfz9j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(186009)(1800799009)(451199024)(55016003)(33656002)(26005)(86362001)(66556008)(66476007)(54906003)(64756008)(66446008)(66946007)(316002)(76116006)(110136005)(5660300002)(38070700005)(41300700001)(38100700002)(52536014)(4326008)(8676002)(8936002)(6506007)(71200400001)(9686003)(7696005)(122000001)(478600001)(82960400001)(2906002)(4744005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Y2hTMDZaYnQvZktteWZ1UE1wUk9KQ0tuTS80elRMUlROdEM2clNTOUNs?=
 =?iso-2022-jp?B?M3EzelVONWRDOUlJNFJ6cE90cjFERDcrL3NuVWJtazJzWnBzZktuamQ4?=
 =?iso-2022-jp?B?b05Ecjk2OCtXYkdkMlZpNVhDSkdUbHByYnpRUlllN0xuSWdhRXhZeXhj?=
 =?iso-2022-jp?B?amNpcWJ1c2daOStJMXpjTytxTVYweU5ZVHd6cWNNaFdJK3Fvb2Naa0g5?=
 =?iso-2022-jp?B?NlVFNTlrQXVpZ3A5bUc1THNmUXlJSm9mbWxwOUhVaFFqNWFoNmVpd05H?=
 =?iso-2022-jp?B?R0JqVXJIdzltQjJoMVVwMGxYZEFSQ2RFMitnVGhJWC9YY0ViSnEyRFZw?=
 =?iso-2022-jp?B?eUQ5WkhiOVUydmNlR0szemZtWUtSUGlObHFhdFZaczNNbDBFUDlYOGpq?=
 =?iso-2022-jp?B?VktuY1RyUnRhOG5lQ01CZ1RyeGNMd0JXbjFJek1ydXZLVDdNVVhmMXlx?=
 =?iso-2022-jp?B?LzQ2aFkvc0hadVE2cE8zZWZqT0VmZWhvNE9wV3dmOWs2VG5LTVJkbHJG?=
 =?iso-2022-jp?B?eHhrNnNpemVzdE9STy9BT3pLczNadlp4REFWcTNkZ1lacEJ0bkZyTDdL?=
 =?iso-2022-jp?B?TTdFa3RDd0FXWnp4UFVlRms3L3RaQ2hXbVJPN3A1N0RweVpCWjUydXRW?=
 =?iso-2022-jp?B?UjdiNndybUhiQjhXQUJMejg4NDBhaHEyQVdJb0ZuN3dGWEFPdndmbk0z?=
 =?iso-2022-jp?B?bTNVbCtWMU9kRUs2YXlNUWhkUW53NS9OdjdSYmZrRkdvQ0pFcVphQkR6?=
 =?iso-2022-jp?B?NUNiOUtxKzIvaUNMUzJKbENYVUxhdWpLVUpiUmpaZnYvd3RkMjZtTXh2?=
 =?iso-2022-jp?B?b3krejJJZlNnaDh1UnppeldrL1l2RThyZkM3MlNSUzNtYmR0VXdtYjM1?=
 =?iso-2022-jp?B?Q2FDOERvSzZ1NEFaa1QrTjRCWk8velRZeTVpMytpeDVxMXVpMUhQQjU2?=
 =?iso-2022-jp?B?VmNoZkxERmxERFE5a21haURMS3N0RldaUWhHUXdpWWMxUnJlcTdKcmRZ?=
 =?iso-2022-jp?B?NUJaWGJ3blZVRFpMWjlnVWNzR2NWbGdzSVgvWk5Xc2ZaZzhuVEE3cUZi?=
 =?iso-2022-jp?B?a3Z2RTd1dE8yemg5TnJheUFuckdLSEJVQnhqdDlUc0ZzN0hzUVhvazNW?=
 =?iso-2022-jp?B?TU9DMzk3RWZuRWFOeDE0dTJ6bFdLQ09YZkFLeTk3SFdjYk5pVXhVL2p0?=
 =?iso-2022-jp?B?dXp1OXBvZENnS0Q5SEd6WWhtRE4rTkd2V1g4d01COW9BNW5mM3ZTNGcy?=
 =?iso-2022-jp?B?enVZNGtFaFMrWndZRXh3MGtuZDdCZUp1QXFydVBnNEhzK0lRNHhMRDNh?=
 =?iso-2022-jp?B?RDZIMysvWFJSOGdNYUtOUDRvbG8wOWY3L3BRS2d5bll3bnZWN3ExM1ZI?=
 =?iso-2022-jp?B?aDVnSmhITExtbXV5TW9sNytqVnBEN1FxWW1aUHhQODlwNTR3WGVKa0Jj?=
 =?iso-2022-jp?B?TzFHa1VQNmVGdFQwOHdyQjFLWmZkTDF3K3U2ZFlxbkZta3VLd1ZydTMz?=
 =?iso-2022-jp?B?NGZpUzNPdTlES1FHU05aTlFYVHAvWS9nZG5EWkVOSDVBY05qUkdoQ0px?=
 =?iso-2022-jp?B?UjFhc2g2eVRXS2kwRmdTVjAyWUFzcXVLcFdieFdwRHJRN3NFcW0vSi9v?=
 =?iso-2022-jp?B?UlU1Sng1NE9DRHo2OFRNRXJ5aDMzOGxSWmp0Q05Pa0ozOU13eldsR1k2?=
 =?iso-2022-jp?B?UUpUTXRWWVcrU3d6OWhiRjhyUk5uRUNXVnBROFBaKzdPL01teXRMZHJZ?=
 =?iso-2022-jp?B?UHF2aHNXeldhcHBXdEFhUy9XOFRCU3pSZjg4eDNoNmRjeWI4TDNRdjBi?=
 =?iso-2022-jp?B?TlBlWFBqajJmZ2U0YXZCcjlqdTdWaUhWSDdhT256SVg0cGNVS3l4QjZj?=
 =?iso-2022-jp?B?T3Z4NFI1R3RURi9NT3lBSVFyRHRoalVWRTZSUXlOLzRZdm1sT1ZVNm82?=
 =?iso-2022-jp?B?QjI3MklMSHpCaXEzaDR1cjM3SUhEbU54VjZYMTY0NzhNU1FpeVc1SkU1?=
 =?iso-2022-jp?B?Z0Q2RWF3UWgyUGN5bExBTmNFcVdyL2pMblhqTUllVTJGekdvdk0rcHhO?=
 =?iso-2022-jp?B?TU90L092QW10RlQ0Uk1aQ2RTeS91SytBbnVvYzNQRTdJWThzdW4rVmJU?=
 =?iso-2022-jp?B?Qyt3RnRXb01xSk9SMVdReXF6c1IxcXZ5RGIwQ1hCK0lGWWRCd3dSWnc5?=
 =?iso-2022-jp?B?RU96dVNnMk9GMmZnVk5DbU1nc1hNOVVPalNTWUZ5MGsyZGJnV1lXZmkw?=
 =?iso-2022-jp?B?bmVYSkpWQTRudXQvTzNGMWxscUVjQ1B5MD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d9cdeb-c212-4e8a-166a-08dbafbe3b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 16:19:37.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HXAhJA+wFFB+Jz7vuQdT9D/CGzirx6UsIglZDfFo4BfAjqF4D1z8u/o7NxDaGBKK6eoNnr/nGmppMwPw0xBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8358
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

> > +   if (4 * node_cpus >=3D cache_cpus)
> > +           return 4;
> > +   else if (2 * node_cpus >=3D cache_cpus)
> > +           return 2;
>
>
> If "4 * node_cpus >=3D cache_cpus " is not true=1B$B!$=1B(B
> "2 * node_cpus >=3D cache_cpus" will never be true.
> Is it the following code?
>
> +     if (2 * node_cpus >=3D cache_cpus)
> +             return 2;
> +     else if (4 * node_cpus >=3D cache_cpus)
> +             return 4;


Shaopeng TAN,

Good catch. Your solution is the correct one.

Will fix in next post.

-Tony
