Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745C807FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjLGEvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjLGEvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:51:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B15126;
        Wed,  6 Dec 2023 20:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701924702; x=1733460702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+0IbhqkRrxLqWUSM8/omrz6QSMFvMSmSfQuhxtPl91A=;
  b=JUe8vqomDKG+2cyzNfkrZzConm+SxZ70Y8WFjL2CgzjuaAWZC+OUpX7B
   jg2cPgsxWJW0rLlAG22Rk79tEs4E4GTQJCODQqEGrNZbqhXyevl4FU2TR
   fcSVDgW8Rp1IZpui/Gn+BR6Zfq1u5QUqsGyDxVbeycqcfLcZrTZ3XL7gi
   8ikziKa/LPKtFCY78ozaqZPZPBw7+vJbJ7gAU7+0Gxrp85TnOj+8mL3NE
   PCrGW16rJPYansaf1F7p3pZlQd695gj1x/WTEz4E4Xkh2OLHyXfFUyBmv
   HhAOzpPYOw6FIygEne89YKQrT0/NI24SuEye/17EAsKbi6H6X+jNXbCzW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374341627"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="374341627"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 20:51:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771571142"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771571142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 20:51:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 20:51:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 20:51:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 20:51:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 20:51:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6tNiQa79dAejkiSQssRN7W9c+ejEt+v3DLX3p8193X/j9dbmlhK60DFsqOuvkkg4dHGpCsv9SExf2hIYLXWXe5g9V1DAQl9ekENkf5eKgd5jXi4twkLgrGUL4tlK39PfJ5uJZb4zoniwTOkC4CjitMv6m5Ow7C5O9se3RxsqWn6PzmzXpn49bAIKmBVZRifLUxmHFUis+Spj05zHcs8on/KD/Tk4JPqh/RFwg/0k947AeJGvcq+Hb8MkdksqHxg45fbC+nMvKBXKsW1aOkngsP3R/WkbYDzhw48PalpWf1tXkLz186iCeIT2Gc7kE3reEf3EUdWZc1X7xMiQyGnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7CmYOu5xl60BNTufSc/bb6K4HoVOq5PvK/gg74+xOk=;
 b=eRwJ3onXkW1QeceE35NBrAwbjm/vvy8K87vpqRRVw1kR1p2dPMsBkzqgee/2Qc/bL26cdKEkgrE55OKTS1esAmSqtUASGZc3vQDGnnqPtt6qTwvK+vpQhI/UKzGBqrJm/5Rmad+te55DHBQKOwkssYvGTiObOnVJNEoxUSXRq639vNMa2TfoDeQEOv5Vu01l83oUAwglaXgNrnGp7Dhp81eRejQKwWGmM7+cOnkJcB3d8s6+7ahyzrMfgVYnDDAOG0CNE9RCfhQtBRJ84GPIdHbPW4k1klg2J+f5L5GxNbB8Nj9bmpEpS6uwKNufAyPElKZmeHZkk3S95AwiA3fm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 04:51:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 04:51:35 +0000
Date:   Wed, 6 Dec 2023 20:51:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Huaisheng Ye <huaisheng.ye@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pei.p.jia@intel.com>
Subject: Re: [PATCH] cxl/core/mbox: get next_persistent_bytes by
 next_persistent_cap
