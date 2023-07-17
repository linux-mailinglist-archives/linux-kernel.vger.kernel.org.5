Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D77564E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGQN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGQN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:26:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA2E76;
        Mon, 17 Jul 2023 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689600392; x=1721136392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JudSg3tEKuZKL5TAvWctdfu8IY8IazwQspec4Xvl9LM=;
  b=DDdZ7tGJ7nHca/oz8lCkfOxqpne+mr0c/vFPm0qxFT5hojeLR6vEOiKi
   HdbLDu9ccL37o/TXdElq9VMu+F1eGFfN/oCX+tkPceBL5Oxz198iQqmRz
   iNdQLJw250tq3N4KGCFRsS/oOloNiM9H7E/D6MUGf/K6LE+omlPaP1LHP
   ZKQSdu/qGK92jbWWVByVNthWlK+NX+Jl+djCa4F4cWXNKU/3pImQ0kkFY
   HXlXMb56AW9QHIU6CEZLPyAW3eqdal4RBZvBfsW6JT6G2aumC/E2SDHcJ
   w4PaQ/+nWSJmYZ+EwOvc0InwrJZryZ9V42K91uejibiIxQYhEC64+6ErW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368571543"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368571543"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793249871"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793249871"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 06:25:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 06:25:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 06:25:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 06:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixOz2lIkOHdr8tyY+AvHsv2Vkj5XdgFsyZawQh4khugC67dYMujzfU9yyeIoIJ/Nx14hEsBGCo7VXT72Y9/GZuPXPvYCQ7uzEBaeIzya3x5DGiqYgllOlUG9IvjVntNPXSMIFbHjItSmw3jltXBFjucAdYjQDu+GwQU0TmW/w0eMFpg0XqV13IoKO5K8ADsJYBWKQrEhcvqk2U5kpwG4x79VksyoUAbK0m1ohY0xfx4/yp09x8JEZTgWO/mI7iB0CczrHTtG6R/94OF5HINDs07GFfyP7m9Wo29CTq7Mu7WtEoHwUDO+wqjfn72ds24UF/xbxosX8BK1VNYOvkW7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4kkSpT8p380rHIV9SQfrtCpGcub/t5E/bsu8dWZlvw=;
 b=eKBK/yakEp6neYh2CGRm08DCCWvxKZ+Cfc1B2ZQHpppB/3SjZbvI6CMrpYArm0hxMS4McyF8/8kbBVBTU5cl++R8x1LFT7Gz1Nmc9IAKioU2hxH8TLDR/Qv3bMyTlZSEq3uiOaheQmCToMTLSslLt5jbRErl0CH8JdpDHFvRvf1VtPbaymOfhS0YewSAC2gS9c/NtOW7qVuwmxXHbzZuVKikkv/O6sNra8JDNEpYKwbpPqvG7G0ISVkBm+mBTJKqR0pSW5yHMRnZVuQ2LwQ1JxTFYdnVztUmBmeaJm2xEV3vD7W7jOU9nJSnpvbhRyr72ygo20/qIViny07PHLsorQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 13:25:53 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2b55:774d:2fd0:59a9]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2b55:774d:2fd0:59a9%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:25:53 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Ding, Hui" <dinghui@sangfor.com.cn>
CC:     "pengdonglin@sangfor.com.cn" <pengdonglin@sangfor.com.cn>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gregory.v.rose@intel.com" <gregory.v.rose@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Williams, Mitch A" <mitch.a.williams@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "grzegorzx.szczurek@intel.com" <grzegorzx.szczurek@intel.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "Kubiak, Michal" <michal.kubiak@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v5 1/2] iavf: Fix use-after-free in
 free_netdev
Thread-Topic: [Intel-wired-lan] [PATCH net v5 1/2] iavf: Fix use-after-free in
 free_netdev
