Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2476D87E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjHBUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHBUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:18:28 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E9FF;
        Wed,  2 Aug 2023 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691007507; x=1722543507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qE6+czYu3P5RjbUSv/VqrQ8rPSt0rDJqz7xRsFgoR/A=;
  b=VBtqxaZSHX0jnRGndNOnYqBbF057vyvqg7k22usU7/711Bv0wylZBKJy
   5UhWDZUGZgw0H6ocD9Rfumt489f6/zYY6RNKMi5opbBD/cCdpn7rdwI14
   ptCQ8+T6zqCNle7BNzyJtRMViBmGJUpOB6Y8BN9yxsa5ALJpeSM3+xWXU
   7hxC6C5x2DEHGjkRsYXqf5Axpo5Q5iKFPMVr1+48nrV3eFTLY1KLeGqXp
   fF1k/lvnowci6imey0pGOMVzNYR7b6Pkp6VSFsAkgnMDqZP/EikEU3jz0
   kE3lDnbbAYHxD564jkt6llgspN+lscsb8QuG8aSxBoHXpEWMLfrWVaEHg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368588195"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="368588195"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 13:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="799255593"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="799255593"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2023 13:18:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 13:18:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 13:18:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 13:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaoYGxXEBBUy195+WjM+3rMVmuk4g7FBzUn7mKcN3QKw/Om4ruREp7lR7UO/4aCJJeFhmkW+bwmTgXDYwXY75pHNmj/qzKNkVWtYIKNWhOzc48bmRgR6uEFo+fakBLgVEHZt5CQe6E0Yw6f6WkMaq2C/sGTI36wX1Yhu+Sn/bC/GvuBB2tkDJRjIuPSZ1fr1htRWI7gQQQM6rWsSzLfYOo76qKoHSjnr2sjK26ZGmgF4LM63q4n+moUfU91KqAyAd9EOtVapqW3Ufi8XdBbAnRx4EfgIHPH7BhstClEkZRmqQRhtuFDyNb7HLRgIrjoFz+V7A+aojrlNwCWP3tVpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE6+czYu3P5RjbUSv/VqrQ8rPSt0rDJqz7xRsFgoR/A=;
 b=PpuyXgQDKqdWM+XFhnnK7vq8MD8j7wg7O5n8kPM1OUxUCkc8IoWiJrbPGx876BjMc6ZbnThtQUz+ELFzRHolEuqubsbPD2r+T2I262yTTE4joNE8oA303aPcLF9CxISlIIKzP9VRdiImJcNuH9OylRFE5hfOa4injYBFb6os5xFVqQ+UU99anahXAZ1saiz1gbKADiAekO57BuaKvO3bttfsf8lzAlMa9ob1fT6nc6qWu8BdcZmb0YltHWRy9LepuNJ/xE6LfCgEkTD73mYN1QJaVntZySM3DURajdTLvAU+xl8Djbw7Ty0f2DntAQYZGZ2wEcem3uO1Qz8NMSp8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 20:18:17 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::52e8:9695:e645:1092]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::52e8:9695:e645:1092%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 20:18:17 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lim, Ee Wey" <ee.wey.lim@intel.com>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Thread-Index: AQHZvs70AZA+3i1QEU28InVclO7Ajq/XfnFw
