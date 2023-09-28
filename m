Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E47B1062
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjI1BbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:31:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C0AC;
        Wed, 27 Sep 2023 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695864682; x=1727400682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kFzDDcKHql4iIfs8IFlnrJhrsoP2Yj0JdKRjInDzNA4=;
  b=n2PSAiEk6yUqVrPU8/xGL1jLT8Y7n4sTH/Hap35ZzAyjcNkFLL9cHxq4
   XQN37tz2RjtznHLMZY6vHRfWSLmiV9PpovrlEAUeLLCyvhJhRagals/IW
   kAGc723u9b3ychr2zQF9O31C/u0SwGC0unLgQM56boPyoFm5xWx4nLi/T
   tkzDujJAJv9dsXsQKYDnWW0lxN/rGKafh8lLZt7yKHtQbephelQJR6bN+
   A8x1Q+F23A2uoRJLYLEY6qYcyC693DZv5jShTw2APW/jhVpOjeyoeU+sJ
   s/uyArgySVeucwhwLTElMMLJ2U+hFHOsPEgGL3X1vhun2DcHygEMvM6Dc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448456561"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="448456561"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 18:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="996387332"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="996387332"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 18:31:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 18:31:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 18:31:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 18:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgcdudpnRc17tQ+YJg2ZNDhnAD5e1Nl1DwNT7KK+WnN8PGMwbIBqInUWFSO054m0p9IIcGqdNjvE8XRiqqosmKprqN+TbM5xCaU45k/AfUdyEyr2gySsm1/pKXQEkcMosKCC79V8UQ3TcCnj+8Y5ABl14EBFw2BzLz1rUCTeBHbmg9DAEuTUUE3QPZvhiHVB+nWfhCdu0g4QMo6ExQDviWFZcdHa4+bptUs7JKV/NJ4AGwaMTkyroXkCRM8BzsLDVOn5dVqDRQ+E6V8twPsLcouHgkxRDKQ5CjTMA4n5dQ1L7UrtmVn6rDrkH/K2MV2WtrVAhLlHFcpOadaLj+0hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neaUnbA0HzUB/jxTfCXCDz7b3fUzFXAwFtwmKoMdt/U=;
 b=jA4pWL25dpX741HTZ83KJSvfNgwVdhT5WdCeAsYSP828sAChIPYCOjE+os5rm7BeEVwc6US8vU8xQtzLXM5GvWlKOlZy0fNUKIdoeINDuXztACdrB/yuiVOQZvLEkJDKLgwCWQh15CpKTdrHbuNE865j4nMC5AW6FoRvxBZuUWSYzq4NOZiz3su/XT41urItI1cBPT55t73PkcyCZyiVc1g9r0K8JekvWmDtppRYX4MvHG+7qfm3loBrcq1oIyiC9UZF5ze7pzVFIKgFQvPV7TdIoPtqNA1EvuTh6UWDXZT2Jn8WR/AHy2gs//CHN9NO00a7URl00kiN3B4nLG2gxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM5PR11MB0042.namprd11.prod.outlook.com (2603:10b6:4:6b::36) by
 DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 01:31:18 +0000
