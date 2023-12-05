Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EC8062ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbjLEXZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjLEXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:25:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB7196;
        Tue,  5 Dec 2023 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701818710; x=1733354710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i9odE/3UBENm9QVrE/Tv5WINQYxfNzkIMgJI1ZMhuYg=;
  b=F7R5RebitQs6rvTkMIDAQqXImNy/zr/oEZz3JPXc+ot0ey7d+uTC0tIC
   jwKvpZQkEvj7dy6SIwWq45LvDq+UlwJrmQUsyxRcv2/e9HyjzDEz4biNs
   voZjZ5BKsPxS6eViFwBI5hrEf+zMdXW1eMy60nZRcog6xJIIV8EKWVz5m
   D+QstX3xbUaYDCrXy1ESJId1PEfNps9/bDPnOLVIVzuyS5hhHHTvDjzZL
   XVKsI0TqyvTgYqlN2YMdLtvtJPBVh+m1nGtTN7eGlxBNEPsC3Bv665RDu
   Q7hwx33MVzTrODKhnZLAz5m+BphTdfiTJk43e26lQBAY2EVY8P/Au33rR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374156516"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="374156516"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="914971086"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="914971086"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:25:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:25:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:25:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:25:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:25:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFlUwkzuVYmKA8rXvgbg5SEoczg5+wI/Sfbjv0JYotKcAr8ZYFBkmyyY3vCFl1JolHVej7meRD4QVzbhNhFnzfiaGk+Q8n3sHtF1Lh3pKQvU8+ijawUnpveOzbz/ICbunnblRJAPwRa2/Hn9PQfzxo6bv/zusy0JQ1h8St5XV37KIniXFZLj5BaR8L+878mja90mVhEhKPdRa8GMtho1V8ch9RNTCWtGtYCJwMWoAdZ0o5wdcYRbgv2Na96cK2l/pAJ9GQ8qsmiUnRBjZOW1JWRjXrtJtigr3aBmlAvAYR4dLZGSyqMlOMdoYMq5L/AO58PTiEIoNVXKV5PesO9Vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9odE/3UBENm9QVrE/Tv5WINQYxfNzkIMgJI1ZMhuYg=;
 b=AuIS6tNrdZIQ6G8ggjL9IQHkRTovTRqN0fdDpIAYPAZUpMUPzwOz8IXw2qMgbIkBt+tEvfg0dk4mzff4pwaPr5pjKBvgCnfsPb+1p0zE9i2BMnJDRKTFKBhHRtVCKkZUYgWRvvXZGa8fTV5e02LYbpbMu4csYk+9hE5Ky86xmxSKpu36uwJ5iB8q9LviaAV1itH2t/AEYE2D4N+u58d61oFv4N+mid7Q3Ko2zBrVOkMc1EvfirxdSGnp8th2pT4022RlWUvk4rVv2FVeC1c6GaDqc/G2kQs53nC/5EnV/8joDwFDwDQEHbiFYoJVs41FDn2BJPTwJdNb8gDLb/6BfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:25:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:25:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: RE: [PATCH v2 1/4] EDAC, pnd2: Replace custom definition by one from
 sizes.h
Thread-Topic: [PATCH v2 1/4] EDAC, pnd2: Replace custom definition by one from
 sizes.h
