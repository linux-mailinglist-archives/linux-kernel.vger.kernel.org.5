Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D987B2A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjI2CWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2CWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:22:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27251A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:22:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c604a5a53eso111304165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695954127; x=1696558927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTUV0L90Ur6DBE0QNkw1hUBF+sBR+scXrg6QO4JzYi4=;
        b=FpVj8qMv3dihbgF3cHMCnbM9E4Uv29RZWkNe0B9nXQoHzUozCVVOa/ZnFJhEP/1LRd
         X/nHN9GoU5MqHb6TqlOdY6zNSJjGIglbyNfyxx19YvfzHAxLoyxvqjs8pKsJuazFB8on
         7ATFflx/ETGmN3Cm7V/4ZqfMLDEnQ/H3JPsySqPdkvnNkTRTNewHWuCIefSfM/Wj6E/8
         V3Qi8H5PfsdKloNGydwC9jLHB/ZlqPqCDh2BvZN+fj5Xe3dr9iH//twVUURhIwqgThVR
         K6VkcljhEyDmWtnf0RKO7/0h2Zn6yQmTOJyPaxZfGTd0o640euc/eLo+W/nvo1xaBYBa
         GUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695954127; x=1696558927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTUV0L90Ur6DBE0QNkw1hUBF+sBR+scXrg6QO4JzYi4=;
        b=kM5DBI+RUFDAz807pKPNnZuV5lP/LW2N7FVD+M9EUYcWF8QTMzb2miexLpfjQWuMgd
         f7pgY/c7kaEJBu8BtIAyEB33U6VMtH5FkJHnA+nJgq80zBjAeVKJk0VXmZTSuFGABe7I
         x1wjLp6A/6312XN+R8qVIDActPrs7TkcqukPEEIfjKpcRx9xEvZsJ3UsD/jdogGrEa8D
         eoaGjLt3XVaqdszcgTeQjNirBJhjPM1Xf9uzejRK2qYlMwmjXgdHRPuh8WmSQsO0h1nn
         N2HHFfoQEkohIBZKiYbvlvrejcqVQPwfFVuQIy8/nUYBAWpyrgc35iFcj2moy5R6uQ8s
         QxVQ==
X-Gm-Message-State: AOJu0YxpedGTRiq4aujKV3L6rTVmzKQPFzx+0bvKskfbT7Uqfy8e5Rrm
        yia6U0HdZjaqfx3AUz0suBWFe2CHNxA=
X-Google-Smtp-Source: AGHT+IH1WYRDQBbppxvZvzgjJEtuJ6EIBOphA4sX+p76NDUiYXpKF+cErADA3hVFjQQxGNuZO61xk93S0Y8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db06:b0:1bb:8c42:79f4 with SMTP id
 m6-20020a170902db0600b001bb8c4279f4mr34397plx.2.1695954127178; Thu, 28 Sep
 2023 19:22:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:21:34 -0700
In-Reply-To: <20230907162449.1739785-1-pgonda@google.com>
Mime-Version: 1.0
References: <20230907162449.1739785-1-pgonda@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169592139216.1034106.11795311917283537943.b4-ty@google.com>
Subject: Re: [PATCH V3] KVM: SEV: Update SEV-ES shutdown intercepts with more metadata
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Peter Gonda <pgonda@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 09:24:49 -0700, Peter Gonda wrote:
> Currently if an SEV-ES VM shuts down userspace sees KVM_RUN struct with
> only the INVALID_ARGUMENT. This is a very limited amount of information
> to debug the situation. Instead KVM can return a
> KVM_EXIT_SHUTDOWN to alert userspace the VM is shutting down and
> is not usable any further.
> 
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: Update SEV-ES shutdown intercepts with more metadata
      https://github.com/kvm-x86/linux/commit/bc3d7c5570a0

--
https://github.com/kvm-x86/linux/tree/next
