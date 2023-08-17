Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF277EF43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbjHQC7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347722AbjHQC7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:59:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1910E;
        Wed, 16 Aug 2023 19:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692241141; x=1723777141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u08ZK1i+HssnOTSEXY+SjzZJRjzVIYCYJSTjIlHhHlA=;
  b=RccGedUyQAXYYcEOg6yYJS7nFCRWpOP0LfoMPFJo0VJoR8DwlJtQrt6M
   vixullDeIGOIcZdgmlvWz2dSOy/XxLXvWJM76+LFOPvcvq2dWMyYr1kFT
   kcR3rZkVXYjEQAtcD9cLKzuukSHdhVHZw3tfopI9+DJEcuo6SBg4iIWE4
   H8f8r4R/iKlX5UCj3uS+xo7UKVbOVoMS6+93J/u9HSBu9bkamIZXq641H
   CXNdXHcIeK5vWwlE4U2v4wgZrS40x0Rz8RqhL2UfqZMbkcRCdmjQrOXEg
   W15VQixFfqjXC/60weV+Mva2PJi2WpVUQDIxhna2236B7spqAPU/ErsuA
   w==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684771200"; 
   d="scan'208";a="239599561"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 10:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5MsoaEYbWLSweJPYziqo3+Y5jTRXpG6C7ijnweBmzFjJp4pflIGBgV5+Se8yWT+J+dcNp2SKE2LQWkC82c4CIu97ETyFgvz8A6HYKs3IChX2bgMPXp9bDYAXWC6pRagvK/ZeOeVFzwcyjLuzgJNqRhQS7k30Duw2Y/zuOxwZtJU7KOu/UTgIJvKQOWasZZQRhoqC6bGBlSlQRQvNLkETvbxiA3V24aYFrC2ne2iBubNka4wAcst3SNh+YEF0WrP5w4OQsP3WjrrLGE1cbuiAXyInaUr5h+EEH0sFw9IpcO2w0dy6uNanbcBKT9bzt+/t0iU0D7k1Mf0xd1J/L8kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u08ZK1i+HssnOTSEXY+SjzZJRjzVIYCYJSTjIlHhHlA=;
 b=kFBJ4b3yt/pw3lcqKV3BiM1CsPo3o875iAmdW4WBHN+BbTzap8tf/UYFZnheTcRrOVlXdZ6s1nAvl5e+zwQt+jtBdlSyOESD05p17eGPJCnQEJOOf38aiJWaavU6G7NsNO7xLIFNmUK63Ssb0LROH8gCLf7ZeEh4stWXstzeD1SjoISWx1wtPEdTKBGUe+kwRkEWIJsN67P5Y6fCseMCkhOrfAyfv0QAvYCNVthjM62Qrisxv4PbucjLY4stagwZXr7gwfn7BNJ52nBOAj0eC2N/1aRpcW3KSSpQyr04IrZuKza+AWlNmTGaAVQOSm+L92DeFIkMPI78W6WHaFX07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u08ZK1i+HssnOTSEXY+SjzZJRjzVIYCYJSTjIlHhHlA=;
 b=jXVHPIjxD7R00B9FKpKe3U1g1qe8zjfcPL8C4YJJkgh3xFEzb7NpMjCleTfDqcvtmeBdgMj9cRrSC6GJgf9N2AWVLxgQfmYXEL0OVAbDruF8IaitGEq03ELQLVtJCsQ6QTGjxsou28O+3ImvrTHEvZHw+uwT+pbbmRoAQSpPvW0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7429.namprd04.prod.outlook.com (2603:10b6:510:8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Thu, 17 Aug 2023 02:58:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 02:58:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Thread-Topic: [PATCH blktests v3 00/13] Switch to allowed_host
Thread-Index: AQHZzDdMs3TsBo7WeUCvxoTAoQFlvq/oVTKAgARbUgCAAC6ZgIAA9fwA
Date:   Thu, 17 Aug 2023 02:58:58 +0000
Message-ID: <ly6ksjwuh5jzju6hsvos35b7rmj43gpdyjbp23s4qoi3ups5eh@zx2s3bkznujc>
References: <20230811093614.28005-1-dwagner@suse.de>
 <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
 <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
 <ky6hb7se4hd5hgvwd7uwxm6pxgznxo5jp4fjr474qf3pepoipo@g2g2wtb2hvn3>
In-Reply-To: <ky6hb7se4hd5hgvwd7uwxm6pxgznxo5jp4fjr474qf3pepoipo@g2g2wtb2hvn3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7429:EE_
x-ms-office365-filtering-correlation-id: dcb14004-f4cb-45d2-a5e4-08db9ecde752
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMzOhNLqjV1QsJMDojudt8prhR8GfZ+5w6dx9L3qqvb9qfHjTbYXAxPlA5Nj9gvP2Fzlu271mpcLM6OYQOIVCdRou8ZQSPWeFKuoLYpJsFP6X1cx1OiDsen5icPvn7utaceO6/FYsKnY6ewN6FrT0Uvwh0qld8WMFM9//QVBhBBR5qDaAM1VVmoCKP9LjPadjHuXP/grkIhS6xQM/uCpkqPqZXh2028OqLxRv2wRNH/LzJW0nh638XvdeyJJMAeYZ8X5B9aWVC+dfSWl2fY9L9PakQBpSMBqihTUjRthpu2XM5PGN5Fkw+v22hKl0z3Z3MEIiuN+jYGioO2sXiy+2KqpFw4GgJOT4eK5R2gr+k5HIqu8HghAUSghozgLJJvMmoyTDCzSlpsFoSsmT1EGPDqf60RldHpFm5XoxeBG1/Ln1u98EN2cG3PfUWxWi1uMnAYOq56XpoO/hCJVEx9pi2HgVe7T4KyALkR1Vf913CtqrxP4fgCOLNp+Ri76EwiBdUDKrrGoLukD8+UuRyR4y6sym7tAyt1P0gJrtUUx5tjyymI9t9vG/1MgNyx1oX/mh8dcxYKffu0U4HhrlRUmTtaX6IxuIfRINsMey4XNNUnxxPxrhkFHMYcHEwudsQl+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(91956017)(66556008)(66946007)(66476007)(64756008)(76116006)(66446008)(122000001)(5660300002)(41300700001)(44832011)(38100700002)(38070700005)(4326008)(8936002)(8676002)(33716001)(82960400001)(26005)(2906002)(4744005)(83380400001)(478600001)(7416002)(86362001)(9686003)(6512007)(6506007)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MG9Ff2RvZvNrJn0APU6Zg+gF9WXJtQiM5qhOeHHde6gkSu1Mwv9ei6PA00cC?=
 =?us-ascii?Q?u/cXOnQyoCA2+7PG20VAHQQ8sYdPcqMiMO+qPWqgZCwLyxgcnHqQX3hfjpop?=
 =?us-ascii?Q?pdv8UPE8/DbS7DTzkttUAhzL+Lhbfa49AElptHeoJDUYdiksjWcIAzgQOjGs?=
 =?us-ascii?Q?xsapMi0SfLe+IDlxCIs4U1peL2Y0qLlWgVhgOL3j+D1sFn9lCAQJAzMV5ZUU?=
 =?us-ascii?Q?E7zMSjAbN3VKpgQPubXw6LaRYXlQFuuWW0MKEq9L0bL/+c2sMJnTuVjmqbOO?=
 =?us-ascii?Q?zvbszky1NgBGJHgd3ouLJnH/pKUg3yncRsDsIAy0JxOwJ8mK0cSzgD2hwhrd?=
 =?us-ascii?Q?xSCbULbU8Hu3nzV+8gV2KzuZLMQcXG119cFmgwa+Com5nyh0rOoMAZ3PeOiF?=
 =?us-ascii?Q?ewLCv8at7lGyth7daDkbYIADY6HCoMa1/hu1YvtN6/WXsZyDj7r5Q5QHsqYX?=
 =?us-ascii?Q?64sgnnvaimF7WiGpJfJwnQjAgfu4ik6z1QD5vonS0jLXcljKoe06IjIZFNJJ?=
 =?us-ascii?Q?c3R9Z0k8P8I9p2fqUoCgihcklLi8fx6q7UyYWR1SkpIwylogQU6VJHXb7DC2?=
 =?us-ascii?Q?wAyAgHcw7h65gdfLATaPnAsAaVg/LfAdEMrLSrVCwx90cVsK8xDVNsueZ+A7?=
 =?us-ascii?Q?gijLXqRIrGMSZoL+FU7AkqqrFfdEMEwKiWHwXEq+dRY1GXfKa0oc3ezSuq1c?=
 =?us-ascii?Q?Jz1SteQrOsXBaNaSXxup3wXrZj2Efn01f+3ozG9NruteD6VPQLGap4/I8zgv?=
 =?us-ascii?Q?V77niyMqWMHXoYkBu+9kWua63nhPsVQ97vEEZ+t8onyHADRlvqEj5INkBXsR?=
 =?us-ascii?Q?T8VxuWpFf7A2dIJ9KUDcgY+Ekrw7vcD7pv+kv6cFCuQN1YQUvEwOcpW6670C?=
 =?us-ascii?Q?XNQ9fPwDucXSA70QuKRnnR8y3wG9zF01Aky1TfoMu5x9UijMiP33jgmlRh6Z?=
 =?us-ascii?Q?fk3z8PLUVq1HURR6+LRAk6e345uHDCwv/ecBXSkySEkucmlWzzWbubUX6aMq?=
 =?us-ascii?Q?EDZTe/jmnTgY63oFkL8XBN2rqT0vIAsU4hJPjFgrfCviOYdWIwfHEN9C5tGL?=
 =?us-ascii?Q?871+3F+qiEZXK3i0l+I2lrowY/OGIeFlNMFJv8HFw0nAhWAW7CVC7injUxng?=
 =?us-ascii?Q?UJqL9CsCHlndjCxXlvXDCdu4k5wNCtFt17JBUHoxUHkCaMcMr9RzuRIZc0so?=
 =?us-ascii?Q?8gzgW9LkfVsItT32LcvmAIL9UxnJtaGC4cEvD+JXai+YpjSQvXnZXDddWfaz?=
 =?us-ascii?Q?J4VcY0rj9pC11mnsUfwUXzZKgOEKY6RbofqzalALw1TfF/+MUv3ErEvDi6zL?=
 =?us-ascii?Q?PbZVUvncnST3aoUm00mJ8pbuHXuNBV4qFQXc4Rea61D8W5O+NA45Qq70rgHK?=
 =?us-ascii?Q?alkerH3I1ehe5Ovia3rPPBV7I3alkhUZWxTMe06JaqvgpH7MhYTz+aCW632o?=
 =?us-ascii?Q?7PWvsHc2FtdrX4BHRnUqDgepGy3+JTDDHZlEj4Oep7FH7VI7Y5axvTpYkyOM?=
 =?us-ascii?Q?AqpJ74R1EgAEkMX7lat/Gu6Nae3NLSL4OHLejSGH+uc8M7NsHU08ttnoUdEH?=
 =?us-ascii?Q?W0CizODm5y9GZcSGDCI6jAN3gnpTH4lnyZwyfgWUq0jITYL45WfrVKlRS2M+?=
 =?us-ascii?Q?rqbdPjAkOqzgBJxZSrjpT+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3491DCB0D163CA418615C6ADB39164CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oTRVa+m6qH2QC1xQQu1Lm1N/m+P8l8KoXW0o5zJSTOJMwS8264xvo8oKEVGN?=
 =?us-ascii?Q?nU7UwgooxDDaCtIcZIopSv7Jcj7JDzxjpWHvmGYXysfQ0zY8BS0HsDBG2jzI?=
 =?us-ascii?Q?UVNl21TyPWsGEESzraCtJYx4MyTepbXlGh7S1sF9I3YvvcSpvsDNO88W/WwP?=
 =?us-ascii?Q?ARZr7KJOd2S3DogRm26u0MxlNJi+oRZIq22VslI3uAhkdhJ1ZgvzYmN4e8Cf?=
 =?us-ascii?Q?bKoe8t9di3ISb3ybQXXWiuyErKmHVuXStZoPzSMP56DbvhHPPBRnZfOwTpda?=
 =?us-ascii?Q?HvxCkfsojVAsRUV6Qgt+8JJN6EqNwI7945FIEqXDswN+MreQ7UenZPKwP1bd?=
 =?us-ascii?Q?Urz0POapts5eE7TtsKCThB2FFeYmBnepDB5GI0/HmN1fHZ1D/SMnr5iot1c/?=
 =?us-ascii?Q?PL/NYkTfWtZGF+8QrMpw/sWRNYBaeNvtUoZz8H/d7SO9aeW0Q4ARcWpJiXhW?=
 =?us-ascii?Q?nhBUM/4eZkLmFQthTNwp9gjNfwLj/kOThl2PxgPGBTzuLF/nLMYtLtP+xNQW?=
 =?us-ascii?Q?ftXFm03VeZpmlI3R6kOXihGXQcJQRPfVtQBkKgN90I6Nl8GaStMfNx0FB0WS?=
 =?us-ascii?Q?N/APW1gaMXhjNlap7Ay8s+Jnxf9AOMYDbJmtx4KX+OuIq1px1wKRIgcU1JSo?=
 =?us-ascii?Q?WnHUvhA6UFD2iTaZHcTY0buOLiV1vUq91KbJGLXlNu0ITR3FxwRL4vqOuci2?=
 =?us-ascii?Q?mDbeGUgpqz7ep9+wjkAZinPVRsIzVLKW7ZaEPq7FLrNV7RIBgN3qTjFnN4ye?=
 =?us-ascii?Q?uPsyDUoXNPfB7gAakcm4tRiYAGLXGbdaM0SgUBdoGkHVAKdSDsbHVBq+lHuP?=
 =?us-ascii?Q?tPFT6TayqWPowX8tFLHw4M6Jvo2Pvwh5Su6zZvBYP0mFg90wihm596NhdUkD?=
 =?us-ascii?Q?5mVlu/m3uUg8tJXMJtr7K/1A2ksb2WRmjoDFYKaRRBJ8DMp83kHWav7/bipV?=
 =?us-ascii?Q?JPyKUZDYDfnQUZyqX4yuoQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb14004-f4cb-45d2-a5e4-08db9ecde752
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 02:58:58.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4Mpj1XvoMQ+Oolx4yKpQL6kocFmBtiY2d3XMkDw3Akxkc/MMQzNrkSO+mNu8nymoj1R6q2mAqZ5icuMphceoqLvSXfRlWUhOPDv8hKdKq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16, 2023 / 21:18, Shin'ichiro Kawasaki wrote:
[...]
> I think the 13th patch worth spending some more time, and other 12 patche=
s
> from 1 to 12 have consensus. If there is no other voice, I will apply the
> patches from 1 to 12 tomorrow.

I've applied the patches from 1 to 12. Of note is that I added "export" to =
the
new, three def_* variables in nvme/rc to avoid shellcheck warnings.

Anyway, thank you for the clean up and fixes!=
