Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8B7DFC25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376548AbjKBWDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:03:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D69192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698962575; x=1730498575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z28xM8s8gG/pNeQHKInG6hXfAycRIYEjZPVLjICO9Jw=;
  b=O36YoXWiptIU64IYGAFLRsBl68X7XWs/rD/08LXSigmAr3Hsv6JeDew6
   6LiCI1StHG7dGKIbJ/f6OWHu+Du69NTENtct/4Jodw+T5imvh+E55R1Ew
   xWx1ZDE2lYWlirzM3XNA/wmdJSxCAWC9PPrBfajUcoRlV3N7U6QtPbFRq
   reD9tKrvfxF/WsJXU+m/1u0UEEP6jVnJcOdoaAkrCrcoAlid9j1i1dIlO
   WjpW63BiziVdj1sJG+e70yXR4sQqP3SHNX9OY4N6d65INw6KNGDckqBTC
   dLx48S+cmW8Oa3dVL4MNdd3lhaYErxQHOJnZVgZpx2FFavP005ZTnWLA+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387711653"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387711653"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="885016583"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="885016583"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 15:02:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:02:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:02:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 15:02:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 15:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I654nPFlpOfaLeXB1afkuUVrd/7tt+bu5L/F3QsgOGkDHbsrqNYsoZUN3L6Av+XORil8ovPX8R7X5XZBy2rdy/Nkutuu0oqSn9H+cqINIhTKhRACXMKfo+dfrGRmloHiMlizohS+NQaph4dlrRtdJkdjB2pZB1f6dAVkZqiPranvNJSgPmmz79vu5qn9ty4q9mXNynu3jzB3JiO8urkyJAwolsWluQ+H8+5L1E57KHiRmv+CyBzLq5JNVyH5zoKtKItrhdoMcJqKaOg3UN7wwFzMm8eLuGVzTVjOqXhEAuBNby/rDYpWgGLB/4x8BRMS5CGqgT5jthUZx84en+ArTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z28xM8s8gG/pNeQHKInG6hXfAycRIYEjZPVLjICO9Jw=;
 b=bik4jW6eGGUDR8wjNjcNjOlR5FBgJT9vq7MPoG78lXPb3bs7NvtcG0gjPJBLufy4TSICOIWFymNRzZRJGQhxjHSkIOnONDGQnizAm2y28I3ubane9JXGQ5z+R5OUo+YL3phdd2ypbXQ3o6wqv0X8nA1kJ/3G6MXdkoEKWaYRK/NZugJbIdIDKzoAJFGAOHYl57/XZTxVLzuCFse2jAimqsn+1hOuKkl/dlrlkTVlmoZ9X+Iwu8sXipjXdp1RfFJgOJHS9JwUviXSeBGUfoP9K1thsy5sHxft4U6O8bOzq/8OlCDN/uMOOGXVxeKtUkmhgnMAX3UB3bc8Jmj81BZoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 22:02:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 22:02:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Moger, Babu" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Topic: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Index: AQHaDdRZXJsCafg/QU20afPRuiTx9LBnlGsg
Date:   Thu, 2 Nov 2023 22:02:50 +0000
Message-ID: <SJ1PR11MB6083D8F1467F094A5F1993EAFCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
 <ZULCd/TGJL9Dmncf@agluck-desk3>
 <3ca2b0ed-6732-4fc4-a5fe-1846b873b02c@intel.com>
