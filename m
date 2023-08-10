Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603CD77758C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHJKOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjHJKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:13:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39310E9;
        Thu, 10 Aug 2023 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691662388; x=1723198388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AznGjUuUepD5hhfdVh/YZQa4sIk0tWZjWcwKuICLFN4=;
  b=Bd4lyYFbOTrJJcGeXg8pErdDwC+MGyye5lFb1shjJrusHjwKslMrLX/c
   RCGoPvzNl8H5MmO6fEJZvh3i1QQcyNnrKjQu48yOIOvCf7DTtNAb5d9Oc
   iOfC9wEk/Aa79FP44kEQiawmjKbnvT6d7P8C49KGDHNtd7s2qWogjS6fA
   DLkb6ZIKQlIhCPS+4VeVS0NyW0zY23NQS5gJbhjGP1xlPWnmZJnmtjKrh
   YEU5+in/BY00ZEoeRoeZWmJCqh0FyQf9V9ea3QjxFGwmX0qcHFHJYjQEU
   w3OcXUHZzy6cCETrwRGj3N6qyipY+nys+aTu7HSJ+Eq0k3wWVEDWXwArJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="361496800"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="361496800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="906004335"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="906004335"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 03:13:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 03:13:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 03:13:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 03:13:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 03:13:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg+YVr1S1l10i/9zkXfuqy1EiSoQB2ErrefTOGpJaaZYpMbnmWPAyWit74upAqD2y554JYTqVlqgmVqTOQQvzky9ATVAJyxuo/OrgkS/zYNKbAUW148TD7DQ++xtagMO6sqbp2W3+mN5jrfLUMU8vkTJK73iRhMaCindx2z7EZS7zgHELH02dBWq9j9lP4Bq9lCaKanZX0gf0G/Y+PNui4lkpQI0Fl+zln8h8vSpu+swWXIY+hrop1skTUHtyDcf10Z8497xYQnNzWAJDnnHMEOQzkHdYybm1pZJ1pCQTvvvIjmcmVLWgDD5IoeGs9duz58mm+bTLfLTlgoXOHf/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AznGjUuUepD5hhfdVh/YZQa4sIk0tWZjWcwKuICLFN4=;
 b=UBRkLv0HVS90FI7jzIUltdOs57GmXoaSTxPHgx3sAQ3mpG0pge+IFnN3n5UwVqHgDzC9HAfSSxwiIniZWWhkqHCdgGGozIk3EdQDrG16c1FFKDXVIH4OEDl0Sjy313eAhXhy5G+gHqWD7wK/WPIC8d/WESl6+JZgw2GATZWiqX6QrnniqAqCvAk7YcBR4a8hT8SgXuXJIbEzjdRkzH7LHzCe8EtRlOU1ZT5aVMqlfsAm/o6Sps1Oj7iWy3ty2MZtLft9o7F8qU3RuIDAXtm9ZgTmD1hl8bxYtx81Jrz8dUU7ohWQ8Ntl3VKXoKwIBF/74R6+pXxtLyCBz9TZfCavbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 10:13:00 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::f04:5042:e271:9eec]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::f04:5042:e271:9eec%7]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 10:13:00 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 4/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_aq_section
