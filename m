Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4376C615
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjHBHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjHBHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:04:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11831FF3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:04:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0e201f87so752507e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690959885; x=1691564685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2sfaru8OmVAEwVJ+R5RxlQAJhktlVz8IstV6follvw=;
        b=t0vr7GihQGBrwc1YJ3g1AAGYXD1jGvcpgN6iJPKD5xMRd3D2qdP95+65hD6xjI47pn
         kIWOuYLdSGmHKai2A5knurHHQEORLXj75JtpwB1ZU7vS0VgUmxbknWAUZzsgFblUWzKS
         aT3HYRNov0I3Xr8f/zcWSnH16/BsAG/VDPYFRoR32RQ3fnySxvEHSNKU+QtkRn/zH/fX
         rPieoZuPJ/0ljTNhj5e+j/+RkSTyoU3yUcSDFPpsQZ/DeflKsTO+UNjJq1RcLE1by5FN
         AOIfoco74tbL3wVNC8VSOvlFVPcpWoj3KViiZNjNaHsDEryuy7dEmJ2awpyYFK0tXAJf
         Xj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959885; x=1691564685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2sfaru8OmVAEwVJ+R5RxlQAJhktlVz8IstV6follvw=;
        b=XA1DmJhEsBiEiIib8DIGesGNdewK0kFbzlYDMnSaDwKyzsCWJzl6kuiIEWrNMfVmZI
         EWGHf/unyAnJyBHwpXKF52VqDBNtKzUTBSk2lDGlMCT/Ve5h312IqY+EG9b2D1XB5vwG
         aSyqQz0SCeoFwSvqngx1J157kkfJBUrvdB4fNg9mWwUHwAGYlMNdyn4J0scrb46+v33j
         C9qQiE8IXyRBWzPX4sHgh47ZGMuV5MxJiX8LYumkNfbtETNMR4GbZit/YHjXCOnrzTQu
         IELihp1NDDqh+wzzCImI5WOLsIWmKNwS9aZgOVx+a/smrfnRuW18aDHXG9HniOPEeaHe
         8WrQ==
X-Gm-Message-State: ABy/qLZ/GOpkApM1tsQ+3l9ULpLUB9r8OlN+V1JjyrOF5d2LnzPKPFXR
        1awYj9rZlFvSh4Q+P0H/NbgLyWUlbrrb5p7N3PNqTg==
X-Google-Smtp-Source: APBJJlEFs33+TYBvFeAhLwS/9cMe6ZvbN5xrDHcMO8IGg8h5hW0KncTIehYj+kKXFczrThbpIoNGezoyA4hMlAxDpQA=
X-Received: by 2002:a19:2d5b:0:b0:4f9:dac6:2f3d with SMTP id
 t27-20020a192d5b000000b004f9dac62f3dmr1638816lft.13.1690959885075; Wed, 02
 Aug 2023 00:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
 <20230731065041.1447-4-masahisa.kojima@linaro.org> <e1e9a9c1-db6f-c2f6-1ac0-fd368f79aec6@canonical.com>
In-Reply-To: <e1e9a9c1-db6f-c2f6-1ac0-fd368f79aec6@canonical.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 2 Aug 2023 10:04:08 +0300
Message-ID: <CAC_iWjLo=RbFCs5i1jdMXRbx0r-ximrSb5fWFad+98R5r_gpXQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
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

Hi Heinrich

[...]

> > +static struct tee_client_driver tee_stmm_efi_driver = {
> > +     .id_table       = tee_stmm_efi_id_table,
> > +     .driver         = {
> > +             .name           = "tee-stmm-efi",
> > +             .bus            = &tee_bus_type,
> > +             .probe          = tee_stmm_efi_probe,
> > +             .remove         = tee_stmm_efi_remove,
> > +     },
> > +};
> > +
> > +static int __init tee_stmm_efi_mod_init(void)
> > +{
> > +     return driver_register(&tee_stmm_efi_driver.driver);
>
> Assuming that multiple drivers supplying EFI runtime services may be
> available in future, e.g.
>
> * generic, using EFI runtime function supplied by UEFI firmware
> * TEE-STMM
> * Qualcomm driver as needed for Lenovo X13s
> * ubootefi.var file in ESP
>
> further assuming that multiple driver probe functions succeed:
>
> How do you identify which driver to activate?

This is really a firmware issue.  Whoever assembles that needs to make
sure there's a single entity that should manage the EFI variables.

As far as the current situation
- Qualcomm doesn't run OP-TEE and IIRC uses a DT-entry to enable that code
- OP-TEE will swap the runtime variables calls if StMM is compiled
along and the userspace supplicant is running
- We got no support for ubootefi.var.  If we ever add that the only
clash I can see is u-boot compiled with StMM support and someone
touches the ubootefi.var on ESP.

I'd really prefer to have the feature be autodetected, but if we can't
do that, perhaps we could agree on an EFI config table that the kernel
could read and interpret on what to activate on priority, or
alternatively re-purpose Qualcomms DT entry?

Regards
/Ilias

>
> Best regards
>
> Heinrich
>
> > +}
> > +
> > +static void __exit tee_stmm_efi_mod_exit(void)
> > +{
> > +     driver_unregister(&tee_stmm_efi_driver.driver);
> > +}
> > +
> > +module_init(tee_stmm_efi_mod_init);
> > +module_exit(tee_stmm_efi_mod_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> > +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> > +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");
>
