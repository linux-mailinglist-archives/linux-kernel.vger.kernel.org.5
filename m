Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB3790A9A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 04:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjICCzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 22:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjICCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 22:55:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F13110;
        Sat,  2 Sep 2023 19:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693709717; x=1725245717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kIrMNhlFv/XKFFRNsEmRNXymCe6XnhPY24lq+XqO/4k=;
  b=gnq0sb7HNWWsK9dOCZ72SZEau+1ue04EpYTwSXT4ExhNxetlidK4kYyg
   1LemRQ+KXcydQBY7kjGAstyxTvi1cHBcCJzgG/ElQt5aHgm6CRHloovOD
   p7NGx/ioD3FapsvoZIbvnHK/9smhjPXG2pAG3bw3vZ6srd5pK7RYjTuAZ
   jE7XmTkIhaUPNevyxnszOUHeaWm8XVjC5qeqMlOvPH4yLd01ca41BhKEl
   01VBsCxnFIDEwJKxbMFEu7J08qWTAyDYs3fCSLvr+Zbms99DB8o1bSizM
   tW5RBQCQs2eoD9iqQ9NPWuyar9iNDlhcqemaBFBreJP2B0HRjTcY9Yq7n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="376349142"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="376349142"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 19:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="769623951"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="769623951"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2023 19:55:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 2 Sep 2023 19:55:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 2 Sep 2023 19:55:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 2 Sep 2023 19:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebRCvM1ZK/8jlXnT8Lo9NEID8K81g8380J+ddH3y7ymLCrwFlsr3sfzwG/J9pfLof6uleJMyc+DTeB9SXSorA7OSIbaMfrjb6/NCYJ1hikuNF81mlU99q4nUkPT+VMSWqA+oUZGSarM2NbSIuUIW03UedlDLiTQ/nZfyr1LRLTpon3cHbhUlit6mRD3OsdrUOR4GiWGeQh8wYU7VHqi0t0mCcz1szdcbNTdId68f8dEah23Wm5bLXV/p81KEaUoRNWev9cqu3L91u+BBrtVoA006/ughZGCf4FSqMxrt5Zi6UczHYC1PwQr6cpDXaNbMR9Mlsi6sFcYqJPqSuV3CMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiXLQ8+lHhRKJSaAIslx4KshpK3448n7WWRZqz5bcfk=;
 b=hXP6E/uRdQ+RikTbepxbwLi0m4HpVGNRfC/ak+uF/uyXpFXlF9JTtltznXhhX5h/TSDJ7XmkHEpVxX20PrkvmXCd/LlxQMW2TaYrtbUeuuKgj9YtBagljJUBr8vD6VwPzziazbzuDNpOMkhy1OSuCCdbAPDTjUlJIsIBR3NF0DRSFxqN5WxckUSSmO2DeatFloTtrm7TKFdW/Tq/uLbpGBC+ZuTJ5PiKs6pGd4yGSFaVqzwZCeiQLdKKCTSPfX1r6UpEcifcX2rmCuDBR2Rre8ItnDSoCnmazd43CfTG5tmn/o2rKpqwu0ZJPwW/T09/5JEqbOGUCGWM6D9TZ3p6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6260.namprd11.prod.outlook.com (2603:10b6:930:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 02:55:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 02:55:12 +0000
Date:   Sat, 2 Sep 2023 19:55:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 01/18] cxl/hdm: Debug, use decoder name function
Message-ID: <64f3f58d8405_1e8e7829461@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-1-f740c47e7916@intel.com>
 <20230829150320.00007f08@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829150320.00007f08@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb9f702-bf3b-41df-ee41-08dbac29311d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2+qDkq6bYJpxmocBCfIdrRyw+SjyW5jDC2XJvAB2oHHH8uk7GWskDAVZdhAYvJ8wklg8DX9J4ofrDH8v1sBlfp77YoZ69DaIDw8zM+2X/1EgJhjeQXBOjnHJiO8w/PNMW9XVaRP5K2ISqtJegWr3QHzCk3RoSQ1uSVhSnwQQ0fVgO3ag5cD+d9nqC8p/YcgdBv/DU2GZCMwxLfwygKqwWPEfvumMBctnDr+wrPR2+7My4741Ad+TJWfKN5PgYKbHN4yk9piTEZOTrqoPoPAJmjf0Kr7PzgjGEBNJLZ0W7EzjYV8GqJaMtcnRIYVBYVL09fwH193EbZSyovpqvqk9/oDY3dNDWvwT2pkii5wx7kY8ZNjUHANWa6P3FGw6BrjfhXCVblNRSrm+riLw9yDsSI/S5OCeoYqGjjWiDvFk4c8YiYr7qBpBii4GGheoXsSRWiifivnyd9vJiCRHwGzvxD4C8NHLIHPjBh/YyY94HEih69KcRhlNzaxI3dpp1Gev1VaQHqiCZdo2JFy3S804PgRHifQFDJdMwr3dbv0WT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(82960400001)(38100700002)(6666004)(86362001)(966005)(478600001)(26005)(9686003)(6512007)(6506007)(6486002)(66946007)(66476007)(2906002)(110136005)(54906003)(316002)(66556008)(4744005)(8676002)(8936002)(5660300002)(44832011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2B2sIUMgPmNOVA9hILfnNq5gQGEh5+bgCdFwNLdTstIKIIJRfSsklULabZy?=
 =?us-ascii?Q?R79nFSGv+CCynIyNgUDcaDHyuWX+t/52wvli6lIkOF13B7oF9vlG98R+mz3Y?=
 =?us-ascii?Q?Cp1EURYH4I1eDbSc0RQMsu7ftl19yX1qTRAst3uKmR/huqJF2pv+rzx5Qydx?=
 =?us-ascii?Q?A2DQEbhP8kSNlG6DB7n4ShGQ1VbQTj0O4Ku+64PunxqywhWHrF1HiAHRxvZk?=
 =?us-ascii?Q?XlJnTEd6NTeJupfGu2ygYju/7I+ad1CJgmyfDNtm+s0canceRPmAvOJJbtSO?=
 =?us-ascii?Q?zfvb0fhZqZElx+TFae7Z228p5yi73EkdBSSDYiQiHt46zdetc4F05PrMtQdi?=
 =?us-ascii?Q?ohgBrmkkyuaoxo9octn629otvLrO0mEz8fvrQmsa3QrOxwKd0cBZzKuA5HnB?=
 =?us-ascii?Q?uMau0fFVLJUxivIkWxiQcaMztOFoV6jWtTJ2uHSJsins2ia2Xd/lzXrfdH4D?=
 =?us-ascii?Q?mkXLOexGCMPDM1r4oezwPmMNSEsQIeqzVIVT0A1Z1YNCjIUks91LUDDgy0at?=
 =?us-ascii?Q?KOx8rkM4Lg6Ol3BHmL5itb8k8S1Pj5xD1EsvUBgwf62ff1yqzwjX3Y3KIoPV?=
 =?us-ascii?Q?0dtCLUUtbOqZuP3PzBotFAZyr5jWNwoea53q6FZaKxuuRr8Tt9caYmRJH2yA?=
 =?us-ascii?Q?PPp+oM/vbubcrk2cEfT5DFH+XmqaRMq/5e2UtxFreFHqg5W/5U294y31BmR1?=
 =?us-ascii?Q?byLYzRi5OokqjIiHvSY4n8rJXRUSzH4gyvqoZyMIk22c0m5S9nj/Bj/46Glg?=
 =?us-ascii?Q?xTsXGCHnfcZmKectKJlHcT3CCboNTdOztWc/f+Hrakzm1gY6Wtkomp1UUa6C?=
 =?us-ascii?Q?U66e2ub4MjCNGtmdwWenTcTtWTfbodJOxp1OSieOQR3DmK2mOQScl/ohnP1d?=
 =?us-ascii?Q?S0J6JrK+20mx/OcAfS2lFBDfa9WF40EORDW8wGQXz8feZfXRR64rad7vx1iA?=
 =?us-ascii?Q?AYHJAIgnQfyx7tInuu8A36JzMw38FA00rKd4iXQnoTLoFahudV3E6RJOzXkT?=
 =?us-ascii?Q?7eDn4ONBEFXK/SLZEebhU4QRSGspdC84KedWRdzlqFuGe7EhJmWbJxu8O4hB?=
 =?us-ascii?Q?w45VwChQCqZLOq3izgC6f897L6eNBFBz2Zaio8iHWFNcTQXOiyUaW3l8oixW?=
 =?us-ascii?Q?ROGmGZKYt9vMsupRM1igHBGzdUKxBg28o5n+mqmeHpNs9fWXsfq9bUeIYKiT?=
 =?us-ascii?Q?PTM/Pmjas5EFcjiYVQFUf+1b6sqLaUp1gs6WcyUcWH5lwRJ0ywYMZCysfTXX?=
 =?us-ascii?Q?Sg9vUqTwZ9JZmijR7PG6a670KfWTA9nJBYm3Dkk4j7EwajIl5+gb9j/UMT6E?=
 =?us-ascii?Q?eX/ZQ6XeUbYdVP4s79ibpXfsYZC83RhAbApL6ibftJz4JOn+7oM0Fq/3wewl?=
 =?us-ascii?Q?44OdHb4xSUYhh2fE2sfgNMh9wSckta1g44BDZmUWI/FsUV7WSdl+EQBg0jgH?=
 =?us-ascii?Q?7RRsQAAS2UG1DTHMVF4ZWQQPQrn9OFKFqJbXy/tBU33GQ5cCMGiIYR7xpLjb?=
 =?us-ascii?Q?S8xX48vbZtR3hfeOYaxSC8iLFRE/9l/aXr9xIn/N8Z3jvEFtme4OoK2gDf33?=
 =?us-ascii?Q?vITytbr25Q+joRP3Ah2k4akG/itO6APGegNghs1H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb9f702-bf3b-41df-ee41-08dbac29311d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 02:55:12.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or5NoH9ETLw5qVTpiO5zMYJvpYxsziANeWVqMC8NphjEFtNA36O9r0PqtCYbLD/i5hul55W15AKUPsQtMBIThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:20:52 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The decoder enum has a name conversion function defined now.
> > 
> > Use that instead of open coding.
> > 
> > Suggested-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> Perhaps pull this one out so it can go upstream before the rest are ready,
> or could be picked up from here.

Good idea, sent separately.

https://lore.kernel.org/all/20230902-use-decoder-name-v1-1-06374ed7a400@intel.com/

Ira
