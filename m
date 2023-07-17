Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79E755FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGQJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGQJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:48:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D5A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:48:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12249a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689587303; x=1692179303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcfAMuwOY+oPetXy5qABvv5WWymZbV8JjdfSgt/USaw=;
        b=P84DhTSzyZDW2DrvdeoORjpxBqoxHEIEega8g9wKlZ9UXX5Rd5HZwc48jZnp3QPFBD
         yMZ6Atn9BHZiRyvS425DKqZp9zKGPq4dlGK/eGNfEJiv90y7kxnRL5FJtgtkO7FSNRN1
         BQ32Y+V0stntMjhKObS3+Xhfis2KnVUC7EZDWDG2mFfvljm3l7D54xbNPHWFrd+UmACj
         eWJw/0Y1bybARKARRhGifrAZgP39Wqm+kCrcVDOclfYdGkD7IHhU9CC0lTat6uhn+XRL
         dSYu9KPvCBWPFnzP1gNnXYS3N/BNg4BeFLLhmayWbC8D50puIZ98DJ2ENGize8qawdzs
         ZXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587303; x=1692179303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcfAMuwOY+oPetXy5qABvv5WWymZbV8JjdfSgt/USaw=;
        b=IdSEEC9QbfEvgrczuLtgHgMS2WyKqfZdX+T3y///BXM6kmua+umQGKLtjB7OPyuUBG
         txuVOBWIZwesukaLiRYYNKWu07tspiPBI3X+YvWUo4qatNGjOqc++f5WUJcmVnhOjv04
         qMrgohjAKbk6c4Yhlp/kRfq2KETbeUx+Fzun93TbwXigxbWh/ZC28zC94cnfYqHcOe+D
         zjTgSz/SapepSJPV4G2DA0tjrEDwULw2ftN13VSY5g6A+sHust1ddEiOZTPOQxW/fq9a
         JSpys18Lvs447EapPfAVG5LknVBX5OFl0Vd/9TdPVfnktZa8PBCUGMTAdpkdOSprwbiB
         oDxw==
X-Gm-Message-State: ABy/qLatBuO7I28iJVQN1MZk3sVfkdiPuhbmHHLCyyWYG1bLrNBu21tS
        +TipUTg10BZSk1dWpR+Y33sYoQ==
X-Google-Smtp-Source: APBJJlG+5dDrquqW2BDi3ZctcLI40czlf8hUMmKlaKfWXwDnH9h988NKHFNTR5bg9i3L2y3YgKm3CQ==
X-Received: by 2002:a50:c346:0:b0:51e:5773:891d with SMTP id q6-20020a50c346000000b0051e5773891dmr611167edb.4.1689587303303;
        Mon, 17 Jul 2023 02:48:23 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id y17-20020adfee11000000b0031274a184d5sm18752365wrn.109.2023.07.17.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:48:22 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:48:18 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, maz@kernel.org, suzuki.poulose@arm.com,
        tabba@google.com, james.morse@arm.com, qperret@google.com,
        bgardon@google.com, sudeep.holla@arm.com, gshan@redhat.com,
        yuzenghui@huawei.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v2] KVM: arm64: Add missing BTI instructions
Message-ID: <ZLUOYn8bujcIrgaG@google.com>
References: <20230706152240.685684-1-smostafa@google.com>
 <168920214959.3096128.780259299986215400.b4-ty@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168920214959.3096128.780259299986215400.b4-ty@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:50:34PM +0000, Oliver Upton wrote:
> On Thu, 6 Jul 2023 15:22:40 +0000, Mostafa Saleh wrote:
> > Some bti instructions were missing from
> > commit b53d4a272349 ("KVM: arm64: Use BTI for nvhe")
> > 
> > 1) kvm_host_psci_cpu_entry
> > kvm_host_psci_cpu_entry is called from __kvm_hyp_init_cpu through "br"
> > instruction as __kvm_hyp_init_cpu resides in idmap section while
> > kvm_host_psci_cpu_entry is in hyp .text so the offset is larger than
> > 128MB range covered by "b".
> > Which means that this function should start with "bti j" instruction.
> > 
> > [...]
> 
> Applied to kvmarm/fixes. Sorry this took longer than expected, Mostafa. I
> was hitting an unrelated issue with pKVM initialization on the only system
> I have that supports BTI.
> 
> [1/1] KVM: arm64: Add missing BTI instructions
>       https://git.kernel.org/kvmarm/kvmarm/c/dcf89d111199
> 

Thanks Oliver, hopefully everything is sorted out now.
