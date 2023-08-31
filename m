Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2637B78F28E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbjHaS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHaS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:27:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09344E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:27:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c08a15fcf4so12943525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693506423; x=1694111223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BL29J1RzTtLIRB8EYDyGe+vo37rP6HDohP3M6dAx+U=;
        b=B/yNBGZdEvJwbmlj8/1+4UyO5O/ON0FW5I2gLe3wDh4122D7oTI9DEvcv4xd+8usvw
         dDu4J7kD/lBmKCcK5DtPJ68276AknazyaquPGN7ZAP8YRL+fSyVocQArGv8/HSA4daKo
         e5T+MxHnWPDkjtaq0KtHSDLzWzYowUKGEUX2WbS60LAuyzzKgF8n5MaaOIHvIXHGvwh0
         B9JkliSm8LCroeYduq+LWqQugsKV75TLsLENFIt7pXEyS4Ms+vwxNkpXWruxghcFLbQx
         k0UqNYmFCbW1sl9YSUIVdebkV0YIqMk9Ir0WJqiYBweOfRjk1cdMUMKbdgx9NkC0bUkU
         w4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693506423; x=1694111223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BL29J1RzTtLIRB8EYDyGe+vo37rP6HDohP3M6dAx+U=;
        b=UlRvvrFEoSKea6+dOKltYLHBuRLbZF98bHRwsng5UfzBLOGp18AaNbrwdsKjjhJDxe
         Qowrb/uYn8m8JIroRFRluIbA1xxE6G1m2T9OnFh9fosoZH3HxbUtEhhMAPkZqcQx8sLd
         ZBClssOKmeR5xAyr1n2eifGus3sUD1wWYlX+q5GNZx9KSvq8jL+RGQBLOXAkZqzu7fRp
         Fs/7hjPsy7Z8dGI3Djd2w0VDxT3GFDibT8YaAzobAu+cuHeNo43PXL2eF/YWMMF+zJKf
         m68zdCPJ4T81yKPlm7YFQbPkXTRz+bVetjQcVqy4+J3KEO7/MQGGF6YYpwMBc6nHtpQN
         6A8g==
X-Gm-Message-State: AOJu0Yw1fxlMQIJRPlXRHGacXf54rFUSua+nWK2K9gKjeUkelKar0Y54
        Mx1PHItuuDQp6UXTtwVPlLXwEzEUPaE=
X-Google-Smtp-Source: AGHT+IGy8aNlBIT34IBTO5UeG7P11LE8KsEbP0ykxoFscuLHnZ697p9o+nlvmi+P3IJduZDTQXpkgbeEDsg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2309:b0:1c0:ac09:4032 with SMTP id
 d9-20020a170903230900b001c0ac094032mr122962plh.9.1693506423541; Thu, 31 Aug
 2023 11:27:03 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:27:01 -0700
In-Reply-To: <CABgObfay4FKV=foWLZzAWaC2kVHRnF1ib+6NC058QVZVFhGeyA@mail.gmail.com>
Mime-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com> <20230830000633.3158416-3-seanjc@google.com>
 <CABgObfay4FKV=foWLZzAWaC2kVHRnF1ib+6NC058QVZVFhGeyA@mail.gmail.com>
Message-ID: <ZPDbdTIUXAnvL7SM@google.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 6.6
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023, Paolo Bonzini wrote:
> This is definitely stuff that I wish I took a look for earlier (and
> this is also why I prefer small bits over the development period, as
> it keeps me honest),

I'll work on making this happen.  I think the biggest thing on my end is to make
it easier to track/merge arbitrary topic branches, e.g. so that I can put big
series into their own branches with minimal risk of forgetting to merge them into
kvm-x86/next.

> I'll take a look but I've pulled it anyway.

FWIW, I despise the "goverened features" name, though I like the guest_can_use()
name.

> BTW, not using filemap turned out to be much bigger, and to some
> extent uglier, than I expected. I'll send a message to the private mem
> thread, but I think we should not pursue that for now and do it in a
> separate patch series (if at all) so that it's clearer what filemap_*
> code is being replaced by custom code.

Bummer, I was hoping we could avoid having to touch mm/ code.
