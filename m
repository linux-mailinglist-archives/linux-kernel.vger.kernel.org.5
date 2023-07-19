Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3460075A01E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGSUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:46:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67418FD;
        Wed, 19 Jul 2023 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689799568; x=1721335568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G5+V6oWzi6eJfvlDuvhWm2ws+L3utOAoyU/EZppzzaY=;
  b=fVewWJECOJyEY/6gNuWWsUzqQYdhp73jjcg1FmTG+TXA0KhMoaQgAt82
   RMViMvrBXqEyctjB1ypCDPLv4ornF4ryatnd7vVRk9ijOzc73nGJd71wk
   1Nb+H49816nR0AGPIckeM3S/FWoeFyjsGReNT+isGRT9g0ZjkD7OcyggI
   0/xP6rzGv1S+/lm0MhpoREjCv906VfiRcril2TAuMzqI862r71AWw6ksY
   FxP4zyL2usOOmyyH4pVmAxgUhtr+wexDtEEDEYUza9YaiwNwtP1w2O3Rs
   5IQdQllZg8lKZ5V/GTP7OklW2yLDCni38ARE9KWLNGXkNLEbDp99NUvyP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370133234"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370133234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="753816085"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="753816085"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2023 13:46:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 13:46:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 13:46:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 13:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICSwajRaEZKYpluLajDujx2QD6XDaCFRZy6yTCY6RwhGqwr0rOvqSUaHd1aYc0r7SDm27Dfn1KCjtW1a2GvuVFyuPoZCNNPigLysk6CBxMyBQ6z41Kdtd0LNAfc3v1IgkTO/AcYVg1YE5tqc4eR2pnArM/tT3BCq8bR19hZsQHt5+Qu9L36ZCPL06SWKMltSeO1rx/UTxbBjzOVxE5LNeRuzbg9Tzktur5fPVDSwe8MMqSspjugPV9R6CQH9dI99qlKff7Aky2+y0rXNYlHxvsdXVUKYthaCrWUcnFonO74knEVvSBpjTQQb0TMe6kYFgANu1yLsIzeSWUVnmfVB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEFhx4fRpVf5xeYPee/42IBvyoI+xXOFyyx5oPq+ovA=;
 b=Rqbs0CoPk6o0hAyT585+NnzEqpW7NJXYzp+TX551iXUvKhjxWRplmhQKveZQvLFi/4OQ2MOv5N7ArkViei3vep5RXokMavuP3zhiJVdB8HpwBtmqGBeyerx8YoIO1NMZEcEKCHuwiv8nPWauLbME9oqzbqWn1dJzCQB0heVBKo6Df3pm5hfm13VXjrezlng+77DN7DLxz8BHdbKeL56zi+jtC9z1IJEgaHbVfX9oIxxfwasvCNfwo8LY/fPnKHpcPovvHx6ZEUaXQhNpn4IyTxWmh8dNGlBGAghIJuugjPSFxXlDbQLwgl/8UU+yTaWG1mQv9g4rkIhY8tO2nP/aGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 20:46:05 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ee97:2e55:ae8d:2809]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ee97:2e55:ae8d:2809%4]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 20:46:05 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 2/2] usb: typec: intel_pmc_mux: Configure Active and
 Retimer Cable type
Thread-Topic: [PATCH v4 2/2] usb: typec: intel_pmc_mux: Configure Active and
 Retimer Cable type
Thread-Index: AQHZuR/kR1fgAoQ4cU+gDZWp1WKvJK+/hYAAgAILzUA=
Date:   Wed, 19 Jul 2023 20:46:05 +0000
Message-ID: <MWHPR11MB0048115794666D99182D85DBA939A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-3-utkarsh.h.patel@intel.com>
 <2023071800-roaming-automated-5404@gregkh>
