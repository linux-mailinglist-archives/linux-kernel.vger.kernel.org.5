Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7857EA911
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjKNDU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjKNDU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:20:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD16D51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699932022; x=1731468022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rk1odlL5fQuIJaOl9mzg/hAvGyhUO5V0eVOAnbWa5Tc=;
  b=bQMOgASQW3fSUHIJrNGvJqkCgEWrny5RfFtxiYMo8fiPucoz9ATStWne
   eelqAEjN+C9/w6DGGRyhk2Z6GEXzPE6v+MSD5Sv6O/iQOX3T2MRVit39Z
   FNLLf3Wzq5QA+S/neKPpGc8BYynHnuCu8G1Oljgglnx+kTMmCeQ2NhQrw
   WCfzgsNV0CvVc0aU5i9Gmvd+PU8eI51yPWyMoMX3KtYwp9dFzAUYMZN7w
   JQImU1N/n7zGMuaoByTxShHI0Kj03YaZeOMmyDkz9i2WK8IgIpQlqhG8j
   t0qM558mOwAdq0UtY25M+jMCwBWJYhbqzMzS4pE8FgOJFJT4POWNTICMC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421665204"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421665204"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937901081"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937901081"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 19:20:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:20:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 19:20:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 19:20:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfrdBBskgjNUhnEjTxsW2VaXcdoPIfGlOZUdoYlCUoF/bi/q6PA9+RD9mFlBFpS6FTvVAtclsGPvWripDUmOauZXI3vki1wR9YVqqrGC1230hNWYgZ8W6+Hc6zgZkoyP4sG0pkYe1HFIFUgg3Q1vWPcJV1NVDTd5dgb5dGAwC25fDwNPbsAEnndgiz2ReRWy+hRdjvebJzk621yaQgYCahp6uvT8qhXA3zdanOhoQGmimiCedRGoYAoQ8KfviaO33tI/Eh4qshvNmYTQWHobKCljbUrH27gWkkPejkPOYiooaFqdPXDVCO89/buWyKIVf3Vr86B9/lzvuj6qQXd0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk1odlL5fQuIJaOl9mzg/hAvGyhUO5V0eVOAnbWa5Tc=;
 b=YVEWCPiQicCv0vm8lSqfDJsB7Ek9Fhkz9z+ROXyIYBI0XJQJXE7IvgoGPKukUoVliltOYnyy7FkKeL9elGcuT2ydecQhFkkbdMRksEw5kWEZCOLvwswaUX0I7kFSGU1J4GLn5tKk+ZvOq5CAlRm3gbYYRA924Di19A2QhbgN+wS4gtS6CUlsxbkpiMyafM/Yr6l8d0jtB40H8+aga6pVblAMUGDL8/Qy9e98Fkbq1DiKEu/nL1g+xzOHonZrdDqX9UVAV6H5MZKMDKADu9B89eU6GwNSCXvaUhrskayLGsa20Y0/oQFOTlHv+XYBgg1ySDT07gYMB5LhPHKjZEaPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 03:20:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 03:20:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Make context clearing consistent with
 context mapping
Thread-Topic: [PATCH 1/1] iommu/vt-d: Make context clearing consistent with
 context mapping
