Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841727EA9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjKNEiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjKNEix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:38:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE103CA;
        Mon, 13 Nov 2023 20:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699936729; x=1731472729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohzo45t/HD0va0rMadusXfp4O2Je7Z3oQh5TAr5oFZQ=;
  b=WNC2Cq+Ht6eDp+FXa1b+DnH6hmQZzgdrI1yAgS+AtT5UyOzmFScGYS5x
   eUm4q1Tftu9uMQwRmSUdM8IsIs49NLmPjla2lWuhulVkMabqD1s2t13Gh
   Fxz+teiT5JVqFiUqTNqqkm2LYDSQHA5mSxMSU8+jIVtOcUEsWiXCdWGnp
   7x3BNcQ3txbPtI00mlY2Ze8yI1hqY0aC6WskqT1XvkAP6cfUWqYk/S1iU
   G9ExiC/uVCJs4YJPexlhIrBTXeBfL36U70XalJxtKfa/9XAPvPAIToJ/9
   XHVfzwtNmUZit7vOBofQ9SY4kzVY5CAIZ1bgx+bssngx43d6FCgTn9ky0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421676432"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="421676432"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="768133012"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="768133012"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:38:47 -0800
Date:   Tue, 14 Nov 2023 06:38:44 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 0/3] Use the standard _PM_OPS() export macro in Intel
 Tangier GPIO driver
Message-ID: <ZVL5tMZLTDKNLfP2@black.fi.intel.com>
References: <20231113131600.10828-1-raag.jadav@intel.com>
 <ZVJHqrj5OzoWav5Z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVJHqrj5OzoWav5Z@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 05:58:34PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 13, 2023 at 06:45:57PM +0530, Raag Jadav wrote:
> > This series exports pm_ops structure from Intel Tangier GPIO driver using
> > EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper and reuses it into its users.
> 
> Yet you missed --base...

My understanding is that we use --base only for the patches with explicit
in-tree dependency, which this series doesn't have any AFAIK.

Will start using it for every patch if it makes everyone happy :)

Raag
