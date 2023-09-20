Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A625C7A87CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjITPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjITPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:03:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD065A1;
        Wed, 20 Sep 2023 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695222188; x=1726758188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Clo/kdxDVut82AvAwirijhjntYxtlNjXhWjLfoT+S+I=;
  b=SAwmzXWOHmZBvmCmd/glhyene5fsI0fCTY3hrwt3fCPP4L3UfsY1PTNq
   LuuOGTaE6MzAfnLI8Sd0KUWKC5GQo19oz7MVyL434CmkXThb9uSFrIuvC
   0e3DQRKjoUMgERLNRNl3Ol4o/ez35xEvFrOY/Ue1eqG3tujGVbpVu7TYv
   i4+yRMmZ/FTtiPYVaPf7nDTtmjMUZfgb+2neKqWfFnnHhc1u0NQVEObeH
   y+mtX/mbDWQxg/Aay2qY8JuRLqtw+qX21GU8RR1m38qOZdE1PsnELwwcf
   Sp9Dn5j4MNFYRjfewoGd7klTJjALWQI5OMJLrV3Ui9+2KzRQ+MmpVdHHZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377546441"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="377546441"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="781729597"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="781729597"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 08:00:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 08:00:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 08:00:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 08:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmEtmZkw6+Z8OO0EJPFl/H//byxeCOEwTpgFVMSUwiAgz6lW92XCvNCUNTJC9Y/uCq0fdkiHi+krEBdMLrAORgG/KGb+sVkTXUesvvPP4hX9jXCxWb6T5o5O0aYPhjwC8rZxm+HKmNJuRO9xjLaVvzCd7D/GUJxXl2Cuj1HdFTFnPyATB7HidVN1Bch8SYTiidjhdIb70QZdz8sjs01BSejqCTRPv7UgLDIqIEJr22GtTa46ucFLdRFsx34HGug9NyNxK2Li2vf/sqhpEZw8OqRJA3jhg6VZx0BOMaLwfGSQ6iJZzQJKwgS9LUwVeQArmFD7/o66claRqJder6L2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clo/kdxDVut82AvAwirijhjntYxtlNjXhWjLfoT+S+I=;
 b=QIOuIqwFelpEDUu4OX2AXgv++QkxYgbgvBgUS9yFF0cYq74Sr+Vd1Ofm0R6WrshVjHihCqL1r2WE9+xYSlLKAbdcU8E4Y+sm6gY2Z1kF3kgaRLQABC+fAqTxQ8h3Kz+aSpvWJxTvwG+HhDxUzgmsuBqzzZoJk1PCyZYfDfhYexz5zMaOV4GztfvnCMTF2PRAzzqjeGWhYUaFSULQSTMG0V0/Jajyj/8kaN1yvvtYUzd30cjj5otIaQuUhUMve1ZlagmGLsGuQobMLAyQ5s3Sa46ZoD+Qp1Kk8eqb5NOp3nMNZo8rdMof3J91RQDfdEXoYjwMi84am6NvcUAt4X12Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 15:00:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:00:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Topic: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Index: AQHZ2tLQzZViQZuDwEGXIVxBB0yNB7AO4J8AgAC3GnCAEj3NgIAAfdyAgAEIEYCAAJM4YA==
Date:   Wed, 20 Sep 2023 15:00:50 +0000
Message-ID: <SJ1PR11MB608385721D0F2B5C5BCB5D0FFCF9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB60839EB5CC3D172D864DF7A7FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7gbxb6kxwa6anvcc4dquyuu7yronww6ztelazn2xllplorhbp5@i7o4fum5tjuf>
 <SJ1PR11MB608362BE12F47FFA54381FB9FCFAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <nchqtx6dp3e2pcp64j7fdeyauarl4funonwkjx3nn5zztgpfw2@2xpb44k52ke6>
