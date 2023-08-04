Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C57703BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjHDO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:59:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621E7AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:59:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bccc9ec02so316478766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691161171; x=1691765971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haxLgvz1q5Yk+iNcNNjz/9sW15Tc+C/ITeGdkf6c1Xw=;
        b=RJB6NZdNzd1Lh6Jqc36CBFKIVo8cAM5yWAWNitJuwtX2kayu+YJa0b9NxROOhM8QGX
         MknqGyaLe098qy454ihbfmo3j9gWn0mL+lx8faq4CnLIxhzXLK5NdeFSgCooWJEjqXRD
         5JDmWJgP/tHIGq4tmaXUiwuyv3/gPxduVPGbs0bXzjfjtyzoXzv86C2AXJJETh1UiQxx
         eoBI8irmtXaxOTj9njvL7v7TeDmAue1fUXBnIv4IM4nRXmMoOEORDBN2BQB34hyUTP8S
         WUKosBTUZezVw8tVUbRQs1aZpQ+yNQKCUVl76lthEr9a/7h1iwqcUmsY16kJlHS91zaI
         5PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161171; x=1691765971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haxLgvz1q5Yk+iNcNNjz/9sW15Tc+C/ITeGdkf6c1Xw=;
        b=W/5Y1BRWrEOuY6leh+Gw8LXS0jQS7YtXlEKOaJhEObJT6oEAvZYJeo7OqL6CPD7h0x
         lbiqYPhjEap/su3Jh8oxQGpGMYdyd9zRMd/D9/W0Kin5V0obOVbN7ttEm/w++PkBx3A1
         xyNdH2/bJdSoY4tRNxUGjrCFSQ8Yo0C8nP+HRSVjprEDG2z0SabNB9HE1ex7HW/3fe1K
         vzdd6w12rmDG9KzMicheAYYj6aG0QLy7LbocpmujA005BlSXWREpjGeH59TPw9/xUTgI
         HlwZlmLOoQN6+bHVStbO5A38c6KUGMkQWFHnAzCF6UTVoGypWykuu/0aKdHoINCc/QLy
         qLRA==
X-Gm-Message-State: AOJu0YyFK4iouSdiLJ6388hNQ6RNZYdwEGkPPm4RbTBNSafwr0Eqvs8r
        N6S6ReHIGhkNhhgY3T+wbMM=
X-Google-Smtp-Source: AGHT+IFVDjRaAumBCGtwmib5tiD99UgWEki4/WYWHl30CXnstywEC1ixz7bEyyhr8vcpQ3wmFJAp+w==
X-Received: by 2002:a17:906:100c:b0:991:c9da:70da with SMTP id 12-20020a170906100c00b00991c9da70damr2010322ejm.61.1691161170479;
        Fri, 04 Aug 2023 07:59:30 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id re8-20020a170906d8c800b00992076f4a01sm1413167ejb.190.2023.08.04.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:59:29 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:59:25 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZM0STfpkRSfNQBt8@andrea>
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea>
 <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
 <ZMxDe0gXKYbY5jgt@andrea>
 <65350c17-3fcf-a057-a280-f6a5d36dcb21@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65350c17-3fcf-a057-a280-f6a5d36dcb21@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the relationship between FENCE.I and instruction cache flush on
> RISC-V ?

The exact nature of this relationship is implementation-dependent.  From
commentary included in the ISA portion referred to in the changelog:

  A simple implementation can flush the local instruction cache and
  the instruction pipeline when the FENCE.I is executed.  A more
  complex implementation might snoop the instruction (data) cache on
  every data (instruction) cache miss, or use an inclusive unified
  private L2 cache to invalidate lines from the primary instruction
  cache when they are being written by a local store instruction.  If
  instruction and data caches are kept coherent in this way, or if
  the memory system consists of only uncached RAMs, then just the
  fetch pipeline needs to be flushed at a FENCE.I.  [..]

Mmh, does this help?

  Andrea
