Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1878BF51
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjH2Hit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjH2HiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:38:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2C132;
        Tue, 29 Aug 2023 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693294697; x=1724830697;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=7xbIuAVv6BRYk1f4b+LCb+VtGRsblUZaWwZkr0s2oa0=;
  b=liawHG+5vekYu4rkUywU+qoo4MNKKB01hy6wZ7oY7gUJGc7yX9u9h2YX
   mHdTCI+ft7gJSFj0qHK2Bvx4TKBAh0m42hR+vzOKcH9pdHbhtEAgSHMlj
   5b2JWM/A6Yybk2VHZWQRwQJfP5QWzEQp9jOtzYDJ6kO+zxzHD0wA2EpYU
   CI53mz5WScBeqCkb7gNVJc75n/oz/SVpdDoo0TaTe1yHfOz5LPjTt2xIM
   KA5xuBU6KBnpq7ZlQY3MnR5HXVvM8T0O3qJIAuzdeps1/SxJwwRbMA4GT
   laI0ogFEQC/o+IH1FDclLyAtJQtFFSfEmRx21oXsnGacyjel71QAQeO0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="375263854"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="375263854"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 00:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853178928"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853178928"
Received: from mnefedov-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.32.206])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 00:38:11 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
In-Reply-To: <20230828165038.GB818859@hu-bjorande-lv.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com>
 <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
 <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
 <9aec0740-2482-d3ad-caf2-5e6278a050b3@suse.cz>
 <89c73602-43f1-30a4-ad58-637aadacd653@linaro.org>
 <20230828165038.GB818859@hu-bjorande-lv.qualcomm.com>
Date:   Tue, 29 Aug 2023 10:38:08 +0300
Message-ID: <87cyz62t9b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> On Mon, Aug 28, 2023 at 05:23:58PM +0200, Krzysztof Kozlowski wrote:
>> On 28/08/2023 17:14, Vlastimil Babka wrote:
>> > On 8/28/23 15:48, Geert Uytterhoeven wrote:
>> >> Hi Bjorn,
>> >>
>> >> On Mon, Aug 28, 2023 at 3:37=E2=80=AFPM Bjorn Andersson
>> >> <quic_bjorande@quicinc.com> wrote:
>> >>> On Mon, Aug 28, 2023 at 11:14:41AM +0300, Jani Nikula wrote:
>> >>>> On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wr=
ote:
>> >>>>> This script runs get_maintainer.py on a given patch file (or multi=
ple
>> >>>>> patch files) and adds its output to the patch file in place with t=
he
>> >>>>> appropriate email headers "To: " or "Cc: " as the case may be. The=
se new
>> >>>>> headers are added after the "From: " line in the patch.
>> >>>>
>> >>>> FWIW, I personally prefer tooling to operate on git branches and co=
mmits
>> >>>> than patches. For me, the patches are just an intermediate step in
>> >>>> getting the commits from my git branch to the mailing list. That's =
not
>> >>>> where I add the Cc's, but rather in the commits in my local branch,
>> >>>> where they're preserved. YMMV.
>> >>>>
>> >>>
>> >>> May I ask how you add/carry the recipients in a commit?
>> >>
>> >> I guess below a "---" line in the commit description?
>> >=20
>> > Does that do anything special in commit log? I'd expect (and I do it t=
hat
>> > way) it's rather just adding a
>>=20
>> It does. It goes away.
>
> Afaict, it's verbatim copied into the .patch, which would mean that it
> goes away when the patch is applied on the other side.
>
> But it's still going to be in the email (followed by another ---), so
> unless there's another step later in the process that cleans this up I
> it looks ugly, and not very useful - unless I'm missing something.
>
>> >=20
>> > Cc: Name <email>
>> >=20
>> > in the tag area where s-o-b, reviewed-by etc are added.
>>=20
>> Why storing autogenerated scripts/get_maintainer.pl CC-entries in commit
>> msg? The non-maintainer-output but the automated output? There is no
>> single need to store automated output of get_maintainers.pl in the git
>> log. It can be easily re-created at any given time, thus its presence in
>> the git history is redundant and obfuscates the log.
>>=20
>
> Fully agree to this. In particular if the patch is going to be sent as
> part of a series the recipients list won't be accurate for any patch.
>
> The case I was looking for was the case where I want to make sure to
> include a specific person, beyond the get_maintainers output. So pretty
> much the usual Cc: tag in the commit message, but I don't necessarily
> want to write this fact into the git history.

The point is, I *never* use get_maintainer.pl output as-is.

BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
