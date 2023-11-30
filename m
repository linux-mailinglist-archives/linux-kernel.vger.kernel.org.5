Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B087FE659
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbjK3BoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjK3BoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:44:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A010DB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfd4ef9f06so5608345ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308665; x=1701913465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lln3JA/pL2zNGG8fnWXWFxt/sDS6XmKq9CUbeWSzI+U=;
        b=hLCQLMreGSsOJb4PEsjjAZX5OBqORQsQ0vhdiAWLZuioy3zTgy6oGMa2s8q+PXMQjA
         OFnirMnv1WQLWdKgACzf+kmNQvDay62Wm4lkfT/2oxPEr7B8otAMdBSSQNw2Kr7ubp/T
         LZnr5wQYJ13pQb4fosgsUqgNv5q3naAnV/U7SDItKHLf7/d4/dH0OavYBrw6IQVT9hWn
         wut9o0kRv8aVgNWaB6VFrtFGVXvyOgXBg6rXqob0GqRUw3jPsw7ICIJ7Tg71PRimIi9V
         zt29wgc0MlnFkhqTAtblLgwPqTIGHqDTeuz7oGxFgo5qZjsg9dAJ00+2C2VsG7JdIA39
         xrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308665; x=1701913465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lln3JA/pL2zNGG8fnWXWFxt/sDS6XmKq9CUbeWSzI+U=;
        b=ZlPJOkZbciMha5zxF8O/dC64PkPB35iluGipZk3/4QGr54N20Irrgeh9QfK1EUk90H
         f9LGZ/vjvkck8URofiw3ErGWXH1v2FzK4PXQ9AFzNuNSVmjsDm01dzKsN3X04eBNg+z0
         hiJFGmXtwEVi64kDLUJlATDU8Y6GlQiMQ8uHVtGunc+WL6Q5KbP6RNnjnZBr45Zk58qm
         jo5Q8dC8yo4DKygIHSTi3nTffEWj6HvvQqVisbulFSm3FPhNfGhiUFw+F1p2jR0XJj+t
         DpLhFS7BiBCpdoAeq5u1ofm6nFdZ4NFSgPhIGGoYp8izs6SROIdB82zbtj7dEFqzEVvz
         4Jug==
X-Gm-Message-State: AOJu0YykUhGoBQlm6vj5tcNP562xnCVDVHAte3z/K4MGXmuHfyjzBS7J
        RCSrpiQnOUAJfR5JGboDwFA9fH2rFgM=
X-Google-Smtp-Source: AGHT+IHhXzzYXOzUBShDv5PGX0Z4/O+DwcPcBk7HaqSRWwv0r6E6VgrGl95aCT63qnVH61WySbFupvW1SnI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:452:b0:1cf:a2af:ee09 with SMTP id
 iw18-20020a170903045200b001cfa2afee09mr3891848plb.5.1701308665015; Wed, 29
 Nov 2023 17:44:25 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:44:10 -0800
In-Reply-To: <9fc8b5395321abbfcaf5d78477a9a7cd350b08e4.camel@infradead.org>
Mime-Version: 1.0
References: <9fc8b5395321abbfcaf5d78477a9a7cd350b08e4.camel@infradead.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <170129774172.531444.5273351479240082811.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: add -MP to CFLAGS
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023 20:34:53 +0100, David Woodhouse wrote:
> Using -MD without -MP causes build failures when a header file is deleted
> or moved. With -MP, the compiler will emit phony targets for the header
> files it lists as dependencies, and the Makefiles won't refuse to attempt
> to rebuild a C unit which no longer includes the deleted header.
> 
> 

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: add -MP to CFLAGS
      https://github.com/kvm-x86/linux/commit/fc6543bb55d4

--
https://github.com/kvm-x86/linux/tree/next
