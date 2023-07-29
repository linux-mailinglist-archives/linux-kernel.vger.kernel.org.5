Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BAA768035
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjG2O7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjG2O7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC635B6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690642729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/wXdZwFXqIWt8nGrgHuW2NdM/uHBSNRLeN2S0n9oPU=;
        b=H8grvz1EXxVYvbLbG/6u2BJ35oYoLxkj6iI/brZQ7fMr0BdyZhoNFWJv54t0IGW1picwPt
        ACs8NvCkvDi/14E5/fzVpqV4B/Hvp/AKnlpFv8gNCTGYFPgkYCJtlB0eAY6Sim2xE02Cza
        NxHIcMKN7l6dvm2vx9qGnazrBfR7G+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-Yl3hWObyPm-cbaE6puzSww-1; Sat, 29 Jul 2023 10:58:47 -0400
X-MC-Unique: Yl3hWObyPm-cbaE6puzSww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D5F5104458D;
        Sat, 29 Jul 2023 14:58:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2CA72166B25;
        Sat, 29 Jul 2023 14:58:46 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Guard against collision with KVM-defined PFERR_IMPLICIT_ACCESS
Date:   Sat, 29 Jul 2023 10:58:16 -0400
Message-Id: <20230729145815.2690215-1-pbonzini@redhat.com>
In-Reply-To: <20230721223711.2334426-1-seanjc@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> WARN so that any such conflict can be surfaced to KVM developers and
> resolved, but otherwise ignore the bit as KVM can't possibly rely on a
> flag it knows nothing about.
>
> Fixes: 4f4aa80e3b88 ("KVM: X86: Handle implicit supervisor access with SMAP")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