Message-ID: <65714f53394a3_1b2839294ce@iweiny-mobl.notmuch>
References: <20231201164005.135912-1-huaisheng.ye@intel.com>
 <656f9a94d9b48_18297729452@iweiny-mobl.notmuch>
 <5fed153a-6668-c980-c573-3a31077c52ac@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5fed153a-6668-c980-c573-3a31077c52ac@intel.com>
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW6PR11MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e958143-e9cb-4876-fe77-08dbf6e03075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iU8xGhqwwbD1P50Q8FX/KluXB0N6qvtwftl/waq2nz0NmirpYtK2baoNQoHnIKCVVr/7umbL3zoCORhqMRcwOCoEGFREvXY6QgOkKdQgypxV2n7ZUFLO8XAlEARqhGGHdrT7B/bPu8nEnJZGS9hOnnz6VNI9vu3hsWfg9Dw28vrMt6YFzh+eniqFCTLiWyopHJmWso3D1usHT9ub3SLtqPqPjA5BAqmyFpmBDZ++Ci8LUWRQgESxj0A01oj2LowC2J4WfRMyp9kOGZdFWD9n566dt/bxyiFaQqZqJt6KLZ2VSZovj6VCtxJdghhmASucBPTwNG4nogG4kMpjhMkA1w1Bym2QphOxXm6jq3RqTQUB3DrTLD3E4sr+ABdlx1wJTGEW956FJbzkhitv5YZerAu+PtZhAItaKvLzci/A3hKSC5mcYar7ldW4mH45D1ozMB6Crnk+btQwSA65s2VJuFK042ZoLe/3/C7Rzs77KsmpS14ZBgH6NFR2Tj9rr/VOw1Sr2RLxA1EcUy1dX49ZhPuz1PRC1ipBoC+DqCrsS5GncGMfHIp1GbwEI8UGqrSw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(44832011)(5660300002)(2906002)(86362001)(8676002)(6666004)(107886003)(9686003)(6512007)(6506007)(53546011)(82960400001)(83380400001)(6486002)(478600001)(26005)(6636002)(8936002)(450100002)(4326008)(38100700002)(316002)(110136005)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0xg8h5APdfJiZSp+eeTBaSAxhiPS5fLKtCoE9eb+igiZK3PpTqexG9nbVkIc?=
 =?us-ascii?Q?Qa5npZPxt3kJLwBeICpmg+FpCWYaG9dZeIQRdTBuNQ55HoqhpyO3+Q3vFDsS?=
 =?us-ascii?Q?YxOssp125xAysJIQusNzlRTeL4wb0btEazwfyObkV4F0m5opvUv8QlEL1e+8?=
 =?us-ascii?Q?KKKSYa/w7FvLHc6Fu3EqR208bnE38s59lCai3V6PYl6DROqYQAMG4mUMsznE?=
 =?us-ascii?Q?JH6HI6DjP53cDDebasPGjO/dUOzfSe6Vu6xfCPl1yZ7IGPDVchkhdBlei1VW?=
 =?us-ascii?Q?TPeY9K/k/C8zB1xBf3YWsZK7Yzuch5nQ5cPSNsV15NUHtufu32J9PDiRmhDw?=
 =?us-ascii?Q?TCB5zgGssZKYnVMwqvyb3hiGJHoI+vA/K9dv5/x3KtSiQtMkkJc5IRgyR0A5?=
 =?us-ascii?Q?+ZqyPomCe8U8UOWwCGvzJ4DNtaUaWB3oGmURgS3gpFc+ofB5g/Z9erRsgS3l?=
 =?us-ascii?Q?5LQcjwCNPxWHf6COGZoZM+xC/ebzmQ7nniIP+M2ndU4TvDYQQbcmnaouGXOc?=
 =?us-ascii?Q?4xBEzvugYRxZFO8T0JesCkeT0UF9yU1dTP93WWlwYSIisvyljHdPq9uYZ44+?=
 =?us-ascii?Q?Cc7DWelFWQQR+p03/83FnhbzUCbn0KQQ5GnqRq8ymsn9H4eRgHrUWWQ69Bhs?=
 =?us-ascii?Q?mVHQA3/hptcEWzFnHxMnBdyEO1UQDs/kPP/Ed6PmHlTIy/fd2b9WOyndJVNe?=
 =?us-ascii?Q?YouDROF2R0HYuYLfIOMYKywGJ+EiQeARc2ZZ3i+FcACmfyfHiqTvv3pHrqDD?=
 =?us-ascii?Q?lOLoPoRzgklggAeSJnd+dfUwo2a0wJHD9KmHix04xYarZW5qmwHkTkmZ+gxs?=
 =?us-ascii?Q?EpxqFMaXCbtBQUvWb3zri5ZbY/FMYDnvjfgin7HMSfdTa5ifiWSh2d82AEMs?=
 =?us-ascii?Q?aFDIeTDQ6BVsYkh1GBqGBvkYphAPRezEriy0UfrDhukpLaYLJ48S0XfKJJ2D?=
 =?us-ascii?Q?B/DWH93IlomJsDrFcp46zIXS0whfsrjmi9CWpgX0WzfLbXISudaNdJwCTUKo?=
 =?us-ascii?Q?1uKH3k9K296jmZA/iLCrNPyQXO+lGksNh9snm8Vu1tKBRId03ljwuzwUnjuM?=
 =?us-ascii?Q?V984vlez/G2yQWuih0QeYfU7afWRwqbmHAsGlrUy9DKJxPNnOrNfIXXlX5NX?=
 =?us-ascii?Q?7lpV3cgTZVdpLUmrbaBEjSluf2ubHpfCyStmdI4eWP31gI48q90wyB7H93oY?=
 =?us-ascii?Q?0MaczAItmKCuFbqbSzo5hWvvswG44vnPaDPMoK5Wcc7jNg1PH1jXJ1AmZM4T?=
 =?us-ascii?Q?hKbRwOJAP8K1CBIpYLCn7/wnDqWRtk9enlTr5NjKtlwN3+j/91Chmk7kdSFk?=
 =?us-ascii?Q?TmHSfMECkCwVuuusP6DO4Sd3kKw7Tr89vjtKAGdv40APMnG8gKFSVj0kLW6X?=
 =?us-ascii?Q?sBx6xwiCTQPierf2Jqyi6q6qDoaUoRbN0JBeKuJjWVxjd6K54ANu/8w+LKHp?=
 =?us-ascii?Q?+b1+IQyduhnABVujSvqPQCKdg8iX5KKBJPX3/6lHwpxkaeJmOu/DT8kypikA?=
 =?us-ascii?Q?6J1KIcgQ5Za/FSwxEbuZiXB/U9wOTiM55f6snN65hc9hq95Yz7kBceNsJ3dE?=
 =?us-ascii?Q?RrUp6r31YHtgRguSq/iXPqwv60SNrGSfy/QzSbtq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e958143-e9cb-4876-fe77-08dbf6e03075
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 04:51:35.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aljMSOnpXaQmzr7Oap0cO0cJGvIEwNpjapwn9SnEh+4ysb39lWxhObKqxpgJC1t6cU/0LmpbwxEieYjIj/4Vyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaisheng Ye wrote:
> 
> 
> On 2023-12-06 05:48, Ira Weiny wrote:
> > Huaisheng Ye wrote:
> >> According to CXL 2.0 8.2.9.5.2.1 table 176, the next Persistent
> >> Bytes should be calculated by next Persistent Capacity.
> >>
> >> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
> > Do we have a fixes tag for this?  Was there a bug associated with this
> > find?
> >
> > Ira
> 
> Hi Ira,

