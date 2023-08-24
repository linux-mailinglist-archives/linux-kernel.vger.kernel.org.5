Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52B5787132
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjHXOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjHXOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:10:15 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2021.outbound.protection.outlook.com [40.92.48.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3A1BE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gECH8NnJj2sDJNbj3qn7yHBfB5jXfN1w8eHJ6uJDPYPqHLboIJLFU9jV9UbP+NIvghLxgaxqxXgyodLEOILQOdwQkzT9D0x4czMRmavzB38Nn0Hj3Tw9p808/+IFTvwXNkKGpc/t4k/wPCJ/ijZ/nxE2OqCRQADlAmmsQY3v7NHqZcxmzNxk+XyBPUkWRQHo+iTgE2GCsleHZFemQcEgKDAg2DQrSoRVBnvslKMNJELDNbMovo0saWoM8l7ZlQvPG3sXwjC8TPIDtKdJSv4JrxEpYQsnWpNqn5GwRYXbyfLcako/ZE5RYTbLe6rCAI51bFHJeAGqui8cBlxfbLViJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb+dtYs3WC2iWdS70hUaMqb0tc1MgzgQ0eWikvpg5z0=;
 b=JU0EtocQVAJc+hZxfPkaqqtSSoAlnTMBn5DvjE+lkZtjSIBiL/+d1gcbbOLR7NJtLrW6oFUhQFsvGDHhz1F8SRyRsZta4aKAyBFhEn5Yp39E4g3DNsHysNqfozigd2dN9dtasy50eUXV5X4sQjNBxbTOs4uF8UStIns17ggcwa7aIDZ8tqFiswxP/7Ien13fGxBgPlJtcoUE/7EpGjXeED3I8Ghig5OfnDSq0VLwgLtL3khmDFPJO0eI7a0VvUMF0a5unRQCOPYO7Tej5PgFGkUDIAW32luMFVkiq6z2KrehesZvCh9NmvFcoq5F10WBs0Ht7tcL691n+4GBrpru3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb+dtYs3WC2iWdS70hUaMqb0tc1MgzgQ0eWikvpg5z0=;
 b=Y3jugpQfuYH9bxWk4GZFxRYK8W6sUrc75ZKyFhn7HmAna0f9Y3sDYlFliyj6nGXgZJtPRC2ITUl1Hbm3GLm+kzPa61WaAueaThBqe54lGsJwuS6b3v5Y/IvBvhaItFIVV589jzC6BWW83qoYe8stiINpG7TqTr/NQ0gfFANKzE6H0Iu+SKsHyOyu2LQNrdvDU8eA3coGnh1q3709OzCmA/yY+MBwdtnrf7DhEW18tC8G8xHp0O4AdA+cUBnPil7JUsggQoT3opCg2zYCJzbB4fDRUDKkEOWLe2xZBH5j8cl6yfr7zShIl8BCCpt9i5Xs/3qNrrrVb4/EcgyO23bFFw==
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:323::12)
 by AS8P192MB1846.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:529::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 14:09:59 +0000
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4]) by PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 14:09:59 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Bit X low jitter kernel config/fair pay philosphy ideas, updates,
 corrections II
Thread-Topic: Bit X low jitter kernel config/fair pay philosphy ideas,
 updates, corrections II
