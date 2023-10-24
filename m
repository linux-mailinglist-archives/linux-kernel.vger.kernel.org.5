Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6CF7D5613
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjJXPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjJXPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:22:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD7619A8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:19:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCJQcL032378;
        Tue, 24 Oct 2023 15:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uYwXUMr2c9/1aMljXpg2yI95qx60Uml3td1g2uQiZaE=;
 b=j1BnIoLr5L3bVSVxNooWjky41vZMmNhpxZ52ZDbFwKTa0wFLUnv4/N3dbLfvx6MZ7Evs
 qj4ex3/gwqy6KmfEmEpSh/lTVJi3Gglcrhb0VXGjxci7fxCNpO5IBk9PkOotjYQkR8mq
 JwTSJygMcBoW9ZYl4gwXXjxRhks5+BA45FblVTV5Hrb1/I8Zd7cX3d7Mv75lwr/hVAv6
 jcWNsbvztXBqWAdkEC8fsy0vgM7rvD812x7yDYq3I2wmHldY7UdlmDuTQfVW8Egg7luo
 viUXSWORg73QmV2sAE28QkGTxmhv1yvcOa+qYsQYiEg+XbaYLAjvaJd1CtA4Chxkd9Qq pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tdq0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 15:18:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ODoaSg001564;
        Tue, 24 Oct 2023 15:18:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53bv9s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 15:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4R1IcAn1Z3v04BbXvRkejm3zFKkAG/cXmvGzXaT6pROS9aze5z44Y44BiAZN8jjQFLvlFQFRWbyui2x8MAb9tfKoIOoey0yVDyUKV70ReEQq70VOU75PdVhfAxFRtF6vVGzX4Rzql/7Fo1q34+TCghdyBzLUUr0NIrQTiU7FFa/izZZd9OO+88u4dhSGDZWaNzVQ3ZQwdI3ehf+rm8eGBpqiSiNPNsmPDDaGhdUBmDcQnD48llyqkfJsBGTOG35UqPqhqObTfw/3ZBAeGTs868KREaAJBBftiQJTBj0fbMh8gDzOxpsTjJ3xYsiiep359S16xp1hCwcVpSMxl85FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYwXUMr2c9/1aMljXpg2yI95qx60Uml3td1g2uQiZaE=;
 b=iSYZFs7m52zc3H1pqLv3wLNjZGOba4K9+qDoHubgASn0PsFOAkdcqyOHp6FrDLZe7h534965TXyaLnVjo+zNVdHP1PheR08Wjq4UtkrYh6u8pzdqJy/9DXk5TwZVhtfQj0prw2qjD/B5HLPtH/ToLNRDAAvSC6L66GZdmqxOT406zTvpYelNpnOUi0YrrNnU7kOh7zWB0Lz3kD8mnYZ6kO/WDGu0IfK5CvVTc+g4bDGBpUoLZhyObh6xrY1RxBRIukjvSczewameALwK0qtKxK75xZdWj5tSNRJCNhq0qadbASopzge+eMcM/g9+oglgvjF59uF5jJxIlriB4zinHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYwXUMr2c9/1aMljXpg2yI95qx60Uml3td1g2uQiZaE=;
 b=J1UOQFA5ph6k8z7VEHNR/Zu63KStgZ4dU5NGKgy4mSrKzkaJTDisX/ax2+r5VNhSbXPO/b7uUh3gWpjMtYJC3xHAUtJPVRQeln05vB+B1JtCj5uy97HlQIj7HhNAhqzWNPgXqhpevf3qqtiIzbb4qc4CpUr005HiI104MWDvACg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 15:18:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 15:18:31 +0000
Date:   Tue, 24 Oct 2023 11:18:27 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mempolicy: migration attempt to match interleave nodes:
 fix
