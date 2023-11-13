Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE227EA1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjKMRdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:33:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C91702;
        Mon, 13 Nov 2023 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699896827; x=1731432827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SAczsaVNtkvgzvDgxvoa8A1O2FfS9m9xGsKsZWvdzJM=;
  b=Edrl/eBn6BEQ9wLFN1F1n2qQ7RhC5/WjzoljNiyFfWdf5ZBycEM677h7
   JprXwLslDnyMR0LOjKMFdwW6RKFMRqb4H9ZugXmDoIuXGVYnhd66E1dAW
   mRbtPp0l26nW7CbYabHpRBJervlNqrbgx6oAdIYaR4e+3+Nda0fhZqOlo
   U3muYNfHrWjldXXfvqVEo2D99JjfucBu0s7aPFSofKQhP/axtb1r4pTEq
   fkA2ZKjgSMvsKFwQM7t6UuYF0X0bdSK5exBDb26AdeEACPMvHm0ZBjze0
   Z946/+bwKXfAnkzw6TB/YI+cR72vom3Wn1m/uwes4ta2C/h1x6FEJYrq0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389340328"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389340328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="764394267"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="764394267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 09:33:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 09:33:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 09:33:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 09:33:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 09:33:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RthIG1JKeYbmjMpAnh5ExqDkrHEmdYUoACmXJnnTJTYKy0lAsw/JjSyQpMyqphBcHSCVa+JS5rIkjmOKviiqHGQkpsJfjtgjavkWdogDCi8hZ68Nd9rZGpcWKYs7GTj3MuOMg0i09u/HnaRTZOhKp2+rN9NxSg4Lc5T6f3HHDY4KJpanwdgRvq8WXa0GrroHmhC9n5xNGqUn7V3yTGj+bvMuEB3FwPL8OVzLXfbclSAC8ZBPJoewYazKmtYDcf7teGKHPuesguZQJTcL5ILlW+L8Cn1G5/yRq0eBt7sp9PWnuauGW07i77K2zT5dAmJAlD07acy9PipKZKFBjqTnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAczsaVNtkvgzvDgxvoa8A1O2FfS9m9xGsKsZWvdzJM=;
 b=jOCBThXRW6nY85dBAeR/eTd6t+4T/2zl3PIkJaTXB3h6Ys3LEqiRxt0Y2Fr7GPhMUZTiq4knKSrBlRmK01iDP3zXUtjdxikA6udbSD0vIVhHdVBwFUbCennDqo8wlGyE7kpBoy6f3CuvgFwUs5pQ+O1qtxN7nCWPTSjSl0jkFTcYtfhglFoIspu3luTgIALKqj1wUASPcUnEnKQSCpZOu3KtQZ1f7/Ah6A5vpvor4+VQOuKETeudTlEw5EcH3jae0gkZbb5kLhed4kiX140CfpMDFb09PO8sdFm9ILfviW1X9O5U27xMLy5oD4Cv+FaBDkL4he+P1tQBNhEmxG6S5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:33:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:33:42 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v11 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v11 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHaE2HZGNIT3KiC+0e+pca2GVOM3LB3sdUAgADWMCA=
