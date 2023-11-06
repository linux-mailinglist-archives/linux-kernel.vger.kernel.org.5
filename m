Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E827E2D14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjKFTlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:41:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690F98;
        Mon,  6 Nov 2023 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699299692; x=1730835692;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/ApfnDGctoPRAAUz0Kk3TUlchg/jcOFSHz85tJuZkgQ=;
  b=iQSbzzqExDIWIJ+5moHdjFlXNT2PSeWgndQxNYMjMiH5utSwZPnOgdCe
   1obNPwOkUl0J4q4Dgf/q9FoEOne6lp/ahToz7xY43CTcBk1erUXp0Be+a
   /sTklisw+sCb1LkwDLKntfxTrRbb6/h7ErPy/hQUqzLpjm6RgWTFQL9yB
   bIgAgFKEXafgHdNWW6ef5CeJkMlcO2l+vvUUWX1AC5lzrE6VFdoB3qfiJ
   Y91O09XCfmORNb66cwUAGUk5Pj//Kej7y24bXLDxijXJWKrkBriJiPgyL
   Qk+K91rUItVHYRiwG077LxmILxgLbaLTvBW5b0lOqfsFYjIdMyuQ3WpXE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393246961"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393246961"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 11:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3556452"
Received: from lpilolli-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.222])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 11:41:29 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Hunter Chasens <hunter.chasens18@ncf.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net,
        Luca Coelho <luciano.coelho@intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] docs: gpu: rfc: i915_scheduler.rst remove unused
 directives for namespacing
In-Reply-To: <CAFJe6O1oJnQvLVSJZP6MMXULGrX=a3SEO1X5b4xff06WhqLw_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231104134708.69432-1-hunter.chasens18@ncf.edu>
 <ZUhvj2uj_PvaDxIM@debian.me> <8734xj18ck.fsf@intel.com>
 <CAFJe6O1oJnQvLVSJZP6MMXULGrX=a3SEO1X5b4xff06WhqLw_g@mail.gmail.com>
Date:   Mon, 06 Nov 2023 21:41:25 +0200
Message-ID: <87edh2zn2y.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023, Hunter Chasens <hunter.chasens18@ncf.edu> wrote:
> When running `make htmldocs` the following warnings are given.
>
> ```
> Documentation/gpu/rfc/i915_scheduler.rst:138: WARNING:
> Unknown directive type "c:namespace-push".
>
> .. c:namespace-push:: rfc
> Documentation/gpu/rfc/i915_scheduler.rst:143: WARNING:
> Unknown directive type "c:namespace-pop".
>
> .. c:namespace-pop::
> ```
>
> The kernel test robot also reported it here.
> Link: https://lore.kernel.org/all/202311061623.86pTQrie-lkp@intel.com/
>
> Last year Maryam Tahhan <mtahhan@redhat.com> from Redhat noticed something
> similar. "The missing support of c:namespace-push:: and c:namespace-pop::
> directives by helper scripts for kernel documentation prevents using the
> ``c:function::`` directive with proper namespacing." From the context, it
> sounds like this was brought about from a Sphinx update.
>
> Link: https://lore.kernel.org/all/20221123092321.88558-3-mtahhan@redhat.c=
om/
>
> When compiled the `.. kernel-doc::` literal gives it the same formatting =
with
> or without the namespace directives present. Due to the above information=
 I
> think it safe to remove these, as they don't seem to do anything but
> throw warnings.

Not so fast!

Looks like this is because namespacing was introduced in Sphinx 3.1
[1]. With earlier Sphinx, you get a warning about the namespace
directives.

However, with newer Sphinx, you get the warning mentioned in commit
f6757dfcfde7 ("drm/doc: fix duplicate declaration warning") if you
remove the namespace directives:

linux/Documentation/gpu/driver-uapi.rst:2279: WARNING: Duplicate C declarat=
ion, also defined at rfc/i915_scheduler:3.
Declaration is '.. c:struct:: i915_context_engines_parallel_submit'.

It would be short-sighted to just remove the directives. Sooner or later
we're gong to bump the (IMO extremely conservative) minimum version
requirement.


BR,
Jani.


[1] https://www.sphinx-doc.org/en/master/usage/domains/c.html#namespacing


>
> On Mon, Nov 6, 2023 at 5:31=E2=80=AFAM Jani Nikula <jani.nikula@intel.com=
> wrote:
>>
>> On Mon, 06 Nov 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> > On Sat, Nov 04, 2023 at 09:47:08AM -0400, Hunter Chasens wrote:
>> >> diff --git a/Documentation/gpu/rfc/i915_scheduler.rst b/Documentation=
/gpu/rfc/i915_scheduler.rst
>> >> index c237ebc024cd..23ba7006929b 100644
>> >> --- a/Documentation/gpu/rfc/i915_scheduler.rst
>> >> +++ b/Documentation/gpu/rfc/i915_scheduler.rst
>> >> @@ -135,13 +135,9 @@ Add I915_CONTEXT_ENGINES_EXT_PARALLEL_SUBMIT and
>> >>  drm_i915_context_engines_parallel_submit to the uAPI to implement th=
is
>> >>  extension.
>> >>
>> >> -.. c:namespace-push:: rfc
>> >> -
>> >>  .. kernel-doc:: include/uapi/drm/i915_drm.h
>> >>          :functions: i915_context_engines_parallel_submit
>> >>
>> >> -.. c:namespace-pop::
>> >> -
>>
>> What makes the namespacing unnecessary?
>>
>> $ git grep '.. kernel-doc:: include/uapi/drm/i915_drm.h'
>> Documentation/gpu/driver-uapi.rst:.. kernel-doc:: include/uapi/drm/i915_=
drm.h
>> Documentation/gpu/rfc/i915_scheduler.rst:.. kernel-doc:: include/uapi/dr=
m/i915_drm.h
>>
>> And you get [1] and [2].
>>
>> >>  Extend execbuf2 IOCTL to support submitting N BBs in a single IOCTL
>> >>  -------------------------------------------------------------------
>> >>  Contexts that have been configured with the 'set_parallel' extension=
 can only
>> >
>> > The warnings go away, thanks!
>>
>> What warnings go away?
>>
>> BR,
>> Jani.
>>
>>
>> [1] https://docs.kernel.org/gpu/driver-uapi.html#c.i915_context_engines_=
parallel_submit
>> [2] https://docs.kernel.org/gpu/rfc/i915_scheduler.html#c.rfc.i915_conte=
xt_engines_parallel_submit
>>
>> >
>> > Fixes: f6757dfcfde7 ("drm/doc: fix duplicate declaration warning")
>> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>
>> --
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel
