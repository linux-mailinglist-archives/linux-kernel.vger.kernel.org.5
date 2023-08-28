Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275678A4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjH1EOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjH1ENr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:13:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08710118;
        Sun, 27 Aug 2023 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693196024; x=1724732024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TyE7CNgFGoyp0VzvdVsMc/oan5pAngWPdbxzQiQIFp8=;
  b=K9CY/QN9SPXzsKOjLNLw8+exU58kgGVGpdZTlHnU5oGyZ+OiqoL5LJ5h
   tY/kfqTWYJhvIJObyPWCcaVY6L93A2fTYRRTkNA4PS3khgbMMFH3wnWFj
   vdSvD5PW9K51vrgfBjL+c1oJ1/IBsmpogX6PL58gq1uPc8e029bI7qXhL
   lXPivUVj0a2LLBrE0vXrjOZy3lmt6JmymWONigq3L+RiOd7Qklo9vVllE
   wCEei5s/ly1SOkrKW8G6bzhIv/V5y/t3J5n0W8td1BXsZvCW/lOGBtlPB
   ymmpPl5zalr2C1VNIyijM9cCZU/QVfr30Z1wP4N7siKsCJpDZvhzCTV/h
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,206,1688400000"; 
   d="scan'208";a="354319237"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 12:13:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfzDvUKiTb/A1Cn4Nf84j0EEyjcpGGOKQP4cVuWESRDND0tE3rs4Euxj2yFzS+ITb61jHFrhgn8CFhTJTD8aAF83oa4U6NBetx5J+RjJHjfh7OZoYv+uxaVfzN4b1CYiHukbELVuKb0uYt80pdyH1K1ArmW015UNSc0dWGe/F7ZV5wb1z+kmyFkIrbyjNvdBuUuyE4dOikCWMxDD2XbHSQ6t/tozIrCGAjgdkGDKIpvhngwyoj6OeKZ/eA+5W8E9qwr87HMV1nxBfRo2VZbhhPBDDa3I/iJfvaDl5eg/sFH/5Rt9DcyX994Cn9noFWALjKMPHlFkDpZEExW4re1D6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGgPnHm5g8IF7IROjJhW1dAx1kY088fA/XN+2NUzMco=;
 b=PtXsiyXpF+lNAQ3CkfA68qJHJZrmGqpj2pE35dPllojlTv0zrnYGMj3EKl1Vag7iTd1ss9EPD6aZOSwsbPTsUG+xLESmYrDGVu1jW2GJvoDlkYlrwDNRtpIVnO1chwDXSFUOWixKHK3+DXODfLenO3PgjtmxcNv6AYdPHl8vUjRD7O2DXGPfX9fXpNTqIFoVz0b6FP1DGPRgY4dQyN8JoVJh7bZXnI7dLeT5w41WFPNW5WBIBMigo0cMhvpEASQfxhrxwSgJ4FP6QgoBnIuyXzvKovERKeYGs0qwMvrn+mRjtVkFU4JkWTn0uqvbM/0SXIkjI0gWATtA8ajavWTukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGgPnHm5g8IF7IROjJhW1dAx1kY088fA/XN+2NUzMco=;
 b=s3q8FOLH6Nzbej8vP+U+PRpQ7uTNBcDggzuwB6/qGWeC4/Y6leMet9GR+22nGbhA1w6SukCfN4vdDl4xfMiEswWz0GjT3LhEaT7Appg16wQomaoO3H0E3pdmj6y7LC51Vc7cmL3KMCutczD+hU4Pb4fasVBJcdv+wN6xMOnFrEY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8867.namprd04.prod.outlook.com (2603:10b6:930:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16; Mon, 28 Aug 2023 04:13:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 04:13:41 +0000
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
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsAgAC/9QCAAKx0AIAAYPoAgAAPCACAAGeugIAAC3qAgAAnFQCAA+SfgA==
Date:   Mon, 28 Aug 2023 04:13:40 +0000
Message-ID: <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
In-Reply-To: <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8867:EE_
x-ms-office365-filtering-correlation-id: e0fa4231-a055-4ba8-4231-08dba77d2966
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ds4UW5NhRosN+e7q14EE4aO7SlhgU7aydwN20ANp1bc88qmcocM091SsVitOKCiO7wmTx/rjoBeDPI2LST97kIyYQAGkUfj9JAXpBDNEtHDf8rr1koO/i/uhmdHdfYmi8vItP+phdzZ3utQuQj+l9aFvVasBUlaefzf9vfxiB+NisCeq0I8ZoPNwZj6dQwcF4A88ilQyM2w4MjERcBKzLdUdKU/uyFa2CQBpFOxKiatZhh9sISeBIvZVSvHxqgOlC+2b1KAzFY7a0BXqGHrhfBh1qESfH1t1KrkWQNJ1Zg4y9rcW9DOguNN11o/SGwUZUhLiPNwm27NoIHtO9R1bi8gs08B8yHnYtx74+Ch2Y4GaDDzrVh40UbY5obGGO7OVetgD3YZulQD3P1sTSD6H1f3PxH2vG38jzr2PMfp6NeD3G1U4BmaKgZ/OSZ/r3u3sEF7/h+DCQQ/waMDPwjgUoaGrS8cLUltZlUlyAwgyhILdbUFPZD7rai6/oP2jzqaC5y4tYtnudZ49Vo4hotjNs4RFW6d1N8Eet7ZX+flzg3C/uM18W9PlUIO6hX8YVbVsMrA8yfa2ekrWyYOKNTcBspOKydEv/9sH4bZp02VKVWG+96SZIZp/TLvRfUDKrSHP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(186009)(451199024)(1800799009)(41300700001)(33716001)(122000001)(38100700002)(38070700005)(86362001)(82960400001)(478600001)(83380400001)(71200400001)(26005)(9686003)(6512007)(53546011)(6506007)(6486002)(76116006)(64756008)(316002)(54906003)(91956017)(66446008)(2906002)(6916009)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NfNoFkzMGXT1Mzu4cZV1bqHh6MDUSGboX0g1c30APT7vHue2BonJo4sVXzfb?=
 =?us-ascii?Q?34TpRsXdFbBqaH6P8MSKh1gq9c5rnpEOpERvwyw6xphWeAa8r9uPol8FHNqG?=
 =?us-ascii?Q?C9lrXdJXxPcFnNqKAGhGM3w8jzAh3ck7BiwxwqM5TySP5En0BJEMby8m7/gj?=
 =?us-ascii?Q?NOgvDhWHr0ebCYx8czuTusj7cMAZ6dysup5oXkeGq2DOcrbhrfxh2ZO17mPY?=
 =?us-ascii?Q?v1W4NHgjv2yArlmal17+wOT1ukU7nxLA1EhF5ceRCpI7JCeNPxIpMSDV1yEi?=
 =?us-ascii?Q?/HK4hZ5+ZixyJge0H6379EsnennANViQJh+e+tnu9R3Z9f0iKHE3mcNDQD7j?=
 =?us-ascii?Q?o+oTp6Twcjj4iA+zMqmxmKirUA33gcpmelyvCncbv1/Bn2++gKlZvgH2BboA?=
 =?us-ascii?Q?yk4R7B+6+ebtvaCF/8VYbkqSubhcr4QB2BPphQaLcrBNzsbI4ZagY7r6hPuq?=
 =?us-ascii?Q?I8VAMopFkmzlUGCHS1r9RfWdCh8hxt8UtxWjRk+QlB+F3bMaF72B29LoWmV1?=
 =?us-ascii?Q?uMXExgpYDNFjdaz2IU9y8PU/8/V1ulHK4/7KoVbP7aU6S8+HTyT8iZrA+HSP?=
 =?us-ascii?Q?bZxDAQBvovWG6SIY813D3qbWayz2OiLnl2POB+oo4eOdkkFjtT3aaHZ3wsk0?=
 =?us-ascii?Q?A8pD6ZTIsMpOXzXpnuf9xn2IZi31s6TyepcvFxqtMB/W7EzsJJQ1wpTnMWbk?=
 =?us-ascii?Q?9nTya3a7AAK77+gY+nb8MHx5dfEkkdBSTefmbOK7HRg+RmrE9qnM34a9ca57?=
 =?us-ascii?Q?btib28kbxEXgbTUt6r+u0phc11yhcvNarHvz+NLyJDd1RzIOLZkazwnTKeR8?=
 =?us-ascii?Q?G4icl4En9cx3CElhNiXQkGORQy42zEiuEr2U/ENaSFe8jesMEK97EMmSoyxo?=
 =?us-ascii?Q?LFL2/cyOvHV4lvkCho5jvOJCjbe3Tj5iivJ/sBCE9+jfTKgzAGnSAXMxbNni?=
 =?us-ascii?Q?snCA0Rlhv3JfAxlIDa9wmL38vwDtjR1WLf/vjObA6ZOWb39lXUbx0YE/DvgP?=
 =?us-ascii?Q?HXKLH6ZNhQcH/+hwka84ODFEV+SUz66sfExvNKhkOn3BiVImt4ClG74bSFyR?=
 =?us-ascii?Q?vJ2LbVnNeTPWyixmn145e6gCrGDZfEgLK8xSDdjswR8omrXB/Zw2lNoTm8EY?=
 =?us-ascii?Q?kuRBLgEm85an7u4JumLDNsJ9EE2tmytRvyiKbDtTfc/z7QuSSQ+ZZRkKcuDV?=
 =?us-ascii?Q?CYrBDTgrPtHJjx/XuPV9vACnIcKqx/0O+45MiyaWXwkZWgEHa4V4985CE1Fi?=
 =?us-ascii?Q?IJYW17yCAYEJJ7f1sITx6eCjaKHUnu5mYTbn6z6csanDgFx22FfH8maZ9E+u?=
 =?us-ascii?Q?+Ojfw5nhdUGv4NfixpSM+j0zpZXWKIfi3GtxR+zLfBNvgOt0bvHIlr6C7Ga4?=
 =?us-ascii?Q?sy8k42ILFGd4/0LcXFfLqx41XKysNgGPpM4xyLDw0SFQGU+OX4qynwcItuXs?=
 =?us-ascii?Q?irLfNlLMwxN6jWIJTiBOdohrdKbKnxazjbQqTifWWDLc8idIgfiIgvdIeCaq?=
 =?us-ascii?Q?J4SFEzIogb26b5CbHM4+L3Ry9gENj7RJkSvH9PZNWU/J1jCQo09KJ9m1Fueh?=
 =?us-ascii?Q?zuAjFoJ0FhbZzOaOu35QcY69pm5NzxxQ+QNBr+tWA8fJPbCZ+DZV6r/mVdbo?=
 =?us-ascii?Q?yrnN+y8ky8c/UDvNm47bMkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <617F7D2994332A4DA5219A4825B185CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nz7VyNzj8UQTXnlwXEVJHbMXZz4HjC3oucn5AaQAK/NqpWFcx2Iy1XBgNana?=
 =?us-ascii?Q?VgPosjtgCqx3BN182UCy1ovfFfUahtcc77SUyBnaAeTTvNEROayRDFH7aTaT?=
 =?us-ascii?Q?zDaUKcB20XNJ1ZGfRtpu/cfWVtyPo/E0rnbuYiiXzmENWfxaaFN9lcCEJo6z?=
 =?us-ascii?Q?vL6dI76NvB6H1ojhp8MzqdsHbjpKWM79KVA05yFnmqcAGEPs8Pc6Nt8xSn3u?=
 =?us-ascii?Q?mX4S05raj/TV1JrazZo6SqnHqsn0H6PPBcEkcLTQI9t/uzaOLCsbdG6aDci3?=
 =?us-ascii?Q?WARUvspPQ1+wRt08f3zHKGafovJk/68+WFG5Q66P7oMR6yB8kB8t7T2+E90B?=
 =?us-ascii?Q?B57TcrG+90jK3vHPL3zHdGF2fsLTr+21szOmPaFXkQWEdLXRdPBGACKbcPXs?=
 =?us-ascii?Q?VNzpYZUiGpRmXCg1SheseJtJ1a3ie3Nyjh4dSL2e1VuFFkD1J8IQu7sdyM8y?=
 =?us-ascii?Q?2GEnBpmYXlzwgtZdu+O6ONzDlJ0Mhum+lKaWqAY3ocx8g3O33eQwxBEaxpHG?=
 =?us-ascii?Q?3wKxtnv/wL1jEXfGkfFVkaYnPMnAhvNI4XHSgTAFTYRZfHpZQ5HU64N3mi5g?=
 =?us-ascii?Q?Sy9JGjCgu+cBuAeU61QBxMcju6CxTbrfliyOmFw7/4crgj6DD1BIxHJZtKdE?=
 =?us-ascii?Q?5q7rC6Wg+Lt/kN6Mcu8+dmht58W5cbrcOrnAzG48Op6CWT69tYZjYX+sqonk?=
 =?us-ascii?Q?boZGSrgYgY+N3UwW4kharW238OMiQGE53fTB2qQZVrzqgvJv4/5NwsyhBddT?=
 =?us-ascii?Q?oTIj1D4+vZxfArpHcHQYus4fW1qAavNqnHXNXR69nKk+R7s+lgSX6GeAjfBV?=
 =?us-ascii?Q?MPrTb63zvrEA5UwOD2GOkdQ+Il2Qo+OfAnhnl/FTuNKHTJ0mh6r13Sn1PMgZ?=
 =?us-ascii?Q?bZu99/nKp3MwYAX5iGLr/jh6cHCDEdCaX3mPPvKaD3xf7gFcCexmrycpoYVt?=
 =?us-ascii?Q?fp0Jsx0I+6EekuRJvuAhPw=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fa4231-a055-4ba8-4231-08dba77d2966
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 04:13:41.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhcNsdr3MAedaThWb4+bZsuVqvA9nzFLLgNtiTHO1lGX6eyi7Yn5LndQMBMVT6Jw0HLnwYJcC88TEbAmBpSCeKxjCbJSb7WdkTogcJB/ODA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8867
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25, 2023 / 09:46, Bart Van Assche wrote:
> On 8/25/23 07:26, Daniel Wagner wrote:
> > On Fri, Aug 25, 2023 at 06:45:25AM -0700, Bart Van Assche wrote:
> > > I don't like the "new style". What is so hard about typing "$@" to pa=
ss all function
> > > arguments to _nvmet_target_setup()? Leaving out "$@" makes it much ha=
rder than
> > > necessary to figure out the intent of the code author - not passing a=
ny arguments
> > > or passing all caller arguments implicitly.
> >=20
> > Because "$@" is just not correct.
>=20
> Why not?

Bart, let me confirm. Do you suggest

    test() {

        _nvmet_target_setup "$@"

instead of this?

    test() {

        _nvmet_target_setup

If so, it looks weird since "$@" in test() is not the parameters passed to
_nvmet_target_setup(). Anyway, I tried the change with test/nvme/003, and
observed the shellcheck warning disappears. Then, it will work so long as "=
$@"
is empty in the context of _nvmet_target_setup() caller. Otherwise, it will=
 not
work. For me, your original suggestion to add "ignored_agument" looks bette=
r
than "$@". (or in short, "noarg" or something)=