In-Reply-To: <nchqtx6dp3e2pcp64j7fdeyauarl4funonwkjx3nn5zztgpfw2@2xpb44k52ke6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5420:EE_
x-ms-office365-filtering-correlation-id: 5a6afd72-e8f3-4e6a-f622-08dbb9ea613e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8U0MmeEfu8Gmw8jHWYSY/YMQXa91+sFEW8dIBQccZed7BCztgFh7OyMLDwDuL01Vvisc5zy/V3mbKu29KWs+W4jU4Wu7i/nkqULb4COitv+ecSTDhGBL7nT+le6/SHgJ4p3OTT348l2WbNtCnsuA0mBW9PgOPDPgLleGRq2F8hdCuXgNfQx+wdxWrSN5jy0q0H+ECkmSUTxASAeqd25hKFMeGHurgBV78EKmZsbm6bzFTc40QbacI0Rwuo9qFzo6PPUB/sQ63HtSVTVGljih0JmNqQhxST0+zPvF3KvNv61Krfo6jbjPWVt/XFxCLkicHYHeZU3qadLl1wXWM4n8U9d8g+hz+qxjL6nqZCsx7M5jHnfs1t5/FUNxryaMnniq4xWh0dr2JvESPQLF6O1Y329U/ULekal86LyRWKvM2P6VyTpEjSUfSeTQss+czrNw6r07+kavK+CYZYMTorJoEsoiKr8heC6g71SHDBNTMs2m4ME/wk/y4h5pvsdY42PH9v2SCwJzrHLCUAyq3qLezE69OWjhc6ksYVBPFOCxUvkjndIeqt3v6VUCXAlUVFuuj0GqYB1mT7Qp0+6zPfAqy/GMskVvKfrnJLgoVnF4vQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(186009)(1800799009)(451199024)(6506007)(71200400001)(7696005)(9686003)(478600001)(966005)(26005)(4744005)(7416002)(2906002)(4326008)(6862004)(8676002)(66556008)(66446008)(76116006)(66476007)(66946007)(54906003)(64756008)(6636002)(5660300002)(52536014)(8936002)(41300700001)(316002)(86362001)(33656002)(122000001)(55016003)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wPkCm8p0kgj+x9oD67Df0d4gMBPpkHMTjX05IWwUe1P5Jd8ZO1MF1Pk2FE7X?=
 =?us-ascii?Q?S586qRXcz6udbDFclvy+BN7bo7oubZCEik7mgu9GTXPNjcsDWfTwkn3mwzfg?=
 =?us-ascii?Q?/CtYP9DDdSUAK4KFDGcbZJDUZURVNexC0ahVzRD6F31NMbvn3fe27NIjKuZz?=
 =?us-ascii?Q?b/BUwS6ue9lBMe9YFR5KJDqFRvEQSziHSRcdM4ApDudGQ69ophYvVHJpWsuB?=
 =?us-ascii?Q?9GpD8zTGC490YaH1kkuTupuxdqZ1wJw8vVeQs4sfHX3GQW0eSZ/ceOk+Hpoq?=
 =?us-ascii?Q?Gl0TyNSY7rFyAlxOiJs+5oISzVO9Hlv++eDDRc7gsU/Zh3J/p3kRdc4qFfE2?=
 =?us-ascii?Q?X+I43lOQbIP82pCMR/EuRhchMGl9cH8Nobp8pchMX1BYLHkmgBEEpwXdWzGC?=
 =?us-ascii?Q?GYX767eAgLhs4oo6UZ8jH2j17wXD8b3wUkrvYIg3xQkSW0O8te0cqQe1AdI8?=
 =?us-ascii?Q?02tNNTjywoAknl7fR5RNbLLf9ay5jagjq4XT0uliIA1apJGowabpwnzBb6io?=
 =?us-ascii?Q?tAzbSQmabcYeaiX7MUiWDb/UuMhE/fkIwS6khE1yY36qVHzppvRLuUDgs1Z+?=
 =?us-ascii?Q?b55cyaqDmPF7ZJxBAyRygRVHDwEphyFvBRbwz9THd3Du05BmMNi8Q19+u2Tc?=
 =?us-ascii?Q?WTMmlA2SCVLXdxrZw/PeF5LBzos6+uILmQhmKGTkzycGylzAEVZ4AOGJ9IB+?=
 =?us-ascii?Q?uDnPByQfleNWCC/tnpdcMf8QKJdG7NgWfjOhEtXo7vM39Vfqc2IMeBAOACZl?=
 =?us-ascii?Q?WUQWoxzIuWujnhNPrwgqDBcu/G7AG4OsHd2+L61krvnngjZ+HWGHw3Q7Otmx?=
 =?us-ascii?Q?BCHCT3kw+96cXxaCr+BqVOl4lZyUz6uXN8AbpiJ9BQ3oZ3qsdVTswmt2kinB?=
 =?us-ascii?Q?KAO0Ra+BqWg7z84uqNkTspCquzmHokbfsoIzqfiC8k70lF47L2KEYFCR6s9L?=
 =?us-ascii?Q?9slSd+nInx366Rt+s6rPrO1/JA6uiC5ZbtJ+CkzhjeIbPWeUb/maXgJdyWHo?=
 =?us-ascii?Q?YgdJcZDZ4g3LxHm6eccsfeshvgz4CqMvE7GdF5b3AYBzBqlJhRkt8C5aEW9R?=
 =?us-ascii?Q?DP33X8xhSTdhmywjqKEdEDnPPVaUMgKIErDsMYXWH7DozFC42DKhyHUlgZZS?=
 =?us-ascii?Q?2TAS979YtWNGptsGZneWWOMcEXZuTdxBXoiZBZgjIiJ6/biBHeT1rPl6Lni0?=
 =?us-ascii?Q?5rmIX79oB4sbj+0T1kIsbraMweNDqdsJiNLv9NFE5u12CP1dPl/j32nCURs+?=
 =?us-ascii?Q?5f+KOP0gsBQERsE47N97QfVsyUCbDsIosE34UwntI7xlzdNhbYyvaFm+Of32?=
 =?us-ascii?Q?Jgq04iLfVOhWUhaj778v0kC85Ps+fIlPQIp+9o95gHgYJNf7m5SUEm/PJJqS?=
 =?us-ascii?Q?uGq/rtEnbZqNz8s6PBEhZ8PEBLdBYZ3W4hDwJWR+6oI0An+ptNOkmJ97fh1x?=
 =?us-ascii?Q?FlbG4qGIOCW3fNquoQt8/KMg8ucFzlRXqke72dW+kAxNKzPDndUvb3oh6To8?=
 =?us-ascii?Q?CQC+IsnFYo7QMoBFlfd0cmDA3Sgs2kStm6X6+CRtMPufiV9vBxBSjKR6aB9O?=
 =?us-ascii?Q?KZwF9S/L6+nhRlHgxlnDMbWx6WdusVAXxoqQ2r6x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6afd72-e8f3-4e6a-f622-08dbb9ea613e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 15:00:50.7965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6E6Nv1CI5DJHG4vlFGWrEaTJ7FbS8Jumd/iZiueSKP93PBU4YYo+A8PQjViagfmyLnBuNKNbOoylz/XUzZWZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What about outputing this value to userspace from resctrl? The ratio is
> already saved inside snc_nodes_per_l3_cache variable. And that would
> help avoid these difficult cases when some cpus are offline which could
> cause snc_ways() to return a wrong value. Or are there some pitfalls
> to that approach?

My original patch series added an "snc_ways" file to the info/ directory
to make this visible. But I was talked out of it because of a lack of clear
user mode use case that needs it.

https://lore.kernel.org/all/f0841866-315b-4727-0a6c-ec60d22ca29c@arm.com/

I don't know if the resctrl self tests constitute a valid use case. Perhaps=
 not
as they can figure this out.

But ... maybe the difficulties that user mode has (because of possibly offl=
ine
CPUs) are an indicator that the kernel should expose this. If only to
make the kernel's view clear in case there are situations where it got the
calculation wrong. E.g. kernel booted with a maxcpus=3DN parameter.

-Tony
