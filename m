Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EFC7E4FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKHFTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjKHFT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:19:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B3D79;
        Tue,  7 Nov 2023 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699420766; x=1730956766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhCcE+gQM9rshDJce6PN3hZMG7Xku+Ee5mJcGHmJEmU=;
  b=VfbxPspIbkktGNPG+q/+QyZxTM9Lw+ZfBsWXvBUmzx8lE+A8Vz04aEyG
   tmRG0aRc/7i/lPvhqhXVrE1M1C9kbaRk/MjV8WBRS0sqkpOW1S0mQyPhb
   5uPIespqxn4Q74iaQNMgYUpIHMvhldCvlcnjbVCdLeEo7HEQgsllylwr2
   9OYkLz4KWGtnXtCADjpbMYjoJaE/3qnjWLS3+wNR+C5whBkwtnYxdWTA2
   3qxdYBiPDF/po41QTmMLY6PG3cZEJ73MrRb6m5h8QnSlwz9JRIiWzqhiR
   RSMJs8kYTtUt+W5LFNU/AqeX5xNOPWtD18oNsXGomih8EdUh/ea02N2Mm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="453995337"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="453995337"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 21:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762945256"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="762945256"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 21:19:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 21:19:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 21:19:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 21:19:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDUZKoJhVewy1ZLS5T1/QVoB227dlG7GJErgDaXXjd8fNMYz/olMU00AarNlUbCgf64ZmrkiK2M4fYPYR7b3kooc3jvy/B74X4hmfqtzZZoF6Cn4GiivuXI7X7G5t97jVQHFWLRP+KYcu8895hdzCHd0SZLJ5Tvtka85wz3grKDr7Q8D1OPlgz+RTdzzPAIx8l2V/KaN4xHNqsalx26LO8D3PbOaAXcoLba57E3qFmOzW9Sy0JYq1K0S/mkjXQZeW+/o7a6Yn+nBHfMVJqw+O3O4TOG8ArMoWyCqFcwEJwD4R6NWl5aq600tZAzQUCNx2edQgjPcBudRZuNv+H4idQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCs1kYVrg5qtEDi/MlbmuHmhYJWEcI2JOZXK223Ejc0=;
 b=Qe+CBZ7FS8vYrjuCGXJcVa2UYH/jifRS6PC5x65cE1p5iSlIk3pbBawwXAkfowwTqQ14tvxOv74s+xbnckO6tIJzzgSQXCp9EJ5ek49xc+JmO0yZFMU0b6FpUqhgBd1ULmLisagV0SPwmOWKcYFLqBlhl/va/SgntTS8BPDl6hzeTt+fqWVelywI0U9GcGw/Rc6GuiMIKvep8QQYhHBOZYwkR5DQWqgDZnIW2B86jcYD1johYPE9D/JZisI8DhDk8PqHr4M6RxG3Qj+J6hr3vmyoPYQzdVYAtv3bF5e3J+5sWTvaQ2qZ4R9pvFcFlKtNr+u93jLCtxomqeoMIAiEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 05:19:22 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 05:19:22 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "dacampbe@redhat.com" <dacampbe@redhat.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] i40e: Use helpers to
 check running FW and AQ API versions
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/3] i40e: Use helpers to
 check running FW and AQ API versions
Thread-Index: AQHaBlHxd+116QnKMEyu0iAjrnj8SrBv+Ghg
Date:   Wed, 8 Nov 2023 05:19:21 +0000
Message-ID: <BL0PR11MB31220CBA21B212B950DD41FEBDA8A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231024081211.677502-1-ivecera@redhat.com>
 <20231024081211.677502-4-ivecera@redhat.com>