Thread-Index: AQHaFpgD7eV3C3aZ80+9ufH0otr//bB5JNYQ
Date:   Tue, 14 Nov 2023 03:20:08 +0000
Message-ID: <BN9PR11MB52765C637BFAD28ADF1D24738CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-4-baolu.lu@linux.intel.com>
In-Reply-To: <20231114011036.70142-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5297:EE_
x-ms-office365-filtering-correlation-id: 894aca76-2da6-408e-693c-08dbe4c09b00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bn7N5tVeuT2JOx8QRD6fcGzx45SGeycIDmx7iAJoVkqlxMdPGipO3/EpnK7s4ianz2ok9jYCy3pKSyleE0+h6IIx2CW0E9ttoOcnaKZtYO2U9t5cKRit+BsOVWyQ+oU0bYbsC8rxZ/Gv4XhHn/FIjccfyi06Sarlea389Da++egeRd9b1D+yUjWzhjfrTAdOcMzT+6HMsDGK0Mb2ZCSZdSdEjfmLdxoNm+EcAfVB8HHquKgJDu3cHqMIh4TX+CgkR4JgSul6rV4+KTXZTh43pmkp8tkue0ibFW9WVyN34pwYUGvzthgytzBPkH4bb7RxgSTX7Q4ZyjpG+1AYX3dvkHqSrUzvpFKQhuoA1T6Vc0lIavtYoWGUGLGm8/SP4iGMcB8d/dHeaTZrNGskQofMtsf1kFBV43R4JJWoX/V9C1XJOFZWW0Z5hfQJFJsY23Dni8WqxuYPygal25ZCJLMN5SHFdi4c5uL7JxvV0jnotgJy2U96sufEAtwoYO5IrJrl7Le1LcXXwEb2FTZxB0gZiQVF16c21HhzjG1kmVGqWRt0PumCyqQQOBJUkaRNrSH/sKtjFYZbeJhrBnf9MuHKnE5qmo0+L/ABqRY07G7cS8r0m3byIIbvfU6UxVC+uOhS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(8676002)(52536014)(4326008)(8936002)(66946007)(76116006)(316002)(64756008)(66556008)(54906003)(66446008)(66476007)(110136005)(33656002)(41300700001)(4744005)(86362001)(5660300002)(55016003)(83380400001)(38070700009)(82960400001)(122000001)(26005)(38100700002)(478600001)(71200400001)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yH4dcvF9MDeP4hd+QjrhApy1yjfp7pG7H1CaSrEI8nJdiT6EOBKI0uf+Q6O?=
 =?us-ascii?Q?iZPKE3PEiX8Y/11aB+wJbfCVmDCedC9YkhOjgwCmzGVYyId1JNjIEBuSAjEO?=
 =?us-ascii?Q?RPca0Y9WZB/qeZjh41SqHCjpq7lzpgUi/R2Dtpu0BOiuxsUyr7CHd2uTUdrb?=
 =?us-ascii?Q?PAmmh/rN/f4h1F7gMiAEQRvhqb4WPQttHkl8nPlOpsE6DiBwMkMHebBi5v1P?=
 =?us-ascii?Q?2X65bV/sC9tFStkAp8ogJfP4dJwh1kAFr9WFWtfDn8rDViuP5wPynIFt2h//?=
 =?us-ascii?Q?OEie1sfyV8RB4pDfXBOGJ+vVS/su8ruoNc6WsEFU1ZAL5bfvalrFXKcGbNzG?=
 =?us-ascii?Q?+q7WOEK1UbIT+TJm2fCZsMPe5U13b2xZlq5VEHeJOEa+fd6m6icn3opSSI3i?=
 =?us-ascii?Q?bN9JQsW5RKzPloCOHa0eCECDTJL1ctvtPPsJPcmL+eGqHnuME/CkC/jCu4sU?=
 =?us-ascii?Q?z7vByAdxS49eSq7GdTeFvvHU1s8W3DUlMVeVVP14x+UCVWm80iMS4WrMREt7?=
 =?us-ascii?Q?Gw9SbgfHqX/ktE6yL17vrPZHLNevPGiZLviuXc9OQIydDQ5MBKS49pQTTi/3?=
 =?us-ascii?Q?v6rYRJa0oPQlQccqiB96IJI8MZs722fXlEcrzDZ6VVTJ17+XO6WMQrUfiJex?=
 =?us-ascii?Q?yV2kHqXFszOdWmruq7LgskXmFsRZ00R017kpVWjVJE8TToFMV96UlmQtVNc6?=
 =?us-ascii?Q?tOcPQBolYCctQCiIPEayMO9dfOcyrkGi+6I/1NlNBVc79cUx70fM1aUTJ+Q3?=
 =?us-ascii?Q?svAHPSKc0DS4BlAXxEzWhGNALLpzxiJlvfnWa9Xi31H6p1vKe0DVuzo/v9Hb?=
 =?us-ascii?Q?cKmFQe+AKThziGxZ2DHQvISgmvB9dUQkM08PvnBZ6i6oc92/UwXaqLWWN9Fe?=
 =?us-ascii?Q?WS33ocOyvUTjSMQR4krQAuwglBSKbgGP/UAxHMYYGhCHVOXmgsFTcAfOaVYH?=
 =?us-ascii?Q?QDTjLqtkAb+Il+HqZkj3TloI4n3Tal+m4I600HbXbWwskZumuHeYQ9u9aXrr?=
 =?us-ascii?Q?OBps2FoAA1pUE/ODWxz6K+qKnGt6EhAYLEgag4Y8/o7AX9yjcOAtVCdNybaY?=
 =?us-ascii?Q?tW0rBmoS3lbewtiniVVbGrrAa2IcJyb6mqdsiisrPt/y2QOiuHR0Gji/eObZ?=
 =?us-ascii?Q?/tQPR4uhX3+LNVMC0kvw9VWXvPT5dL+ga7ASuUOCE5MneV0SlcXr8yxnZu2D?=
 =?us-ascii?Q?2fuC6Z6xiSpK7k6byP1UE/qW7d0VbULEwJPQeY7T8HKnYbhAB/HnagA3Xj4W?=
 =?us-ascii?Q?3F1ePE5E6EW0YloYP8oR0LTtXFwcYw5n1lzE4zzO7udgv5xH6s3OYVRqt1uT?=
 =?us-ascii?Q?nw/GDPFS0OcBhBqs1I2g/03cs8eI4hjUQK3/BQEBYIadcud6zA5zxLID0oQc?=
 =?us-ascii?Q?DyzBcT4DXVyzSe93V2E7hvNedZeopHlboEzgI0v4ggNhiZpUpFh8hmQ8F41h?=
 =?us-ascii?Q?sKH1GZYWURlAPykSqeMdvu4KDywrCpxHDA/iDEEdAHYpJg1rsYEleXn4LO2u?=
 =?us-ascii?Q?53CFZtqIOGnnErWeOuZAAsaNOpEM7sVCwFoRjbQlHbfXikMxkq8ZPksRIWYv?=
 =?us-ascii?Q?HmRbJIjDEJtx76OdL3QsVwHWalkIZjQbaB9+Rpkb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894aca76-2da6-408e-693c-08dbe4c09b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:20:08.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRxsh1aEDfTP059H+zQj8uUsRHs+NBggr78z6Lq5fOPuhwWldIObchZkLO5928bE9/vAKkBc5+5KBroeSexMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, November 14, 2023 9:11 AM
>=20
> In the iommu probe_device path, domain_context_mapping() allows setting
> up the context entry for a non-PCI device. However, in the iommu
> release_device path, domain_context_clear() only clears context entries
> for PCI devices.
>=20
> Make domain_context_clear() behave consistently with
> domain_context_mapping() by clearing context entries for both PCI and
> non-PCI devices.
>=20
> Fixes: 579305f75d34 ("iommu/vt-d: Update to use PCI DMA aliases")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

The code before the fix tag also has the same problem. If we really want
backport then let's find out the very first commit which exhibits this
problem.

But I wonder the actual impact w/o such fix. If there is no hot-remove
possible for those non-PCI devices the context entry will be leaved
enabled until the machine is off. Then this fix is nice-to-have then
probably no need to backport?
