Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7577BDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHNQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHNQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:21:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19BF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692030084; x=1723566084;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qJG7pyee0uv7r8xKS0lzBdPtRoAuVGMgRxZJ+083uBQ=;
  b=nBHe0ctMi8t1CkLC50BUcPpU5IJ2jAhzQL7koZBJhuQTf4n5rMbmXZni
   bDXn9yf7af8W9TiWegQ0JW5FWtRlyJjLYeImO/FwdNfzeOVmiY3fWXNJ+
   mDPPOZTOSkvaE4ep2VuXp3eVBdMEfYNhG2djDrRNGuy38MogZShC0c01C
   B8/ql3lyZMIHbxDRnXk9SS+p7m6Gq++aFa4aYfsE7DHXbPVpFXigr/TrX
   kidJBSGYn+pJSGHZd45Bro+Rs9P+1osuGjDc/PzM0/9lSVfh9bsnkJrCB
   WV1vZhVCxXDuuWXdnt+9nIRrXPuKqXhXGAc+gihkRxs1LcDQ3teVa80Oa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="435963562"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="435963562"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803509234"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803509234"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 09:21:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:21:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:21:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 09:21:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 09:21:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3+Ddu0fXTd2511gvjlYwXN5rYBBjoOgcP9YzBg0swKRLwKde6gCmt1VW0YWrmWCHXspDRc0la1V6qE/wu8AFioNg1R8aXHJc0QE/Fmy/mX7GGMgMkC5pBswpnfPN0apITe5FVDYJHXXz7cRrDMcSMoU9CcgIhD+x0m6+qPwUDWn4zeZMhetn0OgsjrpClbf3OYbdX4C5BlzU4joEaxgyD6d6zXQlgijLvDj4P9D81bmgF47dg9PG9VDTbySN5jNYj+qTPWvl49j+oKLQwTyCtC/CIV5VWkzcf3klGk8Ayog7UMk7eb4ht6bXkbcd2A+IZp+HT7JvSnkd1SZurazCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hh0C1i7n7LtI/olCyNFfdbP4Ie0GGZDS1HLflLfVAQ=;
 b=dBJnrE2Xn2zEnWMGgHsiPMUMr7Mwloi+3RLi70Ibwdy0hlejbxb4SiOjcf3LIWWdvuG8mxDqLi+FGl+RZEbWINugvSOnINpgcbQ0DlMckzykKRrmrfx72DtLZrqqBQNRuHmFWSXtR1ar+mT0ZjYRxOfOzT4uF/1ZTgwLJ9iFjQaKEXs+OEMZNeYrpn0mIY9Bdgr5yCsTfd1RGsFGTX68OuGzsOJ0LIqXt2M3XBJ12J0Q8z+tWApWwpD0r4PGV9lfqvVWCpEKcJVViUY670fnwXPeO+APRdaGYz1GviZWwIsBYUegqrLC2nYOD5IM0OJFQucg1AZm9E5AAFdixN6wYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 16:21:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:21:08 +0000
