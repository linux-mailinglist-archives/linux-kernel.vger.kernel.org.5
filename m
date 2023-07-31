Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64876A3FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGaWNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjGaWND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:13:03 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E999EA;
        Mon, 31 Jul 2023 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690841577; x=1722377577;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HVTwOeTmGhO4UEnxph7nmVVhbLPV3Y92UUuAN9V5fh4=;
  b=j38B+DHB3BUbQoewyAIaW30e+o2QhIpvzkrl4LnrFvQ5OLsLg5c3Hg1l
   7hrslNHPC2X2Dy8BJqo+FEgp1fyUjpY4TEUDm7etyxZUb66RTI6DCneE6
   3BBUp7oP0NPmg4KPsFj+6ahe/NY3BUvFPJi+ak7ySGfMWndpoupIUhhM0
   Dh5liyYGGkQQQbn9zxMgmSmrg/To7eqs+VB0f8hBiolpCU/QdXkJUuaNp
   fRu3z4g2BaZX8JpD0k+P75QoIN0Qs/4rIWxoob690cg/H1UX6S1JNbzqK
   VYDG8KXl880hiVBQNB2sp94SFDKDLH0MgcK+PKh7yvEGc6PaV0lgFpa5L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368040385"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="368040385"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678468727"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="678468727"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 15:12:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:12:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 15:12:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 15:12:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1jjJ/SyQHGOKWW24Wp0U6DeNV4eL41u7yRCXoit+l30c8V2jejeqzbBIKnMpUGjQccLL+TZA0QXlmacd5fSiSE/p39RCXECuOm4QHkX1XwfhxT/YYtiZ2rYCuEuFmeUB25RSgV2DgyNt80j8cfJFbMMYNUvD3rPwe9fVjBNV8ebqbQ+42lW8lxbPY5L/Cn6WvVOKvvoaYGqkrOkfGne8LzXvuQSKN9PQ6FX/4iMaK95MOIz7WR/fUyB2bd+281MVwhpyXPBqaC+Usv5ibM838WK8BjdMD4i2HYIxwKIJ5Tyt/+OxD1H5CThF+bDqDUIJLz/O67jP38UUwfmS/oGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQa+ORU6X2rzr6tHQLZDYB2NlGt6/wOeeFggCnaFTm8=;
 b=UBogKkZ1qktSLuvveHd2ooTlA7++s0pxjU0qPT8gCR6ROjdXUVGsZyq1jeIZ+yUXpSRiHIJ1vMZT/GsNDx3KOSs0PEJqD5mHfn3V3b5RFVGxizzvxnqw0frIqL6jt2usy/mKjlAflQqRehhBvx/AOkoG4DD/HpP8onYdvb9zrKIqEQz2YTTCFEQyi5YwBAYGArPEqmAjKT0yDxa3qTqF7mGwieplj69dLmScC4Nor4HGX3p8z2/Xd0OfA68WIev2j1yvqiqVbtXR3Z78a3d52O8acfSwEsRcWhzDKV6/js2rWz4PZD2gg5/mN64XyP6ZW+Jr841RfJN/6TQBasEL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 22:12:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 22:12:45 +0000
