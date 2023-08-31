Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261078F1AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbjHaRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHaRFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:05:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699010D1;
        Thu, 31 Aug 2023 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693501479; x=1725037479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lD99mSY6nr+V47i9BKj2YjWctCPcaRT7feGlSoi7AwE=;
  b=ID7XCw2Ptha+MUk9vn6Ml38TCpj0aJNe/C4Ccw8CdfD3NQPRZmZRj5dV
   U7yP7AcvKtVPWl8qTs9oXjfQKeEhgqSmBCP2/Ut8Wq58FtwUGuX6tzF1l
   dOeKXOujHChXJ970XQH6/hH2GQlyTJorB4kpuSoZomxhR74EIhUdtibzG
   unBugpwEFlLlQ64BAMQaAat0Amv7D/5HFzqItaJe4/XRFNA09YhqLQWAm
   GOi8a09Qdh61or3OOZ4kuR5EDOw/oTgxBsg4lPHX3Hf9Rb4ePCYd4WsVU
   TAuWknxprRinZn+4NdZHZ2Bk/+z+8QWAT0N80gPP6eE2tiO0YMzgfi7dl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442399800"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442399800"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 10:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829776494"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="829776494"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 10:04:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:04:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 10:04:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 10:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAvryVzhd3CpWgZ0mWT+al2CJzt587f553FFsDOP7JvPryBxkEAaJsCnY+NpEfm5HvTv2G+n1Gck0k39DVp3ZbLcaBxVVFMMUCl3vTcLlglR5bS5AV7kyxP8QvyY8/pLHSpegoL+UKZdUlZHNXvDv0477Q22qzxaEwwyfF9J9hh/wRSdoXQxE4fJFuEfYd41PJCLJAP0HJnP+9vQFcmkWo2Qp54SSzls9HIkDnpoY9Fliy8fAZ20nEnHUAKQAEOu4Q6pJD/c7xJLvEbK5RX2FlOgaWuBMUYL6krh6l/2DVSot9seAY+3A0CYkFwF+jCBMH79ufq3R0+jvlfFIarTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKWMRuS/rVdqzViWVBGN682PIzQw9aQ11XdMgO8Isuk=;
 b=am70O8rTe94GFUQnsjcFV9v3F5KVGn7tgsQvu5nT0F3qfcr3sC+/4FAercEzT6wGs3LhoLdVPhQmAWuIB94enBPaQh51csjsLIYSbdNf0bGoAJLLO3slb8Z5czZZXizt5QSt42iFbaifcj41RJ2Q1mJH/plteC5oLtJv6o9V/4GgGvvXa0l0jYxQcqi7xfXwqN2caOpOq1EBibLY99YI3NGNtnLmoSzYcieId5KufHb3W/BEgN0sZfKXlK6HLzl4Ys2cq9ekiXB0tqIfHB+zRfMIvylNPrXJAvdrGTuD4LpEBme4ai8lxcPJGVHVGQoW69OX00xs51uB/rVcJmaTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 17:04:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6534:8c04:b4c8:33d4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6534:8c04:b4c8:33d4%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 17:04:31 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Topic: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Index: AQHZ2tLQzZViQZuDwEGXIVxBB0yNB7AC0IKAgAAi0cCAAQYZgIAAqlXQ
Date:   Thu, 31 Aug 2023 17:04:31 +0000
Message-ID: <SJ1PR11MB608325D10C22A7EAE1C31C42FCE5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <frfa3olxop3xjnouvvv7y2s36varmto5qwhmkitvslmiawzwkd@zh2jhob4o5qe>
 <SJ1PR11MB60838CA98A341F59260BDE18FCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <zulbpqdmui664qflvo3fcw3wnuailsiwkjtfu4xr37kutdoagy@54z7s6hud2vf>
