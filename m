Return-Path: <linux-kernel+bounces-17711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DDB82517B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F9286F68
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AAD25553;
	Fri,  5 Jan 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mp7SzBCc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6B25102
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704449226; x=1735985226;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nvtN0KdS36vNEcNo8fZ++AFmtcO5M5elRAs7xflUg68=;
  b=Mp7SzBCcjhcM0exZKDZpsNbE2RSt040evfcA9mNV3rTbX5oYoi6QS2zL
   ZCvZsS8hESu9YZYvpo3rjrwKMJPsZ7+8+BMUzq+U0rNAQTU/A9tqrH2a7
   4WPI/mmPLqEDWA5Zz43wXZG6azEqHI7MlkA517xWls7iicX+8xGTmU1Am
   i0oI+7Fxioh1cDCdB0Wt/hnYA5Jd6bMY1EU8UJ+qW0T8DTpQJiI1IqjdJ
   Ic7d9xB7PXnhIELMa+A1wscWRwY+H5E71Ct6lzb47RuN4u3re7jK31f2f
   9Hmbz4kDdzOOTYOV/Kb3kbrU9yPYumi6JW4e0RwAbmo+JxjgYxWYGwTo/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4245773"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="4245773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:07:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773810162"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="773810162"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 02:07:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 02:07:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 02:07:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 02:07:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ5XnlnVLhGAYuUmIyfEusGQgethEVTkOOTZ7/wliIwsdCrA5bLFrWpXWWmQ4NvEp79PQ6AE6TDzhBtAkkQE66eodU0fwscfLMLvWDFxNQIyfKT04sf0rYonEI3LudAJqC/6qRKhoydMYzbLCK6dPnrWlR04hzfeoOef8ZV5u87OQCENTsh8a12enyfABmlyKF5alFiDDqnInv4LuJT67wjh3d6qSRJuG41XBI6lb7wgPx0vYG8L9Jp6xKpo/ZygDK5RclB3QIqwConj6ye8u+aYIxuKUtccbnNR17WR06HhrLOaYjErig0V6UBqGMhr1DwPdqa6qgNOQnaoLGPC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqZfzv072vv59wD+OTR5QpXoL06V7L7qpklOkIg2m/c=;
 b=eMRDfa8K6Dptm0VoTaG/Pj6B4uaY78QF5TH99ENEoapl7VuLnJTTUI/ZZxehNNEMJnVAPOmjoT0/PE9fpvFv35i3rKZpNJtByGNp5nCpI5+SPcVAT19pp7FxV9G4wTRgY9dYsyrLAkv4lWmzYordejZj+Vo9agFRptL1dl5F1g3me2OQqfE7Eud2e2BInu9a3ptfH9eX6CprSQHEDgqiIGZwWL7+hgiV7X7kCBDix4Xk7l5RoMsNqW1YFd0ixWjQJtOom0LQMbfjFkLzPbuv44+YNfCOtJbPl5Tl+85oFuzZ5JM23Q+dxq3z1j3fQ4POonU67nLJPppzn94mB/+L5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.14; Fri, 5 Jan 2024 10:06:55 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::f105:47dd:6794:6821]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::f105:47dd:6794:6821%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 10:06:55 +0000
Date: Fri, 5 Jan 2024 11:06:53 +0100
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Maxime Ripard <mripard@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	"Michal Wajdeczko" <michal.wajdeczko@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, "Javier
 Martinez Canillas" <javierm@redhat.com>, =?utf-8?B?TWHDrXJh?= Canal
	<mcanal@igalia.com>
Subject: Re: [PATCH v3 3/3] drm/tests: managed: Add a simple test for
 drmm_managed_release
