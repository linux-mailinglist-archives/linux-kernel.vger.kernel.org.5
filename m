Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8303B7ED9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbjKPDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjKPDWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:22:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355F119F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700104927; x=1731640927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8W/L8bIC92lVfyw9adC0921bgPZtq+uRrx43dQMym6Q=;
  b=FZSb4OdFKlQNenVHz8nNoGLf+LAr+m0/MBeez0a5KnFdYtV2sy7dWTzb
   NaKOGS5S0pENR+05dOy+13oknrtxSU1EgLlmKMV+ZP9mfdVQvL/vQ3ctZ
   tdPQBt0NqR1hxrgYhkB2w48oLZpPethpDv4p3KunWWWZbTK5LVG8RITqx
   pdqEDud4QdD+lqh6xiL+wbMR/Eq944NoEIXdtliHlkTCu3cr8wLcm6w1U
   NuqjcJX/I9mrsPhipDr0RaGqgLoEuHG5ErW4jxo3573Vd7Hkv3xdaLfl/
   eckVEwax3XTpY1JTtDFcltojoXjSnTgTWepGdcIZm72+3ieX6rw3GzDh2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455296748"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="455296748"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882605556"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="882605556"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 19:21:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:21:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:21:43 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 19:21:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np7/0uwxd3C7zTC+BGfmq1uh/FccqVCv89fV62xeUb6LrihD5qXybCp6Ri1bcszlfibruGRYIsGlKl8d5HDBe25REbA8UltrZODbhzEmZSJIFyp7Ej1AK8M++Yuuk6sTU/pFlWAwf21LAB9FvZNE6izk/7WoLJsGc2poum952kUuAInygNPn4oYmloGw7icQhdAilvco+hT9c122Z5vn4e8On+xm9o2l/ElJkk18YybTViLvn6YGEc0xfdVB+RxTUki2JuXgEH1Wm3q3dud2kmHanmV8gUE84R6WePntBsKxqp7xKX5r8WxnDV6YKjvihtIhmFg0BLspftNjk1q7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W/L8bIC92lVfyw9adC0921bgPZtq+uRrx43dQMym6Q=;
 b=Ofykyw0Dc1s1vgk/kv7MLrPJqJuIgmMsMI45r8DRUT/8qzwxGaCXKXq/PGXwHh4WGrmHWsfP8SIyLYhucxacahCA/SplRqsf8I/PffNcvP2i70VgBUztOA27LRD+4edBsuP2GAlpvj6xBl74sgx+9DYNdx24KP1pT8/G1GvbUa+luMUm3TdbZXUIOIMSqeSFX5Z+rCIUidCznOKF5ObNAkH7XyT+E5pYVKQLDsuMFnyyUFYtPPuDVIHEKQFzRSxJavuWM+Mzdpbjn4CjCyLwtG069lY3+kfOZHAd0aSVnszJ5tPLtuPiL777Fi4KzMofQ/NCSe1wvYdtERbfYSxgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Thu, 16 Nov
 2023 03:21:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:21:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] iommu/vt-d: Move inline helpers to header files