Hey...  First off thanks for the patch.  This is obviously something which
is wrong.  I'm just trying to get more details about how much work should
be done to fix this.

> 
> This bug could be found in cxl-next branch.

This looks like it has been a bug for a while.

59f8d1510739e   (Dan Williams   2023-06-14 18:30:02 -0700       1071) mds->next_persistent_bytes =        
4faf31b43468c   (Dan Williams   2021-09-08 22:12:32 -0700       1072) le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;

Both of those commits were refactoring so the fixes goes back a bit more.

My question is: what problem is this causing for the user and should we ID
which commit's this fixes for potential backporting to stable kernels?

Do you have that information?

> It looks like just cxl-pci would calculate next_persistent_bytes during
> probe. Afterwards, it will no longer be accessed by current cxl drivers.
> 
> For v78 ndctl, cxl_cmd_partition_get_next_persistent_size is calculated from
> next_persistent, which is correct.

This too seems to be old behavior.

4f588b964dccf   (Alison Schofield       2022-02-22 11:56:03 -0800 4142)cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd)

> 
> May I have your Reviewed-by?

Not yet.  I want to know should this be backported and what problems this
causes.  The next values are not going to take effect until the next
reboot/reset of the device.  So they are basically informational, Right?.
Is that why you did not add a fixes to the patch?  If so mention that a
fixes is not needed.  If not, explain why this is something a user might
see and lets figure out what fixes tags to add so this gets backported.

Thanks,
Ira
