Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA047634FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjGZLb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjGZLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:31:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F8BF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:31:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so25853335ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690371113; x=1690975913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pv4E2/kDpVfa/Dtz4RIrx4SYaXDBMv1Xx1z917P6AGI=;
        b=l0T/8cA7WKqxO3XFgE9ZfKHIIgxeet6bqJaEbDCqCpPOhySJ+dWssA6/afqm4C3FaR
         BR/Swp7B2kTCsvcYs2Oap1e+4HLd1dRmTS77blnj+HrL9avMOXUxz4gPSKuPLn5X/bfV
         sQWxK2YW/GaopekmCSB+3S7uSk4HI1OVOvaWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690371113; x=1690975913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv4E2/kDpVfa/Dtz4RIrx4SYaXDBMv1Xx1z917P6AGI=;
        b=h1g5YLR4glZNNjJciaRU5q12eh6X6E4TzrebNWiSALQ1KjqffPy+xlJSCUb3lHGdVe
         5u87aYu0NJvwW0Du6XYQu8kEv4waKGQ7e0Ootr40BdQ+eYemWE0G73aEAFsmCus+f9Zh
         sO+1V8y63ZuCFAbywiIp9mfFSzLsrW4Ju4MseSS+5FHWFvwr2Eb+CVsmyI8uEbu+NNV3
         SxJtJOr8YoKYIyS7E+PTykQh20OzZNLaj9H8G0JS5nXPXantUqKf1mbci28s44Rb3v5b
         mvYmQ76ccoazM/ut0o89f5rwGIZ+dkNW6KfxpITqHm0oZ3AhAht4tPszOh7UV6egdAEK
         T3UA==
X-Gm-Message-State: ABy/qLZhBx6hLH5AM1mfTAMfSjIYH/w6y/SgthnhqRM/eGOP8xzgbGPv
        LTsi2+0L1j/ehpkxX6n4QjTwLA==
X-Google-Smtp-Source: APBJJlFCJJMP3H6D5za0xJAObSY0B6q4CxM92CBcDxsHlqd8NDdz090Z75NONySCDQqIjyGz7wBlWg==
X-Received: by 2002:a17:902:8f8d:b0:1b8:8af0:416f with SMTP id z13-20020a1709028f8d00b001b88af0416fmr1630769plo.1.1690371112691;
        Wed, 26 Jul 2023 04:31:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a2a4:d590:6375:66ba])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709029b8300b001b895336435sm12863278plp.21.2023.07.26.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 04:31:52 -0700 (PDT)
Date:   Wed, 26 Jul 2023 20:31:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>
Cc:     "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] zsmalloc: Fix races between modifications of fullness
 and isolated
Message-ID: <20230726113147.GK955071@google.com>
References: <20230721063705.11455-1-andrew.yang@mediatek.com>
 <20230726031846.GJ955071@google.com>
 <42f1209a686404ffd0f9dff05ed10a8d23383a11.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42f1209a686404ffd0f9dff05ed10a8d23383a11.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/26 06:59), Andrew Yang (楊智強) wrote:
> On Wed, 2023-07-26 at 12:18 +0900, Sergey Senozhatsky wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On (23/07/21 14:37), Andrew Yang wrote:
> > >
> > > Since fullness and isolated share the same unsigned int,
> > > modifications of them should be protected by the same lock.
> > >
> > > Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
> > > Fixes: c4549b871102 ("zsmalloc: remove zspage isolation for
> > migration")
> >
> > Have you observed issues in real life? That commit is more than a
> > year
> > and a half old, so I wonder.
> >
> Yes, we encountered many kernel exceptions of
> VM_BUG_ON(zspage->isolated == 0) in dec_zspage_isolation() and
> BUG_ON(!pages[1]) in zs_unmap_object() lately.

Got it.

> This issue only occurs when migration and reclamation occur at the
> same time. With our memory stress test, we can reproduce this issue
> several times a day. We have no idea why no one else encountered
> this issue. BTW, we switched to the new kernel version with this
> defect a few months ago.

Yeah, pretty curious myself.

> > > @@ -1858,8 +1860,8 @@ static int zs_page_migrate(struct page
> > *newpage, struct page *page,
> > >   * Since we complete the data copy and set up new zspage
> > structure,
> > >   * it's okay to release the pool's lock.
> > >   */
> >
> > This comment should be moved too, because this is not where we unlock
> > the
> > pool anymore.
> >
> Okay, I will submit a new patch later.

Thank you!
