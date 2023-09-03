Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C043790AB6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 05:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjICDic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjICDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 23:38:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A15E1B1;
        Sat,  2 Sep 2023 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693712307; x=1725248307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6jb1KHIhmaLH1Pum7U/n5w3MmV+UU1sExE1EZH87fKQ=;
  b=XJy9SMT/jd7v0Gj/9V52I1Ya+En61UP0ak6GUlmL2i4yY/6uon8xUpXo
   UlYKV68p0SQjyHXzj7wI/cMEamvGPPztWjjzKdWdLHirQiqBVG+UYvZip
   /04XRXJkw0z8UyeWKRWTCFpBB7cEgSRqW1XVIy8QJx1sI5uuaXlN+PaD6
   n11zfTZYtaDfowAWFXKixJ0IF1NnrhxD9l2VQ/a38GfbrnoyS0USctJMq
   QYmbD/mgVMWP5IvDYuVRJSRyyr9UHIkFuh5PQdEm72TONHfJCoqHxljO3
   fAPI1vXLRdr8JQfNFxyrDfm5O6dZV1bFKmWfuuB8PmrJ8308pWbHfoqHp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="442822530"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="442822530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 20:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="810506879"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="810506879"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2023 20:38:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 2 Sep 2023 20:38:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 2 Sep 2023 20:38:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 2 Sep 2023 20:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ino8BQrUiCJqpC0155VXmyVKAlNNkm5kOADlUYy7ZlLidFHH/fXiohizD+ar8bS4vGwIFMUv0qN/6KNCSmaK3uLh0XYnYaujPj4P9reWGU7Z85BWYVM0h/bG1nuVkaidISqO3PlIwfT1mK+qarxsS2Dw9fgZnibXGXdEK2Ux97LUZubps4JyJvqiXSaSyaQSdlWT4ytKlHTymvjqEgfB7UOScIZY1xXsNfg8vRNkPCFkiOUc1tZMBe9+/WEyuSRecD52ikDdVORpdgdFEYFmsXYwUybTBUzpS0lmDfGTLyEQXrgtvFFJLnW5efQeFBps6CcLoLAfG0FGrUj3vnIWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqv44CrSdr0bvINbmLYAqw/GnRF2mEfkV+cHcnzeOL4=;
 b=MD0ppDlTpaQwGWP6zKnI2AJQUV1ffLwfrAfg8XnYj/JPWqIoo5LaOro/pDdB1zIZrZGms6BtdET4sPse2dMC6eFyFP1jzt+CxSDCjCw2RfKIRShF9WcbPr8CVz8TzWjPWYdBbBLDFrFGq9uHaDe5yjCLz85dll4GnpU58IvChOJYMxh3FVmqGVaVJxTkdjtEt7XtrTVhtolVCESIQvbxgKQoHe5T65LbDXCk5DqyT4OCUjLd0FcssakPVNueDpkwynZ/I2IP3jmmAaWVgqBkh1lBpgwEvrGtBhRW+VUESa28oC4xn/4OMPJsLon2Lej8aPeFvzS2KpCPRISRsY4lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6305.namprd11.prod.outlook.com (2603:10b6:930:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 03:38:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 03:38:17 +0000
Date:   Sat, 2 Sep 2023 20:38:13 -0700
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
Subject: Re: [PATCH RFC v2 02/18] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <64f3ffa572f2a_1e8e7829410@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-2-f740c47e7916@intel.com>
 <20230829150732.00004181@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829150732.00004181@Huawei.com>
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3b66a4-d340-4fdb-0fdc-08dbac2f35cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJvNOqD09bKRSVV7YexluDuRZVUc2DB5HiLLFKIJ1kl9JlKlsl8ZD6pwKHd1oVcAM8jFm3h5/gRmNUDqj8uaYNG+EBs7K9okXifj4ixs31TvIeHuu5W0rAh+lzQHnvYDz0fh+IXlosoGCZS3naf/2gsLfxDHp+6daDISLXPbI+VY6sWZ8RgSKK/pVvUNR8Go120RAQKJua05w1Kr3WhIUqUTjPGrPLqTiiwVKWGsFY9kPzpYlc8h29jPId3EBrsyQNSdoE0FdiTWwVVy9XtIj0HTiGE9VDQseLEiuR5BZQvlubIF43il37NGXvWdh2ODEHFOPUPk4y9EPfbRYnG18EJUvafsNpnCOgQVUSM5pVsUuVFtGThquM8dvmlaktRrDDizLj6APmUFhfQUlJRnKZmHct1BzHEDqvxuYlyVUcmbHutKSTyQq/Subuc6OxK/aon2rSre82TwC1wkCzCdv4MRRkmJ+kO7UwFqJ2zP5NH8iXEELO+7SzuILnfYwdWm/ADBoJiOxjqq0CwfihoRdSIyR2xg0wrzVnNwgA/xlKthJ58pKzmLbwxiQtTzvn9W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(82960400001)(38100700002)(6666004)(86362001)(478600001)(83380400001)(26005)(9686003)(6512007)(6506007)(6486002)(66946007)(66476007)(2906002)(110136005)(54906003)(316002)(66556008)(8676002)(8936002)(5660300002)(44832011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RgRbXnF1OIG9QNT7/NnGoHNWUzLPp/Be21kaLxgi8Dc4llKXAGnuqyZ5pbC8?=
 =?us-ascii?Q?1xv5LJ3suBVEOjOIRD7hzqIJLvNif0odJ4VsfDZnx8KsxYoDToaU903raByV?=
 =?us-ascii?Q?07eyOacVyaV6CVuDle1YBmRTU/6KHkVcdg4Io1kEqE0oU2R5VeX98gSq90iO?=
 =?us-ascii?Q?A6QPQ81gvIf4gAVhYnJwhzWCrcH793dRjeS08Kc+Hdcsc7daIncTFU1CJnLd?=
 =?us-ascii?Q?wm7w8aHOAyvpQsQdsNE7dVSodl3YfDKV2czouHhq8cTSeoM294ICvHzJjlml?=
 =?us-ascii?Q?C4jKl/BXg6si06fJuhI3xMnKiFHsUEHZ+GsL6tyoJTaJfia3XDM1HR3Tsib3?=
 =?us-ascii?Q?Qsupq4+nC97PIIMWT+/xyaxntQ0RW2yLGYOUwoVDj1s5lG5WZRS3Q9FKzGld?=
 =?us-ascii?Q?eMHfKwpIKLmmIzPtvkU6lFaZRyEMVbtcKQKC4HqGC2l34g8tB24Ny8Um8a+e?=
 =?us-ascii?Q?o2UroOh33Lvw/wzu4id3iz75bpRu2uHwyv5sDjP6WWMcpP9lhY93YgqVSj8g?=
 =?us-ascii?Q?Ljpu7FwHng+LvqkaLhmU8eSkFGqZ01JGVyzzWCv5MQrZ8oDnpmkOWR2uBUwq?=
 =?us-ascii?Q?NsFGMGxiupB/sSpFm5z71niIm3KJK3lB6zERsg4JoISCg+RiIlQgKQNXXK2P?=
 =?us-ascii?Q?P2Gcn1E9xcEoNz63YBv4/+TYY5QViV4n0Ld75I+6tFuoDC293Vv8EPdMvvf4?=
 =?us-ascii?Q?cn2+Cmk19xMVE3+kr/jVL3qhlSt43wFqUG7peiOfNFkZIov/gu3mXAXBGjWs?=
 =?us-ascii?Q?bKb892+b9fMwPwYL4cdznLwmhyJ5jvLvUKC2snxpvn81hKKsvu9InBFaQZxs?=
 =?us-ascii?Q?z4vy2+Kmxq2mCSNgARfx2Oxg+wNiDAT7lf2f3jDlYIhjYu023fYqHRtGRxGy?=
 =?us-ascii?Q?g8abn0oWddubKSNvDON2b4vROLalBPmEowEQ6maeVqPrONuq/jIFR5ES9nZQ?=
 =?us-ascii?Q?sk4K6f8It6s3IlJGDcS0YvtlzT7S+k89Wbvu/qsAy3sgfHTyD9wlgaG5D2ys?=
 =?us-ascii?Q?+xMV6wDx2WvqMI/WMv7B23amp307ecAz4RYavzvafY/B1SRoc/xAg/1c6xqX?=
 =?us-ascii?Q?yc5NvB5UEQW1C8GmYXyJSYGqhw33nDnweS4Uiw7yp5JZxDADgpmCezFUVUOH?=
 =?us-ascii?Q?CXrM1BG4BzqqsI0IQuyX1dmKFmdYY2cBPhPEGSn2zBfLVzzlCLC7IU485+f4?=
 =?us-ascii?Q?P9nrti4YuQ1VBQhObh6B5cuUEkGsr67r1ex3fZtgtX+cp/hwmrCU3q6xRvc7?=
 =?us-ascii?Q?GV4jLPOx+Sp4xagXSh4TfNzAfYccHCZCURDV4/t1jK/cd6XikFtVIPHu+iBr?=
 =?us-ascii?Q?cfc59eQfdKWgnFzv3v4SuvOc087/wrQy70n4TJPJxMxWU5kXWDWI/IFNhII6?=
 =?us-ascii?Q?60XtSlUXKH5cfiDuE+aHAZqRSMnib605wqz6aGn96IBSyKnjCOSOFryLI0OB?=
 =?us-ascii?Q?VcI+9k+fu8DPX5wBpBLZvI4Ye3nz9PJIr07bEtu1ptbuhI9d7Za3ALZ9o2eZ?=
 =?us-ascii?Q?278vJCJ7Z4muvn0CXivbLfltjbkHqR377uC+ODLMtbeGhkVg7nllRc3OEjZ1?=
 =?us-ascii?Q?2KOp5YE9pB3ygSWqnQwN+YeeXLto7xPfcdyj6w7f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3b66a4-d340-4fdb-0fdc-08dbac2f35cc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 03:38:17.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwcSS4QaVEshnEAknLw3pT4sKfdOJQydzUTo/u5bZkdRnyLBKmzmUC2MZZuFpavSU3dxog9t6Z+pC3DkJId+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6305
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
> On Mon, 28 Aug 2023 22:20:53 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Per the CXL 3.0 specification software must check the Command Effects
> > Log (CEL) to know if a device supports DC.  If the device does support
> > DC the specifics of the DC Regions (0-7) are read through the mailbox.
> > 
> > Flag DC Device (DCD) commands in a device if they are supported.
> > Subsequent patches will key off these bits to configure a DCD.
> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> Trivial unrelated change seems to have sneaked in. Other than that
> this looks good to me.
> 
> So with that tidied up.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> Thanks,
> 
> Jonathan
> 
> > +
> >  static bool cxl_is_security_command(u16 opcode)
> >  {
> >  	int i;
> > @@ -677,9 +705,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> >  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> >  
> > -		if (!cmd && !cxl_is_poison_command(opcode)) {
> > -			dev_dbg(dev,
> > -				"Opcode 0x%04x unsupported by driver\n", opcode);
> > +		if (!cmd && !cxl_is_poison_command(opcode) &&
> > +		    !cxl_is_dcd_command(opcode)) {
> > +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> > +				opcode);
> 
> Clang format has been playing?
> Better to leave this alone and save reviewers wondering what the change
> in the dev_dbg() was.

Fixed.  Thanks for the review,
Ira

> 
> >  			continue;
> >  		}
> 