In-Reply-To: <2023071800-roaming-automated-5404@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|PH8PR11MB8014:EE_
x-ms-office365-filtering-correlation-id: 7b1d6076-42e4-41d5-3f02-08db88992c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZTvXENOZFnNxyDAklYgOGhfB/PTl4PjuUVRownF7/tkCYP3Gel1RXbJ6gdhf9a7zM/eCyqu3YAJPchQW5+X8/sKggXVLJjUdkCiPaFuWwRGIcKYR/jQJdfBXeRIyk0CsLYc4/G/6V4V6lD19Io5ByljcnGVmL3TjCsX9h73//ZyFj0aB84D8Mp3ye8KWxFyHCndCXfExw6Zek9c5VG72HndosMEZJDG5+tDn2Rojo30KhOHNulERe5CuWXfrs1EQ3DQs288u1jsAFwhQ6Xw+ya055Dkq+Uqm3gBKeGbHbRZcQlCt8u0m93yfAUYkyZ2gAlisqH/cYGDrTSOzKSx/J8vvEqRxadCEsUyezgqlRsBSO9LBVEQ0wszinnu2VhznDT0v/VkGMYrOrtbGPApoDSq3XDWc6IlIGHmG582jZFWb9q3A3q5/rrMT8BlkOmBnWdcz0Ooj753cKSp0HPw7Bbdd7xcw9liwG4pEDevMncsC8txe+7e6moeWBIOtOUYEmdaxrvs6GPjzfY77uvVbgZbcTt2LGhqeqE4fDLOqU2jrxe1XiT6kpiqCAkBeljFhauePs6LpwJKOdjUZLG0V8BvMlrs2/W59Ko1GMfyk2MzTxFRU/nIu88w38PEd970
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(316002)(41300700001)(66476007)(64756008)(6916009)(66946007)(4326008)(66446008)(66556008)(5660300002)(8936002)(8676002)(33656002)(83380400001)(38100700002)(86362001)(55016003)(9686003)(122000001)(82960400001)(38070700005)(186003)(76116006)(26005)(7696005)(53546011)(6506007)(54906003)(478600001)(71200400001)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ezr0DyQEOjYHemzk3+ALIhfWK7qHMGA40VGpG+PF72PR78lDTYhf54S35WJ3?=
 =?us-ascii?Q?O0j7YMagf3uOfSywXQgcEqzHtLEI19wIkbSDlqT8aOilKvPcHs8soMH8Yq5O?=
 =?us-ascii?Q?IgVu9QPRlS7nczzNzy311zqrYGPKQXMDUW5Y36yXbY8OZCj+yDuDNe5PsRVF?=
 =?us-ascii?Q?6DW8iWZwBm31ZcLu/2MBR/4AbPAjEFsojzThM+2xt7MigLxZVYZ3OwCzTf9/?=
 =?us-ascii?Q?queazfFpBpNo+07sQBk28Ev6iVSBfK2v4PieAbsuhcXqV/tLBYJdWvfIunb0?=
 =?us-ascii?Q?6NRECpy8vAqUhm+Xs6D6bsf9MDdFaAt61DQcU1vHNrOMoKF7dQ895CPTPyBu?=
 =?us-ascii?Q?KWDgTFr2olrRDs+rCMoYbXq3Z0x23yTkyddxHJWmzl2x7hia1mLYKfhl96Gt?=
 =?us-ascii?Q?iXVQ5zYwTy8uA5XR/kfPNZ7BCur29rzQefJUadQo+T4Yl3YDb338bm6kevqX?=
 =?us-ascii?Q?kjMVucNQFdDlumvQ/dqDyFCTe8dkYIYyBz7IJMbIx7/crH0gc9HL0ok9Hchd?=
 =?us-ascii?Q?Q3v8BxqhID9/8QXtWak/gjDSEHct6petuiuYdjk1MUoD8mYHu2iHPS0p6C1M?=
 =?us-ascii?Q?UAte/IVFz9RNATDwE+9HnZq5nXSZCOF7RSkMyyaRafQjbIAyC55BCiFH39b9?=
 =?us-ascii?Q?eYFsnQ8b+/4HQBrVzpks6EaKrhMP9/9X4PrrSEOmtFbqFsrSj7x4xTlZtnBy?=
 =?us-ascii?Q?ACJlpo0uD8pDncMf5Sv64p77l341SsysAYasm75C10DG9VayhCt6jHFC/FrW?=
 =?us-ascii?Q?xd/BCy9cybZwaDM4QH1c3U46zqc0Aey9Z2yYtghzWoRiBTyJDWi8hHlFViZH?=
 =?us-ascii?Q?9HHUXpDLf81qaumOr0pIfpLanhCjIM4qGKvbMCcoXe7QtapfhbeNB3aHfj8X?=
 =?us-ascii?Q?StoIom6EuEG+OZr5XK5ANgzLLDhQZh0FgJA7ICdOAQVeufCWde/X7JD9XEt2?=
 =?us-ascii?Q?d32I+R0T3fvjjs7VPnX4NbJNOywHUyu+sgyodZ4IbuCrtF3vPR98cxgvb/Hq?=
 =?us-ascii?Q?PDQUOzjrcMVbuAE4zbbG3WtpzTC6dHvdcmz2qCVoTl18pSd+yOUqOm3TK+NO?=
 =?us-ascii?Q?U1Wucp9k9fFkrSUz9O1K9uqCMm1fB1Gpi0+PLmBQ2V0zqH6/Vx1S9FKmpygr?=
 =?us-ascii?Q?j//zmL3DSgt6V5KQoPujyZfOzDH21V1fbHsVmldtoCkluVqh69rhUpnkILLh?=
 =?us-ascii?Q?Vl2xdms84NkO9oHLxYc7JlvWKlYHDVbrL+PAD2mvqWehCIjb2CcOc/uwYTw8?=
 =?us-ascii?Q?n0ebR5BaQUAuI9vkw+36MeLxwb8Ad0vQFWV2KxJHRf+PEi1l2MXYszsCIHKC?=
 =?us-ascii?Q?4GSVCMk7SC0T0RVWP3K+M1S7Y9wcx/TVsa2OTZsuc01IsQM2Dyda6Ni7kJ8w?=
 =?us-ascii?Q?cKw6fRPq8jiVFQM9zA7xUFJdofzQE5fpmjkuLDW3MtuFrzuPiIxBoPfoPPyG?=
 =?us-ascii?Q?yQ2dyNjDasI4DyRGKK7YJKFXIBnBRmIUovxs6npFRm5wc7modA8zgNugwj6e?=
 =?us-ascii?Q?u+hqSuVkxS6/wJ8jAwSzIIQ+4n6uhvpUrX45T4u/N+G+AXUIDV2hs9UvESCH?=
 =?us-ascii?Q?3aAJ+2snMIE6gUxAViUXSABHKP8TagePm+xBbvj9EAnoCWS2fUDL42udvSqN?=
 =?us-ascii?Q?lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1d6076-42e4-41d5-3f02-08db88992c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 20:46:05.5542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibvpZx+O0mkLOH86TTNRBCX362tl85pSs45maE4xYLzHp/CT3OyxceC8ME81u+P6w9O9Y/9ixsGnS2583TyN8jKBwhO9bbRoNffa2YTkWrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the review and feedback.=20

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 18, 2023 6:29 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; pmalani@chromium.org;
> bleung@chromium.org
> Subject: Re: [PATCH v4 2/2] usb: typec: intel_pmc_mux: Configure Active a=
nd
> Retimer Cable type
>=20
> On Mon, Jul 17, 2023 at 07:47:03PM -0700, Utkarsh Patel wrote:
> > Cable type such as active and retimer received as a part of
> > Thunderbolt3 or Thunderbolt4 cable discover mode VDO needs to be
> > configured in the thunderbolt alternate mode.
> >
> > Configuring the register bits for this cable type is changed with
> > Intel Meteor Lake platform. BIT2 for Retimer/Redriver cable and BIT22
> > for Active/Passive cable.
> >
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > ---
> > Changes in v4:
> >  - No changes.
> >
> > Changes in v3:
> >  - No changes.
> >
> > Changes in v2:
> >  - No changes.
> > ---
> > ---
> >  drivers/usb/typec/mux/intel_pmc_mux.c | 28
> > +++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> Why the 2 --- lines?

This is by mistake.

>=20
> And why are you not cc:ing all the proper people (i.e. the person that ca=
n
> actually apply this...)?
>=20
Ack.

I will correct both of these when I send next patch.=20

Sincerely,
Utkarsh Patel.=20
