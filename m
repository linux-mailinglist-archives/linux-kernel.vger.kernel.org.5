Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F367A1911
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjIOImg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:42:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B156115;
        Fri, 15 Sep 2023 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694767349; x=1726303349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bb+Jb92FKPshU0tpBe+rRgP/g0mFCayFI18IV/MJcOU=;
  b=PIqqeqwMmDtPWZx3uRjG0pTslWfTx8mxeYMHWHLGH9DUy8ls1/cx98f2
   lunhxe1jQ34sIUTgE+Q64UYZy/+8LOw7ZFvTNdaAzrHeMrq9cm9Bk9LW6
   rnFZxL6RFE4R8r75szEoibPkR4RXDuaRhAndOsZgz4TCzdpDs5lOq9pXD
   Tp5SlCcuz1LGUlJuXm/KTRJKOGXZOkTPwHcmOxkHyNpPrk/96XIlzyVmD
   CFPjJUpInFh9wAgf4f8NwckypEyujd30/ulNF3x1gw6Azrt4lh/WZtxTM
   xHlHgGXsyUxPjxVbS2W3TG6mjuLP6IjMfcnBNK1LR/gzAGjkYZ6H1mS6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369517972"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="369517972"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="780015711"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="780015711"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 01:42:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:42:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 01:42:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 01:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8si+SzySxzGW2XYsLldZ1PLpXkNqcDAhUvX7UrEd8v8/wsQSok/rwRHKHfTRCeGkWASAF3byp5cXW4DsHTesz6AGbIaIDulcst6dvoy1TN8AWlkWEfR+8MqM/07kun/J2GvvyFGzq0y+qpYp51ERHN7Oq/pXUNfUhi0JObRKkJlF+KPaiBtXuFQQWRvEUfMYCjB2rJOS7ZxtB8IE+ClX62Qd0J6EgEXJn3dSqpsAxer1YtTpJdrxCd2Ay9/aQthSDT4gLveuCMnvAg898qOc/i7zVaRJ0rwC4d/FJWGgZvORQ7FJhZuAMMGQt0kYoS+OgYxSxSctiRhSEMx7C35IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb+Jb92FKPshU0tpBe+rRgP/g0mFCayFI18IV/MJcOU=;
 b=IFcFCOcoTcH7FcCGz6m2ROJtfHS9ndzbuv88RB3nUKSXa4B9tGQs1GkqbihnUscGh09siqJrD4YwYKDq7O4hz/gNoo3YSPHqRIQe0Y7l1oEtVBDTKi5rCAFvrOFB1zM0TcMg8LcW9aL91z2kVndAmGJJKhODC2k7c2aWSPvdi6JKqjr0noPKuaQoeklk+hW0lJDm/3ka+RspVyNw/rO7nkRcsPed+7SXh5pP5K85VzQ9eREv2vmZDlMzGnnbd9JRbVpXTy08SY+8THWy9LIDL+RYjSBU4N2zanC392wt0WkUXIxmbEv6xS4wT32jZgPbya1j9sR7WQTQzhbG4cLhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 08:42:24 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::d36b:7f39:5410:6b30]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::d36b:7f39:5410:6b30%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 08:42:24 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Catherine Sullivan <catherine.sullivan@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Rose <gregory.v.rose@intel.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: Fix VF VLAN offloading when
 port VLAN is configured
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: Fix VF VLAN offloading when
 port VLAN is configured
Thread-Index: AQHZ4aKcjkLdlaYlbUOWPTquLsEBLbAPta4AgAvoEFA=
Date:   Fri, 15 Sep 2023 08:42:24 +0000
Message-ID: <BL0PR11MB35210D095CD20FD123F915FD8FF6A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230907154457.3861711-1-ivecera@redhat.com>
 <26c81971-70eb-ed0d-749f-6d910ad786f8@intel.com>
