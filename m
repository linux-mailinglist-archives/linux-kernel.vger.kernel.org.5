Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BB7FFB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376424AbjK3T10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376442AbjK3T1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:27:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A910E2;
        Thu, 30 Nov 2023 11:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701372448; x=1732908448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c3iTxTFICXNgH8JQsAiclqo2oQruypDWBChO7fVEac8=;
  b=GxG/WdO5diDE05Kks5/S7kMudYvlvlkGBxZIyE0iqLiR5i0oTAlJEgVW
   swwSJuRIZkwu8sLWhBHF20NRTZHF9ilnESBMVAq+uxKl7YpGerDbsHj22
   HfCSifaXL6Q3tKpa6NMYlbZZgW4RWMid2t8MUTGeOU34Scyv4CDNZUWte
   CGE23UMuknsinKx159K9BdnkV+zz6EpGEP1dKnBqJmfOjNki+8DL7EAfG
   /KaWUHTvtY07zCi35mtATUMGiykZhIqhS4skkBNR6M4vqqBo7x/HKIZMG
   WQyWXlTgHecUOhgDTvf8yJ+YzxtX0liK+yoklCMNeY+i65wlF3HoqMDAl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="14930306"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="14930306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 11:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="839905093"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="839905093"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 11:24:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 11:24:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 11:24:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 11:24:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 11:24:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Byk55RuFxT3Dv2+1CAM4YgohM4vXj1SW/aV2KEHCbtlsTYqb2VxUKWvkI9zGTa7jVsM3FnMUgFEm3LFl7ZoZkccyCLwxjNEDI+Uq9O7TTeYWLO+BiRKWIg7+r79KlkQp3+BJFD5JbpHdOAyRUOSf6uqjQGwZKqYJ+q4/ppOo+LTTR3vIGMMa/pOf0qXxfoFOSE6bWQeT14HWC0m+TD3YD8sA3dB1zEb0LX4ed+ye9Av/zqHHJ1PVJVH/dv+mPjI9TV/eRPMSuurKYrYuNOONCGINOe5JE3yHc9h+lNwxK6J9wmetCVr7zpocb+HkM1xFCvyvvBW6tZM9r3ulqRfg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QVkVz3WUwAdKyXEw91uhzq1oKZYvfsz3qCJZhbuxFE=;
 b=HhlNaIxKiuhGS2m6UMoR+HnS7d7Jaxbh/DxhGq5MYd0feggNn5Z7xzFwkT37Te9CWoVoBNiMkw2tqiDg+ThyiNwo4tlI1fbXZ6mR+ToPLRmgi4P4PnOSNCh0yBjWILgMNVgBzCdbXM9sZicwQicAcWXiBMgvJBA7TmF1utS2/IrXNr9T4T/KmYOFC/n7ZHRixJ5ehgqFnb3R60I2r9rxs0bVAc875r+31NsQg82WdZU/Q7XkrM60s2kFD5vpzo/Kz+SeWdV8twDmxeQQXClUHl6YUmaMS/j2lyH3FwynIVq/vRj6VNkBBMHGfy57qD2+qr/SM1UZMIUD8JIEC5lG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 19:24:22 +0000
Received: from DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::2470:7cd0:273e:a338]) by DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::2470:7cd0:273e:a338%5]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 19:24:22 +0000
From:   "Brelinski, Tony" <tony.brelinski@intel.com>
To:     Simon Horman <horms@kernel.org>, ivecera <ivecera@redhat.com>
CC:     Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>,
        "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
 macvlan offloading setup
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
 macvlan offloading setup
Thread-Index: AQHaHvVgunsD0ptUWUmjt82azd4cMrCRhm8AgAHAYYA=
Date:   Thu, 30 Nov 2023 19:24:22 +0000
Message-ID: <DM6PR11MB4218C83B7A07BB833D298D388282A@DM6PR11MB4218.namprd11.prod.outlook.com>
References: <20231124164233.86691-1-ivecera@redhat.com>
 <20231129163618.GD43811@kernel.org>
