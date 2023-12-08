Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60080AC9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574643AbjLHTEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574632AbjLHTEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:04:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3E11F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:04:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d0c4ba7081so29508897b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702062294; x=1702667094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaBQJ3hZrcjmPrQd+jYi6U6TZUHaUJywmO1UrbOss5M=;
        b=eQ91siv+hX7ilCV9ttVUa/8Tyn6DZbtImV8yXBBkLkZ4IUglr9vTVD0Bca8ehUmgq2
         pZr0CJVEZ8uWG1ygf92MZaEC6fdALCF3dhXMpe3UsAw/1jfL2USydz5OyoT3mynlhZVr
         XoXk9lhggC8Ie1V5p6EaFORDczsE8+HFkNxkUMlJoli/gL3i46r2/O/mM238v+Rr2kb8
         +7A4vgZppJGF/DUsNi3EHbTSLKuFMQdbucjRBoTeC0Ovh05JPq7V1CqZjsSjywMpETHF
         8j+k8HCSuMXTuHYmnvkUJPbhrM/G8VLrGmsLIy4c4HUB++3OCTONniPy84YMKh9MsOi4
         AY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062294; x=1702667094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaBQJ3hZrcjmPrQd+jYi6U6TZUHaUJywmO1UrbOss5M=;
        b=f8yWxQaEjQm5k/rSrlKudb2/SWxGWDNOIrbi9WPjWRVKHBXl4NHiQMN4i5i7BqBkTN
         0N4nfJp+caMHIMeWPMRMZJXU3gMLptwe9hVoB4vdjtIWgqVrESsnO0ACMrO9q4Exf4Vx
         zRg7yVvu2+8pYdsGEZ6BdNX33rw81xS9T4QWwCc5NqbDgrmdC8HXnmckoaGFACqPuEy8
         ux0Kq44WqX+Y8w7FkJU5512iSraZkH339qspZ8nye+sfxHgiVngVNoEcrZWYJFfaOHfq
         KuZ19NXaNJ6bi7vVuqqyUpGUMRi0RuQD/+yIrz0ia0cWQ0GB8DFx3Uc2nRDBv/StBtu9
         YJMg==
X-Gm-Message-State: AOJu0YwyyrO2vSRri08SzPYyFsoJZGDN/K7zkyUp0KN5h+HEwBEVbIRy
        ve97MMELFCN6KmcB6HQZgvVxfNnekcc=
X-Google-Smtp-Source: AGHT+IFbZkBjd3HF6V02hYYKfry86AYCnPZiPrBQt5m0oHmgAQfsetl9n/CXi8Ziz13kkCERMT8yZ6+2s/4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:338d:b0:5d6:e473:bf60 with SMTP id
 fl13-20020a05690c338d00b005d6e473bf60mr4374ywb.8.1702062294577; Fri, 08 Dec
 2023 11:04:54 -0800 (PST)
Date:   Fri, 8 Dec 2023 11:04:53 -0800
In-Reply-To: <20231208184908.2298225-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20231208184908.2298225-1-pbonzini@redhat.com>
Message-ID: <ZXNo1Rdla2zghM9s@google.com>
Subject: Re: [PATCH v2] KVM: guest-memfd: fix unused-function warning
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
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

On Fri, Dec 08, 2023, Paolo Bonzini wrote:
> With migration disabled, one function becomes unused:
> 
> virt/kvm/guest_memfd.c:262:12: error: 'kvm_gmem_migrate_folio' defined but not used [-Werror=unused-function]
>   262 | static int kvm_gmem_migrate_folio(struct address_space *mapping,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> Remove the #ifdef around the reference so that fallback_migrate_folio()
> is never used.  The gmem implementation of the hook is trivial; since
> the gmem mapping is unmovable, the pages should not be migrated anyway.
> 
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
