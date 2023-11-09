Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF07E6CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjKIPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKIPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:09:50 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D3F2D62;
        Thu,  9 Nov 2023 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699542588; x=1731078588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LZshtURGL2tPCGW1yzBqAsAF8t7oyR0wlvNL1OWW8HA=;
  b=I96qIPVe3xuNHuY/CVuqCafaPWS5P1SHsnkpBZq8DFFyCSk0M7dNWNjb
   X49Vsduo9KcRRLzs+2j89vmjJu7sust6ehvzt8r84Mkd+Tc1aaIaUfIP1
   I4PiaR109rlhnD9c/tdVyhZ9iqtb8SN4dftibqO710gMoFYDpWSig4x1D
   B+IT7FDiU+9H+BNt4ZVj4n1wj/8Uj5f9VjV0RKmp+CEqEV8qroheSwFdT
   y68jfpldzwgCYR5yuoj0wgWQmhd5Tv98n5OdLba8GHEt2U+U3kFWtG04m
   cC0eJ9BIJHvZLoOnQ8PHzuY2TyooYrl2JyZmeP4v+4nkNat+Z2lRPpoFZ
   w==;
X-CSE-ConnectionGUID: I3QwPWdgRjqZC8nGSnvegw==
X-CSE-MsgGUID: Um01/DEXRbG5FbjWGYCS8Q==
X-IronPort-AV: E=Sophos;i="6.03,289,1694707200"; 
   d="scan'208";a="1738518"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2023 23:09:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hztlbtv+FbcEwBFKznLOeQZ9G4eBE/kZOWrsjVaWcETQaGBPGtNXLhDtvnkD8JCuAG1TUMXoU4SbX9NIiKrew6BeU3dfv6iOfUmgSd1Rb8sWrde7cNYRVGvqFj3e8+hvLIUYUMjsl57IF52gjHh+XpLcQ0iTqt2nOwfkktWA6xivM0t5LkOZ6DOqYAoO/UZ5ekQ9LCOsJbakhTUZ2EyWYacxlVjuakX9W8wXhvrGlVHbkDRXipkSQwNXjIOQZQYsVimYPDo67A77Igog2dNjb69UQQyQ4XcavWIHAg7AcVz7hRYGDx/HK+VI4OeFlrCB4bvQTTI20MYyGwvG13NGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sWqAZrTwbKqkW0NJh0zxMPKy8amME7mOsEF2QT1GcY=;
 b=SNC6cZcPfwXCdPQSvs81GXMuNXsEAuYhBt4tVmNQxiGIN08DAxVZjq1+4CrEFDo1B2VjwcKFttZ4GTLzZPrXtO8Vt5/59O1p28xBGkiyE0GoSuaDpM9Xd5AKEO9RjkfBJqBBKfkKDDvnIY8aHdEY7imwkgiosMfibXOqdnpayc1EBPDXR/mcKaD/05EsjI1//2N6XX7JCCfSWuwo0mWayeFih8KOw3zvgFvEWTv6kDDkMH52EvpQMTk5IbgGJ2s6SmucO54vs5IoHE3YCP+ww7XUwptWcU33inQcSpfN5Qxy9KivW4p+twguqVb9uDTUu/KV1eVnGF69Pm6Pl4ZOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sWqAZrTwbKqkW0NJh0zxMPKy8amME7mOsEF2QT1GcY=;
 b=cSRo4zBMyj/E3SMxUF9CIcucZ10yRLyD19PlCR+6Ot/Ww1sejSwfnIgw9JRryy3LzjClXz1AXoWbO6mvASaGqdg4kTTCLSZkUA3iiy/mSuaotH6xJY4aZeJ/iBXBeF+bKdeurxg9WX3VWIqP8y6y9eb9+wpqrEFtU3z9rxRrnVs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB7058.namprd04.prod.outlook.com (2603:10b6:a03:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 15:09:44 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 15:09:44 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Subject: RE: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
Thread-Topic: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
Thread-Index: AQHaEwu1pvy9NnTwMUiQzW66O5ryQLByFq/A
Date:   Thu, 9 Nov 2023 15:09:44 +0000
Message-ID: <DM6PR04MB6575E82B66D090CDD495BF69FCAFA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
 <20231109125217.185462-2-beanhuo@iokpp.de>
In-Reply-To: <20231109125217.185462-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB7058:EE_
x-ms-office365-filtering-correlation-id: 36826024-759b-4af2-d029-08dbe135e7fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0Us42zzVgeU3zKBPXoeOrxFkUXHiaAhzBJgQ6aeLvD/1kQdSN80L4Aq0Zr54tlEBYSd8L5pJ36i7cNBE0Z+VFhY7MqGbiUE0vYzEhhcOSPOJJoFo/pr9ExZOxGEWNpEo+Qf+k8H+Vk//vHOYGBag5ooTOw/C5yb3WjwUV95Wz45M09U3f3PR4K7xSLoQq4ZPSRbw2ciFYtz0DHRkab96Q393/DxWb2Ig5CUmZigfkzk6f6jNTdJKk2llPf1QPQlFn0SV8vkA0nMYLkxLP4gODZNtJkLJnfk/uWX2hEO6/u2eItXAM8ebi1+83MIzMuqEkEWhuq+MHuCY6VnWSg/kT0V2y9G2MsdzCkohh2X1xPi5zZ/j0h7RqQQ33QohXV9Vv2ZZi3mXohPeyjbNG8x5B0QgD2fIx8i5crHqgbAaVVylOldoDvEcPO+4jf4njY2ixlfY0oA9+Tb8VRXwEgM8zVZNpr5rUMGrJ1Ngi3SsFCmvbzhr/NYj9MxwJTeDTqg/Jl9zLdzsTefk7jHLSmEeOBgOruI4GvZrr//Lcd/WugLuUa3LUOdwQQLCXPQChBCy3qvHjdcxL05t4QuUy18IeE11HOe95pPGx4sq6zg8y82Xbs1C326f+ojInxJI2guZt1WEyi6xCcT6GqoRO47ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(52536014)(55016003)(7696005)(26005)(9686003)(6506007)(41300700001)(82960400001)(38100700002)(33656002)(83380400001)(122000001)(86362001)(8676002)(7416002)(5660300002)(2906002)(4326008)(8936002)(71200400001)(38070700009)(66446008)(921008)(54906003)(66946007)(110136005)(66476007)(76116006)(66556008)(316002)(64756008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GqnzmqvsGMDjkTbGdQ+AqDU7RHEFoKZ/Zj7uWVwQXTrHXSw6zldKUTo2oXGU?=
 =?us-ascii?Q?0KmfuofxhGdRw4/FDTAas2Kbb7hIxQ32mQFMoxCoVdReBLjfowN4WsYGoFmD?=
 =?us-ascii?Q?eojR5Z95oHIYZqZWo8ax08Ii1dziIJU6Rt4LK680FG8O4COFXt+Tgk+fK+Fe?=
 =?us-ascii?Q?4o+IwLK5l0v2+Gk6sA4Q0SpFUpTLt/09PFhkn9TmfUq55eXFUwSlpxESudnf?=
 =?us-ascii?Q?6a21hB4xLDzt1ifM0WxgXMfysHqcu7fqIRgGMeorpN0BEvHFry1Pm5O4yNnC?=
 =?us-ascii?Q?vy9Uyo+T8/ZW+k644zoQvb9TBjrB/wasTO/KgX1Ytc4cndaVAf7mFovVSo3U?=
 =?us-ascii?Q?4Ic2UEpqZNIYKrfq/tqZO5CHCDeomqUiYVjNJey3MWFovQW1qIopmrp0bByy?=
 =?us-ascii?Q?xw12sDOKmObL6ScJMohLWaElqgd+7YwTiBjLvutCISAOo8bxZ1ZJr2v7zomP?=
 =?us-ascii?Q?Ju/4ulUQ00FGE2YGdqjDO/jumTCgRkS4HvWy228DggG6nrU7/oseci6/yG6y?=
 =?us-ascii?Q?S6d511tCzipe7s3Ve5iZNsDVzs2sHpmBXu/z/s5NEIRexZISJLOCQ6Ak8f7i?=
 =?us-ascii?Q?rtdrr/L4i196L4mr6nAJnCOUHBnLhaknGKtj2p+8ffd93KWbPoqnnCMUyBKP?=
 =?us-ascii?Q?3Ms0W8svEA5HQm4oojMgx/DW2dcM5CyKpsaZJku4ocOMDrBksqlvZGaqS+db?=
 =?us-ascii?Q?maFwd22SEInyYi2m5r35HoLdmR/eZTH5JUjsQSt5KT2dUbV7wl1NznOVj0ds?=
 =?us-ascii?Q?LzKIuUGtP2BHD+YafiwoY/q/Qlr/E0l4hP2bnxHQJtnJNVJdU3O7Htrmzfy1?=
 =?us-ascii?Q?badIu5M4LVlYz76cdyaKmSyXEMcx9GN7oHRWIEjWTHLE8h8BN+ozWOLrGPSf?=
 =?us-ascii?Q?XrmfzWIkmaGtr9py1sUqJKEi9h/l6XHpu1OYOgyLGb+ieEogF6+uMZL600Id?=
 =?us-ascii?Q?sw0vyRid9yv5dnHMLrRzZTHAlBHHA8zL5JEDSTfu+y8F5X3SEX6Wi1JKOT7n?=
 =?us-ascii?Q?vYuE5KxIwYkpPb2f8VLP6SmrSCdU6p7ZMYESk78YZKl5Ogw97wOMKjvXvADr?=
 =?us-ascii?Q?oNj4cJM0r4CB//IljlrTmdwrs5Hvr4WZ5DPmd7gCvD/1IVLGxxB1rTD0z179?=
 =?us-ascii?Q?ZNekkfcFpf53KV0W9DxGGVrDVByXbDDrO7K38a82J0hMxMXuvnJReaKtUXbe?=
 =?us-ascii?Q?Vp5hCHgyHGYK80SX2vsmQ5nmuGbaeIyAFkX7qi8yIxNwENQn4F9bwg8XybAP?=
 =?us-ascii?Q?W97VtlhopeD2YBm2uscLamWLsytJsaK2FXpxEEsES9fb/QuQZOhUxiph4frl?=
 =?us-ascii?Q?yJbY25Fd0V/7i9EGDWuPJsWeIt0v4Im1J4aN7uH0UUBwYl4zb4RJWCXLcz0C?=
 =?us-ascii?Q?JaZU1pPf++WzPWylPhlVgaOorc7y0Moh8yfq7kZQtu96q29JVIPhCDqpADmq?=
 =?us-ascii?Q?EOCVGEyxvxz+2wtdDEkRaOJK+ZYMcBAu4+97bexUQKvIfm88KBlOM+8555cl?=
 =?us-ascii?Q?LnonYm2/1v2aDrPZTayaxFA/qxzQ+iwsr+1T8y+CaIxuh8kRain5XMfH6VZv?=
 =?us-ascii?Q?a3CYXyckVJgJk86UfpNhR0ow+RekWTnMHf0usQeq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RaxM3wsK+udC9D3Ne3oBN+rVN7VsbOFeIguPMojY9YVPX+Ivggy6Je5WFlbL?=
 =?us-ascii?Q?pM39+DymW77eDvwias1ei4i+eH2PtohbxdEsUQ++0ogIyYeVbmUoa8pFsJfW?=
 =?us-ascii?Q?fZTGoEQ25aLrK4Fq4k2ZbUOH4hODVULGHSers5fHoh/qOh1mtF1HCIpQ2+4+?=
 =?us-ascii?Q?VT3ii3sY009gF35pGb/kQtrakPHsAQBUYpku+kHG7D5lG+q90FznR4W/EN0c?=
 =?us-ascii?Q?ll6H4IxfDKUUhMjDI9zvy3roJ0EEdN4/keSQTTCvdMaQrN1ZvUcsFr2PRHaT?=
 =?us-ascii?Q?0TKB4s+OC/Yk/hdmcWV4BPy9so3LeBTA9pX7vD99Gkg1HfZcDerdhroqztW7?=
 =?us-ascii?Q?NTQnLtfv+QJ+6WrWjMrKvgR8cvLB/FqiPYyv3J00vYKpJ82i7eURi0WwsG3z?=
 =?us-ascii?Q?z5ah53RpYUtgGEwJYZ9q0NeEkxsUl8LnT3mVkCI54YpvblLBjP+jkfoBcI2l?=
 =?us-ascii?Q?3E/F+PdtYaBnHQbooSkT3Ulf89g4fQd1414jmCOpZMPtSSBof1J+RsU7hqSa?=
 =?us-ascii?Q?kGi6zd+Tbd2gnxQz5Uuz5km/FoXQJKWeopZA2jK33TtuJafkxSASl74VfnZF?=
 =?us-ascii?Q?Thm1XFUn/JPIhPrKK4ql+sk00Onuf16ayuSRHmh0uHFJ7tmlZ9jxRTDA581x?=
 =?us-ascii?Q?dxhIqBuKP/shfc2/GwUiGbrlkrq29Jo8hTPnrJmyeHgUOEuVdKbMB6yn94Vu?=
 =?us-ascii?Q?zb/ufPP7V6wFDrrkuJ/dLIw4LXDuWnsIYqfo4axNo6xPFf6br3iGoSbu9XO0?=
 =?us-ascii?Q?Q0yOC0TFLnYfEzXC2iJqctyuG1uqHoeJDOPMv5i9O2BSOlZc7QUacDf0ARlW?=
 =?us-ascii?Q?yMEhnn24dFpt6wNrVF22Gv+leZOipWdo+PgX99nsZGHBZF8xQidey+M/Pvjy?=
 =?us-ascii?Q?O4AjLmmVMXoiNzZXYL7CEDpUpqFXp0mQ39MIKFL/AWeivqB57QBF3zEfbwYm?=
 =?us-ascii?Q?5acuSkJTGeyffoSb0mKN4+V9v0vgWwFn8/1wTIJONMAS4P1WBI02pAhDkhsB?=
 =?us-ascii?Q?WaLxHOqZVkHwQ5b95o5qWWzuxvi7oAEAAnmKavt1xXJjzTs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36826024-759b-4af2-d029-08dbe135e7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 15:09:44.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmVJfVFuLVabwQ+zUjzQvy/Q9uNEwOEiRjCsiPickyrYdqozUaAWvzvOljwpAx7ckYfIfu3FNxeXji3vgTDwpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> The objective of this patch is to incorporate Real Time Clock (RTC) suppo=
rt in
> Universal Flash Storage (UFS) device. This enhancement is crucial for the
> internal maintenance operations of the UFS device. The patch enables the
> device to handle both absolute and relative time information. Furthermore=
, it
> includes periodic task to update the RTC in accordance with the UFS
> specification, ensuring the accuracy of RTC information for the device's
> internal processes.
Maybe add some reference to qTimestamp and explain why RTC in seconds is st=
ill needed,
when RTC in nanoseconds is already implemented?

Thanks,
Avri

>=20
> Signed-off-by: Mike Bi <mikebi@micron.com>
> Signed-off-by: Luca Porzio <lporzio@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/ufs/core/ufshcd.c | 92
> +++++++++++++++++++++++++++++++++++++++
>  include/ufs/ufs.h         | 20 +++++++++
>  include/ufs/ufshcd.h      |  2 +
>  3 files changed, 114 insertions(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 68d7da02944f..f0e3dd3dd280 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -99,6 +99,9 @@
>  /* Polling time to wait for fDeviceInit */  #define
> FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>=20
> +/* Default RTC update every 10 seconds */ #define
> +UFS_RTC_UPDATE_EVERY_MS  10*1000
> +
>  /* UFSHC 4.0 compliant HC support this mode. */  static bool
> use_mcq_mode =3D true;
>=20
> @@ -677,6 +680,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
>                         hba->dev_info.wb_enabled =3D false;
>                         hba->dev_info.wb_buf_flush_enabled =3D false;
>                 }
> +               if (hba->dev_info.rtc_type =3D=3D UFS_RTC_RELATIVE)
> +                       hba->dev_info.rtc_time_baseline =3D 0;
>         }
>         if (err !=3D -EOPNOTSUPP)
>                 ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err); @@ -
> 8185,6 +8190,85 @@ static void ufs_fixup_device_setup(struct ufs_hba
> *hba)
>         ufshcd_vops_fixup_dev_quirks(hba);
>  }
>=20
> +static int ufshcd_update_rtc(struct ufs_hba *hba) {
> +       int err =3D 0;
> +       u32 val;
> +       struct timespec64 ts64;
> +
> +       ktime_get_real_ts64(&ts64);
> +       val =3D ts64.tv_sec - hba->dev_info.rtc_time_baseline;
> +
> +       ufshcd_rpm_get_sync(hba);
> +       err =3D ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> QUERY_ATTR_IDN_SECONDS_PASSED,
> +                                       0, 0, &val);
> +       ufshcd_rpm_put_sync(hba);
> +
> +       if (err)
> +               dev_err(hba->dev, "%s: failed to send rtc %d\n",  __func_=
_, err);
> +       else if (hba->dev_info.rtc_type =3D=3D UFS_RTC_RELATIVE)
> +               hba->dev_info.rtc_time_baseline =3D ts64.tv_sec;
> +
> +       return err;
> +}
> +
> +static void ufshcd_rtc_work(struct work_struct *work) {
> +       unsigned long flags;
> +       struct ufs_hba *hba;
> +
> +       hba =3D container_of(to_delayed_work(work), struct ufs_hba,
> + ufs_rtc_delayed_work);
> +
> +       spin_lock_irqsave(hba->host->host_lock, flags);
> +       if (hba->clk_gating.active_reqs || hba->ufshcd_state !=3D
> UFSHCD_STATE_OPERATIONAL ||
> +               hba->outstanding_reqs || hba->outstanding_tasks || hba-
> >active_uic_cmd ||
> +               hba->uic_async_done) {
> +               /*
> +                * RTC updates should not interfere with normal IO reques=
ts; we
> should only update
> +                * the RTC when there are no ongoing requestsUFS is not i=
dle
> +                */
> +               spin_unlock_irqrestore(hba->host->host_lock, flags);
> +               goto out;
> +       }
> +       spin_unlock_irqrestore(hba->host->host_lock, flags);
> +
> +       ufshcd_update_rtc(hba);
> +out:
> +       if (ufshcd_is_ufs_dev_active(hba))
> +               schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +
> msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
> +       return;
> +}
> +
> +static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf) {
> +       struct ufs_dev_info *dev_info =3D &hba->dev_info;
> +       u16 periodic_rtc_update =3D
> +get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
> +
> +       if (periodic_rtc_update & BIT(9)) {
> +               dev_info->rtc_type =3D UFS_RTC_ABSOLUTE;
> +               /*
> +                * The concept of measuring time in Linux as the number o=
f seconds
> elapsed since
> +                * 00:00:00 UTC on January 1, 1970, and UFS ABS RTC is el=
apsed
> from January 1st
> +                * 2010 00:00, here we need to adjust ABS baseline.
> +                */
> +               dev_info->rtc_time_baseline =3D mktime64(2010, 1, 1, 0, 0=
, 0) -
> +                                                               mktime64(=
1970, 1, 1, 0, 0, 0);
> +       } else {
> +               dev_info->rtc_type =3D UFS_RTC_RELATIVE;
> +               dev_info->rtc_time_baseline =3D 0;
> +       }
> +
> +       /*
> +        * We ignore TIME_PERIOD defined in wPeriodicRTCUpdate because
> Spec does not clearly
> +        * define how to calculate the specific update period for each ti=
me unit.
> Here we simply
> +        * set the update period to 1 minute by default.
> +        */
> +       hba->dev_info.rtc_update_period =3D UFS_RTC_UPDATE_EVERY_MS;
> +
> +       INIT_DELAYED_WORK(&hba->ufs_rtc_delayed_work,
> ufshcd_rtc_work);
> +}
> +
>  static int ufs_get_device_desc(struct ufs_hba *hba)  {
>         int err;
> @@ -8237,6 +8321,8 @@ static int ufs_get_device_desc(struct ufs_hba
> *hba)
>=20
>         ufshcd_temp_notif_probe(hba, desc_buf);
>=20
> +       ufs_init_rtc(hba, desc_buf);
> +
>         if (hba->ext_iid_sup)
>                 ufshcd_ext_iid_probe(hba, desc_buf);
>=20
> @@ -8790,6 +8876,8 @@ static int ufshcd_device_init(struct ufs_hba *hba,
> bool init_dev_params)
>         ufshcd_force_reset_auto_bkops(hba);
>=20
>         ufshcd_set_timestamp_attr(hba);
> +       schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +
> + msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
>=20
>         /* Gear up to HS gear if supported */
>         if (hba->max_pwr_info.is_valid) { @@ -9746,6 +9834,8 @@ static in=
t
> __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>         ret =3D ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
>         if (ret)
>                 goto set_link_active;
> +
> +       cancel_delayed_work(&hba->ufs_rtc_delayed_work);
>         goto out;
>=20
>  set_link_active:
> @@ -9840,6 +9930,8 @@ static int __ufshcd_wl_resume(struct ufs_hba
> *hba, enum ufs_pm_op pm_op)
>                 if (ret)
>                         goto set_old_link_state;
>                 ufshcd_set_timestamp_attr(hba);
> +               schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +
> + msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
>         }
>=20
>         if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> e77ab1786856..18b39c6b3a97 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -14,6 +14,7 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>  #include <uapi/scsi/scsi_bsg_ufs.h>
> +#include <linux/rtc.h>
>=20
>  /*
>   * Using static_assert() is not allowed in UAPI header files. Hence the =
check
> @@ -551,6 +552,20 @@ struct ufs_vreg_info {
>         struct ufs_vreg *vdd_hba;
>  };
>=20
> +enum ufs_rtc_time {
> +       UFS_RTC_RELATIVE,
> +       UFS_RTC_ABSOLUTE
> +};
> +
> +enum ufs_rtc_time_unit {
> +       UFS_RTC_TIME_UNIT_UNDEFINE      =3D 0x0,
> +       UFS_RTC_TIME_UNIT_MONTHS        =3D 0x1,
> +       UFS_RTC_TIME_UNIT_WEEKS         =3D 0x2,
> +       UFS_RTC_TIME_UNIT_DAYS          =3D 0x3,
> +       UFS_RTC_TIME_UNIT_HOURS         =3D 0x4,
> +       UFS_RTC_TIME_UNIT_MINUTES       =3D 0x5
> +};
> +
>  struct ufs_dev_info {
>         bool    f_power_on_wp_en;
>         /* Keeps information if any of the LU is power on write protected=
 */
> @@ -578,6 +593,11 @@ struct ufs_dev_info {
>=20
>         /* UFS EXT_IID Enable */
>         bool    b_ext_iid_en;
> +
> +       /* UFS RTC */
> +       enum ufs_rtc_time rtc_type;
> +       time64_t rtc_time_baseline;
> +       u32 rtc_update_period;
>  };
>=20
>  /*
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
> 7f0b2c5599cd..11da11d6870c 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1071,6 +1071,8 @@ struct ufs_hba {
>         struct ufs_hw_queue *uhq;
>         struct ufs_hw_queue *dev_cmd_queue;
>         struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> +
> +       struct delayed_work ufs_rtc_delayed_work;
>  };
>=20
>  /**
> --
> 2.34.1