In-Reply-To: <20231129163618.GD43811@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_|BN9PR11MB5243:EE_
x-ms-office365-filtering-correlation-id: f6a4fb89-62ce-4ade-ed02-08dbf1d9f50f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZ+htXUpPLBWqQbUUvraITIUcWSjHocqzC2WUAWH1vz06fbQfVvfkivsWrfjwqM3hMfX/Lpma6xn0UOtbqV1x6Au6RIprdaG+bjuHVQefPDDz6sQ/cb6Rs3MZ2G74r+LkdDGCBOhRbS/UnK1oaVex+m96KvTAxrRQIB0p7UrZunLhvxw4/oJIzOKHxC3wcZw4gbNPkeXtvN6cqOQSXbLMn6f8gL5PbX9YdlaLN+vFXDBxpLet0v/cKbqu8/Qh0CseVTSpUqQe0yOSbVpWxYKtWj7zV+mwHaIDZdtqNFoW4n8vMTJVLJaQ+m4sSNWRYgwK1w6S41mPqaLyc/1YE9oL0JZVYxZXj57G1lJ64FUg2rjIcJxkgi7zREfQwuy1k5caAONsELwMLbpdGe/fmOaNrQhqm1Rz3Rqc6K28PbTmRPE4EiGkhMpWuDzF8jJ01zBbeP83U+e4gKxNB4dpwS/fg1owP7+oAOoEe+sVafWq5ef1cpXsrl7vbwsXHsiyIQGlJBFeTDLQ56HaDzBfbFptT+zxV9nqVFRDGDUheYL2AusbyiKT2MEjR4pe06DgXFwzuUqtlYPkkeh+OumfaQJp/p6TboOsjIpqWblychR2Os=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7696005)(55016003)(33656002)(83380400001)(82960400001)(26005)(38100700002)(41300700001)(38070700009)(53546011)(9686003)(122000001)(71200400001)(45080400002)(966005)(30864003)(5660300002)(2906002)(54906003)(316002)(52536014)(66446008)(6506007)(66476007)(64756008)(110136005)(76116006)(66946007)(66556008)(478600001)(8676002)(86362001)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s/gT4hwaxTTxwD/xh/ahwrIYWNk/h+YCJQNX/+OBl5JlP7rdYqo2Kt9rOCFe?=
 =?us-ascii?Q?b/ivH4GeftCvYaFlTjPb2i0OfUdCTcQM6mgX4n1HusWY0Iz7mYHou3WIzZ1v?=
 =?us-ascii?Q?bvR4/jIj1gRVHiECHaDotuwjdcJHTQeZzAbtRyyl3sK54oXLlBgVGhgwQx/G?=
 =?us-ascii?Q?tljG2bYJbF52zOkPGJWvADOyonHvJFNs4gh5C8zFcCqikchYzscxzDqLAPNZ?=
 =?us-ascii?Q?sxQHFs4Pb35nUJIoOKy1YfvV4hfp7xis28HlDhNa4DUn1OSwuzVtTa24Vq++?=
 =?us-ascii?Q?YLBYND13gGFtTfvAn+j8Xd3ftOvt8Fxh5FhUip+WcfZEazbkTG4X47Z0kij8?=
 =?us-ascii?Q?ShubUl9xuhMeXhVs/CFyd6m++Z20SqoQ4I1Z7JoAfaQvTu3OFlDnU88HapF1?=
 =?us-ascii?Q?zKErAnc9somFDSdd0XilZOrFCiqOc7xhZCI90ZajlzhlQID0EyT4b0opfSW3?=
 =?us-ascii?Q?gj/mM+XdBP5MMl8SHt3GQoI5La+9heNqz9Hew7GxoSSu5YUsbLyXvjMROkk/?=
 =?us-ascii?Q?456fP9Lav2HhurBicihpS0hqDJNhQ8MZuQfkDQFSWXKT5FHvUby85HnDgLDd?=
 =?us-ascii?Q?F9VHPvZy8cDs1J9O96SKauAABnzXTMzszYY33IW9aQ6OFZm8BUsio02t+Mu5?=
 =?us-ascii?Q?TnZz6Uvm7pXBIClDWtCVEKkqf3Cnnc8q0TF7s3wxTnAxPvtrKMepzirjfbLy?=
 =?us-ascii?Q?f5XQA6NEdEou/aw2lhmn4Nou6ka0/I4ebw/KjoMLxq4nL5v2sAouPD6hlPhe?=
 =?us-ascii?Q?mcyesyVcAZsXsZgJj1rSoXesqGa905XOvA+KaVrtkIiqYPoHk0DxkZ+iaOwq?=
 =?us-ascii?Q?Ie5v5in8uNp5fofEl5G7rFOmwant0nnqCHHXWAU1iFXlKEtYtOdTJb8yIqJa?=
 =?us-ascii?Q?thALxaRVnCFtRxxxcD1PvGZIwk1z2p2Ma0+BOnZuelgW36dp6XV4OBX8xwyG?=
 =?us-ascii?Q?SBM1zTpGr2zjs3U/L15jweLgw0ci8aDa3UXhtJ+rfnfQT+XBNpmQE7Z1aH+F?=
 =?us-ascii?Q?9r+YGpcA+HKf2kFsugxsrFxHOrmpuyi7Hp/wGvsOve1jD69I+2VR1zZ2wNJ8?=
 =?us-ascii?Q?Q9khKYAaeAe0DzOBHFSy2G9eMNclruMKTx4KPwnZ1PuAK5yWQBcfTwjqwG1J?=
 =?us-ascii?Q?+opAhRxAqMQCeCgDmBAETDW4rh0t03SlzJHyU27+p428jgwhO3o/wR42kWkB?=
 =?us-ascii?Q?v2XFs1nvev4waBExiI2qL1BsZkUjWJ8Viav4XyyJIarP+bJJqGIZGov+tVd1?=
 =?us-ascii?Q?YUmh1tD0yDF6Gd/b/Hfac1PN0UXWYmki84reEDEhiO8EWMtjRC9c0Re+hzH1?=
 =?us-ascii?Q?/zzMZHC75pl0nAy4NtFX/QzgAT4Pn+2WySVF/FePsSsivyyV9MOpr0P6hkYm?=
 =?us-ascii?Q?rnCBcH4lBlerkDqWAJaNYnDmt3Io/Dl6ox9R2UugXOnZYlNtiinPz/ubAOcO?=
 =?us-ascii?Q?OGhEJvIP6sj9WnjHZidekkPQb7TBQh1f8Dqd/P5JEjaEo1O3jomaiRd8FIVb?=
 =?us-ascii?Q?5Y0My2WRLjduA5c9K55zDnFo738IKLF7nJAf4/wV6MqblJ8Top0hgyrGvIt5?=
 =?us-ascii?Q?kdo4RC+tmQh2Jle4RJM7u+bqr0QO3RtMupwwvOvr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a4fb89-62ce-4ade-ed02-08dbf1d9f50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 19:24:22.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MESOwF10EkwEXNLjNwB56fFO97ZtM543uowjkgcs+uYCppjrd/95LJPexrkRS/hn5ZqMxe19XTp6VeR/0JOpi/OZ1Ae/s5LTEo/zx2ZUi9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Wednesday, November 29, 2023 8:36 AM
