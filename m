Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05D810B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378663AbjLMHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378524AbjLMHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:09:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC0BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451361; x=1733987361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K2DmPBXFpDk06hrV8id6CExCj512gmy+oB9q5ITXYX0=;
  b=Qg6GxytRNNwWAhIXJ90phjj4aC+FjehhZl/QiDhWwbv0KGo6llAq8NM+
   GHNJhRwyd+uX+LZNPbvHp8GawokA3wh2VNzUVmy2x2bn0UPHkvqlsIMW0
   W8bYEVTM50ZSPAICu75Xl7q4TBmOX+OArHYvl7W1dV+1ARdluj+vK2Hux
   9w//gNPQ/z5TXnEh+b6nHAZL3aAgXigQtU4nRCfbkOM4PFDOjnJZFqebR
   amRsPEi5tRDGswukimfuKwSQfyCAskL64g2CJF+YS3GToRNJ/AAALhfyK
   oaaxd/TNgYn7Denn4UvfxePGWZ/cWmnbCVBNWOR/zui8YnHsInEreIjaW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481125892"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481125892"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767108803"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767108803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 23:09:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 23:09:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 23:09:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 23:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv+TAI+wp+qQPHD8JDdlXd81VSPGPF5QmWKvFkjxgBxHow2PAC9nxG7KsOTfoHPtmLobkCiGlqKdNs8jVbsr/W/eJ4/7C+D2SPrctxvClC6gOGYTgjuh/BL+qz1uW2uD08YAnnbfuJG/wZNZB8Pi8u60iWW8+xqRvChukOu6JI051Bn0M2U9QAqW8VTiyab8R8ibdrBURnxafW0xopd7yBc/26NnNpoGz3wvA3oMQaD29YNGosRSZq76qg+n/sOUuLVj2NsXQHEEqen0f4UwbFyJ6KaEyGzWLBRwyoGUPf4EyJic6VLrIiY+fXrp/P36sNMGuxWlbdsa6w6/9N8ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USw2j1qYmoAob0hMwblvzjlL1UBffmdViQbB5abDpbw=;
 b=KJ970Nf5M9wadeDVuJyJth5exwSp0XzHa1PGmJUgcuIgaWRgWMXQMAr21DrAB78K/bmayCAoBNUxV9klyXnN/hPMXJHTfx9uOR1Wb2s79KyJHUD/KdKWwmKxawXDaPQOKwWV8Ng8O62jliz4sjJE6jQTTBy1Nw4bCinLX6Mpm6TrURgB2n2IKSgduD4rmXGF8hSBQJ2saDOifsmeMnANBgro9dIBlFZIw4UGErKPzfc0MBao7feL9AslFG0z+jMhQx08mwyVqmNZogTr5LsuIby3oqgSD2P4Lsl24fHPZCKARXkenh69x2pDyYCFw4itLOD5+8yFg3/mqFU7R7JKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 07:09:15 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 07:09:15 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] mei: fix spellos
