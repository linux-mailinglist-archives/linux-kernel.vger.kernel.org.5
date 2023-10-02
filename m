Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C67B5814
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbjJBQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:48:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638CA7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:48:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso743815066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265324; x=1696870124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tGIS2d4IoBhPIJormO2ARUKb4WPqFJw4stm8Ff0wEc=;
        b=EqZ3hnlW0kWkABLTZ2bv56rY23eCA8qjQ8HHGennZuF3Tn/ebC/DpXVoN2JHmR7rQR
         qACnrpstM/QOzpuAC684PQvJHfpucxdAmdjgh8sFiPiwg0hliZNhLzFJ6293Rlak77jt
         OMQiuaukXF9Kx3sbHepF6KzR1MV0h3/7QHD+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265324; x=1696870124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tGIS2d4IoBhPIJormO2ARUKb4WPqFJw4stm8Ff0wEc=;
        b=uy91fRNAXc6sMxwTQc9c5mCHnzDzyfvkbbBDOToqXXtDETIdmMXxnx44cgA6t+ktJ9
         rboayGFSdMSFaE70+RuBFjaIFM2LDF5pqsjTM7twmju/sm3a3soshGtv4d0t5gSzdXe6
         I7OZZNbKQ8kZ1MgsuGHPpI8lN38oKwtcid4mQVXXfliBSR/7AoXFB8DT9A/3YbHDoB1i
         LGqb3xXEGzzUpCGDURtOLx8eLVG8GDgkVMMYrnVLTB1aeE98Qk5trLOqrZKdwAFZ1CA3
         mwuNTi/cafhzum4FYnkHL7g4HoQ4mKdaF0bs2A24TreyccmoPvME4C5Y+EJ6WdbbkS53
         P+FA==
X-Gm-Message-State: AOJu0YzRZuUZiftg5Mw3kyPWjAVxH/q8+isv6SASxYKC36O4EPdu9wl/
        jEaz6PYcvXQrXsEf31mUPBJf6HWkhru2hRerC18jMV2+
X-Google-Smtp-Source: AGHT+IFeQTeBq/kotKgZoNYHVz0XIx/jK7Vc3KalYucS/PnbFxYtDEcZc27/c20A/FtXD1j6uWeqdA==
X-Received: by 2002:a17:907:e92:b0:9ae:5879:78dd with SMTP id ho18-20020a1709070e9200b009ae587978ddmr259579ejc.1.1696265324091;
        Mon, 02 Oct 2023 09:48:44 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906051100b0098e2969ed44sm17201681eja.45.2023.10.02.09.48.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 09:48:44 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso307a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:48:43 -0700 (PDT)
X-Received: by 2002:a50:96d1:0:b0:522:4741:d992 with SMTP id
 z17-20020a5096d1000000b005224741d992mr2415eda.4.1696265303058; Mon, 02 Oct
 2023 09:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230906160505.2431857-1-dianders@chromium.org>
 <20230906090246.v13.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid> <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
In-Reply-To: <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Oct 2023 09:48:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCcwc71hSMQVQN4AYi7XhKpOwbOZnt8b9iGUgqmvzuKw@mail.gmail.com>
Message-ID: <CAD=FV=WCcwc71hSMQVQN4AYi7XhKpOwbOZnt8b9iGUgqmvzuKw@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] arm64: smp: Remove dedicated wakeup IPI
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephen Boyd <swboyd@chromium.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        philmd@linaro.org, samitolvanen@google.com,
        scott@os.amperecomputing.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 25, 2023 at 5:39=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Mark,
>
> On Wed, Sep 6, 2023 at 9:06=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
> > +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> > +void arch_send_wakeup_ipi(unsigned int cpu)
> > +{
> > +       /*
> > +        * We use a scheduler IPI to wake the CPU as this avoids the ne=
ed for a
> > +        * dedicated IPI and we can safely handle spurious scheduler IP=
Is.
> > +        */
> > +       arch_smp_send_reschedule(cpu);
>
> I was backporting this to our ChromeOS kernels and our build test bot
> noticed that arch_smp_send_reschedule() didn't exist in older kernels.
> That's fine--I can always adjust this patch when backporting or
> cherry-pick extra patches, but it made me wonder. Is there a reason
> you chose to use arch_smp_send_reschedule() directly here instead of
> smp_send_reschedule()? I guess the only difference is that you're
> bypassing the tracing. Is that on purpose? Should we add a comment
> about it, or change this to smp_send_reschedule()?

FWIW, I posted a patch changing this to smp_send_reschedule(). Please
yell if this is incorrect.

https://lore.kernel.org/r/20231002094526.2.I2e6d22fc42ccbf6b26465a28a10e36e=
05ccf3075@changeid
