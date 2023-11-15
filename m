Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24E7EC78C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjKOPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:41:19 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDB12C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:41:15 -0800 (PST)
Date:   Wed, 15 Nov 2023 15:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700062872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ez3o0C9ttk5i0lUy5nBMjLkOP010UEr3wabYUS8B7kA=;
        b=ugF3OweWxcO6VMW+nS9tfqdkxzf8F+7W5It4nkO46fj7K6Y11x6rEJzhXn01dWSAFpjrdM
        TPulrHmSGX1JZHwYHUu+Vw+ELnEy8j4dmqmp7tctL793ssOhTrTQI9oWviC9qh5J+cI7H5
        HwHVT2XFdj0Dafjwwp3v/PRjY/On47w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Shaoqin Huang <shahuang@redhat.com>
Cc:     kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Message-ID: <ZVTmk-u-zUKC4Nrw@linux.dev>
References: <20231115153449.17815-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115153449.17815-1-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:34:48AM -0500, Shaoqin Huang wrote:
> The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
> value, define it in one place to make the code clean.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

Colton already posted a fix for this as part of his selftests series

https://lore.kernel.org/kvmarm/20231103192915.2209393-2-coltonlewis@google.com/

-- 
Thanks,
Oliver
