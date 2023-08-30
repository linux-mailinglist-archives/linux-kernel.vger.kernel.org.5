Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF778DF53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbjH3TUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244983AbjH3OPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:15:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586D122;
        Wed, 30 Aug 2023 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693404947; x=1724940947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2OcooeeYZEppi0287uIjHFRkbVzdWl+yYaQ6dX0OBKk=;
  b=oIZ6F9INLONW8DnJ/UStuARDHGud6j1DceSwngSjPonRRts2y2AmUqNH
   +gMPW0FX1DxHrJenvCIPShp7hF5rGXfu1Knghm3htKi0abRL98StPDpFB
   2Uo8hxjb45YwcA23GAdgA1FI0Gnnrlw4Q2p9Yn0OjLGvEbIUdEqaTKbIE
   A30/7BzmWs4rdV0cooc6ht2kDuaGzmmAtREgmuLNJNI5yEdGCH1qA2D2Z
   YJtiZPIBOgoapHmZvsz2VwNQ+v51Zy7evkKARx/FPi9H8ioojAC9paxop
   e1oZGpdKLp1PPERgvrtzsZeEJXITqUaA6uCF1Wb1eSvmsTcPC2ZWLBkNu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365858284"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="365858284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 07:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="985755296"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="985755296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 07:11:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 07:11:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 07:11:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 07:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mteWAhuT06RGnp2oqpWwOAG5bJV3p29gfqkhzqYN23vq1UnRitF2iL45ylnacnpZwvsdXsg6BrWeQkDn+rNeK5diMSSdhKi6StdPB/C7UrirY0kjKTIGx9ZScP7FB8BfpPfOpEZbI5qPKW5M8qYnXtwFYHX1OIIWG4PMi8SM+wVBZEaCSePdgP0LpNhMIIarOk7MhFtMIUyonFkT5ggL/lEPAcEW13F7eyuIAPlKsV9bdLhS5WexeSMjGufwa5NaVLDhSk2eBsNSjqy4yhrV4FmxdkZkVbS4ijTeWXYmDuqjPnL/jA4fTpo0vRsTlbQdb5zce4s6OeMbPMGdtY1wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIJXoWyLntdaf9+CDSYvYpilZpDd6olgZ91EKBKT9u8=;
 b=dOjRxygNOd+wVPdDVZIvTFd6zasUYvjPiw8proUezkF9GuRox6VfZ70uqn8l7tAs2/sUngdEthS9mtGVpJYNM+SL60RtHSQZhid/bVE2w45GMTFCZstsow8SK6XbobVnF2/+d0yL5710sxVuRcmxhOHavTOWhDbrXg8UlZ3BG2RuNaNo3wXVCuLOpq3Qk3jQXi387e0zim01G69AOumeLYXtP4kH3sVMq8vKjmCr9ClNPbeglYyP43Q9MlrWUgJ7NxBhXoSx8ZzYOdLgLYz1e8JHFtvALMsNcGV7876jkEq/Rxi2Xww3kfsF35Np/pcSXNYtKOHYwqzl6CI6rEUKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 14:11:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087%3]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 14:11:15 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Thread-Topic: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Thread-Index: AQHZ2tLJaZzqU2XJm0W9Zs4AKdu/JrACiWEAgABVEdA=
Date:   Wed, 30 Aug 2023 14:11:14 +0000
Message-ID: <SJ1PR11MB6083A9F0B30A6009BF00235EFCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
 <bssbtlnjbytqoraiamg7igvawtmlnimzthud5mlacbmjotivhj@hrrabdpmkbjx>
