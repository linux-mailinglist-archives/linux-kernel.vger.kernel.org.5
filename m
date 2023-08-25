Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D96787CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjHYAxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjHYAxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:53:33 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AC19A1;
        Thu, 24 Aug 2023 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692924810; x=1724460810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yvNPO0FcmKU1bLzVxft/DiNgIS+WLP+H5UdV28vh0h0=;
  b=jad7B9PhnQeN1B21hHTWh6LJrmIKZF7cAKafCDEdTEMTe2YsqgrlWi3+
   yvD1RBXelXYlqzEAfNWqMcPXOx0KORmI6DxofDHjFlbHRW2rlJ8bPtFsy
   Jo3B6BRYt2cpHqCUpeTj5d8GazY+fMMBXzo3l2BIlABrGTSLaIBrAXUR7
   A4fCtJ3EQe2agNO+W9FilLmlokoYGjhiB/dseKpj+dRb566kewCCL45De
   Ii0m1oyVXxlz7xcGSOl2gb6ENbCop/X3N5Rr8Y7injDngn3z6k4OX5G0D
   klzApcpjtJZVi0EAXSyDAy38Xf6cjVENPe8JHKVYNC/b09nTTkAFjWL9t
   g==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688400000"; 
   d="scan'208";a="246625820"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2023 08:53:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG35UFJ/7TivR+clBARElZ07nd5pgja6/S/ryVdTNh497h0Zms4EO8r7eWSipezkp5NOmuYEGfNnxvkmX88qcHpJ699j16qTZw7VGCvcca7rpyD/WS0BnFFUEpjcJxktvczGNM3+eZiEj3/LshNs4crO8tSdjLV8442lL1Cv+GW+z/17P9/+jlr3Lr+t7231PkHodapeFHxqfBSq0tNY1sEpDYvrOqI8luhnyDRXzmSnWkG6PG+f8IlJdHOFAB45UyiyszK/L+AZgMr4w/S5MZEURJIn2aLIM78bE+n/457hXQn/aZCNVFFcf82ZAopZ6WDNwROj/cxoVQZMe5SQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is1HDtaALy2EiELjqYkGoBw3KRz04FpvHTwOOlciPgs=;
 b=jJCOVQiRw/qIT3nH+/vh/q18OzAam8myq4XZgwGaD9Fe0jvOCBHY7RSqmExEolPl+TnFDpRmYptUNYgFSTDvFa+f51jTvZuQ6ejQdFC+moCx0fC85h2XQS3k95GJwwcOQv0VOJwqedHjweQFikT3ErSe29P1O+bh/G6/AXhpgE0hDhnzVm1F2BU45OMSmUpnQR7VbqlNtTrWEHUMWz9KOEQCAM7LQ2dnaHNS+uZgoTuKbUX3Py32Fq82gQKH02HbuGZUtefm5N5vlcg67P1lRXWu7ZJRtv0sDaolsndWQ9SVax+uDeYaGN3dGcWwCqd3omR4N70yW9Y+oTzuA2DIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is1HDtaALy2EiELjqYkGoBw3KRz04FpvHTwOOlciPgs=;
 b=S2OWlNPFHeIxaaODQ7xqliubkrsmjuh76QOYi+hxhfgWrL1Y046TMi7iBS57xeKyPRTqBe8yJFIAfhLz5s1G+gKbF0sBHeCdoOVMtuNfYVDLaDGaAKUA/WmsBR/4BDL1anlJ/6qG0MfXjLX7LxsrrArEpGmenH0cJVciMZe18dY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7016.namprd04.prod.outlook.com (2603:10b6:610:9a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.19; Fri, 25 Aug 2023 00:53:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.017; Fri, 25 Aug 2023
 00:53:26 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Topic: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsAgAC/9QCAAKx0AA==
Date:   Fri, 25 Aug 2023 00:53:26 +0000
Message-ID: <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
In-Reply-To: <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7016:EE_
x-ms-office365-filtering-correlation-id: ad9895ca-eef1-42aa-f182-08dba505b117
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O20W0rKScYLEPVqIqGHV/eOXpBYlYJ3RSk5kpW6p0tMgO/o8zg5SyTeBWs2sHpyYouJ3wXz+T2/v7o09JBbItGf4u44e5y0qEy/YddnYWFS25YT8rCVSqWBO8PesaPhu1CQZ+BlSdt637CBYwH/y3mdU+6MCz3C3PRsHI23C2hygdhOgQcqg6FI9X21INktG9N8hconHe24sHT4jRknZmQiSowjf5aaotHVfq1Gzgiphh0EDv1EP2Na1sMBZUbiepX80zm88zG3p3fULJUW7bjJIUnqn3X+vdakynYNL39IG/EdknUvg3GiTyG9ejOcc5OpCAsoaR5HaZDx9sxa4gqqQvL3dUMTWzd4YgcwLJX7JmWZ7gK1ZnjYzBXrEebhBe++hjL05uOcKHa7MHHHxmBak6NYAgPtAsB/nctTFj8g7fa8R6igVJnZk2i+iwWYRAwQKeITgGnoYKlkucJ1lHC8fHSj0V8J64gXfYVn81Qee5w5NO9NmWHYGNmBv8K20CuSj1SdSDXmBgXsGzm0fIfud0ZiBHwjsI8fjKiVGMTyPhWHNjGqLMA6anQwTrUuFf2j+AVUr4Rj+CPtkLjB+jNcsezDWW/YqYnTyAeVwy6GbESJMmPCbTDIKpPFAuROV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(122000001)(38070700005)(38100700002)(4326008)(8676002)(8936002)(33716001)(41300700001)(53546011)(6486002)(6506007)(316002)(66446008)(64756008)(54906003)(71200400001)(6916009)(66476007)(66556008)(91956017)(76116006)(66946007)(86362001)(6512007)(9686003)(26005)(478600001)(44832011)(83380400001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BOs04FHOlcLHQcusNzVeKK0nI/owRA2SIuCWSEgr0Ho3ikkPiYu8mm6BtLs?=
 =?us-ascii?Q?ezPifOOv+RI4aMiBKq8vDBJXIzrfHLl6NY2BsLMFYLCvU5O6bzwWpVGJ7wwO?=
 =?us-ascii?Q?naIaCsxDnTbRpiP3/CaQ5n5LKSBLIq072TDcUafzAizG15fAJx2ggBouNskk?=
 =?us-ascii?Q?ap4GY8fe/yuXWtEj8MQoDxahewyMMVHPNE0MlfJYMWwaTHGgJTNMJWZx+Bck?=
 =?us-ascii?Q?SBgfeg853pmQZ++/R9cwrYcFG27a3/KONN7+3IIXPoPVLrpz+8Vz2CT6D4cs?=
 =?us-ascii?Q?s3ow6A1h7ojDVkdOF3nylESttxjT6EmEUTIVAspPzx7E3Fkeh2pJJy8QNZD5?=
 =?us-ascii?Q?HDBSog++Xp2owgwP3Dk++kUW1afAwTHMBgwUWnTvK32xZVuJLepG+pu/+fAK?=
 =?us-ascii?Q?eklDquLNtc/L71jO9KdmJ3gj+Ywd7iL40heyouO0XHtaz5sNmUNgWvqotVMC?=
 =?us-ascii?Q?j8eRPm2cVb2v/xR16Gl0i97PXrkeZum636Ylq/6qO0oRs/rccfmzicEaP1gR?=
 =?us-ascii?Q?TAqT7NlS0/3RQC59hpds5wuL4SIZBNR0O/xELIuHHrF7rr4QJY+rY73mcVSW?=
 =?us-ascii?Q?UWyDrpkdxVJdsfu5vfJ0I5g6nkXBKporkihsEYx8P2pBepxWKg4gckRODPeY?=
 =?us-ascii?Q?OjyM4d40ukugeAvmFaXXapHObiu1IYyP+7bL2Mu4cI0sYxLtnuKOUQvsvKAk?=
 =?us-ascii?Q?piVDR9lDk/PDn6eBc4jXcZyqxwl5hHYhtChFAXra0SGxIJ2Y7R5QByQY6KvE?=
 =?us-ascii?Q?ri2L4f/un6aiDXd2H4V1yeE05cEgGTeUGfJim/bC0DQ1mufG5tyOzL/KMHzQ?=
 =?us-ascii?Q?OiTd8uNGyYVuquXgsUDOKRKcSNQrKVW10O8LMEPtmgQCR2fvZE0AmFcsg20e?=
 =?us-ascii?Q?DLDMVA2J6q0hNcWWNx5Rxums9zdEcfY4llF+42zsT/15oRJhRpanKlIICl1p?=
 =?us-ascii?Q?6N7iQngTHfBIvu5eU971ZoMzj3uAyT5akLfFBo8I/I2QfM97RVoeD0vLB4lc?=
 =?us-ascii?Q?PO7kOIcmYmY9dURzw2ihNucHqYbhD2yZJytWqdSO578bVV8H4ElJA77z/mHg?=
 =?us-ascii?Q?i9X3Pi9ArBoKXgTFVo65dg2oyw0bBAhHq3GzrNlORB+dPsCDPDgvPPqB9+vN?=
 =?us-ascii?Q?iX7L/zU71fsf7yLv7o2nEP9zJu3TBj175BRkDb945r5buaa2/AyIqgldg44q?=
 =?us-ascii?Q?LV41dZq1M0m3nqgj4TySUBug7P+dSJ+hR0RNzTh//PYG4uwmcPUg8t3Zb8il?=
 =?us-ascii?Q?91qQ+zTJfDJr7/sEGbfy8141yYcbaKnAwU1abLxBhFvxhuUKMxIa4B+iBOoF?=
 =?us-ascii?Q?edUo2qsRWifPl2Lc5HidI+A+J186uxjvDcB0/HJSksQrbfSemeAiNE9c95sS?=
 =?us-ascii?Q?e5DGYYMShrKcrhgJBttsnu0DDigvh0JQGuKc8cdCaUQKucwwvpjx/TGUR0EH?=
 =?us-ascii?Q?9rIIBeriug1BtTu7903b/vEcVyHyUUTTs5HO26gphpszfdMD5Vu0mhZU8VlP?=
 =?us-ascii?Q?NrCZUshtorZrr6wwpw/GeP1qsIpdtg7AiUvojyXp2OpwCdOjE6TGnm9rep5o?=
 =?us-ascii?Q?LqhMNaZjOCBgUrhrpenqi9iUNO4m36sfu7Z8YNsGVycSHA5SY9479m24DQMj?=
 =?us-ascii?Q?OadBgajCIR6lLrN41Lt6nWg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A186415B3AB8AA4BB9ED705AF2781E3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9hj1m4zWWAjVE5JwUK6JWPuV7cLo0OUCOM4wYT1wlD/FHKtWJI+v3U5lg5fR?=
 =?us-ascii?Q?POpyZLi7cmGrII0wISB1MQVocBQOFq87PFOFivzsGyJHaW3KeoKUkOI84ZIz?=
 =?us-ascii?Q?ST10peI+bWXpi0SiYKMA9tvm/orGOMop0eGG+iCnSnpXZDg8ebMkPue/S2u9?=
 =?us-ascii?Q?Z4qoJAMbkNIH97gJF2/NICQ8HQz/DqKyX9T8ucXU+4+S/Z8YbCSN+HjMN40f?=
 =?us-ascii?Q?u5SKCxbKsWbqVm4Z1u4BciYpwPWYr5+J49eZQE1anbREaoAMODAJUyT87IdD?=
 =?us-ascii?Q?7+SCt/p7Leip6zAWhbejuvO4tfqCMDqX/aQEKHP6gNefBpOqSpIIvlFeOUd1?=
 =?us-ascii?Q?/xPzKlfCSYMM0M2hGIB/snoKuByztj1pdQjI24VxvZ/VgLx3LDssv+zMEhtt?=
 =?us-ascii?Q?TR7wIDlCdzoLSBEdOyP1dcRr/FuO1+BsdfhNxX0Qq0+GPtHLA+eWAlvwNz1i?=
 =?us-ascii?Q?4g6BLJ7o0e22GcfqP+CN0uVc6WtJ1XfrxvHErLUjBe6cmRLwI6NBMnXKUKuE?=
 =?us-ascii?Q?NrIZfTKB5CbDV7I4+26qOxi+yq16j0q0l4ZBEDfNAzSktauYDARC3YlLYuSO?=
 =?us-ascii?Q?PFMpBxRlsyT4Btrvfpq+ODsE47Mpkd/OD7I8hghrqWFtZ5m7rGKI6DOC7Uve?=
 =?us-ascii?Q?iPt2IwpmDh0+nyIfGC0c6QQdSRMZZabVaHjijk5v/bhEw6jRxfs3xpKZ0oVT?=
 =?us-ascii?Q?zJN96GsO/kPUFd9To+ylD3XeBl4TSfCA1FnjW97dNL+97cfPaJZECepI/g55?=
 =?us-ascii?Q?XJpLbT0fdFaDp0nu67TlZbJAv0XpTINL7BfNd4PtDLrYwwRRoU2DM5Gx5ahU?=
 =?us-ascii?Q?UT0JDkx5VpL6i6zdzIelfTH2ewgLZ9euTkpYnCBYlkrzj1lNeDiz8gTOmnht?=
 =?us-ascii?Q?gNxIWOe//KAhzsVhj8pXwUrYSdTCyNPmQrLWRwsChGpIdX690C1SYrBPDELM?=
 =?us-ascii?Q?Gs1hyWTh/gf7TJOS+v8zFw=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9895ca-eef1-42aa-f182-08dba505b117
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 00:53:26.7459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOH2a/p+YSWi7S4pfQrpD3UOXrW0Gp9+dKBjs/qmtSvO3A8ALcYRHWVEcPmK0HMRIBobcWHn66CTm4JhdG6qtrxqcaKoCOHjK9Oy6Dfgd8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 24, 2023 / 07:36, Bart Van Assche wrote:
> On 8/23/23 20:09, Shinichiro Kawasaki wrote:
> > CC+: Bart,
> >=20
> > This patch makes shellcheck unhappy:
> >=20
> > tests/nvme/003:26:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/004:26:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/005:26:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/006:24:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/008:25:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/010:25:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/012:29:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/014:28:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/018:26:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/019:27:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> > tests/nvme/023:25:2: note: Use _nvmet_target_setup "$@" if function's $=
1 should mean script's $1. [SC2119]
> >=20
> > But I think the warn SC2119 is false-positive and we should suppress it=
. In the
> > past, blktests had suppressed it until the recent commit 26664dff17b6 (=
"Do not
> > suppress any shellcheck warnings"). I think this commit should be rever=
ted
> > together with this series.
> Please do not revert commit 26664dff17b6 because it produces useful
> warnings.

Hmm, I see... SC2119 is false-positive for this patch, but it sometimes use=
ful
functions which takes "$@" as arguments.

> Do you agree that the above warnings are easy to suppress,
> e.g. by changing "_nvmet_target_setup" into
> "_nvmet_target_setup ignored_argument"?

This works, but a bit ugly. Another idea is to make one of the optional
arguments mandatory, a positional argument. I think the option --device_typ=
e
worth making mandatory and explicit, like,

    _nvmet_target_setup device
    _nvmet_target_setup file

This will make it easier for me to review which test case uses which type.
(This might be against Sagi's comment, though.)

Daniel, what do you think?