Thread-Index: AQHaG7uk0qEqBjG9zkmbVUfxABoCs7CbbNBA
Date:   Tue, 5 Dec 2023 23:25:02 +0000
Message-ID: <SJ1PR11MB60836B66CC76A1C3D89253EAFC85A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7680:EE_
x-ms-office365-filtering-correlation-id: 3141ccab-c060-4678-2403-08dbf5e96811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kQrx1ZUT0MhrL+Rt2p5J6hANPIL41hCrFzzTmXkfkbnWDxcPPOUD+UP+vp4G7J6h82UUeTLpLYrjxHZmfaSJ+MqOFEOx7LHEi+uur77ghNJRdkMsKeEWVgWWnayQLqxtqTNOTgm4/K/ZRHO3BGJjoeWwcIaXVGJx8CUnil+ikZbNojYK2Pt1RqBLuw74G11KMWXem3eq/GS7QvaqRweoPlXIbtnQ/H2R72T7svboU3TRcnfFhw1Drf+oWAV8kgumb0KL+fw1jqA407Jrb1RM5Qo3IBtE6CsPCyDSqskayDSgzeCBx4zgbHr7YwchDqvCtp899wUm6B3Dg/5Bsqnk4e3u5Y2L8xRkNkjwn5o2+PiuHFFVzn0ZdKDK5eauBhukl83k0GeWsHWOkKRUthzs5KbQHr2hElXrbPITj4U0iD/woBZhQJSfKGPHJkvenvfKixZfwvJXERmA9eZsb1tUw216Sdy9QSSch3L/71IpPJoXw4n6RH0+urO6kePekJqj/oSoyChNIJyqB/SdQii/cBV80JRq6WhhtcDxkVZt1Flh+0cXyEGU+t450r2lDJK+Q74txG+yTbSrhtwgUygs0ki93rQHRf31ZAX0HhGSttxbtL3j8seEIl/jwUT+XWfZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66476007)(316002)(66446008)(66946007)(110136005)(76116006)(54906003)(64756008)(66556008)(478600001)(71200400001)(5660300002)(41300700001)(558084003)(38070700009)(2906002)(33656002)(86362001)(52536014)(4326008)(8936002)(38100700002)(82960400001)(26005)(122000001)(8676002)(55016003)(6506007)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qg9IBUi40CvDx3yDGsbhnc0sL8SUiFLH9bAExHrSY/8zcmYVQ5oLX08cufOs?=
 =?us-ascii?Q?WrCjQoHLdaj90LWogp5Nh2WUeqnQRqOcsEC+w9B/+00Nfs5M67XepynBdZkq?=
 =?us-ascii?Q?JiPCE/5lKpafb2CLIan0gwx807hgfxL/NlIdnyZ+JMLvRf4CPKhl+M1zTYia?=
 =?us-ascii?Q?Ka6LIBVZcX1iBhgPmT1Jpp9Bcb/QwXMaqCDCQYwZ8QfBNEY45gBNNQ42DPPV?=
 =?us-ascii?Q?eNVssUTHHgW45KvvdoHgMbwNkvl78Hiz+sGL22CiEG4ZJRKUCKem/hk8PHal?=
 =?us-ascii?Q?3yyRb7dF7uZ1eMGRnyijlYPS8SXKKILy+3oFsllWo4shO8F4hO3gj2smTYEt?=
 =?us-ascii?Q?XlnCiAwjmjoqGu/OuXMqIjcV+9QmCJxa1nBwhbsXxxE92Wj3t3oh6z4lB+Ly?=
 =?us-ascii?Q?GEfYQlYLNutS5Weye59pwTvgnRN8Zdr7pCe8m5VbUpQ4eu7B5W/tNiQSGb6Z?=
 =?us-ascii?Q?Dvfs8irx6qhm1AvPXpNrTx4hH3lVE8atuBeQv7wBOZmad8V/G6ERiBVhPRQM?=
 =?us-ascii?Q?d8fe6nxJ5Ugi4uAqkMr6dvo3ZdYhjsgHI+8t/Jk2fLrc9WG1Bb4r1KvTLDAf?=
 =?us-ascii?Q?rrKgG/1UBOGG2ZxBiLgaX5c+Ms7d7ujkx1n80h/WTIABafGrNmzqp+5QY142?=
 =?us-ascii?Q?klcg35FpfFgGXPe4C3DF8CYF9SANgXjkEJspTiDuqkMOJE8oYSvQj5T2SVQp?=
 =?us-ascii?Q?p25CR34UIBXmrzM6DvvFp71lqmasLcapHLlASZ7vBW3WYWWZ6laiPDX/x4Pq?=
 =?us-ascii?Q?pIrs1KFO5gdCTfzBuyvlPKgR94fdYWqhNF7TcWl19pQhxtltYJ0X5j2tHtpM?=
 =?us-ascii?Q?rwoIQnTYpauQBafw2kTNyCijbNumY2MGOH2Hgx7lPdtg7wDITfdgTt4bfyws?=
 =?us-ascii?Q?zTwp2uT2z8CzFNGavLQPD+Lg6mUZavD97cOyBPyeqLsJcQwSiLYWD73Q+ilw?=
 =?us-ascii?Q?N5ErPBlfd0CZG7CoT5Y9MV5DPc2p/tAKeV75ysKaqt4cLTiwKjautrJUcgc1?=
 =?us-ascii?Q?kxUjIMDyCI9TT+t4MeE9pI9UYg2OL8pVCIZm7ldEBY8cb/WD+kXVL1cjbj0C?=
 =?us-ascii?Q?TNd05kexs2AjK6JQHoPmv4e3CLxFzliDA8IgusQTUh9ypJPYkjYPGMRpSJf6?=
 =?us-ascii?Q?OeDvhcQCbb968oByzrZp6SeRJYwzC8q22hJJj62GFa1AJ6dwBKXcwAHW5sDC?=
 =?us-ascii?Q?MH+8lHO5i+4B2nxC1N/tEWTqDor0xmSn5lFjGjOGOEdLzqqx/uRXvYU9/oLb?=
 =?us-ascii?Q?Gy6WbEqbpPLRy12lGFnYQrwgZcMFkKHm8AB78PbF00VCKebzBtEHqPraMSD0?=
 =?us-ascii?Q?rzd1KCXaBObO/gJPcSgZg3SpFA+4MhyAtgd7ezIu3QGjuReKVmWouPsi5Jxy?=
 =?us-ascii?Q?lZXMFdV6dAcI3CVyGwc504vN8gtIkLCzv+0CfZ5FX/4oZKaOFg2RdsVPXciq?=
 =?us-ascii?Q?izleudJuI28Uzasfq0ZNDTu8NSVd36hHL69EA1lOfK5zCNpAFWxd1Jg6MGVi?=
 =?us-ascii?Q?CU/8S8Qk8XS9Y0lhz1djxVkxp/TgzRulilntcwAvDUDwqj/kJ+seNscFKUpv?=
 =?us-ascii?Q?UhaDGVrwZGKZYkSwjXTo7qT6/3b7jKR5zDcplH8v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3141ccab-c060-4678-2403-08dbf5e96811
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 23:25:02.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uWv55Fw2Tl/hffdcPo3GbMaYb9EpXXfSLdQI+1+odDQfe0vIWjyV5XAuiSxQL7AS0xCRbe87V54dZg4Z4/rSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The sizes.h provides a set of common size definitions, use it.
>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied this, and the other three patches in the series.

Thanks

-Tony