Thread-Topic: [Intel-wired-lan] [PATCH 4/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_aq_section
Thread-Index: AQHZxP8nAR2Jb2eCKka8a4wo7rN7Fq/jXBeA
Date:   Thu, 10 Aug 2023 10:13:00 +0000
Message-ID: <BL0PR11MB3122A0252290B39A83732948BD13A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
In-Reply-To: <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ0PR11MB5770:EE_
x-ms-office365-filtering-correlation-id: fb889d9d-bbfc-4613-f586-08db998a606f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QAVklzDe2+xJ7f5crAxFmi8Lmj6h7ZgpLMtfijs0+DLqJmHtS7Pv7KrdNgaQhBSscOBL35A11rY2ozWXKOpskho5C4ylM+ecSIVCMNY6RwPOhDzMPm7ert4Qnb9PHwHlIe0lS0rNDeb4v06RXbhUxOdTZkyGlBwE2TMLvcVthmjXQq+2M0/0cTSVAVZK1uCsVfogKWIEepGk13kElDAegCyZ63XbwdX5b/Z5vYsx+fNj8wQAUvN2jNUoPhot8uHsTbHdbrj4mqFvuPBRrVO3jH4TCwXT0WRahRYLbSjCkCpdkDIvw8lzlgt7UYRNaXHSPrbvs/mBtZtKSsE7BwnaM7DsI4G+6KKTCMpFEbD4mUzt9/+v4SYMYAiuq9N8FV/ai9swQjwu9xu+/5xJwh4gjdR/GehwSUKAjaNYdzkFeSDKdqvFtMBFmW5uKzw1kO/cUxd4eNrH6TVNI3HUxCxgU49SBYPhODfw2Np7lnt0TYUV5z/VZBqpf4QN8kGONYQjkdEAF1NuMXEboqwUbMlHaWwg+IQQiYkP1mKEvOb9ylvKGgt4HblQv6DzVof8d8SxWEvjGmRthcgqkULXUQIFDPv/Q6DkBQBOpQGaj4F1/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(186006)(451199021)(1800799006)(83380400001)(55016003)(7696005)(110136005)(4326008)(4744005)(5660300002)(52536014)(8936002)(64756008)(38100700002)(38070700005)(66446008)(8676002)(316002)(2906002)(54906003)(66476007)(66946007)(66556008)(76116006)(33656002)(86362001)(82960400001)(966005)(478600001)(122000001)(71200400001)(9686003)(41300700001)(55236004)(26005)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pGf7yYQ2z8TbAvk2d43JqH3j1rglD6DaJMJF9Brit6azUqWfVVtda+WjcnqQ?=
 =?us-ascii?Q?Q9RiZfJfJ+EDBywbPJs6qosFvphK0x1QeK3MRhEkjhD2t3MMfVW4/tCAuLfP?=
 =?us-ascii?Q?1I2jqotd4jIQtlPCkQXVKL2CwxjNCMHtCSGEMksqdfAsgu4cwV4cDs83BwM9?=
 =?us-ascii?Q?HZxHJZCmshrg4EhxC/xwPuDa7mc3EKAIgG8/KhoSC/yCfipoV9QSXzWtzgVc?=
 =?us-ascii?Q?jOE6fcNN/uFC50IYRs0ON9tlaqi8a4ur12Jxrk7cWNnmxi8QohtqXwX49xMo?=
 =?us-ascii?Q?QclIjl2VULSmzpvsIzMgHtGsNSX7mNpGzgYC72KdtZJr/XM6HzZjcDDQM/Cn?=
 =?us-ascii?Q?QKd7vDQHXSo6ZbTt5ayTAuVuDajKvTJqOtRX3QDPHDf7Dyldu2IkP9+h6cGi?=
 =?us-ascii?Q?UPqV4sLzQrQJZ9s/kkRM15bYpRkySn5ZpAhBb9V0C+JfmJTsfI8RjeigyZuo?=
 =?us-ascii?Q?ZEeaiqaGbuE8ETsyiTVCejqYHJKf6J6jIkHlQO8C+iYz5VTOcGkvc42jnder?=
 =?us-ascii?Q?9Erap5QTLBRA9jYgH/6ro68/dsdH2JQV05qdC24PG0nUID0gDLhPxpgRRcx0?=
 =?us-ascii?Q?kFYe3d4dW8dawl3RTV6ZV8BxLELSGEyTLwsa95m6IAGKsQvUIev/oBOtUADX?=
 =?us-ascii?Q?C0i2vN4rdqz/64BP8XSaQSH0/RxVeLXCTAhR9PCq7WzLfBieFmfUOPFbUDpF?=
 =?us-ascii?Q?xCL7fY43zVX2bHHmKCXHptOLcuVVJY/WYz8RyF1JFQt993rwYsUmYy4RvG8b?=
 =?us-ascii?Q?2y8If9ZqkSsCiEvme8qJOfnujtWYLGC/gQgJDCw2nJsUfJwms7PLYUKxS25L?=
 =?us-ascii?Q?W+SQWDgX5YnNUbzYVHydTBO1nNnwPWFGADt0YeLdYBg1/3HxusaoxOvdpLqz?=
 =?us-ascii?Q?rKISH8DgtA6YfmGS8L9cjN7oZ5nlE1K0ZgPv4lyLFyaFqQz+bm/mX7rVne0r?=
 =?us-ascii?Q?2oXmF6WF8eBpBSUsDn3P+xaEcatwicJUdnPTIb95cEpJzE8NmjGB9nuEhQIQ?=
 =?us-ascii?Q?ffOQsHip/IYNUAvv9tf0LszhY498Lb4PmP9IfmZ+MxN4PBYUSMtVTLfqdcLM?=
 =?us-ascii?Q?aLO/ppylDAUJHR3sBqoJE7zyTe1H5OdFx6JugT1fd/8DkdqFPkr39EYJKIDk?=
 =?us-ascii?Q?ndGSFemHlzRJb8QcOjiXLk+NDD89RDIkpSt76FO6KgCEr+Qgy5v3MUNHDWhb?=
 =?us-ascii?Q?kEP9nDf+17sAsWbzfCwf0eu7De0AS4ntSDrB2YzoxuIP+cRKElXUccxiDtkC?=
 =?us-ascii?Q?BTQb5Xj6WJfvSDxDGjo+lEsn54/X7VIZ8AFWgmv7+2d6JrOIRC4eql/46SXI?=
 =?us-ascii?Q?CIFR2hLTff/CMK4AUdCXEAhVOF1KMj7IKTdazrnRMVq7/VrraO9tIIpiGPBs?=
 =?us-ascii?Q?KCtm+z+WdpNpyeug4wH73b3j8peV2cYMV+LZ11MJmrW6TY5vkQFjbNwIF/g0?=
 =?us-ascii?Q?f4BZkpDLDygErbFwcEavjTM6ypLkUlOtThX/uS9NdI3Tgsi3uCFXmcKnv4QQ?=
 =?us-ascii?Q?MEhIjuUsEBx6yRsOodTL9XOvfz8mcz2kKiJ8n1fZtxOphZpMtZx18L5bK1z8?=
 =?us-ascii?Q?X1N9FOFFdZh8vZA/FsBd9HnBjDinRNnSXkzRG3rWDRiWDN7j2C0HGEFrIClf?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb889d9d-bbfc-4613-f586-08db998a606f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 10:13:00.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjmO0KsJt8u9ltV/z/z08vG4rPpfguh/XBPEyyB5leVxUa7Ssp0lyQUety4G3IMn77q+aZhTxWVJTkviMnevOwCSvzE57kB1uUACPkqwkKSUgI13TlJH1EIVgFzuWu9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
ustavo A. R. Silva
> Sent: Wednesday, August 2, 2023 10:37 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>
> Cc: linux-hardening@vger.kernel.org; netdev@vger.kernel.org; intel-wired-=
lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gu=
stavoars@kernel.org>
> Subject: [Intel-wired-lan] [PATCH 4/4][next] i40e: Replace one-element ar=
ray with flex-array member in struct i40e_profile_aq_section
>
> One-element and zero-length arrays are deprecated. So, replace one-elemen=
t array in struct i40e_profile_aq_section with flexible-array member.
>
> This results in no differences in binary output.
>
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