> To: ivecera <ivecera@redhat.com>
> Cc: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>; Drewek,
> Wojciech <wojciech.drewek@intel.com>; netdev@vger.kernel.org;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; open list <linux-
> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; moderated list:INTEL ETHERNET DRIVERS <int=
el-
> wired-lan@lists.osuosl.org>; Keller, Jacob E <jacob.e.keller@intel.com>; =
Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S.
> Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash dur=
ing
> macvlan offloading setup
>=20
> On Fri, Nov 24, 2023 at 05:42:33PM +0100, Ivan Vecera wrote:
> > Function i40e_fwd_add() computes num of created channels and num of
> > queues per channel according value of pf->num_lan_msix.
> >
> > This is wrong because the channels are used for subordinated net
> > devices that reuse existing queues from parent net device and number
> > of existing queue pairs (pf->num_queue_pairs) should be used instead.
> >
> > E.g.:
> > Let's have (pf->num_lan_msix =3D=3D 32)... Then we reduce number of
> > combined queues by ethtool to 8 (so pf->num_queue_pairs =3D=3D 8).
> > i40e_fwd_add() called by macvlan then computes number of macvlans
> > channels to be 16 and queues per channel 1 and calls
> > i40e_setup_macvlans(). This computes new number of queue pairs for PF
> > as:
> >
> > num_qps =3D vsi->num_queue_pairs - (macvlan_cnt * qcnt);
> >
> > This is evaluated in this case as:
> > num_qps =3D (8 - 16 * 1) =3D (u16)-8 =3D 0xFFF8
> >
> > ...and this number is stored vsi->next_base_queue that is used during
> > channel creation. This leads to kernel crash.
> >
> > Fix this bug by computing the number of offloaded macvlan devices and
> > no. their queues according the current number of queues instead of
> > maximal one.
> >
> > Reproducer:
> > 1) Enable l2-fwd-offload
> > 2) Reduce number of queues
> > 3) Create macvlan device
> > 4) Make it up
> >
> > Result:
> > [root@cnb-03 ~]# ethtool -K enp2s0f0np0 l2-fwd-offload on
> > [root@cnb-03 ~]# ethtool -l enp2s0f0np0 | grep Combined
> > Combined:       32
> > Combined:       32
> > [root@cnb-03 ~]# ethtool -L enp2s0f0np0 combined 8
> > [root@cnb-03 ~]# ip link add link enp2s0f0np0 mac0 type macvlan mode
> > bridge
> > [root@cnb-03 ~]# ip link set mac0 up
> > ...
> > [ 1225.686698] i40e 0000:02:00.0: User requested queue count/HW max
> > RSS count:  8/32 [ 1242.399103] BUG: kernel NULL pointer dereference,
> > address: 0000000000000118 [ 1242.406064] #PF: supervisor write access
> > in kernel mode [ 1242.411288] #PF: error_code(0x0002) - not-present
> > page [ 1242.416417] PGD 0 P4D 0 [ 1242.418950] Oops: 0002 [#1]
> PREEMPT
> > SMP NOPTI [ 1242.423308] CPU: 26 PID: 2253 Comm: ip Kdump: loaded
> Not
> > tainted 6.7.0-rc1+ #20 [ 1242.430607] Hardware name: Abacus electric,
> > s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.4 04/13/2022
> > [ 1242.440850] RIP:
> > 0010:i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e] [
> > 1242.448165] Code: 48 89 b3 80 00 00 00 48 89 bb 88 00 00 00 74 3c 31
> > c9 0f b7 53 16 49 8b b4 24 f0 0c 00 00 01 ca 83 c1 01 0f b7 d2 48 8b
> > 34 d6 <48> 89 9e 18 01 00 00 49 8b b4 24 e8 0c 00 00 48 8b 14 d6 48 89
> > 9a [ 1242.466902] RSP: 0018:ffffa4d52cd2f610 EFLAGS: 00010202 [
> > 1242.472121] RAX: 0000000000000000 RBX: ffff9390a4ba2e40 RCX:
> > 0000000000000001 [ 1242.479244] RDX: 000000000000fff8 RSI:
> > 0000000000000000 RDI: ffffffffffffffff [ 1242.486370] RBP:
> > ffffa4d52cd2f650 R08: 0000000000000020 R09: 0000000000000000 [
> > 1242.493494] R10: 0000000000000000 R11: 0000000100000001 R12:
> > ffff9390b861a000 [ 1242.500626] R13: 00000000000000a0 R14:
> > 0000000000000010 R15: ffff9390b861a000 [ 1242.507751] FS:
> 00007efda536b740(0000) GS:ffff939f4ec80000(0000)
> knlGS:0000000000000000 [ 1242.515826] CS:  0010 DS: 0000 ES: 0000
> CR0: 0000000080050033 [ 1242.521564] CR2: 0000000000000118 CR3:
> 000000010bd48002 CR4: 0000000000770ef0 [ 1242.528699] PKRU:
> 55555554 [ 1242.531400] Call Trace:
> > [ 1242.533846]  <TASK>
> > [ 1242.535943]  ? __die+0x20/0x70
> > [ 1242.539004]  ? page_fault_oops+0x76/0x170 [ 1242.543018]  ?
> > exc_page_fault+0x65/0x150 [ 1242.546942]  ?
> > asm_exc_page_fault+0x22/0x30 [ 1242.551131]  ?
> > i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e] [
> > 1242.557847]  i40e_setup_channel.part.0+0x5f/0x130 [i40e] [
> > 1242.563167]  i40e_setup_macvlans.constprop.0+0x256/0x420 [i40e] [
> > 1242.569099]  i40e_fwd_add+0xbf/0x270 [i40e] [ 1242.573300]
> > macvlan_open+0x16f/0x200 [macvlan] [ 1242.577831]
> > __dev_open+0xe7/0x1b0 [ 1242.581236]
> __dev_change_flags+0x1db/0x250
> > ...
> >
> > Fixes: 1d8d80b4e4ff ("i40e: Add macvlan support on i40e")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>=20
> Thanks Ivan,
>=20
> I agree with the analysis and that the problem was introduced by the cite=
d
> patch.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

