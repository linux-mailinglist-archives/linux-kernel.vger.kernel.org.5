Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999387DA45F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 02:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJ1Aca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 20:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1Ac1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 20:32:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A78A129;
        Fri, 27 Oct 2023 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698453145; x=1729989145;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fJwbtzDAoaG3nAbDfr4PPX2bqQxKsD8wj/l0KEb27M4=;
  b=BZLRS84+B5KhiuBVVtDQkbSSrk2dwydzhBIzvZAHov8Li6AVZDlFdpmH
   RWIrIp9cFGQDlRAu37Ffx3IChDwp188M4TTWZKOMVTKicciP4devxBB7N
   dpLXn8QdVv8I8hJhRXUPyzijkXp/Nj/geboJLCPGREBwTNp70XLZKlzU1
   dbhi7BdFmm6c4YQZveOXE/VisTbvHXyQDdkM8jBgr1aeHM9ywsZVO5Axl
   vNKbFUbPyA1krXiRY4zjlO1cDOkyrLW3Y3kqcGVmV6s0K0ZmzSng+IUFr
   OSgmSRZiPszcdUwlF5nrEk5XnYxWD7n+tDWv49s0OsxwPGOthA2+9p+mi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="454337811"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="454337811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="1000494"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 17:32:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 17:32:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 17:32:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 17:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlDcPIa6jxh3v562rWUWQGGdREyL/5k4jzhI1qXcHPVkMzoey/4bjKEchi3diFvcg1OEoPm1tsnX8X8PYmMNjuVk0+UcQ90K998CgG40Us1eNAH7ZP2fzi4q0m62+sM7Fx8TonHK3TxvoqyWjS8uLNt40ViNc/LZ/ybt7iUPj//4+1VSGBW+XdWklyzHxJniwBGMsZcv8IwN3h4jx90tLa2Zno1WLOMu7pvZjXAyhXBu3Tthe4UWnVnXxas8Br4ct3uuR2GnZb2EvowVA6zN+X4Jxtt+xPINvQdHnbZhTpeSRwo4UMcoKcvQjuXn5zzDJWi7KMJm8Jt7N2gw2PI+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0JFiuYtxVcrW6fh5eIwjKt1ORjLXHUhoMWqai85Ohw=;
 b=c8535iuxERshFgqHLBcvGEJ6mXFVIPAeS/o0b47jczQihY1xbdz13UKADAWkQIVyzri41zg/l72XHHrwAb54bZa3d5SQrW9xEHI4fzjjtRXVKVp61+bK7071meEThPV0AjBOHg+YHPi774vmyNluQ1og0jELoQwaUGBV/tySGkYr/wIGmM1KKLYI9ciUnCtRvPXbPcZUDd9KH6YIleT2yoXTKSJZs3k2W5Uo0sx0Ih8KR0EJAtCJAfecMZZ+B42Eams5U6CAq55i25AdQ3Kmvkl9ReD7zGhCDLh6PCOeuEYFxkB4DLtO5ooqfKuOU0ghHNntNdhEF7wDpERf8XZ77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sat, 28 Oct
 2023 00:32:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 00:32:21 +0000
Date:   Fri, 27 Oct 2023 17:32:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v12 01/20] cxl/port: Fix release of RCD endpoints
Message-ID: <653c5691a2372_780ef2949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-2-rrichter@amd.com>
 <653b3299c1a33_244c8f29449@dwillia2-xfh.jf.intel.com.notmuch>
 <ZTw_xd2_uaApAzoL@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTw_xd2_uaApAzoL@rric.localdomain>
