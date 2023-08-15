Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894F77D07B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbjHOQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbjHOQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:58:10 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6408B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:58:09 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58c4f6115bdso16043527b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692118689; x=1692723489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnCNsZzQKHd1BrFY1oWDGUc4TVT5uPvYLedMK4qcLgc=;
        b=XbjqjpsI71gp//EQ1eJbjr8avsu9PxVQ4cMJSdHMllwrU71bh1AwI+lfPTewdd1hAh
         72IUrt12Hfo6zZtI2pH8ojFuNpnKfm6MJuGlf33I/wny5u4jdsp50jRL9ATse8fnSq0W
         fjQdK1ZWago54M6vo7o6IQ4xl2fSKlGU3Swka2jM1GuHQuuAosZYki/kJEEPU/IeZ4Yt
         qRQoBQqObZq6B00/rpwRuHT2zzuoSWQZTqKNGNmyR9j8xsdPFHLX8sh9SFaThgxauhe9
         cIDCONLFtGTipSeCnK8eRJdXZqWODoFwzhdFZ1UwEBwJ/84YyXkFNrxhJO8JUUtaZHpN
         WDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118689; x=1692723489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnCNsZzQKHd1BrFY1oWDGUc4TVT5uPvYLedMK4qcLgc=;
        b=KZ8ETZFOSoJYAQGBGmK2sZMcANPFc5l1qZjYhaTuIMwI7t2NawZoaLk6rbBomQnq9G
         uFkjLd0Mli1pX4H9N7mu2EZuvImtMOOe+mRGN6K3vGT2VKcUBk3d4OjnTwp2DWcg6Yza
         kboc17q+L83LQVpv9Bzv5pemb1qWHFFvwRUZcsKExOJhoV384MIflG44/YG3QB1Vpmzp
         IUsnvmuAd4yZPfwva4oqsXEJl3WRpsFBBhVsC6mp40D3JdlOqQAK3IxBtBMgy5nl6V67
         u0fWrKLYmlsTeU/ebOHZIdJeJw0YuSqb7U7ggRZjVkDyH8hFb99YtFyF4TZZ70V6sWoL
         +Gtg==
X-Gm-Message-State: AOJu0YyzbbwaFfk7trlSPkyA2I+MIuJOp86ptDzTMar5Ud/DiCu9UIHn
        NMK5VKh4UWj6U2+i8ARTTuBjrA==
X-Google-Smtp-Source: AGHT+IFJGFiIgKDeEIyyMWYkgpMldRTYMlRr9sSPTqQnRu7geuQrgMlURQTpIAgEUTGzf+/pSwZJSg==
X-Received: by 2002:a0d:cb4d:0:b0:56d:1528:c56f with SMTP id n74-20020a0dcb4d000000b0056d1528c56fmr14474200ywd.16.1692118688806;
        Tue, 15 Aug 2023 09:58:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n129-20020a0dcb87000000b005842447e843sm3515328ywd.10.2023.08.15.09.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:58:08 -0700 (PDT)
Date:   Tue, 15 Aug 2023 09:57:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alexey Dobriyan <adobriyan@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm,thp: fix smaps THPeligible output alignment
In-Reply-To: <9cc6f150-6673-4fe1-a406-e04bc33a49e8@p183>
Message-ID: <4eb1e67d-5fd4-af7d-c1b8-87ac0751fcd@google.com>
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com> <cfb81f7a-f448-5bc2-b0e1-8136fcd1dd8c@google.com> <9cc6f150-6673-4fe1-a406-e04bc33a49e8@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023, Alexey Dobriyan wrote:
> On Mon, Aug 14, 2023 at 01:02:08PM -0700, Hugh Dickins wrote:
> > Swap:                  0 kB
> > SwapPss:               0 kB
> > Locked:                0 kB
> > THPeligible:    0
> > ProtectionKey:         0
> 
> > -	seq_printf(m, "THPeligible:    %d\n",
> > +	seq_printf(m, "THPeligible:    %8u\n",
> >  		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
> 
> Why format string change? It would only slow down printing.

To document the alignment, and to look like the ProtectionKey line below.

> 
> I'd print with
> 
> 	"%u", +hugepage_vma_check()

Sorry, I don't understand.

> 
> or just add whitespace.

My original patch did that, then I thought it better to document the
alignment and save those bytes of kernel.

Hugh
