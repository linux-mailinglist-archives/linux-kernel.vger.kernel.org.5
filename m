Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6E7DCF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjJaObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344455AbjJaObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:31:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2AFC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:30:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da31ef34adaso2340076276.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698762657; x=1699367457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5mFSmwzy02eXplSCzUEvQ6qF9l0j94is7Nf9C9jYY=;
        b=AEHgBXcK60CLou9N22CWwHcBvAaaRBMjJFOosK/TBu+g/89Ojh0+58uOE2dEQqMSuN
         CsOocHoyo82FoCCM+7XTX7fZODOUu1vEVFggc4vyRNd2cSCnF5jtNOoO+5ODkzCOb7/N
         SEfm6WHV7OncdyYqEPfGg4mkiQDZUHZ+Jz/A+K5AS20lJFw5MLylLyS1FlBLzLZXqGKE
         Fn31vhuDMO5hFBeGCz1cYL7MOH89ov3gc6AZjfGUAtZVxaRxkS7WMYm4sifoNd1ykND4
         +kUCH91uwUerzdI4teq59LuSAKcdS6HMlijX0hZydze9OazSzLU326niQYpFtHx+Axsc
         tjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762657; x=1699367457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5mFSmwzy02eXplSCzUEvQ6qF9l0j94is7Nf9C9jYY=;
        b=w+OFgyNVhXp0WQuNAPLGOuwB4ZDVJOSN4FTT9rbOgySddRWtu9P5molTpcpmW9dH/J
         9dWR981wklGE4l4ei+MFjA8J5usDV3TRc30Ux6Zmq8uQNrURTAMEMzY7NuIH/UqHcYiW
         HjxwxN98t782TFiw7i4AK4+aaZGX9AdS0/rzbPFSe4inaEt5fWicrJeqGHs7dQYiFTqt
         +gFreEr1SHYNFXRROHh727Vts66uTOkvqC6sTNSh/StnFnffRQJ1KaDd2zVszp7OIYYY
         MF+ErCW1QhgPymx9AqnjjkPyfEarMv0vLXmXeVXW0CWpRDjTa1/XZKRHsQ7sZSXt4ZKQ
         ocuw==
X-Gm-Message-State: AOJu0Yz9a+SOGc3/kl6NKgoVCS1k4X0tpvAC9FLAs20evo6kXwbqAwCB
        Cp0hdMJCVsej58+tYqVTsG2K8TngjbQ=
X-Google-Smtp-Source: AGHT+IEZqhN+IYUKaMtos7FbgKMZPVomc9IftVr5HCPDZa4DCVZQBFFRA7mieVnbr/UJ/ajvGhyuR5QPPKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1788:b0:da0:c9a5:b529 with SMTP id
 ca8-20020a056902178800b00da0c9a5b529mr222465ybb.12.1698762656758; Tue, 31 Oct
 2023 07:30:56 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:30:55 -0700
In-Reply-To: <CAD=HUj5733eL9momi=V53njm85BQv_QkVrX92xReiq0_9JhqxQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <CAD=HUj5733eL9momi=V53njm85BQv_QkVrX92xReiq0_9JhqxQ@mail.gmail.com>
Message-ID: <ZUEPn_nIoE-gLspp@google.com>
Subject: Re: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, David Stevens wrote:
> Sean, have you been waiting for a new patch series with responses to
> Maxim's comments? I'm not really familiar with kernel contribution
> etiquette, but I was hoping to get your feedback before spending the
> time to put together another patch series.

No, I'm working my way back toward it.  The guest_memfd series took precedence
over everything that I wasn't confident would land in 6.7, i.e. larger series
effectively got put on the back burner.  Sorry :-(
