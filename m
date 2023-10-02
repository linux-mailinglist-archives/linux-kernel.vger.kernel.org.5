Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A0C7B4C98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjJBHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjJBHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:36:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DA5A7;
        Mon,  2 Oct 2023 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696232174; x=1727768174;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=oyVkJe+bvjoFz09YDo+qoxynv+bU5hsnVCU4huRc1CA=;
  b=Q+GoOXE1lR33OhTFEglAI93SJlhgyk+iTPrTvvqGhkrT+1OZcJ4As088
   eScyw7eDpsg3u02+Fchz7dbqclQeJQZRiU2dRpI1fyPswQh/ZdsH3hzdb
   NSZ2JYhh9/enl4NjB4wZ7+JrGkQWDeX88fO0jzHbWRXovkVh6QE7FkOun
   2OYItclOv2ihuiDq+ZA/5mKK5ACKqN2sA6haGAwpDxkkQ+e4y41jT5Zhl
   4fzOpNWWKbVQbbknzb4Sv0rOCWn2XdTVGCLxtO5ifkl8PqDt0Jng+1+Op
   e0xJ238yUpmmacHov9JYVxCQt4Jk4A4yyRJdAHReU8yUf9nF8zoZvMIe/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="446751767"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="446751767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 00:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="866424772"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="866424772"
Received: from svandens-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.151])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 00:36:10 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: encourage direct
 notifications to reviewers
In-Reply-To: <ZRpkWXMiQjUJPszZ@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
 <ZRVDv2fiFyW2S0z1@infradead.org>
 <f4ce8205-93a6-4ef5-94c0-1fb8d261bcac@t-8ch.de>
 <ZRpkWXMiQjUJPszZ@infradead.org>
Date:   Mon, 02 Oct 2023 10:36:01 +0300
Message-ID: <874jj9iihq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2023, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Sep 29, 2023 at 09:24:57AM +0200, Thomas Wei=C3=9Fschuh wrote:
>> > This does not scale.
>>=20
>> Could you elaborate in which way it doesn't scale?
>
> If I send a modest cross-subsystem series it often touches 20+
> subsystems.  Between mailing lists and maintainers that's usually
> already 60+ recipients.  If you now add a another 2-3 maintainers
> we're just going to hit limits in mail servers.

I thought this was about adding people who have commented on previous
versions to Cc. That's usually a very limited number.

BR,
Jani.


--=20
Jani Nikula, Intel
