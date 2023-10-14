Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D17C92D2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 07:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjJNFMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 01:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 01:12:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74FC2;
        Fri, 13 Oct 2023 22:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697260353; x=1728796353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BpdBZAiLTo61w9GVU1uEkejlDGbtSyv+bbMFj0Lomd4=;
  b=QibbNNm8d4C32UAK45XNKj68KQum+p592SbVUzogmbyNp71fLcE47kgm
   ZtZreACsl57gvV+GEUIFLV+wvIw+v2elBz5/hziO9Bb6CiyRc4uRzl6kd
   hoeA6QaF/KQMiCw58Mc18YR4jFs4gxdMRo0lG5a7l1F8XWF0YQGRlVAwB
   dd9DEeu0ZmhgTG6bYNjxAdJ1HfCxxbdInfnQ4NWVI1fBOEUOld0f7wWo8
   hqA9pdiROnO42XYCh+8om8QZFjXwIklTLXvsxSSODUaTDY07+CuCE8Atc
   j8EIrsU1JzMz5applaa/9Fu2fRDCANmvuq8lpu2xpN0uvlCzgJ+layGmF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384174667"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="384174667"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1086397148"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="1086397148"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 22:12:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 22:12:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 22:12:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 22:12:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 22:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT8LR/oSX9tZWij1R5//eDyql7ZLnI9SvEGMRnMQOrDWOePkeruxXmxycZZ/b6pu4MlQN2MseK5210YKGKTSh5mC70nUZ9iC47cigMid7pAzLXt7MJVaT35GJPklacRMu4vsnGLaHNoacuIXtmY6eV4+HgOA0eK7xozGXr+W7j2vLEXhUy9hpnFMn/Qj6k3rvOuuvXcRcr9BS2DPXDk0bCgaHPLPNkLyosBejeIST+CMQT3DLK4b3BvrA/H7wLO/h4+nw/g9soYZJCAgFDG18CJB95h0xOmhzComsRHK8NlN/rZMP7YFLX7z7xgHqzMzI6ex8X+pDdT3wxL184yetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r213hn5dfAXUvOdXfArUhwspFPfozeX7Jzx3kuHPXPc=;
 b=RyhN3+UfEUbk29WKr9nw1GTweKwzliGIGfv/mDseV7GBjvkx/WJBiNp//MXGSZc4Jbbv5rp4L+JDuxjyVwMQSBoEF/8yd/4NWBn2NfH/WIGh+JPHwM2cVX6ZiA9yqoGsO5iDh56gQaTFACoCkBfWegtij6P2V2TuXPc6mMDfAliBr1p+FD+3I+I7wGCVkw0jjoJkf7nnsq/XCi70BxhmW/C8aQ/6SwTMdv+9/ZAFVMrkqag29jD4QXV6UqkCBU0JjFd08txdFFvr2dukdOCgCE3qS6GGmGheaE0lYwK/cBSCqBd6ciw5gg+6L+uEiH7q5cyeGrzmFK6vUiZbfUYqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sat, 14 Oct
 2023 05:12:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6863.047; Sat, 14 Oct 2023
 05:12:30 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
