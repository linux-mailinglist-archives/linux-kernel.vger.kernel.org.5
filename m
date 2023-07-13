Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD1752AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjGMT1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjGMT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:27:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42826B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:27:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53482b44007so735316a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689276438; x=1691868438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMBXi7c6FE7ClrpCTx65QR6NnLayYlC4d8VJ2B2i1Y4=;
        b=OR6scnI6d1gId2kANm6EChHSLrcJhjxR8gzThM3xvkGjmF8tMvgtMpdIIvRlMOh6lx
         oZbs7JoWRaiyy13+MgXxdQJH8M86jySGMJ+Bnpr6YC9RnFe97HKB47HswSjmdoOi7uiO
         GDsIP1C+QTAYn+COe3S8XM5/Y7GS9l0TbKPniKThBNa1heqUYAzjz0XQQqX/8PMdv0Ex
         pDUiyqjoaq3VfIMDnV1FYOB4FdihaPLsx6Ugh6RZfPKFFByCpUv0TWNaUkDSkcNGrTqn
         Yca9Qts7LcXdrmeb/hTfaF56PrsRotX5U6b67/rjQNaXDdueCBcVBK2JnaeLX90O8eoI
         cmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689276438; x=1691868438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMBXi7c6FE7ClrpCTx65QR6NnLayYlC4d8VJ2B2i1Y4=;
        b=fYH+glSLBAWPiunbLPdWL/7YigkylF1fltfHm0turRxvK6Fh3h3pEOrRGhoUNdeWu8
         pOrwcwQQpG3OrTvJxvIR3VVuie02SI7FQP6jpNc19F6wO/qzUv8usZnsmkxBZ2UImiTm
         lLmRV+OwqOi32Aasd0n1Yts4v0n7hMqxQCWDr9H0HE8ES1G0sF/ZPPTYtrEcRrbLnm32
         j5ojCglfJuvwhZhStsBlH0L1xzN+uLQmwSjgKkPF1JyaTy9LKaAUahE3WTYI7XXDoYSa
         rimtlcmISsNiDWqtG4X+NeyJsDxghiskjX6p2Ewo7IULUss+OS6wPsxaNbCvwqJSdd5Y
         yHmg==
X-Gm-Message-State: ABy/qLYCy4RoiLw0y8PJ8derVH2S5XVg49WZeAVnsrvUMDdyjZG7XmHb
        UMY0wVVfxzj0Edr6QmPtLdI=
X-Google-Smtp-Source: APBJJlGdjoTOFysniZVkEhzi/MdZNUz4HCYELkeAVVSlVvLoDjn1esz9d3WONIhaXdww0n96cuz82g==
X-Received: by 2002:a17:90a:5997:b0:263:f75b:c33f with SMTP id l23-20020a17090a599700b00263f75bc33fmr1659208pji.45.1689276437836;
        Thu, 13 Jul 2023 12:27:17 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b002639c4f81cesm13264023pji.3.2023.07.13.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:27:17 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:27:15 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLBQCFbBOaBUTQmB@yury-ThinkPad>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-4-glider@google.com>
 <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		bitmap_set_value_unaligned((unsigned long *)buf, largest_idx,
> > +					   bit_pos, 4);
> 
> > +		bitmap_set_value_unaligned((unsigned long *)buf, largest_idx,
> > +					   bit_pos, 6);
> 
> > +		bitmap_set_value_unaligned((unsigned long *)buf, tags[i],
> > +					   bit_pos, 4);
> 
> > +		bitmap_set_value_unaligned((unsigned long *)buf, 0, bit_pos, 4);
> 
> > +		bitmap_set_value_unaligned((unsigned long *)buf, sizes[i],
> > +					   bit_pos, 7);
> 
> > +	largest_idx = bitmap_get_value_unaligned((unsigned long *)buf, bit_pos,
> > +						 l_bits);
> 
> > +		r_tags[i] = bitmap_get_value_unaligned((unsigned long *)buf,
> > +						       bit_pos, 4);
> 
> > +		r_sizes[i] = bitmap_get_value_unaligned((unsigned long *)buf,
> > +							bit_pos, 7);
> 
> These castings is a red flag. bitmap API shouldn't be used like this. Something
> is not okay here.

Big-endian arches are not OK. Out-of-boundary access is not OK when
the buf is not exactly a multiple of words.

> > +void ea0_release_handle(u64 handle)
> > +{
> > +	void *storage = ea0_storage(handle);
> > +	int size = ea0_storage_size(handle);
> > +	struct kmem_cache *c;
> 
> > +	if (!handle || !storage)
> > +		return;
> 
> You use handle before this check. Haven't you run static analysers?

This approach is called 'defensive programming' as I learned from
previous iteration. Another interesting thing is that the only caller
of the function in patch #5 explicitly checks the handle for NULL, so
we're surely double-defensed here.

        +void _mte_free_saved_tags(void *storage)
        +{
        +       unsigned long handle = xa_to_value(storage);
        +       int size;
        +
        +       if (!handle)
        +               return;
        +       size = ea0_storage_size(handle);
        +       ea0_release_handle(handle);
        +}

_mte_free_saved_tags() calculates size, but doesn't use it in any form,
just to calculate it again in callee...

Thanks,
Yury
