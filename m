Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCF7C804E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJMIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjJMIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:32:14 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5C0B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:32:12 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b08ac3ce7fso862836241.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697185932; x=1697790732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa7qpsXQ74LHlZliuPq5W6XoRIzH0nf1AuDsWbi9MR0=;
        b=ll/ljGLeAPkFQQ87Te3ULVNpz1lDpI4fZy+98TL7iElkUqDWI2WuTdYeIMZI66Oab7
         JLMZwNtiJgcipVehQ52inAFacSSXds+IW8hgoPzY8WBBDgkw8cjMg+TD2eNCuI9mqKwh
         Npki3AOF3DO4W88XwUocpDdCuy8UJHWfEFLn67Vq4umaS20t7yL06KXUyfwN0AC3As8O
         mbo7VW+qqCutDtpu1xQDW5VAoBkazdoDUiG70VvlmWqCK95woTXS0JBDDkmwbNaG8jWt
         itGUlB5+OIP4uTwmSWeNScxtfLOdgcxryzNi9tlYHt+YybXJm7l40zrJWX3xaORwCZQ7
         qv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697185932; x=1697790732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa7qpsXQ74LHlZliuPq5W6XoRIzH0nf1AuDsWbi9MR0=;
        b=N1ge3xFGHDeKmSMG4IHcSVKbWoj2Yav+pnyQM3TJw3ABHp+FQcPHeEb33SaRQBoZrs
         3Aa9SsNLywc4ZyakmWrVJPYKhOsAhNpJeVJIoXNWaAiX45l23mhu2XeBTmnElXLA+yLR
         6HHUVcuhyuRiCLOqKxwv42OThg+JP5o8vHlT0+dZsOkvOMmC410CGAHELBJg33fNlY+b
         YfOcd+7TUzwr035xEDuVQdJOwaLQnS7A75Y6AzX9qgHdv6Dhs0SjZjn0S8oafxy4EVUi
         MTgngQcGVZEQVrbr1lbw8BUC7q/XmbmPUgJXoZvkbWiBB8OP398vAjUXsjzuCPmB2taI
         wKuQ==
X-Gm-Message-State: AOJu0YzwbejqkoTMyCrMn5zPW9+Qqwu7eD45WAOxPbP5rDzo04XgAU25
        WTKGC5ZpcHiCQupTXV4phHyqsDxPJi62bKnUiQCDFA==
X-Google-Smtp-Source: AGHT+IEh/svN9CkCZWFT9mgnutJPkM5O+oq5bh30YsVPe+Vz3NzMOT0KUhUK/L08NjQQ0hXmUVyHIFmb3expDl5tOOg=
X-Received: by 2002:a67:e118:0:b0:457:c6d4:1279 with SMTP id
 d24-20020a67e118000000b00457c6d41279mr521786vsl.5.1697185931904; Fri, 13 Oct
 2023 01:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-14-brgl@bgdev.pl>
 <fr4jwbacvcheqtxy6php2u6wr72mqm5hgat6xwmxhijee7j6sk@azlu42eod6b4> <j543teo2apaugbq25to3un7f7iyh45tfxenmhj7vb3vwqd52i3@434do3lfdzq4>
In-Reply-To: <j543teo2apaugbq25to3un7f7iyh45tfxenmhj7vb3vwqd52i3@434do3lfdzq4>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Oct 2023 10:32:00 +0200
Message-ID: <CAMRc=Mcyp7GQ9Hb2crASW_Y_Q84tn977BXfrKDrM1N8ihdrvRQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] firmware: qcom: tzmem: enable SHM Bridge support
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:17=E2=80=AFAM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Wed, Oct 11, 2023 at 04:14:32PM -0500, Andrew Halaney wrote:
> > On Mon, Oct 09, 2023 at 05:34:25PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add a new Kconfig option for selecting the SHM Bridge mode of operati=
on
> > > for the TrustZone memory allocator.
> > >
> > > If enabled at build-time, it will still be checked for availability a=
t
> > > run-time. If the architecture doesn't support SHM Bridge, the allocat=
or
> > > will work just like in the default mode.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/firmware/qcom/Kconfig      | 10 +++++
> > >  drivers/firmware/qcom/qcom_tzmem.c | 67 ++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 76 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kc=
onfig
> > > index 237da40de832..e01407e31ae4 100644
> > > --- a/drivers/firmware/qcom/Kconfig
> > > +++ b/drivers/firmware/qcom/Kconfig
> > > @@ -27,6 +27,16 @@ config QCOM_TZMEM_MODE_DEFAULT
> > >       Use the default allocator mode. The memory is page-aligned, non=
-cachable
> > >       and contiguous.
> > >
> > > +config QCOM_TZMEM_MODE_SHMBRIDGE
> > > +   bool "SHM Bridge"
> > > +   help
> > > +     Use Qualcomm Shared Memory Bridge. The memory has the same alig=
nment as
> > > +     in the 'Default' allocator but is also explicitly marked as an =
SHM Bridge
> > > +     buffer.
> > > +
> > > +     With this selected, all buffers passed to the TrustZone must be=
 allocated