Date:   Mon, 14 Aug 2023 09:21:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
Message-ID: <64da54713e2fb_2138e294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
 <e1a7a56d-b77c-4728-a8c7-be8db640c909@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e1a7a56d-b77c-4728-a8c7-be8db640c909@linux.microsoft.com>
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 104430a1-4568-4c93-ab8d-08db9ce2774b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJlDdGmHKMVJ7oDsI4DBXlU/0QykqzuHCnE118q0BnGpmIk+8gIHp5FVvYQhi34x6K3wyZgpCsFqpjsXtvIWSrsbJTtrJgG1xm0usoor7oY8ZQ36WQXJXJC5ikH8cmyD3oMeMPIXSgaumHdVskeSsuPZe7waMZbMHuu8M+DqNd2vNkpq5D/1VKp4DDIMlb4dNpYePl9dzxbAue6oGrUzBEM4EIPPLBbyQvuDP9n/HduSEGlVBSwlEMc7eoCdN8AZUIpvO0QWXZtXR1I01u8O9axpXiOqf1smW7CO4hQDajiI0VfF7UAqZP2PIW5N+imGLoVfSstmgsziJoOLj6W1ICfBIQmUnjUw6KfIjOPl6Az2a7uGRfvZtbGGq0oUEMmXxIbkGOVCeWdXv0N6n4am4vOYLIjwpKw7lHAKVuqwvAEsUPd2oHQDcLTkVKxOquRIFhdGYRaaTE0QI8eYDVMHJIXJJj2RJOCwjieqvUqGptf7r3pyjFIkLm0Di2psEW4OHae319IFdgFC9sbIeAZF9xucQSDs2ydU4bB++3ZedQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(1800799006)(186006)(451199021)(9686003)(6486002)(6512007)(966005)(6666004)(38100700002)(82960400001)(83380400001)(86362001)(53546011)(26005)(6506007)(2906002)(54906003)(110136005)(478600001)(7416002)(8676002)(41300700001)(5660300002)(8936002)(66556008)(66946007)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?234qsNMTH9DcoUAawtAppl3c1CnUpK8CvW0gV7U4KuVO4uz/PiUMsG2Amr9h?=
 =?us-ascii?Q?V1olHlyeS3cTSYoLYRP6kA9YiA/YP4nYILCELUPi13BO8Kl/M1T1xSf0AHbd?=
 =?us-ascii?Q?ndnaMO9VkzROZz6hv9O/Ye/QOe7fIGlniAqMp05JUOtEPiLdaW5eCMUFKM5W?=
 =?us-ascii?Q?hbs8jO7yEHVvWcpspjPmTEhbPItHW+zZcLumk1Pg7nLstdwHFo3kr4SeuAwr?=
 =?us-ascii?Q?FXgpXqQOSk7zsnqFewfzDcS8bygxVDcpacdMwRFENKZzfV1REZ6Rre+aWgN7?=
 =?us-ascii?Q?PlP9Fur4vQ1e8EhiJ6nceSbAwBlbOPVJ4dMZCpg0nks+YHncbqWuc1L485T5?=
 =?us-ascii?Q?vnH+k4cEeCd8GZF+gPygHEmFz8QyUpf3L08pVUOoSA/KXymLeH4BKA5TzlV1?=
 =?us-ascii?Q?L8i3qdfiCO8Yyd3mAiNttrUA7fmzlMiHSUfeSCusVRYWY6F0ffapWGW1tC7n?=
 =?us-ascii?Q?+FkOPOVs0Wvs5BKpS0HyXydnLHN0EJ979O5tn+P+zgNW1PPsyQ0jCfWVLQ+d?=
 =?us-ascii?Q?vFJ/ysp/gYR33ZVH4dx5YTJGk8eiqHjd9owuss3iwPcSY43INjbWQ/tpZ51F?=
 =?us-ascii?Q?wdaDW2pCynDIT8QB/ZgiRs6xboTf+LfguiYszqfP+p0WTK3ReY9+gNHUH0C4?=
 =?us-ascii?Q?BxEsNO5WJiF7hbseAeV5sIjjG4Neah6SUSAzzTjtyIusUyxaRSqG6ezIOuHq?=
 =?us-ascii?Q?0MbnWZtVV9iHiqeP+dgKaqq7cc30ZYeTq6xxjnJpHfG0FBr4jWAD9wj7SqOy?=
 =?us-ascii?Q?NemG1R2b6z5mJBvHyARtdqxz01OiQKDhYiJCD5Wu6sOVa9ubs4Zus2mofliU?=
 =?us-ascii?Q?K8Bm8ZxS678TTTYS/E0Y2R93OFwYEqIGHGDfrDD08OfOwMFV1ZZqKSTlptZr?=
 =?us-ascii?Q?AR23V7mMRYfEKY3V3V/R1H7Vita16st103glVdnTBs8Pw3tKNBzpD5WT8Zf1?=
 =?us-ascii?Q?wyC00p/DJ5a3454eBQOGrjSia4hq7BVIpdVsYg0pUbhAOuHAS4ZjlGkd91w1?=
 =?us-ascii?Q?3Gbd0cYdpMBpFpRWgajzqyAjFoph2tgDl0EtNqazBxhdQHo/gYTyrSnzlZRA?=
 =?us-ascii?Q?4UDRH9hgecvyLjuavzizXaknJPu+Vinz5FZY2/WOdTE9atUrLYVIfj8+B/6B?=
 =?us-ascii?Q?F3eT2CgUAfsM6HW/1XAtW4Jyap6WIXFknTdwUuU1bkxS+VMF0B2x0YecSDsT?=
 =?us-ascii?Q?ANnFKe9VQoQP/i+trxk9jSG/eLYos+KIxa9NcPoyv2gzvmNo/9Au2shjpFhv?=
 =?us-ascii?Q?AMvQV9V0msOIvYKZGyk37UhpgP844SCK4i2/pDezj8sOpvMy4h0XgmMKxtDn?=
 =?us-ascii?Q?gwabUF4RYCprpECH3WQVxukdAfDvXHSADvbLzdAp5Tk/Ir0qW2xuxEqeuP4D?=
 =?us-ascii?Q?+6pgfgY6yNBtcuzwYZMew1wHZMeXWFUZwuP7z2U1QiIQwTA8uJcAbRC72PAy?=
 =?us-ascii?Q?EV6+67/xj86gh/sUoJYj/7h4jjjcVZYSqPq/objJqSb9kkQNl/ucJYLuJu+9?=
 =?us-ascii?Q?D6DRxGqo0e92b2Q9e/7xl/b2Zkks1JRfK249UkU5Y+38ksOvb7GqnjG8SXRC?=
 =?us-ascii?Q?i7HNqBfDIlWEs69oTsc8P7C33/tuHk20kbrQtl2EhnZ3vZtdf2jgRL1dUUXp?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 104430a1-4568-4c93-ab8d-08db9ce2774b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:21:08.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQpTJC5/Kbd0OFhFPeO+epz4GBH7hneAy9vWIKlCvnH6at/liR4kkzygpswnDQfSHW7nrUfBw64WSmJ3vd1gSNKyV5aTU6R4xPpBklhCNS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
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

