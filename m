Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370577DFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjHPLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbjHPLDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:03:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C52128;
        Wed, 16 Aug 2023 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692183803; x=1723719803;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=bUv1wXkr/uZoLvVTS8ckUalhZnE5wuaaS21qmwPwdF4=;
  b=KotHJNDJm/2r3RSQnSM1SAjtEl3Xnbv+yhSvrbxbXXiyFfRR1DAaRQGd
   nBsU2FGXJFHVFeYKXRkEmJYt3qdOVA5wZsVA4lGefknzZP9olK2ItmY9Y
   R5HvUWx5jvX4XuTK9Czn8hDdCXMmtjb223Qp/nJRKphTyK4lTnFjMWhno
   MG2sODfgaRnngrbvgTawIMyeMPKdZozZ4gjdCnGayMoJXg7SfpNZV9fB2
   0PiWfttAVKlWq5pZ5m0hCts3hX3RD6kfJ0D1p+B26wPFO7uWcIErHH3ZO
   WcQ11pRIs7vXfBBltA17DQPQQulqVGuUMgdPuA9LHAs457KTR1ePxNXsG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371410755"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="371410755"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711082099"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711082099"
Received: from golubevv-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.52.134])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:01:39 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
In-Reply-To: <ZNvGz4v2QYowrhk0@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
 <ZNvGz4v2QYowrhk0@casper.infradead.org>
Date:   Wed, 16 Aug 2023 14:01:35 +0300
Message-ID: <87bkf79row.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Aug 15, 2023 at 08:35:40PM +0200, Miguel Ojeda wrote:
>> On Tue, Aug 15, 2023 at 8:23=E2=80=AFPM Jonathan Corbet <corbet@lwn.net>=
 wrote:
>> >
>> > As an alternative, of course, we could consider turning off those
>> > specific warnings entirely for normal builds.
>>=20
>> It could be nice to get to enforce warning-free builds as soon as possib=
le.
>>=20
>> Perhaps we could move those to a `W=3D1`-like group and clean them over
>> time instead? Or do we have that already?
>
> I think the problem is that we don't run kernel-doc by default.  Instead,
> it's only run for W=3D1 (and higher) builds.  That's why Carlos doesn't
> see the problems he is introducing in his own builds.  Of course, if
> AMD required building with W=3D1 then they'd see these problems earlier
> in their own testing.  Apparently they don't.
>
> Is it time to just run kernel-doc by default?  There aren't _that_
> many kernel-doc warnings now.  Not compared to how they used to be.
> And enabling them for everyone means that new ones won't sneak in.
> I haven't timed how much extra time kernel-doc adds to a build.
> Perhaps that's infeasible.

Personally, I believe it's easier to get at a warning free build (both
compiler W=3D1 warnings as well as kernel-doc) by doing it driver and
subsystem at a time, instead of, say, one warning at a time across the
entire kernel. It's just too much of a burden to fix the entire kernel
to enable a warning across the board.

To that end, the i915 Makefile enables a lot more warnings than the
defaults, and the developers and CI run the compiler and kernel-doc with
-Werror. No new warnings get introduced.

What I'd hope for is build system support to enable W=3D1
compiler/kernel-doc warnings for a subdir with a few lines at most,
instead of duplicating and copy-pasting tens of lines from
scripts/Makefile.extrawarn like we have to do now.


BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
