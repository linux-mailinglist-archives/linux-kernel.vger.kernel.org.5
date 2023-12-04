Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0F8040BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjLDVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:07:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779A2FF;
        Mon,  4 Dec 2023 13:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701724082; x=1733260082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPGLUM4c886/Ong4yoTXqdUFBVQ8BJ8aMq6WA07Hqyw=;
  b=cSkTOQcqHkCgslZSNYm51BaQowROp24va93SiY3QG4qUiFQ/+wqIkyWh
   ZA9Wqmiy8iOU9gyD6s04uBbJMkYeFrQaGDTwgb3dp4fgXOR6DpL5nImIT
   AZNkFmasmG6DnyB0b89Wp0zwHhjM4MDYCFg1bmNMQ/rKYeK8RuCylvGgZ
   7gX+cxCwlNp4vDBC0PcUdeKO6CuHuJ/oOIHhLvjw209XvlJvjulY83SHS
   Y1elTb2sxL9BD6pHA64tpaWuvki1rjtFK+9H88SbAYPDi4pu7CcVrgsIF
   J2AdL8cZ6emVqvUGhd7vX35WK/Yxf+PKMGWha3pGxEtqBlL2SSXv7wU+t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="396597278"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="396597278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="894128159"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="894128159"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:08:01 -0800
Date:   Mon, 4 Dec 2023 13:08:00 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Message-ID: <ZW4/sE4Af0p3jl07@agluck-desk3>
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
 <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
 <ZW4XjqxfYBFZId6H@agluck-desk3>
 <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
 <SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0285bbec-7152-4f54-94a3-45ce265a3ebe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0285bbec-7152-4f54-94a3-45ce265a3ebe@intel.com>
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

On Mon, Dec 04, 2023 at 12:03:23PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 12/4/2023 11:45 AM, Luck, Tony wrote:
> >> Yes. I saw the thread. Even then I feel having two similar options can
> >> cause confusion. I feel it is enough just to solve the original problem.
> >> Giving more options to a corner cases is a overkill in my opinion.
> > 
> > The "original" problem was systems without "local" bandwidth event. I
> > wanted to give a way for users of mba_MBps to still have some way to
> > use it (assuming that "total" bandwidth event was present).
> > 
> > Reinette suggested that some people might want to use "total", even
> > on systems that support "local". I firmly agree with that.  It is easy to
> > construct scenarios where most bandwidth is to a remote node. using
> > "local" event will do nothing to throttle in these case. I'm not at all sure
> > why "local" event was picked. There's nothing in the LKML threads to
> > give clues.
> > 
> > I proposed a mount option "total" as a modifier to be used in conjunction
> > with "mba_MBps". Reinette said it was too generic. Her suggestion was
> > to add "mba_MBps_total" to be used instead of "mba_MBps".
> 
> No, it cannot be used instead of "mba_MBps". My intention was for it to be
> in addition to existing "mba_MBps" since taking "mba_MBps" away would be
> considered breaking user space ABI.

I was unclear. The mba_MBps option must remain as legacy ABI. My
"instead of" was intended to convey that a user wanting total bandwidth
would use:

# mount -t resctrl -o mba_MBps_total resctrl /sys/fs/resctrl

rather than the new option being a modifier and requiring both
the legacy option and the modifier like this:

# mount -t resctrl -o mba_MBps,mba_MBps_total resctrl /sys/fs/resctrl

which seems overly verbose.

> 
> Even so ...
> 
> > 
> > Is that where I should have gone, instead of "mba_MBps={local|total}"?
> 
> While I did propose "mba_MBps_total" (in addition to "mba_MBps") I do
> recognize your comment that a new key of mba_MBps_event does give more
> flexibility if different events become available in future. Emphasis is
> on "different" since I do not believe the parsing can support multiple
> events and thus mba_MBps_event cannot be treated as a general bucket for all
> mba_sc options, just different events guiding the feedback loop.
> 
> "mba_MBps" must be kept and having it continue to use local bw as default,
> but total bw on systems that do not support local bw seems appropriate,
> (which is what this patch does).

So we defintely have:

"mba_MBps" - defaults to local, on systems without local may switch to
total if that is available. Should this switch get a pr_info()? Or just happen
silently (as I've done in patches so far).

and need to come to agreement on which of these to implement:

A) "mba_MBps_total" - forces use of total. Fails the mount if total is not
   available.

B) "mba_MBps={local|total)" forces use of chosen event, fails if event
is unavailable.

C) Something else.

D) Don't provide any way to force use of total event.

> 
> Reinette

-Tony