In-Reply-To: <zulbpqdmui664qflvo3fcw3wnuailsiwkjtfu4xr37kutdoagy@54z7s6hud2vf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7859:EE_
x-ms-office365-filtering-correlation-id: 3d00be8b-ab10-43d2-f7fc-08dbaa445824
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zt5SNqb1R96ur+NiIDBdo1MpbIu0fH+Abg2jI0zkLLup9/DDZtLMLPIbdo8BTrjVFVwJHl9ZHg6f/BAgYZL2Sjrkx2U5e7P48CHyLY9mgJRzOyfLU2U0KD+madTUeNvqKkGtZEhNlBkI7dOyxfWwsM7ZFt8+EztZtOAZeUEyIr17/3eAevITV9PuIymzQUZOkhIRUS90FhkE4BZZAAhyB8man3LnamoVPiMawujaajCO7UOnjj26FVLUUSBwHu0WOrj4oWMEQrt5l1WPRuxVuWDWa2ut4QfUfL51Qogqr2R2WT3pZ10Rig30h7C85o0bHvPhb165bPMV7BaVSE0GN6iG8rCTTw5f6l1PX6yNsnsVJLL49bE9KbYaWxgr4pS7+hEFLAgCL+Y2IoF2asAopfNhQu0FylpK6+egisQ5UdQkPJa4B4yl7NAeEYBwsQ+i0G2OtKwRLHU68zYqTEVB/jtb3Q6r0/EU+vsO3CzzqpmBFiRqKIxV2eJ4/oUdqaXTJPyUSacTNkX9YgOybS8t7DUhpG2eBm6Yr0io+fPVjLw9VSnQ7UHnUdOi4zAMLtju25SSbpw21w/gmw4+PT1IfheUiJzqXcbI/bF/EQsy18N2hlJQCu3sWr4cpKCayvYn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(451199024)(186009)(41300700001)(8936002)(55016003)(6862004)(64756008)(66556008)(8676002)(4326008)(478600001)(66476007)(71200400001)(66946007)(76116006)(6636002)(316002)(66446008)(6506007)(26005)(54906003)(7696005)(9686003)(2906002)(4744005)(38100700002)(38070700005)(82960400001)(122000001)(52536014)(5660300002)(33656002)(7416002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vxtRESb/vgHgVT9a538ckQwCyajWbGJJJBbeG4Rbmvjd+b3YxGEXvLd2pFGT?=
 =?us-ascii?Q?A91RR7M3m4G0U5nnEuogg1AY/WIPyNW2d2xetIF28QHa3d0jK/BvcOxS/bJo?=
 =?us-ascii?Q?Lk1x1y1soJL7vIsxn5x+/0Oo/PIK10P1MvLw2OoCjpF6/r+q0p81EaGoGxrj?=
 =?us-ascii?Q?0Ujbqh9hXQ/Ks/ECDHWFcNp8OocbE7ioo/ygxVE8zqssOibKa0OE4tTMJIqx?=
 =?us-ascii?Q?9MTeRfkFP/a5ziDmQJG74ekEVQuJzqZMv+bLHCEpKSvnm/LW0uxeZQjlnGJk?=
 =?us-ascii?Q?udnEqf3ROeNs3dU6jn877Dhm/C+vk+GdP0Pa2N/HS8FBpdl+INGu2mpQHDmD?=
 =?us-ascii?Q?i9lTZPo2ykrvabgNQSYzViJ0BXRZ9z488LoeZSJBiD4E7toxnbq9NC+Hqm0K?=
 =?us-ascii?Q?HidDPvKKUSxukjszs7SmKEzwCPJoUqJ2OVT8yTgCUBi7cIy20z9tM/syWI1Y?=
 =?us-ascii?Q?2myUQrGMtt++OlU8RfO/U1zCLGZ79wgU+e1Zj7b4HoMtqJ7JhfHRXj2SHqEC?=
 =?us-ascii?Q?4TcjBHAbwJrEfcIeevsDP+ydRhQOz0UgwKmahoRBbwy6f8Yer/JxaDXunhEE?=
 =?us-ascii?Q?oUZYyAzozAVZUbeWn6yi6gwFTYiJAC7Q7U17x9zx0lCRe13P9DabxGp806jZ?=
 =?us-ascii?Q?KcrNkfVaHw6F2z99STZxr8tG7YAApE/b4grSA4g5QRyiYRcqqFwqWBZ1jjdU?=
 =?us-ascii?Q?A1fl7I8AVHRl9EoIqNHKqvsbVjrJFf1UipDpe+Mhvq2YBGInk4s0owZby3ZQ?=
 =?us-ascii?Q?Sn5ZiiisFrEK2poTO8O1/KE3UADnqqzwQphnpn6FqdtSS/9LcrZYvhEmXcuc?=
 =?us-ascii?Q?f0aJpCLaZxDsCxwL2UIgWmIV74fEQM4q32Kx1aJGATEwNAdt6YCS8o8Q43je?=
 =?us-ascii?Q?14ojn+QsRlNc55V/xw9OEltzkj3+rIW7zWX/sj8l18IDyWoCfEtDznugtt9E?=
 =?us-ascii?Q?ffWFbczD5sEdfTLpl8veQFO/yB6zohwQboZN33ZUGMLyTYyNeHT1GoIQL1fk?=
 =?us-ascii?Q?Lj8B/R2HVVf1/srXXYltGWDW9jXU3dTVoULy2weh0gVqGKTXEoUe1Q38uVrV?=
 =?us-ascii?Q?hZo2PQPUNAnsLwBHQBfj1IdbucorwlXzKiNfTF5hmhTPIqjIVBFY9pbRzADg?=
 =?us-ascii?Q?ElM+Y74JBNd+pEZAY80QQYQy8dgCnOhXMFgbebFhTYckF++yFsw0kySr/JFF?=
 =?us-ascii?Q?Ye2lW8L8pVOjuwwSSmHh2lVmgbr0vhS4Q2SaC19OdLsNEYO8pf0eVqJ2ox+7?=
 =?us-ascii?Q?pwEzIPrtu2FyLmG/GRifzJrkTyeTtzAYm/K8R8Cmx4edkWyjx5d1Bks+D/7J?=
 =?us-ascii?Q?sN7gcjT0C9VDUTbnIQ8kGvN3XfoD3LV6EEeLKfkLno9NbvnRILa3GKZEoOlz?=
 =?us-ascii?Q?WiJ0DgmsiXVPZW3tqqcG6BONBdNFE76gMdFwFqW+v9Vdvb2oeiUdlufmwsF5?=
 =?us-ascii?Q?eMAyVDmBGPJGfePzMzRkssTtbRBjSSaBxbOtEPUMXLJiwm72XzXF4OtY6vCn?=
 =?us-ascii?Q?7L7/wbvUdVYFtiKqTG/WCuEbIqc3xQ/PQUIx/t9hQ63m8OAuUNozuoiAF6tr?=
 =?us-ascii?Q?DYzXWoZcLo4UPF1LiIA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d00be8b-ab10-43d2-f7fc-08dbaa445824
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 17:04:31.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5M1H4GTIRCS/R4eKHLiASz20+SVJCtzcUhcA3Wnd3/ffzm3kQ4EnQWqVuaW56a0klo8T1KACfPdkeDpTip4N7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
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

> So it would look like this:
>
>       while ((fscanf(fp, "%x", c)) !=3D EOF ) {
>           if (c > 0xF)
>                   continue;
>           count =3D __builtin_popcount(c);
>       }
>
> Are there some problems with an approach like that?

I think I'd prefer something that does more checking on the input
(e.g. the hex numbers are separated by "," and terminated with
a '\n').

If Shuah Khan doesn't like my original patch I can re-write
to use fscanf() et. al.

-Tony
