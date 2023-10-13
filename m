Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5E7C8BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJMRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJMRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:05:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD5BB;
        Fri, 13 Oct 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697216743; x=1728752743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qt1X/yegfKhvMKjYtgBl6bS5dOEvk9c2w/vbH9Hp/Kk=;
  b=GAIXjF0jO3xoW26P98aRKvYntMJO6MyjRtd0d7CS1CJ1RoxbiKYiSwPL
   Sp/Kr3+vGBlSoALYn9HxFDdIKY7jFhIsTtLxc57pFrhV4/2Z5d9j1vLgp
   Ttf2V/9pkL3722g+BkgqUcBBwXByvpgMZyxoFCUjybPeImwPHjpcfn5+E
   ThaLITSkcdUFs2I97eMdSnXlTNBJti9V9sgE1Il+gusWe8UaWZpJNSz9N
   xqJshekG8PUxWcM6aZLlKQD6+Aa2jnhFESDHOH4b/XTJox9Z4GfgW8+UA
   Dts1QT160qVZx5HSBkjeVy9G92qM1YOuJLy7/pt+z4jwz11ExGX21w9q9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="3826472"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3826472"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731423482"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="731423482"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:05:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:05:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:05:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5BOSdsnrwWfQLTxPzbDP17sUYYBqL0/kL3HpGc5oEfYbUdqSYhKBpYJE+U1qLMpCstXUPXkEKByu7LKplehr35Z02cOZmVP7sA8Uo9cQOgMXtYHAGkVWsBuhFUDtRxns2VkpRPq+yvfT5HqxAHcnMKUpjGXd971dt/WY1hdhmG2KcwMlbw+hANfbBsn8dIWXfqVg2NuYw0bB0E5nb07S97xqOG22kOBylYRBIB5LnyrPqhnKWY/EPpbnFE3HBGkyxE3IU8zgnFYf/sUYM0IVmRpfGs5B+bgtKdo8StkoEZuv6gRFXxBAhqXY5S6meCHNVj2XOhdwcx0SJwQ1+wkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwKa+18i6VPd81L9A4n+iCkrp4n3ksBESaHJEJN0tJg=;
 b=hixXDJtObO9EPrTGQ0eDiE9RZYMyq6CJRn6rKfvgKXQgNW7OuCzYJAaiaiNEsqT6l72NOBWFwr+CrIWl01GWp8a9pU9TpsYMmdPBo1zoFGFJK/Mzqmyg1ikWHwRpXkfvUmRpMz28lQfbLx7HxBioy/SkKkaVHsvSjah8TlWb47nSgKh8hzXqJuo1R4sBzoijIYQLp5Q6vk7bKXCj9/vHxoS8yuj2MXchEz/b/ERIeRWOyK+UkjStOtzOeajyZ9uLMZ9pY/Zr5imajRNQlG715Mx3KLCHH3Gr5lO7WI2pZ0xJBsFXZTDN2nU/f/S52/KxqFrHrqWN+261oFxhR2w9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 17:05:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ec95:c199:551f:2d11]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ec95:c199:551f:2d11%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 17:05:37 +0000
Date:   Fri, 13 Oct 2023 10:05:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: NFIT: Fix local use of devm_*()
Message-ID: <652978deafdf8_f8792944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231013085722.3031537-1-michal.wilczynski@intel.com>
 <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f7441bb4-c2c9-4eee-9fed-ad8b28de4788@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7441bb4-c2c9-4eee-9fed-ad8b28de4788@intel.com>