In-Reply-To: <26c81971-70eb-ed0d-749f-6d910ad786f8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: 01ba1ffc-9efd-4b8d-a1b7-08dbb5c7af37
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yHAdW791Kqr1caQbXV81wFP+W3zGlSVqJcRkogpG1L/iIsnA+b+sGKzctwaZGsDTd1mwH8qcAcOVFy+QwCPOjdOWFAuM9M4okmuDTla68BQbegtuNBEPWn8kGAxnOJK0B+mfhMT2RNNvSRVRSxP0Tq6vICm8xGcGnM0ZCUIzzKmlRe7SYF7NalhhtirC83DGYfLnn2LJQL/gOFqUaGraZ/vKp7TJabVjZhWIYgnHKkCxCLqVyRmFm6URHc/c7ZroolVCI0SvqAEpElV968U7fC68BXYdzaJrwSW4ad6/Ize1Le/QJL5n/SVxVnx1A4nUcOUtt1Fvmv4NOdg7uVd1iaByRfVQnjGdO50z1WWB5tXnzm8RtD4LSrzXyYGFsIqwx20dChtrZP5v5uj9Qm06ivv14QcHhcbr2yQeujbF9PUclCBghLQk1AKjmdCphf6AD/1f1sxAmWQ5PFjCsoMPh+Z/l3gbwoEnBC7vNcHqjexUqguf8G+a/N0Y2WVEwB06sI0SFMAcTjxTsFYq1cxbvgMcgKzm1sHpslyX1G0VGmBFCY0jTvRHccGSjVPeZGFZ84V/M4TLjULiOkHUsDKzku7ozu4vOHVLg2laEkI0ce8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(83380400001)(478600001)(122000001)(966005)(38070700005)(9686003)(71200400001)(8676002)(2906002)(53546011)(55016003)(6506007)(7696005)(66946007)(64756008)(52536014)(66476007)(8936002)(86362001)(4326008)(41300700001)(5660300002)(54906003)(33656002)(66556008)(66446008)(82960400001)(76116006)(110136005)(316002)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N9zKeh9+aOaT/XspDcMG4IYujxA4lVibX0SrUc72Tcb1jS5QN0ZWFd74+TqE?=
 =?us-ascii?Q?oA/oADqGJsPv1vFj0DLNJs7kg1v1lm2dt/w7byJP1G9aqF2aoodsNMZcA5mh?=
 =?us-ascii?Q?NYfFDPBlY+lYIDk7ZKmRQBamA8XjPUSYsQbJ/qaTNzpVOKrhARmKdUyClw3c?=
 =?us-ascii?Q?a52V1Ur+YT0FlU+iVZStBVz6+p5FxLDGgsIBwqQIsWjoE5GeTeI+3LVMl0I9?=
 =?us-ascii?Q?aMDtA9IgJ/tKuBKC9KCBiwjHX2yxGE/C3FdSbJvJ1ydOyA8CRCl2kNjqVua8?=
 =?us-ascii?Q?nzu20PIsZx7v83XnK0mavBP8anufFiud8bOQ2Pui2K9+v6suftxaghVcRFVq?=
 =?us-ascii?Q?VcSes+0YVKSCp0YiBPOrF/cvvEIbCuCIGqXG87eNA+tgjdD0Fb2uhCsLu6GD?=
 =?us-ascii?Q?yde9az4Iu1wK54WlI76lKe5m5dG+wNFdJ6ZrMEwItOjxPbVMob0eqOtguwD9?=
 =?us-ascii?Q?TKxDt3DNZoOyvpUB5Is4LrMgO6ENHuVbYSwjGkUuXpu3zGcVc1tWF2fpJsVz?=
 =?us-ascii?Q?Y9un+mW0yjq5IMcXRjPKCpq0Qc6+mee6D07fy8vD8WV8sr2q90O6vBkytv/j?=
 =?us-ascii?Q?lnCxna9ioR3bX9NsQz8rn8rdj0JTo+M3/Irjivdxb1tP0xQrdodZFUJCNHax?=
 =?us-ascii?Q?jCb4CVZ7qhXmMwJCWIhDeyhq+lB3zbbY5Wc7RKlCQiBaDVZo3+tAWIEnfx4p?=
 =?us-ascii?Q?h0sIlr+DSigzeXjXSQRFGpzKrRqLm1VQ2ygYmZZh07mC1hO2VzG/2pl0/bCK?=
 =?us-ascii?Q?sw03UrYmzhfTVuLgqVuRJ7Gq0L4jORJfGDrIymFXnilysNOhZyRkMf+4gIeG?=
 =?us-ascii?Q?QKe84mmZJ81e6WFJu/hqYGtF/I8OUKkNieNVtYTph4Jb9b3KsrW2q8PQYhHM?=
 =?us-ascii?Q?pHkfOkUG/BydF99KBKU5J9nC1KGk/TTIS44Wtvb6hKfVNfmouwZN/Ah9J6b8?=
 =?us-ascii?Q?yCMIWp3vpOui+sDENR9ck8Gx3yuYhejY0rnz0p3t5NA9pMW7u8ceEhoc8/sA?=
 =?us-ascii?Q?qDk4KKKHphGR9Y4Pjxfsoj6qjCq4qsa3Bpx4Oo/3TmNBq1xSABTtb1AAJeJZ?=
 =?us-ascii?Q?SzOgNnWoGd5v/3uXxySwkgzO2beEd7bdOroRphHZ6D6W+R6UJtMydFD5vpeg?=
 =?us-ascii?Q?GElYgLcEjHtCttN1fEJ6GyV7rPwkXTYXdPd+J9r5uBWCcAUfN3OoxVCgmEUK?=
 =?us-ascii?Q?K38LrSQxXsPSmJbwRbbd8PVYoTbOqoXa1QQwtm7CCGebUh/MrJFCnB/Pre18?=
 =?us-ascii?Q?UreOssD+7BUfzB0xYf0jKdtHdVWeNtGusV2R0ZEj9jaR1KteyrFkn2ih7bg9?=
 =?us-ascii?Q?eUo/gWa635kNuXKnr3wGNn/LlzsJBJ0Bm5tn/U4GJCBdOKaKzxXJ4BHFCVe/?=
 =?us-ascii?Q?oNm2rtXaWyFffEyaKFXT1/c/3tpmtIwzj5AABtieAigQ/GSKXFKrTjt3Xv0Y?=
 =?us-ascii?Q?yxAl1uWF/JqjwjMylD2g+B6OWqCesIdqtzxWX1iBlgwFKu2dFZ12o90iNO7E?=
 =?us-ascii?Q?6PPUqpFf9tevk14lxbGN41XmLLOfJ1MTEC8FrURcqDhpSZfUiwskdK6FeNnI?=
 =?us-ascii?Q?KFIoSrKEKbDU2Beo5LObltxM84E/F4ZFbBtofgoH6DX7MsN1YtGefAq6cDow?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ba1ffc-9efd-4b8d-a1b7-08dbb5c7af37
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:42:24.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjh31JVRodLhRQIFv1kg0pnNluab2k85XTn/VNixlwL579hAg2rqXvJGJ0spRfaWunGTBlVpEga8OmrYqeJ656HiklaZXNEm19TbIeoZ0GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Thursday, September 7, 2023 8:53 PM
> To: ivecera <ivecera@redhat.com>; netdev@vger.kernel.org
> Cc: Catherine Sullivan <catherine.sullivan@intel.com>; moderated list:INT=
EL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; open list <linux-
> kernel@vger.kernel.org>; Greg Rose <gregory.v.rose@intel.com>; Eric Dumaz=
et
> <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Jeff Kirsher <jeffrey.t.kirsher@intel.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David
> S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Fix VF VLAN offloading w=
hen
> port VLAN is configured
>=20
> On 9/7/2023 8:44 AM, Ivan Vecera wrote:
> > If port VLAN is configured on a VF then any other VLANs on top of this
> > VF are broken.
> >
> > During i40e_ndo_set_vf_port_vlan() call the i40e driver reset the VF
> > and iavf driver asks PF (using VIRTCHNL_OP_GET_VF_RESOURCES) for VF
> > capabilities but this reset occurs too early, prior setting of
> > vf->info.pvid field and because this field can be zero during
> > i40e_vc_get_vf_resources_msg() then VIRTCHNL_VF_OFFLOAD_VLAN
> capability is reported to iavf driver.
> >
> > This is wrong because iavf driver should not report VLAN offloading
> > capability when port VLAN is configured as i40e does not support QinQ
> > offloading.
> >
> > Fix the issue by moving VF reset after setting of vf->port_vlan_id
> > field.
> >
> > Without this patch:
> > $ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
> > $ ip link set enp2s0f0 vf 0 vlan 3
> > $ ip link set enp2s0f0v0 up
> > $ ip link add link enp2s0f0v0 name vlan4 type vlan id 4 $ ip link set
> > vlan4 up ...
> > $ ethtool -k enp2s0f0v0 | grep vlan-offload
> > rx-vlan-offload: on
> > tx-vlan-offload: on
> > $ dmesg -l err | grep iavf
> > [1292500.742914] iavf 0000:02:02.0: Failed to add VLAN filter, error
> > IAVF_ERR_INVALID_QP_ID
> >
> > With this patch:
> > $ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
> > $ ip link set enp2s0f0 vf 0 vlan 3
> > $ ip link set enp2s0f0v0 up
> > $ ip link add link enp2s0f0v0 name vlan4 type vlan id 4 $ ip link set
> > vlan4 up ...
> > $ ethtool -k enp2s0f0v0 | grep vlan-offload
> > rx-vlan-offload: off [requested on]
> > tx-vlan-offload: off [requested on]
> > $ dmesg -l err | grep iavf
> >
> > Fixes: f9b4b6278d51ff ("i40e: Reset the VF upon conflicting VLAN
> > configuration")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>=20
> Change looks reasonable to me and since it fixes your reproducer above, t=
hen
> excellent! Thank you!
>=20
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>=20
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


