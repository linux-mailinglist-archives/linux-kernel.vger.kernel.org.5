Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3B7C03AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJJSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjJJSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:47:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFA93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:47:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c60778a3bfso50088435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963627; x=1697568427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAmoOiweFBSvVR3HkBiuX5nCGSKxelsAguCpoV9UbNM=;
        b=MzGTtCH5fzs08ADhXwEc+g3wDlDi8pJlIjQE1Ot1AOQwdFjAa2SAW8zK5ZngLRONuT
         rAjUI1QMKI957iTPlFcS41d1j6AkkK8aJIG5VmF0Sd7XF/mMg0ovyOkBG9q8Y5Dz9KKm
         9nVOhAzcLl4sI8yDGBUFAdzPN0me8Moqm4NDFliTSihPDwhysJbNZ6KoE6sbdUwvzP0U
         8AosGMsaedPqqQYiDSWZmCvpoK6ehRfcGKcJcS8sSiy5lDActFTbVXeb2egZtvn3mATo
         RCaJl7RONFqsmvpnrsv1HtcXqJrREI8cUGMXxH+vP5E+oMFITO1C9M3Vz42GIJkVHGBX
         /uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963627; x=1697568427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAmoOiweFBSvVR3HkBiuX5nCGSKxelsAguCpoV9UbNM=;
        b=pkyW7V9THDyOPrfQWTvVyBf1Z8BVX0TBz1EJ/S8O31nOeMmdtqid1j7bf/fUbC2HkN
         Htih0ZnOETeHsgU/GR2ahWrTv9zMEeU9BfBfzAB4JGY2KvR5JPRj6i+YlajDOCfE3wYc
         IwP3oJNKLuJaCLllbMYjjLlx2LsRYIDl4w6hdvwtpHiLML/oO2bZXO92TDFi+bFRW6GB
         OA4dUq5M5/zjp2OSpywOTIS85yvCd5iX75Ka7+BMqfTa2M0WGKHcd/cd3PuhSTopwsw2
         UzATN/yWFCaSVPs+n0rcCi1Eix3IXWUZiPfezGgJSiTZznVXb23myW8AaOsGp89IQJ3h
         IjIA==
X-Gm-Message-State: AOJu0Yw0lnnBkmXZikli7epuG5hh/Ssoogq4Bnf8f07biqDqmM8Mwkud
        lWK25eveK28Bos5p/vTcOSg=
X-Google-Smtp-Source: AGHT+IGicYlCofArrDHaaGD2YpINbO2E/1Hq+hkgVrcWc+Nd0Zcmpn9wkjHBOjCDQNM32GRNm7S2GQ==
X-Received: by 2002:a17:902:d481:b0:1c8:7d21:fc50 with SMTP id c1-20020a170902d48100b001c87d21fc50mr17855714plg.56.1696963627193;
        Tue, 10 Oct 2023 11:47:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709027c8200b001c736746d33sm12067706pll.217.2023.10.10.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:47:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Oct 2023 08:47:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Use the kmem_cache_free() instead of kfree()
 to release pwq
Message-ID: <ZSWcKUQG_e3sAsZu@slm.duckdns.org>
References: <20231007113541.8365-1-qiang.zhang1211@gmail.com>
 <ZSQuWl_B_7i0ZW7Z@slm.duckdns.org>
 <CALm+0cUU3nvzk-A6+4zF5fCrkQ_dDY6GE81L97qU-xyCHCsaww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUU3nvzk-A6+4zF5fCrkQ_dDY6GE81L97qU-xyCHCsaww@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:53:31AM +0800, Z qiang wrote:
> >
> > On Sat, Oct 07, 2023 at 07:35:41PM +0800, Zqiang wrote:
> > > The pwq objects is allocated by kmem_cache_alloc(), this commit therefore
> > > use kmem_cache_free() instead of kfree() to release pwq objects and also
> > > make use the correct tracepoint("trace_kmem_cache_free") to trace the
> > > release of pwq.
> >
> > This isn't wrong. kfree() can be used for memory allocated with
> > kmem_cache_alloc().
> >
> 
> Yes, that's not wrong.  but pwq is allocated by kmem_cache_alloc(),
> usually should use kmem_cache_free() to release, correspondingly, we can
> use 'trace_kmem_cache_alloc/trace_kmem_cache_free' to track, not using
> 'trace_kmem_cache_alloc/trace_kfree'.
> And in rcu_free_pwq(), we use kmem_cache_free() to free pwq.

Can you please update the patch description to clarify that the code is
currently not broken but it's trying to make it nicer by unifying how
they're freed?

Thanks.

-- 
tejun