> > > +     using the TZMem allocator or else the TrustZone will refuse to =
use them.
> > > +
> > >  endchoice
> > >
> > >  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> > > diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qc=
om/qcom_tzmem.c
> > > index eee51fed756e..b3137844fe43 100644
> > > --- a/drivers/firmware/qcom/qcom_tzmem.c
> > > +++ b/drivers/firmware/qcom/qcom_tzmem.c
> > > @@ -55,7 +55,72 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tz=
mem_pool *pool)
> > >
> > >  }
> > >
> > > -#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> > > +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> > > +
> > > +#include <linux/firmware/qcom/qcom_scm.h>
> > > +
> > > +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> > > +
> > > +static bool qcom_tzmem_using_shm_bridge;
> > > +
> > > +static int qcom_tzmem_init(void)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret =3D qcom_scm_shm_bridge_enable();
> > > +   if (ret =3D=3D -EOPNOTSUPP) {
> > > +           dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
> > > +           ret =3D 0;
> > > +   }
> > > +
> > > +   if (!ret)
> > > +           qcom_tzmem_using_shm_bridge =3D true;
> >
> > Does the qcom_scm_shm_bridge_enable() returning -EOPNOTSUPP case make
> > sense? Setting ret to 0 and then claiming we're using shm_bridge seems
> > wrong to me.
> >

You answered yourself in the previous email. The size cannot be less
than 4096 bytes. There's no need to check it anymore than that IMO.

Bart

> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> > > +{
> > > +   u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms, *=
handle;
> > > +   int ret;
> > > +
> > > +   if (!qcom_tzmem_using_shm_bridge)
> > > +           return 0;
> > > +
> > > +   ns_perms =3D (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> > > +   pfn_and_ns_perm =3D (u64)pool->pbase | ns_perms;
> > > +   ipfn_and_s_perm =3D (u64)pool->pbase | ns_perms;
> > > +   size_and_flags =3D pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIF=
T);
> >
> > Is there any sanity checking that can be done here? I assume bits 0-11 =
are all
> > flag fields (or at least unrelated to size which I assume at a minimum
> > must be 4k aka bit 12).
>
> I guess qcom_tzmem_pool_new's PAGE_ALIGN would make sure this is
> probably ok for all future users, but I do think some sanity would be
> nice to indicate the size's allowed for SHM bridge.
>
> >
> > > +
> > > +   handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
> >
> > Consider __free(kfree) + return_ptr() usage?
> >
> > > +   if (!handle)
> > > +           return -ENOMEM;
> > > +
> > > +   ret =3D qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_per=
m,
> > > +                                    ipfn_and_s_perm, size_and_flags,
> > > +                                    QCOM_SCM_VMID_HLOS, handle);
> > > +   if (ret) {
> > > +           kfree(handle);
> > > +           return ret;
> > > +   }
> > > +
> > > +   pool->priv =3D handle;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> > > +{
> > > +   u64 *handle =3D pool->priv;
> > > +
> > > +   if (!qcom_tzmem_using_shm_bridge)
> > > +           return;
> > > +
> > > +   qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
> > > +   kfree(handle);
> > > +}
> > > +
> > > +#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
> > >
> > >  /**
> > >   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> > > --
> > > 2.39.2
> > >
>