In-Reply-To: <bssbtlnjbytqoraiamg7igvawtmlnimzthud5mlacbmjotivhj@hrrabdpmkbjx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM6PR11MB4675:EE_
x-ms-office365-filtering-correlation-id: 9dfa8799-233e-49c7-6247-08dba962f8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khNlL5LIBVZB4SPdEyOwfKv4RNUE39ywf1lVCPdrssu4mOC03eUwMNeAP2bODsAdJRAgPjG5JO4YYUNELF7Rmy4kVyf+X8+4zGB4xLMBUzfXTzkZqjlt1IT+VazGcYhaA7x0Xsc4xm2D+uJPA3PTGawp9NbRMv6y4vqr6ik9TDwZRP/kKPXF8gcBtsWDICHPEx6IgCNdXcutLV5zlb0jWK+UY8afoCfgC4tQds69ShLFpRq+9uCZcWQVW9UGRHdv3L3l0uFzdoTUV9tG8EngodZ18W65rH+W0vJZHAbK8sS/szI0BjADC6RPpP+qX966voIfsulZntRvNGHdpbmCrRb9fZLkEcF26bhpBzXWpkeNApXmwJlYWZ98vKXMFl682J3Vt7gO9OxGGz5zr8xQWU2LEi+6cpi2BMPmPhiLjzm7PzJrpAtNR+cupvKWu6Wy4Zc48fhJnQ2TYcxnow/5yPfcvpj1ZAIu5u7GMZl9HWQm+6i1oE2V0RLl5B6X1y15zKpusncShqChDIaOUdUvGXTAmxHTQad3niXkDFNSI1Na9NItdxCkldQlqCFv2ykQcJ8FrxYoJbmigqa5jV1ert7KtN04cDne+vsHk37kiC826VBEQzXtEyLPZ7UEcRVF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(2906002)(5660300002)(7416002)(33656002)(86362001)(122000001)(38070700005)(82960400001)(38100700002)(52536014)(55016003)(8676002)(4326008)(6862004)(41300700001)(8936002)(83380400001)(66556008)(26005)(316002)(9686003)(6636002)(6506007)(7696005)(54906003)(66446008)(66476007)(478600001)(71200400001)(64756008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZN/HDV3GzCpOTBgQnpg6CzQCGsaie1WWE7wAHEOiICTRXquoiTHWpJFT8+2l?=
 =?us-ascii?Q?h4yTyTnskaTgwQ5hm+Fe3qOQ4dosy/esOD0FsfszNINHIhZVeu5arlsIRqZx?=
 =?us-ascii?Q?HXYKpN57s9Vaj5Sb+E0771JlpL3bsz/MYA9RB6h26S3jIunluWTlP7kLMgul?=
 =?us-ascii?Q?pzNphGLmer/3fNbmzjkrNjQB8WdEcxtXFUVEXEE/+Nuwevp6Ypn7TmY2MVPT?=
 =?us-ascii?Q?Eribiw99RkJ1J/NoTPOaMydnvrx/vGA0SuTTRmE8Pp3xH3OuMJMImG8kUpHs?=
 =?us-ascii?Q?QLPMSgBy48+0zeHD1bsT3Riez6JMzdV+BI9cDBFYtha9gQklHtCGqkBls636?=
 =?us-ascii?Q?YoKDe93wq7sybA4QDogPQ1Gc58DcdoxzdTyZiRCb1DXi3ySBxCC4Q4UFKCdz?=
 =?us-ascii?Q?b5nb9rrHf8abDUJ1reJA3F6Owf0mFPm2MgUII5O5w3o5BeMNweEoFLeoJ5rb?=
 =?us-ascii?Q?l3dOA883BoS4j62IQ3Yo1A3WS9KJILI57m75W1d0Na9SdRTXHTnnsijzIrDw?=
 =?us-ascii?Q?pP1Cetar8j2PNwsaAFOFBjDdMdevspC4HGY5Xc9rgjoezuAUo/bZwVcYtW1r?=
 =?us-ascii?Q?LFW+bQomtH7rnRo45J8B7TvNuTh8yrf6MfFZKrFcbvxjxb60aTWpT0WGF3hg?=
 =?us-ascii?Q?VqsUZTwilQZc5k+17XkUBj1FhO8u//2JKRIqORzQpKyCTPsaDyJtxWehR5W6?=
 =?us-ascii?Q?1DVghxNa2A7ntFg60Ditv3KsT1WH8cWMTKl+FYYWrXIjSo5Bp2dl4W9Mr0oO?=
 =?us-ascii?Q?VjyrT6j4zP4kk1vKDmuFtnEGZxaqKBN2Up0eZjiXnzb8Ra4dqT+YaXBsCgbW?=
 =?us-ascii?Q?MoPL0haYVGSGs2BzylAt06TXuw6RbIorUr+QDGWPEbWqhweZZpzm1yeZ3Fu5?=
 =?us-ascii?Q?+bhzW8bKzLRJbZqXvA1es8Yq3CicV5uoyd8fr28HINZbc5EyyuSsLWWWLh+M?=
 =?us-ascii?Q?IRCnOISHqtyUzUJkl7hU3kRP7uYdLahds1M3m/huIRYv6jXxDXlZ8H2UsIew?=
 =?us-ascii?Q?Adm3JsY5cxDS3P87JbI3/JAeNZEpbVv0KvyjYE1sthzPkek0bhI9MR9QK6fM?=
 =?us-ascii?Q?mOFmAiGbZie+E7NgDO7umcgURCPNKnpFb0zP9GABnXYsY1Cu+QHd1RN3dcDB?=
 =?us-ascii?Q?Wjkei5T5SMpvME6TX29XswfgwLPawlT7VEDIiw4cX6fNJdD/bnJRQSYDERui?=
 =?us-ascii?Q?Tlkj9RWbdBPolKK9rMtDHeCGIyeYEFDGHcrWBJxNHmDqc9JyfC3hK4G1TRbV?=
 =?us-ascii?Q?8vcXje7kGXW1SExeOr+bBSdK+6+Glms3z+CHDGXNwH2TWgioDBEiN+Af169s?=
 =?us-ascii?Q?SWH5MvPhk7/F4PUda6zfACi3hOJUp31KPsjNTc5XEVDMiv6yj4kAfXlWXc5O?=
 =?us-ascii?Q?kHC4YsWRbw1uFCyNCDqvCavlpi0pNK8FecebF5uNWRabEAEaOllWXvqviUv+?=
 =?us-ascii?Q?FlPgboRcmSAABnpuMHmQoXMHwdUYzkeN02oJyDcrROIhPUQV8+ntTGFXA7qY?=
 =?us-ascii?Q?bR6xy/2YdJErDrJ+Xaz6YMmmgZYDa9nQ2YsrlFzafpMyNqx5jGu64taaj7YO?=
 =?us-ascii?Q?qEDGtViiFJQ4XkuwSpc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa8799-233e-49c7-6247-08dba962f8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 14:11:14.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8IYVUkGdtmc9rjGrzmyq6RlfqJjj+PrEUNNkST4UX0iFuZp2xvGvrEnu14PR1pAPe49ErHGUJDQiA6owRrWJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >+static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> >+{
> >+    switch (scope) {
> >+    case RESCTRL_L3_CACHE:
> >+            return get_cpu_cacheinfo_id(cpu, 3);
> >+    case RESCTRL_L2_CACHE:
> >+            return get_cpu_cacheinfo_id(cpu, 2);
> >+    default:
> >+            WARN_ON_ONCE(1);
> >+            break;
> >+    }
> >+
> >+    return -1;
> >+}
>
> Is there some reason the "return -1" is outside of the default switch
> case?
>
> Other switch statements in this patch do have returns inside the default
> case, is this one different in some way?

I've sometimes had compilers complain about code written:

static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
{
        switch (scope) {
        case RESCTRL_L3_CACHE:
                return get_cpu_cacheinfo_id(cpu, 3);
        case RESCTRL_L2_CACHE:
                return get_cpu_cacheinfo_id(cpu, 2);
        default:
                WARN_ON_ONCE(1);
                return -1;
        }
}

because they failed to notice that every path in the switch does a "return =
and they
issue a warning that the function has no return value because they don't re=
alize
that the end of the function can't be reached.

So it's defensive programming against possible complier issues.

-Tony