Date:   Mon, 13 Nov 2023 17:33:42 +0000
Message-ID: <SJ1PR11MB608341DB23F8558166901B1DFCB3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <TYAPR01MB6330461AE38D0991FBF62A0D8BB3A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB6330461AE38D0991FBF62A0D8BB3A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=5d64cce7-ed31-4539-b02d-4fa91c491db1;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2023-11-13T04:43:41Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: ec784df1-9916-4f9c-9ad8-08dbe46eae10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z61SC3dSTZCcYx7ohB1hubXZYhCiN0tsrnml57/5HLXzXUn8PsogihH76mbnejbtPwV1VbvEJz6xvNkj3m4FfejmRJmR2SpezrwyXspJAD9iq8RMpmG5LbdVV/Qw1zE8+55rFTYNEnehgjiXKxluq/W5Dew+L88SWpVngPNaS/VyLHxxstUVQiEK32vXzUzlEc+j4T3MJ9F6cWuVEpYuXfq6RJrmVVRmpYvKFksLnwCBbd0/UBpjz7krGFRplCbTlgkCdfV7aLwkGJPTLG4nLW0U+EF+VInUU3Tflrr4gIBHb00/Tu6dYvgvVu0vP2MOSx2yQ+pDlTxHmOMBNQn5QOAO+EHS0upl8FjhctnHHe/GgeRS58TBnv6MvrjQSDqFOlPmP9vqnimDWbLy/jwtf1zHoLanJj66RTJcBlE7harQnVvCbZvhbxXRj/5bkID4VqVsACEFFj9IBhDad/pdaaZVQVTCp08A1nCnZmDLJNEwfgSUdxmXETy9Gto8vrKsBTe9pApbZ7+msJ9h6Rgshebp9B1WD5SvsGw6hoI7f0kYHoQpL1tlmSLj5A43SFPTdd//JyNRDB/0uu+XpfWo286XHSBX8KoTs8IB2Nu4D91EKV7YNdDtHWCDSK03GS8U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(66446008)(54906003)(64756008)(76116006)(66556008)(66946007)(66476007)(316002)(478600001)(71200400001)(7416002)(86362001)(5660300002)(38070700009)(33656002)(41300700001)(558084003)(2906002)(52536014)(4326008)(8676002)(8936002)(38100700002)(122000001)(26005)(82960400001)(55016003)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NAZJo+M+KMyeqkJUP9t3c4hjSwYF/gWWkMU1xScnRb+6qXCwwd/TbfxlKJnx?=
 =?us-ascii?Q?k6liVuAy9Q8Gc5UtyxhnxlErzGm6diYoUqlVyagYfyEkloFmZpNPsZcXzh32?=
 =?us-ascii?Q?iISISQdH3UkVknqE9jqJZN9/iITmzEeGc7weICDtvm1t90bbuv1sabwo0KTY?=
 =?us-ascii?Q?ExJzRl8j1agdsZf5D4+83jlxW6TvYnKCStp+9LpY/Q5Q6sXYst3fHxteTLWj?=
 =?us-ascii?Q?2GPOYqGl9vd3Pdlqbph63BE7JFrCHLzU7Od7oNL76dR7CsPBcrI346nxmt8n?=
 =?us-ascii?Q?PCWe97RzYN2krNEy4enAebE6CBPoFyCiKYdxYNXkcOnXtFiAWJIguzEY5tu3?=
 =?us-ascii?Q?7oPUcijsHuIJGhPtFDniPXh0zOOvNB0Ul5q5E6hsA/DQ1q2I+zqgVtrJaLq0?=
 =?us-ascii?Q?ytzC+GPRM1lK2mUqZCjRo85WCotn1ycTVsmcq2McjsyB0+3HjSo+/O8S+Qk3?=
 =?us-ascii?Q?JtxBHNloH0dRBmYoBQnYOyYKsGABV111OGJCbeJyUyi4JyXOtRfJ6QDlmkk1?=
 =?us-ascii?Q?BP/a8YJ80arIOCzN7O5+wYbz2dkyT1BnasDzpkowJoOa1d3EzthQw8dnrMlH?=
 =?us-ascii?Q?L7EtuhTPmA3RiBvQwVh/qunwMehwq0owjFonEVTagWu+mPZRCIlUpDqiMZkA?=
 =?us-ascii?Q?11H0L+buEtqCHyD6su/iMYbKWX761TbgOJNFrAryS94WCnb1wqg1+XxepEem?=
 =?us-ascii?Q?Zt7CtGAaNzfAwsr3lzmuBMCOovsaPLUyDXFBLFac2v5X5e3eHf4YzZaX1oIo?=
 =?us-ascii?Q?87Fogp5I6vyzTtjSp0lVLrWkUbfEQ5SkKh1qHQw78kPJVDyWzhHnjfONHKQ3?=
 =?us-ascii?Q?ZDst/eQJPlOb7axLV1QasdIwMwEg/7DvXE8QJhE9pmtsroFfTV9+vrjvBDjy?=
 =?us-ascii?Q?FbBNn512UPToP6HT7ve1n3VJUWBjevMJu/C6qCFgJGjoOGOWQv4zQNfGqUxP?=
 =?us-ascii?Q?V7wCdd5MB5GxxKtNyylFr4gBpAvlPpVJOuRNW7IM9+N521rVa7SHHONa9uPl?=
 =?us-ascii?Q?0rHW3n7YMWM0t0Vwu/Tg3BUUBl12OmVZ/1qifEbJLjNaeK2iBKi0yNSAyvKh?=
 =?us-ascii?Q?VZM88JFWbCs0H+c+HNhwjW48wWxeG+I5oVKVULaKgbeN3/DP/LLdDMY8wo1q?=
 =?us-ascii?Q?o6ekpHMJ7U8Led0F3tge7506H1hGevhIloC9ougyfOrEGDUCPy1YMPvqlpZR?=
 =?us-ascii?Q?WPX9AIaQykIyp1RbQlGvvBjbImZ9SwdFhsslvUbKscldRq926i/0pB6fqZSY?=
 =?us-ascii?Q?0XgX7H1C5uiTeCQmHOACHc5VxuRIKfwyByGN07P8ZLP3/907AGbmIKqSZzEF?=
 =?us-ascii?Q?ZDJpfWtL8zYBNC1+K3Nwhd8+6gIYHCEDpN4fH7UKtwxEQn71aP/iV+xPpHNS?=
 =?us-ascii?Q?PLVr+nFIv4oOMJXY7ws5ukksVXo9N1l6AQQ9/JlX1mk9XkzdzQLV0Ia9t9s7?=
 =?us-ascii?Q?y+F+j67FhzS0dkmpCa3XYgsf9W9sRdcgqbRiDXrGZMX5XubIlEKOT6YGLroZ?=
 =?us-ascii?Q?rq1MN/+VVwn7qrH86HjkQSn/mSKA7MCmQMEu0i72L2XMmb7NWP0SH5j8P0CT?=
 =?us-ascii?Q?LWMSggtq7dxVzEPR8YWCcfQjHyoKOa32LUqn5NWo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec784df1-9916-4f9c-9ad8-08dbe46eae10
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 17:33:42.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoB/mYVPZLx7tKi/cKfFPObSk66dlceDs0hmIadxGQENixUt/nCps2ofxx/7KPvtGl2nOwzWMtnq84AbYTsdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I ran resctrl selftest on Intel(R) Xeon(R) Gold 6254 CPU.
> Everything looks good.
>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>


Shaopeng TAN,

Thanks for your patience, and for testing this latest version.

-Tony
