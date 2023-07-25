Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B66761DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjGYPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGYPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:51:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24B1FE6;
        Tue, 25 Jul 2023 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300289; x=1721836289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ok1m7DzZi+KYg91Lw7zF22d83JBBiN1fg9Gw9IxFBRg=;
  b=gYgrnIVUnJSq9YBIx4GAp8knCUvZCo0nj+JuQw39aCcMlm+4YutvBj+v
   o1BvgATmvkU59MYLGMfB6hlbWfvZOUOblH79SxAYHWwu2yUEGBD4PyNqz
   lctodXgGsnUdaPtPpXZ0FAGZymhZk/PRpwmhhsrn0N+ZoOQODYonjLSLt
   7zDBFQ8XE+80YYbst5WbwRDNApzW5oHuVfn5Qv10CDdWYbIcx1cM8Z5mH
   UVPt1JnrhA468UPmoVBAHKvx4lNjVHKlvakanOpsNz+salFSPRedcIYBl
   PRgIcqEFw0rzgFJGIkmjoqWT2H0tNnJeLvWp/hHNUBSrI4FCZhTBI+G7I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348042029"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="348042029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="703335944"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="703335944"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2023 08:51:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:51:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 08:51:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 08:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc6T7J6fMxz7+vD4QMY9XrkCQ8sk5bzeRGq9f4FZp6TnsplH7iqqMZm0UbtxFGgvIaFxyqurzf1cBy85XdsdlHAqqIpuTdGdTmrRUV2PK0C8FTJ19cpuM7tpVdHgj+1LtbfJx19PhWA/aYJg2RK4ou08led9OE00C3aSZJnqrpgXVoZpjlCneDp4LdMdMEBYzchc1dtR0xlhygfoGK+RVCuLcVvxUDIl+M9aSAA+hRvOicjrcYSSwRZbtJYLdaDffxc5A2HRlaibmsaNF2RPQPWn/U+/FApZunukXhGuNzaO8CKzZMCNQsd0rT5ZQ8O9efovtqsqLScEv+7SXKJDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKoOj+jX1xICccEkdmRAFMwxZcc40sYqKdd28HRwKcw=;
 b=KyxduAlBTF4TihOSn54L+q2t2efAgC5R3iiwyu60FOKysxNb2doOsCZj3qep0JOa4gBW4essXTHa/Q9AmxcuKuIekY5vBA+C1srjbVcw7eqP0sQarQb5FoEvTV4eEAOH+aNcG7gBN1EVBqqf7HG7W9Cty8JP8hffgGWSfEDJoIk/K6OQCIFkARzuUpthqqk+G95fD/rsGFxJdYIvQrbrR+SLijyU+9fxfvYUaZsl+M0TQoJZzRKgkKb+INMQwoK0cXHpOTokC34NOW7RfL+O6u20LphaGqHI5pDrmoa4hUfo1jysQdreylvpbPpytlO76HjAshh4z/XSPNMZEMXENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 15:51:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 15:51:24 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lim, Ee Wey" <ee.wey.lim@intel.com>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Thread-Index: AQHZvs70AZA+3i1QEU28InVclO7Ajq/KoVGg
