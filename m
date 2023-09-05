Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55E7932B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbjIEXto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjIEXtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:49:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1971BE;
        Tue,  5 Sep 2023 16:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693957775; x=1725493775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NP5G6QvC2pGeBXcNJgadWRBzt0MIOFwOlugbqf1icZQ=;
  b=dhmabb7FS0lWSX2X5yibYG8/V8NF7BVIZ7BNXH4OGAdysVLH4GgCpNvi
   7XLFtmm6a6M1Tn2mFUciN4toS4QWHfi5GahWEDfIISgfXGdPz5uatrl+z
   96vnJqQTZXIqKubh2yFB5XDf627LeQhilqQwxEyG7i4/jG1cKvEWwdWuH
   iTt0QsdvxabBFjmMqexyX4+GnicfxxvQs+ed338cbIrFOaVCdiSpQEfCS
   BzDTpQ3ObHu/qOywZ4S757vzW0stwG/J0yLA0BEpxlXEoxzT+P8zbCK3C
   XMj1J2z4WYSmsukkDx3Zme9pFhqKy8ebHgUKN6zwK1OG4VcDRwb2KIlgK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374321738"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="374321738"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 16:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806801362"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="806801362"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 16:49:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:49:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:49:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 16:49:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 16:49:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK2dp3LPNVIFbPcQiEl7phcvAvOnzJcKh+ufBAOiUM/JvDO2rMwlQC5O/4BMHcIEpmSXa1lGoxX/vAdSJoY6H85oGWukOxi2CsjX0P0btj2kQOvHzpGn7GkzfVD7nXY7WB5/B/Ncjan5U56o3hSTHDT9m1HEookalWZQFLqUBI7pTaq9rhrAfFXWwvhv6KNqxr/0L3mM6J3pjsciJugkjIErGjf0MvxD7udV3KZdl9eOfu2mr3gnEs3tHtASgGAVXEVUDjtv75iuZIQ+BF11tL8+0uTTsgJkMcWDL/PqsiwwdrtwbtIkFLLwh/vGDypPrhQr/1/ZpON4rJkH3nsWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpWJg4CccjlexYRJPh8z4RG27Q+nnfX7hZDIYgw17tY=;
 b=iEkLQBN9TGksvJJ5fxVZR5TsXJtuRZxkhbnYzIxfyt0obLgGxLp/6OuALPadQSo9E2gMWThSZ6ZUvNVwvJoEA7P40RzvNxY3V6eR62WQHFbxIgoi/SqCzYNXy7ZXPjfJpSplzRVPLSMpKfkcn/0ZnjFLrlO91SZ+37WKiTekJzwTh8e0Kg/dMW2TIxUvf/uRSTI4zj9VB8FS+Lt2Y9D4XAFGGyqKNDOO9CjelFqC7OPSzO7h80UyBgDFPvvLFGTDbhEtynQ5GrV3YZMGJ4+CT2KZNwUEtg4wzof9ehHlLkonKHB1li34jfrRIz1REWn3MuJCVKuCyhJM9xNK1rjnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 23:49:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 23:49:30 +0000
Date:   Tue, 5 Sep 2023 16:49:25 -0700
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
Subject: Re: [PATCH RFC v2 10/18] cxl/mem: Handle DCD add and release
 capacity events.
