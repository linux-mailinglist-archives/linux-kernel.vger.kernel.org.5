Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211D7BA486
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjJEQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbjJEQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E33101BC;
        Thu,  5 Oct 2023 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696518546; x=1728054546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fuus/tHWV4+TgOmNyzvUvmfA4T3zLpKSVBdG/pzVX7c=;
  b=YM//9dYj/gYa7NmlvC3Wy7LBjRVygSLoGOyhAuaIb/CA9Q93DjVGVY+2
   pASVyLWdEWumF9OcsWi9Z5bQPg+mU5oqf7kXy+bX+gu5kuYgcovkZpIik
   3f/iph/KZy+UX/Ce45004eonTP1GEDG4Z0W91U8cUFZ+ZtZOHJBnXHbjS
   A73LiJRLwmXsPrdmh2x4Z5IuxlELQcFkhwf84Ta60aPQxN/INAzVF/SsN
   i2sa2NAPGf2W14UixIFAZBF3n7M42Rv6YyJDkhDJmxTaS/KERzGaJQmmY
   +UAqd4hJlgZp6hPbOXmAfizDmIRc2IHRK4FS11z4//BxjurhFEypNHzLi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380803435"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380803435"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781283417"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="781283417"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 08:08:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 08:08:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 08:08:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 08:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjVxeY6Hmqtjyt3CYVrtPSSOOZcBqyqxc7i6puU/AQVbPgDkHUj7qMn5RXFtmlix0GEfAhlNTW6BAQsM582BH5POWSq13EBHPyo55LuYtBruoIsHJN0ZYMw8zggNNpDr+vBxBEc4GwoZf0GMUrwmbnsKBLZKFePD38YcR2HTG/xyRvEQzk+HtVhjJD3viNH8T2bCOQmuL7RoY2vssC0Eh1EadvNbMs6TP4Ej6TMe4MJgb5dnl7VC3NiHM6tbPLaCNklVlgNhnPE7NfTso7V8dTR4xIIwZuApAudSYimwmukn+n/CNreweScrH70m1z1RwINylVk8sn6EAVf8mod3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fuus/tHWV4+TgOmNyzvUvmfA4T3zLpKSVBdG/pzVX7c=;
 b=iS5m+K8mEvILcJ7acsfeq8XkTfdZ96ctI+2HHLH+8/a/BSthk/AyzSyI1leTei1I6VXePbGgFaenUaWHABLle9IBgO0QrJiXFNaZ/d2RlI14086YjlxuSqg1pF0Uqgo2nGGAlQ+a7l0emTGCCUraLqVjUaVph+ZUYO5xArJVeRrrJj2vzQNGCKaUk6kUHr8UjBD44eW+k9qB9lBC+BUC1O8DW3n5PkSOEs6qf/bZSgi5gjwvSMwQ3U5UjjC/p/cclAo5mbtbPjs9gilNoE9QNDuyZOWAvAu0K3Abh8pEAkG/Cp4z+gOstUcDs4USkcBxqqfIzE8oIj7DzS5ZNlal7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 5 Oct
 2023 15:08:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 15:08:24 +0000
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
Subject: RE: [PATCH v8 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v8 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHZ9kDmPMTGRMpqwECfzMNRwN+gxLA62l+AgABzpuA=
Date:   Thu, 5 Oct 2023 15:08:24 +0000
Message-ID: <SJ1PR11MB6083188C577FD1067B6F7362FCCAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003213043.13565-1-tony.luck@intel.com>
 <TYAPR01MB6330625DB7B68BC63B4F67E38BCAA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB6330625DB7B68BC63B4F67E38BCAA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=8889ef1a-6052-4a21-ba9c-04c4f3fb983c;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED???;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-10-05T08:07:28Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB8335:EE_
x-ms-office365-filtering-correlation-id: 176b9195-2171-4687-059c-08dbc5b4ebe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtevpG/BxeMC8hfMxN5e1TTE+aVrSglKxfiFPD2XzbDP4QQ57DnLZjJkaRH/7csf8Ri+cwrwGcYjHNSW5e/vDcgZD9CRnjINyBZSwKoAXuQorpv6VGn/e6XGAA2BswR99ezUh560Uak+T5XoD+R5tN2uJtwsrQf6FZnz0Hi9SqZ86y3bgHDE9kuHhiDLR2SVHTLoakP/XHkvHuiEj7gwrTAVfESRDhC5i05MPfvJyHQ4yxupKIT+lSc7cdiWsw9or+QtvVGZpBpL1jbplJFo3ZWlwb8wO5gKcNwDk6hOQi9EIEyS1yfsIGrQNC8vfZhc4BwAgdti/WWTBYxe8owzMoJJTSfZ0MuN6INuxNnJ7cTua6q0QXwBRQTpwxftvF1ycoahr9F0JzlLynwwM7QoKpA9zny5kVFnScU5gR1sJ0MBWFkOdZGyN+EA/U7Pod8AshCm/RVKt1BmH/vm0isuaBNj+03bt6gT2rIIIcooJeYNYmqom39cyywplLicLKAgnqgFZoZOOR0bnOL2CVpuLUZY1LFI7W8nzMxl1U7Dn+C3MjCFpiekzlKcpCTiGUQ/rh5q2kYt/95hr3Fv9c02P0Rp7pd8XV2CTE89u5BVhdYFtDIgWbqrOM1X5TsWRhzB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(110136005)(8676002)(52536014)(26005)(5660300002)(8936002)(4326008)(76116006)(83380400001)(66946007)(33656002)(4744005)(2906002)(478600001)(66446008)(7696005)(6506007)(66556008)(9686003)(54906003)(64756008)(66476007)(55016003)(316002)(7416002)(38100700002)(86362001)(82960400001)(38070700005)(71200400001)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XNflut/yjagPMYZnLBFFgzNRREZ2fbGO2+++mxKC3ubb1K96G5LalVRP1sn?=
 =?us-ascii?Q?pTML3y9Ra2Q4v8OtuZlEZ8aWTbk3bfwv3yONfPrZTaol9wT7do19fx0ZUsUk?=
 =?us-ascii?Q?q5LapcdsrnpgdlHyEWBQzjL3y8IsLgvfnI74w3HHuebwDsCWrVd7Nxa6CCUM?=
 =?us-ascii?Q?s9atknOSHN3vc0pquBTCERCXBA9cUXMBrHvjkyujcmRqqTbPTAWd1JjXveLD?=
 =?us-ascii?Q?oxhiR2+L9HOJY3qiN3hfO6KBMNHHgb6jCgb522hvnPNaSFA4dZkZu0874P3s?=
 =?us-ascii?Q?O2U+EHymaYFnMCmnb1XW1SI3jhP18xdZULrZl4IuT96R2tOGKtJ7NJerIxJv?=
 =?us-ascii?Q?glfIqa3H+LSk+X+6uE0dU1cILKMG+ST8+2kf1WVy/iBC0D4xapwvETYgkjLw?=
 =?us-ascii?Q?+3fx5uaY6z9FLco8ghhkKF+r5pEA8jfT88DIsmWpzw5ewG6xDf/TTfiULCgO?=
 =?us-ascii?Q?1scDkZ+UbeWvxNrzIOHbLA6KzyrX3vK3GhtiXLD68NuskKF48rw7IYxTl0Qe?=
 =?us-ascii?Q?dgxMwW7f7am5+IMqUPKHBOudLr2LtKUmXJWyiaK/TsqFy+sjLZJAxBq4CQnK?=
 =?us-ascii?Q?K/e29gHy8+uq2MwmCP6oqh6mvXTOUVNgW8KIa6bcn5VJhjX8RWN5SgitfOem?=
 =?us-ascii?Q?/FUjMAmHKP1oHfGOSjrXBhWwV+YzCuffp1tZBy9F3nWg/hrMmjePNW8XpMLb?=
 =?us-ascii?Q?YGu12nWyUAio9q8dzLMZfD8Qr//XuDVzxHdcMsgLkT0swL3kGL6sk7PdEsvT?=
 =?us-ascii?Q?YdpXVb5kEc3LyXABYNdSIK0J1jy5SHDubYK0upGPNaI3FoLwr59cnz5IwU4w?=
 =?us-ascii?Q?4zqgoyg5UKGtsyDZoNpx1v+Za+W+63SkN5wMXEwM0xhVYjI4NYpIy/OBMuj7?=
 =?us-ascii?Q?qVRH83vCESc27juZAdVwxooDj5wO2AZpe8H+N6F9LwXrHJodNa9RvQfj3iGQ?=
 =?us-ascii?Q?7XD71WT2de4QnPgmSTJjwOWNtvFWokmTn5d2Bum9dvMwJq4B9d7VAJQ99N97?=
 =?us-ascii?Q?xAk41Cm4ihjok4XB6Ea4WG0/4VJsoyJxObmWu8U0ZsAzJgipDmDs7hDTkCRq?=
 =?us-ascii?Q?uQZVFMpmI9O66eVrHupDkX5OJsZsd5dtf/tHlyEIQosZi/EEpDi9hhxhiLIX?=
 =?us-ascii?Q?81JFdgof4RIQpH6+C+D+0ApGSD3Rspu05u1tFaEEGvAECz0Pnw2t2hK7CPxq?=
 =?us-ascii?Q?yViIygLIZHEd4b0o8tmc7yUgVlrbroGezSht1LuxV2AaXLUP9vjnelyjGSz9?=
 =?us-ascii?Q?27DFqgE6/hQoTgqBPr2n5cRzkRRQQstECQORmN0GK+ef1yXCEk8kfwqOirK2?=
 =?us-ascii?Q?fHNp3hdTrDVG/Tdff21W9Bun1yqs5t99oDJFgakt8E5VNVxjwkg7Lwkrd/de?=
 =?us-ascii?Q?pXGUhuJF4tn2Pwwb0JseS6M6wgj9RyrtqKKOa4pumSeSZkwLrYqOJT4deEQA?=
 =?us-ascii?Q?5rJC2puzljVC9cTVE4wXKkidBgjFb8W/5nsaYE+6lSJ8dsBMdoVhkTowtCpm?=
 =?us-ascii?Q?IrQAJbT7jtsDkNI6UakDfbxF1iJroK/e4/rjnCK8sa1Nynm2qkBw3tmOMa7G?=
 =?us-ascii?Q?CYJUUCFKzdNFVeMt077lrIWJyTmwquoCict0noVR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b9195-2171-4687-059c-08dbc5b4ebe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 15:08:24.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBY2yoyS6pZE2IlFYqrMPUHn1zU4XYdtjh/tmNV9rm8u8ww0yqzve4ata+JP2OTd7Ib46jmYmb/qooLIUeEqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I applied this patch series to kernel v6.5 and v6.6-rc4, but the kernel c=
annot be booted.
> Could you tell me what kernel version this patch series is based on?

Hi Shaopeng,

Patches are based on v6.6-rc3 (see the "base-commit" line at the end of the=
 cover letter).

Which CPU family/model/stepping & microcode are you testing on?

Are there error or panic messages when it does not boot?

-Tony
