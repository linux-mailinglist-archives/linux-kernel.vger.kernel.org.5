Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D67C8E63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjJMUhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:37:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137F83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697229456; x=1728765456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cs/WEr9zjLMZGb09W4qW54rtWgSUzSmVTLxf1JGMD48=;
  b=oPQ7+zRnv8LAaDnkE8srEuYnzAnyDumeImj+IRd5zsI+TNKMmBt8IJBw
   oyRfe1XMdEpEaf830zS2KEl+SUimeDt3MgHvHPJsgVUOAPmaLqPIZh+H+
   +9RqWorRCB0k1SVmKJc8irrQV1DmClnwvfyPZp8Yzz24u2lULioRL9yUA
   lvq1ba1uKul8xfsT7JeBPFZ/9VKx4TXbWisj/9F/V5m/KmCrHz+V7KSEb
   J7MREormDR+lU07Wys2ZilK+AbUey+M/VLrJkPHEzwBLHbcGpmx5Z6k1d
   2W01mDpSgQ9u+8j8poZuY89cCrvqGG1wtGGWBz0Z3aWPP1t4T4Nffe8Xs
   w==;
X-CSE-ConnectionGUID: OVDFoFTYSKauE/XLA0QJcg==
X-CSE-MsgGUID: 9y+L3/5DQo2I/sMmAGLgFg==
X-IronPort-AV: E=Sophos;i="6.03,223,1694707200"; 
   d="scan'208";a="244604752"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2023 04:37:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeekGxLczENq4zGnIb5NaUEaUkFpYR6a//fS1SQrHeRTyEy2UImILi+D6ZTYNAPZNXfytCfp0veunrc8PEX25ck5FswNfrfWjCIc5Ow3cfhwiKQ6zfwfjMF0uiPiBJOeVp8Sz9hq6ocoiqIlnIn/CW5noRn5fhddKDNHbblvevLlmisdOmD9gVf+KGGoeZ+3RXfcd8DEZQGDWEON1ynO8cFCLY4btPNnYy0PaPcdJ0uYxNAcw6u0M6mJXN0LOlyXuVdr+v+pU/1LlwVfbnUrSrWaCSsYJ0lldIP5M7RrjaVwhJg45lOUII5UBa7BnFeBKLcp77huw5x6RxBwfmPXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su6gYTtqB/TIjJTrdGRVgIHtAnZ2PAeGzvzQpFjuTvs=;
 b=QpQWY54hUHRgZehn60LpsCNS6i35IiX3JxU1Jo9qpZeAvhBJJiGffg0fwxJJYpFA9n0p1vzbcPmTDCJz09m6AqjOa69HQSJ9CwlPmZonKgk3tbyWNw4aesQLY5N5qzhDN4y87ryzdSNqx9wXobNIV0Tjs9vM8WzCe6jP1kVajGLpYWqHCeX4TLdZ19sPIYS8bFEEmQFHrDtvko6S1udAEzcCgV+zJHQhA855NzISnzujZS1L+6MCNtQIkQeO4yM5LUWxUbN60q/3smo5DCvBaQMTvYCk0TWjd6QoD4U47yXwV5QO8XLuiJIRq+g9CnlPUmSxQb0tbljgxHc6S5cYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su6gYTtqB/TIjJTrdGRVgIHtAnZ2PAeGzvzQpFjuTvs=;
 b=eot3QORDpuTcNJnFzmGC9o3g8Jhi2tCaIR00F8CJzVr2VgNZWgINMRkJ4e/mkoYb+k205iu5PFHDQULrkcLUxjhzydFS79EA70dF5KcgG8eUVhiasrPdsvJ7iZa0U+9f3/rktfQHbZhFJYZhIidvjgwRQL8rjUj4GvrMFpSST9g=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB7113.namprd04.prod.outlook.com (2603:10b6:5:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29; Fri, 13 Oct
 2023 20:37:32 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Fri, 13 Oct 2023
 20:37:32 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Thread-Topic: [PATCH v2] nvme: update firmware version after commit
Thread-Index: AQHZ/fL8/I5yjhJHTEW4R44mU62q7LBH7PoAgABBTYA=
Date:   Fri, 13 Oct 2023 20:37:32 +0000
Message-ID: <ZSmqi7Va4CkpQ4zl@x1-carbon>
References: <20231013163420.3097-1-dwagner@suse.de>
 <ZSlzxGx8k9pgkhDk@kbusch-mbp>
In-Reply-To: <ZSlzxGx8k9pgkhDk@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB7113:EE_
x-ms-office365-filtering-correlation-id: 002a9fe0-43a1-4499-f275-08dbcc2c39c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOOyzRJodQjtvQesuAAaozqeQzKu/eO6aDbwfo5xSWsrf0Dsol2IqmO2HyvqtUM+PQTTzBhH5HlYm0absiEgDoGWOQXxFlZMzM8lu84vejrIKZeKhUCRFPxyjH5YF/smt6Cv0+4t5Yfo3pfdnltOQic1YL/6PI/X2MtIpYuo+bLY6NoKyWSBCIs0etdwWLGHgjsJq9j62IOku4XC7nwALBqql+ARDmqVrgppjNRncixejxQsoEeabPU5OMio2bQbZep7pwtB/k2wFw27dorDFfT5eFVZCKSf9ipIFVia4vC2m9xOdX+L04W8tanxMKZXc0OQ0QAPVzhFzaLz8bQeJ0PSTMFcvg/WU7e362PL/mjXimS0zMdUxXy/wUl9k/PfG7fa9q2aYrqRpkBquLns9CqtBz2DZjGsQ9jkGbXoxg5Pc801LdjzMT1tTbZ7Pi8lEyIEZCfA3zVujEG3FBNV9+zmxvM/U6upbnJc/SwGWrBGsMQk5UuoOsgqJFNYBlsXPYdyP2zPVSj5D20wC1lNdJwzxUK27oTGFayNg6yXC/kvmyewoK3B3LxFgilJnl8Z2IsGs9I4BsCClRMTqLTEs6FDOY8duvTOK8Ew5TzlGCF9hJLnIKCLzcy7t/ZPAIny
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66946007)(66556008)(91956017)(64756008)(76116006)(66446008)(54906003)(66476007)(316002)(5660300002)(41300700001)(478600001)(6916009)(6486002)(6506007)(6512007)(9686003)(8936002)(4326008)(2906002)(4744005)(8676002)(86362001)(82960400001)(38070700005)(38100700002)(122000001)(71200400001)(26005)(33716001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WXNde5035Dafh7yGF+HiouswCRNwjitEgZRc9G556sqclHqV4fFekYURf0mD?=
 =?us-ascii?Q?n8NDqU/NP1EOYrSisxJvjFvLDq/VZn/r3qHcBweAlpVZ/QDmXaAk0lVQI6t4?=
 =?us-ascii?Q?CThMjYenE5P3uQBuOaqcA0cntEsa1zquW8fPAoILywMmuPH1lXaY4URuOapm?=
 =?us-ascii?Q?VtJSMRZ0I+BqXDOnFBzWITfkfVsPOa65seTTb6XArD+zqCFVjE8NBZeV05bY?=
 =?us-ascii?Q?C0w8qdM1mURn6LSmAZFC9D3Rkvz7J0noYSyI9lf/U0wBUibO0EARB7od8D8n?=
 =?us-ascii?Q?uXkV4JHcDJCmIS7HvO7CkyqoWD7aoSznzz+SvuLG8kPMa7tVYqOpWfO64dqy?=
 =?us-ascii?Q?yXylgsybUcKEaDTxSeF842/CCtSmMuCAX/vVntzU+ccnfAg284Z3oHu5mf8u?=
 =?us-ascii?Q?x4NsNKZG3uVuWUvnMsh8h7/RTctKgAIWvfVPeF9yhbqrd8rcO4MvuNnNsVgs?=
 =?us-ascii?Q?j0LVpCaWA2gTa1ogGU84d/a4h3jiyHenPOH02XbP0n61uXTPAxsd1gmLkatD?=
 =?us-ascii?Q?HmmYMpTtj7rmS64yz/bG4hFw132P17yN2p/RLAeNxHlhRBdb5sSGiZNcqbh2?=
 =?us-ascii?Q?yV90w5tjAQuyFpuIZ0iZIJ4fRgGYSB+CYCK/yQ5jiFiq3a0BL9jSH8kUw7oB?=
 =?us-ascii?Q?xzD6p+EaEkQTPVGoU+cpcLjTKTVegxepE8Vc5MpKAqPwTUzo9fOgCubOaqwt?=
 =?us-ascii?Q?mxFqk0qkwov4h3rvI9bQjzdmUhrcFPk8GIj/xbw+1iT7Ec3z4ejGYCguJ+Vw?=
 =?us-ascii?Q?cFWawGyFrTyiNN7IdJXerIQAlbIsssthqK/jyyMpKaD/zNYONjG2YdBa58L+?=
 =?us-ascii?Q?+VUPHOH1AMgzqeK+sz6NYOOAPBNDVlk0gIrxryVB2JyCyIrOxiCtwEKrm6/v?=
 =?us-ascii?Q?mJ9DvftWBgzFSEmv58gAWX3b2JJkMZKxLGT101ZnDP7WwKx2x9BRWc4O7Pwo?=
 =?us-ascii?Q?2g3BvIlptnofwFywnFSQHsMjdbzMT5zl32yfo6rZIUQKaG8WSxjCsIphH45T?=
 =?us-ascii?Q?lUzETLkPCAo4zwQbVccYJ5vi6rokVDd4CNBF9xczSZqBbrtkxiWNnXLYCk+O?=
 =?us-ascii?Q?Tx3o2Ycs7vIIBSiehQ+XwfOzcc/yBCNfGdAOuqpMyfUXMgWxchce16mSYiUj?=
 =?us-ascii?Q?mkSmeb5iUN/r8hW+KQp+beqLxYChd4pZSeskewH0Ziq6ZGwX7cNH1oQ7Nysz?=
 =?us-ascii?Q?Ra96lhA7C/JlwVqqy0/0fB8jl3I8M4n+FyTSP90jkKfElPwK3MQ1w2/c9NGz?=
 =?us-ascii?Q?ZUeZH3w7cc8NTOQIrfVbkPeIYJpCmFfPfzMKUwO+R01Kb3BQPZ+pgAw9S9Ob?=
 =?us-ascii?Q?jbeHMDlHURultsDFbvtRGK+4CXSlKcQIB5XuCJovGF1G8S5NEAkNbXtKuJA9?=
 =?us-ascii?Q?s/qs3D2tGUbJ1aKNn58BvRYuxFvR4ZZFt1JPFGnCvDlzUCS3w+rl0MFLI3wt?=
 =?us-ascii?Q?oqd/jyP60shHL24r4myBvyPp0MTsu6JkBiNWl+FUxqoNpi1JreX3vYJJT8/6?=
 =?us-ascii?Q?94SOH9m4bc54tR8Pq+yu5+i6zyWHsoZhnMN1j4WyEeJR5suSDDY+0gtJJQr7?=
 =?us-ascii?Q?8Cui+6cNc52OPNsLIa2DojZ3ysoO2ZCGhDNVgJl/fUPpJ2FwJxjy/jliVgjR?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC92A94F3476C5469B045F9419EF02C1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DXA8MfSVIsuHFiO/0jDU7sxw4zkZFkAAPOeBwAfxEVAj+3J+kxRWBhWk4pcG?=
 =?us-ascii?Q?QmZEVsPhtatpkQjchYtVdb84MmznJQtD5N2QsqTkrdhyvenL3OTP9Di4miJk?=
 =?us-ascii?Q?FBeKchpYTKgaP6JUaqvHepxy7ts0hsars1fca2uGvyMSUNL/dtFp2vOScHJ4?=
 =?us-ascii?Q?vrhJWOfrKws61PE13BXiMMk9ULkr/3CTobhruQA46B5qtYNqfT218daCxD03?=
 =?us-ascii?Q?9yW802zBw8X9hd9H5pm1ag6tNTU0VmOe4cdFieYEq3kSrfLUM9X2hwY7xuEl?=
 =?us-ascii?Q?9pChffQJ7orGiC5wZJSFFUYZaQENyZTjrYCagQrXWcYDsbBWsHbqzRsJjT6C?=
 =?us-ascii?Q?43s4av6PGaWxy5PNh+Kev1LoyR66PUCuhF2enwuNIhwzRNy2s8pp29JXsJQU?=
 =?us-ascii?Q?c9DcIcCMCnFKpqbU/vHHdmhqyhrj44JbN+F6j5Kwr55mpR7iS3rumE2uu4aM?=
 =?us-ascii?Q?aIT464R8G/e/jJdWFTI6ylqLpYFQY9AQOdBFE6M9/3BLcLkLOZ3gzffd3fa7?=
 =?us-ascii?Q?14xgcWt5+qzdfi2T4tFOXzrtM4XkYAhFOPVpYy7jn3rSKgDeLBMeozHGBt3l?=
 =?us-ascii?Q?PLeHLaPEvNyjXUZpUpOorcAuWdjoygQfAYWAHDTO+mv3XErOWI1T1tiMDjGZ?=
 =?us-ascii?Q?/xLD013vE6h8V9P+DY426b5UmL5Q4IZ4MejN8DXxSFojkEvE68sRHLpJ0JfE?=
 =?us-ascii?Q?myrsvLpWfeHsqy4CGeyseI1HyQjuOzn87BBJYAyKGs3V9bP4ws/XtCU7N/P1?=
 =?us-ascii?Q?M1Cd1A1yLGy8lYx+cbSEHnbYJNHGEvvlMNKnyevDrjwF5zMuaZlbwycJZrJl?=
 =?us-ascii?Q?X6tetRSA8QYGCSDfsN7tKlG1bLIy7YFj682/i6aBjHeTA3xkKxllN8gzVkvJ?=
 =?us-ascii?Q?4nGfWD2cbZIgOdAqPjrmYjIoGdt2Y0vPx3v0SsPkJXQuLeCMr5DtAKj0TOFz?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002a9fe0-43a1-4499-f275-08dbcc2c39c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 20:37:32.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+To8SKA8VpSEK46B3CzSUMFnm0oJodwKjgQFgmH8ckaFT3WfDcZLEnvI5uXFO7ugxMv4pI4zyUVZYDWo7pTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:43:48AM -0600, Keith Busch wrote:
> On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
> >  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_N=
VM,
> > -			log, sizeof(*log), 0))
> > +			 log, sizeof(*log), 0)) {
> >  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> > +		goto out_free_log;
> > +	}
> > +
> > +	afi =3D le64_to_cpu(log->afi);

BTW, this field is a single byte, so there should be no need to
use *_to_cpu() on this. (Byte order is only important when the
field is more than one byte.)


Kind regards,
Niklas=
