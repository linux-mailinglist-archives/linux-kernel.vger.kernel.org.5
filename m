Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4E7ED9F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjKPDT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjKPDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:19:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43873199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700104763; x=1731640763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DWIbm3betOsGbjgCeMBoM1gqDIqdh5hbL9upEuJUd34=;
  b=USDSokYg1BpjEqmQg0zPaEc33xn2mLQCHLkyJfeusuEj5LRMSvpZE5l/
   AqFiy6w58NAuIFFcUmr3SH0qvPtXwPtpjpLiDMA396vQR1gsW+9RvID1a
   NTTRp39hJBncr/Phs3B5d3O6Y3fRjFqMJJAgsD4Ba3lGHXG1tHsky7zR+
   SeLsDK/vCd+5BLbBhEUp4xAyDsQQ/V5zDio+XubC8lo64wt1WdrISDDE9
   57JXJM4uY+WsOB3BWmiVATEcvQ8LfsiOalnSvypUzp8LJ8SeN+OwNUBBH
   D7nvbtdrT2HSEZZtLMw6LRp0mcpkWDyBUxcC+u6My9f0cX0DICYTxPHTv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="12556536"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="12556536"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855851365"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="855851365"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 19:19:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:19:22 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:19:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:19:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 19:19:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOnhnf3Y6Vf93caJdUSJmiDok8lZg7UGKC6HRc5jkWC8+6ho77vlEZ7rDNJ8G8umNDCEJs0PEcP1JRnCh+zjr5Jxaf6rLNDhfTGSRvFBYorTgZ/ZDIDmY/B7ZLQjvw45SExNg3GVhY1Ob2v4JOFyfHJAg/r1BZviXr3ROyDXf5t0YSKwSAppnn3GBGFF64eHLgJk699Wsc1n9FhYXEZKUyIH/JrmHg5l22fXVYhmFCIL+ymhEzyZ8O5dGbBfxxc09+vhCKS0zjUOjlBkaC8hBFB0maKGohRU7ky2zp3bGyutIiXAMpuAXOMlUxh1Bh6sNfTpcDwF+sT54FtHWrna/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+udE/oNaoyhH93TY7LyaJZLvaMOYxJjlnN4M2Om5rM=;
 b=lB5PWSohJyjmZAgn4MjnVZh/RS10q/ufJx12hlYI2vnqMVCau6Cb8NxCBs3KGhNnbPsp4syiX+pRzgKCJwhWsj9a0r+ZBUiLwVM3/vFFANEFc1d0hd2OzSVQfvxq+tyVqKKf4cKKIVAVvGOtyIZ8Q9bhdVUyZt4elcEnbDjVBhx8SmWvg3KId/+V+xXZTHEuyR1aWxnLmTWKDyyI6nx0eKDRxlmDbt7kGaQWa6CEIW+kMB+YByhCUbjPLCcXqcU49BEN3aG6503JgN6iSNqMF6E9+Wm8omsUj0kaz7Gk9TmQbTSpquqjSEli1+ihWz6tXxTMKzxUxheUmiV2gX6Dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Thu, 16 Nov
 2023 03:19:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:19:14 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
