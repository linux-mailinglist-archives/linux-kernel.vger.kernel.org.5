Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18F7D53D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbjJXOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjJXOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:23:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71EEC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:23:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81a80097fso60246857b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698157427; x=1698762227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=twMmNMLT/rPYEX5Nwf1fQb/yxDk1I4wk+S2dB4JawmA=;
        b=WDBFNIl+DJbJYnWkAgC/ZzjYcU5V74rmw4RgdvbpD0OdN3zc2kWi32uPj2SB/cd6Nc
         CJROJ7PVA8ovUdvx5umwjOAHYV9hafZYb94XnErGKBEXBi7DunOZ2M1C33fOxT8jOKQh
         Z8Ag0TjOMjYRKN9H3/IOo2Ap3YmObqovlNThk8cPVSclxRaSs0AZtf4pwrnSlD6ehRxQ
         +0CoBHFKJlfqKGRmUV83Q9jjWwy+3LyzFQThnxpTdtfsQKIx4zzBqNccgDADhF/o5Eh9
         H08q2aMQN+h0i97eODJbn6oh1eewGMAElS+iJTHuRHGSpt0oSFbrw+bwmtnPU7OQM0BT
         gzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157427; x=1698762227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twMmNMLT/rPYEX5Nwf1fQb/yxDk1I4wk+S2dB4JawmA=;
        b=BOJCgyQxDgdbRnwYKVPjHqz8NUWGJVbHp4KrvzoRNUgbyemnT3W+v0gI3C406QrUTH
         OSWo+BLiGincX136ymf8S1kkFFreqZAGQluYClbiUmAiPY0HXjAmOdFRHWDAZHNpiltA
         Vod3w0jBLcZdZh+ts9sHBjTFMP+wJ8qsNU7vzBQ4C6pIS4palUH9WKynpsjAmbAQsegz
         ElbRHO+VBQk34QdWuiZTqjdobSAJ9Ro4k/q1/3W3g8hZnKsr50WIqZSMZ5SX8rRNfOiK
         Hvl7KzXe69AtNsT5l896V/lP54NRHjUwI6EeFFHxbCWZ3WtowNHxFxstHpi+8WsFc0uP
         nZlA==
X-Gm-Message-State: AOJu0YyQvUGFAKe/OJJbIBycfUbddFJHFQSHCX2SGSJtQY8YWYd/z5Vs
        crJH0UsYCyup/t8Jvux02nrvtblxrKA=
X-Google-Smtp-Source: AGHT+IGomLg66HtY40UECd2ZEeql0Ylsl7XTPknydZb9bn5J7FV27/lzXVzqu0bZZaKrQWPTG0VOmceIcUw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ebc7:0:b0:5a8:7b96:23d8 with SMTP id
 u190-20020a0debc7000000b005a87b9623d8mr253989ywe.3.1698157426910; Tue, 24 Oct
 2023 07:23:46 -0700 (PDT)
Date:   Tue, 24 Oct 2023 07:23:45 -0700
In-Reply-To: <58bcee35-7573-7ea8-18f3-de741e3e7b9b@gmail.com>
Mime-Version: 1.0
References: <20231024002633.2540714-1-seanjc@google.com> <20231024002633.2540714-14-seanjc@google.com>
 <58bcee35-7573-7ea8-18f3-de741e3e7b9b@gmail.com>
Message-ID: <ZTfTcbuOi7FBVMow@google.com>
Subject: Re: [PATCH v5 13/13] KVM: selftests: Extend PMU counters test to
 permute on vPMU version
From:   Sean Christopherson <seanjc@google.com>
To:     JinrongLiang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023, JinrongLiang wrote:
> > -static void test_gp_counters(uint8_t nr_gp_counters, uint64_t perf_cap)
> > +static void test_gp_counters(uint8_t pmu_version, uint8_t nr_gp_counters,
> 
> The parameter pmu_version is not used in this function.

Argh, I forgot to actually set the PMU version for the guest.  Good catch!
