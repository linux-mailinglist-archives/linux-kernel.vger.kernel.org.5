Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91F7C8779
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjJMOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjJMOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:06:48 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A874BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:06:46 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b6043d0bbeso852058241.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697206005; x=1697810805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt0fl4zmpVCDg/iIyheiKGniBaGSQD47C4wQ8/liHAY=;
        b=Q2HyXIlPZa0CssQLmgX2KN80scdTeB9cb/+f/2BMuztDjyARTtuvGACXkb1aJgkgIq
         Pv5dY6Whysr2x5JO7mO1EMet5//mSxIgGRMW0DrUi1/38Vjqy7UQyLqlEGGcj1U7whJa
         cq2cjKECHvK19PJfYxikkCRDdj4HhyHJt4X5l03vkHYCiO3ymPfeWX39W+OHMqvxbbEV
         797xFE8KVsTjzsrTqFm2jg+uDjdw0LhldZFHx08tv8oAkQhNeOb0UhI0UIlecL15loyn
         L34/pBXuq6kwdpo4uj/mip4WGHcujWHHwbRlgt6yovYKaM2VsQfLostLuD2GX5yADO0X
         N+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206005; x=1697810805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt0fl4zmpVCDg/iIyheiKGniBaGSQD47C4wQ8/liHAY=;
        b=OfDihgLtJCVVnthJbnas5Ykx+FsFPRM1edBNO1o4yBfRPP3ey3VHSMlZ3NsE9imD1w
         wPfeML+xPEpYathQj5HM24Ne4bEtd4iylNGhv9peRXZN3+CQlqwlsgCDvWta3Q0GB/q6
         loSDPKHKqvivj2NvMIHY0vVolNr0xpDo3M58MEADpPVxSVAwwuUz44efJV1Wc86P4A5y
         0OxCZzMtxn40MRsUwcQ00asrYFWkCmzI3vAyjLVURN7aV7qfSogI9n0fCIwvRaJpSLS8
         905HabFFq/UQL7N/EBfFhIYRWyWyZJjrclqTTmZDEU4z9z+BIkLaQ8LUVB9D/okPKf7M
         jUuw==
X-Gm-Message-State: AOJu0YwF6MxnCNZM8zj+MDtS7cl51AO8oEmcipoW7OfJr2eoXhVabwzZ
        o2H2i2yzFe3KaYmzRHANEpeOsiSFm9eO4c2OrsSWww==
X-Google-Smtp-Source: AGHT+IHHW8Cvi6xw76wjQvt7zAWuReiRAvKLMZtlUVHDQhJIZCO7syVhni+4FjqpV0pR1q0gxReM64HGLnzc7atULVU=
X-Received: by 2002:a05:6122:ca8:b0:49d:120c:3c2a with SMTP id
 ba40-20020a0561220ca800b0049d120c3c2amr24587056vkb.11.1697206004911; Fri, 13
 Oct 2023 07:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-14-brgl@bgdev.pl>
 <fr4jwbacvcheqtxy6php2u6wr72mqm5hgat6xwmxhijee7j6sk@azlu42eod6b4>
 <j543teo2apaugbq25to3un7f7iyh45tfxenmhj7vb3vwqd52i3@434do3lfdzq4>
 <CAMRc=Mcyp7GQ9Hb2crASW_Y_Q84tn977BXfrKDrM1N8ihdrvRQ@mail.gmail.com> <km6pp6ctzclrgrvfgpbhoykngcnyoqerjnng65x3mox7dzdwwt@nnvxbwqbygrw>
In-Reply-To: <km6pp6ctzclrgrvfgpbhoykngcnyoqerjnng65x3mox7dzdwwt@nnvxbwqbygrw>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Oct 2023 16:06:33 +0200
Message-ID: <CAMRc=MenB-41Gf8hDQ-eO6V2CFCEqe-8uOMJ6FMneeb8xCmu-w@mail.gmail.com>
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

On Fri, Oct 13, 2023 at 3:31=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Fri, Oct 13, 2023 at 10:32:00AM +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 12, 2023 at 12:17=E2=80=AFAM Andrew Halaney <ahalaney@redha=
t.com> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 04:14:32PM -0500, Andrew Halaney wrote:
> > > > On Mon, Oct 09, 2023 at 05:34:25PM +0200, Bartosz Golaszewski wrote=
:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Add a new Kconfig option for selecting the SHM Bridge mode of ope=
ration
> > > > > for the TrustZone memory allocator.
> > > > >
> > > > > If enabled at build-time, it will still be checked for availabili=
ty at
> > > > > run-time. If the architecture doesn't support SHM Bridge, the all=
ocator
> > > > > will work just like in the default mode.
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.or=
g>
> > > > > ---
> > > > >  drivers/firmware/qcom/Kconfig      | 10 +++++
> > > > >  drivers/firmware/qcom/qcom_tzmem.c | 67 ++++++++++++++++++++++++=
+++++-
> > > > >  2 files changed, 76 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qco=
m/Kconfig
> > > > > index 237da40de832..e01407e31ae4 100644
> > > > > --- a/drivers/firmware/qcom/Kconfig
> > > > > +++ b/drivers/firmware/qcom/Kconfig
> > > > > @@ -27,6 +27,16 @@ config QCOM_TZMEM_MODE_DEFAULT
> > > > >       Use the default allocator mode. The memory is page-aligned,=
 non-cachable