Message-ID: <64f7be8553587_1e8e782946e@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
 <20230829165930.0000208c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829165930.0000208c@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc2e0c0-668b-465a-e8e2-08dbae6abf79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rn0ie0sVqFp4Vqom3hvGJH0uCPshnfHozfcmDaXs1Sfe6eg7pIgKA3XeeOryRzjIE1fahH/7stWSPsVfDfrScARAf6cHxmc0cz+4urnQSSakb+f/6TKb2z0SZ/JvqzxKvYgTh7hPpTr1XjuQy3NHIfLAIAMNfc6IXi71GUxFlF7WJJPfAWbNxffj8pb1GeWDR/phXPoh0VObFAUGqRGd9HuOt7kS3j1jTUjA65V2RgsXMLJAummvtJE3evjeDLskNtZxo1qULNEtcA/xUmpSvN9EJGUzFPG9iUXLVG/PgqzpEPlh4O6UJzHNvdkxq+PcafBx71+FmCoKgibqawWYypFj8NLY5cgINTlB9hz4Drk+WkRO0/ZeTTWyw11RN7kiBQ9DTnBakUpgfnsxOLU07Z5yYh35fhrR3ioiSVw63M2lP4FlYurHYOffpDLD6yTcmnS7gyhzOXf4EpWx0/8Azyzr9CWb+FWElToQllxo22Upu1zjRO7BmoSMaksnDtJ9l+E8KLieLcPuOkuYQ81s7jKvca/m0QpYFY7CzaZhWZtbA4ymkeXTbdgJEjjdzAaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(26005)(2906002)(8936002)(8676002)(478600001)(82960400001)(4326008)(5660300002)(44832011)(41300700001)(6666004)(316002)(86362001)(110136005)(54906003)(66476007)(66556008)(66946007)(6512007)(9686003)(6506007)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSwNgVHcgaNOFPPPhfQHVcCD9Kf47AhGo2UTfyG91gDV+CYqRrnWGjcmJc3Z?=
 =?us-ascii?Q?H3mMSnO9vw+ig7CefuxLjedvS98Jhdp9EXMcCDwRTiZfC7BvVmF/0SYpMTxX?=
 =?us-ascii?Q?j6nKHVQcIBxwEUbcGrD5yjAyktZxY0Uu6GxfMoGOOBhI7fOfWq6RGY/6+xpK?=
 =?us-ascii?Q?LBAD4XkgvJUhmDMQ9OofcMMcJm/RfuE80bdgxxtRSFhb73iu6TdAiYEHfsUo?=
 =?us-ascii?Q?Nh7wwKvySgEv64S3pf0LYR2VzzbbxE+oQPA97S+KieqtwuBSYWwRjjkr5U56?=
 =?us-ascii?Q?xzD+fdqzERdtgpNz/4yMGvaC63NPuLrviS49pXlbhv1nXi3isB33NKtU/ZE+?=
 =?us-ascii?Q?GTlgvJzfNfbdXDG0RJoTad2lwtuYQVknfO/YBuEh01b6mmRxG74WhBRW+vy+?=
 =?us-ascii?Q?cTmfl9tCLIkU9BJlp0k46yOA0EfuUG9MQiutrvksdqxeOw/i96uM2yN46BKb?=
 =?us-ascii?Q?KgesxkR1MOcmmer4gd5gbXgrgcjisJYVErk2hMQ1IbPyg5wNt1GZbbPgeAcI?=
 =?us-ascii?Q?BGNkmPULcPX8ayWT+TnvB9GqGYGAGKxwCoHfnAYC2Bkfh7kU4bTbpSy9mWDz?=
 =?us-ascii?Q?usU6mS8Ur5piQOofjwklk/Lk1wFCn1LrNndSonLSMhLcXQamT0wLT8OJS5kc?=
 =?us-ascii?Q?BdA5U730JkSo1T7bsLBy5DHHMdd+v59+j0+mT2uKV3x2R8H+OxSNtL+luAoH?=
 =?us-ascii?Q?BDXl5XCnYhCzccC+fPGsVqJaCRgcYMeTti+x2YuE8HR0W0sc5CFNTPIiPzNY?=
 =?us-ascii?Q?rXgya6ALoQmc8yb6gCEN/LEZwPO62T3HNaSI8lJrgcMLszY4SfxDsW1hIBSz?=
 =?us-ascii?Q?o41/9aCWAzujLepbgYiu09zYy98H7v2RviyPxvcIu9ClPCGcWFfX0XxVgb2d?=
 =?us-ascii?Q?V+lO+4JNPnOqYwryXS4ad+pGy9hVahBoQsOJ5iag+IXODv8z/DExbXDa84cd?=
 =?us-ascii?Q?5mYxH6gT971LUx5eMM1TklV/dkMrgfd3J13IhZe0vuAlTN974PjyaWVWJlFk?=
 =?us-ascii?Q?bssdZHjoNh9CWobXmc2Rz6CQmM/s/L6/jddxxi6Vatjjj3ona8BH6ggKhEpD?=
 =?us-ascii?Q?l/9fA+21Cv0p/kACt+FTSgK0yFQq7FRIoLNzM81eXBKiqT22o7HhYY5OFazp?=
 =?us-ascii?Q?pNAIOza70WjnwQPHVUe2MYQoRu0Cl6bdAeEL5VMSu2uPpuW2YpaTjuqF8uWJ?=
 =?us-ascii?Q?i5Y6kQm9pmxHk+RVqUyYfnNBS9pkuox6FNFSwLEzoSMavv3C3qL2PfHQzfsw?=
 =?us-ascii?Q?IzG7KpPxgQyfMQAgUnzwWOzr5HjJVZOrKtwd5ooUnki3wIdBVUxlU607AWbz?=
 =?us-ascii?Q?+q8EgyX+fWg1ORJdMEBcdBGI8kaBHmgiq/XJNP3/fJ74LY99+reTG1op8n6p?=
 =?us-ascii?Q?J1M1WJUM4DlIcBdUntSLRq/x3gb67ZI38krhfhSbw5xSgsf/frtP9aTOmKwL?=
 =?us-ascii?Q?WHfs31aYd3BJIVxagaX4sr6kykDUqFODrNgTjtEow5FLrEMSdy05WqTuCXx8?=
 =?us-ascii?Q?deiicosLr7cQzgsLogMMFOdHF5morQCJFL/f6zBQHnFKAhlRm1HCtXEup3lf?=
 =?us-ascii?Q?9UhAgxQpTltooUoBVLMs7oLW7opAyc0yP+oAh4hu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc2e0c0-668b-465a-e8e2-08dbae6abf79
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 23:49:30.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQc0QHWd9HZPH95jby7ZhsMkogqoq7Dq1IxnJSBhvN8IyMpIlVU1WWLRCJQ9+nk2lnix5aguSCH94Nglg4u0cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
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
> On Mon, 28 Aug 2023 22:21:01 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > A Dynamic Capacity Device (DCD) utilizes events to signal the host about
> > the changes to the allocation of Dynamic Capacity (DC) extents. The
> > device communicates the state of DC extents through an extent list that
> > describes the starting DPA, length, and meta data of the blocks the host
> > can access.
> > 
> > Process the dynamic capacity add and release events.  The addition or
> > removal of extents can occur at any time.  Adding asynchronous memory is
> > straight forward.  Also remember the host is under no obligation to
> > respond to a release event until it is done with the memory.  Introduce
> > extent kref's to handle the delay of extent release.
> > 
> > In the case of a force removal, access to the memory will fail and may
> > cause a crash.  However, the extent tracking object is preserved for the
> > region to safely tear down as long as the memory is not accessed.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Minor stuff inline.
> 
> 
> > +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> > +				int *n, struct range *extent)
> > +{
> > +	struct cxl_mbox_dc_response *dc_res;
> > +	unsigned int size;
> > +
> > +	if (!extent)
> > +		size = struct_size(dc_res, extent_list, 0);
> 
> This is confusing as if you did have *n > 0 I'd kind of expect
> this to just not extend the list rather than shortening it.
> Now I guess that never happens, but locally it looks odd.
> 
> Maybe just handle that case in a separate function as it doesn't
> share much code with the case where there is an extent and I would
> assume we always know at the caller which one we want.

Yea I forget why I left this alone.  I did not care for it during internal
review and I think I got so busy with the other code that this just got
left behind.

Frankly this is a candidate for the __free() magic as well.  But in a
helper function which handles sending the response...

This needs some refactoring for sure...  :-/

> 
> 
> > +	else
> > +		size = struct_size(dc_res, extent_list, *n + 1);
> 
> Might be clearer with a local variable for the number of extents.
> 
> extents_count = *n;
> 
> if (extent)
> 	extents_count++;
> 
> size = struct_size(dc_res, extent_list, extents_count);
> 
> Though I'm not sure that really helps.  Maybe this will just need
> to be a little confusing :)

