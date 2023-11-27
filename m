Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ADC7FA649
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjK0QYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjK0QYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:24:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CCCE;
        Mon, 27 Nov 2023 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701102253; x=1732638253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pC7ItqT/Jt4iS7s9ERZY/cmKPTThT+AoQzduxjDNxRI=;
  b=DpmHL43uEC5iig03TbDmR9SeUeB3yF2KADIf+VN9w+dAovg7paDf0Bz5
   8/jHtoHxGcCoEZcgfbYtmMZiVx1Z/hoyc9+Kt0Y+2vohDH+jKphJbYdS1
   kiNKdQLAZJIoJOD5UAQiwHDAullM/genLLE3C8+/GIo5PTxRd8Ta+H7/T
   DoNwwvoiz89prewYvHo31i+UgBI8FXlDABgvzq2xPSaAehmXF3R5nIWcT
   wD0fACm58twjP3cgqCfTSrgXWcYJ+2HPDqA42t2RyWy3Y63UJTorNAy9W
   z17rmgcPtQXE5C8sbA0ypUse2Q/s6Zg2xw+hnpDz5JjUFmjQ5gKaEubSF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="478930176"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="478930176"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912137668"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="912137668"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 08:23:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 08:23:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 08:23:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 08:23:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eadu8yfhWVWF8DFQrm4Tebrztzdtty3XXFeJWNTwojTx+vk38BBcBEFS1aaec3ITANNW4ljFQenTCiWMetFZSDUdWtaGAGBnB9keT0TJAB2MnoWHJodp0EEPa24kB/QE1ueDSAHJsxdWyf+PyomUeNc4iJFbMvzQJ6sOwJ1aEr6TsmslgGtgsq9uAmx3DpBTi4HFbW389igAxk0IlywfOekD69CGJYTlGpKbWOPdUbodBpZN65XrOGlBBUGDPI8BRikw2u2HHlwIORE8UpKrV2mOp1Y0rRnCy5uNNTB2usEaYduRtY5sEvM+BHKAB8yyLRMjLjINRKv/Q7JYcxztlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w3v5hRA4nb6NnML8ycBRVtuaT1zcFyz8OjR12ATRmc=;
 b=G5dv84T1SgOnYlHpJk0DFajSPE3SmqNmwSGJaZ0k/f+1wVLqoR09y9GdfyOVMr107nxogJvbr6pLbauxTFfUwQqjXFeYtvZk+wPTMsPn3wmayzJxKJu0thj+UFBZJjvPy6Y+gwCk6poGEG/hUNcAqUl1+7hY92Z7UnE0Og0Rod5JRtbTdsWr+lglqjbcZDJ3hR1F3z3yXb7cDZHfwjAKKFwv9nRr/Ox255aRfq/KEmJJS1R0TV3L3af+CYZJUSeoDSHmYodFALF67Ky9zbSQqVZfP4W2iHekUKhERH48bMRKsroYJ+Dl/iq6hneF/LltEyKcKgXxDwdHOQitsCFVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4257.namprd11.prod.outlook.com (2603:10b6:a03:1ca::32)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 16:23:55 +0000
