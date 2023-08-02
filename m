Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1176D33E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjHBQEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjHBQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:03:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC4C2103;
        Wed,  2 Aug 2023 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690992236; x=1722528236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0N9YLSc/SlLu9dY9zumskJeiUCs9uJxumkJ084bZWKQ=;
  b=OPg8iBNBQqC+iO/64Pd2I00HanOUPeMMGBvGKsxu/XuDO7jT007xtA2+
   pj3/PZDrKzbeRpyFxSaw0b7hzStMCPvkhYdP4pLo5m65zHWhmz2aZkaa4
   xGMH0vNKVCqrd8SkqNgrk3lhaCuTY5hSbOm9a9lgFGZFgPcV3U13eGBIm
   hbOBcciK7XjG1g7imEWIT1LMMzykUEHDeyKRLflxuZF/AM2oEV5UOnwqa
   qlpMux1pBSbH0qYggHiDHH/Ut/qMcHhao3q89X1KXbrZjYG5NcWk/pNv0
   BP1OOhQp6S5PgwVq88MfFc78t57zYBFODDuCurPrRdEU0xp7VBUfMRiZe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359662152"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="359662152"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706224191"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="706224191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 09:03:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 09:03:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 09:03:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 09:03:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVxdNbTicx5Qftm0FrWoBZMMOHm3FpbgAwBgajMq6v10aTHrRIvkZGG9LYLUXY8PapQScLHXUMGp5RdWVnGrkCZAbUwmmiyWbmLPJCDJo1Mmhb/PI8Yed6FuZupzTjLNRnMilRYi1Oedkf3JpYDTtMu4uTKXpf+CvEeCFQ4qVnI+B8COxnBxz8LsH7q/kyZzuennRgUOc7dL7C3fJ450gNFqEca5kAWDf3LW8YrOcgnvcqIdHOhX558U+dBZPpY+rGKcWozSsdN90zspmeYf9lq6hccIcC8xOf7Z1rlYyDzgNGKsV+Dai0omG5oYv2azlWBJ39g5gA4sskZMyKSNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N9YLSc/SlLu9dY9zumskJeiUCs9uJxumkJ084bZWKQ=;
 b=W0ywU255NkG5mrbXUOF3wJSN5RC5S8HuAj9CEB4QMt+MuF0lAabzzEx2vn97msRKrpYSqV5mcEcGrmMqz8ab3Ua6nNW8LxaFVXqaGQsnU42dPDq8gNfDmcXLIxqwL7yy1c7OLluYPDKzmNOFY48J5N7osixTB/kyKpbttI0OjKYGGDjm+E10kd9Km+IklKGm0KR+P4n9yVlaClR28cwlk35jy0VUEKzztWL2MpluRNk20iYwCfcaJnCHq81oIy4aGrTvzFVHp8oSPDCrr1HVqQ6d7mUhqw0in4B2eLhAmNT3Gj4jdL433hXbZ/zzYLDvML8EYd4sCKygUYabMJSMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 16:03:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::52e8:9695:e645:1092]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::52e8:9695:e645:1092%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:03:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Xiaochun Lee <lixiaochun.2888@163.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiaocli@redhat.com" <xiaocli@redhat.com>,
        "Huang, Adrian" <ahuang12@lenovo.com>,
        "Li, Xiaochun" <lixc17@lenovo.com>
Subject: RE: [PATCH v1] ACPI: extlog: Fix finding the generic error data for
 v3 structure
Thread-Topic: [PATCH v1] ACPI: extlog: Fix finding the generic error data for
 v3 structure
