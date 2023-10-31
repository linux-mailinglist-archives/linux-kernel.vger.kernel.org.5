Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C117DC4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjJaDL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:11:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF8A6;
        Mon, 30 Oct 2023 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698721881; x=1730257881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FyWJ6RB0ywCmqvPSLSgs/2QhWwJnlGYUN1BYC20v9uA=;
  b=Ze9zyWDj41yZ1x3B5xEidegEAbpaf4QQNJkbRRCNHoEb18MZ9/+5qony
   Ea13fNz/RbXS5efUwid3TakFUqJ/Zwcja0DG1NJHC8FuJAWMXlRqjXTdz
   hNpLxtgtKnEffwM+Ub4Fdq7Tn1q8FJ+6HVkxAlnGRMuSJY34HRaC+iI26
   ogfk/LqPTy+VF3OXDbAQt4YtaifoNMk5VXOa9TjauqYfJThmZ2e4+Tt1c
   5NpqDUdur3y8sxBGH8AsZg3GQI/UC/s51wOvuuHyEtTh/HstvRwk6iaDs
   mKkK/ydoyJ6Xsl6iBSeZ7WdXJER2WdR1v3KSEL1WFh5QsMa3OPZE1/TRo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="391080433"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="391080433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 20:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="754008546"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="754008546"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 20:11:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 20:11:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 20:11:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 20:11:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 20:11:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv9GcpUMZQ6OP7NBr2cS/uaTuhLvnl+IsV/Ho2EEbObR4lhehRpOiQ6L9d20ie5hxpmvu7kJjvXrcPjGTuWZ48ddvIqDonPMG1jUfsQbqt0MYRmeVpLUJbLay+ysgFOk3q8QQy1/LJk97udGwZHRPq+6Jo0strY4qaGrNVMtEOX6+3Q+77VQwACwQ4AtLQ7JwrjioRBSb8aXFWqy+U2S+hLdtdzYll1IePo0SHJE6eqzCsyDMprzxgQaQHYOQ0IIYzCyQJOW4h1ezOJICsFSv67eBTQZxx/Da1g3PXruX8YvhPFQgVwYD9MF4PCPIJSlPBycwGzTrLq7dAWz/21UBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyWJ6RB0ywCmqvPSLSgs/2QhWwJnlGYUN1BYC20v9uA=;
 b=JCL9+h91g9zzwVg/IBp9Vukb5Nv2NkYRlR+/0ws1MwEhBfDaRhsFLzqzbrb0Uod6Xn3aTs7InyaUotbIXWoZgiRJ22Yeh/8EvetaSXaX3yljU1yqJXrzXHT0q37R1/w59zat8p4g9VXS+9APAvFIEjZCChUzoU7W/Gp3276OVGY+QYpJ5Yuud15v16SxXY6uJCLz2MpODrHEowGj9bc0dmZwKKdnd2HUdkFNDlzWlMcbGPikRsPjTNjTdu0MTQ0oD+dSOjdxJ2qeqqj/12MnubaP7AL/zge/YMFtdLZty4RlYq2pIyfOxyoPJyqQgD809ayHt4ku6kASKYze5ubsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 31 Oct 2023 03:11:12 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::2126:3b64:585d:7da9]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::2126:3b64:585d:7da9%7]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 03:11:10 +0000
From:   "Gan, Yi Fang" <yi.fang.gan@intel.com>
To:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Looi, Hong Aun" <hong.aun.looi@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>
Subject: RE: [PATCH net-next 1/1] net: stmmac: check CBS input values before
 configuration
Thread-Topic: [PATCH net-next 1/1] net: stmmac: check CBS input values before
 configuration
Thread-Index: AQHaCJzakEPiAidBQUW5oe8eW8MjxrBdaaCAgAXUTvA=
Date:   Tue, 31 Oct 2023 03:11:10 +0000
Message-ID: <DM6PR11MB330631ACFA1BC5FCA1318D03B9A0A@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <20231027061114.3792619-1-yi.fang.gan@intel.com>
 <99233115-89ca-4ae8-8679-a16e1f959727@intel.com>
