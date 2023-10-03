Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817417B69EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjJCNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjJCNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:13:14 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F5A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:13:10 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57b5f0d658dso518485eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696338790; x=1696943590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qngHVrILvNeCSm/s79v1hXPA4srlr06zsPatTFbmIhg=;
        b=BxDM8DJ+YlixlnNbAVGaX48ZuXVRnGCDQBips3Aebj7xyS6oEbiU5pp/TMFWRbypEd
         lzCulFlFll6x1lJsOPCSd7ySOd1SRyH77uydfP+Z/fUpR84te7AjeLkRi7BnbWpmZPTR
         ZlInmS9gAgZ6uOLKh1lMo96Ixjrd9rT1xNASyS1bphjPbdd6l+uq8oR8AzxMatajL0Ee
         eBXi4glsPIzWPJsHCe0L/DFo9BJAVYpxJV+rZBdUYX4dknaG/Jjylz0/os254EvUwPD8
         78etQr7gG1C4Tf0KQJahT+ZOREh2cBuM041TB8nFx1iTvFhYsXUSZS9CWnKhV+D/7Kdg
         ne1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338790; x=1696943590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qngHVrILvNeCSm/s79v1hXPA4srlr06zsPatTFbmIhg=;
        b=pu0tgU82MTZepNlzL+br7uipZhgX+WVfT/ezSE6ZX3UemWWFHEeAPikeLP7iw40Z3v
         AgnYP3tsHpu3pE5h5mhCh3qRzZmyVR3vhiC0j7qnRMUIgEbP13VoS1nBrKohlau4d5i4
         u4sGEn+pWP22HggK4Oy1UrWR15A52+QSyszBsnlGPi8bUM6OzaXaN6H6QM8kz60od+Dp
         42Pf0SxoIkNcyNzddz2fDAtHcwmxnnxEE/kmeQmHA6o8NHn+UmOGhPTHPwHoFU6KVQtA
         dQhwy2P9sdBfGZmYLOyTg/IY/kznVm3gyIUZaAo5Zlai7wh8z+pxry+MbLwwYjFDUkCv
         EbzA==
X-Gm-Message-State: AOJu0Yx1gAkyrgnLO3LsDqv2EWi3DGz+loSHXEyH0c5gN/KzXUa2RlGx
        fRXBG4ZaWQEA4xt//iPdvMdXEA==
X-Google-Smtp-Source: AGHT+IGZa47bNwbD2O9N2xm+OcLA8zN+h0X/kwuWCtsg+xTV228gW+PB93NcRH/Aro1283tpnCWNew==
X-Received: by 2002:a54:4899:0:b0:3a7:f650:af9b with SMTP id r25-20020a544899000000b003a7f650af9bmr15578226oic.55.1696338790195;
        Tue, 03 Oct 2023 06:13:10 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id v4-20020a0c8e04000000b0065afd35c762sm469236qvb.91.2023.10.03.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:13:09 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:13:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: memcg: normalize the value passed into
 memcg_rstat_updated()
Message-ID: <20231003131309.GD17012@cmpxchg.org>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175741.635002-3-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 05:57:40PM +0000, Yosry Ahmed wrote:
> memcg_rstat_updated() uses the value of the state update to keep track
> of the magnitude of pending updates, so that we only do a stats flush
> when it's worth the work. Most values passed into memcg_rstat_updated()
> are in pages, however, a few of them are actually in bytes or KBs.
> 
> To put this into perspective, a 512 byte slab allocation today would
> look the same as allocating 512 pages. This may result in premature
> flushes, which means unnecessary work and latency.

Yikes.

I'm somewhat less concerned about the performance as I am about the
variance in flushing cost that could be quite difficult to pinpoint.
IMO this is a correctness fix and a code cleanup, not a performance
thing.

> Normalize all the state values passed into memcg_rstat_updated() to
> pages. Round up non-zero sub-page to 1 page, because
> memcg_rstat_updated() ignores 0 page updates.
> 
> Fixes: 5b3be698a872 ("memcg: better bounds on the memcg stats updates")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
