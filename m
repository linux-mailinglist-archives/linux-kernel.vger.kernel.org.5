Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1376C315
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHBCui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHBCuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:50:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA97210A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:50:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2683add3662so4395957a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690944633; x=1691549433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mEciU1Z6QKvhxwGm0gWIaghrQDHodEupjalaHi7C4ek=;
        b=sw00dMomp4qoKUJKvQWZ8U7BwpH8nuA1hdHmpgpt9RwYi4sKYaf0YyJFCKdkljd+aI
         RdPmRAthF/D/TZQ3L5BRlkqzFpACa4cTugXbIWait5MP+MUqkIDU7qRcCxAAL49KOYgd
         l0zajU2VVCuxEX/6z7FJeMclkxAv5VkLGoZFoWxzPOR4z6LF7ohCRJiQBbrwFNJ8HWfj
         tD2muoJGdEun1lmGp3D3PJt9DrtWVpQ9+6nmaUqv5zkfxYp4JZg8veCTjwspXGah7GXg
         qI3JEcVDTX4erseoCaBxYfj3e/EWM22pKJ6F7EIox+VlsKdSn5/Y13I65vgk0Sx6Bv3A
         KRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944633; x=1691549433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEciU1Z6QKvhxwGm0gWIaghrQDHodEupjalaHi7C4ek=;
        b=V5mhJpOi3CPMtMfS8jkEvudKo3aVynVIx4VSaqMMtE5718ukUCgFmMe+0hvX9FacQl
         1WZiypnS0VPodRcmgvZP9ed3f4okhxMaJrQOkNZjrSlcmgWW1VcvSVR/aeZU7iWIqjpf
         sDZCc5E8uNJSd184pNLSzsDEhz9olf3HkuoXI7QIRrLfbt+mkWPa54E4tc0vaMNXyo3r
         4+E58tFf5EsnO127cijUTAGdNDOIX8tAHJNnliVCOMOtBYIyL5Jl3vele8AFtDeCTBWr
         Fc+C9waeMEQOIZtTOtdg3s5wAKyOYsuQ4hmKARDCTkwtep58Ln3Ly9W7YkdlKE+D47ee
         f/AA==
X-Gm-Message-State: ABy/qLZJLqjq07mWiKx0E849dK2vCKImBfVduxL8Zrq9rfQfZggFJHWO
        jEnjBtAkhKy92VxZF/uF09THwpeYMuFMv2PxYl73HQ==
X-Google-Smtp-Source: APBJJlFE7aed1xYMU4PfC57Dmdh/QB/JAqb36jqJoBarsI5/0tnpl7QlbRPHXlGgVLBoc+KXTKRNlsXgpM9WzYpK66A=
X-Received: by 2002:a17:90a:1b6c:b0:268:3d4:24bb with SMTP id
 q99-20020a17090a1b6c00b0026803d424bbmr14844027pjq.1.1690944633503; Tue, 01
 Aug 2023 19:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
 <20230731065041.1447-4-masahisa.kojima@linaro.org> <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
In-Reply-To: <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Wed, 2 Aug 2023 11:50:22 +0900
Message-ID: <CADQ0-X91QS8F1UA4Yzj8skk-q+F_5XaU=jQiew_TBpxV7=X5PA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 00:05, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 7/30/23 23:50, Masahisa Kojima wrote:
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 043ca31c114e..aa38089d1e4a 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -287,3 +287,18 @@ config UEFI_CPER_X86
> >       bool
> >       depends on UEFI_CPER && X86
> >       default y
> > +
> > +config TEE_STMM_EFI
> > +     tristate "TEE based EFI runtime variable service driver"
>
>                   TEE-based
OK.

>
> > +     depends on EFI && OPTEE && !EFI_VARS_PSTORE
> > +     help
> > +       Select this config option if TEE is compiled to include StandAloneMM
> > +       as a separate secure partition it has the ability to check and store
>
>                                partition. It has the ability
OK.

Thank you for your review.

Regards,
Masahisa Kojima

>
> > +       EFI variables on an RPMB or any other non-volatile medium used by
> > +       StandAloneMM.
> > +
> > +       Enabling this will change the EFI runtime services from the firmware
> > +       provided functions to TEE calls.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called tee_stmm_efi.
>
> --
> ~Randy
