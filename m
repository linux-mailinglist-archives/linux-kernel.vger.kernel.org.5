Return-Path: <linux-kernel+bounces-24226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78082B960
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2914286BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7EC15C9;
	Fri, 12 Jan 2024 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KYk6GOeA"
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71224110D;
	Fri, 12 Jan 2024 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1184; q=dns/txt; s=iport;
  t=1705025746; x=1706235346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UXlCyS396l2PkFr1O3kSbluDjPmJ6KxOXCW+ntMwus8=;
  b=KYk6GOeAXWENIqJDy9Nft4amPaHRXCNkjo155v+R8JBqmjLaqqmZqKxB
   gBrrI2hkgJhabD/MpYMf2OXpm0mqDA38qQJkuIySVKAr16hsINjoBZ6C5
   B3h9vkkeEzPJbWwHcYyLWn2IA1DP7FuoVI/hEg1yRl+R+QnXQmrC4TdYF
   s=;
X-CSE-ConnectionGUID: +NjKNOJ4TDG8us1PmyCsoA==
X-CSE-MsgGUID: p2yDlYEiQD+QrAMvQyQ5LQ==
X-IPAS-Result: =?us-ascii?q?A0AsAADkn6Bl/5pdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlIHc4EHEkiIHgOETl+GRYIlmCeFWoElA1YPAQEBDQEBRAQBA?=
 =?us-ascii?q?YUGAodEAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBBQEBBQEBAQIBBwWBChOFe?=
 =?us-ascii?q?QiGPQEBAQEDEhUTPxACAQgYHQEQMSUCBA4FCBqFPgMBqVkBgUACiih4gQEzg?=
 =?us-ascii?q?QGCFgWye4FIAYgaAYoiJxuCDYEVQoJoPoRFhBKCLwSCFoNCkFJSfx0DgQUEX?=
 =?us-ascii?q?A8FFg8eNxEQEw0DCG4dAjE8AwUDBDIKEgwLIQUTQgNABkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAaBgwmAwMSSQIQFAM7AwMGAwoxAzBVQgxQA2UfMgk8DwwaAhseDScjA?=
 =?us-ascii?q?ixCAxEFEAIWAyQWBDYRCQsmAyoGOgISDAYGCV0mFgkEJQMIBANUAyN0EQMEC?=
 =?us-ascii?q?gMUBwsHe4FWA0QdQAMLbT01FBsFBIE2BZcCAXsTHIIkKZYorxoKhBGhSReqD?=
 =?us-ascii?q?i6YH6g9AgQCBAUCDgEBBoFjPIFZcBWDIlIZD6IRdjsCBwsBAQMJimcBAQ?=
IronPort-PHdr: A9a23:MoAbXxfkYngCHp0JuGWvOUH+lGM/eYqcDmcuAtIPgrZKdOGk55v9e
 RWZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vRht6r1uS7+LXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0BbLr3BUM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:AyB/BK2pwf7Qx+DP3fbD5d5wkn2cJEfYwER7XKvMYLTBsI5bp2FRm
 GtNWGqCbPrcNzSmfIpyat6x8UgBv5/Um95mSAE+3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yEzmE4E/3aNANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV5
 bsen+WFYAX5g2ctaDpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGT2c0Hqs/2LpLLU4e6
 OdBEDUcRQuErrfjqF67YrEEasULNsLnOsYUvWttiGqfBvc9SpeFSKLPjTNa9G5v3YYVQrCPP
 IxANGYHgBfoO3WjPn8UAYgineOhhVH0ciZTrxSeoq9fD237llQriOGzb4uPEjCMbd0Pj2qcl
 0/Hxki6OwszEcKm2APY1kv504cjmgu+Aur+DoaQ9fNwhlCXg24aDhwKUkGgiee2h1T4WN9FL
 UEQvC00osAa8E2tU8m4XBCipnOAlgATVsAWEOAg7gyJjK3O7G6xAmkCUy4Ec9c9tecoSjEwk
 FyEhdXkAXpoqrL9dJ6G3q2foTX3Mi8PICpZIyQFVgACpdLkpenfky7yczqqK4bs5vXdEjDry
 DfMpy8774j/R+ZSv0ln1TgrWw6Rm6U=