Date:   Wed, 2 Aug 2023 20:18:17 +0000
Message-ID: <SJ1PR11MB608356E4C19E9A3D7FE030D4FC0BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230725080427.23883-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230725080427.23883-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7384:EE_
x-ms-office365-filtering-correlation-id: e15a3c63-e8d9-457c-e6c5-08db93959bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8MKGwafeA1Wj2G/1LP8f8TztljwkITkC4iOaFM8Pf2saV43IOw7w/x/pTVWtxWUNDe1WXk17rPyW9deHCTG/KZ4W4OsNuxX0Lwa2yEOB0Q5A+z9sDnETwNLyVhwXeb5Q7ehlqgw2OIEqpH0sahyC56H1QySAt1qAIVeN+9Y5ef4hqcQ08xRx6jCTKOzNAa+N65/oJWGlQS9SkbfTdECrmT6YsfZ8bSQj8Sm9Kl4B+nzmCqk+aIvj5MOLFk2MU0KgyxHtfvoM+PFU8bIz28ZiD+ku5sJVowSOIxeN4nYgCUNLktSPGYAPCo5S5mhpl/zEb5Hwj2kVwYNoeEVgFnX/iI6yBsmfNb2aFOnPRpHu15G80l55Fsu4gUM3NifQlUK8slhJiMWDeEEYpACeRbItwkQXlig536j4/JibJFvlHgLlPIg0inPLmAIo51SYguvsa9jg7/OLGT7KVYU5rt6LqBAW0B+oSnLP3oEhsnwNyxoIqc6L2H1MeQXCkGdNZQYqVJSg/TKgeBAOw9KvEQZqNmhkes7Kvw2TtindVZt0CV0YApdfyXxJlN4PP1dfTrTmnFlrEUJ7INeSb+iTNHqJokYcAf0Ic/2gncqkl3HlwadZKn/uNPfZTeJgGGwsavB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(107886003)(6506007)(26005)(186003)(4744005)(316002)(76116006)(2906002)(66946007)(4326008)(6636002)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(6862004)(41300700001)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(54906003)(55016003)(38100700002)(82960400001)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mwRkD9CjFC3+wuZwsZR+wjZON/Es3bDE1f580gvQxjNCBawjbCC5xw2HeoNi?=
 =?us-ascii?Q?Qy8gMEsNMysAuGgDYHlo/mk3kCXCdj3QoTZ+5aGL7z/aECW3YzKhfCS2IxUu?=
 =?us-ascii?Q?QXBhGUj4g52vJEkXLHzDbVmw+zsL4H67ATnhbeOEdP62ekizZkhOqTxMOC7I?=
 =?us-ascii?Q?PQV4WBHi3VLa3AHy4wr0tKHeYThVETvEJFEmsusoOgwlaD3QPgqFyGoJEKfo?=
 =?us-ascii?Q?CQ3n3yHwy67nQ+0QKkYKL8Lrtj/8nSOQW+Uhuo+IuNSerHi4NBo3KSPB8BJu?=
 =?us-ascii?Q?oSFFt4Bc4Qre2TqyqymuA262MGwMCjDFRC19Mo4+RDwsQN5/Rn1HZnB8zohA?=
 =?us-ascii?Q?SqLdOqKl5oXNPO/deZh7IWrG+FjkxxYNSnSI3fTnWjQrF7Hr2QgrqG+wo0Jg?=
 =?us-ascii?Q?m0ZlPZip1pfmk5GJ2rhi3PE6Xf+oLelreKMYiZoqO8wnrx/vo+gdzRbOmwf4?=
 =?us-ascii?Q?RFEEMB5iSMk+9ApQ1lvDjtNtq2oFPSiov56r726nv4XFM1BxJ0TgfIJFua45?=
 =?us-ascii?Q?f6Eifu/YdQZvhdJQrGp4KhTF8/quSjIgfsdSpQi5ALO+16Mcuz0pe/h/Eauw?=
 =?us-ascii?Q?hWexuBX21xltj2cw/m8bT98Er7KS2GcAB84hnusmOANFvupAu9QXhsZu7oAG?=
 =?us-ascii?Q?exW0Z6LjeAmridrOY7lPgTcSmUpKJGQPnuSMJrtZ/04owSL6DEHJC/KDPCpC?=
 =?us-ascii?Q?JtAphsGGmxVDFB+aVhbQGpF/svPavyVvndhBIiwtOPTaPq34u81uQoPf5OEZ?=
 =?us-ascii?Q?nyjMHMUeehkzfQVtNri6qdyp9BJDsFVZ5Jw9xCSJsilKejQ1RhIAXDyiJhM/?=
 =?us-ascii?Q?h4k3zDRCxdG4/Qs5nKRNYmpv428+ZswyvxJMfiikXp1sV3xXzCJ3ucZuW/Vb?=
 =?us-ascii?Q?nGc3uOnVhbfYcFrfyEVJ/FWqHcokZpFGyT2c9hLxI+X96SYWFQiBySt8vdA+?=
 =?us-ascii?Q?iwxSW9ieP/H8Ng43fkd6qMALzgCAqxtlBVlw437pAwJVo8tZxw5M7NoCI4f/?=
 =?us-ascii?Q?sXCozOVFMG8tcJmtP7bVg6myx6IU2Cq/3syvRbeCXlLjcERzhwmZQxgICp7N?=
 =?us-ascii?Q?uEEcnft00uUyt2A4X2fszeyt0k6YgdewkbdbkmLQrp4VQItkhYIeeBR2VYXo?=
 =?us-ascii?Q?x3Cj4LxW4u7U8gYn9lBDMzdJPms2XvDrJ4jAm6R/CHsNaUFDvwWHDU04KY7K?=
 =?us-ascii?Q?DYUvrsxCOCAa0XGHd/nPkvHJxfsbPl0XNKJHZ8srAbYFrxHVlicmyRNAAVjN?=
 =?us-ascii?Q?dR8NZRBqzZ00qobZUkO9sxHrIQEAyUDCeJZBQIBC7RwvDIiHg0jeYjvVRVgV?=
 =?us-ascii?Q?mXK+52cdWy3aATylnNRJr7zneTaVGOoPgEizAZFPt19u4WOGgjfzOTNyfpxE?=
 =?us-ascii?Q?GPQwpNZVbugr+7plGENKiOZuyw0cYqLqMiWIlLr/zeWBv+eSqXBGmIcp/ph4?=
 =?us-ascii?Q?Y27wUmkCcrVS+Ul09d4SRYrro1zerpQcxGu2Ho5ShPHBiLN6Qx2WSbkbFsdO?=
 =?us-ascii?Q?4Yg1IptDmEy1heZhcYGcD2tJJI+M0hiSh32E29cg2bH/R8PZvYf+QeFiMhha?=
 =?us-ascii?Q?qJGyznEz9gRt/iMSwNQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15a3c63-e8d9-457c-e6c5-08db93959bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 20:18:17.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+3sf68s+zgFrTKRlZ1r3yhc6KNi+/rnCNhB2KVLahpQBKJnKk3wxRM01yR0jFa+/+XBb/Z+MW0KM8cftVTryw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
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

> Current igen6_edac checks for pending errors before the registration
> of the error handler. However, there is a possibility that the error
> occurs during the registration process, leading to unhandled pending
> errors and no future error events. This issue can be reproduced by
> repeatedly injecting errors during the loading of the igen6_edac.
>
> Fix this issue by moving the pending error handler after the registration
> of the error handler, ensuring that no pending errors are left unhandled.
>
> Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs u=
sing IBECC")
> Reported-by: Ee Wey Lim <ee.wey.lim@intel.com>
> Tested-by: Ee Wey Lim <ee.wey.lim@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied to RAS tree for next merge window.

Thanks

-Tony