In-Reply-To: <99233115-89ca-4ae8-8679-a16e1f959727@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3306:EE_|BL3PR11MB6411:EE_
x-ms-office365-filtering-correlation-id: 1c0b7579-2f11-484e-1b18-08dbd9bf082c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aipRBJQhDwABdS9lcC563xqR7M+m60q/+5IFtUDIoz2B7hTAg7Ll6CZTNqI9ExOyO08ZBi6bhg6hWRvC6Dv5woQofGvFplflLb0uNBcG1EOWSP9084M4wWcybHY0wdvauBUoZhocZ21R/HpT3ln4OKe2G3T6z8X5N1JT8ENqQr27+vL7VoO7cZc8TqZjrzzMUAVMyxGEbzs0q76SX1XpKoN6wMI3Wy1e53GV1ZfG/AiZGd+GhNydTkJpS2eezIM4W5xhcKH2EkNlzTk5JeYL7w7tpR8NqRGurix0vtkq53mFjLnrIz0/N7QDlYZqkRWy0FPYbJcSkAIvJl/sWRchh/CxoWEfudnLT9GDZkH+HiMPPh0DhSpAO9wXScgq37zAY6h4dYWauYiE1wEL1a1ZzrrZQD2//jFH2d1hshZPAAVWZI5QoxqNKKZXHLtfxkDgfPqLKGpOTiwWaguwG7Ec+614mENcCqoLxJIy7lkgVitziqZ0maRidVcIkKjYJvmCaJs+0z8HHJggCPiOZnVmYDo26P09ke609EIAMqzkC2m8j+QDuHR/NamHonR126AYnU+Z7X3lUgkRsifZyDdwA/dxSQ7OdmG5WlXIv1SEBzd9LI5Bfza0n7FocLJMKxfPDSpmqiUM2C0HEwq50Yc7iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(66946007)(76116006)(66446008)(66556008)(66476007)(64756008)(54906003)(110136005)(316002)(26005)(8936002)(8676002)(4326008)(52536014)(83380400001)(5660300002)(38100700002)(53546011)(478600001)(122000001)(82960400001)(33656002)(7696005)(6506007)(2906002)(9686003)(86362001)(71200400001)(921008)(38070700009)(41300700001)(107886003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDU3REtXSHlkK3NZTExFc3F6QThabnpNRzFNNUVsQVRFQ2Y0V3R3SHVPWVYv?=
 =?utf-8?B?bnJzamJFbWtYaGJub3B3V3FOUUY0dGp3bktCSGZ0SEFsTFFOd3REUHJ5TEtt?=
 =?utf-8?B?V2hueUN4bmRNRzBQNEZhMkhocVdteGdrZ3daaU40UjZFMzJWeitZNjNsSWtS?=
 =?utf-8?B?ajVscG5US0YvOUNHNkFoUzkwZEJMaWlkT2ovZ0p0NTE0THBQeXlKN3hxQnRu?=
 =?utf-8?B?WGlHeWo0QVovOW8weEpFN3hxRDN0bXAxT0ZPSWkxMWM3aGpBcmd2WDdWVmdp?=
 =?utf-8?B?THZUeXp5eDVXc0YvY09IOERHWW5RdUxrUjVOVXpqYkJBK2M0eklDMWptRmh1?=
 =?utf-8?B?YTBPNFNuMUhOeFoxUGtyYXRPWTNPcUp5RWZPNi9qN002c0Vla2g4aVFrOXdM?=
 =?utf-8?B?bnpMdWZXaW1mWHZNUFpzUm9XRHdoRmdVUS91dHZPRENocTBxOTNZWnVIV2g4?=
 =?utf-8?B?TXFsL3JMWEJoekFzOGpzOWZrNVlWT3hrUTBsVTI5VEowS3JHc3ZwczBncTNw?=
 =?utf-8?B?N3NTSGZQditVRWxKL1I2ZmdkL3lIdHpWT05EQzV0TzdURlpuNlZVZ2xlbFcr?=
 =?utf-8?B?aHpVMWN4V1BYejQ3K3QzOGQremhuanpzQ205TGQ0UkFzdVA1OFF1NUV0dnhX?=
 =?utf-8?B?bUNoZWxFdlRhdGlWSTM4blNzWDZsUnNMNlpXajdGYk9qNVRhdDJmUUFOU1JM?=
 =?utf-8?B?Q3FPL2U4TDRJQmJSVXRKWDRHYUtoVS9STEx3U1UybmY3ZDU2Y0FzSVk3OVJY?=
 =?utf-8?B?UXVkR3FtTGRIWWZTK2gxVmw2SkxULzZoRVJIcktrL2ZWeWR0VGlxcFRabHFU?=
 =?utf-8?B?Y1Brc29pTEpCekVWMWFJcm5zSjR1eHlqNTQwOUpyb1pXcjZlcUI1MjhQeWtT?=
 =?utf-8?B?czFsSjlMRXlVa0tZYUVLQ29lTU9SeGFvNzNRTFNNMjBlMGR5R0czSTEvKzVJ?=
 =?utf-8?B?OTJjQzZHd1pNbzZIS0VoeG95d1JsTHNiVHVVdmVaN0gzYU1RSHY0cUtvM2hP?=
 =?utf-8?B?TW1wclFGMEcyM0lFUXhQbEk3RjFwZks1RDR2UUhUUk83L1V6ZmF1VkN0MHFW?=
 =?utf-8?B?Q3A2VmpnQmRHV090bytrcnlGN2dMeGtpWFdNRkJPWHdneDVqdjVVTjdGWDBy?=
 =?utf-8?B?dWF3dkhUOG1oYlV2NjhGQ0NDTWpFOGlyNlVtaVBqcElsVE5ON2dNU0kzc0hL?=
 =?utf-8?B?M3ZoaVFmYUx5MHlxMllISW1xcldQT3VOSDJaNkFyYTQ3cW56V3N0ZG9ZV2JZ?=
 =?utf-8?B?b3lhOVVKa3hTNzRYZDJNWFlCc212dkQ5aEFtdnI5dzFNQk5iTUxJVmZXT3ZL?=
 =?utf-8?B?NVpjQXN5THh3eTVBcVlRdFhOQ1NyMGRUbXZYS0VSRnlwT3lYOUwyZUlhNHJN?=
 =?utf-8?B?SEtjSUpqUmZ3VVhVTmJWMTVSR2lCeko5aTg3cXUyMSt5cjNHS04vZ0grYS9i?=
 =?utf-8?B?NzgyeFZ6RUZ0QWlWVDJ4UTdjcWJ5SURORWl2eUlETTlmSEZXVnpiRVFMYWcz?=
 =?utf-8?B?eVVqTDBzOUJNRk5zRWMvYlBSY2lkaFlEOHBIMXFrVVZiZWkrdkVaUlBhc2Fw?=
 =?utf-8?B?SzFjWXloRWl6bGt5M0xYS2hNOW5palJtZllJVFNjUHNMSEx4NWUwbGN6bERl?=
 =?utf-8?B?TTRKMkVvY29TcDFZVG9LMWlzWkpzaElDMDUwS1ZGY2ZJbG5VbzRXMlFHNXNM?=
 =?utf-8?B?MjYwRkcxYVA5ZUkrYnhRc0RSQnQ5aFBnRDE2cmo2RVVqRGRaWlZ5eVpHc1VR?=
 =?utf-8?B?VGhjSVlrUk4reXgvRDRzZ0ZMZGxoVE1oSlM4VUsxNkZ3M3JWMzRieFFOUkRU?=
 =?utf-8?B?WjZXSVpIUzNwWjdCMHJsa01uU1lsYjloOTlBMnhXdS94elpsVks2anplOXJR?=
 =?utf-8?B?Q21jNHBSNFp3K3JBKzNhbzh1K016aHdycVF4ZlN2eEo3eTh2RlRlTFlOR0Ns?=
 =?utf-8?B?QVY2bldtRW5FWFQxTzk1M0Q2dGFaYmR1WmtJb0Z2V3dZUnBSbEQrZFc4cE1K?=
 =?utf-8?B?MTAxbHNXVXZRYWM3L2F4N0xWOVdkNnJXUDUrQmdqaGhxaUVoMEJnNGJTcWhu?=
 =?utf-8?B?MG42SXl0bVhiUXNLaHJKZGcvVE9kOURqNkw5eCs2NnppdmtSemoyYnhjYW16?=
 =?utf-8?Q?HUowgy0Ose+BKY0cR4ReYN1Ct?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0b7579-2f11-484e-1b18-08dbd9bf082c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 03:11:10.1775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGH4vCvWF2McafFTtgIVrCBFra+BHKY7Ns9zJ0Jzd0H77MxYjo9a9X5aFMmMSpo9JBPbpy8BV2piSAhehi3E9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClZhbHVlIHplcm8gaXMgYWxsb3dlZC4gSSB3aWxsIHVwZGF0ZSBWMiB3aXRoIHRoZSBj