X-ClientProxiedBy: MW4PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:303:b6::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d48b6b8-0ff8-4ca7-ed05-08dbcc0e9ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlKDn7TCjn7QpmYstKyMNHCsqnFlKoQCRMpCytxYpFUwm9UrQy0vIBXdtnsQGty+C814knnZTsABoHFLIvzykgeXpODIJ24OSfk8lORpNIevLFJtfC8HCSiBs3q7fU7xuxrYO4i0qUUAD8ayNZ1TkaOYFdzSuueDz1/TSlnLRLCE1ZanasxiC1dxbTeZeQetJwLKd7TXiuD/q9Hby0wrpr4tLJBdHycD7uiwSEqZxphHIBw84qRJaonyjmmmhF5HfHBc1NRCu+5fgRtnxa+2O/ZGlCZNn7cR7Au95lxc3ABXwO3s1LI8KlBOazOzMhoKIhddJMgIxvLRIISr+dOMF9VeYKZDJZsu3JuYFKnAmQOQEOw6KCFTTJigEdz8Zat6iabVl2mQqFQcALqbFkOVw/NLtebyn6AdCM0TbA3ZneqHH26QY1i7BSZHLq1AJLqGuiJKuLq2AsOdp4MRZZfefoUkU0sAak7w0ifpGI+C1gkPL3DFjEprVxzXXrpLsrmGoK/JeZSA2Y+UVlcTPLO1X2S1C8wKSOSkfnddh0Clwr0ji9XEBZj17y94WYjoSb8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(38100700002)(316002)(82960400001)(5660300002)(26005)(8676002)(8936002)(66946007)(66556008)(41300700001)(4326008)(478600001)(53546011)(66476007)(6512007)(9686003)(110136005)(6486002)(83380400001)(2906002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bBBB+gdvpEV+HVxFcdseb3YpfWn3PBee8u+lmgzKGd6Ghnj4hA1c3IgydGjn?=
 =?us-ascii?Q?iW0CidEBuudADqns8fBVPpkUuP2v1gwuezAJvAZnImDYZKDMlmIiE9gNftP7?=
 =?us-ascii?Q?hypHYzRHH/REOwmyTjxXmJeHfZPhI8abCK3dLTQjU7bQB6YInNBf0MxUcHZe?=
 =?us-ascii?Q?Ce/vNTLRWuMuF1wDVQ8hZ9M4f1FAK1lG4SRQpvduay5B6u3+fUZayoM0TlIB?=
 =?us-ascii?Q?MhyJ6cRgLH4xbf0ksstFg3XsO4VmD6rXUyTe1VPvPbMoxn5J5xnQAqZhAge3?=
 =?us-ascii?Q?pAwByZWt4gJa96eKg+Zh4MikOGMiwr8zuNPSQYIx4NQG89OIlIYxfwm67Xrz?=
 =?us-ascii?Q?1Wk2SCSad8szWBVlfd4FzI5ycbQpupSg8fheUQrKLcpiuYmZ+6ea7sTCGKHY?=
 =?us-ascii?Q?ywXSMH2ONUzX/MltxxdedaCXfz27u5AJwQamuoHZU6ldSitRKDKfBEB1Fsdy?=
 =?us-ascii?Q?2vFu5yzg1XN1jcUDogrS6i9fEwtnC4Xzcg/fEp1dYcmDGptO+ptnN4tp7nn5?=
 =?us-ascii?Q?ts748nY2Z4ReMKN8MFvFrih8CrnkT4vloNjllzy8i+A94tpm9eapd5woCAfO?=
 =?us-ascii?Q?U0y/EBk88BAUoQdfvKdZlmh/Wzi1/q2traAmdH4qQd0XYI6111Ripz+KroS+?=
 =?us-ascii?Q?oVg+qJqFysjyfdCOleVmX/yFgnlvhNyuBjtwj/QiJTQsoEbkt1pmCSn+5PwP?=
 =?us-ascii?Q?3/xi8XcIUK/B/Kb3LIL+pHRjAMbJZ6cOBLy/bQZEJSscCJyNUS1HUdNFGtMH?=
 =?us-ascii?Q?v90QcTCOyCLI/MUG/J7wroeZvaik99KV7e7O04g07n5jJL4d4Gn2eFXK7C8o?=
 =?us-ascii?Q?ukNvhz1YoTF8Vf7ey2wIvtJx79ksq/PCWPEGdgRTxmMS8eygco9we8zEbMp8?=
 =?us-ascii?Q?vNWqJt97ONLanKsY9bY1Kh9paundXgkNvXhb1Eit9Bj9GweMJMdb6NFRFQCS?=
 =?us-ascii?Q?D7E0+YExx3fO53C4OKYC5LQ+SejkYd9SMRTeG0mHSRuhQhLpNTNCUAXu0MA2?=
 =?us-ascii?Q?dBdkR8fF630v+ErR2dsbRKw5p1mMBGr4vbx4IIs3ZRWrWIK2NKZymLd0/AwO?=
 =?us-ascii?Q?zmkDMgKqc4KLa7Ou6iOSNhYDSn0qFJcQVB5fzjnWalF/injakeSfH5aQ770k?=
 =?us-ascii?Q?zOdyArOiXKJS/DrYYA4vgrO/2GSudlhoxfTxFfl4s/j+vHt6yfCDeHOp2zzn?=
 =?us-ascii?Q?WhGrY97WPYx5ZcU7xDOimBZQ4IqoqZtCvhKZV3AKSl7vZ4Vu26JtLDQFZe7S?=
 =?us-ascii?Q?RRijtDMZKWf4zUqv0J8KcRV83PeQz9/K096ECUTDAkrDqibm+QYs11qGErDL?=
 =?us-ascii?Q?uz2lJNbpQVNXkkfvwPX/dAua9kUyWxYmd7gDWfUnQrd5Wol1kQ10Gt/r7vEC?=
 =?us-ascii?Q?iCdljXfSrNpRolwrDUOjf8YUl5Szq3I8xA3CbmV42MYjGNdFab+uxM5J4Vcy?=
 =?us-ascii?Q?qmZqO/Rzs616tPzM6SwGObmu+GG4bqAC42vJEQrs0n5jIMXV3Ptij0il+toD?=
 =?us-ascii?Q?8kbPFLGrNQmyQSwhlw47KfxWSYZaVAVwx1CqH9jwI0xKtCfMWSI1BG/mae87?=
 =?us-ascii?Q?5GKYrxAM2TsTMojoCwwE7uR2ZxBjtJKdevu4zDq9NULh/pnv37H7w7cjfwJq?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d48b6b8-0ff8-4ca7-ed05-08dbcc0e9ee0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:05:37.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoFOwTDjvxHm18pfjGJUKOaL++zyxk4n1MQbCqydvq0Fkrzr86l64ba+4ILtqckEyzPzPSHdxrUIuiC4ZEye4OmG1kHY30/P/oMI3KJSUcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
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

Wilczynski, Michal wrote:
> On 10/13/2023 6:38 PM, Dan Williams wrote:
> > Michal Wilczynski wrote:
> >> devm_*() family of functions purpose is managing memory attached to a
> >> device. So in general it should only be used for allocations that should
> >> last for the whole lifecycle of the device. 
> > No, this assertion is not accurate, if it were strictly true then
> > devm_kfree() should be deleted. This patch is only a cleanup to switch
> > the automatic cleanup pattern from devm to the new cleanup.h helpers.
> 
> The memory in question is only used locally in a function, so there is no reason
> to use devm_*() family of functions. I think devm_kfree() is more for special
> cases where the memory is meant to be used for the whole lifecycle of device,
> but some special case occurs and it's not and it needs to be freed.
> 
> This is an incorrect API usage. Would you propose to change all memory
> allocations currently being done to devm_*() family simply because devm_kfree()
> exists ?

Michal, please work with someone else to get these cleanups upstream, I
am done with this thread.
