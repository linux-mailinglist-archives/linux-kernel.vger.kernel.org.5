Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650087E4FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKHFTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKHFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:19:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149510C0;
        Tue,  7 Nov 2023 21:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699420777; x=1730956777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l082A5gXBJomjs6w1TbQQe8E6sXfuBVtbhKwMf/gKYE=;
  b=KzHICuXKPfFXPKB4Vy6Squ5ri2OJlHmq+jx5XK9JKGDlAHRcy8EyTHLa
   yWHEQFn1476H3SuyOabcV5nSngv1crZfcjBHKeQFY1MmCF1ncnCKqpoT/
   UdtWw4aJFv3tSXhMQNsA4Aanzj2W5q2eUAWPtiyqgnB+hsOb+VHazVI5l
   jVgQ7lW6G6P/DY/LE/hMGqWXL5yMxCG7U0w7yV9muxDDfxzDm9ocxD7yn
   XUYTLdlzHCH2tbi36czp9+zS/wnFSKDb7UCFIPx+CSpgIuXzNPfzWuHfj
   XndkUri29gb76bWSvKa8mWlntfrk74epmoxoeTTQBuvpR5/TsQtJyV2Wz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="11246363"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="11246363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 21:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="4071602"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 21:19:24 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 21:19:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 21:19:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 21:19:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQmURnMKG+wQ8MkkHUGSzEztgkp9+ujqu2A2mn2CJP9f/VwcksXszT2Y1IN6ZX2gY6dsA3QPWtFnmDyEHwWOe3lM4MTU8cmxJl+Z03QS2dkLypQZYmF6le5sI1eWxejKyyzs78BV2etMVdpUj+m15q5vhnP0sJVT9bcRFTBgIAW/zayQfWNpslFVXpQBXE/qgK96JBFa1cVnAtFIdln7zel9MKwKbRSJZy2UsbIsccS+y6uUdlfcj4JwNNL1TL7gjwxfR7+Sr9hY+CKSQbTy3voF+ULJV360r8cr2jr36ZFXnKwkEWRiAX+d4rMDNTeGqV4fnIqyI9ESgGG+YhJf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzKZldLi7GrrUrqb8XsYbTMuRlGn3qP7X3RUWYZXKg4=;
 b=JSLpwjD8lhYSwJHccRlsakSPfzqVkd0R6ladofvYJy4WRBUi5+gawR4ybVc/M/Ff/jQfextKqRj29hjTok0FUqbNBXXF2IwrEAlfqYGztSUWLPGlYRm1FbQkqvAMMrIrQuf0o5/LCLgmfaw4VVkgPGPZ1YKCWZK0M014neQBEIKBbJALoA4h6GXIgdmIYBfOftfu/h0d7VV/1iIUJkanRMnn94ZkQK/eHSzN+ArkKWgArzQIMgb3gXMLHhYxUri3BPlJNwy0DvIUBYtvOXujcltwBwEvU+MlK6OHO6ixFTP+iqxHFmGBKNFEeukufmfbFuV4LgIw++DFdat5sNCrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 05:19:15 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 05:19:15 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "dacampbe@redhat.com" <dacampbe@redhat.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/3] i40e: Move
 i40e_is_aq_api_ver_ge helper
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/3] i40e: Move
 i40e_is_aq_api_ver_ge helper
Thread-Index: AQHaBlHlWI55jDC8Rku+LIGSpqFL47Bv9+NQ
Date:   Wed, 8 Nov 2023 05:19:15 +0000
Message-ID: <BL0PR11MB312245DC5A5BAF37C52BB0D9BDA8A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231024081211.677502-1-ivecera@redhat.com>
 <20231024081211.677502-2-ivecera@redhat.com>