The issue this patch is supposed to fix is resolved by this patch, but now =
there is a new crash seen with this patch.  Crash output below:

Crash logs:

[  315.844666] i40e 0000:86:00.0: Query for DCB configuration failed, err -=
EIO aq_err I40E_AQ_RC_EINVAL
[  315.844678] i40e 0000:86:00.0: DCB init failed -5, disabled
[  315.873394] i40e 0000:86:00.0: User requested queue count/HW max RSS cou=
nt:  1/64
[  315.900682] i40e 0000:86:00.0 eth4: Not enough queues to support macvlan=
s
[  316.021500] i40e 0000:86:00.0: Query for DCB configuration failed, err -=
EIO aq_err I40E_AQ_RC_EINVAL
[  316.021510] i40e 0000:86:00.0: DCB init failed -5, disabled
[  316.055114] i40e 0000:86:00.0: User requested queue count/HW max RSS cou=
nt:  3/64
[  316.314535] i40e 0000:86:00.0: Query for DCB configuration failed, err -=
EIO aq_err I40E_AQ_RC_EINVAL
[  316.314544] i40e 0000:86:00.0: DCB init failed -5, disabled
[  316.341128] i40e 0000:86:00.0: User requested queue count/HW max RSS cou=
nt:  8/64
[  316.360934] i40e 0000:86:00.0: Error adding mac filter on macvlan err -E=
IO, aq_err I40E_AQ_RC_ENOENT
[  316.360945] mac0: L2fwd offload disabled to L2 filter error
[  316.423043] i40e 0000:86:00.0: Error adding mac filter on macvlan err -E=
IO, aq_err I40E_AQ_RC_ENOENT
[  316.423053] mac0: L2fwd offload disabled to L2 filter error
[  317.450445] BUG: kernel NULL pointer dereference, address: 0000000000000=
0f4
[  317.450455] #PF: supervisor read access in kernel mode
[  317.450460] #PF: error_code(0x0000) - not-present page
[  317.450465] PGD 0 P4D 0=20
[  317.450472] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  317.450480] CPU: 24 PID: 0 Comm: swapper/24 Kdump: loaded Not tainted 6.=
7.0-rc2_next-queue_29th-Nov-2023-00580-ga1c79fa9e5cd #1
[  317.450488] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5=
C620.86B.02.01.0010.010620200716 01/06/2020
[  317.450492] RIP: 0010:i40e_process_skb_fields+0x32/0x200 [i40e]
[  317.450621] Code: 89 f5 41 54 55 48 89 fd 53 4c 8b 66 08 48 89 d3 4c 89 =
e2 4d 89 e0 81 e2 ff ff 07 00 41 f6 c4 80 0f 85 84 01 00 00 48 8b 45 18 <f6=
> 80 f4 00 00 00 80 74 14 4c 89 c0 25 00 30 00 00 48 3d 00 30 00
[  317.450627] RSP: 0018:ffffc90006f60df0 EFLAGS: 00010246
[  317.450633] RAX: 0000000000000000 RBX: ffff8881067f4400 RCX: 00000000000=
00056
[  317.450638] RDX: 0000000000003003 RSI: ffff888c4918e000 RDI: ffff888c7bf=
799c0
[  317.450642] RBP: ffff888c7bf799c0 R08: 0000159780003003 R09: ffff888107f=
3e0c0
[  317.450646] R10: ffff888c4918e000 R11: ffffc90006f60ff8 R12: 00001597800=
03003
[  317.450650] R13: ffff888c4918e000 R14: ffff8881067f4400 R15: ffff888c7bf=
799c0
[  317.450654] FS:  0000000000000000(0000) GS:ffff88980f200000(0000) knlGS:=
0000000000000000
[  317.450659] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  317.450663] CR2: 00000000000000f4 CR3: 0000000761020006 CR4: 00000000007=
706f0
[  317.450667] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  317.450671] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  317.450674] PKRU: 55555554
[  317.450677] Call Trace:
[  317.450684]  <IRQ>
[  317.450689]  ? __die+0x20/0x70
[  317.450704]  ? page_fault_oops+0x76/0x170
[  317.450716]  ? exc_page_fault+0x65/0x150
[  317.450727]  ? asm_exc_page_fault+0x22/0x30
[  317.450737]  ? i40e_process_skb_fields+0x32/0x200 [i40e]
[  317.450845]  i40e_clean_rx_irq+0x5e3/0x7e0 [i40e]
[  317.450943]  i40e_napi_poll+0x13a/0x4f0 [i40e]
[  317.451037]  __napi_poll+0x29/0x1b0
[  317.451046]  net_rx_action+0x29b/0x370
[  317.451052]  ? __napi_schedule_irqoff+0x58/0xa0
[  317.451062]  __do_softirq+0xc8/0x2a8
[  317.451071]  irq_exit_rcu+0xa6/0xc0
[  317.451080]  common_interrupt+0x80/0xa0
[  317.451086]  </IRQ>
[  317.451089]  <TASK>
[  317.451091]  asm_common_interrupt+0x22/0x40
[  317.451097] RIP: 0010:cpuidle_enter_state+0xc2/0x420
[  317.451107] Code: 00 e8 12 53 4c ff e8 4d f4 ff ff 8b 53 04 49 89 c5 0f =
1f 44 00 00 31 ff e8 8b 2c 4b ff 45 84 ff 0f 85 3a 02 00 00 fb 45 85 f6 <0f=
> 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52 48 8d 04 82 49
[  317.451113] RSP: 0018:ffffc90004847e80 EFLAGS: 00000206
[  317.451118] RAX: ffff88980f232040 RBX: ffff88980f23d600 RCX: 00000000000=
0001f
[  317.451122] RDX: 0000000000000018 RSI: 000000003d188150 RDI: 00000000000=
00000
[  317.451126] RBP: 0000000000000003 R08: 00000049e9852dad R09: 00000000000=
00000
[  317.451130] R10: 0000000000000210 R11: ffff88980f230c24 R12: ffffffff940=
b3a60
[  317.451134] R13: 00000049e9852dad R14: 0000000000000003 R15: 00000000000=
00000
[  317.451143]  cpuidle_enter+0x29/0x40
[  317.451157]  cpuidle_idle_call+0xfa/0x160
[  317.451171]  do_idle+0x7b/0xe0
[  317.451179]  cpu_startup_entry+0x26/0x30
[  317.451188]  start_secondary+0x115/0x140
[  317.451196]  secondary_startup_64_no_verify+0x17d/0x18b
[  317.451210]  </TASK>
[  317.451212] Modules linked in: macvlan snd_seq_dummy snd_hrtimer snd_seq=
 snd_timer snd_seq_device snd soundcore qrtr rfkill vfat fat xfs libcrc32c =
rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod intel_rapl_msr in=
tel_rapl_common intel_uncore_frequency intel_uncore_frequency_common target=
_core_mod ib_iser isst_if_common skx_edac libiscsi nfit scsi_transport_iscs=
i libnvdimm rdma_cm ipmi_ssif iw_cm x86_pkg_temp_thermal intel_powerclamp i=
b_cm coretemp kvm_intel kvm irqbypass rapl intel_cstate irdma iTCO_wdt ib_u=
verbs iTCO_vendor_support intel_uncore acpi_ipmi mei_me pcspkr ipmi_si i2c_=
i801 ib_core mei ipmi_devintf i2c_smbus lpc_ich ioatdma intel_pch_thermal i=
pmi_msghandler joydev acpi_power_meter acpi_pad ext4 mbcache jbd2 ast drm_s=
hmem_helper drm_kms_helper sd_mod t10_pi sg ice ixgbe drm i40e ahci crct10d=
if_pclmul libahci crc32_pclmul igb crc32c_intel ghash_clmulni_intel libata =
mdio i2c_algo_bit dca gnss wmi fuse [last unloaded: macvlan]
[  317.451344] CR2: 00000000000000f4

Thanks,
Tony B.