X-ClientProxiedBy: MWH0EPF00056D17.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1b) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 047db141-d9a3-4527-6380-08dbd74d58ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNe6duc0m/dHhMnxYhQNEX/SojVEqVOuwTfwjDujMa14kkRMVLg+F3uHYaMlFHSPN0GBps4uUd7/7AKPbciHufFSegTMp0TjnSTJ6DFJMcnPgAtENJfB/kE7RaS6Rd+quCuQwTAG5DHtLIIhgP8vXghAq4u7nDqqd4ohgF6lhwgz5aSvcPIkv81ljLQEWd8x/RKiHEMotKvnLEqz6GQ7McgsCSYtUvagz64eFdAtFfFemc1ktWdJyz1SmerauAwOvQ7dEZnR5ouQGYfP7BF/KhSqm0mYPY9wT2oy43lyENP9e3zVCp6+ThYKzIBD4SCeP1OpR1w35gWNsnYyqXcaTPNuvkUitP4NwCRdE08Dx3xz2ckf5Np9R+mdi/NBGyYTGcJXGvXozL3UlBm+UlOwWvq0chK/wfm9i++CFckMsYsIrNM9D3y8Lq5YECZeO32YhOdWiG2707JemPOq6SbbzGXNHrC5aeCKAHw+IvlzOlfn6ktKpir6t31boCqWmnnzV0fZdfbiam52/pozREBUUMeehoDp90SPxRjKuWJzUDDzaKoRSBTEWoFUky9+bRIj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(26005)(6512007)(9686003)(6506007)(83380400001)(82960400001)(4744005)(8936002)(6486002)(8676002)(478600001)(41300700001)(4326008)(86362001)(316002)(5660300002)(2906002)(54906003)(6666004)(66556008)(110136005)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2XQrKOUHmfC23/3HUwt4MIPCYJBHKT/HRCcPCeXwXBr89nDP7ebrN/6/7QLS?=
 =?us-ascii?Q?K01ZwGl1pJbryu+pqeM+2ZbWMQbK9PSzt8z7i0WH51qMuzgeWorpljmxac41?=
 =?us-ascii?Q?qbh1tga5vvE0UNE8BNB/eZqyYHVT/WmcLiObwUSHRt9y5l/kSWGqfqi8IAML?=
 =?us-ascii?Q?3VdGn3M7kvmZ/rO7C+Q31ybm16+ZiUCvHNEJQ0S4A7huuTogCF/nssQEoYZ+?=
 =?us-ascii?Q?sRWgPVyCY5qShXs/Q5eoH0diRS48Vw/h4G2jLVSeu21aMXcBLBXJN1aw1DJo?=
 =?us-ascii?Q?SXKIZqlJUcUyRzcCSVvEL6qvBRWHEkhGOALXo2KLyldO7Hvnby5CLuB6TrMj?=
 =?us-ascii?Q?C7Y7rXB91gAuUA0gEnM2L+vAf3GlZEjdZUAquJDXaepaCNB0KAYwPL0Alykh?=
 =?us-ascii?Q?9JYLQZwbIgBG+zcagePBPOPFRH1EPDftAqcV7r1LdQKKRox7kdqLCy1kcnEi?=
 =?us-ascii?Q?GUN9dNtr8gQDULJd7jsmdc3yJkrpN4LVDO3CDe7txrx7STbHGSCrEc6qICG7?=
 =?us-ascii?Q?5QDrf0zv6LV4C4/EHR/iGBnWQjfoSryMe42XUu9ZbSaNJoc/FW4OhBq1Awqw?=
 =?us-ascii?Q?tEZexVsnX5ESqhelYis7mRuI1SYYlQ1dMz2Tb9m25xwjN5mCefHea8fa1ev6?=
 =?us-ascii?Q?kjWh3/LUzmmmK4RLBAUzd/RgJyDSiLqlfdqFI5WK92/yEP8JEUYhCE4FUzSE?=
 =?us-ascii?Q?vBZpiWvPB1M4PINlCX7IRs3Ku6UFwgJmdYt49uwNyw816jwRSfWR4KT/KxKQ?=
 =?us-ascii?Q?ERf2KnqUYmjF/PybKI4jOQYlabEhGYx9yai14WKzSSemWDSNQbZ8Nb/X1n/o?=
 =?us-ascii?Q?6CPRFkPX70zZRnVsPTD6anXcaF3wCzzp3ozQdlMh3pHTJ5KOB5YgMsd+64gO?=
 =?us-ascii?Q?rZudjo4w5vfhaqWbPrq8eFnQM8bb7K8Ggmhfhmvk+V2FrOjcOGDQdk1Jwp6R?=
 =?us-ascii?Q?0UhlSmpniNAy8OhhDulXKIKpRIa5HbRyMCORJuRg7vASpiyJfLnfDaWBooqR?=
 =?us-ascii?Q?APoTLEh5dYCPmCXrC9o7JxlRkkuO0RhYLSk9ZTJCQT60a5qymaTU1YIDnGh2?=
 =?us-ascii?Q?zlWbm7/1Q/cPJtmgktKM22qvhttP3JA6DiHjHqDC5W60LPy74X4mv1h2dbMY?=
 =?us-ascii?Q?3Pjdsimn3WuOyoPIrRn3nJX1OkXw0q+A9VfyLa2kEP4Kixllnbb0qH9Axoq8?=
 =?us-ascii?Q?nmInNp5MOll06g/PGbn6ZuskcjO0MgYoo8vcZvndohJLgJrU3t7/x0Irssf3?=
 =?us-ascii?Q?Qqp3br7Cd4twmQDabjFg5a24a8JfAGvygDV0EB4wxcaiFql/fVSq3Rtasz1C?=
 =?us-ascii?Q?VJR7cOiKw11ipet0/bllpT23C5eAuM0DDVU3qdGOSNpmMpNII69gKDHxfWEJ?=
 =?us-ascii?Q?XuOvTflYgjA9VfywSUMnkK8RVNOBlf/S9OcOCthfn2Zva9chREwpq/Edumi5?=
 =?us-ascii?Q?/KoC6UxRuWXf+zMF+1hrJL+8fpv+W3osrDcqW/gW+1kPr62SpKW4H4tzwmlo?=
 =?us-ascii?Q?m6//tskzfCItQIR2Qov29obJMsdm0nt62w68Gxafhisx+W24UV8Ahn8K3A3l?=
 =?us-ascii?Q?nO7yUZjkGr9FpxnP/tepEIaI0rJv18qyya0EgFTIdHbUKcL74MGz2+rIr0yg?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 047db141-d9a3-4527-6380-08dbd74d58ad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 00:32:20.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WXyYpuYUeUfC/8165uWTyrCfxyH9VxqY+tPiTeUZXoaPDx/kC1XvjU2YFe27j85+HHO9TYsPj91wtVuHkyFuCxbzOPho0ag7JyzmcLvQ6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
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

Robert Richter wrote:
> Dan,
[..]
> 
> delete_endpoint() is called here, but the uport etc. is not unbound.
> Which means this is not true:
> 
> 	if (parent->driver && !endpoint->dead) {
> 		...
> 
> I don't remember this with my patch. The parent is there different, so
> that could be the reason.
> 
> I could not yet look into more detail but wanted to let you know. Will
> continue.

Apologies, I didn't have that regression going, I think I see the issue.
Thanks for the heads up.
