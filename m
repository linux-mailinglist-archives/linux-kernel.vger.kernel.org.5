Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64027AFED2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjI0IoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjI0IoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:44:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061AB95
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:43:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bffdf50212so172296441fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695804237; x=1696409037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCkza55Bwm3HBRjy5gx9XLQCeSfCsP7GfuZ+jZDqYqw=;
        b=zv+K0F+vhJkU5qOAiIZitQVZlEaJ9EfIuEtc/xFw1nY8UI+DuARkBmjQhHfTkGZSWB
         kpGFsCHBMJJ12rXgX11fJ1PPvR8if4Gan2OV05JiqNTZA7Sa7DzJvULEogxikSre4UD0
         GtNiAFJOVc1oAxcTSitXgl9NsfUf7j9nODVN/vBUmElzup5RGgRKd0gYvomsJ6pEls9v
         Kz9luzw59VforWj1DpXDEdBpC3gJHmQfQbS1s++nV54e0e6cttxSpNac97UsVtlLaAHJ
         vVOEhqeV5z9DU7K+l2YFH2z06fBpD6BRrsFXjUt9mAFOUljBBF0pUgBIy0TqUA10cuGe
         Rr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804237; x=1696409037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCkza55Bwm3HBRjy5gx9XLQCeSfCsP7GfuZ+jZDqYqw=;
        b=F9BXXghZOyV1mdK/G3c0ujGF9lF3o30XKfR/EgVwcEvYAIhs+HBR/7BEXk/hAdHSem
         O1chbsOu+EdXX7MNEvkldKDvHaML1jqUCkXJgvmOvwNB0eRoBAZQYyMrbHFkQLVi8WvU
         ADYm+DLqhp56Vv+CBzPBiQrBioQXqNEm+TPmsvXepJfr7nKe1XDx+wUXR0gdkxuMEN3M
         PtlSiWs99TaibU4kM7F4p9VDQGufluDpJ54qAanp1Qo1l+9RS/pLXklr9Cv8sMXrsXcR
         5MgZ5GdNZvb1idbsmM2N7z8IbVcJwpyqWiLcWZ4htO+ufm3M2khOrie8rpOfNbFKtRx5
         W4KA==
X-Gm-Message-State: AOJu0Yx8uxN+oSPyrDWVICBhpj/Q6MkUqfRQK5DUBALb+OROhs/5dvwi
        gWXHhYcchWfv3DVncSuxNqblHKYN74occcnW6bZNRw==
X-Google-Smtp-Source: AGHT+IE7Akj1gkfZU49/hgqEVZAQMUM1wLScrcB5V4TjMtUkPkchUmssEKLJNnUKIAgOAz2uYNKfsTcxRUUXPmMhtdY=
X-Received: by 2002:a2e:808f:0:b0:2c0:d21:39de with SMTP id
 i15-20020a2e808f000000b002c00d2139demr1519425ljg.42.1695804237206; Wed, 27
 Sep 2023 01:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com> <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
In-Reply-To: <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
From:   Thomas Fossati <thomas.fossati@linaro.org>
Date:   Wed, 27 Sep 2023 10:43:41 +0200
Message-ID: <CA+1=6yehiG+-Mnn2Xk6TdPqjkucANpwLvcfLdd9sDG2foeyRaA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caveat: newbie here (just subscribed the linux-coco list) trying to
bridge the abstract language of IETF RATS with an actual
implementation of the architecture.

> +struct tsm_report {
> +     struct tsm_desc desc;
> +     size_t outblob_len;
> +     u8 *outblob;
> +     size_t certs_len;
> +     u8 *certs;
> +};

Could you clarify the semantics of @certs?

Are these what the IETF calls platform "endorsements" [1], [2]?
Or could a DICE report (which is a cert chain) fall into this bucket too?

If the former, maybe @endorsement_certs (or similar) would minimise ambiguity.

[1] https://www.rfc-editor.org/rfc/rfc9334.html#name-endorsements
[2] https://www.ietf.org/archive/id/draft-dthaler-rats-endorsements-02.html