In-Reply-To: <20231024081211.677502-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: 725616b6-6aa1-46a6-7179-08dbe01a4420
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7otkMG8a3pPp1sSBucvE44mXPixbWex8jegDwWHXG+0XOXBGkgNNjGMSENr9YnP2L+NZc0Q+ONcQuk/JOBAn13ki7VpUnXJZjlJ6y3Q5nl6MMRGGBvxARfBz/2Bp9hsI3UPbyNQ31DnLXtXuiWplyMpiJK0sBKkPDzFpBIsfh6T2XlVThquntpZUJ9cey5nEUw2WgIo3J+YWKoRtzMlbS8Ezy8b/Cdxe6SylRlJdKJIomc2xQbUINPBOZDV4kTHg9UdSZ9YTtKrVjN6XeZk1xdCdVXWU33l9qxyiI1RymVbagsIFoyGgPTdzb6Oc1IrBlTUK+qfXgO5XpXQoTfu3RZaBgI076QQC2VVCxbEnjF0IDTvIdBxF4/hTARPTXjnUAR2U9xPjU41KPRe8q4GYOxC49AwXovZyqb/M6LuYAEsEcY7q4lAqh5eaOUbOs5E/iXWd3lR/1jzDRpj+pgMbR2Ys/gs2hQTLVrquIyniYmW71Xzd7t5TyBEXGiu3NAmaeNWrBxri2mD6S9WePdwqR6BxI2jmMDpXVWQql/VL3tAlSEjs99GErGwtP4nJyG5xeJ04Tupr34FccGhd1fjJEPukvtqqh967qGDkep6Al/MFDl0J2giUTjD5MYjEhrfn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(71200400001)(33656002)(7696005)(53546011)(6506007)(478600001)(55016003)(9686003)(110136005)(64756008)(54906003)(66476007)(66446008)(76116006)(66556008)(316002)(66946007)(38070700009)(26005)(8936002)(8676002)(4326008)(83380400001)(52536014)(86362001)(5660300002)(2906002)(4744005)(38100700002)(41300700001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0AbVLDOHRMo8oIUDGG+5H5JE++7PLigWMZ4vG3pPo++XpeFqWSXTkGZp8Alt?=
 =?us-ascii?Q?nuG3obgEukSBStHc4T0u+J18Fz80LEycQuP3C++DYuejBsH/pt4eDlx1R8UL?=
 =?us-ascii?Q?+HjJZJlk3JYdhK/QXNQC+l+/uxagC161fM70cHYmjv/SPgkzT7hh+s9gXLdo?=
 =?us-ascii?Q?wDYJKpxxDn3AZgJH4DUvz7k0xXmLe+/Ke3Evkw8h58uaEqxe/nYI+KHr5Nh6?=
 =?us-ascii?Q?4U5e8SzzwjI4cFX23XiO6OU8iDQG0zcCwHVhypI3Y/62diUDilWEm31amnHn?=
 =?us-ascii?Q?sXBbT5glqn9lzCorXE2nZPrVwLTIaYlj59z2yCDeiZzTD93XjtuGPC3y2NTc?=
 =?us-ascii?Q?CXESyVx/3vyIby4VGbiSHkr2m0R21Cyq0WPNwry0Ksfi3ydBwosLzh+CJHT4?=
 =?us-ascii?Q?AbZhZS3cjtjHzAPWE10Oce4Za9pjU8cWGQIrtIGgj5JY+lzhf+r5qgxBH5NB?=
 =?us-ascii?Q?SwCbjWx1iEAxACUvRgQASKyRwA++Lfmz+RdMbiJnSBGWVvcwtMoCkEjcu8t3?=
 =?us-ascii?Q?QWahLtYvZ58SZP3h2FWa0w3dlJFfn6Ch1xPlLeIUJoYdmXhjonxnnMJSlBuc?=
 =?us-ascii?Q?2AIrENPIkqPyeXUF4pcCVmRSu3p5gMMEsk0QaqqeFyYX7aJAI0JZySW5JN3y?=
 =?us-ascii?Q?5jplHZcyc8BGP35uE255mMYAbi+hH5vlayFr4VdJAAQxy6CRZZ2XJJox6LQw?=
 =?us-ascii?Q?iyMc5CfZEzPok68VXQh4LAeGqWvMuL0ccOkPk8g/G6tXnXUKgEAXvkvc8JPu?=
 =?us-ascii?Q?Q3Ejr+AVdu1pHfAoLs+HlCDRDE30jv22jJfW+zoQXsYWAAncV13uLP6tyAuE?=
 =?us-ascii?Q?wCnBURg3W072MII1yoeE2CBnItw7QiXXuPzCaWyIL374elB5aD17gLjBihXD?=
 =?us-ascii?Q?tU9c23/iA43ImrRzX212tQsHiuPrtwb0krTleF9/M6IlzKY2n8jXY3RSMR0u?=
 =?us-ascii?Q?CRhNpdy3Dt+CbBIFvyoZbJIs+NwEo+cORaQaS1pVtLT7e54GfveObxM9S8OF?=
 =?us-ascii?Q?VKYmZdbXCbvQAwkE2irrTyxipXXANnC6GnqPzdUBQard/zzHYXHXSS+IVc/h?=
 =?us-ascii?Q?Xe+M1GGBO0ZW+aPc3QCe2R96PYth4EjIW3TZlB7ibEyOP9OSzQ5++vb1xzIX?=
 =?us-ascii?Q?FoRwgZxEkLbSvfi8wWAD8O3iVBq6LJX0cGxvrzaVD71jHkdzoAeJcjB7q90V?=
 =?us-ascii?Q?Eas4z1I51MX3/7Zxyzx5FTJGoH5yxaHU/RFUD91Ptg0Mglnk3xL030Z/eFK6?=
 =?us-ascii?Q?lwZFMrxL7lxQKhk3vvqc3qiAqnzYpgT/2nW3ctXpthvxY6Xswb55QwFH0ku9?=
 =?us-ascii?Q?PazVeeAm5tRj7oWaxn21GLaJZjx/FkglgIM6lEvBh4ZpgKTuSoIEw1Y5S2OA?=
 =?us-ascii?Q?3bEJ7Tv+veVM9lzmod+kRt+whk8N441MYwf+OoRBBVmoq5bpNuqj5rxQ2Vrn?=
 =?us-ascii?Q?hQ+68QN/OsG8R0U96LY3bqfejZjRDGWLtMaqX2ipVlU9TzpZ88Pya4K7TB7u?=
 =?us-ascii?Q?lGptXIlBcajrnEEuCn2fJ5cD7uGI/wWGZs5mcG+sVoQpb6VpJuDU7sQzGLgj?=
 =?us-ascii?Q?Nz/d/lZDBpr4U1Nyua0W+PvKEEpxFbKkmiW+UcCsiZD2Xodwhz6UoEOGeBCR?=
 =?us-ascii?Q?p6wIQKhGb4P4bHtndHv40Wo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725616b6-6aa1-46a6-7179-08dbe01a4420
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 05:19:21.9780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6v1cCJmBhN4vt5d/sS6P7vspj2Zn8jSEH/7nxya8h0LoBqqjhdkTA8L4JtNUrGwioggUlz5bDd+DsaW+1bZkYELbOqzQxuxh6Iya6T8U4W6mi8U5ko5qTVit9hFNj807
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Tuesday, October 24, 2023 1:42 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Brandeburg, Jesse <jesse.brandeburg=
@intel.com>; linux-kernel@vger.kernel.org; Eric Dumazet <edumazet@google.co=
m>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; dacampbe@redhat.com; Ke=
ller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>;=
 Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/3] i40e: Use helpers to c=
heck running FW and AQ API versions
>
> Use new helpers to check versions of running FW and provided
> AQ API to make the code more readable.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 56 +++++++------------
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 25 ++++-----
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  7 +--
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +-
>  4 files changed, 36 insertions(+), 58 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