IronPort-HdrOrdr: A9a23:UmTQNqOmWRJgDMBcT47255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NCZLUbbUQqTXc1fBOTZskfd8kHFh4pgPO
 JbAtdD4b7LfBZHZKTBkXSF+r8bqbHtntHL9ILjJjVWPH1Xgspbnn5E43OgYzZLrX59dOIE/f
 Snl616jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyjqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqEMKiGXow0cLk/aJAA7SOPAxwr6xtSGprXbIiesMlZ
 6jGVjp7qa/QymwxBgVrOK4Jy2C3nDE0kbK19RjzkC2leAlGeVsRUt1xjIPLL4QWC3984wpC+
 9oEYXV4+tXa0qTazTDsnBo28HEZAV5Iv6qeDlKhiWu6UkfoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBZLfMB2BfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPJgF1oE7lp
 jNWE5R8WQyZ0XtA8uT24AjyGGGfEytGTD2js1O7ZlwvbPxALLtLC2YUVgr19Ctpv0Oa/erLc
 pb+KgmdMMLAVGebbqhhTeOKaW6AUNuJfEohg==
X-Talos-CUID: 9a23:Jo0XmG9aFD6UVe5l85yVvw0yGOMDVV+B8Fv/c1KjUF5sWZaOTnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Aw72lfw9aKP2NzvtoNyQWb9aQf98y8oiqOW0MqLl?=
 =?us-ascii?q?FgtOtEDJJKg7AqA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:14:36 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 40C2Eaxu029694
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:14:36 GMT
X-CSE-ConnectionGUID: lI3pxKHiSNG4Qcp8lzSv7Q==
X-CSE-MsgGUID: WPnRLfgcS7mTm4uAdv6LKw==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,188,1695686400"; 
   d="scan'208";a="19623758"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGsB5y6PktyMsWsOv5mc3fjD0R9/2igmz7RmSzr4P7Xgi7pmWfWkXPxXdes3xg+IYrCwivxP1eFa9SH7EL5/sbxVzYrRJrynAbT4WRDDUFye+1wFL3zuztgItnhqgZWFPBEHznAyeSBkyxC48OrMjgMKUzSZqZ9bW8F0aRCzt24bFJLaltTq16DHpl/c4r+GibCy+jooDtS7lmbND4tOOG31Nh130ushEggJ+kvrNg8p6Zss7E9R3uBO7ryQpetp9jAA5Ni/uojz/DxIZpLWU7JwxjMXtgGtbdXgOc0Gkuk41HYcp46veEZiwtrIqbSAIs2q9jZ43v5PqTjleibHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXlCyS396l2PkFr1O3kSbluDjPmJ6KxOXCW+ntMwus8=;
 b=aNJ6IhLnOY9hWwo95m70w6vINeQDQsxfGrGjELxufMLIm4lJAhoBaf6eIZUdPeNQY97LDdlTQInZNZC2ihzbrlJ/tfF/GjgOzNuif+zSyCc7tt9ht+v7DEOnO3YKBhZnFkXXiWzasZyz0wjNi+gnXCcn+mT+b08VlWxP9nvpsTj9fCY0hiJIo74QXUZ3vKZsolemQ4y1okHtPsleO5UevYoYB2SgKLLYfL33G8AODC7GrV0CrMbJLHU/N19VyI/NQNEB/GjA6IrPWjXn2kGAe+aPnQyd/Niorh/yfKtmhn3JWmJv8RjlziMxej5OzOArUeeC4zH88AyEV2QCH8IcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 02:14:34 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::55e2:9720:962:3073]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::55e2:9720:962:3073%5]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 02:14:32 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Sesidhar Baddela
 (sebaddel)" <sebaddel@cisco.com>,
        "James E.J. Bottomley"
	<jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] scsi: fnic: unlock on error path in fnic_queuecommand()
Thread-Topic: [PATCH] scsi: fnic: unlock on error path in fnic_queuecommand()
Thread-Index: AQHaQ/S4wCJM6FLsDkqtdo8A4xgFVrDVcADw
Date: Fri, 12 Jan 2024 02:14:32 +0000
Message-ID:
 <SJ0PR11MB5896EF08C7E85D91B16C8531C36F2@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <5360fa20-74bc-4c22-a78e-ea8b18c5410d@moroto.mountain>
