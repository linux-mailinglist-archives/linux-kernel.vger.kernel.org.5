Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C87655D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjG0OWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjG0OWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:22:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC8122
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:22:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3172144c084so1107153f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690467764; x=1691072564;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaT2pEF0J9eN1S1CydWmLfdCMmVfOoCmMoN2wkr7y8k=;
        b=FIMiQR8bJiPm9V7gKRr2Rij4FvQEQgQs6OvDqK7Q0bWtMW7GtWSZj7wO8u4t1vW3gn
         QfDDMRt0Tu5CdUkK8g2AIOm7U/lgYIEN5/t0xN6cKbKHR4Qus8tR38m5dACZTsG2MoYF
         nSh0+Tzl/m4EERjBFmUdVcfgOfJwshOX99zmxyr9jwJks70Sk51Mczc65Ipvzb2jvICe
         w0J9GMGm9OGcZwqt4R03QQ8+RezeqzRrOrT15K5lk0UKQu58etypRJzWlFTToiU8qEpO
         Z3E+n/M75MrDzu8D/UxEFUjNh42ZD/qUlcoiNv4sbBl4K0mHhOGdGJNxCCJ9a8Ar1v7v
         oFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467764; x=1691072564;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HaT2pEF0J9eN1S1CydWmLfdCMmVfOoCmMoN2wkr7y8k=;
        b=HsmjJheLYaBv4t9zQPoDmDYMUGMrevbPSQ+snhrZ+Ih87I90mY3P8pR8Y77ve8Xb/w
         V/yHMXqXpUGt5xrWYE811fdticPC7NyWyU/HsgZ1RYG1IJyGeqn8YkwqX78xoBxi1qmF
         FXdkoUTMiikbAhfi1bAjIba8Vzl4Hj0jjdOE5z2aLPI1qPRob7uo+E1yh9yojYk1j+Gf
         /ol8s8pEa82FGjO7nt+NH67flKuURIJOmtOwW4Z95xND2ow/u1PzOVCgdjn/q6rjMkP5
         m6/krboRwvBQHuwQY+Faw8qwK1IJ+90QBCYUC8Yn9bF3ouPRcoaEmM6zCeu77X5aAab4
         mYkg==
X-Gm-Message-State: ABy/qLa83CL+0U000sxleI+S5ZK8XVCgBIlLZiACvqylWRf3gV5/Uy7n
        KWC2laLHtAuYh6S2tATSaJQ=
X-Google-Smtp-Source: APBJJlF7P9V/kiplYnzpb1Y2LwJnwM6kK74EjM2VTY6lSRPH2VL3wq08AqFAaBhX5xeT/KzfDEElkg==
X-Received: by 2002:a5d:50c6:0:b0:314:748:d59d with SMTP id f6-20020a5d50c6000000b003140748d59dmr2203910wrt.27.1690467764350;
        Thu, 27 Jul 2023 07:22:44 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id l6-20020a5d4806000000b003143ac73fd0sm2267865wrq.1.2023.07.27.07.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:22:43 -0700 (PDT)
Message-ID: <0012c64a-26cb-131d-7abb-29f6741af944@gmail.com>
Date:   Thu, 27 Jul 2023 15:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: potential null pointer dereference in setup_cpuid_table
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with cppcheck found a potential null pointer dereference 
in function setup_cpuid_table in arch/x86/kernel/sev-shared.c as follows:

         if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < 
PAGE_SIZE)
                 sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);

         cpuid_table_fw = (const struct snp_cpuid_table 
*)cc_info->cpuid_phys;


cc_info is being null checked, so it's potentially null, however, the 
assignment to cpuid_table_fw is dereferencing cc_info. Either cc_info is 
never null and the null check is redundant, or there is a potential null 
pointer dereference.

Colin

