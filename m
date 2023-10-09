Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4D7BEE34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378902AbjJIWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJIWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:22:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4A9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvRw3eB3fVjej916cD97q3lP4Em/kzHLzROYNczUNtz3qDUJOROoOm3X9zwrgwXAlzCLwwZa0C277MkBRROpwZM0PgOZu2zWncj+gAP0mq6ibC/VuqjL9YaW3OnHiAu0HaE7tq3PUURjtT6n+a9OIyvNKq/FtEiLsjd3nGLQWD7q+X9TGp7jAhj/WtOQAuCxMgAajzlxDFZLzaSi4OS2sNzPLAt1cdZ/9K8oWDjsKEtdvbq9VBhlIPwNUUSCiAJQ5hdDCsHCGVSW2gwEbsPRb77ARWpL7ScZrBNmAAtzWX1uNooa3kIkSuLZOF5S03SAIwbl5gAtmZn049FQcvmLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOUhl0ZJKimcg0f/PRvV2xvmojg8INli926KGinV//U=;
 b=cuJXW7LH62b2Z922/u1iQyXNvycAymfLo7Pi78IzcPnHyMHNnmMg5xd+wDheFP5x5+IaDsE7HRt23HRyP2+VTkoVFeuNdPy8ihA+Hlv0h3Dfekb1rg8X5XYXw5r3uFCuJOtXCzjl+PINBAYDpEs4gqlAR64/uIVhDzrhINiKak39nNyy1VIITAmIG2r2ukNInO6UK2WIEpIUkJNCcRLpKMkjS+tKxxVDXMSx8s7h2XHwx6ksk5sl/AZuJviyRXaxi6GlM2gL5z6IUNYRFNE6E1kZBmvvG/x7/EM1XnV3Yc+X08BH5WnmRD1XH0bEU/Y6X9gMdLmo04HlFeyM/Im8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOUhl0ZJKimcg0f/PRvV2xvmojg8INli926KGinV//U=;
 b=RXNuUriakoFyLrTHMgHEt2Llir6V1C4nCKE6lnxPlutBdismfKgQ3N3zGES9sw61UaB9SNRCKR+1ayuB3NVasFtGqrGGGRweXeYqe7LKYcVeDYivAUVYKpOSqo1V4o5J0Hz2QCyT2e5RfJ/vibM5dmzfLxGxzh0KnOjCI3m3wktCb5XOjy1hHMMrRmtJ/i+svYHJN/Kgizuro1oq/KRnvpg28ZRnVjgEbB/f/J9arF5U9XGr9pJ6npM4jeB+NHT1jAOIHwgnv3yOvFr5Mo3DAUkTngO5JVsbSHnkO8hEKboFnciFfqOBibthzvtF5lNz7PrJhJSzPrLT1MIZ63fmtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 22:22:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 22:22:19 +0000
Date:   Mon, 9 Oct 2023 19:22:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] mm/gup: make failure to pin an error if FOLL_NOWAIT
 not specified
Message-ID: <20231009222218.GD3952@nvidia.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <c7bfaf30cb682b92766e35ec85d93a84798b37f4.1696174961.git.lstoakes@gmail.com>
 <6161e8a8-64a4-c4ea-626d-daac45ccd836@redhat.com>
 <6a421da0-8479-4873-8e46-6f92aed342c6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a421da0-8479-4873-8e46-6f92aed342c6@lucifer.local>
