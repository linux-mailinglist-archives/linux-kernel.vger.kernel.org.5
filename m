Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AE7E6CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjKIPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjKIPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:10:58 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15135AC;
        Thu,  9 Nov 2023 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699542655; x=1731078655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yXqmrlqpdVkJAcJCMDYxXTPl03/oSvegATmXzCvqbuk=;
  b=qX59q8LfRN5ed/jN+S8Pw96EUSaATHrHDNpa1vVBKc+iHPF+Hlsr4PnV
   a7FBtnE5OYUZrtkSha5V67g6DOFNz9iDnfS9oYn0gr7ilKfWpD+ouO+Ah
   yqFEFVXtUxw6fE1LVWo53DTlrYEYEwWTIEHaT79rs2ZMNMQIP7rhCrWss
   o8yuvpsczQ8GCHyDAfXbZf29B+4an7tSZJ5gZuy9oCNdw9b5dLLEF8Msl
   /F0e+RquR6hfaivsUl15K275fBR1zz5M6zK3cbjxjU4dManMmHwYdGO3N
   zFGlYolgjZoibGa7X0X7WGDzT3wNTywFby/ODJ3FB1WZCaXsHr2BUHxSW
   w==;
X-CSE-ConnectionGUID: pYGeFLexRsud6PtmPH39bA==
X-CSE-MsgGUID: hLEvUvGMRMinSfBjNQqugw==
X-IronPort-AV: E=Sophos;i="6.03,289,1694707200"; 
   d="scan'208";a="1843131"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2023 23:10:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSrWbAOJuQ/hniRFwQSBrjs2+OQVXfZ8mySydm4+LnvHjjYurVjkx+IBub6A+HqFEbwex6yJqqJ/L/Sl41SbWVJoOLVFJSQQoAsjaNg+KVfFtMKD9VNHm9F91FWSydV0L7OUa4QbStm7uHc/U/6rrBhxIgX1Q1tQ0SudQR0qQODN1HwQNg4d9DUiYRwiaLkEGdIczjh/CbsSTJBMqSR71xbMMhbFL3licto1k2Ct7+btMejuzylAsvfS6IKWOVBj0sJ1y6vZS2SOZ9fkeOsK5oLHu2rpV7dIjqFZnX6Eb2ath39jE7VAYF4+mch4xq5Erqo2ZzQ8ebJ6A+1luYBf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0idEQVQsVCA6K+IpfPH3hSen7IdX4268c64tdgksOuo=;
 b=lyikfAMuTix9s+yfeAYA4tjTCBBaHwzFXdX6D9ESZkZxtxYTPZ1H6YYotxPzzgnxVPBRbbOyDZXQ6bE6R5nzLRMg767yHf191xSLMXwtyzeK0UMVUPxVj0h1UWPr7fgy65/ffcnG/Tq8HwZX98uDbplFEAlJyZlmExpfJQ6eA6Ju3Qnu+zvR77f7fNR0juOEzkBEh4JorYtKgR1FvV4NLoFFoj/6cKR0hx1vl/RStF+jI7mkVMf+6S7mwJVNVwTwJ+6iPL8VRswLQXLhH0ASTHjYoYAkD3v6aFYuWmY1p3ff8prX4WCqZ1P7s79DE6gZno+a27G+4lRQfx9sILRB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0idEQVQsVCA6K+IpfPH3hSen7IdX4268c64tdgksOuo=;
 b=DiM1zlJe40vwDL5vKmj8dzyA0D9bxQ6pgivQ2P1H8eaJavFjLBqvwPJ1ruPFC/I3BZVL5r+UL8d1TULfIhq0Au5uCz+IaInhmW06fR6VQHCD92x+t9PgvW9tPp4103kUa/xQ67MBhPhYF8LG8k72iU8RYEMLzkl1/GayVVxgXvQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB8346.namprd04.prod.outlook.com (2603:10b6:303:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 15:10:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 15:10:51 +0000
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
Subject: RE: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC update
Thread-Topic: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC
 update
Thread-Index: AQHaEwu4Mh5K15HH00ihOyQoiVZi4rByF6IA
Date:   Thu, 9 Nov 2023 15:10:51 +0000
Message-ID: <DM6PR04MB6575A20FDBB306B8416C86C5FCAFA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
 <20231109125217.185462-3-beanhuo@iokpp.de>
In-Reply-To: <20231109125217.185462-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB8346:EE_
x-ms-office365-filtering-correlation-id: 1f8654af-5c90-47a3-6be8-08dbe1360ffd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q83r8MRWofAg+6CBi61f38j7j7NJ+I5PbstLv6IBIoowtdvusEquttkZYiNkDR7e90AcwRTbUWvWpkAR4gBu8s1mBlz4702KyZ02USgJa4/zHTKe6wGsSEj5yXTiyrizdw++Bt061siJH9Z1J9868TX1Yq6ktEGLsfu+dmCn529C+7HO9n6/cDQxJYm2ifAkf8tcc5FfmojqLYMDi8MB0O4ASpzKt2O4qRjW+D6gyariZYnn8eBY11YwV/3AX0mQO4kEVzkjZlFPr2OixtP3yQEZjH2OS3Sws05MxF/Utin1k+7zL0FtwdpWigKc9tip0MOyPoU2dhtQCVSIj0KhKzvxlqQUjb+e/3qMl+1TnY7nDoTOB77qlqk2uAM9eBQQupilvcXfTTMdt8/Mhhax3cLeygaZWDb8JEchSN58BEOirpqWdCRzcUGCAh4udEn8DFcGVCuwMDNp2IxtoekPoB2kp4L6rEtV5xVL1MJmyZ8F93H4qiw2dY3852TW3mH1wMUZQGUyoZlA7JJMd8wVw2RUviB6L7A/pGEXOBrzalg8ebHzjyAxIXbNk9RkboYPjGt3T4yK1WtGbThAADy+6I0SQK3/FglvzYS2gOaHkMqPOnxyNf+02Xw8sof2et/dMtYM6S0NS6X/40yxk5IvLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(71200400001)(9686003)(478600001)(5660300002)(7416002)(86362001)(7696005)(6506007)(55016003)(316002)(76116006)(66476007)(110136005)(66446008)(66946007)(41300700001)(54906003)(64756008)(33656002)(66556008)(8676002)(122000001)(38100700002)(82960400001)(4326008)(921008)(8936002)(52536014)(15650500001)(2906002)(38070700009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qK+Sw26XDGEv/rcHWL+HNjHlFAuyLo6IsBatApe/NxADLALYrjL1t28SdXhw?=
 =?us-ascii?Q?O/dByuVoDYGiuvqnriB0ULVEKfIpiSiFv6Es24RVuA6OFdrhNAW5EoelntgU?=
 =?us-ascii?Q?i1iG9qhUkNebT3wPQWWOgDUIXodsfysIjhbx4wBEANlUE+ZmlE8LqkvE1gF7?=
 =?us-ascii?Q?wLGAxGvdBaVSJkQqTHguniGosjrWTZ5shu5qL35e16iqVctJG8q0XUdWXIMx?=
 =?us-ascii?Q?ON6VxbHfRYEqJn6VP0oBaNtUNwAAIadmUqcnDySCEWlOnB18EHYpg11YiLkm?=
 =?us-ascii?Q?l06y016OEseuf4Gn2LdEbb4IwsWxQXFqFpp9dEtJZbyy+e/tPosBFCylXci9?=
 =?us-ascii?Q?zddlvyeUgZKRszFnwXot9mdPqc/gFKUyMYvObwTWBGLNiOOVdrDYtjY8utrG?=
 =?us-ascii?Q?SQrvyGmMWiU+MTzB52XraG4rj7i6Xa5n/CspK8g0LAWr15EzvyIFiqslGMmG?=
 =?us-ascii?Q?AW38a5bsAlksYzrtoRJ40ppKx4PgpXIhyFvDqvPwPGo2sraa5BKL25Jta6az?=
 =?us-ascii?Q?tDRY89qkp85sYn9Plb2bLPi2gwmpsPwuNDcTWeN6h+CrHR4pQ3htLUeitKml?=
 =?us-ascii?Q?NJ1BEZK0aMvalZBqlmCPgEe1YwEbtZ6xuMHzGLrTrhvcwK+lGPR2TxCkpnxI?=
 =?us-ascii?Q?LsBYJd8KbRNCr1738ZsYUVMA/0bPU75xeO/etFWAs5gL0cvEaT3VcuuaLnHq?=
 =?us-ascii?Q?2qMCGiMVnUpzOqoJDUqYHmKgn05mxsgnjBuUHfJQrtu2t51Hqs6N2JyMHqLQ?=
 =?us-ascii?Q?c9IEsTjJRYyb1Ch2JNo1HHqE/i63Tgf9ISh98pqNDpFa5BeXfW2zCE3d6mWQ?=
 =?us-ascii?Q?lorquQbbgIQsXnbnT8vA3tGFnttjRdV5HwUCi3mfMB3k/GuUKU4n30C2O7gi?=
 =?us-ascii?Q?NOgEXCCY2LzIBhrtxd0lN5whh5P2xdhHPKMaXIu8ofgLaoNlao/3a752/f9B?=
 =?us-ascii?Q?TGK7Esxukkao6y3fcTOKR6iIM13bS1TmQA0n2qpQB/XTUw561seMH4JNwgBm?=
 =?us-ascii?Q?YCsngfRpaD38DC1vhB4VZsf/LwJ8Pwio2TnBj8GG9wUHY6DCej/F/yCP1wl/?=
 =?us-ascii?Q?2E04cV4P0adFWGqHzPKNTiEfdvlgPru+qY+jcbo5/GaxpjvK3T98BAJ6mZr2?=
 =?us-ascii?Q?cSeQB5rODzwSUtsj3nBPMsJLMs19v8o8jDRSNKcLp3A+u+7Tzlax5aZMsHOd?=
 =?us-ascii?Q?69SUVsFBpufBxV9X9zoQ60sZPzjT2Gfi/cfZwV42dyTh1gH3xfx406dGSVvr?=
 =?us-ascii?Q?aoHC75QFUzGBKF35TkKMgm5ZzhFcphTx11jiZ92ACoPEEzI7jXAw1eGQ9Pif?=
 =?us-ascii?Q?902ZOnrLyiKbXdzzaeb6NlITVP69ekYcSG1POOi2Olh1CUsubU1yYjFeZ2M8?=
 =?us-ascii?Q?4WtQuKR1VAz1a/MaJbcN4OML7JP4m6gwj7Nx1ykh0sjIdXVwNTGZkDXr3QGh?=
 =?us-ascii?Q?lVjOuElIGLJBG32EDyPJ4WhWVM77uGc2IpQgp8Yd80445rG4eGocyO89IchQ?=
 =?us-ascii?Q?24BXbt8x1O+vJyE9iBEA6FwwpdBJlVbN1oErSHNUCtXd4380ydgyWWOOiKYs?=
 =?us-ascii?Q?1SVEO7VCxvB05Zss9+44Bb+kYFux9bISjXUbHPMa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5dcZWaVS/orJdLMt+RjUrur+P72BqyzP4ebFJJvglXYrMs/avqhqVyLYInvB?=
 =?us-ascii?Q?WnFbvTxMEvWxhXscwIgLutZQf19u0+roDVe9ru7oPig2gvjCYVY8FUU2UKq3?=
 =?us-ascii?Q?CfiU7DNNlMt+Ut2sTOayFfLVIZ3+uyXINkK8QN+UrHn/4s3mwWr6NC0sq3gT?=
 =?us-ascii?Q?fz5AXUT6tPrOoP3QVKjjjrwVmlf++JZxS4ZWaEu4ag4FtMsRuQklzKpkEaIJ?=
 =?us-ascii?Q?MK1ridkEf+5SOZKdnurzraMhH36xhfFH3LtszDJMiUAlnSF/MGkVAHPH8tuW?=
 =?us-ascii?Q?g0CgbCdCup41tF9OCRjhZ1bdNG1KMDRtKsatUYu87LTQKO0ouDWLM5INwoWC?=
 =?us-ascii?Q?2RUjPlUQaCQQAGolts5TicU618TzsSC4Z5ElAQBKATlPcM52NjtKl4wrZyO0?=
 =?us-ascii?Q?qsvheQTnNwwy6QVkonFPNS0CqLs4kg6sPjlASrmVxWIy/0C0IhkyeDcRqC1p?=
 =?us-ascii?Q?rWAomndDHVVExHzjuzzj+8UbW9BfEtXblF/o5hcFrhTBQfwOwwjZmnNWfaPH?=
 =?us-ascii?Q?kSbjGqCmca1aXaKOnkwGdtNrZTpK1s9qAtLpJ5kFYhf+PTbIUz0cVLOoP/GS?=
 =?us-ascii?Q?W8FKLZzEB0NmPTby0IDIBaBsLoPL5XtFN5j26/HQkqJyoZUf6pqFfc+kWayz?=
 =?us-ascii?Q?YUDAJvi45KmgdGhKIEsnQY9YZYjW8feVRYBM7oXxvc/DUfwiANHH9AYh3aa9?=
 =?us-ascii?Q?6l2nNmq6LaGKR/SoUteJ+DxGZRgpRhFBsKx07h9Ec4RrpqExRRsD8kr0xIU0?=
 =?us-ascii?Q?5wSs/BmMVo4vvVacRnN+PyoaEcB3F2Pu3YW04LiAiqMDv5jM3Xx0J556vsxQ?=
 =?us-ascii?Q?wRdnm8jJTglSXz9I4ZaEZ4lxIfv8xgN+bTsLX/2v3qkfPHhjOe4cZyRuTpbA?=
 =?us-ascii?Q?3vjqfIDkRGUm5xJwCE24IWcXYJDIS4dUOxgUgXBlbdbPAaAXh1yvKATjz9eP?=
 =?us-ascii?Q?3i30MFc/obkoGyXNQIiVGc7x7bh0dNkF72Mp+HFvGNYo7kpQBZziD1ROOGOb?=
 =?us-ascii?Q?t/57AfpoXzXvXeTr7WWFW2JLkFyP4JFod43oHVDdo4zG1pY=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8654af-5c90-47a3-6be8-08dbe1360ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 15:10:51.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVl/Bi8g2jzwbpVx8z2bUJlx6YRQXpKJ7TiDGeaB8M1+KVGomfqnpci6hKyCOi2DhPcF4X2VWmtkd29qVE+Pbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8346
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> This patch introduces a sysfs node named 'rtc_update_ms' within the kerne=
l,
> enabling users to adjust the RTC periodic update frequency to suit the
> specific requirements of the system and UFS. Also, this patch allows the =
user
> to disable periodic update RTC  in the UFS idle time.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Forgot to add doc?

Thanks,
Avri

> ---
>  drivers/ufs/core/ufs-sysfs.c | 31 +++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd.c    |  4 ++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c =
index
> c95906443d5f..d42846316a86 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -255,6 +255,35 @@ static ssize_t wb_on_store(struct device *dev,
> struct device_attribute *attr,
>         return res < 0 ? res : count;
>  }
>=20
> +static ssize_t rtc_update_ms_show(struct device *dev, struct
> device_attribute *attr,
> +                         char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%d\n", hba->dev_info.rtc_update_period);
> +}
> +
> +static ssize_t rtc_update_ms_store(struct device *dev, struct
> device_attribute *attr,
> +                          const char *buf, size_t count) {
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +       unsigned int ms;
> +       bool resume_period_update;
> +
> +       if (kstrtouint(buf, 0, &ms))
> +               return -EINVAL;
> +
> +       if (!hba->dev_info.rtc_update_period && ms > 0)
> +               resume_period_update =3D  true;
> +       /* Minimum and maximum update frequency should be synchronized
> with all UFS vendors */
> +       hba->dev_info.rtc_update_period =3D ms;
> +
> +       if (resume_period_update)
> +               schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +                                               msecs_to_jiffies(hba-
> >dev_info.rtc_update_period));
> +       return count;
> +}
> +
>  static ssize_t enable_wb_buf_flush_show(struct device *dev,
>                                     struct device_attribute *attr,
>                                     char *buf) @@ -339,6 +368,7 @@ static
> DEVICE_ATTR_RW(auto_hibern8);  static DEVICE_ATTR_RW(wb_on);  static
> DEVICE_ATTR_RW(enable_wb_buf_flush);
>  static DEVICE_ATTR_RW(wb_flush_threshold);
> +static DEVICE_ATTR_RW(rtc_update_ms);
>=20
>  static struct attribute *ufs_sysfs_ufshcd_attrs[] =3D {
>         &dev_attr_rpm_lvl.attr,
> @@ -351,6 +381,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] =3D=
 {
>         &dev_attr_wb_on.attr,
>         &dev_attr_enable_wb_buf_flush.attr,
>         &dev_attr_wb_flush_threshold.attr,
> +       &dev_attr_rtc_update_ms.attr,
>         NULL
>  };
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> f0e3dd3dd280..ae9b60619fd3 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8234,9 +8234,9 @@ static void ufshcd_rtc_work(struct work_struct
> *work)
>=20
>         ufshcd_update_rtc(hba);
>  out:
> -       if (ufshcd_is_ufs_dev_active(hba))
> +       if (ufshcd_is_ufs_dev_active(hba) &&
> + hba->dev_info.rtc_update_period)
>                 schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> -
> msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
> +
> + msecs_to_jiffies(hba->dev_info.rtc_update_period));
>         return;
>  }
>=20
> --
> 2.34.1