Thread-Topic: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
Thread-Index: AQHaGC/xpSvEePKn7k6kCnwzLYTTGrB8RhyQ
Date:   Thu, 16 Nov 2023 03:19:13 +0000
Message-ID: <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-2-baolu.lu@linux.intel.com>
In-Reply-To: <20231116015048.29675-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: a92df774-b5e6-4311-ce04-08dbe652cee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEwmsOgkNP4mHpf/cszZLl80qytm0iBfOYdis6BcTU4e4lH0hm+UgNdgAGa/USde7hrN9CeFW8Mjgb7Gwo6PfuiuuxW+BJ6INDx0ghot4UwgB9yF3gfqUJcPisP0jYnoYs2Mc6R8vk0jWF+jl0jlPuxwf3fS1Uyt41lFf3GxJbShgc0c3eUFioQa3z0QaOzP4+tIEc/mGAbDfq1UCL/8+MA9GJNwqrYoeTh19lWh3YpR+nRGLE4JVVfwUwBhhiQ+gxIM9IE3csdO+wdc6nnR1s6Ufyh6tqvk/lTvMwGf1k/ySSB+yLPh0RXRlnPOan4A+BLM/tw+dDrb95/c//CUziGdbNIe8Kc+3QJmBID8rp+SyKVV59uBUT6HbYBTVUihSRSmudkwhu5oA0OEwga3ZtrxGin8qLCwMtndFPHwW4BObYsaCYru2D4luSqxTMNdo6w5be68wizGxo2K7OEtob06TSa+58dQqmkWGDhOPSXcu+hVQnlri/dimgfuNRVIwhWxcoyMXByxoKjHwY4cBDfKY6pi66eJNaZWp9rBZYuKv8h1wpXIOqcaQEHTC3L7I1b5mJGKdOpY6CI2rwI/UyDGvCQiv1axWqtJlvec2+WkHI/+EhJ+gUOdykAy/odm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(122000001)(5660300002)(26005)(9686003)(55016003)(76116006)(38100700002)(7696005)(6506007)(2906002)(4744005)(86362001)(82960400001)(33656002)(110136005)(71200400001)(66476007)(66556008)(8676002)(66946007)(316002)(66446008)(4326008)(64756008)(54906003)(478600001)(52536014)(8936002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nK3nG/8quXUHF2gVUTUYX0TItC71KnuAACn8jYhg17i/f21eQJOSrQfy2FM/?=
 =?us-ascii?Q?cdN3m34lpEZSThYTiGhFxgd1PRdnh1tDvDwpO4UcOTLh6tYDcafNRiKtxzbt?=
 =?us-ascii?Q?Yej84UoCt9/w+xVJSCcGnT3iNaOj/cZTFuUqVaf8ANlcjx76sZE2xKlkouDe?=
 =?us-ascii?Q?k1LhgorFxjfA++dmq2NNia33rcowu86klCBKeuZapTt5NkjNo7+QbXwtUkSq?=
 =?us-ascii?Q?WL9eKGmUwP6EIvmk6ILVyq3AJTOOQMpzH/HJCbZM3GxzV9la2MVSSS+am5VO?=
 =?us-ascii?Q?sZ/t1e8PupQssfrwJsrvcPPQ1C7kR7+45ewac0hgmdRRCjr4JFK5pPmLx46p?=
 =?us-ascii?Q?UUzmbJrJEJk31CPpgDjEjeKYPVwm+tqyFK/Ru7TZRFAezAXg6aX2cw6NYbtk?=
 =?us-ascii?Q?w5sTPBTq06YhLmTQ74NqAUaXcrJBaV+65+XYrc3JTPs6zELBe5hIP2nKhcEP?=
 =?us-ascii?Q?BzgnAaa4BXGbP5Z6BwYFzEzT7qNCB8Ony6fPLSfVh818mUQc7+uB/WOoWCWh?=
 =?us-ascii?Q?pbIw1gs6p8sUDzYPTerNshji7vhr9VU1YDJ8LN9F004T9jeMlQ0dcVCos/D0?=
 =?us-ascii?Q?ML6af743Xm+lpwBhw8OBPta6dWbauMQ6baBqJ4ISpLyAqQ2VcqIUs5VurJcX?=
 =?us-ascii?Q?5oJk+zYSdbI3ib4yyNP3xUktiByulk4xEWgFoskZlKqTvk3JWy2U8+2hgVpT?=
 =?us-ascii?Q?NNhoOewlsHXhmDTowY6sbtgq1orxhQpGpt9VAkKgq6tlrHxwa/2jcHerD8NO?=
 =?us-ascii?Q?bnbUUJn33mHFvBVBfJRyu1rmY4O6ZgTDMLrUNCURhvEq7e2e6qiv3IV/0YjB?=
 =?us-ascii?Q?DRUQD2Qtn2IrY3Azo3bqMwIQwsztTJf3okTmqmctlqaTc1em+uxPTNOVIX17?=
 =?us-ascii?Q?7Ob6ROtRYv3RNYVzMCbkf20f9k8jSs++6XMwN/pq6C68hJ9CriPtldCs8VMQ?=
 =?us-ascii?Q?5+FDqOFy0UbzfP9ibeBMqPBR1PK0yDQfeJNtK2PDN/kyAvt4dg7q8zdMpokn?=
 =?us-ascii?Q?Oh6FCZnzHWM5snxunM8ksD459kS1+FA3tTypvmzd23eWq6LZ+EzhJokUyGZu?=
 =?us-ascii?Q?faZ9vk6S+hWDB7muEyglonxLUPwuUELacp3dgxgk0/+c3X2p1ERSkmVOnroA?=
 =?us-ascii?Q?6D7EkBTt8ydi8B8G1Cd8ha89wO9BfsGlQ823i6qe7VrlCZ+nWry71+IGKUY1?=
 =?us-ascii?Q?Gvg359sqAZrO0c+pFUorqfxbZ2IZESP6hlKFm8DO8CNBJh2POr258WJmO+xZ?=
 =?us-ascii?Q?FE6g6eKa/IfAYF11dezDjYhpUbyqE4kgJl/v1REBzr6L55Uvk9+H6pGqTiqa?=
 =?us-ascii?Q?RNha+Pdv2lzTMebi00o1/T1ZgJVO0zUqSX0s6y7I3Ps56ThGfEr1MAZ/FNv1?=
 =?us-ascii?Q?M62xMXP+TxWej5I0ZO73JYQS+gdWNBVm8OthIabKDgLFRViXX4T3FrgtfLDg?=
 =?us-ascii?Q?3+ibiczU5FD2pb7j70CS4uYEHe33226k17GRD7OwCNF9T4nDuNz9PtalwD8X?=
 =?us-ascii?Q?kqcspLwxg0dMxUGazkjFASv7m6KUyij4aP4CY1hvWDoFOFnCGbRbKkNuf15A?=
 =?us-ascii?Q?unN0WMufi2Rsi9aRHfstjgLLQ+PshL5IrGYRqvtF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92df774-b5e6-4311-ce04-08dbe652cee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 03:19:13.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/v2S12r+zZ92FwZS8FoNLGqfbZD3fw7508SL5NUk4n6wePEOjlr3zfrL4gdLiuoVaEfFJA7dp3QaK0l5QJDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 16, 2023 9:51 AM
>=20
> +static inline struct intel_iommu *dev_to_iommu(struct device *dev)
> +{
> +	/*
> +	 * Assume that valid per-device iommu structure must be installed
> +	 * if iommu_probe_device() has succeeded. This helper could only
> +	 * be used after device is probed.
> +	 */
> +	return ((struct device_domain_info *)dev_iommu_priv_get(dev))-
> >iommu;
> +}

Not sure whether this helper is useful. This is only used by 2 out of 5
post-probe users. Probably just open-coding in all 5 places is clearer.