b21taXQgbXNnIHVwZGF0ZWQuDQoNCkJlc3QgcmVnYXJkcywNCkdhbiBZaSBGYW5nDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHJld2VrLCBXb2pjaWVjaCA8d29qY2ll
Y2guZHJld2VrQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDI3LCAyMDIzIDY6
MDggUE0NCj4gVG86IEdhbiwgWWkgRmFuZyA8eWkuZmFuZy5nYW5AaW50ZWwuY29tPjsgQWxleGFu
ZHJlIFRvcmd1ZQ0KPiA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEpvc2UgQWJyZXUg
PGpvYWJyZXVAc3lub3BzeXMuY29tPjsNCj4gRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5j
b20+OyBNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+Ow0KPiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHku
Y29tOyBsaW51eC0NCj4gYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBMb29pLCBIb25nIEF1biA8aG9uZy5hdW4ubG9vaUBp
bnRlbC5jb20+OyBWb29uLCBXZWlmZW5nDQo+IDx3ZWlmZW5nLnZvb25AaW50ZWwuY29tPjsgU29u
ZywgWW9vbmcgU2lhbmcNCj4gPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tPjsgU2l0LCBNaWNo
YWVsIFdlaSBIb25nDQo+IDxtaWNoYWVsLndlaS5ob25nLnNpdEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMS8xXSBuZXQ6IHN0bW1hYzogY2hlY2sgQ0JTIGlucHV0
IHZhbHVlcyBiZWZvcmUNCj4gY29uZmlndXJhdGlvbg0KPiANCj4gDQo+IA0KPiBPbiAyNy4xMC4y
MDIzIDA4OjExLCBHYW4gWWkgRmFuZyB3cm90ZToNCj4gPiBGcm9tOiBNaWNoYWVsIFNpdCBXZWkg
SG9uZyA8bWljaGFlbC53ZWkuaG9uZy5zaXRAaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkIGNoZWNr
IGZvciBiZWxvdyBjb25kaXRpb25zIGJlZm9yZSBwcm9jZWVkaW5nIHRvIGNvbmZpZ3VyYXRpb24u
DQo+ID4gQSBtZXNzYWdlIHdpbGwgYmUgcHJvbXB0ZWQgaWYgdGhlIGlucHV0IHZhbHVlIGlzIGlu
dmFsaWQuDQo+ID4NCj4gPiBJZGxlc2xvcGUgbWludXMgc2VuZHNsb3BlIHNob3VsZCBlcXVhbCBz
cGVlZF9kaXYuDQo+ID4gSWRsZXNsb3BlIGlzIGFsd2F5cyBhIHBvc2l0aXZlIHZhbHVlLg0KPiA+
IFNlbmRzbG9wZSBpcyBhbHdheXMgYSBuZWdhdGl2ZSB2YWx1ZS4NCj4gPiBIaWNyZWRpdCBpcyBh
bHdheXMgYSBwb3NpdGl2ZSB2YWx1ZS4NCj4gPiBMb2NyZWRpdCBpcyBhbHdheXMgYSBuZWdhdGl2
ZSB2YWx1ZS4NCj4gDQo+IENhbiB0aG9zZSB2YWx1ZXMgYmUgZXF1YWwgdG8gMD8gVGhlIGNvZGUg
YWxsb3dzIGl0IGJ1dCB0aGUgY29tbWl0IG1zZw0KPiBkb2Vzbid0IG1lbnRpb24gdGhhdC4NCj4g
U29tZSBkcml2ZXJzIGRvZXMgbm90IGFsbG93IDAsIGxhbjk2NnhfY2JzX2FkZCBlLmcuIFdvdWxk
IGJlIGdvb2QgdG8NCj4gZG91YmxlIGNoZWNrIHRoYXQuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBTaXQgV2VpIEhvbmcgPG1pY2hhZWwud2VpLmhvbmcuc2l0QGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYW4sIFlpIEZhbmcgPHlpLmZhbmcuZ2FuQGludGVsLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3Rt
bWFjX3RjLmMgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1h
Yy9zdG1tYWNfdGMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hY190Yy5jDQo+ID4gaW5kZXggYWM0MWVmNGNiZDJmLi5lOGEwNzk5NDZmODQgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX3RjLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfdGMu
Yw0KPiA+IEBAIC0zODEsNiArMzgxLDExIEBAIHN0YXRpYyBpbnQgdGNfc2V0dXBfY2JzKHN0cnVj
dCBzdG1tYWNfcHJpdiAqcHJpdiwNCj4gPiAgCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gIAl9
DQo+ID4NCj4gPiArCWlmICgocW9wdC0+aWRsZXNsb3BlIC0gcW9wdC0+c2VuZHNsb3BlICE9IHNw
ZWVkX2RpdikgfHwNCj4gPiArCSAgICBxb3B0LT5pZGxlc2xvcGUgPCAwIHx8IHFvcHQtPnNlbmRz
bG9wZSA+IDAgfHwNCj4gPiArCSAgICBxb3B0LT5oaWNyZWRpdCA8IDAgfHwgcW9wdC0+bG9jcmVk
aXQgPiAwKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAgCW1vZGVfdG9fdXNl
ID0gcHJpdi0+cGxhdC0+dHhfcXVldWVzX2NmZ1txdWV1ZV0ubW9kZV90b191c2U7DQo+ID4gIAlp
ZiAobW9kZV90b191c2UgPT0gTVRMX1FVRVVFX0RDQiAmJiBxb3B0LT5lbmFibGUpIHsNCj4gPiAg
CQlyZXQgPSBzdG1tYWNfZG1hX3Ftb2RlKHByaXYsIHByaXYtPmlvYWRkciwgcXVldWUsDQo+IE1U
TF9RVUVVRV9BVkIpOw0K
