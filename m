Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2077FB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353339AbjHQPvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353334AbjHQPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:51:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B7430D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692287474; x=1723823474;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EDamx9oLfTwkiX+ZgQoo5LmGz60Jih5zAD4d1pVrLJc=;
  b=ICuZALhicK3jZeh+ujGenOpRDqF4fSVq6Hj/RcxcV0rrheVk8RQYklCG
   hcHyD34kcscEF4D836U451pdmKsbUNtX0j2bq2NRs6a9934qBKxHnxeAU
   l+DcHkH+9yZ2iSripEPUB69Gj08Q8Ak69fw+k2v/YXyHylLOR9jN37W0r
   AdS/1xRPFDryHLIofTO3GXH3ydczwi0gohsjqBTIy6ZJiReRftBhxDU2D
   jsLwyIDKas9at9hC56uPKEQbt5DfmiJXUsEWhwiU2/SbBqg/m9r9GSFU2
   vU+8QdEVUZHRiIcHMoL6jTw9/4J9xJ+WfO7wv+xFSh65/2z1+HlA8QDkq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370314698"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370314698"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737769264"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737769264"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 08:51:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:51:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 08:51:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 08:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCCSQFn4w1NStaDRro2uln0lg2uuTzHgAvhN/KHCVJn6EN4yus7phGlXv/MhmI8H1OOR65makceK3IZ9v+wzkdXk5NCtivLmxcDB42f+byF7TpR8p5SwSyj55lYr/MVq+hEzLwU622QcenLJsqpvydBUBfTMZuVZTJdcjC9I/ftnFloo2RG75Z1X4hBdz/Z4vPbY6wAVKoTp+0mZCEExhL8V8mQFjvL5zQKSzim1vX6z0mMDCHfvJ5MQysqiPGi+L86Qlw7yaBT+urQgcjsUapRHjHbsT5v2z0Z6r0OiiZ6GZaSCYy9LHuTcn9JtvknwIH5kbvXqxa9cZSeJi6NLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDamx9oLfTwkiX+ZgQoo5LmGz60Jih5zAD4d1pVrLJc=;
 b=ndGCw+PChP5o0W739shYJxJcqZndZEX0QTtmqANd1nPqKWY3kcbihMKUsqvaRlNZ2qZ03kmOEa28WiNXuckdkfde1D85nGfqUxe/mOR/CVazUMJqw8cK5jYUi38FgW2ky5RCFnS/2WwyuaX9Z4XH6ZmTqwMZRmIlGVak+5duYuIx1LQ6C59K3HEQRxGPD6+4TB5oxQXQN8L9TZZqhiO02wKruswyjud+QvQfKPqevTbmz8l8Ky4InLQiQCw6WyCvwFZCb/thhJfNFTY2jgnpZbbnidNE+sbrVhVkDm4GAtiSSLLVWtZrglsc0gKay3EJHy9sNyOooIXvBnETYettog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7078.namprd11.prod.outlook.com (2603:10b6:303:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:51:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Thu, 17 Aug 2023
 15:51:03 +0000
Date:   Thu, 17 Aug 2023 08:51:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>, <kjain@linux.ibm.com>
Subject: RE: [PATCH] drivers: nvdimm: fix dereference after free
Message-ID: <64de41e4e5e7c_29e220294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
X-ClientProxiedBy: MW3PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:303:2a::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d98c488-4303-4f37-edca-08db9f39c2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+nK68tEAY1EDpXJX8oXbowHxIYJLO0laOD2HCmu+GUZOfaL2VzBZxpqSrJp9DUbSi1l6SvNq5GILteAfLsTS0I2EJzLfdbr/HPx16hrptNix6k8TO1mFLJi0j1aQRugQB0NvPwpG0cMnaGc8TfoMNhBa5ychH5j9IuVFiErwt6R6uiikVG5ZKgXt3ydJIWUl7dwuaAgtruRn0Pi1q8Z6STrPSBP/mMKvGjddMk2hNx+0dECFaMKp4pcGkmmkNq193hmoOiVvgGrYWdYyGCTUqJuwoDTMxtcvCv98Te1oC/lpMvmiGhPo9KiWCX+NElsDkmExAJB25HsBWHKJLff3IYFzC7/PCqMBGmzgvtB/iCKtsfXPsQigYeK7k+5QPdVmSTfo4IBlbPY5MTM/3IJAKc0kxH2CujCbKz57HYl8Biy9QWyCtNgyg/hVjgxPKNJ0iXIoLjuo9pMf7n883eMr7SLBcbGKJEI5Wtn+/GmVFOMTqPPBrBZ2qVKReuKjAV43zISBDxP+Er0+9kqEP1d7M5qaH3aGijuT31sWMo1/3d6Yyd3LsxDiuuEkKbxvScy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199024)(1800799009)(186009)(86362001)(82960400001)(38100700002)(5660300002)(66556008)(478600001)(6506007)(66476007)(66946007)(316002)(6486002)(26005)(6512007)(41300700001)(4326008)(8676002)(9686003)(8936002)(66899024)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nk0OEl/+sFzVEBDD1ANG6bpG6iK+0eqqSs1m5Yn1xR0qBJCBn/oZp7RXiQG?=
 =?us-ascii?Q?ReSCz0YkzjldBYUR1nZPqaKtkXV85Qiks4b3kZGgLHVMsPTQMGqPHRDwxJ2U?=
 =?us-ascii?Q?hF7N1wnq5cnjX1dmQBcIVX/nVCJ7aReDh1Uoq0t0OMP0DyiGi5TWt2oyuFBT?=
 =?us-ascii?Q?bZIpM6AvaXaHJBEYRSvBYnVkUlAZkiHJXoXG4mGdKFYXoCjSiW7XOoQoShIh?=
 =?us-ascii?Q?vdGOnbLNzzhuzbZs7YQHvfoo2sAgLtTiatMKDynr6q7PQktd+rDhWyfPJHxE?=
 =?us-ascii?Q?CBRNlj4fjPMzs2zSwSkj6WOpfPu6YQG7XaXXAAtlGBwxpnQI+ha3iO4oXgUm?=
 =?us-ascii?Q?7bkuKbPalNC8VN3BXli4ibd54v1VPjUKGirCWAWEjlvDexGrws2p1paFCw3B?=
 =?us-ascii?Q?E8n2D4CJuya+OR7pBYsZw6S/++4HmMHb0AW55y1C/+2t3wrB7zxJTvf894wF?=
 =?us-ascii?Q?kcRDf5LWOo5BCEcvbNp6YhXn0IVHIpDyUUgxdxUrxkwfdSGg5pvKLc8XwRmQ?=
 =?us-ascii?Q?pQB3JuEuWXf20fknu33fgIZAqIuBYzBD+afK7t4lMWlgUSR+qL0SS/HwYo7K?=
 =?us-ascii?Q?qYftkhz5ZTvsydS/21ckeqt22tHysY0zQd2YD00s+0+h7ilv008zdzbh5dsW?=
 =?us-ascii?Q?b0Cb6blQFkxSXjSpARYKP984UmxObJWUAsclCcfD30/HnfZlxYgK6Zm/9UGR?=
 =?us-ascii?Q?78frGUNfUrz4bGN1kQA4fS9mK8DdF+gDifqoSz0Rdz0wapcRc5H3XebWekvf?=
 =?us-ascii?Q?HVdoQQ4kzEak1DGHaTh8gvjt0Vrym9+dGprGcwjRlsd/fz5dPv0l6D5/aqM5?=
 =?us-ascii?Q?SReS5KkxZgAxCxMKmCM7UGfh5gpfh6zju99NlOOj63kWFLpXOp2CdZWCvoeW?=
 =?us-ascii?Q?okXFosIIlBYiPervyIvRWF/NDdxUs22uqrLWOp2nnvvJ9taKtvU/GRZ8VDCO?=
 =?us-ascii?Q?Yi6odvmijX7EhQ7HOJT5er52LLEcl/rn51AUqFUx1DbpjXKk36MvMtH/abr1?=
 =?us-ascii?Q?tp7WFEoYN8GOSfaT8fTsaoRAg8bFpepEM915+Xrzq87D8LZUGKp/0K83JROY?=
 =?us-ascii?Q?9Ji8kciLJqmTvdFrR5sTwJq9ajDyP30saSJUpxKzsbc+ghpfd46Jt0vx055/?=
 =?us-ascii?Q?wcG9wQUfGw2f/WJL9INSaoc8wBWiD+RKp88A75r64hISYX7jkCEnnVPumjo1?=
 =?us-ascii?Q?xAWhV4v7fQ/o708MFlKhV5SxxQ+/wChgJIiWWEn8ZJhvnrsm+ujW9/SVavOo?=
 =?us-ascii?Q?8cO4Uk+kLduJk4oxgD/4vbH+B80SDeV0Oj/3/duOhKhEXx4SyAe5xVtVSbor?=
 =?us-ascii?Q?bjl5b3ae9mVfNykfQ1Q13hDEiVoUnHoJqAIO73hZHzuvSYy0BupY/+OXo/hW?=
 =?us-ascii?Q?RKxdF0Jcv+CK1aG5RlgdibXBOdyda+gZSywIKFMd0+SD1KR+SfeuFgIcnYM5?=
 =?us-ascii?Q?gD0561xqbwLUTm6rCQNyPO92cLxE+CAN2Y7UK5H4eJpS5GIB1wbPR7nq6y3i?=
 =?us-ascii?Q?5qvBJYNfSI+jDb9O7VskR0UiuHwf6zoQ6cjidENC2VD8deKtwj06viNMac7A?=
 =?us-ascii?Q?BxMYKM4v5uVitGFdDRU2UpD4ShPzjWR7xE6P0kYPLK5IrEIctynk2OexbZB1?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d98c488-4303-4f37-edca-08db9f39c2e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:51:03.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w5+r+APLG4XcFl0L2kMWsJ175JuafLK8tBuSrKl3cilZ7xsMLudViDROVPqxaJw6ZQyGcPGHrko5ciDm7mGp36eS6emlwDYleLrIkhceXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7078
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Kajol ]

Konstantin Meskhidze wrote:
> 'nd_pmu->pmu.attr_groups' is dereferenced in function
> 'nvdimm_pmu_free_hotplug_memory' call after it has been freed. Because in
> function 'nvdimm_pmu_free_hotplug_memory' memory pointed by the fields of
> 'nd_pmu->pmu.attr_groups' is deallocated it is necessary to call 'kfree'
> after 'nvdimm_pmu_free_hotplug_memory'.

Another one that would be fixed by static attribute groups.

I do think we should move forward with these fixes as is for ease of backport,
but long term this dynamically allocated attribute groups approach needs to be
jettisoned. ...unless I am missing a concrete reason it needs to remain dynamic?