Thread-Index: AQHZ1pRSwYTN8u5UN0qbRpUkGi4W7w==
Date:   Thu, 24 Aug 2023 14:09:59 +0000
Message-ID: <PAVP192MB2135A916867B8B516FCD0DF9E91DA@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [u3vKGSDY62E1H9O7EudEdHtRKOuXvAjt]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVP192MB2135:EE_|AS8P192MB1846:EE_
x-ms-office365-filtering-correlation-id: b43809dd-393f-4353-3229-08dba4abcd5c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzrpVKo0IiLXLSrMPvQYbfsFJjTU7Zw9ElydYWv51gJZgYtkNNJzASgzpcwuHmliU3Yq2efZuuwjC4ctLs8O3Wo8yiXLuaA5S+7qwT6QASgThUIWw5DG+CQoB0CGijv31CuXtnir4RfLUb5TEAH2IO/TH0YKI4p131P33L+KuZoEKF/wsx34BJwdYyRb34trTPdcn5QFVUBHFVhdNhGBUy4KxM8NR2eQyEuskvUc+9GFXjH5UnAVMbmKyfSNBTR4e9139fvt774HRnAc5B3eGKIu5v782IYrMFyBlCCk182mKdn0zRF2MTVpTQVf6PCa0iGrmmMeufm8xLOlbRI9tzCleiiLkwwSaZXOVsH3+xbIpB6w9BQ7i8ozDFxz/foHoS9arW2kZ77QwMp7xpEMvGb5lIVimU6EqlE2WdTuZANPorbVNYHmacwTkabB7Xznt6Nnqrev0EOgqQduxMDnLUd3h9ffOPMUtRYo/VQ9EPii6rD3k8ak9laB8CeocnflDvcDULNj5gTbp07dP6Rmxo+nDAtM1zEt+SDY1K64Jxc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bevWxlpwMvmJW025kxXOWVKvtFIHBETf4ZMhsVd3XfRhrXZaR3lUsidgjV?=
 =?iso-8859-1?Q?PBZ/gZyLVD9lRsghmQa6QHzHY5kGIXWvGZxzBnUvJ7yc3Vc7wtvChz9xqD?=
 =?iso-8859-1?Q?sU0QjBav11XhQ7ZBePTfy4zmJqoDT5uF+0RQuH7izCuCOxRUvKRZq1iJO5?=
 =?iso-8859-1?Q?wgaAe9YTNi/S4UpS99rcztzaoDXolrcVV1xZkQc8t9VQgOg42ewEpHvgKc?=
 =?iso-8859-1?Q?HmDiTlRQQXywxCIx8n5hxcJTVXe9dXPpCMTfGmzR6LXXlJdab9o6MhALYM?=
 =?iso-8859-1?Q?AKBCjlgFFN8gnabT9uuMLg7oBzMObgHy1jWS/GNZi28EQJ+bcar/3GKhVs?=
 =?iso-8859-1?Q?OjkU95XkeixI7F8VIxfDsRA6lsL2xvVdrZP8hft/+XnwlZa+M1TnwziFEN?=
 =?iso-8859-1?Q?HQRtZRWXdxZ2t1pAS99QGO4h0WueHfQKbypvvhFkltBS+rRlS/flQmMlCE?=
 =?iso-8859-1?Q?CeIoRYT8MlgTcR9R4185r2ewzAq/RDebUZCMMSCLi0b3u78uuhdZONTPQH?=
 =?iso-8859-1?Q?MfNPuVZv3oAbnGHRDfTZVMLmcaS7lH8FvSo5AA8pmFrbDtiqk2L6OzDjjL?=
 =?iso-8859-1?Q?u4IvCkmhUiDwL6gE5ZY0cRMXc13qGWSkPmk6SM1tXDyV70nlXzy499rjLe?=
 =?iso-8859-1?Q?jSQDaNYXkApEo5/pfz3AVAdWUrCx6yVwFLHevm/m3QKf7CTSokoibESslr?=
 =?iso-8859-1?Q?6LXxm+RV3vSNnzcTI5NB4kR3m5juhFzWgelHuFwh2Sn32OR2Ki2yMvZfUT?=
 =?iso-8859-1?Q?zERhVPgZyQ0axLRPsm4mx/jAWd3PjFzCWoB9TiQPxhdanK9OxYFK+dPo24?=
 =?iso-8859-1?Q?XN0YBRb7jTET4kA0ZNeWUbtLFhODsxOtBdujzFcGosogwK3fR+pO9KxxOG?=
 =?iso-8859-1?Q?skgiUGU/4DJ0A5Rhj3+0KI8TQwF6Z+VYazqs0Aq0UALdpctx7Vyxl9QFvm?=
 =?iso-8859-1?Q?6+RxnFa2tsmYhC0r3r2AOyJqSgYYSQliPwsq/THMJxvDA7mt1e054HH8aj?=
 =?iso-8859-1?Q?kI10i5zUK9PfrEZRyVE7LBtsLHKFUT9XR1CtoUSNdaqz13WbK1tD7qCS/m?=
 =?iso-8859-1?Q?600SmC21TQgpIIxj8I0dwFdfFspfMucccmWBv3XZPn9YBT0cg9aGqbHq8U?=
 =?iso-8859-1?Q?xRFPBbDOUNimIICj/L+Tfv0iBRhP088gxG62hz6uBciiHBeDua6Ib/otZS?=
 =?iso-8859-1?Q?Pq7lZP/YLyIcWKAjU0jq1KD7tvpbpq5woNkvHoj4fpnCIp64/QLn6OlX8f?=
 =?iso-8859-1?Q?OeGJm4MeRk6PdDX4pN7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b43809dd-393f-4353-3229-08dba4abcd5c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 14:09:59.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I already updated the concept used in translation of the arabic Deity t=
o Tah. Seems a perfect fit now.=0A=
=0A=
Interested can see some of my research here: https://www.youtube.com/@Ac-Ta=
h/videos=0A=
=0A=
Also something I thought I could mention in these AI days - Could AI help f=
actorize code into functions that can be made in hardware? =0A=
=0A=
Something to think about,=0A=
=0A=
Peace,=0A=
Ywe C=E6rlyn=0A=
=0A=