Received: from BY5PR11MB4257.namprd11.prod.outlook.com
 ([fe80::dc55:8434:8e81:bcb5]) by BY5PR11MB4257.namprd11.prod.outlook.com
 ([fe80::dc55:8434:8e81:bcb5%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:23:55 +0000
From:   "Bahadur, Sachin" <sachin.bahadur@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Thread-Topic: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Thread-Index: AQHaIPe/QZ4HasPNt0KtTZtgr5dQa7CN6caAgABvukA=
Date:   Mon, 27 Nov 2023 16:23:55 +0000
Message-ID: <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
 <ZWRkN12fhENyN4PY@nanopsycho>
In-Reply-To: <ZWRkN12fhENyN4PY@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4257:EE_|PH0PR11MB7564:EE_
x-ms-office365-filtering-correlation-id: 5f26fd20-b81a-4355-57d3-08dbef654047
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHAKS8AicNtX3DF1214ZOLy7Y9DafZTWvTXcN/PzArG92+j/rFt+ZTJGFVSzmkJx1UBY6vTbH5xUIsefvb2+wwyHtlf9OVWkd0N0cE03ZRLDo0Tbf1EypYOTBRhZGpNESYTJeOlHm2Y6HIDU9WR3tS5Gpt51zYxyqjF6yiDuMZb6a/kiCQ56MlcHiqjN1CeiYL4rjwSLSZvwqj360BMvQQZ0+bKjnyQxGkHpcpvhLF4ydyBIAvu3JulhJnyjiMSC05gWIRA0b3nqWoqbx7YjTnH99q16gnrc8TqSZIRSacHfCpH/RY2kjWwQjj2tRipqRmcqe2EcUjU05wE2rNDeIVvFCHzdn0hG9RP4p7F9rHS5H88heWd6fgoci7lLersma0V0Xi4HmTuYyK8n+ENQAsRyyUTlBOgcy3yvushQh8giNDIuCWgSuDnJtTTMQ2POV31Y97Gg306cyef67tHy4NiOPU2h50SYKeuktrklv6Xco5Zrup6M4Ib9CUKc6PvtbilCddgECt1YwLRrd7uvI2AQ/SFz+hime2ULr4vlTdHnRyWWjTw+ht93cyzJyPm2QKuPz8a0SruO93PwiKZLmbZNEDqPzR7inw5xBuFhq9lMPPafsyxkD3dJgYHrnkQR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(4326008)(8676002)(8936002)(52536014)(7696005)(9686003)(6506007)(66476007)(66556008)(66946007)(66446008)(76116006)(54906003)(6916009)(316002)(478600001)(2906002)(122000001)(55016003)(4744005)(33656002)(38100700002)(41300700001)(38070700009)(86362001)(26005)(82960400001)(83380400001)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M6LccqGjd8+StQSegge3vgeVMtJb7NS28YEF3rwCdofYZKV/j7TxBNfZB/R0?=
 =?us-ascii?Q?cUigj1bJbRO75AXJwxJUTsxm+JIS1oN/tycOGSemXbM2SpCuetNT+BgWLCAj?=
 =?us-ascii?Q?n36bYdJGIJwvfHfKAJjyhJ0z5ffPUlBf4SH240uEU7zNViOXnWhs2lLet/P3?=
 =?us-ascii?Q?QwaMd8wyF49L3rQndxhYfGTXwp/2gwa+oAIQfpmYeyGdrF4K8UJCp+WGtqOo?=
 =?us-ascii?Q?DJ6Jc3ElZRlA7sMPbVJ9kQ/438iNduDn3x7WFU9h+MZ8pcQxx7Dwl/Zn1yMd?=
 =?us-ascii?Q?mMKyVDm1vafkM3foA/oBnzJCuUVQ/lRgwq1h690P/ZVcJ6NHuNqlA3NL4TI1?=
 =?us-ascii?Q?hVGV4AiE3Uc8iDDTH6oIWKUZNVM0Nurx2eaPt54ChPOF/WrzC/WjVLOcDJJU?=
 =?us-ascii?Q?bwxsJREwf2sdn+ZCNxeNX1x/AeMfNBqRogCPVQpwiePh1QCwnNtsaIeGcnXQ?=
 =?us-ascii?Q?z3sfTV4CB3BFGbh2jdxtNqZXgI4HJCnMJHZzKDIIzd6Q1dyW5S/YkwPS1Bm1?=
 =?us-ascii?Q?DD5Q2BKiZ/Y5gy8gcVpoKimfwjdoZJATCuEhmdEl8Bq4Oa72LF7TA1yGE4/Q?=
 =?us-ascii?Q?D/ncDoJajKfM4dsaYqdJVyeJxLm/G2s5UJI9zEhQxEp/DUEw/I1etOdLLUA7?=
 =?us-ascii?Q?6SxoAT5GUywf/L157TWauYNYM4UUMaw2ccIVoIXWJ3rTZzPBZ/gFsyKNnsnC?=
 =?us-ascii?Q?HxKk6XJRzxlntOSHxM7bdlKL+9pqMK9fBQzCqf5YLnS7MwH9IzKaWBgjvQ1o?=
 =?us-ascii?Q?Krpa0mnoeq62Sf6bwen0BEr1xUrY8RZm8MaWZfS5migg+C0PPUXrrGY6GE/D?=
 =?us-ascii?Q?jfOyed3yZS34lVyS5/5hF9l2LvPWFnd99do/mDwpB5GC1zLQdNFyalq4Vyvt?=
 =?us-ascii?Q?+bCLh8q0Rhkm9WttwE9bG/yCV0IAxUwRC0OkI+cfe29u4XUCnazCIgshoYsO?=
 =?us-ascii?Q?EdeZJAbBN/PDEapmosjeH15pRnyzqkGWdnvJcfKUEdC23Fbs5aS2S3ROGrW1?=
 =?us-ascii?Q?H0/kuUL22b+zrHM74YNjEWbbm9ADFewpSmMHwbKeFwRTXp5AN/DZTGzgXU3r?=
 =?us-ascii?Q?mia0WEauZx96xwVtCH+u1PuM7te1Ui4sDRlxO0PtryXwdtBRDfoLdbyFIk4m?=
 =?us-ascii?Q?Ey8SrifGY1FIk/8GrdIMCNt3YA2/VgoXNtcGyY4RIXMer+EEoXhvG8n6l2bW?=
 =?us-ascii?Q?xvw/Qb2A3gf8cssbpM7zuvnwH2wH2fwv1XcuYxwIv/MIHftKhoWnJ9FOK1Ed?=
 =?us-ascii?Q?L0bIRP0ZLCW8C7ahHYF3Q9JCGDnVt/pbzPAvV75eAH/pU2rGzG7SMlI8ADHi?=
 =?us-ascii?Q?ksFEdPQ6KfaKYCEcdILP5uDC1PIkl+M3zGBEgB+p4OCaoEsSNuJw7bMnbALB?=
 =?us-ascii?Q?XbT3znbMnOpAVY+zgEnzkbuGOFlTn3RrYA49kDJvLlWUmrV765Cr6Q4TlBpF?=
 =?us-ascii?Q?EP481qsFoV8Pcp9NN/7rYMtCl62vaLKVOW2AuTyzdmjH7hNFEqR8y3GdPkh0?=
 =?us-ascii?Q?jkyzFrxqUvg6mu/cHIbIablczdZNvNs6nBCxWOiK1riF2sEK3zohQYC7XyvT?=
 =?us-ascii?Q?2M8cuaPvwuahVllAu2ohsuJN9nRoKjuWh6zm9VZf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f26fd20-b81a-4355-57d3-08dbef654047
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 16:23:55.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBpw8b9/2EJoPlCzZIroC9fTj1xZiJUgIxQ5bGmD6LmLh4c8Hzr9zNsY80oY7kuVtzwJsaLe3YnbdQw2h/M99olmNhv2P++TguIIqE271cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
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

=20
> Nack. Remove the netdev during re-init, that would solve your issue.
> Looks like some checks are needed to be added in devlink code to make sur=
e
> drivers behave properly. I'm on in.

Sure. This fix should apply to all drivers. Adding it in devlink makes more
sense. I am not a devlink expert, so I hope you or someone else can
help with it.

>=20
>=20
> >+			return -EBUSY;
> >+		}
> > 		ice_unload(pf);
> > 		return 0;
> > 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
> >--
> >2.25.1
> >
> >