In-Reply-To: <20231024081211.677502-2-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: 2457dcbf-f35e-479e-3d64-08dbe01a403e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RXm/KxQZlNFqNlX7WJyPnNvbTtaVItR0ccbWDcdTppLj9oz5NO6WgIPvQj0ZTCZWATogReOYN6U/P6PcgunFgFA2WTJY1gJ1p5q2KH115N9rKy8gtxToJ4p+6/KGxVM2O+SM9SOOu88xzcyD+kPZHkIqn2ZIw1/QglBDoJUWgUMZgfTDX/0516D4GX3XF+FAXopQqgFi3rboga6WXZHhjDOAwhLYwAIFBO++t+Qq1+bvSBcCaC0THqQTB6t8FG+Pj15lsoIloy6FtSSnkiIUkf36Dzrcq1ZKAYFWZfsoweBMXJhQHPIALmdKJhEMbB78mQABRs/x/oaMokGs7uKhoKUSoDiGOVesXC5iAK/pWtb5gIpLwaY7SliBFZtEX0G9FjstyFcMKD4eba2gFcnN+zmQxKQ8/vAUh06U2d4QzfBWQH8APOXLMtjwpomHx5funkDbOYNuM6TbqYddR/ocJlVthRwz/ajHILoFdboEuRUMUo3B4cc9DUy9Oz6s5qy5VphapGJZ61AmRy04ndhFfsEoxxet/QhdMcWhcQUjTGZrFtCPG7xIaAK0AVrevyleKcsheak/Vu0IEstc5Z0abCOHXPBo1Cf4QomKgdkFgmwkjYC99TNO9fwQyUd/sTh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(71200400001)(33656002)(7696005)(53546011)(6506007)(478600001)(55016003)(9686003)(110136005)(64756008)(54906003)(66476007)(66446008)(76116006)(66556008)(316002)(66946007)(38070700009)(26005)(8936002)(8676002)(4326008)(83380400001)(52536014)(86362001)(5660300002)(2906002)(4744005)(38100700002)(41300700001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWeJ7KKrLh70uiuLdZwdn8BZdRun3qIqFvR8PKiezFEp9KTHBuAyrBKMsjT5?=
 =?us-ascii?Q?d8UvSUPTemJ6QlTtXIG3EtCnLvDJi1X5WNVs8/eGoWLcIF6+VqxNa9mtl3Qv?=
 =?us-ascii?Q?x8CBL95UR2HLkGtEQo6Fqr22sxk9uqlSsLIHHb9qB8rtJjAUzhwXJndpxIxP?=
 =?us-ascii?Q?kXwHVnJfEJTZgZ0+ULRZMk95OakwRdlRlK7K0k2gwHUld4XEvgKnezR0wev3?=
 =?us-ascii?Q?1pFyCJVyTTiyc+IwiBJxzPse4+AZlONusQudNSBYZ4NheE+IdKj2VxCZXcA7?=
 =?us-ascii?Q?vzAfZKgJpi2qHXuuhNG0N5v4SDew3Vr5/o+yJys4Ch++hNqsVNf8+GM73jR2?=
 =?us-ascii?Q?GjwkNijVK4HnkGS6N2B2vczUygPoMu5V0J9Srn5eVu3ae9u+dvD91zR26ae+?=
 =?us-ascii?Q?VuLwhdqOMalOhnlisbNISqiGWy1QQsriuDotciajRxU7AES2EhMqoTAGI7Ri?=
 =?us-ascii?Q?fuOgasLhddsQuaeb3aPeLZOm5AS4tEL5/eTogBEWfCBUyx2P6MzTegAtWjdt?=
 =?us-ascii?Q?A9VGhAUbcmjiWQsvdz/0fG0adkj2udzXYGVqSVuiPwgoBShOifiidNhczy2B?=
 =?us-ascii?Q?MIZrF2cTyyq4zmqyQcCxHumYe3ZD52rnxe8f5SURnN3rsr+X40eOplyhIpoA?=
 =?us-ascii?Q?NwNd/S+bB/ioN6JXgt7ZnvoF4GFZ70Hmyspz9xYHRRrQdcuvOjXH/FfxSu+C?=
 =?us-ascii?Q?p7+N6C8QcuJPBWeBcILWi9ETsvJoy/iy9/CRKPm8VnJraTRsvLJEIEAzBHVF?=
 =?us-ascii?Q?cQEtgjBQiWxoa3t0y7K/rS+ecsFrD7E5eLKHf574Qej53qNs9r4nHaH8pLHM?=
 =?us-ascii?Q?W8Oj0LhMN8ipk75xJf70cn7ERIOSjMiBqzLCm8VLnBViXA5XompoxV3xMU0M?=
 =?us-ascii?Q?moVU5iTSM/F6hg7e2QkXqcOsTeaPtmj3yeo3GbaczmIuE+r9tzggljHjQ+PC?=
 =?us-ascii?Q?j/Jq3tyl94eM34HTorson+E7AEqAhG/XoF0kzpTD6SGfzhx9TCpd3TChD28A?=
 =?us-ascii?Q?L1gBywBGmMNcuZx4fG4/LlJFA2ZEvgkqJs4XVbBql6HTVqgNU+qUvtxKCKJI?=
 =?us-ascii?Q?9i0JrIFHmfPUYL7iNyQ0pf/pP7XCAPwEtnvoNF//PVAj+btkCmSxEHcNPV/H?=
 =?us-ascii?Q?uMxnSglflVTKkI2JKetKmLY7DbhrMkdQCDG7M0I85obSjfb3i4KNDHGfb3hE?=
 =?us-ascii?Q?fL17H+n9RH/9dSil4mvtM6VHis+UIyC2kmrZiRu3eBmxXClO3YLud/Hu2r15?=
 =?us-ascii?Q?mKiRCMOQO3ISk4Em0rgln+FojyWXhDLsVOCiE5r56U0RTvJlEU4Xae45W/Yp?=
 =?us-ascii?Q?98Q8wvXfmOQiwarid5lZ/YZNN3sdtOxu6nCabzjKF4a8OUMQnRKtHDDoibkt?=
 =?us-ascii?Q?oPR5dyAujhcRN93I5HeGDMLt8WtTJiqWmjCcsN7T7DRu8zZEDxTc+dpWi+73?=
 =?us-ascii?Q?0+FTv4uvi2bJYmD7KMH7c0viuTmEu20roMCxT62RTNEJZQbXr/Zr3oHKvX7V?=
 =?us-ascii?Q?U9puOfQ2qjAzwlZl35Jblfh+vEWufVzxvSPKEBygoF2xbr9QfRFzpqQ26peB?=
 =?us-ascii?Q?RrHu3vlwdfLnvS0kB4eNpQXhmATlzqZvzVawBoTDk4HUxMrJdhHKflzxwVWi?=
 =?us-ascii?Q?+GmD2fVxpjZkFDrw6e0z8gE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2457dcbf-f35e-479e-3d64-08dbe01a403e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 05:19:15.4545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiEJU8a1DXZqXIWt6oVGjR9a82cpb33qzVv4LlVBXYhMDO3gbiglOXMooeh0mgBDt8cHMzs2k3rdHQnQLz7DbAIbzSGjIg1XuPZazjZ1cZZWeemPA+i4McVAVtSPXC+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Tuesday, October 24, 2023 1:42 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Brandeburg, Jesse <jesse.brandeburg=
@intel.com>; linux-kernel@vger.kernel.org; Eric Dumazet <edumazet@google.co=
m>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; dacampbe@redhat.com; Ke=
ller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>;=
 Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/3] i40e: Move i40e_is_aq_=
api_ver_ge helper
>
> Move i40e_is_aq_api_ver_ge helper function (used to check if AdminQ
> API version is recent enough) to header so it can be used from
> other .c files.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 23 ++++---------------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 14 +++++++++++
>  2 files changed, 18 insertions(+), 19 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

