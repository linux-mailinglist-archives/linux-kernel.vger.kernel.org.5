Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F17D1DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJUPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjJUPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:02:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF2DA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:02:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so2773118a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697900538; x=1698505338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCJvi57jtZdtcZj+EIuPUrFmFUxCTQA0afp++0JCcCE=;
        b=ALb9b92aGj77JAoFotPcTxcohOk9PS3klCKsG/0bAGEWaB7SGf6drmFxvCB74X0d68
         OjsEns/GWSu2WeyM2556yctfNNF3fKnWSv9V8MjsAIkNcELqJHhk2b54mH9+Gju6oIeM
         gCSSRDqcJjKJTGIvCPsgZ+c7wNJjwCaVO+UOFcxAFokcWIZ9drB3rrPwKn4xR5/Rd42N
         UWT7pkPnJKj5FaeNVVmcoqoIqGpIc/HYpCycRD1f3mmnLtZFPgo6lxhsHb0xtF437I83
         StJacy5gam4g50LgPJyZ2TskIE7mUUH4uhNi2JayHGV8Uw4xuZUkQwsFHvZzPDeN+bhv
         f9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900538; x=1698505338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCJvi57jtZdtcZj+EIuPUrFmFUxCTQA0afp++0JCcCE=;
        b=X82TIK2XzxsAlYvlrBWWS3l1RrcOosrSrzsOa3DCOcxshTMedLgQZJOueqpUKVuAlQ
         qPSx6vdr/bTatE/gvQt5XH83at9veuocPtEHFQXyJHMBOrJG27DQW3fXEA/XmlisJVut
         TX6MYEsmjMVIM2LrBTCZnqRFb2ORZ3MIN8nQ7K84vw897ttnCgXODflzuQ/TG5iU4Xrb
         FWQrOcKZrbG3AyFndPsC4AknXw/NoCxR5bj6N3qG2usZcwjr3pToAF0XiSR/iw6iB1jd
         bHIDO+VLGJ1KMe+LZhoC2LpRcMCHp2mnNofV9nr7f5P7cPtVyFmOmFs5a5qleepE8arG
         83ZA==
X-Gm-Message-State: AOJu0YwQK0zSgKYoOp/OGd/Z6m3jLL5uQZ7CqJBMy92aXqzyOOKQaTvB
        8hTPmVxFk/EoMB7mcSeXuOfHIbH0fGM=
X-Google-Smtp-Source: AGHT+IGAfiPwgV3TmZYEuLImV5VQMc8Vxx5GhiwP2VvFBdgLMYPYkZDwGDF3k622TPtGZaZQviPVBw==
X-Received: by 2002:a50:a45e:0:b0:53e:332e:3e04 with SMTP id v30-20020a50a45e000000b0053e332e3e04mr3116712edb.37.1697900537644;
        Sat, 21 Oct 2023 08:02:17 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id a62-20020a509ec4000000b0053e5f67d637sm3625588edf.9.2023.10.21.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 08:02:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 21 Oct 2023 17:02:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: BUG: KASAN: slab-use-after-free in reweight_entity+0x8d4
Message-ID: <ZTPn9VztOvvux3oD@gmail.com>
References: <CABXGCsNMFZHXvtN7uAmjUPewfAcgD038rMhkruQCD8kqS3cXaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNMFZHXvtN7uAmjUPewfAcgD038rMhkruQCD8kqS3cXaA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:

> Hi,
> I caught one slab-use-after-free durung release cycle 6.6 rc6 and it
> looks like it will not easily reproduce again.
> I tried rebooting and repeating all my actions but slab-use-after-free
> did not happen again.
> 
> What we know:
> 
> 1) backtrace:
> 
> [  336.215839] BUG: KASAN: slab-use-after-free in reweight_entity+0x8d4/0xa50
> [  336.215846] Read of size 8 at addr ffff88812d1a80b0 by task
> fossilize_repla/10552

I think it might be the bug fixed via:

  d2929762cc3f ("sched/eevdf: Fix heap corruption more")

Thanks,

	Ingo