Received: from DM5PR11MB0042.namprd11.prod.outlook.com
 ([fe80::847d:e218:d45a:2079]) by DM5PR11MB0042.namprd11.prod.outlook.com
 ([fe80::847d:e218:d45a:2079%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 01:31:18 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH v4 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZ62rbNkeZhAZZx06GIHaJQh/KW7AjypoAgAIVhzCABhXHAIAAbckQ
Date:   Thu, 28 Sep 2023 01:31:18 +0000
Message-ID: <DM5PR11MB004261CE9939D0ECDDB81D4FA9C1A@DM5PR11MB0042.namprd11.prod.outlook.com>
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
 <20230920023243.2494410-5-utkarsh.h.patel@intel.com>
 <ZQsE5hgm4qYpr/My@smile.fi.intel.com>
 <CY4PR11MB0037E70612B8067062AC1C40A9FCA@CY4PR11MB0037.namprd11.prod.outlook.com>
 <ZRHfNoiDazz1ZDtD@smile.fi.intel.com>
In-Reply-To: <ZRHfNoiDazz1ZDtD@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0042:EE_|DS7PR11MB7949:EE_
x-ms-office365-filtering-correlation-id: a5ee8bb6-fa35-4309-3a2f-08dbbfc29cfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7J7ru248whyrayPG8dVjOCjdFgznwQBWCAcnKTmMqq2Ib59aLLUSPvvdlLrISYyt50+FLT3E8px9Hz+kgFU9zOr05JmEcfEAvWSCemcpK/AVuQrMMlY+B9VWHF4vflnJtDBvlYcFwBaV8xXv7rX5YgLFBFXELqxgLY3LFpCz4oiRUXUndsRvPCkwfNMjvmTFxsQRp55sv4quCQSAfsDbgOKKU+3Gx6yqaxPmevwTnkzFTLwuNoglp1VwS/4wRGWImTG4zhGWHE8v/y6S4oXvhkX2Q+XlimGjKpboHG7o4WoJui7y/KClQZa2E1lopOIHYgO2D4qHAzgvjx245+uZavnrs0m5zOjSwzIjPeJjVcPf6Jh5rYt4BIGoxg8x544q5gaMqcvDzgjUAoxt9Et1OL8n6pBmoMNtOJ1u/sLxGMmsYGbuKo7kF746/kDnSU0NB0JJFt3oPmZwLiJKifYsAbcH6lmhEM1SDwpgPkJjxWDzzTWPYuYOLdGB2TXpQ3Np5kReoPp4S8Q2zOs0QUHSN6NBSxmuqbK8RDk6AbRtbUpxTCl+v3ehQpyIyytvWia9hztkSc0VDDEYaIL3Dat8qCqCSK6I/V2miX8+N/jHekeQZEhfbTuHaCGoNSejYRXx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0042.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4744005)(8936002)(55016003)(26005)(478600001)(5660300002)(86362001)(4326008)(8676002)(52536014)(6916009)(122000001)(71200400001)(38100700002)(2906002)(41300700001)(66446008)(64756008)(66946007)(54906003)(316002)(38070700005)(66476007)(76116006)(66556008)(7696005)(6506007)(33656002)(9686003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0pXQv5IMZC3QCnNXHY3NtzEpE7uXnmKSFab2rLdKRxEyUz1ELRq2WEWos2aH?=
 =?us-ascii?Q?5kgpFJp0W01WNtfSJE5rKwAfmeWYCeKOO5DoBrMZAZ6cNNesHTbDje73vJdc?=
 =?us-ascii?Q?Xe5hNAyY1N6nYDCllM+enHOYTE9LywMBZXMPNbRU4xFoicwXJkjLIR4S+g9o?=
 =?us-ascii?Q?8RpVSri64MpXxw3S016er75i2neXd3TI03WXdOPjsYekyLYRRRb/fHbyKvIQ?=
 =?us-ascii?Q?u2yxm5Tg/uEKO8xd/qVsLqUpVGlsaxfQkJTpd3F4JTDos3m9S2mocPZ1bbxv?=
 =?us-ascii?Q?GQfItAm/O/zW5JIj4N/OrHAzrV9LwDtl/+xCDLcJ0hcXRlxUm3TJzr5LrU0B?=
 =?us-ascii?Q?zUx2OkTvLXw2UV/RNx1J79ZvheP8ShcQG3kFbVynD6V5F7nFHk3pJS1Xh46O?=
 =?us-ascii?Q?E9Y8YbcZdvfafkmhveRFzBSc/9RujBEVceSRIvS9yCm+ASl0vYO10lmzkDu7?=
 =?us-ascii?Q?1jEfHCH7PnQlJIYuA9JJFuwqdkGu2ftHPi6dDCFz1oAJ5/rgKT2anYLd4Rnr?=
 =?us-ascii?Q?+bI/sxY7C8HqF1SPVm6MxIa655yTPMZd/zaDnnzs3bhkz7O4rVGG8xKFw9Jp?=
 =?us-ascii?Q?+sbQAXUi3NqOoN7kGz0aHrO7+hxTGGv3ltCvnuUR9XwG75OQ58Lh3OeKbhBg?=
 =?us-ascii?Q?UJNaXTVG/KYfrT3BwC9IHxyn6Q+JM+ApHZ6uJxlh0nSNF45mkVqajxrt0i8/?=
 =?us-ascii?Q?eT7WZTGJiItQYdDSm5v7NmKgCerg5iQdqUT/7T5e/h4wHdeX/U+9PKubPLGV?=
 =?us-ascii?Q?P5GGyEpIGll19avkAvfwRh8OyykNrZQ5sYAYKHtiTg+hyownCuj7UFSWThFZ?=
 =?us-ascii?Q?czXPW6xAGuGVzJaNus2X/Tf3cvXN7gCrNYLVxS8afL6DjNOt3TTk+3U9Lnzz?=
 =?us-ascii?Q?KvidV02KNQEmIiy3iRy6LuN6BAVie+3xOEDCZcB6TAuEDHmi2g90JcwLtuau?=
 =?us-ascii?Q?TJpwMpR8eVz9u9+z6eCKMRGeofVVpG6wj3ej9yALpV/CCmOvp8+d/V343o4O?=
 =?us-ascii?Q?SF/+QqJqWyrixFve6VMAJbqTHtShQiv6Rh93oKmWtWyigIX+2KZusK6iDYD0?=
 =?us-ascii?Q?kB3h02RxHFiAmI8h46i2bWBv8QB4xRILVsl6QYxxeQkhTVhqhxHV33AA7+ko?=
 =?us-ascii?Q?ERaRh+8knN0/yb4PlsJIRvSvzwqbox0d6d06wGhEWfWcLNEVp9TMXbzGE164?=
 =?us-ascii?Q?kCg3YSCJVASauYbPcMx7LqyUGKQUSbKNgPM16MnIV0TgiAce1xkm3HmnSeeE?=
 =?us-ascii?Q?CvUhqcGxQpzf2goiNo5XtfO2QUrWr6D5+TeRK9gUUVVmtJCkqcgKuYy3o0YO?=
 =?us-ascii?Q?Jvf3gbsVbX9KZ66Yw+fIc2bz/1gtWy4YXB1t+w0KonhO0kUEIP6OPIXEETdY?=
 =?us-ascii?Q?Bo0At9zHL1/v/FAb8s1Z3IGkOiskFUKeE/KwtX26yXdVBdusPhj/tQ/O5fOS?=
 =?us-ascii?Q?65v6eV1TEIyxCDkGq+R+V/jfL19gVpFCXWuAajBbwKKl/YGmcFV7oDBMwFYT?=
 =?us-ascii?Q?JS1aKGVsu6B6wM9sGmI8TIeXPecPRcMwqSx4ghBg+U9XSuAbUBHItNxlS+Dv?=
 =?us-ascii?Q?S1dbx7zfohQ6VdF6Z6KWVXf7v0wy7nTvLmDtp8yy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0042.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ee8bb6-fa35-4309-3a2f-08dbbfc29cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 01:31:18.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q52bUun7laS/wpRuofOJrTk/NnZEUxvFJ9k/xbETUKaM6ZPS+qGeV8KfHSFztZU3raeIDIMF8pXRmhfopw+MVmWIeD32yXi1nCbuifbnSwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949
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

>=20
> On Mon, Sep 25, 2023 at 03:54:40PM +0000, Patel, Utkarsh H wrote:
>=20
> ...
>=20
> > > > +	/**
> > >
> > > Are you sure?
> > >
> > > > +	 * Get cable VDO for thunderbolt cables and cables with DPSID
> > > > +but
> > > does not
> > > > +	 * support DPAM2.1.
> > > > +	 */
> > >
> > Yes, there are TBT3 cables which advertise DPSID but does not provide
> > any DP capabilities in the DP discover mode VDO but does support UHBR.
> > In that case, need to use TBTSID and use capabilities from TBT discover=
 mode
> VDO.
>=20
> My comment was against the style of the comment, not about content.
>=20

Ahh, Okay.  Thank you for clarifying.

Sincerely,
Utkarsh Patel.