Message-ID: <3u5s4zkjbqu4qtjvbj7y7qlocrqmwhpzfwhphxbqpo6573gjoz@3zkv3oyvorrf>
References: <20231211220939.215024-1-michal.winiarski@intel.com>
 <20231211220939.215024-4-michal.winiarski@intel.com>
 <mwdzi5424bvw57pqred3e2hcq7tp6xkaywj3dabixkbmq5hkbf@emquthxzlth3>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mwdzi5424bvw57pqred3e2hcq7tp6xkaywj3dabixkbmq5hkbf@emquthxzlth3>
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 7377729d-dee1-40d4-82ac-08dc0dd60c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwOzmvxZ5NaFxtg1YEbwlyLPfQVggCDOv02CA5KdlGKQZdCdbVU0sItLnAkXUrG27z9l970K0C/dawwYqyTPym9aSe5jt1+KtmjMM+gfBDviUn72i/svQb+0tn3zgd7czwFrKJcj3VQAEKGEFbPAK4nntJU/vxsEc4P91a7vwZI2Eup94RFDOrmLgg3++ce1LFRS2EjsHrMLC/oe5Re5agV73rj7l/soFRoXN/TWVHRmEyKvucl39yMqpYIld3/L+dW4L6p9IEi+71K0CfmN/5CzzKddHSx2520TAADZoZZaGJ8fkfEWw5yXbqiKEqiKs1XAqfRiWE0GoEWpG+XD7lAJh/EcFFCyTTRNvFsxipxUMe3XOTj1wZk6lttxSxXEJHz8+p1SLRG3U0yZgdqRmsfst8o39TXlo/AMt8lALLTV6ckI+79ZyXgHU4sZ2qTDWkJhqLSOIwQHRhv55Z9CDokqGZ8Q+4GTN3xuFf83RfZ+pQkTgjll5778BLDVOA+fO0ShGjgyZ+oN95hco5U/l8eYaHmruelrCIlVtMFzS9djVAAiiI2Ip7EIbK+I7icu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(6506007)(6512007)(66476007)(478600001)(66556008)(66946007)(8676002)(8936002)(316002)(54906003)(2906002)(6486002)(26005)(83380400001)(33716001)(6916009)(41300700001)(5660300002)(7416002)(4326008)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBQSnE0N1JqeU5EMDZZalhsOUVLYXV6eUFBVTVQbjVTL09sdlN3QmFIMzI3?=
 =?utf-8?B?KzlOS3B0ZjloMU9rRGp6dkk4NmxVbnB0RDE1VkhIQm9SVTd6a1EyNWRiRUdZ?=
 =?utf-8?B?NXhvUEkvWTNKeXNLeTFBVEdTazBLTzBsNDBhREpwRk94UVZVdzIyTnhLSVlP?=
 =?utf-8?B?MlNxcDRLWjdRMUFlS2k5Qmx2MGZKY1dwSG83ZW9IamRtSE1vNzB1YThYampD?=
 =?utf-8?B?Sjg3Zys2a2Y4OTQxTnV4R3JhT3IxRzEwVTNCeXVzTUdWYkxJL2x5TjJpeElI?=
 =?utf-8?B?Z1loQlV1ZjZTTmlkT2p2elJRaUVvbWNNTTFieGhZd2NtVkJMOFlzRmhGZ2JY?=
 =?utf-8?B?dW1YM2NIdjk0MWhxS2l6bGg0anlVWjNYcDh1MW10Vnp3ZW1ZNXV0Y0N5OE4v?=
 =?utf-8?B?c0hkd0VheVlLOXU0NHZKWE85WE01WUcrSFkwTUJySlZzVzMxclFVT2pwandp?=
 =?utf-8?B?eUI3b05HWk1SZllWNWRGRUdMMG1IOWQ2bkZ5VFYzMit6M002d0s1Wmd2M0xh?=
 =?utf-8?B?YmYrVjNMMVhRNXhxajAzcS81NFovbHg0Nis4ZDd6NGtaMUtUM1NRaHNmeEpE?=
 =?utf-8?B?VTdrRGQvSENvdXNMbGkwejhwZ1d6dW5Hb2tBRStNcXZqVkJPKy9qcXNQZ2R6?=
 =?utf-8?B?RHhoQXpIZGlPcFczYTR2WTBXSnZiRGZyMjdKekhpQXlna2s2SkpwVnNlWEhF?=
 =?utf-8?B?R2NsSnlZWmI1d0pldmlLVElGMm1aMzZhUXpHNDU3cTlYN0FnTUJidURZOFRF?=
 =?utf-8?B?aEgxOW42allrckc4dVRONkk1MXNiSXRxM3VKclIvcWJQRGJjN2ZIVjlkZmdB?=
 =?utf-8?B?YnRseGFTNzFWSlFpNWxTVllEYmFoRFhXcWtHd2owamtiVlZCREVhR0xxVEdw?=
 =?utf-8?B?b1FudE1VaUlTS1JoZzRDdkszWkFPNDRRay9udW1wbGI2M1BSdHFmWnl1OXpO?=
 =?utf-8?B?b3lUWDh5MzhyMmhFR00vQ25XK1FaVG5vVVF0Tk02Uk1QZzJXYVY4enJzZUFV?=
 =?utf-8?B?d2ZtdGVneUtGei9zNDFxTVNKWC9Pd1ZtUjhKRUJrY21lSFFoZThwVjRBTnlZ?=
 =?utf-8?B?MFJCWFNLaVNiTENNMnA0eUU2dWppK2xhdGhtbTRQSGxkNWtOT1lFQXl3YlhO?=
 =?utf-8?B?enNJL2ZWQXkwS3E5alc3S2xpMFhtMENDS1N4cngzTTlPeGVTeGZVNFNTUW5E?=
 =?utf-8?B?dWJIL1dwMHAwRFE1SzBHS0lLZHlaTlZEamc5VENzWVRGMVE0ejlYZXhjVkpE?=
 =?utf-8?B?aldMV0F1UVRKMFlPSG5CRVl4eW9takowTnR0ZUNMR29ocWJMZlJrZWw1Z1Iv?=
 =?utf-8?B?elA0Y1FkTndvOWgyT3VMWWtnTG5KREVHRFBGVWVWVVVSQ1l0ZkhBWEV2V1U0?=
 =?utf-8?B?NjBWVlR6UVM1Yks1Nmp4UERibSt2UTRKblBkRTIraHd1aWNFWVdpeWdIWnIz?=
 =?utf-8?B?anQ5V1ZuQmtrK0dSQ0kyR21BT0x0WDQ1MTNaTGVFZEdEdE10dXR0YUQ4aUFS?=
 =?utf-8?B?MjFwWVRYVTBtMGtXaVRGYmZwK1phR3AwZGVNTmVDbkw3REFmNVE0Vmx3bGhK?=
 =?utf-8?B?bk4xUVhtay95Yy9QdGpzbHU1dVpIckxSdWJOZVpZcERLTjVESTRoNTRaV0pE?=
 =?utf-8?B?bnpYbGs3V2dzNWZLeEsrM0NFMnU4LzQwY1ExL2oyRitZQ2R4ZWFhQjgwa0Fw?=
 =?utf-8?B?aTVCWjJrNXowekRKSzl5Mk9wUk1HaDR5emFESWpaZUcwNDBSVkF1WVdsMEM2?=
 =?utf-8?B?dC9pWFJTd2tLeWxxSGUxMW9ld0x6Y0pKWEoyYUFESUw0cUJtdEUvSU0zUjcy?=
 =?utf-8?B?YzFkSG5mM1NkQTU5d3VLTDhSMENzbWxDWUFCbkF2Z0xoT1l0ZEl0Q1FyckZY?=
 =?utf-8?B?TFcrbkFTVFgzVjFjdUJSQm8rVWtlUTRoYU9kTzUrWWpPTkpITTdETXg0aE8x?=
 =?utf-8?B?djA4T0hFVmZKZXFOaHFUVWxzVUVtWmlBT0I5UEZSWmZUNzIrbWxuNVloMXhq?=
 =?utf-8?B?T3ZnNFhsVEJIMVlDMmZ2TzFlZ2RTT01hSTV0ZzZ5ckV0WldKREhoVDFENXc0?=
 =?utf-8?B?RWNRT0tWbCtVZWNXSzlGc1FEUnJPZGpvY3AvK3dXMllOU3ZHQzB6VU03Qlpt?=
 =?utf-8?B?Wk5COVBva3RhU2hudFdFOVROVWlkRHZQQ0tyMWdVdWl4Q2NESXNaMFRsM0Np?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7377729d-dee1-40d4-82ac-08dc0dd60c08
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:06:55.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18sntp0/O2mt8svBOS0NwX2bKOkpWmez9WYPy9hepO0025eOM8NSPuMJDPzQwBX2WRRNYuse7a+X6d4yWS987hwSAoDVvLccF0Br6kXpY3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com