Message-ID: <20231024151827.i7e2f6cheet4k5h5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
 <77954a5-9c9b-1c11-7d5c-3262c01b895f@google.com>
 <3311d544-fb05-a7f1-1b74-16aa0f6cd4fe@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3311d544-fb05-a7f1-1b74-16aa0f6cd4fe@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN9PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:408:f8::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: cc442e51-7b7c-40ac-0dc3-08dbd4a47b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07mQZD/b0jJ5mR6Ic8c+eY0pzK85kcuSza3A3UgoV7WjYUNZQNfg9nB4h2EwpGlzWAV0oaRPWcCez2IMDOZPB06GF8XThXZNUcHbqwU0iNkwVw/9F5PFLkb/Tr3OeaF1bM6JmWH2acTbPEnffIhHzARENb5bhnV+62Fx0PQzVWWwgEb3CAE8mPTvRcugj7IFDVItkxOT50FMHTwpktie4rs6ar0lvhq9omoul6yR2LT5Gd0heepbDXOLcv9/8dc36DMSu/p+1BtPaDExMoS/KyDYS+01I8+fimjjWwIDYuJocX2S3+en+KBLS1qQdfPPScP4KIy3Kx53SfjNMRzCiwpbkAeG8I5rt3BpG6urJ0SQDfHxd0piUow7l5AHcrfoUOXJrYG8HtuFLF/DYrCxJWZDgjEal+kKwWJWb7gyzpqO50iOrqpYY3apPn8WP97Pu6lRZ9NpHZEXbpaW7acd7T7UOYlLPqipH0YyySPgAOscIZ/VqbX/7imybKoUoSJvLqJRmVt/0J+1ETu3ZOllKZOSF9DBJwsdB3kyLxXF70M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(316002)(66946007)(66476007)(66556008)(6916009)(8676002)(4326008)(8936002)(54906003)(6486002)(966005)(5660300002)(6506007)(86362001)(33716001)(38100700002)(6512007)(9686003)(26005)(2906002)(83380400001)(41300700001)(6666004)(7416002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GA5yJquQN223G2Ioj7LvYe//RbJmiq5DmH3Z3xe05nGhfst2HF9j+Yl7U3LJ?=
 =?us-ascii?Q?I7i//i2uZH676ELgBGWtIykd3zQk3eljhfmjRxHUWpMZcv3eLzDcbC7Vyi50?=
 =?us-ascii?Q?d1QMLu40cVK9VFPhaL8mF9FCmKfzfMGDaGb047Zf+6Z2FWGHjUmjR94jcFSi?=
 =?us-ascii?Q?AyEdo99AdAPsIEcsVj/AnGpuZn27k5pqufu1r+u+8Nn9QfRvQT1Sh9H9icrr?=
 =?us-ascii?Q?D9iev3QKqZ2sLwucmsMN8UfCy8eDB8dXXdTO8PUneyNWnmj21Ub/Zh8Cwd7D?=
 =?us-ascii?Q?oEOPci+DmVSY4PSQUsa6M6Tbbld/iOiA2UKd2ZEErPVOJCxgoEPjWwetauvU?=
 =?us-ascii?Q?Au8VBiObFK1Vlq0ZZik5eyqjw3t0pkvKidEuKSgfzt3ARRm8Ly1VddpTMhcu?=
 =?us-ascii?Q?s5glFDvtEsF55iKfrUn/Vv7hOrTRoItG/Sur2FolBTCz1K2a6zhFD858zZmK?=
 =?us-ascii?Q?HvfFBIjMx7JDaQiouDZ8aQ2QEbNyHBFDja8W6UPuxFwq7P4onnspjOoHa2bl?=
 =?us-ascii?Q?jZvOsYogXf6o4gvoMfCsTzioZ1pZ1Z53+R8jOUVNc2S/I+7bLnLaE6FnFmUU?=
 =?us-ascii?Q?cWC2dTJ5aShV8VnCoVgv/3/2DYXgrBHw3/M+Xx2moJGCuRsyddQZWVRIALqv?=
 =?us-ascii?Q?Gdu0p/NUoWF8rVroiDycQrkK5okM/FFvmVKjA7MV8M5akYvmHjquxLnE7MQq?=
 =?us-ascii?Q?r/oRoLHikKLqDmqXXhrNFcG6nWFdK/CSI5PO4VHFXDVY+b/gLAB/wNKVMTHP?=
 =?us-ascii?Q?33ECY2Jd3ko8PsINqiXwpTBbIuas4J7vv8gAljeczKdyplXpmYLq5a5BfcSe?=
 =?us-ascii?Q?XgBUIW93emNYeeJlkHtjtvFrTMQOLKokwf83jsK7JlxI5aWSLiFG/JczJesC?=
 =?us-ascii?Q?ENn3WCIbEJCkAp0b/t1ww7MR1oGC5HXEnJp8dCHztIIP3rchhQjgCL0aANwI?=
 =?us-ascii?Q?AV2PzIrUvHh/LirKDi/c6rJ87vX2WIbc7N//Lg+H23KdrnmDRuX2D2yQkGZy?=
 =?us-ascii?Q?M/pi8Nbk3ljdIbovSyUJ4356EvXFZfLgXZ4QfA9fye679Pjme8EBIpS/av0D?=
 =?us-ascii?Q?/gnxUpQtOJv+0pYzFAZ16mLqiW7Iu/bZGWhjp34kTSZQvMPsNf8EzDh/k76+?=
 =?us-ascii?Q?Zf853ad+meZlujTS92l8CAlh2C/F9B9GaMhx1H5S50E2UyNP5xqeqarAc6j9?=
 =?us-ascii?Q?HERr8tFZaesdf/gWG7OJ7CepjWZzTmI8e5GV/DH4y632Jul90rUPV8YOgiBm?=
 =?us-ascii?Q?gfp+ZgfY/9CX/ZAYiIFXIAgkN5MEcRLzgUSH0RSskoKgJqFUnNoNbYxZ+5fp?=
 =?us-ascii?Q?RS9qenAXp9IeTOtwkzKgjLjY4QBlE8Pkh0vkmpGf1/lkkvy4T6rg6WS8eyu6?=
 =?us-ascii?Q?BYMD6bOleTZuUfS9Y+9cAJimhqjOvI2JoLuwgviXgkVKytJUo9DV/Yq8hOEw?=
 =?us-ascii?Q?svOQSa4/81+oL5vxUjghKIrqfB3cypFeZnpqhAGWPdWNq77P5+hxkHHv4lPZ?=
 =?us-ascii?Q?Plu7koYTOzNIPyWF0fW5IyccQOPxF9JDnxtxYU4KNmCXGITaNguGi72iVwle?=
 =?us-ascii?Q?2QmV7UtHgZjtgMcHWIklXPJQ5M1d2+BMg+udg6ii?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+YMUNyXS0bEWg7NJoeVPHi2n3ayccCnv12OeBzFbKCTQrBZRUkWOvNjA0+/+?=
 =?us-ascii?Q?mn/y2K07fIvIqH8V+zBQcUtN35snKqR7tdbHis9NtdEqJD+wz6pyRAj1+FvV?=
 =?us-ascii?Q?WhfWoPux37vSZlXPd+OO0vI6e3HuBLlfg4THL/VtMkVAUCcIg/Tha4CST80X?=
 =?us-ascii?Q?SX3tc6OWcLtUaVOKevS1uPvc5gLUZE7avdqVmnjzlMcYd15XZWEPcUUzwxQ7?=
 =?us-ascii?Q?3H2yoezoAkc4TA3qdV9soV/jvhPc5bqG3MHM8j2sSlhri3emaHJHMdJZoJDe?=
 =?us-ascii?Q?TPOnN1+oy3WLlZ9IZaut80gAXT8ebqdjI5tPZVmCA8Gv2sX+rotJ2uRY15wK?=
 =?us-ascii?Q?/XH7fjbbsiQSO+lesFABsQV+EC+1LopnVFqZODgN1li5V5LB4SurLQuIcD/J?=
 =?us-ascii?Q?VBReWUgNGEXGSxiotTpezuscishwsK8uta4PWsr6LUtlA4dYCgTNjvYUqsvH?=
 =?us-ascii?Q?OVxfskJ92f7zxSm9MD3gADmXUs9PbTEOOQ/vdIhNxpv65GSg6GtpFmdjTfBU?=
 =?us-ascii?Q?3dzG6Q19lydfqt1+7u6TK4T4noKe+vDQjgE7VjtMbD2kt8TCHb4PLNeiz9X/?=
 =?us-ascii?Q?UOzL9KvmZrFK2m1lHledPC7Yn+7rpkH2/1U5AjBtYvgty7Pl5QvojEwyAKpr?=
 =?us-ascii?Q?J+BYoVDzTkhfA8PLBj9HKz/FG6uwqDtaY/kfxLfLRA5bBAMimCkkicsS/p+j?=
 =?us-ascii?Q?HmEKTtwLkY32ct6zKbKPfPlmTvpsllmhyAfbXIB0oB+30Tkl8aYDjYWqQDwu?=
 =?us-ascii?Q?jCzmfYfhzdfLeFUIybFF7bv2KmuZ+YnVLPvcw066cJEwe1qkse0TknsYbyI+?=
 =?us-ascii?Q?HDHn5YaYyWML+rYHCWUR2XWbz+cXKBPlBfuIWOnZU13X/4WXhkFWeC3i3MzM?=
 =?us-ascii?Q?GBCiJrhNCUbQjuZ8gajNoFhwmUlckITnNOwAmDk996nqOSy4a1iSo/0kruzm?=
 =?us-ascii?Q?fk3iJ5SpGnrci4nJAWJ25jQqLDL0sChQZ8sKdxT2CcFFN5ULT87Y06iIrv2t?=
 =?us-ascii?Q?PJEV+1Bd2Zmw+PP+774TTsDePpDWySoKIzJm8ld4KrssWy+7LC83kycZ9A2O?=
 =?us-ascii?Q?zTC4XRmft9p2z4NF4mOBvr3MWV3ckIjmco3lT+SAMgvklj1mXaXSUpPi3uq0?=
 =?us-ascii?Q?apSjlHy0PQSuJsbs1bHWT2OPHuXJOfrhdp2e72I+Lusw4OlF3lavpelNVr5Q?=
 =?us-ascii?Q?r7eCEqjWZ9o8bF8Sd0g/lLj74zpPPTExEferjsABFFVLZSLyGhSgpoEeIYyL?=
 =?us-ascii?Q?EPHh7+BcKbek4+pdpLiy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc442e51-7b7c-40ac-0dc3-08dbd4a47b41
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:18:31.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLDEdGw7aK6lCjGJM2AHB9MzJ9MGW5CRlIdkyscwZnr5q4NEJ99DB8lOE0SZqpGf9V3LIGpvQzLjbFbgB+iWJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_15,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=797
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240131
X-Proofpoint-ORIG-GUID: wBEOtOnm0RJe2YQz8VMF34e-dWIxiNWy
X-Proofpoint-GUID: wBEOtOnm0RJe2YQz8VMF34e-dWIxiNWy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [231024 02:50]:
> mm-unstable commit edd33b8807a1 ("mempolicy: migration attempt to match
> interleave nodes") added a second vma_iter search to do_mbind(), to
> determine the interleave index to be used in the MPOL_INTERLEAVE case.
> 
> But sadly it added it just after the mmap_write_unlock(), leaving this
> new VMA search unprotected: and so syzbot reports suspicious RCU usage
> from lib/maple_tree.c:856.
> 
> This could be fixed with an rcu_read_lock/unlock() pair (per Liam);
> but since we have been relying on the mmap_lock up to this point, it's
> slightly better to extend it over the new search too, for a well-defined
> result consistent with the policy this mbind() is establishing (rather
> than whatever might follow once the mmap_lock is dropped).

Would downgrading the lock work?  It would avoid the potential writing
issue and should still satisfy lockdep.

> 
> Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/000000000000c05f1b0608657fde@google.com/
> Fixes: edd33b8807a1 ("mempolicy: migration attempt to match interleave nodes")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/mempolicy.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 989293180eb6..5e472e6e0507 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1291,8 +1291,6 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		}
>  	}
>  
> -	mmap_write_unlock(mm);
> -
>  	if (!err && !list_empty(&pagelist)) {
>  		/* Convert MPOL_DEFAULT's NULL to task or default policy */
>  		if (!new) {
> @@ -1334,7 +1332,11 @@ static long do_mbind(unsigned long start, unsigned long len,
>  				mmpol.ilx -= page->index >> order;
>  			}
>  		}
> +	}
>  
> +	mmap_write_unlock(mm);
> +
> +	if (!err && !list_empty(&pagelist)) {
>  		nr_failed |= migrate_pages(&pagelist,
>  				alloc_migration_target_by_mpol, NULL,
>  				(unsigned long)&mmpol, MIGRATE_SYNC,
> -- 
> 2.35.3
> 