Date:   Tue, 25 Jul 2023 15:51:24 +0000
Message-ID: <SJ1PR11MB6083D914A12B64369E478BA3FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230725080427.23883-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230725080427.23883-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: 030df67e-eddc-40de-4049-08db8d270014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6CN2w2GcyI8HzO+oUldFqTgVm2FerR0jQw3K1KLI4iaOPMUFWvRrwEgf7TLpZGJEERT0c/F5GacMJ/6SDUxA73uvt8FqkwkSD33aCKWc1DEEa8P6RIU64lg9/yskJYqChNJ4Tx422gBer9FL6iJkx/7u5xmggCBTsDpLtg6Q1VoTAle8bSL71mv9+oojIFdB2av801iXwVNjReb5nGkdVekI54bM0UXwpO3vfJ2ObJVR02zHVllBQhyifyqu5svNR52Fkjvk65rVcyCQaAJAJHIIkpnPhluXhh5fAhnIgaXaBllwO3aP4Q5FxehNcMiQnekhbUV9i99kbre3nayc+WKgCn+P3kxmuv8meNQXiwYkfE0P3zcUZ1bnX+H7APw1a4QNw4pBJ93BiG7qhdBvT8gEM1F4mvqo+JKxBHUNC58bDmlAa8uxKjLvRIeAyHW2v6KCeyvD5caZLMadP5NSTS5AwxIDGSoguvCecN6SY2ZqpAgn2WAzmXyM/VEM8C1fUunVLpYPHQ8Cg8KauphOVeFgieH/XB7KDyv/l2CxpdqRIo2RSEhcUcwZ78eDzpe8WTFmL0p+CCyeG3E6lYjdU2tzhYb/AG4/NazRM3YVEgBLw8poO2Gqef3UQK0GbBp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(9686003)(7696005)(478600001)(71200400001)(54906003)(38070700005)(33656002)(86362001)(55016003)(4744005)(2906002)(107886003)(186003)(6506007)(26005)(76116006)(316002)(82960400001)(38100700002)(66446008)(66946007)(6636002)(52536014)(64756008)(66556008)(41300700001)(8676002)(4326008)(66476007)(8936002)(5660300002)(122000001)(6862004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?adwLq0RyypFshiqKfHBKu0KUIHwooHBFvn2Nyz4/IxTUoUzZ6ng2c/YdDEko?=
 =?us-ascii?Q?ak0zOZap5uUNxZBhO9nHPWbSC8IOfPHHOhpBOtWhj1kZ7BUeefwQYnkE6vP4?=
 =?us-ascii?Q?O6DCVSD1QYYOjRIHD6uGYZ8lS4TSKmVr7ks8PPxxWsJF1JNLGVPs6x3oDDVd?=
 =?us-ascii?Q?I4KzwI8v2MJOgNo59ZFIQBOwliX/dzkUQpi6YCShVR2sH7kMdjXupEbz0zdD?=
 =?us-ascii?Q?DjNW1EqGTrE3HNNAUY9b7q+tl1ciAA5lNyFghAWMYPLVawa0XIa9ZLBBKrt+?=
 =?us-ascii?Q?PnltdPA+JMi4c2tCXw+aoTyzLtUbvEz1np6748E+0VACtsGORVjWNRkAVgE+?=
 =?us-ascii?Q?XD2o9gAUpcDzXz4BrqFpha8n87DVZVBHGWq4gpjcWUXIafjIziAZTximWQD+?=
 =?us-ascii?Q?WGdMGQLw99Q9BuyUgzWMY4YXHiboVxxSdVkPNVIqoXeZFzReo4iJ1wx3exch?=
 =?us-ascii?Q?Pbl9FdTJ8Y7x8WlDXBNeMV4HZqDjCjEO1igW33VQ6cRZr+tSfvNqob3NjJi8?=
 =?us-ascii?Q?mXPNEwkXP2DiVWlWThJpkE+OH+HzSWZ3TajbdMUu7V7C1ZK8zaGIc+tE5Uxv?=
 =?us-ascii?Q?elAXiuotEWSi55orHm01qzcFt0oR/F6CeONqANj8EuxspbAFQURr+4NTpbU3?=
 =?us-ascii?Q?tV/3Jo+hdI7WsGakXf9Ab+Z4MjMAQxWz5UkRsrX/x373uSmpgDw+ipBaKGK6?=
 =?us-ascii?Q?Dosm6z7K80JhHx4ofYjG61OWqLOD08g7CBWGkHEflD4MkBJROL2AehHw8t2A?=
 =?us-ascii?Q?+J/lyF8xgIgR15D+bdo1CwbWH9Y+9ZIpukPInjcFjBgxBoUHWMZwHV1j/y6y?=
 =?us-ascii?Q?2CFdiqGR5IVKds3Kf7fS7yIv4bRC0LFHt9JNGuGQqo8vzv0P2D+dG7FvYj3V?=
 =?us-ascii?Q?F2rnDxfpzHBQQqSy7RGKYJK7GaWUdtMG2+LQAWUjk6i01e9pWmCdSp3ZDfl/?=
 =?us-ascii?Q?crlcIk+/jHBXXQX6hCS/MisFjNkf6ziCquviKwlrzbyYlnN6WPRgJfEXBdHU?=
 =?us-ascii?Q?2wK4Sz9DqEIsN23389dDiVblBIwMmAbQD/sFI+e3rLreKch8kWX1hiaaRe1r?=
 =?us-ascii?Q?99RCB2Dr0NwYhxsfMkKLu7NNFa8MMQB26OBjD2gEx4m9QfN4spC8BlDNjo/P?=
 =?us-ascii?Q?4l60p/PJKfEs/qCRtkjyprzDeE9V9LRwXFoniL/MzXHN+1StssUrbr/T/XWY?=
 =?us-ascii?Q?zHG7f1h8i3PELKZkCpmY8uQmX8swq/K8RozX2ECRe3Zp8ghygRFQ2G6JyLoT?=
 =?us-ascii?Q?6cpFlqD5rWVJ6km67xVLJBtijiSalfRpjgaX7o0WiB0uMmxwCSjz3Fo6rkzk?=
 =?us-ascii?Q?VIROncV5bwE/NPbM5JJ5FQYK+cU3W/cfl6gMwrsu9eUbOjRZiq5UsCdUtAIH?=
 =?us-ascii?Q?s0pQl+JIp8De4dI9eV4cXsy3je9iq0WKEKvZnIYWK+NW7OeXP30trXsQMoh8?=
 =?us-ascii?Q?F+4iazyeyayIeiLn7Y4cJxpwLhpGa9AWzSirkdWfDJoUtmj4wX43uV7p/1lQ?=
 =?us-ascii?Q?Ge3Gwe0VRc+L8VisqpOag9kvB2KdEFTzXZzTOuYJTO1P3mAhvGORkKpaZy+Z?=
 =?us-ascii?Q?pTiqA0ECjHFwbJAKGkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030df67e-eddc-40de-4049-08db8d270014
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 15:51:24.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PfDXdOb8O4TjvHAGU+5dUKy8n2KFg53INEAufV7e/RQnvSNHJJA1SbKDQ1TEtEiGoPAa/VonkfzRAkDZcoU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix this issue by moving the pending error handler after the registration
> of the error handler, ensuring that no pending errors are left unhandled.

Do you think drivers/edac/e7xxx_edac.c has the same issue?

491
492         /* clear any pending errors, or initial state bits */
493         e7xxx_get_error_info(mci, &discard);
494
495         /* Here we assume that we will never see multiple instances of =
this
496          * type of memory controller.  The ID is therefore hardcoded to=
 0.
497          */
498         if (edac_mc_add_mc(mci)) {
499                 edac_dbg(3, "failed edac_mc_add_mc()\n");
500                 goto fail1;
501         }
502
503         /* allocating generic PCI control info */
504         e7xxx_pci =3D edac_pci_create_generic_ctl(&pdev->dev, EDAC_MOD_=
STR);

Though it might be hard to find such an old system to test.

-Tony

