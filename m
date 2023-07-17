Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529987564FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGQN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGQN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:28:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409035BB;
        Mon, 17 Jul 2023 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689600452; x=1721136452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XINq3PZ9jwOhuwEfgSovvHePaqe7bFz+GYGM6I5SB2I=;
  b=AoeCM2yCV4BLFJ6BMRHUwE9eseKAtVCNBeYxS8HRhsyXo7ydI84eVtsR
   DvschTNR7DSVmPotrgutC65CunN1TFxWQFUqDWa3TtUAhN+TwAZBMrIKv
   XEvj8nr7ZFt9EvZRZ1OAbV7DgrhkUyXzJfE9dpaSbHym01WSczAtINAgm
   FkigxBtSDaH70cKIWA+s81LKy6pc1n5IpclOrIUSONn9nZOWSqWwsesmR
   I1IcxlSbCXmyj/TveeTdcGucYR8z67dvHhVinn6NCshj4pbtkwaocGDdF
   E71KwCeQkHokfE3FBzSwZ0AoMDJ66mt4xH6pws9ewE3BuMmkCC3u2Xrl7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345519693"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345519693"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1053906939"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053906939"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 06:26:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 06:26:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 06:26:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 06:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEM2knwKBelmg2nQ3/kPFEaL2xT8iK3E0XyJOoJlXcpLHV3EZvXwRx9H8tjWiSgQvIgDIlZy9uCJCDcejokYPcpeQF9HqwnHOeX7hBk6U/3ab7I3zhaQ3E3xID6M8ENYFrStZOmMk0vOuCGflswT13G8BMAEY6Mz23LFS76oLpTDp2mx5ldiy0RQevRltx/jraZXJF11o4r13D7UCh7arpPrrjoY3+FMC4FQkdJyanU9OtF0ERWUmbNBNRFyAhKqsglamaJlHoL/zO2PES3HKo6wtpF+CpZB3DZpPNmKMJSiCVarceYUtFW+nsnCPXCcrR5fmsp7SVac0qgYoNA7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3LkqjX4zc/UlU2yNvQztfXb9uSq/SJmS2EOmIyDfT8=;
 b=gmd0cgFnZ4/E02BdLqaFK8v/TRVGo+ygyyRMyirVpdKWCjqGvfaztEjbK7rSos2nG6HS8AsSrxTvvBI0jdp6ckOr3gJmNYJgN1bxt0srEqroGquQwU1MqPEsOdqZ7aRRQY4Ti8XuOT0IOrvyUkbIx7WYM91b6j48O0lj732ZnAOvTymwBGnJYEsb6C20HYhkqDNzI1A6VvX43T9xP9wEw6eIFjASLpfmwSsp84gE/pg/TOFc8EBFnOWfQFT4c/N+wE28EzyN3Uy/dXg37aITgE77N33Os+j2YVcBpq+1yljk6+BsmzPgZnRXdYAxJ9MsQ5shT2zy89NgJi+02O5IkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 13:26:52 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2b55:774d:2fd0:59a9]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2b55:774d:2fd0:59a9%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:26:52 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net v5 2/2] iavf: Fix out-of-bounds when
 setting channels on remove
Thread-Topic: [Intel-wired-lan] [PATCH net v5 2/2] iavf: Fix out-of-bounds
 when setting channels on remove
Thread-Index: AQHZgmcx3JXpn5A2Cka5LBJnCCwmSK9R8p2AgGxtNLA=
Date:   Mon, 17 Jul 2023 13:26:52 +0000
Message-ID: <BL0PR11MB35216C012485B6575D9650D38F3BA@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230509111148.4608-1-dinghui@sangfor.com.cn>
 <20230509111148.4608-3-dinghui@sangfor.com.cn>
 <20230509133943.GK38143@unreal>
