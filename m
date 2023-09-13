Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB379E4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjIMKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIMKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:32:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C57D3;
        Wed, 13 Sep 2023 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694601155; x=1726137155;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5t3z4o6kZ1KUc08UcPLGB8pqxJnJEeeNk5Oanyn4G7c=;
  b=Erj0fkk9eQWJkl1coWw2WlRCxM0mbF8PyuzunhjzVI9p1UXnrPwyrpV0
   XzvXBIliNPuyfqhQqfXvkDVs5LJJGzhj3wFjgDjGOObYiYgSlrUqcdW6c
   ThebzULD3PTJSnqxzK3ne6jpnxZAVB9J04ZYk7MJEdoE7M9+SIcEOXIOK
   e+kyFqs/D707EWJg9yEQ5CjO8jVo/7aSArnpuBzhEGiAMXavml68aRWPp
   OpCs3lE8h220Jleuneo63kOXT8zgXT5hE25JYLc8DFyNdsJyggfM6ac2I
   NmBBwFDUiygZNzmt37kamzAwTiHf8zDXKNdPI5AFvE/l4EDxWVziUFlRP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377534551"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377534551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990870447"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="990870447"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.145.205])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:32:26 -0700
Date:   Wed, 13 Sep 2023 12:32:22 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next] md: simplify md_seq_ops
Message-ID: <20230913123222.00006a8e@linux.intel.com>
In-Reply-To: <b2754d8e-dfe7-ffff-66ac-052f366530e4@huaweicloud.com>
References: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
        <20230911160540.0000060e@linux.intel.com>
        <b2754d8e-dfe7-ffff-66ac-052f366530e4@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 09:02:19 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> >> +static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> >> +{
> >> +	return seq_list_next(v, &all_mddevs, pos);
> >> +}  
> > Can it be so simple? Why previous versions takes care of holding "(void)*1"
> > and "(void)*2" then? Could you elaborate?  
> 
> "1" means printing "Personalities", which is now moved to md_seq_start,
> and "2" means printing "unsed devices" which is now moved to
> md_seq_stop. And now md_seq_next is only used to iterate the mddev list.
> 

Ok, LGTM.

Mariusz