> > > > >       and contiguous.
> > > > >
> > > > > +config QCOM_TZMEM_MODE_SHMBRIDGE
> > > > > +   bool "SHM Bridge"
> > > > > +   help
> > > > > +     Use Qualcomm Shared Memory Bridge. The memory has the same =
alignment as
> > > > > +     in the 'Default' allocator but is also explicitly marked as=
 an SHM Bridge
> > > > > +     buffer.
> > > > > +
> > > > > +     With this selected, all buffers passed to the TrustZone mus=
t be allocated
> > > > > +     using the TZMem allocator or else the TrustZone will refuse=
 to use them.
> > > > > +
> > > > >  endchoice
> > > > >
> > > > >  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> > > > > diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmwar=
e/qcom/qcom_tzmem.c
> > > > > index eee51fed756e..b3137844fe43 100644
> > > > > --- a/drivers/firmware/qcom/qcom_tzmem.c
> > > > > +++ b/drivers/firmware/qcom/qcom_tzmem.c
> > > > > @@ -55,7 +55,72 @@ static void qcom_tzmem_cleanup_pool(struct qco=
m_tzmem_pool *pool)
> > > > >
> > > > >  }
> > > > >
> > > > > -#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> > > > > +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> > > > > +
> > > > > +#include <linux/firmware/qcom/qcom_scm.h>
> > > > > +
> > > > > +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> > > > > +
> > > > > +static bool qcom_tzmem_using_shm_bridge;
> > > > > +
> > > > > +static int qcom_tzmem_init(void)
> > > > > +{
> > > > > +   int ret;
> > > > > +
> > > > > +   ret =3D qcom_scm_shm_bridge_enable();
> > > > > +   if (ret =3D=3D -EOPNOTSUPP) {
> > > > > +           dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n"=
);
> > > > > +           ret =3D 0;
> > > > > +   }
> > > > > +
> > > > > +   if (!ret)
> > > > > +           qcom_tzmem_using_shm_bridge =3D true;
> > > >
> > > > Does the qcom_scm_shm_bridge_enable() returning -EOPNOTSUPP case ma=
ke
> > > > sense? Setting ret to 0 and then claiming we're using shm_bridge se=
ems
> > > > wrong to me.
> > > >
> >
> > You answered yourself in the previous email. The size cannot be less
> > than 4096 bytes. There's no need to check it anymore than that IMO.
> >
>
> Ok, I still think that would be nice but your call.
>
> But this comment was about the above ret =3D 0 assignment. I am thinking
> that's incorrect, because you fail to enable SHM bridge with
> -EOPNOTSUPP, then you go ahead and tell the code to claim it is
> supported with the if (!ret) conditional. This results in SHM bridge
> trying to be used when its really not supported right?
>
> Looks to me that you're really trying to return 0, not ret =3D 0.
>

Gah! You're right, I should have waited with v4. Oh well, I'll respin
it next week.

Bart

> > Bart
> >
> > > > > +
> > > > > +   return ret;
> > > > > +}
> > > > > +
> > > > > +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> > > > > +{
> > > > > +   u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perm=
s, *handle;
> > > > > +   int ret;
> > > > > +
> > > > > +   if (!qcom_tzmem_using_shm_bridge)
> > > > > +           return 0;
> > > > > +
> > > > > +   ns_perms =3D (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> > > > > +   pfn_and_ns_perm =3D (u64)pool->pbase | ns_perms;
> > > > > +   ipfn_and_s_perm =3D (u64)pool->pbase | ns_perms;
> > > > > +   size_and_flags =3D pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_=
SHIFT);
> > > >
> > > > Is there any sanity checking that can be done here? I assume bits 0=
-11 are all
> > > > flag fields (or at least unrelated to size which I assume at a mini=
mum
> > > > must be 4k aka bit 12).
> > >
> > > I guess qcom_tzmem_pool_new's PAGE_ALIGN would make sure this is
> > > probably ok for all future users, but I do think some sanity would be
> > > nice to indicate the size's allowed for SHM bridge.
> > >
> > > >
> > > > > +
> > > > > +   handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
> > > >
> > > > Consider __free(kfree) + return_ptr() usage?
> > > >
> > > > > +   if (!handle)
> > > > > +           return -ENOMEM;
> > > > > +
> > > > > +   ret =3D qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns=
_perm,
> > > > > +                                    ipfn_and_s_perm, size_and_fl=
ags,
> > > > > +                                    QCOM_SCM_VMID_HLOS, handle);
> > > > > +   if (ret) {
> > > > > +           kfree(handle);
> > > > > +           return ret;
> > > > > +   }
> > > > > +
> > > > > +   pool->priv =3D handle;
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool=
)
> > > > > +{
> > > > > +   u64 *handle =3D pool->priv;
> > > > > +
> > > > > +   if (!qcom_tzmem_using_shm_bridge)
> > > > > +           return;
> > > > > +
> > > > > +   qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
> > > > > +   kfree(handle);
> > > > > +}
> > > > > +
> > > > > +#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
> > > > >
> > > > >  /**
> > > > >   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> > > > > --
> > > > > 2.39.2
> > > > >
> > >
> >
>