Date:   Mon, 31 Jul 2023 15:12:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] cxl/mbox: Fix debug message print
Message-ID: <64c831da6af64_52483294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fbdd4f-e711-45f3-73c5-08db9213445c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vePxYI7rLJ32RBIXE/BhcxH+bWeF/h/2+9YQNKZ6Ir2/LS5ltLUDijY8KEFbVqNewLgmnRWFpJ6fo6eN38DU5KHvjDa+62JjiI0AeXcb6o35YIJ2+L74aOZddGixiwgYcrqm+2+T36GqTCk8s7tL78fCZsvo5eAaQcE1P2/KlW0GMPLvii7gi8jaIU1ot7wRclI6rxZ4aRbLDrvCZdzLJzqXXqBHp4NFUDJAOSv9Nc90IIBrKzXKniPXOlCbxjR9iZoDgQllIJH14WoyAbXwLkHaV+kSkF2DCRsjow9HVoyIv2UdnqcA248qVX3fVW1t3+lGN7yZbBq+nBdGEHGFT2MDwN+FgxDni3My0DO/Xj6A8KCdHbRh65w33lcobwHfd2XtCfccqnJXKfhbNyb7xRJ2c72sbe/Lc5c3jGF/J5Q/ps3XbhMKNOxIhpjfaHcQKBHAx9qrXwJ3VjFjjEp8jkhUIloRGanYI+eySX8pia12TKSw/XabpFAR3maEju9hF+KxEGBW6Kd42AAMixUEjFHgSNqmCbPc5rwk9WRO9e8vwSt/A4KsQvKuIIS57t+O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(38100700002)(66476007)(86362001)(8676002)(8936002)(5660300002)(316002)(4326008)(54906003)(66556008)(66946007)(110136005)(82960400001)(41300700001)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(107886003)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5EjY3oyoi0ea9+/2KMFs4vbXCjJ4qhFbL2J7oXBCS2J+ZcR04Mk7TdC+EHI?=
 =?us-ascii?Q?FhHFwWrjyyPlC8PJrDKDJWX9LYIGllirG0GC/y2CXH9zsKDTjIIEtKB+iduS?=
 =?us-ascii?Q?A/ows8ChvMvCLpb2F1UFas9eU9A3bXOjNLl8mq+m6Rd3GUBykyX3a6Iv/pTY?=
 =?us-ascii?Q?ydQep1lOvqCXjiDL8zOey9Jlx5MSJcYmMjK2UpBupKkmMeOY4NFgkN/Y0JB5?=
 =?us-ascii?Q?gYJQQwqR35JlvQwH7C7mTvMYUTSUwYMtw5FEcL79bufJEZ9rt88YVu8SZxld?=
 =?us-ascii?Q?xMdBO0/p5Ym4M0QVqeaz1QwEDr+yT1/GNGcCxb4flkFA6kJDZSpxJcMldABJ?=
 =?us-ascii?Q?CEja0FobniRcdJnjOaT2XIoOpuUVz1hOuVxk4ua5g1nRjeaaSWgj53igtoHG?=
 =?us-ascii?Q?cWJGkAjtR9S/dwhGmYk40hOl9HpgRRlkxgab/3OuYDi5WuB2KbQzRxh7T4Q+?=
 =?us-ascii?Q?su45o25hefoEfZfzCpVCj2m49JOXHE5tcS1utUyE4iydgFAx4E0loAdWSqUk?=
 =?us-ascii?Q?pAkQ4woqCtErMt/fPi6FXMiNjviBPVsJtZ93snz5CLZAq+j6zD9JSke+ipbV?=
 =?us-ascii?Q?+ONHm4nK4ZQmFsZutrrL86tDw80eIMsksMuUA77svxYQgQC6BGQUJseqkSPf?=
 =?us-ascii?Q?0DauYsqyqkWgwRd61JFaZ25AS8J/AhUuTerlNPijB/hVZsbNnOfhH8q6/cdb?=
 =?us-ascii?Q?5r8BGWWUKO319RTwPzAWXdIoSc8iJcC34G11gIRiDmcOgFZHiO6+u+AKj8Bd?=
 =?us-ascii?Q?nUh3RYhJ9fAYksBCVVdiNwUxqUkEPK+qxT4JUAVZUvSUlxTQ3YcN1LnZRIpK?=
 =?us-ascii?Q?42otsWy+/udS8xdFw3WNLnoInvT+hR9nN2ilFIivzkiQ+u8HJ+qQ9bh8iMZK?=
 =?us-ascii?Q?HS4LGIhpp16NdwOdFKAY+kG84CsBA6jqO5mgqYV7YumvG+1+n6o6gTX24XNC?=
 =?us-ascii?Q?SBwflw98ldkyvGmhMol2UmS+Ekl0lf7mqS0T7Iplec0GlZIvkLqbMPiJVtac?=
 =?us-ascii?Q?gPoLbh2jxB5oz2OWG4HP8nCGiCJKtUmfTi68p463jkCQNrOTN1zXKBF3ILwa?=
 =?us-ascii?Q?I4ktVquqppErGDJoWAN/uNPmkv9GoPO/MBVthyIXbnhTxxbXO/l8BELl6Hcg?=
 =?us-ascii?Q?QLdueRlnG2V81q8EVEnE/36MaHuoOy1uGc7YbxbYxCHmM3oSnheby3CwLvy7?=
 =?us-ascii?Q?r8vglI+hySxrfm3RgJsnIq0tnyIs43v5W40Nkx/vHXmy3hgN4Y2YLwUFlWPv?=
 =?us-ascii?Q?w54sT9imhwCLTMSgqdcs442K9y8o1vo7m+nbulj7vUtVRwSIObJvv9ImSIA6?=
 =?us-ascii?Q?Ca2hMwqg4eTE+MQY6oI3TNTFIxhn4TeEdT1pGLOCVfzah2WSDYlYbeayhCQK?=
 =?us-ascii?Q?yEI+pCN4Goej2DBADlTwX1fceUlu0l/aMONufc1F2ySEk6XC2S5BFQY4j3mP?=
 =?us-ascii?Q?C7E1Zq1pcmr81Wou18yxSIh1NVPsN5hCLZgmBDxmE7gLyRbhQGmO2k6ZK9WY?=
 =?us-ascii?Q?zvPL5Xb2+Ma5kvJOA3HR0laCZrz5zorXRUNewETEF1++Qs2YLA2m9yrp9Gov?=
 =?us-ascii?Q?AaZ9TabihPxQ+GNcqms1Y/3PdTzo2X92ihqNdcULVGz0s8892wLrM1NseBVu?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fbdd4f-e711-45f3-73c5-08db9213445c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 22:12:45.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iiT7RpVfQYvbMKMe/R8M5t1w2Z5hq6ObvWxdtFtjA9cWWUIxiuW/r61/vFP8kJXjxGfvzFV3U6vucFJykeBv9tm/j6UqddMCcXtoY3dy/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4741
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

