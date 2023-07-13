Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6197C752ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjGMTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGMTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216EB2D6B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SlWSwhHe+t/+5CD+8qzJLYQdlCsQhw+Uh2KGkPXB6kM=; b=vg3XLPJFrNw3vBwRCjiW5YxOq2
        J7z60gNJOjveg32CLIuJ85nynYH5q14lwRsCJUluPBYOWCNDwUUPmAzN1bbzgN4io1hrdAbNn+bet
        LvHAEgJAI3o+TolSH/sGJ6361Hl5rgpW0e7WaGYCAX2Jmm6BKgnZf+Xvchn5LU/nzwqptkUtfZPrg
        RIUS2TMNeUwzQXngfHeIGUDygAngNJiGYqLfhn/ym9A0WNBTTT/Qqyl22ZXC/vOOrpOxsQ0i3H5Ne
        RShtljbjCUdcWFxd8DVqFRYbU1479QbYMDVCzwsl/nd+vfJEiyINMToaackbPhBPrWaqhPUhfEKOJ
        iAesR+Yw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qK1l4-004DOL-2N;
        Thu, 13 Jul 2023 19:13:46 +0000
Message-ID: <76995421-a529-ac25-c306-2e4ac2844602@infradead.org>
Date:   Thu, 13 Jul 2023 12:13:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 21/21] dyndbg-doc: add classmap info to howto
Content-Language: en-US
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org
References: <20230713163626.31338-1-jim.cromie@gmail.com>
 <20230713163626.31338-22-jim.cromie@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713163626.31338-22-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 09:36, Jim Cromie wrote:
> Add some basic info on classmap usage and api
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  .../admin-guide/dynamic-debug-howto.rst       | 64 ++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 8dc668cc1216..878750ce8c1d 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst

> @@ -374,3 +373,66 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
>  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
>  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
>  in case ``prefix_str`` is built dynamically.
> +
> +Dynamic Debug classmaps
> +=======================
> +
> +Dyndbg generally selects *prdbg* callsites using structural info:
> +module, file, function, line.  Using classmaps, user modules can
> +organize/select pr_debug()s as they like.
> +
> +- classes coordinates/spans multiple modules
> +- complements the mod,file,func attrs
> +- keeps pr_debug's 0-off-cost JUMP_LABEL goodness
> +- isolates from other class'd and un-class'd pr_debugs() 
> +  (one doesnt mix 2 clients bank accounts)

          doesn't

> +
> +  # IOW this doesn't change DRM.debug settings
> +  #> echo -p > /proc/dynamic_debug/control
> +
> +  # change the classes by naming them explicitly (no wildcard here)
> +  #> echo class DRM_UT_CORE +p > /proc/dynamic_debug/control
> +
> +To support DRM.debug (/sys/module/drm/parameters/debug), dyndbg
> +provides DYNDBG_CLASSMAP_PARAM*.  It maps the categories/classes:
> +DRM_UT_CORE.. to bits 0..N, allowing to set all classes at once.
> +
> +Dynamic Debug Classmap API
> +==========================
> +
> +DYNDBG_CLASSMAP_DEFINE - modules create CLASSMAPs, naming the classes
> +and type, and mapping the class-names to consecutive _class_ids.  By
> +doing so, they tell dyndbg that they are using those class_ids, and
> +authorize dyndbg to manipulate the callsites by their class-names.
> +
> +Its expected that client modules will follow the DRM.debug model:
> +1. define their debug-classes using an enum type, where the enum
> +symbol and its integer value define both the classnames and class-ids.
> +2. use or macro-wrap __pr_debug_cls(ENUM_VAL, "hello world\n")
> +   
> +There are 2 types of classmaps:
> +
> + DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, ala DRM.debug

                                                          a la
or just                                                   like

> + DD_CLASS_TYPE_LEVEL_NUM: classes are relative (Verbose3 > Verbose2)
> +
> +Both these classmap-types use the class-names/ENUM_VALs to validate
> +commands into >control.
> +
> +DYNDBG_CLASSMAP_PARAM - refs a DEFINEd classmap, exposing the set of

Is this:                   refers to a
?

> +defined classes to manipulation as a group.  This interface enforces
> +the relatedness of classes of DD_CLASS_TYPE_LEVEL_NUM typed classmaps;
> +all classes are independent in the >control parser itself.
> +
> +DYNDBG_CLASSMAP_USE - drm drivers use the CLASSMAP that drm DEFINEs.
> +This shares the classmap defn, and authorizes coordinated changes

                            definition,

> +amongst the CLASSMAP DEFINEr and multiple USErs.
> +
> +Modules or module-groups (drm & drivers) can define multiple
> +classmaps, as long as they share the limited 0..62 per-module-group
> +_class_id range, without overlap.
> +
> +``#define DEBUG`` will enable all pr_debugs in scope, including any
> +class'd ones (__pr_debug_cls(id,fmt..)).  This won't be reflected in
> +the PARAM readback value, but the pr_debug callsites can be toggled
> +into agreement with the param.
> +

thanks.
-- 
~Randy