On Fri, Dec 15, 2023 at 05:31:38PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Dec 11, 2023 at 11:09:39PM +0100, Michał Winiarski wrote:
> > Add a simple test that checks whether the action is indeed called right
> > away and that it is not called on the final drm_dev_put().
> > 
> > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> > ---
> >  drivers/gpu/drm/tests/drm_managed_test.c | 29 ++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/tests/drm_managed_test.c
> > index 15bd2474440b5..ef5e784afbc6d 100644
> > --- a/drivers/gpu/drm/tests/drm_managed_test.c
> > +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> > @@ -48,6 +48,34 @@ static void drm_test_managed_run_action(struct kunit *test)
> >  	KUNIT_EXPECT_GT_MSG(test, ret, 0, "Release action was not called");
> >  }
> >  
> > +/*
> > + * The test verifies that the release action is called immediately when
> > + * drmm_release_action is called and that it is not called for a second time
> > + * when the device is released.
> > + */
> 
> Thanks, it's much clearer now.
> 
> > +static void drm_test_managed_release_action(struct kunit *test)
> > +{
> > +	struct managed_test_priv *priv = test->priv;
> > +	int ret;
> > +
> > +	ret = drmm_add_action_or_reset(priv->drm, drm_action, priv);
> > +	KUNIT_EXPECT_EQ(test, ret, 0);
> > +
> > +	ret = drm_dev_register(priv->drm, 0);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	drmm_release_action(priv->drm, drm_action, priv);
> > +	KUNIT_EXPECT_TRUE_MSG(test, priv->action_done, "Release action was not called");
> > +	priv->action_done = false;
> 
> We should call wait_event_* here.
> 
> > +
> > +	drm_dev_unregister(priv->drm);
> > +	drm_kunit_helper_free_device(test, priv->drm->dev);
> > +
> > +	ret = wait_event_interruptible_timeout(priv->action_wq, priv->action_done,
> > +					       msecs_to_jiffies(TEST_TIMEOUT_MS));
> > +	KUNIT_EXPECT_EQ_MSG(test, ret, 0, "Unexpected release action call during cleanup");
> > +}
> > +
> 
> Tests should in general be as fast as possible. Waiting for 100ms for
> the success case is not ok. We have ~500 tests at the moment, if every
> test was doing that it would take at least 50s to run all our unit
> tests, while it takes less than a second at the moment on a capable
> machine.
> 
> And also, I'm not sure we actually need to make sure it never happened.
> If only because nothing actually guarantees it wouldn't have happened
> after the timeout anyway, so the test isn't definitive.

There's no difference in that regard (test being definitive) between
drm_test_managed_release_action and pre-existing
drm_test_managed_run_action.

If the action is executed after the timeout, with run_action we're going
to get a false-negative result, and with release_action we're going to
get a false-positive result.

> I guess what we could test is whether the action is still in the actions
> list through a function only exported to tests. If it's no longer in the
> action list, then it won't be run.

That would require digging into implementation details rather than
focusing on the interface, which, in my opinion, is not a very good
approach.

In the next revision I'll drop the waitqueue completely. If that won't
work, I also have a variant that uses bus notifier to make both tests
more definitive.

Thanks,
-Michał

> But unless we ever have a bug, I'm not sure it's worth testing for that.
> 
> Maxime