Ira Weiny wrote:
> The handle value used to report an event being cleared by dev_dbg() is
> incorrect due to a post increment of the payload handle index.
> 
> Delay the increment of the index until after the print.  Also add the
> debugging for event processing which was useful in finding this bug.
> 
> To: Davidlohr Bueso <dave@stgolabs.net>
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> To: Dave Jiang <dave.jiang@intel.com>
> To: Alison Schofield <alison.schofield@intel.com>
> To: Vishal Verma <vishal.l.verma@intel.com>
> To: Dan Williams <dan.j.williams@intel.com>

Is this some new process recommendation to use "To:", I would only
expect Cc: for maintainers.

> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan gets listed twice because?

> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

I assume this is because b4 takes its address from the patch itself?

It just feels a bit too noisy.

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> NOTE: This does fix a bug in the patch referenced below.  However, I
> don't think that warrants back porting because this is only a debug
> print.

I don't think that's a reason not to flag for backport. Smaller things
than this have been backported, and if it saves someone getting confused
in the field its worth it.

> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> ---
>  drivers/cxl/core/mbox.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..f052d5f174ee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	 */
>  	i = 0;
>  	for (cnt = 0; cnt < total; cnt++) {
> -		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +		payload->handles[i] = get_pl->records[cnt].hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>  			le16_to_cpu(payload->handles[i]));
> +		i++;
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> @@ -946,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (!nr_rec)
>  			break;
>  
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
> +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> +				type,
> +				le16_to_cpu(payload->records[i].hdr.handle));
>  			cxl_event_trace_record(cxlmd, type,
>  					       &payload->records[i]);

This looks unrelated to the fix.

> +		}
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> 
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230731-cxl-fix-clear-event-debug-print-3b57da0e956c
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 