Actually no.  IIRC the original idea was to have a running response data
structure realloc'ed as events were processed from the log and then to
send out a final large response...  But in my refactoring I did not do
that.  The refactoring processes each event (extent) before going on to
the next event.  I suppose this may be an issue later if large numbers
of extents are added to the logs rapidly and the processing is not fast
enough and the logs overflow.

But I don't think the complexity is warranted at this time.  Especially
because under that condition the size of the response needs to be
contained within mds->payload_size.  So there is quite a bit more
complexity there that I don't think was accounted for initially.

I think cxl_send_dc_cap_response() should handle this allocation (using
__free() magic) and then do the send all in 1 function.

I'll refactor and see how it goes.

> 
> > +
> > +	dc_res = krealloc(*res, size, GFP_KERNEL);
> > +	if (!dc_res)
> > +		return -ENOMEM;
> > +
> > +	if (extent) {
> > +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> > +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> > +		dc_res->extent_list[*n].length = cpu_to_le64(range_len(extent));
> > +		(*n)++;
> > +	}
> > +
> > +	*res = dc_res;
> > +	return 0;
> > +}
> 
> > +
> > +/* Returns 0 if the event was handled successfully. */
> > +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> > +					struct cxl_event_record_raw *rec)
> > +{
> > +	struct dcd_event_dyn_cap *record = (struct dcd_event_dyn_cap *)rec;
> > +	uuid_t *id = &rec->hdr.id;
> > +	int rc;
> > +
> > +	if (!uuid_equal(id, &dc_event_uuid))
> > +		return -EINVAL;
> > +
> > +	switch (record->data.event_type) {
> > +	case DCD_ADD_CAPACITY:
> > +		rc = cxl_handle_dcd_add_event(mds, &record->data.extent);
> > +		break;
> 
> I guess it might not be consistent with local style...
> 		return cxl_handle_dcd_add_event()  etc

Sure.  That is cleaner.  Done.

Ira

> 
> > +	case DCD_RELEASE_CAPACITY:
> > +        case DCD_FORCED_CAPACITY_RELEASE:
> > +		rc = cxl_handle_dcd_release_event(mds, &record->data.extent);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> 
> 


