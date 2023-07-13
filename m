Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D79752134
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjGMMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjGMMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:23:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0262737;
        Thu, 13 Jul 2023 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689250963; x=1720786963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eZEKcZui4S0eiNk746jZAKLHVDs6+WDhqOHzvgH7V0M=;
  b=MIKrWpTWE5bpyL5wslPrR6vNTb4u+joE+/OHHOnekv7/SFsfxcP210WZ
   tfW4xlhe90lpn3NCRtrGKAhzgBRkiFMX8nffCa8fmYlWT6e/4FH8XNCPv
   H+CPc1G6tJL1dfl8Kf0hdb2OaYXdldTD2s6fGtqayBdygWQFF6+OGE4Dw
   42frXEXOyEH5HZG4Y4n9en2WxRhKXlr3jrzmxPG+C692Sp1HJjXwcPYSa
   d9R2ReKU/T1DCR1pyROYfAedapLBVtX21USPUm3hCHkAj46jpheXsxA/W
   lwD1kJxwWnHJQ/TBaIT1SHcTiVdlCtp59eNLKfFWhQyAh1sHYWfmUvlKX
   A==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684771200"; 
   d="scan'208";a="238290247"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 20:21:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A47hHTCAq3i/T4ql1QzLGwOAA7R1FZ5akX7QqrER9W7+TGrJM1y2ifTzbgFlrk4NGiNyjV4SSZ2hE7CqwIoalkj/uAbF30m3t6ACL6LPMvnLPn1uaA9jq74hbag/rISYu8bZHLbV/mIBxK6XU44ziLiWkQgWQVDBTW/gchcTx1s1I6KhvQPKXISzITJyjCbaKVwOoRT03Yyj3tJp8Q3lATQZWFs+qyWtWMWwtggbO2RsCZknKogBHjOsY3xErxqq20S2QwMF5g9y66FXw2kBq6V2wbgkmDJRz1NgrV79E1UdfzAZZNJ4Y3o0/s/OR7fBSIYPxZmJxWu210d8nRSsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZEKcZui4S0eiNk746jZAKLHVDs6+WDhqOHzvgH7V0M=;
 b=ZbRqo4FAnSY0Hoh8IwX6ZvmkO/O0hPNDHGzRuJQquF4YGmoSAS2GCqtRTq9RBEUJEelrk+UzhmhefLJ075WKJmka9x8v6m8mu+iZ6b/KvzsUlq0hNB+JPjeINU0ar7c8Ctz2geCmFCNbp6wWv16whz6hl25h9ZHFCknYdSeJPwT/qVCuSiamxD6T4hdvr0/UTk7TdJxqXH81Ni6cymdQ0zAbGckki+wjRWP7fK5+kloifBM8Rk1mrxbexydPI1YxsOnRCgFqNnv0MpWPK9G5ubOakol/MWI2E+ex/rWLE4kopiVak1c9rZCT5+X40OL9DQo8AdmuCASHRQa38ukL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZEKcZui4S0eiNk746jZAKLHVDs6+WDhqOHzvgH7V0M=;
 b=dsLfLlr2k64AfCCdW6YqXzvVK5wZIsxaDqW0VO5aI2lmN1/dMYg7392rgVYi35GSPUYwXeFh6YK5M6zSyple0SXbq5U2SDeZlvjg4gXKGcl6jXZ0JNrHYyFkicFfM25ey7WcJ1vkYLIMxG/fvNwGg7Qo/dWVRJBpn5OwSnsW958=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7705.namprd04.prod.outlook.com (2603:10b6:806:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:21:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 12:21:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "mhartmay@linux.ibm.com" <mhartmay@linux.ibm.com>,
        "bblock@linux.ibm.com" <bblock@linux.ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
Thread-Topic: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
Thread-Index: AQHZtYSQnzKxZ0Itxk6F+okOIyyKAg==
Date:   Thu, 13 Jul 2023 12:21:35 +0000
Message-ID: <byd2qxkpr3hfwbwqvyfhzme5tj22ysl73anejw6wcrqnq5eh7k@datuhqcrjprq>
References: <20230705024001.177585-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230705024001.177585-1-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7705:EE_
x-ms-office365-filtering-correlation-id: 010fab9a-0ab9-44f7-f291-08db839bb3a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3h8drUEpWlVU/fExtF//pvQKLogPzO0YFEAO6KzGm72MVj89XZcqOIzPlqmCtXgmPrCVdNzNPuoHhqDJe4UtJKuSnuU2mXPD6bD992krEUWeEQNElfF63dre19XuPz7zRFIubsDRVYu43UGpatnfEjrw20ntnBKvHUxhB51o7o7PqKAE7WFvy3E50HFaExkXDfOrc2T8s/P2hPwws9FEkjUWLqoE/O1P6kYdG8oDFM/polNdkBOPO8d4d4vNA59jUdt6x3Jn/11JPzk7tvLOJnYzRD9jYivc2dLY99qKqi2fStORPhVpkiMtXk99EN65//3m7Q2lQse2NSGyCKYXD/Dl5jHVGovwJ3Z6xFm3LkdARfU6M8gLtxWQnTdevdOJvX+E94tZtgkV7HQ/kfh+maQPRqpCtZ0PAbMsQrQ1rAzGmycK9cOsgedzdu/kvONN8y/5YWMApq37KBHNAWt2PUFQHvdD6GQC579twoQdgNunadGaJers7D21PM3uzug/v9ihSjRgXXCiWcomL6Aif80Dt+gCu7OuUdKICNgX7+GGml2vG0SPl+cDHveJ4pgZQYH6d8GyE6Q7OwrZNvkzlLsiVxAKl7LXGc36sWEDyn4UPIvsV7Isf50+ndU93qay
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(83380400001)(38100700002)(33716001)(122000001)(38070700005)(82960400001)(86362001)(54906003)(478600001)(26005)(71200400001)(186003)(966005)(6486002)(6512007)(9686003)(76116006)(44832011)(5660300002)(66476007)(64756008)(8936002)(8676002)(66946007)(91956017)(66446008)(66556008)(2906002)(41300700001)(4744005)(4326008)(6916009)(316002)(6506007)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p/4vrI1psDXr/KlItKtqIa178UK7hNETodcnZAI9XxMx/tCBiCKETwxje1c1?=
 =?us-ascii?Q?fuH0W8LD6KX8L83jiFQ7Ts6CDxms5/gPe2oorbfkDNgO7YVjJUfWp437gZ7u?=
 =?us-ascii?Q?DVl6DEEsXmmbRNDLdPGunqd5UQCROIllZaPxO+My+VKoNcNnZj4AEx37rjSh?=
 =?us-ascii?Q?dhhyooX18u7XGsqZ1FRO3iuJ2F/Hz2Z8EiVc7hlVCOU8WyE+YKYhmYEdioxv?=
 =?us-ascii?Q?eHthvlaVyM4jGhVUrA6po1xXC+paYWtONor9YWIVTdvzlpzTcOThniQB8YTM?=
 =?us-ascii?Q?m+LVW/yRztq9Kr7jisMY6zQ6zCwso6eqCN/RlxR/uu7NOolCtNdXIcVniwMF?=
 =?us-ascii?Q?dVu7myDC70ZQAo5M+tWzCW/wU9wEyWzF6v21R1WcuFBbLek+S0pQPELOgEkp?=
 =?us-ascii?Q?CoUGMK48SpjV/uePxUNUH8xCaNx/rM51ACIpKrn8mfCJ1Q8U0M+q/7CafccS?=
 =?us-ascii?Q?up/Pj319X8HUD8Mk/xdtBpQUjy7WBHPKgNlmKyKjgCVRqGkVWQXlNLKn9msT?=
 =?us-ascii?Q?m0hkYZaPMtkLjb4mWLmClM8WZtAfcBxVbzvbO4btwhhOAuSYVoJiQ0+Ipygy?=
 =?us-ascii?Q?c/yjQyLcgArtvvhPqPmCnlyJpzKZLTA+PvGk1AKdbiPuEzIAPvALdUTQm/7+?=
 =?us-ascii?Q?6xPMn5dMczeDKCh8fitEM90jd/Q70Ti4caf3aye2pw2LFztoDFrmqHUVFIr6?=
 =?us-ascii?Q?MUO2R1vqePse/CXZeptw/OFpcTXYqaM/JrmnditLt5787zDlLfvv9mlZ0dFf?=
 =?us-ascii?Q?v25e/4wOFemDMl4dnbtXtCRhfXMBK56m0fe/jSnLSn+6K4aAxc5WN4zj9TmU?=
 =?us-ascii?Q?2EdKZqtA8tChPKlPjiMQYlAFkZqFSBYOA/eyfbeIbPkZHX3wYYsJgl/vGbLY?=
 =?us-ascii?Q?4RC86VGuivHUWbLSBt+jNgMeUoLB8V/TrK2aw9ZG+kG2c/LGRif0h2L+gpwX?=
 =?us-ascii?Q?6NrQgCb0oHvu/trUHMFFGtS3QNGdO2JNvQ49HbOM05O1l1tJykDsau2J8Mrr?=
 =?us-ascii?Q?GjyhcZm6pgkS1EUEcoNWKPsVvRhweZFNhjpqCXbbNqkdXn/JEksjJaW8azTp?=
 =?us-ascii?Q?zTop1s/sMVyb3x0f7eItyvCZu8wuqAbBa47O8EsQuWATvAnrxIZTBKARLVd8?=
 =?us-ascii?Q?XxRz6NbMNzzYC2kE6yA8KKtZPujM07FLGp59h7ECTAvkFNT45sSTDGlUyQgH?=
 =?us-ascii?Q?QRsbz+4if2GfKf24w7X7JqDoY+QWijBOluiuLUlmfgdt8WyU0oCsNU5GOOiA?=
 =?us-ascii?Q?I4RnzoMgczIS6K0z2yRV+68L+u77q2t2uXqLgsc925v/cc0769v2W437MkvC?=
 =?us-ascii?Q?Wge6YbdIUXGSpZQJD7hITs8sSa+nxn1lsj96RV7AbqzlEM2tNOXg36zkpkaK?=
 =?us-ascii?Q?ACQhks8CejjzJxDe1MgIYKbkXVLBFhdhBKwvJK5bBZsaEiStBytFbpvwV5jO?=
 =?us-ascii?Q?kvU6HKhiFTn5g9CPbu6NqH7pMy81djJQoUB+vZ1GlfsttsY+alQ1rvTM45/7?=
 =?us-ascii?Q?xK8pWFA73XnjUEdRt14aXXRqGpYfhqaJpYXkkrpqpJiKFWcwqU83msjYRw21?=
 =?us-ascii?Q?HmJsjeXP0gR+nkj65nYUSwHfq6q0SxCi0Uv18C8cLXa7cpq1c+dco15KYp8E?=
 =?us-ascii?Q?QO6ZW/5EUWhRSbfK7TnDYlA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEC3775696798E44BF56A7A80766E444@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Io6+QriZ7/NthSFj4Do/Sd9AnFVvLn0elztaayQrU5ZpdsITJp177H8mSuvc?=
 =?us-ascii?Q?PTFMprKD0fHMEAhYjOvzBTvPVMZYhfNBPe2hlp4nzKGZdNV7RPmUsSRp5Emo?=
 =?us-ascii?Q?fGPKQ2w0VlZ8l9yDMWL0hiyv9jMzQWG1GegjpBd+EgPJUpYAVDjkoQZ3+1zz?=
 =?us-ascii?Q?d13mqGZYMnNdu9GMxUMyhi20ju/kN3DNHDz68zHVAYoCgwae1IOMFTxWME0K?=
 =?us-ascii?Q?VN3IajPBFpRqOVJLract9y3WT+NX3ttdYElZmKzc/dYszv6A93mbU/dFNEFi?=
 =?us-ascii?Q?Pp8/da/MwxcewunDeQzry+HMLGFQWOq1dEMvLztka9n6Kfht3nspkKbytpDo?=
 =?us-ascii?Q?SnVZyAlTz6lk/YNhgmQMvnovRKu1nDZsqrYQPsYNq8o1IHoaJL0HBZWf7WQB?=
 =?us-ascii?Q?2/kePumiwIQ13xr//H+KSyBUzJGyuigFneahGNCtGuvIYDyRFqm84kFdmeWc?=
 =?us-ascii?Q?33dWZ9sAtiAlcaMlfnaCaH5elLoQDF7t9WrkleBJfjHlmzmLRrBvU8RR5ths?=
 =?us-ascii?Q?SmRHJKPhCGWIDnJDD6/bK0/rNC+r24WetuD3KfUu5ypw/1/ZXBOuhyl58RgI?=
 =?us-ascii?Q?2Q1rMpKXe9hK5wj8S3Y+xLH3UaheZA+KQ2KEd3gCb1E+ggNoJ0MHfD5kRK2V?=
 =?us-ascii?Q?R9f/LUmtcfMpNdULELX6Q6s5bWOP3kmDEDIXouvP6/0WHVm2xQIBruINF8gH?=
 =?us-ascii?Q?9R5PyLiXZq9uRCvA9QQ20Kp84vfMgjd9PQR/6G7/+U1K0i5vtfzrr5yITmle?=
 =?us-ascii?Q?NU6Xmhouks0+vl/E/KCSSXHz/PA3z20U6Q9rtDeW4Mk1AGtHlDfC6OKCqZut?=
 =?us-ascii?Q?M5SqTPkqyXMuFlju7CaIze0MtXMKLQKHT0m4Ozrj1BFQ9jlSmM3j7S0W76Kv?=
 =?us-ascii?Q?yYelvjVLzGEwbOlGXg3o10p90K+z7ooJi5VTR2RJuvI6NMAHLsU82sl/XFvv?=
 =?us-ascii?Q?K0/9JJtgGhlozmBsieiXHQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010fab9a-0ab9-44f7-f291-08db839bb3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 12:21:36.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uix41mkoB9S8hYcSlTWq9WlHGYKS1h4Pge7Hp7W5JxrD5Y6YDmInGphubI3CbfWtDEx2VrNWu4b5tsgXphQJqZAWvrkiLvzJrT4/+rjeO8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7705
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 05, 2023 / 10:40, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Commit fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
> make a mess how blk_get_queue() is called, blk_get_queue() returns true
> on success while the caller expects it returns 0 on success.
>=20
> Fix this problem and also add a corresponding error message on failure.
>=20
> Fixes: fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Closes: https://lore.kernel.org/all/87lefv622n.fsf@linux.ibm.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I observed that /dev/sg* files are not created with kernel v6.5-rc1, and it
causes blktests scsi/002 failure. I confirmed this patch fixes it. Thanks.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
