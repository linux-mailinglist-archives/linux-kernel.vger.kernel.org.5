Return-Path: <linux-kernel+bounces-38892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A929983C7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942A3B2411C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0B12A154;
	Thu, 25 Jan 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKo4oQKV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC75129A9C;
	Thu, 25 Jan 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199997; cv=fail; b=ApMitXeBCZt/v7ZlWcMdCmf/3UP8Pp4mmR/SXTGZCTl5plDXM7NDGaBBkC9MgrA8SOWMoor0RS4wVRDA1834aM82LkVyhysiPiEdUoKfNNtFMyKBliXnmEZ+eP8haRy8nCz3h5prABnKoeq4PGVkxnepfy3SJSGYh0nPltGBJl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199997; c=relaxed/simple;
	bh=QFjOFSC0vp2Ff0zDkP5YNEAMkVjrSjlACMSNU+6F25o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oowuilPv7H8pvwNnUBGtA4gIVRT9ySTHXwOkoTMDPg+0Wrk9TxCNc4JugZv6W59XnqiKezxx9nDpBbvaYGdOkvV9CXF76lg1UliEd/p7zz9SM2osLg8Ez2502wN2cwHvwk89YJSL723M8jy17J57GpczPEL0LwbZ4wqVzgBMHd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKo4oQKV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706199995; x=1737735995;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QFjOFSC0vp2Ff0zDkP5YNEAMkVjrSjlACMSNU+6F25o=;
  b=oKo4oQKVkov3hTHwalvbY4WbO69MmXhpAPhW/iS9FF2PsJUu2KK4/7aj
   unzSWNtl9jXkK/pUFUkThyAdzRT+q+GhBYD2AkTnOhaXxmD9UE7mqWmaZ
   0nA70HYqT3NTg5dFobKpLdBKElSrU+zO8oGKxIt9EdPyIzSpdsCU5MN0J
   7PbH/4+9aNGeyAYq6APkW3wDRHfJs/EHMD0BKNwrTiciyuAK6eG5hZ4TA
   l+90vXn9sqLyB7AXVriJ03T6B6ErLN+O3x4u9i/ZfI44a0H/oAPk/PdH+
   ivC2hlk4f13vbUX4keiPoF5iY313xLyC2rlkavDIQoYpwSfXeeKdmPt/g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="8966888"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8966888"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:26:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1117994901"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117994901"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 08:26:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 08:26:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 08:26:23 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 08:26:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyjibt0WT497qAnDH4lSOfOQxPMtqzcOgQGRyhTY1wGNznLrL43FiXgs+IOpnaiIrRx439nOcI5ZaP0lYgn/aUo98SL1/YruhIDO0AoatJ1rER+PU9j66gBy+XsConAP/3z26KLNiZIG0NTBGRC08ogxrq86da8eiG9NKhG2qv03RGm5oYn7EWJFmltoSL788oZGQ9L8L19QJxqCdSQhnHjSvyYKBRbnv78Rek0XSnb2I3xOYCMgf4g832VMO/dQGUWrFWrDxhK6bzvE/miUTXPPVDJwHRqSSz/cG1Ch5JVXc2eL7SnbYuXudzAYaIv0u6N9dmvwOlbLYUTUAlyTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FPAf4oAptTsHurMu84oNnRVo2errBlkaQASL14sWNo=;
 b=KMwvMtCUINiKRZl4AmvEc+0gygH9jhEstrGqs3Mc0m1XRJqMW+ajbflTkE5GQ0KhRrfTB6hwqABcfwg7/Z0/ZhWGGbOcphgfGMzifFRoA1ojklze7Jv23wgrSTEttO1rwzi/QU/WPp1otmLrKAQWE+FCAdcCCX1/Kz8ZdwBf4c1u1ImmsBLjEhrU0giDa0wk+DFsuIYDW3sDCNbAb/g3UnXTaPZxB8t0NTQnGVidyeM+BBqRIGuXxTmLQ8IIKgH9gPOrJXjZBK3bNSNnowWe44ALl1GSpEKkBR8egaFmmdTJO92M2UExgko58XocsQjw0QPnGZE/qSU3LZ57w48yeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:26:21 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::42b3:9892:db7f:5563]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::42b3:9892:db7f:5563%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 16:26:21 +0000
