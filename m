Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBD77F6D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350988AbjHQMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjHQMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:52:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771BC2D70;
        Thu, 17 Aug 2023 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276727; x=1723812727;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uTZXa2ZbJ5+m4Bkygw68tvUEp95Uj8Il/aB6Vw3a5qg=;
  b=oEFojDSe8e0IjhrB9G/LjaetystUylVcmV1uhxLS1IEpZWXQQlkySbcd
   i7YnK3f8pWRL+iKZqYLrvKqEVPK3US3+RDqV45GnY8x1rhLtUDUlbvsFs
   mQ5WmiGsoWR5wO8fofSnWVtVF4QDcP37KgcAz2I4f7QOsjaLTv1LzUDix
   8MFLdqWxK3jtNvGvyJY+NMit7Pr/MKWXmM+yq/HrcC8zM85wtCD1GCTsu
   aPTXXn2O0+Yx/TRMHGorJc3E4kSXElTferqyqQ/CGhjt+AU79Lg019RwJ
   3o8VWaQ3B6GrqxL3SXMUDzo8aUtphxj/jWMSwg/XS8vlt/r12UgS0Kybd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="459157730"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="459157730"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:52:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804624818"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="804624818"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 05:52:01 -0700
Message-ID: <ef189a18-98ba-52c9-13a3-ce8531fc18cf@linux.intel.com>
Date:   Thu, 17 Aug 2023 15:53:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cc271e17-6204-b610-b40e-5c882ad6be36@suse.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current wakeup
 on system suspend
In-Reply-To: <cc271e17-6204-b610-b40e-5c882ad6be36@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.8.2023 14.18, Oliver Neukum wrote:
> On 17.08.23 11:33, Kai-Heng Feng wrote:
> 
> Hi,
> 
>> So for system-wide suspend, also disable connect, disconnect and
>> over-current wakeup to prevent spurious wakeup.
> 
> isn't this breaking the ability to effectively use your root hub
> as a source of system wakeups? That is, even if you want the
> system to wake up if somebody attaches a new device, it no longer works?
> 

I got the same concern about this.

-Mathias