Thread-Index: AQHZgmcwNKHdsV2mXEKG7O4tyzSJo69R8q8AgGxsxuA=
Date:   Mon, 17 Jul 2023 13:25:53 +0000
Message-ID: <BL0PR11MB3521A84A538B26EB6CD287A48F3BA@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230509111148.4608-1-dinghui@sangfor.com.cn>
 <20230509111148.4608-2-dinghui@sangfor.com.cn>
 <20230509133958.GL38143@unreal>
In-Reply-To: <20230509133958.GL38143@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: 5ba7e78b-3282-4b62-333e-08db86c95870
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkjQtv1WAS9bkysHiNnV+8Oo4v39lABojE42NdwJC7siHjpB011r9jHNa57SaUlXcQmiexaoN6GuxLl3deHPeePK9RjknTE7lcZbZdpprp6lJ30I7cGSOfuDZ8ntdf08a8+uyZJrJzAWvIn8ke0NEbAOmX7NZk0qkwADarILwdIFZVYc4KV0/8mdV/kut1u2U6VJQH8vLBDZbBbaKv3b7PvIz8q6XLOxTzKh16yc1dwSTIWpOWYnmw8ygsXOw1M9ADeY3P82/e8FYoGZJgP6vZ/A3RUeBsu+/d7TTch0XsGRQ7ixmo7hRtGeoJIT3Eo7BTHQm5x6GO1JcYn1w1BtTpMihe8nVGG5YmIvOcNApV3LrlLfdHh79qfBjqSttLJVhBNx4o7T/8WrtiJJ66Fa7zapuPX9MfLNyoF0gTtdPpG3AsqV+2fQzXPWNS64olBD1GvE6IjdKfYnUtTsDFyc5WsVEx5dnr1dQ9U9s0cZPnFKBebxXZaTa4K1hUMcrU0IzGZEh+5Tvgt518NBdzHZxOUlXnrWLHzvkIHNLxgEdoev/56pTJYZYt3+RuuKBM+PlZgkiwx0ZheginfMiEolgq4lLFZ4BaEqlFTcWlRYQkc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(110136005)(478600001)(71200400001)(7696005)(54906003)(186003)(53546011)(6506007)(26005)(9686003)(966005)(76116006)(2906002)(41300700001)(4326008)(316002)(64756008)(66556008)(66446008)(66946007)(5660300002)(52536014)(8936002)(7416002)(8676002)(66476007)(38100700002)(122000001)(82960400001)(33656002)(86362001)(38070700005)(83380400001)(55016003)(84970400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3t7EJAnSjNBJJTPGjPEwn2C0MeQFkacu8UlfoTYkO15O8iT5MBnC+L1FC0BM?=
 =?us-ascii?Q?5yIBmWoDTzaAhK3fjhcryu8Vs5ka2tyJG4vlxbgMZNf9e+qdd1z2sLLG3qea?=
 =?us-ascii?Q?/0ZOYdnhS3aLhJRyh9d+TVT5yZYjJgA2JaSas9NZdlvP0BWvboA5bD7sJ9vv?=
 =?us-ascii?Q?yxdieSZCezBb8ZGrhbUkP8XGp24MEddRo4KHQAKi27Wb23csF25jNxmZwOy8?=
 =?us-ascii?Q?a4m+yhS6LrP1ID5d++7u06YUNuahusIOKowLLZknX+04dW4xr4ppTm7FesZq?=
 =?us-ascii?Q?/trgbmdGzOxUNQlMiKKh6IiR+HwzJuOXU+9AYXGT86mUfVmW8eyMvz579G9q?=
 =?us-ascii?Q?tZaFzMJ7ppJpSq7mNPoiTtkUHe/ey7xzUt/x/7uWAZgXOlo7rymodfOBQhTz?=
 =?us-ascii?Q?6GnV0sj6YtxRd8q1tKa+qpP+mno/kPhJzCmGevhgswqKW+9i1cLW8aONoWmd?=
 =?us-ascii?Q?6d9f8zRU5df+RzFBW36AMXG5epduSGlxe4iw/5mn1/rpyUCMhmOP2rGfKHxj?=
 =?us-ascii?Q?zup/7x2Hyg8sjNO2Oy0+d3wuiE3xFkimL/SUqVNOQaewOvJYGW2x4hNFTpUU?=
 =?us-ascii?Q?pP3WP/S3gzSM57bojq94qeVt8lb20AX0ePVikiJ6xBD+wSHHtQ+HNVSOR6+z?=
 =?us-ascii?Q?CeIBjwVXPXTajaWr467UVGpO0yQ1v4jws5w9ix+7MzZuK/jpafmEAng509Ed?=
 =?us-ascii?Q?Wc4yFs3oDYICT7r930z4v1XZn55fP68VtSfW7azmsJSSs/+qfZuzaZ3KD6DS?=
 =?us-ascii?Q?oMee0UpVjT+6U7tSVng2+dpJLfMfT0Dvylu6WDmrprdkbOH6oEJFphcIvhJt?=
 =?us-ascii?Q?dyiMf3DVuxiQmlVWAZvJV+IwibuUwXOytN0JcrXckSssRerYf+6wjzhmD2um?=
 =?us-ascii?Q?D2rx077lHXR1rFrVk9RjgKeRv4+cFI6p69KErIaYc4QiXsrq1p19ctQ/Ae6R?=
 =?us-ascii?Q?Dn0LuXPTzQDastUBQ59TS+jsWRAHO+4Tpy3N5Nrkol6ABh7tSPxYvqSr7oZV?=
 =?us-ascii?Q?E+yc21l99OJoWcR0z2ClKzW6khSuDX9XlTMvIXCfURl0e6TztNCkI9vSWUmA?=
 =?us-ascii?Q?QeY2eMSmCMHV1LqL78/sUgVveDHy5yurplFQAGxJmzqDQeixMGEV5phpu1h6?=
 =?us-ascii?Q?cWMJ5ZlD9Raf0YQ4pNprbaCtbDC+JJ8sT0xnGSwiH88XbcIv9G33m7YVnjtm?=
 =?us-ascii?Q?JowegQ2TkXYOkyCjhWBaWMx8uVj8mfoLtZdsYrNibFjgY7rwJ6Vw7G0S7Nr+?=
 =?us-ascii?Q?QSgbx4+36O1y73b52h9uAkTZ0OKMYel4Jr16unxWMKRML75vdGui928t0A+q?=
 =?us-ascii?Q?fx3dH/nYj+hPgeShAM6zCrJn+WRE/i2tfAsgcuWTH0XLCGhykPSwmbwVnfXS?=
 =?us-ascii?Q?smIwxOac8df1CscbaCiZkU4Qibxb1Kuxp0yskykoPtxhmzAJiflKoCr2A2rp?=
 =?us-ascii?Q?mRRYKwHTcH174zz3r5IeSXHYVryWmfGSrF/jRB8H9CGhGnwAV5Ui/OoJMUNt?=
 =?us-ascii?Q?gZK1QOpVzX0G0AZcz23wYg6r8IN1WDU1EYfKIDY0sE1ud9FWYumXZnprFMCM?=
 =?us-ascii?Q?RyG/MTa86huIdxrRxdqmInZRyJd95l+LDxRkz9sAVS1MA11jN6DsfEDekq0X?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba7e78b-3282-4b62-333e-08db86c95870
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 13:25:53.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yyz11bmiMAAIRaWr9CXWecL5QTw5+mgbrnsmtiqPirw6HhCP8Dyi14MedqbO/luAPuCo+R5IKZGZCtEul3TagvEvCdxkawlnx3n5mOf+9jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Leon Romanovsky
> Sent: wtorek, 9 maja 2023 15:40
> To: Ding, Hui <dinghui@sangfor.com.cn>
> Cc: pengdonglin@sangfor.com.cn; keescook@chromium.org;
> gregory.v.rose@intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; huangcun@sangfor.com.cn; linux-
> kernel@vger.kernel.org; grzegorzx.szczurek@intel.com;
> edumazet@google.com; Kubiak, Michal <michal.kubiak@intel.com>; intel-
> wired-lan@lists.osuosl.org; jeffrey.t.kirsher@intel.com;
> simon.horman@corigine.com; kuba@kernel.org; netdev@vger.kernel.org;
> pabeni@redhat.com; davem@davemloft.net; linux-
> hardening@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH net v5 1/2] iavf: Fix use-after-fre=
e in
> free_netdev
>=20
> On Tue, May 09, 2023 at 07:11:47PM +0800, Ding Hui wrote:
> > We do netif_napi_add() for all allocated q_vectors[], but potentially
> > do netif_napi_del() for part of them, then kfree q_vectors and leave
> > invalid pointers at dev->napi_list.
> >
> > Reproducer:
> >
> >   [root@host ~]# cat repro.sh
> >   #!/bin/bash
> >
> >   pf_dbsf=3D"0000:41:00.0"
> >   vf0_dbsf=3D"0000:41:02.0"
> >   g_pids=3D()
> >
> >   function do_set_numvf()
> >   {
> >       echo 2 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
> >       sleep $((RANDOM%3+1))
> >       echo 0 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
> >       sleep $((RANDOM%3+1))
> >   }
> >
> >   function do_set_channel()
> >   {
> >       local nic=3D$(ls -1 --indicator-style=3Dnone
> /sys/bus/pci/devices/${vf0_dbsf}/net/)
> >       [ -z "$nic" ] && { sleep $((RANDOM%3)) ; return 1; }
> >       ifconfig $nic 192.168.18.5 netmask 255.255.255.0
> >       ifconfig $nic up
> >       ethtool -L $nic combined 1
> >       ethtool -L $nic combined 4
> >       sleep $((RANDOM%3))
> >   }
> >
> >   function on_exit()
> >   {
> >       local pid
> >       for pid in "${g_pids[@]}"; do
> >           kill -0 "$pid" &>/dev/null && kill "$pid" &>/dev/null
> >       done
> >       g_pids=3D()
> >   }
> >
> >   trap "on_exit; exit" EXIT
> >
> >   while :; do do_set_numvf ; done &
> >   g_pids+=3D($!)
> >   while :; do do_set_channel ; done &
> >   g_pids+=3D($!)
> >
> >   wait
> >
> > Result:
> >
> > [ 4093.900222]
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D
> > [ 4093.900230] BUG: KASAN: use-after-free in free_netdev+0x308/0x390 [
> > 4093.900232] Read of size 8 at addr ffff88b4dc145640 by task
> > repro.sh/6699 [ 4093.900233]
> > [ 4093.900236] CPU: 10 PID: 6699 Comm: repro.sh Kdump: loaded Tainted:
> G           O     --------- -t - 4.18.0 #1
> > [ 4093.900238] Hardware name: Powerleader PR2008AL/H12DSi-N6, BIOS
> 2.0
> > 04/09/2021 [ 4093.900239] Call Trace:
> > [ 4093.900244]  dump_stack+0x71/0xab
> > [ 4093.900249]  print_address_description+0x6b/0x290
> > [ 4093.900251]  ? free_netdev+0x308/0x390 [ 4093.900252]
> > kasan_report+0x14a/0x2b0 [ 4093.900254]  free_netdev+0x308/0x390 [
> > 4093.900261]  iavf_remove+0x825/0xd20 [iavf] [ 4093.900265]
> > pci_device_remove+0xa8/0x1f0 [ 4093.900268]
> > device_release_driver_internal+0x1c6/0x460
> > [ 4093.900271]  pci_stop_bus_device+0x101/0x150 [ 4093.900273]
> > pci_stop_and_remove_bus_device+0xe/0x20
> > [ 4093.900275]  pci_iov_remove_virtfn+0x187/0x420 [ 4093.900277]  ?
> > pci_iov_add_virtfn+0xe10/0xe10 [ 4093.900278]  ?
> > pci_get_subsys+0x90/0x90 [ 4093.900280]  sriov_disable+0xed/0x3e0 [
> > 4093.900282]  ? bus_find_device+0x12d/0x1a0 [ 4093.900290]
> > i40e_free_vfs+0x754/0x1210 [i40e] [ 4093.900298]  ?
> > i40e_reset_all_vfs+0x880/0x880 [i40e] [ 4093.900299]  ?
> > pci_get_device+0x7c/0x90 [ 4093.900300]  ? pci_get_subsys+0x90/0x90 [
> > 4093.900306]  ? pci_vfs_assigned.part.7+0x144/0x210
> > [ 4093.900309]  ? __mutex_lock_slowpath+0x10/0x10 [ 4093.900315]
> > i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e] [ 4093.900318]
> > sriov_numvfs_store+0x214/0x290 [ 4093.900320]  ?
> > sriov_totalvfs_show+0x30/0x30 [ 4093.900321]  ?
> > __mutex_lock_slowpath+0x10/0x10 [ 4093.900323]  ?
> > __check_object_size+0x15a/0x350 [ 4093.900326]
> > kernfs_fop_write+0x280/0x3f0 [ 4093.900329]  vfs_write+0x145/0x440 [
> > 4093.900330]  ksys_write+0xab/0x160 [ 4093.900332]  ?
> > __ia32_sys_read+0xb0/0xb0 [ 4093.900334]  ? fput_many+0x1a/0x120 [
> > 4093.900335]  ? filp_close+0xf0/0x130 [ 4093.900338]
> > do_syscall_64+0xa0/0x370 [ 4093.900339]  ? page_fault+0x8/0x30 [
> > 4093.900341]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > [ 4093.900357] RIP: 0033:0x7f16ad4d22c0 [ 4093.900359] Code: 73 01 c3
> > 48 8b 0d d8 cb 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00
> > 83 3d 89 24 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73
> > 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 04 24 [ 4093.900360] RSP:
> > 002b:00007ffd6491b7f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001 [
> > 4093.900362] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> > 00007f16ad4d22c0 [ 4093.900363] RDX: 0000000000000002 RSI:
> > 0000000001a41408 RDI: 0000000000000001 [ 4093.900364] RBP:
> > 0000000001a41408 R08: 00007f16ad7a1780 R09: 00007f16ae1f2700 [
> > 4093.900364] R10: 0000000000000001 R11: 0000000000000246 R12:
> 0000000000000002 [ 4093.900365] R13: 0000000000000001 R14:
> 00007f16ad7a0620 R15: 0000000000000001 [ 4093.900367] [ 4093.900368]
> Allocated by task 820:
> > [ 4093.900371]  kasan_kmalloc+0xa6/0xd0 [ 4093.900373]
> > __kmalloc+0xfb/0x200 [ 4093.900376]
> > iavf_init_interrupt_scheme+0x63b/0x1320 [iavf] [ 4093.900380]
> > iavf_watchdog_task+0x3d51/0x52c0 [iavf] [ 4093.900382]
> > process_one_work+0x56a/0x11f0 [ 4093.900383]
> worker_thread+0x8f/0xf40
> > [ 4093.900384]  kthread+0x2a0/0x390 [ 4093.900385]
> > ret_from_fork+0x1f/0x40 [ 4093.900387]  0xffffffffffffffff [
> > 4093.900387] [ 4093.900388] Freed by task 6699:
> > [ 4093.900390]  __kasan_slab_free+0x137/0x190 [ 4093.900391]
> > kfree+0x8b/0x1b0 [ 4093.900394]  iavf_free_q_vectors+0x11d/0x1a0
> > [iavf] [ 4093.900397]  iavf_remove+0x35a/0xd20 [iavf] [ 4093.900399]
> > pci_device_remove+0xa8/0x1f0 [ 4093.900400]
> > device_release_driver_internal+0x1c6/0x460
> > [ 4093.900401]  pci_stop_bus_device+0x101/0x150 [ 4093.900402]
> > pci_stop_and_remove_bus_device+0xe/0x20
> > [ 4093.900403]  pci_iov_remove_virtfn+0x187/0x420 [ 4093.900404]
> > sriov_disable+0xed/0x3e0 [ 4093.900409]  i40e_free_vfs+0x754/0x1210
> > [i40e] [ 4093.900415]  i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e] [
> > 4093.900416]  sriov_numvfs_store+0x214/0x290 [ 4093.900417]
> > kernfs_fop_write+0x280/0x3f0 [ 4093.900418]  vfs_write+0x145/0x440 [
> > 4093.900419]  ksys_write+0xab/0x160 [ 4093.900420]
> > do_syscall_64+0xa0/0x370 [ 4093.900421]
> > entry_SYSCALL_64_after_hwframe+0x65/0xca
> > [ 4093.900422]  0xffffffffffffffff
> > [ 4093.900422]
> > [ 4093.900424] The buggy address belongs to the object at
> ffff88b4dc144200
> >                 which belongs to the cache kmalloc-8k of size 8192 [
> > 4093.900425] The buggy address is located 5184 bytes inside of
> >                 8192-byte region [ffff88b4dc144200, ffff88b4dc146200)
> > [ 4093.900425] The buggy address belongs to the page:
> > [ 4093.900427] page:ffffea00d3705000 refcount:1 mapcount:0
> > mapping:ffff88bf04415c80 index:0x0 compound_mapcount: 0 [
> 4093.900430]
> > flags: 0x10000000008100(slab|head) [ 4093.900433] raw:
> > 0010000000008100 dead000000000100 dead000000000200 ffff88bf04415c80
> [
> > 4093.900434] raw: 0000000000000000 0000000000030003 00000001ffffffff
> > 0000000000000000 [ 4093.900434] page dumped because: kasan: bad access
> > detected [ 4093.900435] [ 4093.900435] Memory state around the buggy
> address:
> > [ 4093.900436]  ffff88b4dc145500: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb [ 4093.900437]  ffff88b4dc145580: fb fb fb fb fb fb fb fb
> > fb fb fb fb fb fb fb fb [ 4093.900438] >ffff88b4dc145600: fb fb fb fb f=
b fb fb
> fb fb fb fb fb fb fb fb fb
> > [ 4093.900438]                                            ^
> > [ 4093.900439]  ffff88b4dc145680: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb [ 4093.900440]  ffff88b4dc145700: fb fb fb fb fb fb fb fb
> > fb fb fb fb fb fb fb fb [ 4093.900440]
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Although the patch #2 (of 2) can avoid the issuse triggered by this
> > repro.sh, there still are other potential risks that if
> > num_active_queues is changed to less than allocated q_vectors[] by
> > unexpected, the mismatched netif_napi_add/del() can also cause UAF.
> >
> > Since we actually call netif_napi_add() for all allocated q_vectors
> > unconditionally in iavf_alloc_q_vectors(), so we should fix it by
> > letting netif_napi_del() match to netif_napi_add().
> >
> > Fixes: 5eae00c57f5e ("i40evf: main driver core")
> > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
> > Cc: Huang Cun <huangcun@sangfor.com.cn>
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > ---
> > v4 to v5:
> >   - no changes
> >
> > v3 to v4:
> >   - fix typo in commit message
> >
> > v2 to v3:
> >   - fix review tag
> >
> > v1 to v2:
> >   - add Fixes: tag
> >   - add reproduction script
> >   - update commit message
> >
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_main.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