Date: Thu, 25 Jan 2024 08:26:18 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Jithu Joseph <jithu.joseph@intel.com>, Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>, <platform-driver-x86@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] platform/x86/intel/ifs: Remove unnecessary ret init
Message-ID: <ZbKLqgte4rVx8yGx@a4bf019067fa.jf.intel.com>
References: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com>
 <ZbJ8gp47CWDDqCb4@a4bf019067fa.jf.intel.com>
 <b9368410-e084-8d4e-1c81-55c4e6a22434@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9368410-e084-8d4e-1c81-55c4e6a22434@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 573e0898-5ec7-43bc-d800-08dc1dc25da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbXdelYX1YaJqnTN/sWj8KAq5k5UZwKg8pVYea29sqD/ewyrI7cX3GUaipb34kjSZ1aAgMVMjE8aLhtdsXI9AUxfP8lhi6rPyOZwILHNcsaThcO6VYC0TkMAOPR1HpxWDni4050DedxmE384Mhheobi++IKnf+7pvcUPdzrxJqJULyrOHy4pWj3xnxHjAmtE6XbLb5ITz0FCdBhGNoD2c0tM3XeglDIS4CDgB5gF9Gd0YLuLHgJNxG5yZ3xELyACS5ceywxJ0VSYc28+3Kc0RZ7XXA0aQNx3Sc4RX4KWVp5Od3MrWmZPoVigLSWSikzyOETqhNArred612kwaynhntgdKjUPlLkKpq90dGlJD/ZN7z2jDhE9GR+sZs734zed9V9dUjQ61WIoSXfrcbLOrM22tngOTpqPb8iExU8CMGSkEcciBfbXnWpE4H3vzNJ4qjjxjgieKCH4mYFfzsRPJ8gcW1FzNckSNv6srts9UZdRpT5cWaR5AVdqmOp63sTzt4U+TE2VqYPDOTIJfTZSZOiwj2qYeOHeQYcK/SdI8fy0oo2UNuLoRxm00GdgQ1F5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(83380400001)(38100700002)(8936002)(5660300002)(82960400001)(4744005)(2906002)(86362001)(44832011)(41300700001)(4326008)(8676002)(26005)(478600001)(6486002)(6666004)(66574015)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n94cc4cptq8OAktqCqo9W4HXR97W5VyiwlbxKvdKeX6GDdNGMcRId1DUZ2?=
 =?iso-8859-1?Q?CSfgsroG64uJeQDvUH51G9yMLDmL4DTaXjdy9NTcDG14vGJNbIaXur/IxN?=
 =?iso-8859-1?Q?1i5Rr/xJHqt2PIsZN/pEvfNIe+BXCySxXW5az5Zr3rjtDD7//WkU2QLOzS?=
 =?iso-8859-1?Q?Gm/9g7BDqZ4s70YxR3vYByZutyhWEU9mclTFg9Vi/DU5fFR4Fr4Ru6/wnD?=
 =?iso-8859-1?Q?G/UncAn8vV11enpZv3bw0D1wNxSvWzCkUBAyXzNhRetLgUQmU1cBMTCwOM?=
 =?iso-8859-1?Q?xehz0i30MtGy+lpBOYtRtqQsl6miC2NpIrM3xCU4dNZ2de99Di4pva87VJ?=
 =?iso-8859-1?Q?Nskjwn1xW90gENOvXwjJFLbg52qBEcO2JfgKQrctqcoJMb3Glnvzz6kxvk?=
 =?iso-8859-1?Q?ydDGoFA3ZTDeOcpiBgFQlOWiPocsYVSnSkHVV1WwV8lrcKCBlz/qU0TXgL?=
 =?iso-8859-1?Q?/lwqm12T0u2croESnvgoHnVSiMjrX/lnpwZYqPlB0DsNMpNIVYHzBWJ5Wn?=
 =?iso-8859-1?Q?Glw8lVtzGRVYn6eRkK8xT/oG7xY/RTWsHn0O6TmT8wuv8FyYI9iC9jltxk?=
 =?iso-8859-1?Q?CfZfRnXA2vELxqWP+E9M7osaspKOU5Ec3YPYFTcAXF3+Um0fQR7qmgrBR8?=
 =?iso-8859-1?Q?sDAmI1osOjmZ5HtDN+kP3eUnEHJfr4mPVRKCyzyDJP04AWEky/045Hjv6F?=
 =?iso-8859-1?Q?Wp44bj8AxkK9/l+2OMj4l1QUQQSf/jp4T+gafa/XOGamN4OhJwCgDMYoYP?=
 =?iso-8859-1?Q?Q+EAGZ6G44oC91Nab1uL7G2ixySiEnFDg7Fc8wEZ5CBIwWwsI6K5KVywKW?=
 =?iso-8859-1?Q?JjfZfYajvvMldCEWXzRoPmj1gcVND+eqnHkFH4pRW0p592RgbT4Nar3sFI?=
 =?iso-8859-1?Q?4/7yxYU9Rvm/KI13jBrMJFpi985KDnPdNsJDjpdjlr6IXZIigPOevdaJUr?=
 =?iso-8859-1?Q?1dzjuT6ij39TpFXstLCwOGX1MiSRPJ1u8UVe5C7QnHP9GQW76TMdf+2Vi+?=
 =?iso-8859-1?Q?2zYAYAej1S0v2aAXfyQbNTWKg5W1iRLhxbMlDFQTWpOEdMmpMLWBVIXd3V?=
 =?iso-8859-1?Q?EWqkFtOVUSD6McYwW9BDYNzq8/kwmBLCKk6gA72DorHhXTaXhJuvXUIJOn?=
 =?iso-8859-1?Q?AyYB9itgt+rjHuGiNcquJ9ZpP/39TvnQBS75qit94HaEc/Zzeqv/gs2aAJ?=
 =?iso-8859-1?Q?j4JBl1QBagSgTjNxncL3BB9z0/eBAaXSOrAdF7xAjgxCALObK0Ie7dKxrM?=
 =?iso-8859-1?Q?IPNW4rPgDxtIyJ9UX9OeUnM8/baNjMGcfsBNkG++Y/XLApJK/RWUcoxPl9?=
 =?iso-8859-1?Q?0wa7wb3IxdlvKVzp8GMNIMWSti9QqqwJzfVyzvNKHlkyQPu3vO6mgkGtOu?=
 =?iso-8859-1?Q?wR/GDeK+2l7DS0vc5zsOXgt3YjQd1s3fgDv9EHB259+O8zep/bCqSlzyZv?=
 =?iso-8859-1?Q?1QnYNvnWi0FoF5GFBYzxthdJc70NDuHj2BVIzDQ3c23xIQ2Lx2Ua/im4a6?=
 =?iso-8859-1?Q?1ZFBUMsKlTcaS7AXcTsFzRF+tCM+XmfyLvSbHH2G1XkMnfwwVA2dnf4j30?=
 =?iso-8859-1?Q?ibwskEr6tjh7an+hVw3sBoPFqTBb+514c3Anfu3sISbfhJ/KnnE+EsI73F?=
 =?iso-8859-1?Q?dbxBxO+uvfwOpR/LNJa65r1t4w4UO05wvl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e0898-5ec7-43bc-d800-08dc1dc25da1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:26:21.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJm1inkJNtIsz8qZn6UXNPXcvfAGp5t4GCYaTlNj+eVe2gYvIO/xmFyLUs39UpMIjTF9wr4hSvGrlXFVbHvFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com

On Thu, Jan 25, 2024 at 06:12:00PM +0200, Ilpo Järvinen wrote:
> On Thu, 25 Jan 2024, Ashok Raj wrote:
> 

[snip]

> 
> Hi,
> 
> I was thinking of merging it myself into pdx86 review-ilpo -> next after 
> allowing it sit on the queue a day or two. IMO, doesn't need to be more 
> complicated than the usual process kernel process with patches, it would 
> just take extra time from all the more there are middlemens handling the 
> patch (after all this is just a trivial cleanup which I noticed while 
> reviewing the patches you sent and since it didn't conflict the series, 
> I just sent the obvious cleanup).
> 
> But that's assuming you don't have anything conflicting beyond those 
> patches which you sent? If that's the case, it would be better for you to 
> take care of it so just let me and I won't merge it myself until it comes 
> back.

I don't have anything beyond this that conflicts with this change.

Feel free to add 

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

