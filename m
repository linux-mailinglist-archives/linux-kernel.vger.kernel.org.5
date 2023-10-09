Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940617BDCBA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbjJIMsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbjJIMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:48:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A76B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:48:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3248e90f032so4439875f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696855712; x=1697460512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy34EsmsQ4zlGQIs0EyL60N40tSqUoCRP6CMCeIqR90=;
        b=CM+lnB7TYV1/YX2c78qoI19iz6/OTKWazQeNXNyg2UhCpvQOAqdJh0VdWMYP8wRVYw
         tHIJvG5zHiIGXzZnKrQK6v5OC2hoiLjJ0FOFTxb9Eo+DyHAX5/sbn5EDIDB4CB+BXhdX
         S8JCXPAEaHfmvcsdIvxv7H5Cj9Vpd7CVIZlEhplZMW9PxapgW8z4cQWzXWE363lphJcn
         MryO4ea8Np0RQsaymL2WOWWk7rC34fHGRILB0bxdjXwcUsbZViefbrq5z/PiQrDU14b2
         R5q+DuyPVHGXx9SMNXuCiQIdP35ejRKb4vsJq9wb6TH5tqpSD07BgrSynGlCm2nj28in
         ZpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855712; x=1697460512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jy34EsmsQ4zlGQIs0EyL60N40tSqUoCRP6CMCeIqR90=;
        b=oW5MtyqlFI9CAeHJegs5YMjsVyST1qyMEaT8Z0Ni6W7K/ZcN+i/HcZU13XcpMGJxBi
         pLQH5dDLawhivkMtUcredxjMyV27zbsp2o4MH1AFaByHv6F0Gm2JJ7dV3ACrhqu021ag
         2dzSRKTG33Zo0UX3s+S829F630YwvCT/7mIusmz8rxF7mknXaJGJz5uXq1G8Um68xGMz
         EmXPw4b5I8dcrg8XPReyxtHc+EhBrD2JWX8+GFZ0+Rcagv4HLsu+3DazjOzPOmd5mxsR
         3fYWi0oPUJiZIerLVnTKt9x5vAAlufjfSY/SotfnuwUnWRE89AGowYnw7xrmoUaESdWn
         xFdg==
X-Gm-Message-State: AOJu0YzzNfAY+ghYsBLCvHo2RnmwjjYnglbqzp9FPEx88rKqyAcdmG5q
        OpGrBAkDfSODpzjFbIWKipAp0Lcwhbk=
X-Google-Smtp-Source: AGHT+IG4CWWuTIoY+vT+JRaSeC0ry4pHXTLbfBfbtmWls0mWLPmyrSPyI8kMWIq39AhmrXCTZPqrhA==
X-Received: by 2002:a5d:62c6:0:b0:31f:d52a:82b3 with SMTP id o6-20020a5d62c6000000b0031fd52a82b3mr12894251wrv.46.1696855711563;
        Mon, 09 Oct 2023 05:48:31 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id b6-20020adfee86000000b0031f300a4c26sm9523141wro.93.2023.10.09.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 05:48:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 14:48:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     surenb@google.com, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: [PATCH linux-next 1/3] sched/psi: Change update_triggers() to a
 void function
Message-ID: <ZSP2nMGZhtA8hr23@gmail.com>
References: <ZSPayGSz6HQBp+3W@gmail.com>
 <202310092024289721617@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310092024289721617@zte.com.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* yang.yang29@zte.com.cn <yang.yang29@zte.com.cn> wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Update_triggers() always return now + group->rtpoll_min_period, and the
> return value is only used by psi_rtpoll_work(), so change update_triggers()
> to a void function, let group->rtpoll_next_update = now +
> group->rtpoll_min_period directly.
> This will avoid unnecessary function return value passing.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Ingo Molnar <mingo@kernel.org>

Thanks for the split-up!

I'll remove the Suggested-by tags you added for me: I didn't suggest the
changes themselves, only the split-up, which isn't credit-worthy :-)

Thanks,

	Ingo