In-Reply-To: <3ca2b0ed-6732-4fc4-a5fe-1846b873b02c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: 8e5be0a4-610b-413b-c525-08dbdbef74d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2lzC0BwMCWhfEvNiUWFlHVUkN5oNak0vhVI7DD+8TDDz1cb1VqEqt8jpcpcU4imOP5dh9bo7qXrgE/Ug3QHzTwFGobArADD+16xbHGgyM69jv0bMOw7rY5hGf5qugXEeOixaYOBOTNIUKUaXFsSOjUpeDbGxleAz7pli55fJryve84Koe1F2PoBmkhRmOG7bC6UIOr8urBp35if01meJHlpndWD/sYKO2QgbRLL5wqBz/K9QanTuOkYl4MrSvqOkJes1/59QFL3q5IMzIbp5nvaWIEAg/B/o0miP/0xT9aERi1rv56qGb59PSM8kIdgtFPv1FChOnYSJGDyI3AqxcabL50AslYMsc7145fwpo+zBB359GRdBz8M91L4DQOg9GQpcXY3xonT1TJlwzYhm+XHILfA6Qwyo0IHXXZWyaAUbAA0Hk4hnd5/I6sH/4gW2IJ5Z+vHMDbjS4yUeoQLfZtiwDzzu5Oc6d2sZFCHWpPsYSbFd82bBkfnL2WD/loBfBBBvl/2XFVh+T+SydgVFzi5Dt5x21nsER1hd/ePHxpNVl37O7xesxEuj37knhIVpKXj1bWDPOG1ExzQ1GVzwuUBzE6MARS1vK87vD14Bn53kt5s4h8ODPWk/SbLvp6MCAJNbtbUv2IxIO90S/l5Y6umeJ2j1qnUoPr88Lq3dPF+NNQmzCr2ejYiGKdMcwgG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799009)(55016003)(478600001)(316002)(64756008)(66946007)(54906003)(71200400001)(66556008)(66446008)(76116006)(66476007)(110136005)(6506007)(8676002)(8936002)(9686003)(38100700002)(86362001)(7696005)(52536014)(41300700001)(4744005)(5660300002)(2906002)(82960400001)(4326008)(33656002)(122000001)(26005)(38070700009)(83380400001)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEE4OVVyWVRRa3N0Rmh3SXE0MjlSNmtmdEIwTEYxZWZtTFd6SzlvK3lZVTJo?=
 =?utf-8?B?Qm40TytoMURONWtSSFNjY0szSSticVliNVFxNjI1M3RoWjZoMVlEMjFKamc2?=
 =?utf-8?B?U3JSSktPMXlSamVTa0pOV1p0ZjNJSGttNEI5V2lMRk9UUVJwSVh1RXZSWklT?=
 =?utf-8?B?Qlp3QnM5TGN1NktCUWpmR25USkc0NFdzdUlJRmo3cWh2RGdkTVBYa090UDBU?=
 =?utf-8?B?emhxTVU1c0o5T0dOc055bDlBY3krM0F2bEJGdFlYRXZ0bXFFMytsSDZIV3lh?=
 =?utf-8?B?RGtiV0xFNDBBVjdQdjVHUmJMWStGVkd5eHcxSi84VmZYWTE5VUtwd0ltREwz?=
 =?utf-8?B?UzgzL1BhbUdDQnhuTnJUYlVuc0hxSHIxeFlFYjlxcnVVa0QwbGwxamF3OURh?=
 =?utf-8?B?V1FHVTUxMlE0d0gwZTJoRUQveWJvVG12blh3c0JIUjliTStoVEMwK3ZPMXB4?=
 =?utf-8?B?NmJTdDZoTDZzdHhTOXF5elZtd29kS09qNTU0aWZKZkVSNFFsN1lGNHhSdzB1?=
 =?utf-8?B?Z3IwN1lPbnYxVTd2cmlieUl3d1RlV0FHK2k1NTFWczk0WVZGd2llaHR4OUxF?=
 =?utf-8?B?cEhYN1kxakd3NithRHNQUUFadUJnUUxWRCtmSHdmOGdLTHpGNjZ4US9KWW1u?=
 =?utf-8?B?R0luWlNoSXZkUG9JcmQ4dzRJSUl4dXVLYTh3YkpWMFpHYW9Gd3kwZXFwRDd3?=
 =?utf-8?B?NTZMcGs4aUl2RlNuQ0NMYXMzMXprVGwvSlFKbkJWc0RNWFVVcmUyNk13ODly?=
 =?utf-8?B?RFdhMmJxWWlGMWk4VU1HSUJPa0NsN1V2ZjVoT2xlUDFRTFVHQ0lyUURBWFRE?=
 =?utf-8?B?Q0QrTUhETmZVd3VaU0dNd3kxN1ZPaTJ6K3dDb1IvTjNIZCtiUTJVT0M5dmdz?=
 =?utf-8?B?OEJucVpwRzdENjQ2YXhVSFNSazcxSVFRWjhqK2hFWTVYTzJtdGhlYTlqNnd1?=
 =?utf-8?B?eHpGaDBvM2QrRWk0WnpBZEwvY3diYXFwVnpGNTNUd2NTejYzVytzVDVQdWJo?=
 =?utf-8?B?cVl0MkRiL0thWHZOR2Q4dUxGY2J6eldnbDdZQjJTQkJqT2kyNEVYNDg1dkRC?=
 =?utf-8?B?WTd2TW53WVJLY01QTlV4VWp0aXdwUklCd2xzUDJ6TnVJdlkwTnBqRU9oaWFm?=
 =?utf-8?B?RXl5RkhCUm9sdzl2dnFYbWFiWnU4c3hSNkErcUpFSHBFcC91Q0YzRjVjOFVj?=
 =?utf-8?B?M2lFOVM4RW5KRWhXbGJTN1JXUFFwQnM0Qk8vRWQ0Ull2bE8xTVpYbEx1bFFV?=
 =?utf-8?B?Yk9WMlYvTkd5WVNaUGlmRWxZTDBQUkY2SUY0WG9CWmNXUGhtRGN6T1haZElZ?=
 =?utf-8?B?OTlicFk1a3JNS2puTWkva012d2RtaVNGUEk2M3I2dnJacXl2ZlRQeXYvK0gy?=
 =?utf-8?B?SUhDYXVtdVNRODhidTRldzRSeGNHOHUxWTFwdXRoM1BoSzBLbDBJUk9JV2NQ?=
 =?utf-8?B?d00vQ2c3Y1U4R1Jwd3pVR2xyQ3I0K0ZmV0FJNW13TElMb3BPMlZydWxpaWxQ?=
 =?utf-8?B?ZTBKYU9ZQUo3RzI4cVhReGEvZWFTaGV6RC9BdnpvbGltU095VURkOEk0ZUtK?=
 =?utf-8?B?MkQ5d3RRRnpINmQwdEJuUWxpTEt3Kzk5ckpDOHZaMkdqeW4ydE9zM1ZpNkdL?=
 =?utf-8?B?S2l5SmdQVTdmZXExbHRtMmpSR0N2Vkg2M1hrT1lJUm4vYlQ0YTJPTlNRY0hQ?=
 =?utf-8?B?dnN3NVRFaEIzTjJSOHVIeGRvSFZOcnFqVUNkZGZOOThkVnpnZU9jTlphOHNW?=
 =?utf-8?B?VmgzUnNkYmE5THFvcER5WklnTUJoR1NtV3R0dkkxSEZsT3JmUmNZMSt2RWpD?=
 =?utf-8?B?eW5xY1BJZHNHRS9jK2VMLy9KNVJBQWk0ZWhtLzBoUDM0T1FhbjcrREhndEla?=
 =?utf-8?B?alF6RGVwa0JPRlF1QjJWMVpZNGZWbDIzWnJ3MTRoSUpHb29nS2JqSnVab0pW?=
 =?utf-8?B?dkFvU1ozWHZXVFVrbGs3NCtLRmlxL0d5MXFpMnBJUDJHNCs3UTBqTHliVFNW?=
 =?utf-8?B?c01ubzZjQWVOeUhENVJSeFc1c1BGekc1dXc0cXVONlQ4TkRVOGtDY3hpRVhZ?=
 =?utf-8?B?cVRJVU1BeEY0aTdabEZ6eGVWNEs5ZXZxWkJrL0VzclBYSWVMWkowaGNiMFNX?=
 =?utf-8?Q?9NJBkYDquiv6abmcexcHIS7hN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5be0a4-610b-413b-c525-08dbdbef74d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 22:02:50.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxuYeCu5fVc1qvJd21KIqu8Z9OptUp4M5wJGzYJW3XDgxRngUgyg8wMlTc6ymebPdEgj4hg3jQZOSvLhJslyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGlzIHN0cmFuZ2UsIEkgYW0gbm90IGFibGUgdG8gZW5jb3VudGVyIHRoaXMgd2Fybmlu