Thread-Index: AQHZxUfoGYIdw00+ikm1RnQT1cOgnq/XKvgw
Date:   Wed, 2 Aug 2023 16:03:46 +0000
Message-ID: <SJ1PR11MB6083DA8FD0F3790DA04CF337FC0BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <1690984066-31757-1-git-send-email-lixiaochun.2888@163.com>
In-Reply-To: <1690984066-31757-1-git-send-email-lixiaochun.2888@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6416:EE_
x-ms-office365-filtering-correlation-id: 8449d134-5456-4b6b-fad6-08db93720dbc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTe3V9M3Cc/CVvOFuGccXeJJNUUeGqxgnqCxHXqrCvH7HgTIc1Tk7zLC+g9cGT17Y8qzfMjBrkMq6z1Ne3c+JrKMaZeZboAtA8EIdiKMQyuvvmACZ9IxuAbK6s0KS3+oxWf22omjnKHKM2woA4gIR0i9XpBUgCn8LpZsK9MiZshjxgqYAXPyDhqyp9XRjl5nTUNTuuTPRsBvaPW6k0fLCHNKaSl4QhWDN31IIXF3JIk2Yzb29BgnoqFl2KhtPEXCTA+77AUYE6BReQBaip7dKtHFf7hDgi0EJelcFBDJitC34sEk/oqfWKLD1h8gyno9hPly4ktEvYswSxuYd2Gql/z5NA6o0ak3ZobR4yv+M6Emi3y/8a29gZK8hznmrx61K2cXvwBNgu22dPYJeAXCptuaCaTTL+AKOSdv+cZ3CGWZ7Nbb9LeaT1zHcegRgWdchIY9x4R41R/7HzBuvQBT8SLRRs7/4MzrtOaNH89pevfavLk12n87vqx3/u66csCnT3TOAaGGe6GAstxfMLYx/qHWBS3MChRniXkszt3GkvZMhn1WtlGfwpoCnr56RfobFTb8/40kkqSREAz5Oo2Nrza1HPt4g43PXlwmZkCeS5C/Hc689sfEV4ToJaq7BiUprH6vI9TO5UivdDftSOq3Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(52536014)(6506007)(4744005)(8676002)(8936002)(38070700005)(54906003)(38100700002)(110136005)(9686003)(2906002)(66476007)(66556008)(66946007)(66446008)(64756008)(82960400001)(122000001)(478600001)(71200400001)(33656002)(7696005)(76116006)(4326008)(55016003)(86362001)(316002)(186003)(26005)(41300700001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8SudaS32gKVDS4cQ3PQc1bAfpCib5vX7DCX6FH7jrDVvVvPKPfuaiiu5/N5o?=
 =?us-ascii?Q?0nttjEy2ofqGApHs6X1sd/i5I6KBEsxB1bv0nyM7lw+4B4YInCvpIio1PXca?=
 =?us-ascii?Q?jnapSGgLURKGXyS6X4Q//uzc/mwMH8q02oynWqa3E7c7DwZE/Z7t1fZOuB7R?=
 =?us-ascii?Q?0GfjJHP2nHzCPd3pDLx4Z93DBVi2KRfe4BX6TrTvZdPksWxUxaiLTu2+Chek?=
 =?us-ascii?Q?T/z9IiXRylNQBxEmBgl9bFfNe5S7wVBsvJjC1pMjHi622AvlOlD/sl4XFxop?=
 =?us-ascii?Q?WEpK80hqarYMe756EJ3Q6ZXVEZEQ3g4T/HO90sgjI11IAP/6lJcZQUgCCX0v?=
 =?us-ascii?Q?nPyRBME4auvBr2ebQMc9Xw1kWBRPRbjZuErCU8IeyPFBRiwYVCULiP5x468d?=
 =?us-ascii?Q?90ABy4p+5H1fLOCLWWMz4oiysqnycNliP7J8TuM6ofA9yi30BLijINmPphqx?=
 =?us-ascii?Q?VJ7jixVC/Fjhav5DXLV6lec1/SYIw+FL/t7FA5NTIsT6qqrDPYCdKxcdbOIa?=
 =?us-ascii?Q?75xs2DKXxJpu38RIFXDNEBr+Em0bqaaVfinj6vhvA2h8BzrXsScPRC+2y2yk?=
 =?us-ascii?Q?CZVYkzoYZDBBJgvjVvagbMzHiDPYUY46D3sUuZ1b/2ld3KwOCF1UVu/JnecJ?=
 =?us-ascii?Q?w0A1RiuAmVvGCnFb+xNDpdXZYwBQpHyzJLy725m7VjTSFUeP/xFQQytTQR4Z?=
 =?us-ascii?Q?TS59A/pPl6PWs6oJGJvDrnmb0kjRsxEBBa4S5V9/VwX8ogrA0z32GD6hu8ze?=
 =?us-ascii?Q?8721B0TRgXGZpz7DZy10LPY+8nvCFHfhQ4fbVVsBHrm0Tc9ZWd/6WHgj+/CA?=
 =?us-ascii?Q?jUtT504leTwmnqbQePT1Ol1oKy2Y2gOZGarGZBMPrEhvfsCL5Cu4LWxAvjtB?=
 =?us-ascii?Q?yXk+0HlaRfzsrgxRN0vO77Fq6yz7MLzTdUatqYMsJ+asdK0nIPMmFlF3XEcs?=
 =?us-ascii?Q?FmECJRuwuZ+haRpXHud7iRwgb/e83rXlpVVno+uO8wiS6UMX8D1cuwBzljRX?=
 =?us-ascii?Q?BtQEueHoBN6xiWDBtUZcl4nfENIpIxg9IgkV5kP/2OL/8MkIFb9yfV5EFGbU?=
 =?us-ascii?Q?q7+aZyqjb5PnIDx+NXhivGLy51Lod5A/YnS0S7J2QRJudF0NBBizHfLyjcBk?=
 =?us-ascii?Q?NWIBwkXtkCgGJGoVTLMXBeT/cB3+/jWo/ErbIiYL59GmePmvI80hen5Nxl3t?=
 =?us-ascii?Q?CbOo2h+auXIOLG47TQLYGiS5Z2zciYvRlmrdEuinZJYPj230LEx8g0SGqpsD?=
 =?us-ascii?Q?crNuWPYLX2dquPPDFyaWFAYAZ/spWBarlVDVW9YxQUc17e/zmlN3c0+yJLrk?=
 =?us-ascii?Q?mOJiaIplfdBtqBauc3UB8qV1y9QQFTtF/5UI6d5oS2pvZyz2GBpymVzscJ5O?=
 =?us-ascii?Q?ivm5agm83Kq7PvUWgurT24x15yx3jH+575MicdC2n2hBteqYBfAGeRj+nsBb?=
 =?us-ascii?Q?GTSfZTnw97A5S3RexX4JVGRYUTeXZCuq9uWJpsSsBS2vqdiY8+bne0JhE4GS?=
 =?us-ascii?Q?eSJz1cMkg3lsXekDbqpHEMVn/vr1AhoBtu8ReH2k7YQH3PcjKAtPSE8I4Ss8?=
 =?us-ascii?Q?s2bBLD5Fep/zvtWTe8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8449d134-5456-4b6b-fad6-08db93720dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 16:03:46.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0Vly/HZQfCrBfw7ziixOfPVvEFIq6wWvE/zm3C3k+SMnJvGuricQrNEeHXpYQg2/pPwDWeCKd+vcHxlMogVpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix by using acpi_hest_get_payload( ) to find out the correct
> generic error data for v3 structure. The revision v300 generic
> error data is different from the old one, so for compatibility
> with old and new version, change to a new interface to locate
> the right memory error section that was defined in CPER.
>
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