Thread-Topic: [PATCH] mei: fix spellos
Thread-Index: AQHaLX7ET4ddhBKe+ket855PW9Yft7Cmy00w
Date:   Wed, 13 Dec 2023 07:09:15 +0000
Message-ID: <MN2PR11MB40936BB0DF3B1AAA66C01AA3E58DA@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20231213044158.4449-1-rdunlap@infradead.org>
In-Reply-To: <20231213044158.4449-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|MW3PR11MB4556:EE_
x-ms-office365-filtering-correlation-id: 51e592f4-6b57-4dce-99e7-08dbfbaa6a92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DmOLKsP2iALamn9QfSL4jJ7uOIUvGdw5Bx2E/AKgv9JwnjjyrIm1bGZaGaem3Cs5IyJ9945JoxtIyMcLP5x1fy4uFJ5P0apbIRtfQlB8WANt3HYYvxtSmhcnPE5+oHEHlQHeDY/4efu6JJplHgncbbYIfbA4s21/l6OwISa73kT+rNcpV2/3zYF9YOAJlnYm/5AXge0YeQADnrHZXszhn/vALlb99T6DvUKjdKDuWz8vAVcff9ur3qdESDLvTvJgHS7WBcFfsrE8jnj3zJe21C/Yf/EAhwgRlbb5+CHtMXgKQkHB8q0bN6wr1WWZB8JJT9C5SETU2zJ9g0UHlqG++zhnxSEcfiy+eLU5CvvvzgvvquUjFtXDveM9KfD4FfyrVVyq6eNbgUwk501Ht22QfqoI81See2bJhIbepGWdf+UPkl944UGH3t0mqSb6HqVbqeH/tto15e5OdB+XxvGrFhUxRzXLA6H8bTXDxYusnhNt0VyT9lAralDAXBRvqtEob9ZRUaIr4ofPQsYSsVo3+6YvC+E5/sionFOC6lumLREIe5AugbA+xfM0QrhzAyXaWzRgDiyHLi5A0G4vHQbcGX2DAaO9uLsL2gpyJ6c5rhupnYj7JCoU5pXzof9QnlSf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52536014)(38100700002)(5660300002)(8676002)(8936002)(4326008)(41300700001)(6506007)(66946007)(86362001)(82960400001)(76116006)(316002)(110136005)(33656002)(122000001)(66556008)(66446008)(66476007)(55016003)(64756008)(2906002)(38070700009)(26005)(83380400001)(9686003)(71200400001)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DtdW98bGJH5a2/bVbOYw6Y40Y3Y7Q5TMBm0zky7O2PoQ/B1XLzNhNGbelS0v?=
 =?us-ascii?Q?3DPB3RLBAtg00C0Rc9H5caK5HN1SM86rKMI7wcQDrh9kJW4lQVxJUjgqOQ/O?=
 =?us-ascii?Q?l/cEHJBgvc2F/81+mRScfvfBzexT5HEMQz15ESSyO4JrHTffJG0D6ySpdsPK?=
 =?us-ascii?Q?+YubO1STqKLUPJ1PQ5NWchsX40E1Hr2rfnY5Xw6wTQ7JIrwJLD2nQioTsSfn?=
 =?us-ascii?Q?9xjkWwjdpY8GfRS9MHSdK/6eXvQHGrRWsNuE95g4cF7mrNBND354bqC6F0Xj?=
 =?us-ascii?Q?z4w9oXEtr1BJEf9+au2TQKeO3ZsNfLDpWMMxrIN02hWtb8i12nbnq/WR/AUW?=
 =?us-ascii?Q?ITlZV8iy1fus0P//K1goMEYVrHlDCy8WAmf0c8Hb8Rx0oQi5W9YRXZzuQzSm?=
 =?us-ascii?Q?Dx7/fkQKtPYzmDe8+0SiJOC5XhuDR8lj+RjXHFNl8Zxlaj4xufDTWaidlyoD?=
 =?us-ascii?Q?J8eSb+aS+qBthiKR7gxQIiCazhgiTT/hYkCXXt7fL/uhTiZWU6yYzjykJsZA?=
 =?us-ascii?Q?oTuySaqHwHeLiZPUFi5Q+YFvM2/uoWfDwpar1n2xcrZ0nU+rEEcdL+eZ7h8e?=
 =?us-ascii?Q?CGn8O/5Vl6vQmpBgKNuSMgmDxD26q5pRp2jrnHkkTjQhyVyyF5ziaU2TKt65?=
 =?us-ascii?Q?f63t9PZZvDYNbs7cdwk2NGVrE2DhtXJUqSrI+YxRhSiol2dYix4cEjFnOwQA?=
 =?us-ascii?Q?pBTMeqF4rDL8U5A5xrLmmI4MS6YAxqZ1O6blCBmVf9GeYr+PCWeAZ1cExF9H?=
 =?us-ascii?Q?rshEAR+KY8BAqPELRbknsUjv1JmEDWInCOV3AAhPPH4v4e0SbPC5s0h2gO+S?=
 =?us-ascii?Q?xRK9JXHsnStCYzoUKW+Kw+7WkRm/dQTuVTy1watMvdiMP8PN4g0XCnoAico0?=
 =?us-ascii?Q?8K6NsUZVyCxM/ZSfzUM/sEGPB9K8tQzheukwX9Ltdkg7a2dFvPGyVYbQKGBC?=
 =?us-ascii?Q?OMwQihj+g/ym2nyB4R7bxHh29r7JK5mXmu0oevEhY6IkTX7jHU9ocS5C9VQ6?=
 =?us-ascii?Q?1+E/HxpkPstV18JqJRrPbCJDlhbOERd+z+K04nvirtTdFgAynHH4AWZ6h2Wr?=
 =?us-ascii?Q?L0Voa1HStn92acqOFgMHrb3jswGXrX+ekn8P/BxYfygO7owam0AJklg7JXxT?=
 =?us-ascii?Q?nTXY4pOUh6CDlx9sZCjBRCXnuxNtzVA6zaSYiLRb+5gUCLzVCyu4I8FpDCna?=
 =?us-ascii?Q?10puA1tjGRJMmq6FzkhMbF8ESqelwEfJ+sAK2H9l06KZ9pPNhHfdG32kZCa/?=
 =?us-ascii?Q?DZJIsRcnj8S9+8tloeCtaPe1QleP0BN22y08nYHf95350YG+pIa868VXs7xz?=
 =?us-ascii?Q?zaBiusDXLsVojPMCGd8E69dkSa+W8AMVCQZC0ldnOWAXi7reXrmnp1C2OJ7J?=
 =?us-ascii?Q?wRNyfLbcTxebBXlB/dMXQdCphpGoHAqfsdSFty3XCPgZxuv9dn/qscw+Hk1Q?=
 =?us-ascii?Q?QW1rNcQfTQrR8LWOpGRFlpOoJ8ZEe9MxAgBd4ZFuu8DXiut2ZylHhAmwVuqw?=
 =?us-ascii?Q?gxu+G9lzmk60E2xyxGOzSWnTpjUkbCWZ0A0Y496TFyxrrLFqtMWZdKJlfDJI?=
 =?us-ascii?Q?S7DIfL88rlvbs0mGzoBnJiQFS3hz8CsuafceqAwD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e592f4-6b57-4dce-99e7-08dbfbaa6a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 07:09:15.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7mW0EkVjGUAhD+N+539le8RWqJKOxfOnG+K9ZTcbtW9LIbU2j8vahLrmM/Q9ILLkNkAJE7jIp5srLafxBiAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
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


=20
> Correct spellos reported by codespell.
Can please specify in the commit message that only include/uapi/linux/mei.h=
 is fixed.
Thanks
Tomas

>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/uapi/linux/mei.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -- a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
> --- a/include/uapi/linux/mei.h
> +++ b/include/uapi/linux/mei.h
> @@ -100,14 +100,14 @@ struct mei_connect_client_data_vtag {
>   * a FW client on a tagged channel. From this point on, every read
>   * and write will communicate with the associated FW client
>   * on the tagged channel.
> - * Upone close() the communication is terminated.
> + * Upon close() the communication is terminated.
>   *
>   * The IOCTL argument is a struct with a union that contains
>   * the input parameter and the output parameter for this IOCTL.
>   *
>   * The input parameter is UUID of the FW Client, a vtag [0,255].
>   * The output parameter is the properties of the FW client
> - * (FW protocool version and max message size).
> + * (FW protocol version and max message size).
>   *
>   * Clients that do not support tagged connection
>   * will respond with -EOPNOTSUPP.
