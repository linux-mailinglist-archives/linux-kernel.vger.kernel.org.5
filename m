Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23F6803661
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345357AbjLDOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbjLDOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:35 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE81984
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:23 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1994979276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701699742; x=1702304542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bqFs8Nn5l4x89tBJBGRIiKA24/GR8vDeoJPMLAjDB70=;
        b=QEsSeE6+26UQsZ39lPeE8gKMT5r1+hc+VSHH44QerPceiHU7eIw3gVn5ot9tUnKfNs
         AGF381cCAXkGWzLnxzWVnppHipFAm9bClPGUV+zbE14lIR/2XhBejgAfhHXT3iafckQx
         Nn3jQe1HqBZav8XjvhzhXVdklDflbtuygX+CZNWkCQ2W7knUh1SuoO4IdXn4nKkOalaX
         HMj1sruthYsXIiOxUIglxZd1o0wjt1Sano06oNEWDzKJoxep+c0uRqqQfKIp7Zl9qtjd
         M2Wl25S/C24aPSp+qLeMsKxpg1buIwy1KUwKnHGGit+vpXq5J9MV16BCNCjshFpPepSr
         AGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699742; x=1702304542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqFs8Nn5l4x89tBJBGRIiKA24/GR8vDeoJPMLAjDB70=;
        b=wiNkzPcTC9CKYMA1pbpDjcHJUpE08o4rnOVsVErd/vaHd2/G86KYQ0ph9don+BCMGl
         LLfjsT1rTCrwnD8n9PDyiXxLbWpfPuEHi/3bic4VHHs5EiLbMlDDH5ooGhoSCcmOex4W
         BuxJDzB/U+ZtnSEUmxj7391jYI4N6vfXLfmjJTbRupYamoQiLd4YdDTJ391Y1WM6LJNG
         KVjRa7XrGchMgOvOy4svhViBTVyX//RGUPu4rsnPDFjd2inpA9CFnRD4Okif/FBr0v7/
         2folxSelJYF7xMoGgARj0qKFg/Gh7oK/xBYltidzENJ1zQPAgp40mDKhPe8heN8gMbMz
         hYCw==
X-Gm-Message-State: AOJu0Yz0D1xPpSgzGul5Ejm/a65zqm2+1Ya01LHUWOPzY5VjX0xRir4f
        dCBplZRmz3Dhlv+udhFEj9s=
X-Google-Smtp-Source: AGHT+IF9jVjz0psZFUrBtIl1+4SXEox3V+eE8Q9xhtvcLiaBOO3nY8WUz3eXy1x+N2TROUU7kM9bXg==
X-Received: by 2002:a25:d84:0:b0:db5:37c4:0 with SMTP id 126-20020a250d84000000b00db537c40000mr1214114ybn.42.1701699742125;
        Mon, 04 Dec 2023 06:22:22 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:3c76:612b:b76f:61a6])
        by smtp.gmail.com with ESMTPSA id w67-20020a253046000000b00db3fca90d6esm2333786ybw.2.2023.12.04.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:22:21 -0800 (PST)
Date:   Mon, 4 Dec 2023 06:22:20 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 1/3] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZW3gnNbnzpZwtrMa@yury-ThinkPad>
References: <20231109151106.2385155-1-glider@google.com>
 <CAG_fn=U7EV0ohaNFRwQ83cvwVn-Fer1pHXOjPevbP_XpYGDCYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=U7EV0ohaNFRwQ83cvwVn-Fer1pHXOjPevbP_XpYGDCYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 02:28:09PM +0100, Alexander Potapenko wrote:
> On Thu, Nov 9, 2023 at 4:11 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > From: Syed Nayyar Waris <syednwaris@gmail.com>
> >
> > The two new functions allow reading/writing values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > The code was taken from "bitops: Introduce the for_each_set_clump macro"
> > by Syed Nayyar Waris with a number of changes and simplifications:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value());
> >  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
> >    and bitmap_write();
> >  - some redundant computations are omitted.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> > Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Co-developed-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Yury, Andy, do you think anything else is needed for this series?
> If not, whom should we ask to take it?

I probably need to revisit it, but generally it looks OK.

But I can't take new API without having real users. Now that your MTE
series is delayed, and Alexander's 'ip_tunnel flags' is not moving as
well, there's non-zero chance to merge dead code.

If you want it to be merged, I'd advise you to walk through the kernel
sources and find good cases where bitmap_read() and bitmap_write() can
be used. Then append this series with such conversions, and I'll be
able to move it.

Thanks,
Yury
