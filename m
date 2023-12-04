Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F164803241
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjLDMNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjLDMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:13:50 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AFFE;
        Mon,  4 Dec 2023 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701692034; x=1733228034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4TdFGsujIsgqA6CAu4v7zvvkWk2mLJTyW5vtDic+DF4=;
  b=rygKk+P1KAQPvmgkk+DJlBUNJ1t3yY3GZOU3xc8m/YEbgGBJFJbaEZ/6
   2nV5oc0VUI+Eo4qxyYAn7gqb04WHI441/g1qplM4yjsSIhH0i5z+nW5cA
   XMhQJ3xqoDeSAFlViGqCTXJCAknuSLriyvlQDfZ8NZbjxw2Q8ktXh9Fem
   ho5CKTeXZkw1WZcpTsN4l8iN333HHVrK4A1xxUVe6oM4NprH/bQqCHk27
   RMEQ0uuhwRENByzqGCbIccSkOFxsn9nCxzZEoAOAlkYbziFwlbfFNDlSf
   h9HPj36mcurt4Ef9DJl5KFoJ2gkvh6YtdYcqyQa2+eDOUKkJzmy/HG4mN
   Q==;
X-CSE-ConnectionGUID: u3ZcaN6NTTeii0DkBz7IZA==
X-CSE-MsgGUID: U6HY9kyETkie93JrzUgF9Q==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="3978002"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 20:13:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5c72ogzyQ6YBf/5RRaqjzF8g0q55E7iDnX8jnaxIlkr68gFgtMohTc0e0pn6rUqrRu+mQIKrJNvSJ1ZI7IBbmQ9xjKmwZ7lpk3PO6oPP0osbUg2230wLnrYgVoa5iT/WpYka+z+O0J8js5510pMbH9sOjoKE+AX+fDQe0YNNWWQ/bP1vqPxW2yaa+ZuSIhP45aaUW/eoXyTeo1s7/Ux4ibBaAMILSjq9WVkC+mKVu1ZmfG231j3GWh5GGISn5kDhtzCoXsFgrJU0qeG63LUKU53kN+JTnb8Xh2eYsoDFPr7YBat0YmUAb/9FjDh8mnPcwAxcifk4LvkE8hP1oKJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLfCb6tvHlp91Yia66EH9L2k7899FPMI6+3bcYEskdU=;
 b=NRCJWHaVtVOD5+6xKFqxMH49G7DW5Zw+b/Sd5Oi84WLem/ZQIQZfEtMgazeKPsWyQNlUld6MaiOQbcFXzYQAcC2mUZWVxrh6BbA3qzTLT13+YwF3cINQy6GXwJEZgp0O05y5fOA4h5E8sZd+Vml4ZcjX1FTGCqmfZwRXFE03U1IG52YfKX/iF+2a4OrgjWag/nrsqYNTn/bBFUGrt7EUvEcwetbWn6cTLNOKYDmZ4WqgyWli+fbl960ajsInZzmGVQfgeZdZKRgla5KzKNG4n2M29sRugGcjLPULaVNAV/lvJSusKF8qzvF3ddLoAFU38mmeSiydRPjAP6e6Do1Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLfCb6tvHlp91Yia66EH9L2k7899FPMI6+3bcYEskdU=;
 b=xt5hN384yh0Rgi5wjGCxPJHcA0G6U3pnP47uU++KTr8KjidprmvbCOLCv/NJb1sONW5Ut07QHYs9GfDjQC2zbC2qsq/ZvIiOcZiKTYv+R2pdMUXeXsxJ6TJHWuyqIFs9SUSDDlS9nfdYchVsEZlf2LJhTkqy1tL24CJ/X4Hlw6A=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7772.namprd04.prod.outlook.com (2603:10b6:510:e7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 12:13:47 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:13:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Subject: RE: [PATCH v3 2/3] scsi: ufs: core: Add UFS RTC support
Thread-Topic: [PATCH v3 2/3] scsi: ufs: core: Add UFS RTC support
Thread-Index: AQHaJTkKGJCMMiwoCEWzpUFDJD5+pLCZCRfg
Date:   Mon, 4 Dec 2023 12:13:45 +0000
Message-ID: <DM6PR04MB657594BADE76428806210D3AFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
 <20231202160227.766529-3-beanhuo@iokpp.de>
In-Reply-To: <20231202160227.766529-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7772:EE_
x-ms-office365-filtering-correlation-id: 7db68d2e-0096-4907-d98e-08dbf4c276f6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1W2yNac7FGtopVExI/+4FAkddIxKjvHnVJObPX6I+dzgWF7o6Kn8MNsG9D7DHInI9vYEt+cD51A81Zv5sdQ2qeNobLKiPz8vB6MOSv1z9VxKz7u6iOT+HjX3d0kfhOKjeAL80dF31zosMWepE+TUjZ8csWhWu5GDDlF5XxxIq0tu4FcPkfxuIUjzqHFLnD/wCt+DDbCeq58DhDAAKYR9DTK/fheOJTfYcrEP4JzBwU2t5IthAPqKp8k9toCDEiyPQIRYUUGRXvCM+hTjyGViL4BkhabEfA7uru8I43k57Dum8d6Tf6eTzHla5vn0rFDyM8joH30eP9dW0sD+faMyxUej080MNLFwUMfj5VLJz+nVz2a2/C6+KWTRrNFs3HJIH4FYC5eh77uEzx7MF5tFyDgRN/SLMcP/lNJN5TRsIhitTbMq+eMRNnyURdDgqfPP071l7JhInS46jYLAMZBXxuGPO3Hyu8CsKR1F2c0V1TMMzo8usPFj3qcdjUkagL3BAluhG8JLOmaE4i0nxXSFBddiHBBnWHu1lMsOZSQ/stFSy73dwbfRitPcchvzyjkKlObQDO/5YtLgG5D7PtuI7WtirIiCSzj+jOtbTVct5g2r2rasfqimyBsxW515x3JdE4wcgv0Zvwq7m426BPqvFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(76116006)(110136005)(64756008)(66476007)(66446008)(54906003)(316002)(33656002)(921008)(478600001)(41300700001)(71200400001)(5660300002)(2906002)(7416002)(52536014)(38070700009)(8936002)(4326008)(8676002)(86362001)(83380400001)(82960400001)(55016003)(122000001)(38100700002)(26005)(6506007)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f50Wpbz24sjz1atofR3iLNus3HIIDGgzCPQFmaRNekLy1ZI4s2oliDT2Ijdk?=
 =?us-ascii?Q?U2VQrj/WLKWR1saJssFMtSJDZyyje8Dq7aIdIE7Vu4nWn+NprYqUzKk3qFjc?=
 =?us-ascii?Q?C+BVfzpN06GWxfM2+YM/R0NZiPF21b5Idat5ROicKp8LT0EmwSMkhAG/khyA?=
 =?us-ascii?Q?C3G4kLzhZetJ2pxEGBHr+K2vcyaEXN6UkVThJuujJCJxSz6KnccGUUsnM1Wf?=
 =?us-ascii?Q?1mna+h+ul7MMMjzsJaYyMtFi6+adcWRA6WMflzswC7qKSf1CfO5Q8X3AT3UY?=
 =?us-ascii?Q?SlzvizPg4GBwpeTkBMe3MwJUaL8HNc3Zn2/p6p3OMqO82c/pQMTRQjve3Xjc?=
 =?us-ascii?Q?yHWxvTy7V2r4VR1Eywj9EnxvP+BGQx+5qbf8JjonY0jIq3zsB/D9LpZBJwls?=
 =?us-ascii?Q?rFGXmHp+op9lXUgrn+s4IbC6VwlF35B7h+h2WxXMO/CQG9yJNM01EKr5IztX?=
 =?us-ascii?Q?YE3buMM21yLyI7AIPWlpnkjcCOhYlpSO5kdLp6H3cIvoxQlG63KpnHiifjhL?=
 =?us-ascii?Q?TLH4Y1J6M77wmsqKXKp9GVtbg9YG+LbJ1GT/R1p2yEsmtQD4hqXUHRItXniY?=
 =?us-ascii?Q?U4w/GjNPtCoOlsv3RnOLzDK7ZS4v5EVp9v4BJBiYgRDGXHiVVfp9o+QMDiHF?=
 =?us-ascii?Q?KzXM2VoAl54hzUlm6LE1GliS67CkGNEGlv5iWS9qqc/S6ggcgekTAfvkL1T0?=
 =?us-ascii?Q?N1A504dcoYSfBOpxxCgaUOJhqJRMNohUWx3q/OofLKganWv/DfWWJ60H/IgQ?=
 =?us-ascii?Q?oYI7nctdp7HzxgUm1vX8SgUKf9wz82QpGOu8A/D68PX0UDAh3l/aWLg4yiJ4?=
 =?us-ascii?Q?dMwB2zp9KNwSDPvte9c1h/ElZA3ol9tlkECcasEgVZg0OVxxwOUJl5yMbrEs?=
 =?us-ascii?Q?hyV1sTI7EDh48h84+YsDkzZjgpl655Q23QJN//SIdAnqPRPrOq2v3roPXr5y?=
 =?us-ascii?Q?6i8SoRcpgQ8RWdLDmN4u/eBXe6hYCptYxZzBHnZMIX0DdoeZmsrp7jgUYRmx?=
 =?us-ascii?Q?52uRDh7XneCiyoEZSykWuq2KxL5gu4hzE0VAOSDCkQPS9yD/0z0tj2Mbpi/x?=
 =?us-ascii?Q?jxlBnv2akQh6dqQcqUmmN1byCpZT0tSns2feNpZOmo4c0kiJyJCVMyiR5XYf?=
 =?us-ascii?Q?00L46/g8xvLOBe2tKDunpLHc1VQnHWlHIWPaAcvFXOU/AmoJ+Rd4ICDJMZML?=
 =?us-ascii?Q?1mMvcxspR4XmgyT5mg7tcM2A7DOgtJwDJCLT/Tdh4jmPFaJG2CJ6NyKV8iAe?=
 =?us-ascii?Q?uDxxZOlBU2qmX7ItnVNCmVGYJbJtb93i9G5mLbPqjrmrZvpiefGDKtPospqb?=
 =?us-ascii?Q?KkCJ7CrL8ajbJM4CNarX+rvt8s3ruyhNtzgq3zQBFJbdGQedZP7I8Nl/wCN5?=
 =?us-ascii?Q?GE+seVlgERzTVOQ8D9LLYYd5UKG6gk3zwV15jD+fknIwoe0MX2AAwvAjhlpT?=
 =?us-ascii?Q?2yuBXYce/YMG8izUntWxIaw6D2pbYBC/fuTTq9HtY736j3MuJORNZWl0n1ci?=
 =?us-ascii?Q?F0uNkrQmvSprSpsQHx6mNPmkH4UZTwI/5nJgF5eu1stT+ZNPZYlbLf5z1nHB?=
 =?us-ascii?Q?jStl9v/TKztuSPeKCtDkp+YNNRw2mbOzXPiK2ivA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KvCzokIiKaSrrVLf1f9Z36WDVTp1hVcgN2Gj40aVeKHlZFe3n2g1nXJHkg98?=
 =?us-ascii?Q?TL572/XaRBIslHo3m42hSuZoUDUzOIANmkXjr14yvVjkJd/psPJWOTedDqZ9?=
 =?us-ascii?Q?WzMGUEZFfAy9gIRmVHlO6GWHwDKrfqAdAm9gTkSQlUCIFQXTUrYYckd4tRdV?=
 =?us-ascii?Q?hPDtZ3r9ZcBXw8B3kib5xRcowR4i2zx57Xr9z4De21eom8mYH/a26MMelP6c?=
 =?us-ascii?Q?fH3uw5+RYAe2vcCniEp2Vsa7AF4T+u30EvT/5R1VP0HvlLjsY7v6PLRrG+MI?=
 =?us-ascii?Q?17gz6/Wtts341Vao7oE9aT9OimPeF1s+qSLErDOc7MaaGD3Vfei2/GGQUFoI?=
 =?us-ascii?Q?xUEUR0A5bdCMyE/xN3a5LCLkFC3NnbCnZs4SEKeuJLm86lovDkzNpIK8VusD?=
 =?us-ascii?Q?6bXR7YCBPoxr7rGJyJecimxdrjPGzZ/mRuh2/SlaPkzF5ur1YwUsGyr1Pg/o?=
 =?us-ascii?Q?Kx+zgSB7l6ZZy6ai0odF6udK6IDTNFzkIe09lWk7BJVfHRnlPmv0MkpHJ/am?=
 =?us-ascii?Q?4HB7IrB4a1iiSzuWQjPc1x+Eo8rfEGBvBuuhE3WBfLE6ORRho4CgH7NGq7uF?=
 =?us-ascii?Q?XXdH2xYhkMBr8Eqv5Mmaip3R6QutyjzgQrgqU93DmV+kKy+6TYJHEnKwuLO5?=
 =?us-ascii?Q?dX/lVI+hJTvdHN+48R12DjR5fnwBIANRWjLwFWOFRDOj33EzRvaTT4o3Nb5J?=
 =?us-ascii?Q?MwuwJQxHEcFLuNbFBIKhpw2v1MFaqNf3+7dAYR1dE5/vtaBl7685daqqPX/w?=
 =?us-ascii?Q?emucKaBn1QuXtEQbPjRnS5iUZBFoeFAnn9H5kJ1/ECnE6jl3Qr9mXaB481Oz?=
 =?us-ascii?Q?/2xXoDXfvW1BpXbDkB53pP3l/EBPm16zzycYdzQ0L0MPa6bV9VkxRccQjJDV?=
 =?us-ascii?Q?HJJmqx5XYZ+URAov/SahfM0lQywdEuiHMkcjqX6CVC2yK/OAs7qA33/hDTKX?=
 =?us-ascii?Q?N8P0kKMbEjzloSQIkkaJkT1XR9ZQOghtvgfjUbmcqA7maTijYAzrk2whVYwz?=
 =?us-ascii?Q?LkoeStHd8hhSGW3CZBxhVBIBMyBRU+qpHwsyk5izPOlxpX0=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db68d2e-0096-4907-d98e-08dbf4c276f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 12:13:45.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLJSUZoJBDWSthW7V588O/gda2vhqM01q/+gCFiAMQz1j8espRaF5hI9fmvmEAZ3xv4nb4gsVjmCGNxD4Gal2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7772
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf) {
> +       struct ufs_dev_info *dev_info =3D &hba->dev_info;
> +       u16 periodic_rtc_update =3D
> +get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
> +
> +       if (periodic_rtc_update & UFS_RTC_TIME_BASELINE) {
Is it allowed to ignore the update period as depicted by wPeriodicRTCUpdate=
?
And choose a different update period, e.g. 10 seconds instead?
If yes - then It deserve a comment IMO.

Thanks,
Avri

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
> +                                                       mktime64(1970, 1,=
 1, 0, 0, 0);
> +       } else {
> +               dev_info->rtc_type =3D UFS_RTC_RELATIVE;
> +               dev_info->rtc_time_baseline =3D 0;
> +       }
> +
> +       INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
> }
> +
>  static int ufs_get_device_desc(struct ufs_hba *hba)  {
>         int err;
> @@ -8241,6 +8310,8 @@ static int ufs_get_device_desc(struct ufs_hba
> *hba)
>=20
>         ufshcd_temp_notif_probe(hba, desc_buf);
>=20
> +       ufs_init_rtc(hba, desc_buf);
> +
>         if (hba->ext_iid_sup)
>                 ufshcd_ext_iid_probe(hba, desc_buf);
>=20
> @@ -8794,6 +8865,8 @@ static int ufshcd_device_init(struct ufs_hba *hba,
> bool init_dev_params)
>         ufshcd_force_reset_auto_bkops(hba);
>=20
>         ufshcd_set_timestamp_attr(hba);
> +       schedule_delayed_work(&hba->ufs_rtc_update_work,
> +
> + msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
>=20
>         /* Gear up to HS gear if supported */
>         if (hba->max_pwr_info.is_valid) { @@ -9750,6 +9823,8 @@ static in=
t
> __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>         ret =3D ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
>         if (ret)
>                 goto set_link_active;
> +
> +       cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
>         goto out;
>=20
>  set_link_active:
> @@ -9844,6 +9919,8 @@ static int __ufshcd_wl_resume(struct ufs_hba
> *hba, enum ufs_pm_op pm_op)
>                 if (ret)
>                         goto set_old_link_state;
>                 ufshcd_set_timestamp_attr(hba);
> +               schedule_delayed_work(&hba->ufs_rtc_update_work,
> +
> + msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
>         }
>=20
>         if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> e77ab1786856..8022d267fe8a 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -14,6 +14,7 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>  #include <uapi/scsi/scsi_bsg_ufs.h>
> +#include <linux/time64.h>
>=20
>  /*
>   * Using static_assert() is not allowed in UAPI header files. Hence the =
check
> @@ -551,6 +552,15 @@ struct ufs_vreg_info {
>         struct ufs_vreg *vdd_hba;
>  };
>=20
> +/*
> + * UFS device descriptor wPeriodicRTCUpdate bit9 defines RTC time
> baseline.
> + */
> +#define UFS_RTC_TIME_BASELINE BIT(9)
> +enum ufs_rtc_time {
> +       UFS_RTC_RELATIVE,
> +       UFS_RTC_ABSOLUTE
> +};
> +
>  struct ufs_dev_info {
>         bool    f_power_on_wp_en;
>         /* Keeps information if any of the LU is power on write protected=
 */ @@
> -578,6 +588,10 @@ struct ufs_dev_info {
>=20
>         /* UFS EXT_IID Enable */
>         bool    b_ext_iid_en;
> +
> +       /* UFS RTC */
> +       enum ufs_rtc_time rtc_type;
> +       time64_t rtc_time_baseline;
>  };
>=20
>  /*
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
> 7f0b2c5599cd..7bdda92fcb1c 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -911,6 +911,8 @@ enum ufshcd_mcq_opr {
>   * @mcq_base: Multi circular queue registers base address
>   * @uhq: array of supported hardware queues
>   * @dev_cmd_queue: Queue for issuing device management commands
> + * @mcq_opr: MCQ operation and runtime registers
> + * @ufs_rtc_update_work: A work for UFS RTC periodic update
>   */
>  struct ufs_hba {
>         void __iomem *mmio_base;
> @@ -1071,6 +1073,8 @@ struct ufs_hba {
>         struct ufs_hw_queue *uhq;
>         struct ufs_hw_queue *dev_cmd_queue;
>         struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> +
> +       struct delayed_work ufs_rtc_update_work;
>  };
>=20
>  /**
> --
> 2.34.1
>=20

