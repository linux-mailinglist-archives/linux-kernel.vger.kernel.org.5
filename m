Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CA751423
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjGLXIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjGLXH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:07:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C1268D;
        Wed, 12 Jul 2023 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203258; x=1720739258;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zF/TXZw6hOm08VrKmM6zI6uDz3q9AB/6cG/sj6SO8/Q=;
  b=aQ35bKgZcelOnc+imrUyyFKdEZiwY5g54N1ZRi/9TkX3ReAuW7wsdOlJ
   vHu/KuRuFG6+6ODHjUtkQteh8v1a9dM2lui7OBRWp48RdN11m0Vxu0zUh
   RGSfSGIgiWjWvqYfChrrwwtBPv0DtBjgwult2FsKOWEGIQfVoxxbYpjOz
   j3Zyb/39XrNQRSCC8b0u4MMoJnnveiEzNb6+z3CNuTEtHsxbn2AFrlIIG
   zvMFioGHKpdrZLi8DUqXEr62KtSLfXuxZN3PoztxFJZT3pMKxG06Z93WA
   8aZBmqBSAqBDJwAx/j5dQ5mXbawASg5hN5oYXjl80eeSsuakv8ACIXQPD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451388411"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="451388411"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751351909"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="751351909"
Received: from nlsegerl-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.182.248])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:07:19 -0700
Message-ID: <39172b7b3016a7f850cbffe752cb8ccdb986623d.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] doc: TPMI: Add debugfs documentation
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 16:07:19 -0700
In-Reply-To: <ZK7DYuyo88efUje+@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
         <20230711220949.71881-4-srinivas.pandruvada@linux.intel.com>
         <ZK7DYuyo88efUje+@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 18:14 +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 03:09:49PM -0700, Srinivas Pandruvada wrote:
> > Describe fields in the TPMI debugfs folder.
> 
> ...
> 
> > +What:          /sys/kernel/debug/tpmi-<n>/pfs_dump
> > +Date:          December 2023
> 
> November ?
> 
Changed.


Thanks,
Srinivas

> > +KernelVersion: 6.6
> 
> ...
> 
> > +Date:          December 2023
> 
> > +Date:          December 2023
> 