X-ClientProxiedBy: MN2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:208:a8::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7fd0f3-7fb5-44d0-38f9-08dbc91633c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AXyKoLNzdBMcUArKdMRS3/dsSwtpL7XGRanlZOmZu77nAs2IOqxQ0MUDctagvYlEVCEKAYtpHcp9Ks32nMJIVS40OyTmHl35xmUpyldWnsdW+0vENA1gyWI2ScvfiQLWwE8YnJ1t+NBo04auvbtvtI1r3Q4htb0VG5QY0RcGdovbXXjlVBbwPT7UECq1mfPVS8qCK9pxs7yboSGisd2GacvqesBc2BPWOOxXY1B/yCWiaG8IT0Xs+jPpi2d01XEkYFUK/hkKGLi2q2D2Iged0d+ErO2Zn9hW21wfEk7eKok/0zyTV5Rak9Q7EJNVARsDBt2vX9Qg/uWNNIsnjtwoEdq7sm6PrtDH14siFZGhDK7496bYwYk86TwbaRFzOXnispGOp033R6HwiGF42nWgSJmX8XN7OhRj7LV9MzJ/a9WnMIhXNvjVXlNrLPBrw5zK9T94OKDFO8ssQ4wxgWRAzig8/2EqDpzmAnwVG8+AWWs3Uxqz/zf0VDJnuZwNi/2yh6Qjj/36Pb5mRHKQ6HiiETKKTx+lMcQUtaifCXWtA/K0c72jUR4G0M1C7QcSTrA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(33656002)(36756003)(66899024)(2906002)(6486002)(6512007)(478600001)(41300700001)(8676002)(4326008)(5660300002)(6506007)(8936002)(2616005)(83380400001)(1076003)(316002)(66476007)(66556008)(6916009)(66946007)(7416002)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckN9rdyxDymDRSx4sj7jUdNrnCjbY9utkHdEHLvKmkH+axyycjWZV2kzVYVO?=
 =?us-ascii?Q?pkAnA+gD7d8r0ESROhTex56YP8jNhZmL7e/O+xOoPBWPv/YMqMk3u998T8jB?=
 =?us-ascii?Q?sM608AG/wfhnU59yrWzlg9ZtiVvtUQ1NMPpZse9gssxmGYhrDEW5Cgm08NHT?=
 =?us-ascii?Q?YUvbKYvaI0Kjvg+7OFIy7FxUtQh6rwTxA1czv0bNJVaFx9txgvdphgGNpfl+?=
 =?us-ascii?Q?33Wnpf5RsK45raPMyWQEgWLaatxxoDygKi9cYvyXPqfXYYms51HIFwDAj+ql?=
 =?us-ascii?Q?MsNQMAObTX8YC6IjZ9nND9tlSLk6InTABK1Fb/mfiV4gsx0SetSMnQ2kQXNL?=
 =?us-ascii?Q?P675/mKmSGbKIEKZHHgCUle70vcJmNc+U9aNEJUBsf+wZBJf+VIsVc3TaJr+?=
 =?us-ascii?Q?vqEpQnC/eBa9kU5c4o81RwjXt2qqnI3nLIYaduePgeV8TI23G5X8/la1Xhml?=
 =?us-ascii?Q?T4Y0PANbRaDzOi1vQW2r6fU/+lrMp+zzc2l2RZ46cRXzvhYUl4H6Ill9E1mL?=
 =?us-ascii?Q?WhkQ9p7LHn3qxEkbrVXGg4nUusfbex/ZDWhxy3J1+uhBN5YPxspxtrLqFpVm?=
 =?us-ascii?Q?tgMW+HoaUta/pPs42EtjAZ+mhqhkq6ix2lkunlUt/csutezP4qmL5ge6JFWx?=
 =?us-ascii?Q?a6cFL20Empn72SWPQeus8L21oTcUwggFuXrQ7ALWX5Iz84U7iH4eFdhe2w7V?=
 =?us-ascii?Q?pMrec2VR4MS4Cd3GdmU4Qi2sW36/Tk9LPNFonwjE1b0zJPq7gWfKpbs/Z5c+?=
 =?us-ascii?Q?k3bn8+MK2VHNOya3DBvXlDBe3I5H/Wm2bk60cMsJwU0eF5/4IV2oq68bKxoR?=
 =?us-ascii?Q?q5srxX0c2tg1opd1Nrg82Io9V+ePRBnheJmyuUBpG3WLwtiUbvlEspcnYYa5?=
 =?us-ascii?Q?ZCVR5hebmxSpAp9IDmHcx64EyboMlcMyuUVWh7RpAsn4tbkiEJrMBUjX+z9Z?=
 =?us-ascii?Q?RvfNMTHJBdTTJVSaLH0ndRyHDIGF4VwY7CFvaZdrZp4QARcZqIit48FMZ0wI?=
 =?us-ascii?Q?8bCthOPCDnQ5P/uII7DSoait4F+MgIh2p0WbkG89jSvsAEvoyuvOR5aD98Xl?=
 =?us-ascii?Q?VKdn3YNLaiZhURxooyqqQJU3cETW1t4CekdyG2TveM32uUPlF7FNeKMHog5i?=
 =?us-ascii?Q?oEJEeCszwaPNFgyj2PBuVsyfVv6OM9oiClr4mDONPOH3DQWxhYXJAw4zOvLs?=
 =?us-ascii?Q?hj+9nJVRdpBYb46ZLRF7LJwsAeu7TLrAByJajKXEEuod/6r3RJf2/nLvKXYV?=
 =?us-ascii?Q?BXLT6cSZg7wb+9l1aIQ4esuXq0CGt2hUOZ3ucDt0impMBccsnpH9lna8bUeY?=
 =?us-ascii?Q?VXlUAro+HExzUcynWP5A19YtcvIkfx+7y1B4zAVO5VSOHoTIClJTASkQYdMA?=
 =?us-ascii?Q?o9+vaXiiWjlO4ZKNfjV6mIzZvHNxyaYlNsmnHpFgsKLv3A4WJqcyKZUCvKD1?=
 =?us-ascii?Q?YyunO3TbfXpBFpQmKIPj5VdGkZ1lMosU3DpwJ/UYsBs+doJ2VnRAhDUiUXAQ?=
 =?us-ascii?Q?9QsDhiFYkVsJ4l3jNjzaix5rciCtigWsEMBQKjA/pSfY3Z/I5xhjMufipTBt?=
 =?us-ascii?Q?8wYMgj547fuDSiuTilM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7fd0f3-7fb5-44d0-38f9-08dbc91633c2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:22:19.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeNB/A9AUnwDqRYPma/2j+wvRSGUt0LwJWhJGYsPQj0rglM4kVYisQjKPyiCA0r2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:51:04PM +0100, Lorenzo Stoakes wrote:

> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index b21b33d1787e..fb2218d74ca5 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1471,6 +1471,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> > >   	long ret, pages_done;
> > >   	bool must_unlock = false;
> > > +	if (!nr_pages)
> > > +		return 0;
> > > +
> >
> > Probably unlikely() is reasonable. I even wonder if WARN_ON_ONCE() would be
> > appropriate, but likely there are weird callers that end up calling this
> > with nr_pages==0 ... probably they should be identified and changed. Future
> > work.
> >
> > >   	/*
> > >   	 * The internal caller expects GUP to manage the lock internally and the
> > >   	 * lock must be released when this returns.
> > > @@ -1595,6 +1598,14 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> > >   		mmap_read_unlock(mm);
> > >   		*locked = 0;
> > >   	}
> > > +
> > > +	/*
> > > +	 * Failing to pin anything implies something has gone wrong except when
> > > +	 * FOLL_NOWAIT is specified, so explicitly make this an error.
> > > +	 */
> > > +	if (pages_done == 0 && !(flags & FOLL_NOWAIT))
> > > +		return -EFAULT;
> > > +
> >
> > But who would be affected by that and why do we care about adding this
> > check?
> >
> > This smells like a "if (WARN_ON_ONCE())", correct?
> 
> Sure it does somewhat, however there are 'ordinary' (maybe) scenarios where
> this could possibly happen - FOLL_UNLOCKABLE and __get_user_pages() returns
> 0, or lock retained for non-FOLL_NOWAIT scenario and __get_user_pages() 0
> also.
> 
> So I think the safest option might be to leave without-WARN, however you
> could argue since we're making it an error now maybe we want to draw
> attention to it by warning.
> 
> I just want to avoid a warning that _might_ be a product of a particular
> faulting scenario.
> 
> Jason or John may have an opinion on this.

Ideally the subfunctions would never return 0 when they are not
supposed to return zero and this would be a warn on to try to enforce
that.

There should be a clear limited set of flags where the caller is
expected to handle a 0 return - and those flags should have guidance
what the caller should do to handle it..

Jason