Jeremi Piotrowski wrote:
> On 8/14/2023 9:43 AM, Dan Williams wrote:
> > One of the common operations of a TSM (Trusted Security Module) is to
> > provide a way for a TVM (confidential computing guest execution
> > environment) to take a measurement of its launch state, sign it and
> > submit it to a verifying party. Upon successful attestation that
> > verifies the integrity of the TVM additional secrets may be deployed.
> > The concept is common across TSMs, but the implementations are
> > unfortunately vendor specific. While the industry grapples with a common
> > definition of this attestation format [1], Linux need not make this
> > problem worse by defining a new ABI per TSM that wants to perform a
> > similar operation. The current momentum has been to invent new ioctl-ABI
> > per TSM per function which at best is an abdication of the kernel's
> > responsibility to make common infrastructure concepts share common ABI.
> > 
> > The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> > more, is to define a sysfs interface to retrieve the TSM-specific blob.
> > 
> >     echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
> >     hexdump /sys/class/tsm/tsm0/outblob
> > 
> > This approach later allows for the standardization of the attestation
> > blob format without needing to change the Linux ABI. Until then, the
> > format of 'outblob' is determined by the parent device for 'tsm0'.
> > 
> > The expectation is that this is a boot time exchange that need not be
> > regenerated, making it amenable to a sysfs interface. In case userspace
> > does try to generate multiple attestation reports it includes conflict
> > detection so userspace can be sure no other thread changed the
> > parameters from its last configuration step to the blob retrieval.
> > 
> > TSM specific options are encoded as 'extra' attributes on the TSM device
> > with the expectation that vendors reuse the same options for similar
> > concepts. The current options are defined by SEV-SNP's need for a
> > 'privilege level' concept (VMPL), and the option to retrieve a
> > certificate chain in addition to the attestation report ("extended"
> > format).
> > 
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Peter Gonda <pgonda@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
[..]
> > +static ssize_t outblob_read(struct file *f, struct kobject *kobj,
> > +			    struct bin_attribute *bin_attr, char *buf,
> > +			    loff_t offset, size_t count)
> > +{
> > +	guard(rwsem_read)(&tsm_rwsem);
> 
> This is unfortunate but it would need to be a rwsem_write otherwise two
> processes can race to reach the kvfree and both call report_new at the
> same time (unlikely as it may be).

Ugh, yup, good eye, will fix.
