Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF176462B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjG0Ftk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjG0FtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:49:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1002D79
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690436924; x=1721972924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OTm3NtM06KAkUOJL1bCRKphkPVZysgRp+vHdrXJSeZY=;
  b=h6ggvoZmsZH/LFSbTDCxX17cEkxq2HWauCRSG8k02vUGWQ6cmYfIDeOj
   cidDYl4in/jok63SSzXpkYJow3O7AnFOSU0a7lauTFpmOTZARMquR/wa2
   NNH38HVVY9wIT90Gxv5bAkh5kXV+k1r5teEh1TsGlOwyjTYDgsqGKw9Sk
   9AGrbKi7ZjP1YPFvIuk6sWl7jZFY9FL5o6K4d7fioS2KpcP3DW1t2Go6k
   rbdyWDgzyKb5VgCBBMTgYO+XbK16IoBfLmLP55MK3K4UxwEkAt4YVeaOV
   dI6U+mdh8DlOuPOjuzfDKIt5Pv5OfR17nq7WWiK6NKxxH7u0DR6h3gOp8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="353113464"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="353113464"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="730133898"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="730133898"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2023 22:48:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:48:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:48:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCCOEJEaKwceelxNRF3unled+uTavUvfNceCFbCE2KL9amltHQF6VD1ffO98YpfDKIMntB0JLmB39RCtuPFFa1/SouJtQfUiITovLOofySOwp90YsFM/eftIT8IhXItPLdtON1nl+Uo7nSee+rNu1S7FJ6KB5JM9kGX0JvsgOBB42lh2J8Ht3+e3eiqNqUPT1QXwBg5i6/ju1XnqFXj3zi5AdkGwWoXezyCh0WbXmc0+Y6xuJwmGrF8ISLdRyGfSKqHSI8CNCMnZbgdGMFyNfSXIcK7yps3aih2Ruo4DUsj9KWxvuMrayrEs0eOEv02ekq+oekLHpO+tBWrboUSUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTm3NtM06KAkUOJL1bCRKphkPVZysgRp+vHdrXJSeZY=;
 b=T57fZMZ/bmnpp4giPQW8o8KGUjdqz2XwrFvZdPJlnMXCvxb6miYdj7bBe4D963z2lYIkw1wU1c38c0Ac5TtD4TjLA/fqpbZQjGJ+pXDFZjSvZRRhgG2PBQfL/AT9tH5y1i5v2SmMhbVPwsKSE38RzJT16qGblqthO1yWcYYtuH83KQk0d0VVTfeAKOXHd9mnsuhQH77mo6p7/UFgTg2eEjd/h8GMsBG7tnDx+TqkIT5SJOvn6umSiCMl88wJQ1wSCISjxPeBSd3XjsMlTULa6CbPXRdLoSs8jBEg9HGu4ipnOrnRVKhT/bIZY+sbCcHEQx9rBhEoa6AsKuEb5NjVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:48:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:48:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v11 6/8] iommu/vt-d: Prepare for set_dev_pasid callback
Thread-Topic: [PATCH v11 6/8] iommu/vt-d: Prepare for set_dev_pasid callback
Thread-Index: AQHZvn0hJ7UKHwfS50apAcVPsaxhhK/NHt9A
Date:   Thu, 27 Jul 2023 05:48:21 +0000
Message-ID: <BN9PR11MB527618D85D5DBBD0CF252BCE8C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
 <20230724222538.3902553-7-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230724222538.3902553-7-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7056:EE_