In-Reply-To: <5360fa20-74bc-4c22-a78e-ea8b18c5410d@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA0PR11MB7933:EE_
x-ms-office365-filtering-correlation-id: e5d76b9d-c6a7-49dd-62f7-08dc1314375f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 olBIPkJoUCIrkSyollOsH46Ftw7yjUYRjlkXyPgt8c9zTmjgUO5XqGI4LKy9H46vlXjIv9Oj0Nz1SNVrDv7gb5Yl08mElcQK5QdRHI1mxhGElLLoEDd2ef97DEcuhQEk64F2oXhRGFKa3/OdmbG3NfVqiNL3AMKrrOAaZB02qxgq6y5aGy9ongPrIsto2WOZa0qMF3yHyYCipBufE4WIs2NWvp+ELs4RfsVvopPAt92FFBwW4TbToenuf0GiyXAFhiIWv/fEDxPv2QJGPjVpbuEkm3ZlxUF6SXA3vXxlkCHG3/CSeYJnyOTYldUoHkNRxr5NLnXoayy9l15GleY/KguoBbvnyxgTmzzT+r4JMFtbNhzvl5PBJt3h7z/m2K5pUSDNA2LWPO9Y6AKNYtsZXEf6LRnAdLNrC99w0KhQx3eZQ95RHKGFkXM8URZPDlsz8JKS6lmhtEnAJ9Gm9qtSWO857zcKgyeXeKuGRS4lPxV9GMbaMOHaDmYIxQoPIeY9SCsf44mX7BDu90RMcaPIbqpmuWMDGD0DndCoo+zQGrzpLvZlSGwvNm3/Opii2oOYIMtvEK4PX+sxqqKKLLSzju9/zOSofmbSMz2jnrvsx3rYn4DCtVWZc8PzYxwa09Kz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66446008)(478600001)(83380400001)(2906002)(122000001)(38100700002)(71200400001)(4326008)(8676002)(66946007)(316002)(52536014)(54906003)(66476007)(7696005)(9686003)(6506007)(4744005)(53546011)(6916009)(8936002)(5660300002)(64756008)(76116006)(66556008)(41300700001)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7rpJxr2l7RzrkHTjEtjSKv2gvMXoE1/M3dNfSygLy0pwC5v5gGOvIzdjRf5a?=
 =?us-ascii?Q?zC9KAKCAPGbSUjnZm7Y0XBGjfHoWh5TwMI4F/DDyCyWObrT8qfBvGzRXn+yh?=
 =?us-ascii?Q?h2zfgmiCstx/L1mhAwiFg9G1+mSHrHuv2cBu+LNsGT3PpP1lem7YXfcIOrwe?=
 =?us-ascii?Q?Cp6XIkdGsTPxxtW8/yboiOAoRAbJPZ34m7eY5cqAYJrv9BNUMLUuIdwyMxrr?=
 =?us-ascii?Q?cTLh1tIbdVQoddQR2tPM96zkOqZo/SJFfA6lYb6BfbbIqeR2/OBBVWMp8ao5?=
 =?us-ascii?Q?2Ur63SgfRebRMurebQpEosMLWN+T3djPRq9yGqANVx/XfHZVbR1+9s6WdaeJ?=
 =?us-ascii?Q?SWLQaWwD7ZaTa7oEScn6QP54mknLFPRSp4aAAIGKTnE2RxjWGOPVZd+Z+ZGO?=
 =?us-ascii?Q?tCy4UISEThtgn0mrHOpz9ulDBlP4fCDYu7tuOpks5ELes7ycRs6CZm3/99GY?=
 =?us-ascii?Q?TCOdvRiTWZ/FLxRiBD3AQJQbLHwgtjRmvbMsmRnoNaGB7HlnbYQ8lLd+lYmq?=
 =?us-ascii?Q?2gfuFPRwk+5ZvEWGhvaT7NDOC6o2ikb2hWGAYmF62nQGeZZuyydtn3X1iFxk?=
 =?us-ascii?Q?0VrefaSOIBIZnROHrKuj0IjbLHdFJDPQjAwlqN6NIIg5H2fT7/MkVc7x2lv+?=
 =?us-ascii?Q?RLMvd/JR8A4Tk5bujoU9+rUA4MOjsi41FZpEtrEsZLNcMzASciM54dZV2kda?=
 =?us-ascii?Q?oPZ8hgGANJQUa2iLObWnndBMNErACOU+oWg8ISKA2v2hpSbRndNV12cPUq/+?=
 =?us-ascii?Q?JvsYzx6orR1HWauLlnEJVvyjrd7h7MVSDmuQOzw3YGTALqTa5fZl4IebQLw4?=
 =?us-ascii?Q?tGKT+UEQ02nukfiUTrevnX6sj/bb9ZaMc08N9Rq3+6DxEozNERpjpXplQiHa?=
 =?us-ascii?Q?zDVCEVK3E4AGYEkhPwhKOnqtPuUQHMOdQJNtlpCJ8H/77KHTwe7C2jpAplqV?=
 =?us-ascii?Q?uYWlhGfjDpRdurk7XBJYbMtP4ZdSXjLr38HU6VPiuLBiqgaRLnRfu5vMNnvQ?=
 =?us-ascii?Q?lLoZyfyDeT26WWqFXm5zDLK5E4VvY/yMqN6lNe/tiwrYipc+a/s+Z2QtrpRw?=
 =?us-ascii?Q?JUQxWkdBMkYBSO6hebSKceJsjw7VVtBGnqeA/w+cia6R5J1XRYBVULNrAsTS?=
 =?us-ascii?Q?lsHXIZ+ZMVPz7bGrf8kfyPYVlj7XvgqbJWEL63f0MKMk/KDJVTI53h6xg4NA?=
 =?us-ascii?Q?Yx3hR+wVgOjtv7kiEtFbmyZGrZ/9b5F1FIWELiEoO+Lo+i9g603qa0VzLT1G?=
 =?us-ascii?Q?TCLhaRXADtaxu2f91CcMjrQhuFXj2+LtSzarv2tO3wVKOzMfEd2s3/mTFGFg?=
 =?us-ascii?Q?u6sImidxcc/cofuB1/fXS+T6a4zz4kRNfMSFk7SmTAbNuYMIgBM+3MMLgWDJ?=
 =?us-ascii?Q?Meb3K4LVhDt1fK4IqAG9eaMuna6AU9FxkZfujZjoNF2D+ql+ghac4M6YyVED?=
 =?us-ascii?Q?3C0FN7t/s3+1P7HCahoAXkMJsanUNvv3Tqhtf7qH4W8PMeSuFzfBikG9sYoj?=
 =?us-ascii?Q?qYih7Aqw115+86yyA8k7IAEiZ/L07OUp+dw09zvTE0X6pMf+xJE2iY3yHQGc?=
 =?us-ascii?Q?hopBMB08sZ6jEW9N5qULpFu7LrWyajINpHok9i3x6nPcnWEu+l1MfjdVQPw1?=
 =?us-ascii?Q?0cy4Iiuz//rIP7mAwtwpzTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d76b9d-c6a7-49dd-62f7-08dc1314375f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 02:14:32.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCawmbra7/4Z+mO0iL4NC0Ttavu7rcVsYaQmrdhgguFR9LoyMCq9MmbkAEdxzPNVJGujmnh+DbbfMndZ1Xq0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com

On Wednesday, January 10, 2024 10:42 AM, Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Call spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags) before
> returning.
>
> Fixes: c81df08cd294 ("scsi: fnic: Add support for multiqueue (MQ) in fnic=
 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> drivers/scsi/fnic/fnic_scsi.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.=
c
> index 4d6db4509e75..8d7fc5284293 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -546,6 +546,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct=
 scsi_cmnd *sc)
> if (fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] !=
=3D NULL) {
> WARN(1, "fnic<%d>: %s: hwq: %d tag 0x%x already exists\n",
> fnic->fnic_num, __func__, hwq, blk_mq_unique_tag_to_tag(mqtag));
> +             spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
> return SCSI_MLQUEUE_HOST_BUSY;
> }
>
> --
> 2.42.0
>
>

Thanks for your change, Dan.
Looks good to me.

Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