Zy4gSXMgbXkgZ2NjIHBlcmhhcHMNCj4gdG9vIG9sZD8gSSBrbm93IHRoZXJlIHdlcmUgc29tZSBz
cGVjaWZpYyB2ZXJzaW9ucyBuZWVkZWQgdG8gcmVwcm9kdWNlIHNpbWlsYXINCj4gd2FybmluZ3Mg
d2l0aCBjbGFuZyAoc2VlIHJlZmVyZW5jZSBjb21taXQgNzkzMjA3YmFkNzFjICgieDg2L3Jlc2N0
cmw6IEZpeCBhIHNpbGx5DQo+IC1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgd2FybmluZyIpKS4N
Cg0KSSdtIHVzaW5nIHRoZSBkZWZhdWx0IGluc3RhbGwgZnJvbSBGZWRvcmEgMzg6DQoNCiQgZ2Nj
IC0tdmVyc2lvbg0KZ2NjIChHQ0MpIDEzLjIuMSAyMDIzMDcyOCAoUmVkIEhhdCAxMy4yLjEtMSkN
CkNvcHlyaWdodCAoQykgMjAyMyBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4NClRoaXMg
aXMgZnJlZSBzb2Z0d2FyZTsgc2VlIHRoZSBzb3VyY2UgZm9yIGNvcHlpbmcgY29uZGl0aW9ucy4g
IFRoZXJlIGlzIE5PDQp3YXJyYW50eTsgbm90IGV2ZW4gZm9yIE1FUkNIQU5UQUJJTElUWSBvciBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4NCg0KLVRvbnkNCg==
