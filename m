Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD47806CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358415AbjHRH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358418AbjHRH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:58:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F43A84
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692345529; x=1723881529;
  h=from:to:cc:subject:sender:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UnK0YL4eshwYSyCjK3HJ0gIbD0Qcbn8v9Fva0/0hvWs=;
  b=aZ/nDISR5/kbM/weaKj323XloSWg/MNaZ3IUiAM+wMIdB3YIWRwHyQYl
   FMwNRX6MEFnCmHrZK/jlPCCnpoelGrriIYsutd+vPgpNH5TCiJ08At0AH
   PJrHRcjNjf4Te6qcQ0vVxfS0H51Eu/YlZZ5ImWzQIkR56YUiANouE2awC
   vutMTenm0c4PM5xzFTPYDqXaqcff/IJSMbKZmyOZL6N+P2uPIYOEouP2v
   yKtJ3lzAcyj0niUOI8X0PvJVSHuWv/vZCKc+85SkeJUdkPLBC+hZ1L2Xs
   rnIn3QE6HHGT7pSRa9QOr2R1cpLPt2Tr5TMdth6ohf4JwepIzMV3q05G4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376801397"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="376801397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="684793544"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="684793544"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2023 00:58:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 00:58:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 00:58:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 00:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flQ2KZ+3gYM9+Oaw8LuEtPz6CBPanh5umQzC+4G99mHXawZNR9ZbOKAssVQJ79kDd6Cjj8h1MM24zO+/rSYxBO9NuhckEEoKZ9gkx21a+NxPH9EI/vteM4IvyKZ8YUERXvez1/lZOOe+JMJ2H6/JQjPgPFWVGsJ3Je00ql5r5a/kwGRWH0BL4mYz+GcB96zjzTLFyonKDNf2gb2J0Tv+hkrrdOuFmwqjogmJFqlhmcSy+6UgOvW7W2Hy2ZCJV2gtex2kaxks/+P/nt34CuvakSQHwI+tqKKJFTREJrVKlo55otimMD9Xi5nKfZAvtWsAjEeSfbcGHMZol2dEEc1t9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnK0YL4eshwYSyCjK3HJ0gIbD0Qcbn8v9Fva0/0hvWs=;
 b=iSgXuo7QiElOAvwNwVdIXqjnsNi1eaY6A9ax7cxC1N+GvDrGRbL0mouuph6MVEVHNDfXPEIBwtglUkWfbFPy8diirUpcVFh+KxUb1dd4tU9jwF9ZCYB+vjmc0BG019StV/Nsuy8fi6J/rKslYKf0KvYt950uka5wnS5Yeg4GH2ZHGnLV/iBimG3jCwElFoyfXOa7WcFCqEeoovc4d+fCk9pF+5iinVcrx0+mWI8lz6wkvhWze65j/entynRniH9AT6iaMGgQtzrkHG2QglIkmc6YKWGyGQuHOWR5XSkrd3tQOZ31OV4LOnFl+nCVEzZkry3HGfnEDq+cJ+Nbm3Ae0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:58:47 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::55ae:a9d8:12e6:d0c7]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::55ae:a9d8:12e6:d0c7%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:47 +0000
From:   lkp <lkp@intel.com>
To:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: [0-Day CI notification] the service will be paused from Friday Aug
 18, 5 PM CST to Monday Aug 21, 3 PM CST (GMT+8)
Thread-Topic: [0-Day CI notification] the service will be paused from Friday
 Aug 18, 5 PM CST to Monday Aug 21, 3 PM CST (GMT+8)
