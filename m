Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267A801EAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjLBVaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:30:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26000E5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:30:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cda22140f2so3250334b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552608; x=1702157408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5J15MlXHLI92cGapwCUHhHVqByLKgeQqZvgS95PAzA=;
        b=dlto57h7Wpk0SmZ008RWoyaZgsqCbIumChqPhf2hssU5qNq+J65bivQmQFo5KR4J9P
         h6YXSKoZtWZM3hYbiM8zO7EOHY+g/9vx4We8PmfWfLGGJQE/HiRZYLg6WIwSvCl8hFEx
         bKO8LPNX6MUtq+gxtCC8EQtUMgTEDQX6qdy80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552608; x=1702157408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5J15MlXHLI92cGapwCUHhHVqByLKgeQqZvgS95PAzA=;
        b=ORXOSzTQCcXSEKNYlkWbZyd+G0IZOC5S7JQFAfLqbh4JVyRRAAjmaaQSq5BZD8pIfY
         VQ0mUtkqB1JYNtsR8OV7qoBXapU/37bk8p/NYI64v7dhe41hylYmO+ynHCbp1oE09pm/
         SNjiRvYAdy2Pw53m6Wpamq7bJolHoV+q3gP6f5xbGgL5klZ3bOSDjcQ6SyXjLVPd/2iT
         h6INbJcdDOOLVqWwxdm9y4DJltlyHLQbA3XodiWQmNx+rwTpR/wiZAgKnRoA1PQdHuVJ
         CmKMv11qDUT9+JsEBDWAimP8QNhDL7Htd/UNS2BaQVlyiE7gZAGuxcaiAZlXTI9Oe38g
         vjZg==
X-Gm-Message-State: AOJu0Yw3HJTZL4b+Uhhshh8kO4f/v5OeCEyLfESeX+vDs5SemraELHPa
        tALZkKnHxod0mpSo1LWjYP3H+w==
X-Google-Smtp-Source: AGHT+IHvVBon3TJyINAYLAf07X3SlMJEK4rycMYTmue0klxJqQCgHaBNdJUe4p9vusQ32Ct3N0bKjg==
X-Received: by 2002:a05:6a00:2d24:b0:6ce:3c1e:743f with SMTP id fa36-20020a056a002d2400b006ce3c1e743fmr849277pfb.41.1701552608590;
        Sat, 02 Dec 2023 13:30:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o24-20020a056a001b5800b006ce3a0b4bfasm984474pfv.24.2023.12.02.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:30:07 -0800 (PST)
Date:   Sat, 2 Dec 2023 13:30:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Message-ID: <202312021329.86D56FA@keescook>
References: <20231201031505.286117-1-sxwjean@me.com>
 <20231201031505.286117-3-sxwjean@me.com>
 <202312010945.7C5DB1FBB@keescook>
 <PH0PR11MB51923F916D8FB7D94270BBA7EC80A@PH0PR11MB5192.namprd11.prod.outlook.com>
 <67b155dd-3731-489e-c3bd-333cb7e90801@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b155dd-3731-489e-c3bd-333cb7e90801@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 07:12:25PM +0100, Vlastimil Babka wrote:
> On 12/2/23 05:23, Song, Xiongwei wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Kees Cook <keescook@chromium.org>
> >> Sent: Saturday, December 2, 2023 1:48 AM
> >> To: sxwjean@me.com
> >> Cc: vbabka@suse.cz; 42.hyeyoo@gmail.com; cl@linux.com; linux-mm@kvack.org;
> >> penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com;
> >> roman.gushchin@linux.dev; corbet@lwn.net; arnd@arndb.de; akpm@linux-
> >> foundation.org; gregkh@linuxfoundation.org; linux-doc@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; Song, Xiongwei <Xiongwei.Song@windriver.com>
> >> Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with "slab_$param"
> >> 
> >> CAUTION: This email comes from a non Wind River email account!
> >> Do not click links or open attachments unless you recognize the sender and know the
> >> content is safe.
> >> 
> >> On Fri, Dec 01, 2023 at 11:15:04AM +0800, sxwjean@me.com wrote:
> >> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >> >
> >> > Since the SLAB allocator has been removed, so we need to clean up the
> >> > sl[au]b_$params. However, the "slab/SLAB" terms should be keep for
> >> > long-term rather than "slub/SLUB". Hence, we should use "slab_$param"
> >> > as the primary prefix, which is pointed out by Vlastimil Babka. For more
> >> > information please see [1].
> >> >
> >> > This patch is changing the following slab parameters
> >> > - slub_max_order
> >> > - slub_min_order
> >> > - slub_min_objects
> >> > - slub_debug
> >> > to
> >> > - slab_max_order
> >> > - slab_min_order
> >> > - slab_min_objects
> >> > - slab_debug
> >> > as the primary slab parameters in
> >> > Documentation/admin-guide/kernel-parameters.txt and source, and rename all
> >> > setup functions of them too. Meanwhile, "slub_$params" can also be passed
> >> > by command line, which is to keep backward compatibility. Also mark all
> >> > "slub_$params" as legacy.
> >> 
> >> *If* we do this, I think the old names need to be recognized, perhaps
> 
> Yes, they are already recognized by the patch.

Ah, sorry, I missed that. I didn't see it when I skimmed earlier.

> >> with a boot pr_warn() about their deprecation/renaming for several
> >> releases (likely across LTSes). I think it's not a good idea to
> >> wholesale rename these with no warning. That's going to cause a lot of
> >> surprises and broken userspace...
> > 
> > Oh, yes, that's a good idea. Will update.
> 
> I'd wait for a while with the warnings, no need to rush.

Better to start ASAP, yeah?

-- 
Kees Cook