In-Reply-To: <20230509133943.GK38143@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: 296492c3-12ce-4204-dc9f-08db86c97b97
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dr5qq1nNoFNtM/NvStaperHszAO/juxivmfkOa7CVWnCOMcxa2eVibmHUcmYU0b46QUI9WEgHN+SGr6JLA9BSbPlAjT2JfAvdVS61Ya5EIkldi5rqaN6fLUjYvAzyBDPq5UTB8g4T3y/SMAnq748Ujju2uFNyKZ4H2yjqN0ZvPAKSGAQ28rqV0jwYuGkL5GwmqrvMI5QO1xVh3mCYT4treoyBFP45rOr+zGGcB8C81+3dvbpSYg7db4ImQS24dx7F4lpkcpqdcTOJhmsoxhl0g9M+wilUa+JzxAJrJMfhQYltEAuOVtzjLqTEU7Mdbb7esFc7SiC80E7JcbKn9/ht113ZU+PdU2ySu2fpXZPkhMxk31QsnWmgCLH4JZKD+WSTlQbxIeBHoAN0JdpvlSha7nxLERR1lHyU74Ci7WGS4pw1YGZHoolDoZ/FjiEnhWk3vlFYlbBtjbrCJQlbkXxgLUzt7QBTtVY9U15pKqG7Av9pyIzsHzaeAWd1dlOPSlj3VzNMP2X8wwZUlwtXQdn3nkBWU6G064qhoNo2aW1kkKI/OhgveVs8L3RWjdgblKNH7mD3hTWQoG/CKmV3CUoKE+5V8M41R2vGNAaAeL+/L4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(110136005)(478600001)(71200400001)(7696005)(54906003)(186003)(53546011)(6506007)(26005)(9686003)(966005)(76116006)(2906002)(41300700001)(4326008)(316002)(64756008)(66556008)(66446008)(66946007)(5660300002)(52536014)(8936002)(7416002)(8676002)(66476007)(38100700002)(122000001)(82960400001)(33656002)(86362001)(38070700005)(83380400001)(55016003)(84970400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBtBiQ5RO9CltEEdikwr6A0l1FIXTTDH1j15BE5nVxfRqw8CkgmGo7F2OoM9?=
 =?us-ascii?Q?1xRv9TC7DvP+skTqAJMxSmfA3WEKXQ/VJerCuboMcpJsf8eoPAvHcCd4KN+8?=
 =?us-ascii?Q?mYZQEr/o1rvFS7gCTI3ktBpfZ/85PYpznM4mm+nOefeVRBfxiK2VHKJ5anLC?=
 =?us-ascii?Q?XxaYaa6StxSt+xHfWOttMXdWn2P3Zt9m7Q1ivhT3/6ZBwgWA95/lZl2lJ2IZ?=
 =?us-ascii?Q?B0ll180d3oWOAaNdJyw2ppylOI0tp6416hkzwgrfMfZnDqWrXcIUgTq+9hMk?=
 =?us-ascii?Q?P5y4l9TgqJphNfZF+U4dmln+J9FBy2Uwcz1VpzXNT+d+JyPapAc0iF0SZGon?=
 =?us-ascii?Q?rFLwULbOfsMKaE65mCTI8AnH7oVGpFKYpWucXgDcJ3uHHjhJdTuF7rqKt/YJ?=
 =?us-ascii?Q?PWvjCo++n6F7Hu/zt/aEjZIFfsZUBev9sC+fMuDQ+gpOYwVt6Tm1WX823DBH?=
 =?us-ascii?Q?ZCCdfeRd5TPLrh0uuvnp1u/SgyaPMAXtCztkuRM1aNjyYnBtb0RLg72zLqHn?=
 =?us-ascii?Q?Hf3iB0W1vKjbjA+d4GGLzClde5SNeE+k6xx+vfO806DZlY0kBVnCVfBS7Llh?=
 =?us-ascii?Q?o0JDgwm2OEX4U/JnBgX0geGaD4XTlvNDoAYfJiyXOwAs6RdyredEC7X3QniI?=
 =?us-ascii?Q?bYebdeZVS3Ydq0ybmqvrRA/3g4FLinLaC/9hwRUYYcmsJa00QuUSx1Sc/RC1?=
 =?us-ascii?Q?/cxDXQLiM+ye5nppxgrD7RGlNl4NeZYy5tQGzsV6/ip4Oz1mpp5uar+j8npY?=
 =?us-ascii?Q?92FKs9Km6460HjFi0mKyPRA2z2uRdo6NXX5pLjbeVNtZFqFRk8SRhfSqbEK7?=
 =?us-ascii?Q?wNkRKM/s/kekPaouinF0RD2Td6If4FNbKSfi4Drc/gJ1TUZAHfn0O04+Y3Ig?=
 =?us-ascii?Q?TV8lQBHL1RGhKAwcL+2J3Tx5ZzxUMTOT6i1BfVXzKw3M3sTJL63OkYOMNKIf?=
 =?us-ascii?Q?5sel5k9Pk/NlIolitbnBOpI1rW4wafERnAyH6t5YBGvQgevDci5qSIfCnYXV?=
 =?us-ascii?Q?vHfnbI4GOwPZ248fjDkSb/XzgFv0IASiiMCRa6U9cSAeigFFOaCkEduzp26+?=
 =?us-ascii?Q?qyHvTBfNJ3JBfnMEdHHGSFYawVmNvwtaqoHeW9opQMYeT8KIH9feJLQXIM8h?=
 =?us-ascii?Q?OZXW/nA219Z7gQeweEyzdfCrxOlgz03YKhsnUD21zJVdJeW7Q0CnYd2p6WUA?=
 =?us-ascii?Q?gaEX8ArU+p9JkNHHz+IixhC6+Sv5t8yQsZfx0xim0XqMdRPxX9LZqSQqLX2g?=
 =?us-ascii?Q?/xJjG/jpSuiiA+KTyVIDwAWNqAKIdLPy7Wjk7WpmB1jEze58Y36+aXoSxFwK?=
 =?us-ascii?Q?xLk0I5BofcsZdye6ZFMMVYOfaEiyvOls/RsMUzja/gcpAURn3FRChCDL1N8v?=
 =?us-ascii?Q?jsVfkz6Czlc+I516oyAoM4SB5sMvk0EUQ4jsu2mtTqYfkQN5BkRSz/A1jqxG?=
 =?us-ascii?Q?IBS29oHCADw9EUBXd/fUxFIemyeF6YVfJPdy9sTDUXaFv7ceHIYXNRT02ui8?=
 =?us-ascii?Q?Bpe+rkIX3U1c0Us/r63pti0FVP/ZC3uhkEtXNcxAFaTFGSxOYaWg0cIY67jS?=
 =?us-ascii?Q?HQwGFl52ZYKfLMOiovCKgGk0pbVU2rAcNdVjVPV4Sa/iUcFdDK++EcHXHEY6?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296492c3-12ce-4204-dc9f-08db86c97b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 13:26:52.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sf4w+Vnsp3amYs4/SYQp4KdCQI0C/GdMi6besD0HLMncOLf1276nxiLMvuvMLm4V6TjhwVBDyfy+/FgaRjjZYGgtoNN0O01JrNxscPX4Q9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> Subject: Re: [Intel-wired-lan] [PATCH net v5 2/2] iavf: Fix out-of-bounds
> when setting channels on remove
>=20
> On Tue, May 09, 2023 at 07:11:48PM +0800, Ding Hui wrote:
> > If we set channels greater during iavf_remove(), and waiting reset
> > done would be timeout, then returned with error but changed
> > num_active_queues directly, that will lead to OOB like the following
> > logs. Because the num_active_queues is greater than tx/rx_rings[]
> allocated actually.
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
> > [ 3506.152887] iavf 0000:41:02.0: Removing device [ 3510.400799]
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D
> > [ 3510.400820] BUG: KASAN: slab-out-of-bounds in
> > iavf_free_all_tx_resources+0x156/0x160 [iavf] [ 3510.400823] Read of
> > size 8 at addr ffff88b6f9311008 by task repro.sh/55536 [ 3510.400823]
> > [ 3510.400830] CPU: 101 PID: 55536 Comm: repro.sh Kdump: loaded
> Tainted: G           O     --------- -t - 4.18.0 #1
> > [ 3510.400832] Hardware name: Powerleader PR2008AL/H12DSi-N6, BIOS
> 2.0
> > 04/09/2021 [ 3510.400835] Call Trace:
> > [ 3510.400851]  dump_stack+0x71/0xab
> > [ 3510.400860]  print_address_description+0x6b/0x290
> > [ 3510.400865]  ? iavf_free_all_tx_resources+0x156/0x160 [iavf] [
> > 3510.400868]  kasan_report+0x14a/0x2b0 [ 3510.400873]
> > iavf_free_all_tx_resources+0x156/0x160 [iavf] [ 3510.400880]
> > iavf_remove+0x2b6/0xc70 [iavf] [ 3510.400884]  ?
> > iavf_free_all_rx_resources+0x160/0x160 [iavf] [ 3510.400891]  ?
> > wait_woken+0x1d0/0x1d0 [ 3510.400895]  ?
> > notifier_call_chain+0xc1/0x130 [ 3510.400903]
> > pci_device_remove+0xa8/0x1f0 [ 3510.400910]
> > device_release_driver_internal+0x1c6/0x460
> > [ 3510.400916]  pci_stop_bus_device+0x101/0x150 [ 3510.400919]
> > pci_stop_and_remove_bus_device+0xe/0x20
> > [ 3510.400924]  pci_iov_remove_virtfn+0x187/0x420 [ 3510.400927]  ?
> > pci_iov_add_virtfn+0xe10/0xe10 [ 3510.400929]  ?
> > pci_get_subsys+0x90/0x90 [ 3510.400932]  sriov_disable+0xed/0x3e0 [
> > 3510.400936]  ? bus_find_device+0x12d/0x1a0 [ 3510.400953]
> > i40e_free_vfs+0x754/0x1210 [i40e] [ 3510.400966]  ?
> > i40e_reset_all_vfs+0x880/0x880 [i40e] [ 3510.400968]  ?
> > pci_get_device+0x7c/0x90 [ 3510.400970]  ? pci_get_subsys+0x90/0x90 [
> > 3510.400982]  ? pci_vfs_assigned.part.7+0x144/0x210
> > [ 3510.400987]  ? __mutex_lock_slowpath+0x10/0x10 [ 3510.400996]
> > i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e] [ 3510.401001]
> > sriov_numvfs_store+0x214/0x290 [ 3510.401005]  ?
> > sriov_totalvfs_show+0x30/0x30 [ 3510.401007]  ?
> > __mutex_lock_slowpath+0x10/0x10 [ 3510.401011]  ?
> > __check_object_size+0x15a/0x350 [ 3510.401018]
> > kernfs_fop_write+0x280/0x3f0 [ 3510.401022]  vfs_write+0x145/0x440 [
> > 3510.401025]  ksys_write+0xab/0x160 [ 3510.401028]  ?
> > __ia32_sys_read+0xb0/0xb0 [ 3510.401031]  ? fput_many+0x1a/0x120 [
> > 3510.401032]  ? filp_close+0xf0/0x130 [ 3510.401038]
> > do_syscall_64+0xa0/0x370 [ 3510.401041]  ? page_fault+0x8/0x30 [
> > 3510.401043]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > [ 3510.401073] RIP: 0033:0x7f3a9bb842c0 [ 3510.401079] Code: 73 01 c3
> > 48 8b 0d d8 cb 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00
> > 83 3d 89 24 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73
> > 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 04 24 [ 3510.401080] RSP:
> > 002b:00007ffc05f1fe18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001 [
> > 3510.401083] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> > 00007f3a9bb842c0 [ 3510.401085] RDX: 0000000000000002 RSI:
> > 0000000002327408 RDI: 0000000000000001 [ 3510.401086] RBP:
> > 0000000002327408 R08: 00007f3a9be53780 R09: 00007f3a9c8a4700 [
> > 3510.401086] R10: 0000000000000001 R11: 0000000000000246 R12:
> 0000000000000002 [ 3510.401087] R13: 0000000000000001 R14:
> 00007f3a9be52620 R15: 0000000000000001 [ 3510.401090] [ 3510.401093]
> Allocated by task 76795:
> > [ 3510.401098]  kasan_kmalloc+0xa6/0xd0 [ 3510.401099]
> > __kmalloc+0xfb/0x200 [ 3510.401104]
> > iavf_init_interrupt_scheme+0x26f/0x1310 [iavf] [ 3510.401108]
> > iavf_watchdog_task+0x1d58/0x4050 [iavf] [ 3510.401114]
> > process_one_work+0x56a/0x11f0 [ 3510.401115]
> worker_thread+0x8f/0xf40
> > [ 3510.401117]  kthread+0x2a0/0x390 [ 3510.401119]
> > ret_from_fork+0x1f/0x40 [ 3510.401122]  0xffffffffffffffff [
> > 3510.401123]
> >
> > In timeout handling, we should keep the original num_active_queues and
> > reset num_req_queues to 0.
> >
> > Fixes: 4e5e6b5d9d13 ("iavf: Fix return of set the new channel count")
> > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
> > Cc: Huang Cun <huangcun@sangfor.com.cn>
> > ---
> > v4 to v5:
> >   - remove testing __IAVF_IN_REMOVE_TASK condition
> >   - update commit message
> >   - remove Reviewed-by tags to review again
> >
> > v3 to v4:
> >   - nothing changed
> >
> > v2 to v3:
> >   - fix review tag
> >
> > v1 to v2:
> >   - add reproduction script
> >
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