Thread-Index: AdnRqceHdEhLnziXSEy2TuQjp1jT/g==
Sender: "Sang, Oliver" <oliver.sang@intel.com>
Date:   Fri, 18 Aug 2023 07:58:47 +0000
Message-ID: <SJ0PR11MB6792576A4E0EA2D3A61F26CBF11BA@SJ0PR11MB6792.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-exchange-messagesentrepresentingtype: 2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6792:EE_|SN7PR11MB7539:EE_
x-ms-office365-filtering-correlation-id: ae352a9d-188d-4426-dc83-08db9fc0f3be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWd5PDZTuydXvQy0LjsFme/ErrAcazlr89wX7I35fRK/SSWJnLaSzfFzpKewGkzSPrjFBW+Kv3LZuZ4eV6qiORlgrNaF57ewv7D5AQjjFk5H5tQ6M1DAYgCuwbc7cpL4dTsrRp5OXef3iQ4j2bh9a7Ns/SWajCLHOlMao4WY2wcD14ykFq3SdEtymtbFn/tsqC5XvtToEHLo9PaWaCmbYA6RFvvZvKg0TbZ54g4rlsq9nUDwqJVxXb9ryIFomOLyMdIYf+0IMiVaN/80/ZYQ3blNkDnQpXWCIHOh5MxTiA9yEV7fqi9LzHKZtsykMhze2Z362151O/WmL1Npg/gjDc3NtkiORijaMYUZHOOykCKJLvNjAJ9oJs4XKJvV/lGoV16m4rxsQn3j8UwUStPGLMvZFAyWRvmCVQM0BEgbHcM3IvMKS1o9ORC30J/A95+kJrE39Fm9GLUmVI34NqdHRs5Qty1NPM7TtsdTeHY3H8p7ciO65hsRkYCpiMqCgcgnV/ciChBrX7+fshPBGUUGveVhVyjCitQTfIpEY8Q4i9dHnaJynF0EQwsR9CpXu5QRoqVMMcE9hWlxrxU0cw0+Zd8ejpRLVsHfFO0jWeHwLmFnnIHjMQMOve9pnlc3LIzE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(83380400001)(26005)(478600001)(6506007)(7696005)(7846003)(71200400001)(33656002)(9686003)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(66476007)(64756008)(76116006)(66946007)(66556008)(316002)(110136005)(4326008)(8936002)(8676002)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nXXzEFFXEan3UwEaCWqmljy2t+OLr+GBKIr2e9uHuJGDcbefIIZp+m0+akzV?=
 =?us-ascii?Q?kVe6FLgJYt0RhRlivTTANDCE8Bm/8RTQJBIUQyd/A77UlY26xpBGAwxMCxfN?=
 =?us-ascii?Q?1jRGEXqB5HQz+55CGlCSjOO5cVtuVh4sPWivKKtp/DpOOnnuLYa0aWGfsoP9?=
 =?us-ascii?Q?8VMGPztF50M6Aufz9FjGuyYINh5ObtpvyyYiaO8/1FkjvRD4KSV+jqjIZCK0?=
 =?us-ascii?Q?t8ky//fNrH2j5cJiDinIKrGu/bMJQFAZgWd+hwyIVwl7osh3JUURlsAKmcX4?=
 =?us-ascii?Q?oKVIRHed75lRqr9vsr705GOJrh0K909BCAC98tsLJuOtMt6D/IFliZS+BKU1?=
 =?us-ascii?Q?KkDi+OSafphgdIQ4DrYieKZynYpGVPeA7EoK10oTRx8ovWXWGls37cUkx6AI?=
 =?us-ascii?Q?bwnOhQv+Mn4sHycN6vYLSRdqq/algx/Sz3Gh39/m3FQpZ36/28zyP36PtSZj?=
 =?us-ascii?Q?AQdj9hzFxdxN+XFTgRWoVt6VZJuGGyFmaA1tteuNCXxug+u6cuBFj4lJ5gnQ?=
 =?us-ascii?Q?pFAwEo6jWRBe/cOocCIdRJtjHc1ZviVrjlkUn7vtsctZBPTW2lPEhb+V2fC+?=
 =?us-ascii?Q?1dVwv1niAr3dUjL23+FoTpz+t92hTzSIR2WzNL1MRj7ZsxVbol4ky48e+GP8?=
 =?us-ascii?Q?TBt2ashg+aXtQr45lYxtv2qigY6vd7UOAUj4/qPqNauy0mv/kufrSSwXeGbY?=
 =?us-ascii?Q?M2M8Qb6vuqA16jso7XWU8c0+pZKXIwKNOTkA7b5B11Z2gUitV465QMsem32Z?=
 =?us-ascii?Q?vEdmVgLcYTkpKUexBB0EYzUn1Gv3hYN+RuZuTL7Kn6VDveH1gVrdKXh76DiW?=
 =?us-ascii?Q?79clvZpdf+VxUtduVqA++Og3wZIooqQtG4gf/beRk0K8pOIuw3f7vUPLT2PW?=
 =?us-ascii?Q?QEpbP8koM/EDTVC3IW3Q/mWopsiPpEHNtyssrMXzru2829zTL/oK4z1g15Hs?=
 =?us-ascii?Q?J6Y1nyDDgs4OnvXZXZ+He+7/Ud76CDnqCOoptB885uGTM6G9eE89jWYpDhHK?=
 =?us-ascii?Q?V+HpX04+u/BzSrMc8JF93yg9V6UwMbm2Y6K5HdKg9LrFC13HU7/WzsiDMgCw?=
 =?us-ascii?Q?Z4Hf9nxfrKDsGWdZbPQK3NMClBA2d7JPUfrP8J4YOLvZlLGUzSwx49eIB21M?=
 =?us-ascii?Q?7803RvwR6QkLGu1F14+SN8AvfZIzqO3emn0QNqojq+8eSSWH/ieqLAkVob2e?=
 =?us-ascii?Q?kU2TMmDyyNSgIJniL5aa6EK2F23xB0VSIr+HVfB+tvMrv++DC4tpIgbME/By?=
 =?us-ascii?Q?T3KhOD3bXDvkLMvl9FoN/LdIrwozGM6wGYQzZIX3I1Vugs7GRMB4uPykUrt1?=
 =?us-ascii?Q?nfWNbJojQAER8mpJ5nYN5W80lyPx433GlP93gQnMh+CnhELYbKESvYq3BG5S?=
 =?us-ascii?Q?8drI7RpgAuecse4HFTjp9nj59TjHmBRnFvGVWuOgtjv1+/y354hpso6d7ZjS?=
 =?us-ascii?Q?3NJMqeTGuG7EviDxb1LNsoN+d3hMr83aEYMR7q/y6yuKzKalJ3oR7daNtsya?=
 =?us-ascii?Q?PdY5F05CXWdbSREKxh5JlcbAt7dBLVQEI3++xiNFz8Ghiurn0BQelTHT0Vex?=
 =?us-ascii?Q?t0paiXdxvaX+p6TWF9YR9l/JcZYB1ILdcZTMFIuS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae352a9d-188d-4426-dc83-08db9fc0f3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 07:58:47.4792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CeNXFRguBpHFX74S+P1DNP5qeTXOWsZr7gVb4hJT29PkR/OgLBn2gfKy+7XocD5ljMrM2RrPhov5L7l06t7b5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7539
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

Hi all,

this is Kernel Test Robot from the 0-Day CI test service. Thanks for
anyone who subscribes to the service. We will have a lab power shutdown
this weekend, thus need to pause the service for about 3 days, from
Friday Aug 18, 5 PM CST to Monday Aug 21, 3 PM CST (GMT+8).

Sorry for any inconvenience caused by this, we will recover the
service to be online as early as possible.

Thanks
