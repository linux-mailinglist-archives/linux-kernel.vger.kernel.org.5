Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55957EE4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjKPPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjKPPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:52:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D916101;
        Thu, 16 Nov 2023 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700149934; x=1731685934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q+SpuiHWixl/2iHDOZJhDhjvPhOIxB3kw33rkALx/ac=;
  b=k/d08LaHZfnTFUpsha7nnKP1gCixjmJ6wnJ0mFet3OwPiV88IEaxoKx6
   4xtfB4NramR0mwx+sOmbnx2O+bg55y1omt/HPjTZ8dlxL9bvCmAvW+1AB
   B7jXh61CyL3dTT5N+cmNQ8K/no5MGHgK3kkWaMQeIXwDkT43vgT/vsx6X
   F5JclvONi+Ar379WM1VeD7yPhEsuGIVm03W9X6mVA7t5uiPp2O7nemrW9
   c8+u4UddVYO0Y5Ms6+OL5HALsEV7k63Pg0yt1Ng72BRfuIqgvYj7mfIf6
   1vYlXEYuSfgHoFrDj+3NVjnvxp12ZNWEgQ2Cg16l8cqRMoS5EExPYmoim
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="371293305"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="371293305"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:52:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="741802053"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="741802053"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 07:52:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:52:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:52:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 07:52:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 07:52:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkxKHukG0tnb5jeSPAFfR5PEudC4ks0scfLHwjPcG0kjqP06z4UHoBVg9D7cTiKe8MipZWqwp2vZVJl8x6Menqf9lAV0iPvRcNwsQJzXdOWuPeq1GbApB3u5Q3NO/d73grR+RXRPUdjRQhSXhUiWqScqj31bhEVJECNOhf7WR5I3aYsj3h8IcMuHUv8403Ka4QH675lvxH6m9VlmBzuRUCFSHBinIgxWRWZNlWqq9YxZEX57pPTzsQ7/puXihvEvtCm65a1E95XQgUHWBSOOGFxououvb/+xhDIOx6tCNCA0JeAdnjsQRyGkN6TXN2jjaX7GGm9N2k9RkTg5D9HiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+SpuiHWixl/2iHDOZJhDhjvPhOIxB3kw33rkALx/ac=;
 b=m9K9W5QJS1vemEbdVb534eD7FHNhd78d2wXO276FvwbqndaqIEhFoG/aIMW39gX2ATXpeM3tla6nqsmNzdxSSMjVckGlOpTQ+GnFF/tS7KV1X0tZdMwmBtvkhFi1XA9EqR7CmtBvcvyn07CXLzX03n8oJ9QKLvDwqLyBVqP4auOTZiu7mlEgVqwSGpvKOIRNVWmFIv3GBgM0qt45Xycf/CppdiriZ3dPYXvqp/OtpEIUW0fowgtWK0wFZtKgUbee4hxi17iftNp4a8dRLws+XCSvyxgV7nKbovxepo6S5L5G+F5p1+pZbWcFirJs3Ok8CJvzRgB2xEv7/TqUutdqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 15:52:07 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a7:165b:5c95:7a5d]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a7:165b:5c95:7a5d%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:52:06 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     Simon Horman <horms@kernel.org>, ivecera <ivecera@redhat.com>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] iavf: Remove queue tracking
 fields from iavf_adminq_ring
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] iavf: Remove queue tracking
 fields from iavf_adminq_ring
Thread-Index: AQHaB+gUbHAaPQzHrE2HZOs0BH2JpLBo4TEAgBRYnhA=
Date:   Thu, 16 Nov 2023 15:52:06 +0000
Message-ID: <BL0PR11MB3521C0334FF07B3C3DD69D9D8FB0A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20231026083932.2623631-1-ivecera@redhat.com>
 <20231103170928.GD714036@kernel.org>
