Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39476F673
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHDARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHDARM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:17:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873183AAF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:17:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bed101b70so205633166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691108225; x=1691713025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78WVpSFpmXIbenrd24m7JltYbyEgqWinokwRiqNn9QQ=;
        b=E/jDfIK2P7ezXzkHxMjGuX+UXJ25ZnGTJfHravOriqzEKVZuGwR5WHHZntMJ+3qi3X
         39pSODl09eX5RxwlK1rpY7wmFWVmZ/RKoC4E6ozOqYwFi+Kt4o3LThVRyNXSFC93SteX
         GR41mxvguKLqiMd4E4m/JR5oyQNEBFTDKYWldraPle/wraXYV0weMeJmybgmsTP3p59m
         j3/hQhbpSFsrg0prGYnmFfORmDCI9NNcs98ql5kQtklo5y5vFjLQAxOFlLydYm+0L6po
         /PO5fyg80tWctmW8TT6H+JgPFO3u7BAAgx/Bk/BCIUny71pNKVpuVHg9QPydoyFuLWsj
         u8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691108225; x=1691713025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78WVpSFpmXIbenrd24m7JltYbyEgqWinokwRiqNn9QQ=;
        b=NR9m+xp2HSdUvN33hZl//ToDehdXqFbmSWeaYYPEMsfanp4wFKrkUbZxqJvIvon917
         rf6HSejqBw91LP22ujELQe9xEnc56sTHTodrtN4YGYbetcRf/X1ItD4QhV3qxEZxmaKY
         3jT4mDRGweV52fQ6cgf9WsZlTJe5x3CgWvAPUD4n2y7goE277kecS9hiERKQLFFvRaSs
         ZqVvAiYKOpY35cy4r+D2QvQuIJh8jlDw6pa7j3kSuGi3NkYM7ErMsOynVIQ0n626VWWQ
         2ce3cj4U41swXiwkFJ+3X+ze+B2ZB13BL4zD9XZ2u6MJeR2fAJ0PR81vU9jxkDUbplGC
         BAMg==
X-Gm-Message-State: AOJu0Yx7V7DusxTQoFwDQkbNFAZQ9bZ09hdjBwvCny/Y4WWlYEHJoBeZ
        82rKDO6sVV20Pmx3Ec74zHQ=
X-Google-Smtp-Source: AGHT+IEVYwWjSGw0bWdHrfva2E1QUgg7WDVWqP78y5nlSx4Cenv4Ku+OxLKP+jOA7Ks4k0GA3uuw3w==
X-Received: by 2002:a17:906:8a5a:b0:969:93f2:259a with SMTP id gx26-20020a1709068a5a00b0096993f2259amr130217ejc.73.1691108224562;
        Thu, 03 Aug 2023 17:17:04 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id r23-20020a17090638d700b0099bc8db97bcsm477089ejd.131.2023.08.03.17.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:17:03 -0700 (PDT)
Date:   Fri, 4 Aug 2023 02:16:59 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZMxDe0gXKYbY5jgt@andrea>
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea>
 <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you double-check that riscv switch_mm() implies a fence.i or equivalent
> on the CPU doing the switch_mm ?

AFAICT, (riscv) switch_mm() does not guarantee that.


> AFAIR membarrier use of sync_core_before_usermode relies on switch_mm
> issuing a core serializing instruction.

I see.  Thanks for the clarification.

BTW, the comment in __schedule() suggests that membarrier also relies on
switch_mm() issuing a full memory barrier: I don't think this holds.

Removing the "deferred icache flush" logic in switch_mm() - in favour of
a "plain" MB; FENCE.I - would meet both of these requirements.

Other ideas?

  Andrea