Thread-Topic: [PATCH 4/4] iommu/vt-d: Move inline helpers to header files
Thread-Index: AQHaGC/4jHtR3MXFHk2s4DtHm2hYHbB8R5Mg
Date:   Thu, 16 Nov 2023 03:21:39 +0000
Message-ID: <BN9PR11MB5276A67CCBD5483E2B4D02EC8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-5-baolu.lu@linux.intel.com>
In-Reply-To: <20231116015048.29675-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: 7dbbab23-37d7-41a1-2b96-08dbe6532629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rhFChB4AV6VHN4t3u+qlQk7DFkTnnDieHksxyg/yPppmad50ezBD85TG2Wx2d4HBnulGy7LhBXyrAy09hX9m87ncJ+1g/S/pgd26yyBUnO9d03cLRXfvx10GrwA9BrUdp5HTWSLvM5ymmgHV6ktyc8YtCcD6Ss0SZl8IAOBGnhqAyFIWzMiRSWT/qIteC8eDosOroGEYnM4jNCDVWkMwj4bjsSI6Q6yOIs31gXe3hlgnl0ivi7MHvoDB3yjUQHm1QH5swMmroWVTkArOh5Y6cFh00sB6DSyxl5F85WbggY1FMB3qc6tJbERJ3P62ffT9OWH7F7dyTtRuGcfW0nHO34XXwxuNUZVZ/0sisHxl4ziC/0Ds8iApA502QCLjbJc1CyfPmSJGWXalXAZlges0oiaDLoIyA6khl2cLUqIwskcqPaFydvtjglGSJUTKQIR9NQGS8g/lzLJWpL3ur0qM6l/goSrtwLELV4Z5RRfjnyvxc8cYlD9lMOoAjNo9BCGO7Q86RM9dA1xhYoZ8RPvuKmkKB6Gv3NvNB8BuUIk8S0ayJjp+UJUEcQMyiJvm6mUR7LUOAQYoDz+YfqubALIR1dIc+iUwOt0PGHrUDdDxhC4O6Bpd1abXB9gvDbXOVn66
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(122000001)(5660300002)(26005)(9686003)(55016003)(76116006)(38100700002)(7696005)(6506007)(2906002)(86362001)(82960400001)(33656002)(110136005)(558084003)(71200400001)(66476007)(66556008)(8676002)(66946007)(316002)(66446008)(4326008)(64756008)(54906003)(478600001)(52536014)(8936002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cdHrDCRyHmvhahYkclF/LSPFZXyuMk3F6pVoIu1bMkUnbe4qdtxxG807JR01?=
 =?us-ascii?Q?2afltEwNVoy8dl2DP6qu+Zs3DuxVAP8PZJWcGIXJ/foVYnlYxsx26dqbvePl?=
 =?us-ascii?Q?XHBjJLkrG1C45EdoYTiEwaSMQ9wNo/8nvba0RjLnODQiByBuYSnxiyK2mY9N?=
 =?us-ascii?Q?YhPydzpFlRHZ5yUifMusFAxuClg7jd7YBXv8mkRlvlkblx+DHrVS583Gkja1?=
 =?us-ascii?Q?+5WTWy49x6XHhanuULTc7e3Mlt3z+HTEYREf7o2yEbvOkXoCx7Wlv77EzENt?=
 =?us-ascii?Q?XErb2RpIYeR6BrcK8Obgn+hp3SDdda7TxgzT5YM5MH7O4Q/rbUqXBpHdCxoc?=
 =?us-ascii?Q?JIn5+NvBlrI6+SxK/jT/YH1D/BXBBeON0z9D0pcCN6l7iaDpYejPaCR0U/VC?=
 =?us-ascii?Q?mv6HCNVYEVtSzzA1SJ+h4HYKDhH2M79to2KjUSvyMC/hqQV6zmqXqR7bpcng?=
 =?us-ascii?Q?2m4hjgDjkfEn417mPu3uDNZeiA3DiZPhHLAWwGiKZKDwFWI3CgEZKirnvlsC?=
 =?us-ascii?Q?TY/HMoFj63kpkah38UP/BAxzGQqdr4NpWzYpdfjj0AfI9PNbV0RgxM3Vvclk?=
 =?us-ascii?Q?5JROXjosfsgZjAiIQKxIFrATkZm/pGadgal50iG55aiUA4495JpHW+Evs4oi?=
 =?us-ascii?Q?ms7P/cKmpu3CyybgSKZwULigKx+ea+9R3Z4HPub5vaUVmIDbuuE/jhx1XMvp?=
 =?us-ascii?Q?ORrMb2EkW3Np3KVXmROirf+/zfsmVoQvDQweOoVGKyqLVDMiQxPhHVtEN3Vu?=
 =?us-ascii?Q?/SXf18eTfEbShrEmpay5TgB6b60f1/BoyUtieHUPhQa+/Wd0HKmC8xLcmwdt?=
 =?us-ascii?Q?IXIcfYAs4KgN1nsiNHCEkzQSvzgXl/kgpDwxKzUctWOmS+wLtl171HY80y5w?=
 =?us-ascii?Q?MNeQSxM4ZAmr8QIVx7KQyh/LOJzQyqXfOA1btDjOrurUS2H9BAjMs4gtUgUm?=
 =?us-ascii?Q?ueG2Zm+EkWNKkUDD2GUw3ZALnnndTMmdw7jC62SxAto/hXDdc6djet8nPL3v?=
 =?us-ascii?Q?PP6iCBbhxW8r/YQATKfbA8qA5PvsuYIrAkEGv6oay4tOnYbovbJFcM0RS7Iz?=
 =?us-ascii?Q?OspDxPNy0xrgmLJgNzblZLib8AE5JQ9V2AiZd0n8zlksIg/fdY/c8jLxA3/p?=
 =?us-ascii?Q?6nxrEaOOQD54H4kIZ5NoLQ/rtpVpg3/hEmK7Y713wlQ4nmuplQ0Ed2Cg2V6M?=
 =?us-ascii?Q?HOGuFeLAJc22W1cb4p7fF7byaS5mS5W2jlLnct9XgJ/TQYA6IzHzhxDhTmnm?=
 =?us-ascii?Q?r0Z8EOUnc+Qc3FKHI1bY3OwDru8uxG4gFmUsayZOGgYGuPGsTUfazABz6Dkz?=
 =?us-ascii?Q?E61FF5EDc9aMhyJpHknY6W3yQpdnl9fmzdct7zugb+WkjJcLe2cM8XGtjTLe?=
 =?us-ascii?Q?uC/4zi+b54q5N2WO9qW0MkQqzarZ2d08fgiulNu9fyQrSAfLggbt8372gANe?=
 =?us-ascii?Q?YaGbKlKEfNM7q4j2z285pyRiQfghBzk7M0OaHfxMa3x8RwexQlvzKdKn+/DK?=
 =?us-ascii?Q?z+l/wx2VW1hHBSXbaKKBsgIvUJwixoOAuVfYOAzV/KhGZMY/kn2WajVSjmzR?=
 =?us-ascii?Q?UW9UdwlX4RCmTMjMcFUvkEzxJ5lslylFFDjzTz1E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbbab23-37d7-41a1-2b96-08dbe6532629
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 03:21:39.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/A5+NzoBd/Lb4K52y5jrkYROx8XTKgCayywBMg5gjc2VHAuKQTRakXFR6GTDSBGvFWbj+YVzWM5ypCkj7DFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 16, 2023 9:51 AM
>=20
> Move inline helpers to header files so that other files can use them
> without duplicating the code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