In-Reply-To: <20231103170928.GD714036@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SJ0PR11MB6768:EE_
x-ms-office365-filtering-correlation-id: 5c23fe34-5b00-4ff4-138b-08dbe6bbfbff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rk/dqzMl4wZ3px1I7WW7O6qsrzf9CwMlaoAL5G5Rx60Zj9UPRtwdX0/EjC7T0uFM6/zK5pExfnuYTgEcO6/nyEr/t5weaEhIUodHVXGzIVg1tVZRnZCOS433YqGPY7xjtG7ZtZgB/TnKcSFBS1+6gZiPKjzO7ao4EfuFP/+ad46cAkaJQNavrwbagKPqwe/+D0hJzcd3uYoVW5Ve3Y3pwwy7UekndQZJb5gSL6IIF+q4lXHT0VREP1WSIfaCHlojuZ7VOacVD24gim2GfIGtBD6eA7DZa8W/RuZ/E8QEIiu3pbkextCzZXVd7PtTi+P/3xJYvwB10134EBcUJYyrxPYQYMRKjZBokcZDqKcrJqsddnydK4OiR4Reb1ZVOw1He3pffmj98mWWJsBdE9ITp3AhWjisjGiNnIralADICprazrzztdZ3cucOSW3x4e9C6IjxK8juLVjeW0+TD4i0vOJRpNguC9k5aDIpB+Pu2XU6VeJLlQPGC4yMsC3pI+1B2B1XsyQizuqKTbvu5Q9EQWTzZJOvXcIUJqUZJ5zhngvnVt7Y0OakhoxXPtEbU67+iN0w2Xy6MB3AUHEBnMwCJiou+ss2lxr1zC3vK1v7dB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(966005)(478600001)(2906002)(6506007)(9686003)(53546011)(7696005)(52536014)(33656002)(5660300002)(86362001)(71200400001)(316002)(64756008)(54906003)(66946007)(66476007)(66556008)(66446008)(76116006)(4326008)(8936002)(8676002)(38100700002)(38070700009)(83380400001)(110136005)(41300700001)(55016003)(26005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rYsfQEZFedn6fZqC9pxW6qtOJ8b6U6wnld9Bs6i2mvZEMRMerUG2vntQuoQr?=
 =?us-ascii?Q?bSm4fhNTvOLeBoNKArAwssD9/3X5XHEJ8X7JznMk1FMurbzYvCCpoRT3LWNN?=
 =?us-ascii?Q?2C6SRRN+4adb2UF6GKWWyB/u6gbu34zm0VYX0Cr7fi3d1YPcoxfUF7/6/jOw?=
 =?us-ascii?Q?YBhjO3AR5azX48zyLzxm6Quq8fkN/C6U/u6XovLEmYldat1dxhHqZKbOLa55?=
 =?us-ascii?Q?ENzhjSlrv0dYoeo2COJxVumw+LoDSP7eIz/8TQv4w+b6opkWuvpzNIhjxdo9?=
 =?us-ascii?Q?qFYLp1yXLsV7GrMUcGJ4BwgNO7HB3pVIh/hgNykY/OF6HZckzDSCs/+zgE5W?=
 =?us-ascii?Q?pn8XP+8YWdoSC/ApUVTJxRuHvK5TNzQ8aD50LPXOlGNZIrGOC793VrtAtvDd?=
 =?us-ascii?Q?DQsnVqONGMgcMDCoJ8jw67+JkKi4iSMQM2EyIj4tQOIzOlaqAcdTBsmdcbxX?=
 =?us-ascii?Q?ZX3HARVWnloDz1Z45bAgDLJzcWZAfupFPRVkGwXM5CBSX3SgDQ2aqjR/3XRw?=
 =?us-ascii?Q?FMuEfv5qpEgOe05mdZXnDQg+7qb7WzlyduXzDpBJ0VgsGqm6i1on+kI/Uweu?=
 =?us-ascii?Q?JI3JNHaQ+LT6t/BID/OP+RTCFH2uAJhWO3IiNOeMZJ/o2fo/mNa0Tj/8CRkW?=
 =?us-ascii?Q?l9V+66oCtiWBSqrNqSrWDlsuQkmfIUo7dxz5owKMaj2MPimqNnfkT5YBkt9q?=
 =?us-ascii?Q?Na0SOASBIPji2X0Cib34it4JlFgQxCSodR3HvTaND18/zx94gdJLDONenKQm?=
 =?us-ascii?Q?vxgMlA2GCOGWqXJvXvXUhzSQIsCAMErGThi8zaWbj/hk7w4+1LWRfkFbSXnq?=
 =?us-ascii?Q?woLYR92QYCkbldQOxoafjk6fnrzmA3Fxff5pVm3Hr9yoe9olfncxlFB9yRMw?=
 =?us-ascii?Q?Ml0cDElM+5uDA2Iu3/WkEdAxbeXY7RAO86tvOPUDs7sAHpOADNHrbefmt/FC?=
 =?us-ascii?Q?lXTcddMIZsSP7zLPDeNQXtBZUhiVYrpZRtP/xPnQiM9/nvMPFWrQucR+Av5o?=
 =?us-ascii?Q?ZN5DBr8AacqRwHFzPfscFvRFIdL9a61e0WGXS8mVWpPGXtAahxHNU7wbQsI+?=
 =?us-ascii?Q?l4b1eJNObGliuAEpJ6Oj+Rhy8UYCh5P+bS7rtf4CMnEugywnv8duQJC0hxjV?=
 =?us-ascii?Q?Y7qGgEKKBuBEi1NgWBBQMizOKw6ehsTMJJJgJ6eZT5U862XUVP7a5IjkOeW6?=
 =?us-ascii?Q?hHBSttPfjjoNP0KggOPkP7mBlntq2OCYt2tKy3WFye2YrfSu5uAua/BNfAW4?=
 =?us-ascii?Q?eXSrYI4Ak5gFIPerldhzcqJj2GbQ2RO+YpuM1sW2SM3ob9uxrZtfcDcjqbJ7?=
 =?us-ascii?Q?6uABMvKDgWptuKICBwstGFf1bFRLxgZOX9qhzEkFU6vnrfWTvhuziwhnjIeH?=
 =?us-ascii?Q?TKN+4Uz+ktP4yBQ3Yf7MdPUCFgDN/JjIqLeV1g9Xyvv6HJVRJV1bpteovotc?=
 =?us-ascii?Q?U2sxvbGibuoDuLN1q7zXSb3FOgk+0bO3KAayOWcxvdHK68odx+2Y/jD1tqt+?=
 =?us-ascii?Q?zcpTVDsjUj5yeXcFQ3Sw3fs5BsSyQFe98BHcA73GxOMxtS110JmLupMXYsPY?=
 =?us-ascii?Q?S2NkoOagEblplEEJMjNWrPgKsZLvRROr7i9Lp+ejEBSXIBG2OvYvun5/uQ5j?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c23fe34-5b00-4ff4-138b-08dbe6bbfbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 15:52:06.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Wwc+fiwKQwMa5MRzBJeDh2rhEbdHJX7H2PXB0rRD/qOl1uuqIQo/27Q/mlcmJZHoeMcH1+5DsLUiHpDV55SxXMR3kE/4vZgopVxPxvMkEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Friday, November 3, 2023 6:09 PM
> To: ivecera <ivecera@redhat.com>
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>;
> netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> linux-kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub K=
icinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next] iavf: Remove queue tracki=
ng
> fields from iavf_adminq_ring
>=20
> On Thu, Oct 26, 2023 at 10:39:32AM +0200, Ivan Vecera wrote:
> > Fields 'head', 'tail', 'len', 'bah' and 'bal' in iavf_adminq_ring are
> > used to store register offsets. These offsets are initialized and
> > remains constant so there is no need to store them in the
> > iavf_adminq_ring structure.
> >
> > Remove these fields from iavf_adminq_ring and use register offset
> > constants instead. Remove iavf_adminq_init_regs() that originally
> > stores these constants into these fields.
> >
> > Finally improve iavf_check_asq_alive() that assumes that non-zero
> > value of hw->aq.asq.len indicates fully initialized AdminQ send queue.
> > Replace it by check for non-zero value of field hw->aq.asq.count that
> > is non-zero when the sending queue is initialized and is zeroed during
> > shutdown of the queue.
> >
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>=20
> Thanks, this is a nice cleanup.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> ...
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