x-ms-office365-filtering-correlation-id: c81813cf-96f7-4715-b02a-08db8e6515f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SuSRcwKiFFljK1wAA1yDKoc8Dn/mIv2ewCz6HlSmJ/q/gBiQ1papGsOVnAc72gMSS7TzMjZFkj+moTpP0V4f4hs/FMjRsOeLDMlroWIhEam6m91O4lpzNdN607AYRr6zUGNTmS2iLXFHs5oFfyYrKgMWqTdIHfuIeyoZjWV9Vb6cp3uebmYOfLNek0Jk1u19p3add6meOVfw3K1s2Gbvi07FDiuJa4e2kpVcEm9ndNs216mY3/gxzoO8bNu9HwMD1E3gECk7zt/IAFimgBi9RBhGbxKF1ryN1fT+eA55qXLz4pHajXWuhHqJlx/8Sv4Delc9d7SzOtKMB+vrTdFbJXx3XNkysO28h9T/5uMCDmdFfXfAwtLfnugivJT+9nK0tAwXvmpbbtyYx9AtQC4/qR4zj/DopPpXGn+B4SWHe0o5SEh7MjagFUUk76kYzS9Y5b/HR7yJm2rPGG9EwEe0TXxLVlHPzhizp/rVDqgHeRusA9ocEiRmXvqAh9vLqUIJr4HN45RxzdE8n0dqS3jVgk8cbX5Ix0fs3pa9oEGcMZ10nOSY2yC9VeFGNhg8vsowkYpgKC2uzBhb589BmLWfWcVbWrCy0pmRYJKmcDpbERIcmbFK2dVWuiw2OuO6eyUZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(38070700005)(2906002)(7696005)(71200400001)(4744005)(38100700002)(186003)(52536014)(5660300002)(86362001)(55016003)(33656002)(316002)(26005)(6506007)(8936002)(8676002)(41300700001)(4326008)(64756008)(66476007)(66946007)(76116006)(66556008)(66446008)(9686003)(478600001)(82960400001)(54906003)(110136005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mse0rPqJHUaOHj8ESzSoWE4TJYGCn2FMpmnzsl+GU0QIQ0+9QWa8oTjlQttY?=
 =?us-ascii?Q?QjWMGAi9fJiVqKp9RZIxME6N967XK4xYugAzMfmxhmbXDtwe1A1Eu/dcdFFP?=
 =?us-ascii?Q?fDM7LSfyT0nnzlJR4jPl+VLUVjThDhjH65EeHH+l8JeoZZYxtDGOvBboq+6d?=
 =?us-ascii?Q?Qb3TG8u0qySSj5vpolzDFirQ6GunwUeQ8/tKqh2PVLM6JLaoOExVLPQnU1KM?=
 =?us-ascii?Q?v6p72B5frkz1IxCpbo9PY1wMms29W73+aE2LlDirOrv2A3Y7RsjjvYdVJ41l?=
 =?us-ascii?Q?vpx+QvjtpMh9mDz+ZJ++lsGdQF3z2EAmF8XACCVfuYEwWiKhxIr0UpfnEHrl?=
 =?us-ascii?Q?ntQ1Jtpz3ftTdclsGguDeedlGQdM7dOeVo2afqt+c3E1NwEHGEa79Y4EK3e0?=
 =?us-ascii?Q?/XLoBWydy51ch3bWI+NhM5E4hfnoxxj8XFdIhiyPRB5aODY8BPX+cR0F2uP3?=
 =?us-ascii?Q?UT68kRvqNlLL0MlloVokgND2/KYWIpWG67iCJv1J73mfOyrivpYkImCAnrn+?=
 =?us-ascii?Q?NK3Mbqe53dwL8ZHwywGNvtM2XjUvr0ZdQeqUs0w8y1kMH+YaNwhbdwsOnFtT?=
 =?us-ascii?Q?dLS0tbnDUhUXfBz5ArMrYC7TNIfIi660hO12ZeeMLOfSfBo5Fr7MQ444NLn5?=
 =?us-ascii?Q?YEQ0gDiges9QNSNcgZUNymdPGwPcgdSP6o4Eg3zAUvcTxsb+6jKABByiajyP?=
 =?us-ascii?Q?2bcZ1i/szev0zxpFt7oirvDHhcedQqPB+PUrGSf/Rmor9lW7Z12pFIDOr0Yb?=
 =?us-ascii?Q?1PuxzXMtZ5nCXg3x+9nVa4vLRPxkU90JnITxrjJBODwBZ4knzdNjcR7Fbtd/?=
 =?us-ascii?Q?54PWb9dEbJwYqkkva7T/kS0pUEyI7pt6Vf/MhS4Mm32fIgvTvGSbI71HWQsf?=
 =?us-ascii?Q?ajxKNxjJKwmDtdu0ecq1V78zzAC/4orwTo/T2hG4ImkVK+uiKyvy6ZAwSBlq?=
 =?us-ascii?Q?GYlI2+yzv07YYrk8gFjTGp+eiHTrZRvBfAques8fRMZSmT5+7Y1DJ8+SwTwo?=
 =?us-ascii?Q?/v8QeuHLeNip3eySijp5j6+SIPF79VQzHKjigJTeC7IcPeki4+VNpBazIPYU?=
 =?us-ascii?Q?RneMBZFGEoSj4QRMNrqkLJ/2EK9xGZxfm0Br/xSE7Q707PHL8kStYVSARKT+?=
 =?us-ascii?Q?iNDtYAk+uDE2kqMa8Cdm+GcBz/jOQTHEwZlGeiOd+kbsdDgAP2lkvXFEb94p?=
 =?us-ascii?Q?k4e1DiTiuN/HaJ/LH3KoEBKMIYi77VkEyZ+vJE6tuc4i1wOGZyNVhHSHrGKD?=
 =?us-ascii?Q?jDbcfkxw9/U6iUmyB6Felbq4eNzDrfx8hW/zX/bqywsXDbLH6WlcFS+N6ZzO?=
 =?us-ascii?Q?w1KRIucO2cDbSlQPYcK7MbVEs4ZpzSjBXrJEfhCh7JCp11Ha/+UKNXyNoQ7M?=
 =?us-ascii?Q?aUWYw2cBpajTi/32TrKHrm1Y3I/5M9ScHthZhm4SN8emr56+48jE635UCKjl?=
 =?us-ascii?Q?b0SM0MiUq40WYT5L5U4L1SrW9BKIOWDSzr/RkTQuIZ/uZC/erjyMxwL/sqDv?=
 =?us-ascii?Q?rVdJ9WyH/IKpeE0llzXwgZC0Wh1XqeDEdjjClLY6iqXblAi+NIUJuMFw4qmV?=
 =?us-ascii?Q?I9rNyO++Dd3SpFZS8yagE8R4VCxBke2KfXw4rzo1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81813cf-96f7-4715-b02a-08db8e6515f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:48:21.3601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pXcmSu5VdGRcFB++ZdvdOIIo2xFOJfoofEB5y6PzSskKYPWQI1aFSVeGQemXcqyp61TmkG2a1sXpRU4AMV4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, July 25, 2023 6:26 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The domain_flush_pasid_iotlb() helper function is used to flush the IOTLB
> entries for a given PASID. Previously, this function assumed that
> RID2PASID was only used for the first-level DMA translation. However, wit=
h
> the introduction of the set_dev_pasid callback, this assumption is no
> longer valid.
>=20
> Add a check before using the RID2PASID for PASID invalidation. This check
> ensures that the domain has been attached to a physical device before
> using RID2PASID.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