CC:     Youquan Song <youquan.song@intel.com>
Subject: RE: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Topic: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Index: AQHZ/lso9WGwaznFOkSBbySsExRE6LBIvACg
Date:   Sat, 14 Oct 2023 05:12:29 +0000
Message-ID: <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
In-Reply-To: <20231014051754.3759099-1-zhiquan1.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6696:EE_
x-ms-office365-filtering-correlation-id: a003e90f-8c8f-41d0-5900-08dbcc742a3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rXS1SFbMM9mgRvP87Mvocu+59JL7zZx2K5Zog30Ys5vt2rrjqRCzhwis98f+m8w4qCBwrk22LEZLMgGnJIaJWsqU/wnoEOoep/qskJa9eLCzONDl9J7xldJyu46WWt9UaBOLxdZTpmIZ9ODA9xb/Mj8uQzpEQKaSvFgAYZfOMXwlZi++SG6s/hMfbGd4lo+IVrfTUDGuQcIR2JQcJFELS0KKsU2N49hVToq3T/Unl/HriWAbQvbgYcCz2j8azITdYHd/XziDnF8sZdwCh3f7y+qozK9YkOY7mTuoTZrIGCrSWs5aUGrGjKZOYmJcXd1x4rIaMGN50M9sV+93ShPOZqTJbsul/CccAvqVRVTpT7rG7//wZKs8intYfEpljUZacLDeRPcL992r/Sf2dWVoQruMnAT6a8Y3vOGd/3jZBUMs5DaUarv6oT6bTKbQwgOj2nL4bI/fDP8FcyDGRV1YROxSio0SoirTsmvOv7jieoDwN3Nxl2Oyhh1+RGe+kGz76I2XGT0J1l+yBex+gJFqiBRTdxuFq6bQ4kQmF04LqBakBpZVs8q+5irtJCqthNQFV7PeDpJitJN3PAi8zpymBhUSnV0WewXTkiVjWUfxceY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(107886003)(41300700001)(7696005)(71200400001)(6506007)(4744005)(2906002)(64756008)(66476007)(66556008)(66446008)(66946007)(4326008)(26005)(478600001)(5660300002)(9686003)(966005)(52536014)(316002)(38100700002)(110136005)(8676002)(122000001)(55016003)(8936002)(33656002)(82960400001)(86362001)(38070700005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eCkNnYDOLMlk50X7oGSlAzWl6ZN8Oxrz/XO9Twzbe9elHinglBVyKP2ggxQE?=
 =?us-ascii?Q?kzTFXO+b0ZYUw7WDNnM5sQ0ovMYsBixyMUvK2l297QR7gIfqBkjUWw1cau0Z?=
 =?us-ascii?Q?zXwj0wkM2zpLgBGInnkBJQvt0Pgg1vQ6c0fIr8TeyB3CkhFK2G322pcm6qDZ?=
 =?us-ascii?Q?VDmwA9XrEd11i5S8IPLT7yXIlz0b2n5ch5GpPhn2uIi/iH5g5rwLKeyjjTXR?=
 =?us-ascii?Q?MjOfCG2FD5hwx2KSMez0BrrmQYEd1dawd81ZRwfrk5D0zPZZHXxgbAaJRuiq?=
 =?us-ascii?Q?NZ4pXF55Usa+hJFduYl7hj9Hd4LAYYgMvFAXU7se1R98KFawCbWhUzIiBM2t?=
 =?us-ascii?Q?a8bPWqw7KFyGSSwuU9bBo0PbYdpCiYVxRhjutbCwwFhL3WCOdBbvHjWb5ugR?=
 =?us-ascii?Q?AdvJhhEvYa74NNuqqICViqIXhoglbLZEWeCNGBksaALwM0qCXrH7qukA0Cz0?=
 =?us-ascii?Q?1qNXYIR83QSZWsQ0/Mo5u07wSCrBe4Y/v81PDVJ9A+tI0VYjM7CbatYKZzb8?=
 =?us-ascii?Q?VwVy9YAxpX3wFqpJFuDo+7ou+6AkJ5y772BDMTrROs5y+d+sXCrKu2MKESSO?=
 =?us-ascii?Q?lvHK+uuAeSmMLnRpPHSESHE84uLQd3ZkiIMSLLRo/APsU2NEgR+5F3JONa6V?=
 =?us-ascii?Q?G/E9bQaBpkFX2W72u9JRoDmcWImJs2V/gHvTzpQPabhHHZ/NMvsyZM/5o4PH?=
 =?us-ascii?Q?H8qYbkcSKj1V9K3Zm7crQOxOUu6b4AgYItn+wLgqI/6Q7m1xir1mcBk5hqH9?=
 =?us-ascii?Q?un8zRbH1DXvKkBsCb2K7k3Hlf4k0IFxQpkbyqxISIlphG6qQbsPhAB2gkcZA?=
 =?us-ascii?Q?+tMfHdVvWUvOChpkanrEGNYB29en5rkeKXubGGYi0XJdLjj4/+F+3Em3QsP+?=
 =?us-ascii?Q?52YoO4IwQn4+VG5V4D0iq5iSuvAOrOd3iF7qucbtZDx3sHv3f5BLOCa+3VFG?=
 =?us-ascii?Q?+lu5DOxiGAkjEVJDnoPWkqRrIf/vXzVoRQzS6qblKzaQewinSctak/6BQj4/?=
 =?us-ascii?Q?M4Exj7jt0QVA53cZhQeKXf+cO6ELfEKvzHj08VCi8ytwLBGemEOQwBePk32i?=
 =?us-ascii?Q?bjYt8Mo+FFwb9EYeFh9q5xP/xG/pu3izyoEU+ctniLv1FVEM7GCkYYciSPmR?=
 =?us-ascii?Q?navsepDQ3fIlCcRprYR3ZrCxrDviNhfdbY1cnb0r/AMpyZOWkJQjZkNOeyRS?=
 =?us-ascii?Q?+LArGBFYiMr9BE6wKpqaBPFuM7y6ORQ2eI81cUaV2gOFkULrqFfyB7+foCHR?=
 =?us-ascii?Q?nJXWwvx/yh97DVI3EaDwaNMWjqa7MNpPDesUcwJ4DDM/MBGvNaZ0DxlJTZpw?=
 =?us-ascii?Q?dqQt8fVXbXa1Jcy7gSaGmOxN+zF5B0EVhiJ4MYsvAmy5hu57u9jIyyVyrdJo?=
 =?us-ascii?Q?0ajW4wiQHdyWOrVaINU7xnCRdfNZfId3qldXx+ZxAmEXw9KHKUxeURKss7QP?=
 =?us-ascii?Q?Nmrr63EPttTqQI43eIuzo0sz0X5B3oyQFlkpp0x1rALlO2ZgBfYM0jSNWlcP?=
 =?us-ascii?Q?dENLJLQ8vPjMZ7E74aELE4Yks1htuNmrFAOzgj4VfkeS1RcULTagXJpSaVFR?=
 =?us-ascii?Q?hCoXx7mD8pGnbQoQAVwJWRCNYXpg1FSYlpFhBpeM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a003e90f-8c8f-41d0-5900-08dbcc742a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2023 05:12:29.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1ZnWR8ii6hViRpMTJAPOz7RVwEeoK8qm5jL307g+12igfc5grJIb4t+X/8WXVbt4eo55QN67ranMafSh8UdrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
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

> Co-developed-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel=
.com/#t

This still has problems.  You should have removed my Signed-off-by. You sho=
uld NOT
have added Ingo's Signed-off-by (the only time to add someone else's Signed=
-off-by
is when paired with a Co-developed-by).

-Tony
