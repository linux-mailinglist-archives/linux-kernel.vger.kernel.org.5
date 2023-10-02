Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6523A7B551D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbjJBOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjJBOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:23:27 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E2D8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:23:23 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4526f0bdf72so7301921137.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696256602; x=1696861402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxPjHX8lOdg5VlveiL5SkCXpx+vPkDUf+Tm1mFqI5VM=;
        b=qMJQM4jP5TmU5Tj262qA7kPKWAq3tzEhXHVM0mHzQ6gKYh997GFEVg0u3IjfaS12cI
         natHDYF4rJN/5J/sbf+hHuf4rZjXHkSI2QotJ8FaD4feAXguchODcUvF6pqy0JqcLiVP
         51r5me4Y/jCg0P1My3XO20Bq7GwpqjgWa0AMtA1deDC5sAgXd7cWOIim8tN/8btsAI4c
         2EkSVEvdvYoddhAzZi3F779t/S4coPhZ5Nx8M4zBFVLiFls1FLYdpCsQyMyHpppkEVA4
         4+IZVHFFZVHfK78cDX5wQ5QAjCio/mz7BGCi1K1yO3HtKIqvXpnVmkSFRHsy2q1Q54J9
         1I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696256602; x=1696861402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxPjHX8lOdg5VlveiL5SkCXpx+vPkDUf+Tm1mFqI5VM=;
        b=U/xtONGAeOzedjxSiDFOz48BUw1w2IQLsLKaT6PfJQ0IBX5GRB2tu6uREzWyWOHAak
         gj+mdPIUmGHzeozI8whl9WcyUkuH1BAJqQXvKvFErmsxFKdqTQZf3G7mdCfT6Le+Jxt9
         F11dJcNv//R2ZOCTP4dEgw6jPERtIi1KSgWjdB1Mz+nn73syP++iJdHCjEM8EkU2L1Wc
         5UOsksKRuAwtAakFcByB5GK9xJGgbBn/ACl1Y6MwrrfKYvimxq3ipQiOYmFvNoAZEyI5
         fCkTFLjPRyCR9Kv1GkkECmVfe7hQ4vY+NzH6f6Dp8snQv7yk8/GA1E2a9iLxXflQHgt5
         WZIQ==
X-Gm-Message-State: AOJu0YwtybhaFYPSMzuvDEwk+62jCOYxVXPIhH5EvBtcWGpKo4XYcqVU
        c4SWatTceuNpuh/YW7J+6xT4KsQ2TYpf70qFG8Nxtg==
X-Google-Smtp-Source: AGHT+IH+Qwl344hqarvnFgd7d9muanbsUuF8KD20GSUMYmpmcxR4p8pJ6Y9KSS6MqhaEBbPWRRCXGOcQUYELCjahEBQ=
X-Received: by 2002:a05:6102:1cb:b0:452:9ccb:fac6 with SMTP id
 s11-20020a05610201cb00b004529ccbfac6mr9453083vsq.32.1696256602101; Mon, 02
 Oct 2023 07:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230928092040.9420-1-brgl@bgdev.pl> <20230928092040.9420-7-brgl@bgdev.pl>
 <gwflmag5pq7osprj25l7i4tgyln2nauuqcwdhth2eomareooag@4dw4lwk4vr36>
 <CAMRc=Mfxt1DLinxMcKivQqqnHvFv5P8WXNnfAwnfrHgoz+q-5w@mail.gmail.com>
 <20230929204404.enzsjanohdqqpmk4@halaney-x13s> <2539186e-e0ec-4eba-9d6a-d966e00f0eb9@quicinc.com>
 <5puhrnpw2rww6kawt77krges6aj4re6nfblqkomuw5njtwydya@cuarfakzv62i> <6wt36wqcnvzp5znasldeu7txcscslydpxn7fcanzt3e77xcaju@ufbolnewsqwl>
In-Reply-To: <6wt36wqcnvzp5znasldeu7txcscslydpxn7fcanzt3e77xcaju@ufbolnewsqwl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Oct 2023 16:23:11 +0200
Message-ID: <CAMRc=McxX6q12gKry-8xy8Qmhs1vfNCO1iV3zGSC1He7S1YDZA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] firmware: qcom: scm: make qcom_scm_pas_init_image()
 use the SCM allocator
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
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

On Mon, Oct 2, 2023 at 4:15=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com>=
 wrote:
>
> On Mon, Oct 02, 2023 at 08:24:09AM -0500, Andrew Halaney wrote:
> > On Fri, Sep 29, 2023 at 03:48:37PM -0700, Elliot Berman wrote:
> > > Hi Andrew,
> > >
> > > On 9/29/2023 1:44 PM, Andrew Halaney wrote:
> > > > On Fri, Sep 29, 2023 at 12:22:16PM -0700, Bartosz Golaszewski wrote=
:
> > > >> On Fri, 29 Sep 2023 21:16:51 +0200, Andrew Halaney <ahalaney@redha=
t.com> said:
> > > >>> On Thu, Sep 28, 2023 at 11:20:35AM +0200, Bartosz Golaszewski wro=
te:
> > > >>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >>>>
> > > >>>> Let's use the new SCM memory allocator to obtain a buffer for th=
is call
> > > >>>> instead of using dma_alloc_coherent().
> > > >>>>
> > > >>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.o=
rg>
> > > >>>> ---
> > > >>>>  drivers/firmware/qcom/qcom_scm.c | 16 +++++-----------
> > > >>>>  1 file changed, 5 insertions(+), 11 deletions(-)
> > > >>>>
> > > >>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware=
/qcom/qcom_scm.c
> > > >>>> index 02a773ba1383..c0eb81069847 100644
> > > >>>> --- a/drivers/firmware/qcom/qcom_scm.c
> > > >>>> +++ b/drivers/firmware/qcom/qcom_scm.c
> > > >>>> @@ -532,7 +532,7 @@ static void qcom_scm_set_download_mode(bool =
enable)
> > > >>>>  int qcom_scm_pas_init_image(u32 peripheral, const void *metadat=
a, size_t size,
> > > >>>>                            struct qcom_scm_pas_metadata *ctx)
> > > >>>>  {
> > > >>>> -      dma_addr_t mdata_phys;
> > > >>>> +      phys_addr_t mdata_phys;
> > > >>>
> > > >>>>        void *mdata_buf;
> > > >>>>        int ret;
> > > >>>>        struct qcom_scm_desc desc =3D {
> > > >>>> @@ -544,13 +544,7 @@ int qcom_scm_pas_init_image(u32 peripheral,=
 const void *metadata, size_t size,
> > > >>>>        };
> > > >>>>        struct qcom_scm_res res;
> > > >>>>
> > > >>>> -      /*
> > > >>>> -       * During the scm call memory protection will be enabled =
for the meta
> > > >>>> -       * data blob, so make sure it's physically contiguous, 4K=
 aligned and
> > > >>>> -       * non-cachable to avoid XPU violations.
> > > >>>> -       */
> > > >>>> -      mdata_buf =3D dma_alloc_coherent(__scm->dev, size, &mdata=
_phys,
> > > >>>> -                                     GFP_KERNEL);
> > > >>>> +      mdata_buf =3D qcom_scm_mem_alloc(size, GFP_KERNEL);
> > > >>>
> > > >>> mdata_phys is never initialized now, and its what's being shoved =
into
> > > >>> desc.args[1] later, which I believe is what triggered the -EINVAL
> > > >>> with qcom_scm_call() that I reported in my cover letter reply thi=
s
> > > >>> morning.
> > > >>>
> > > >>> Prior with the DMA API that would have been the device view of th=
e buffer.
> > > >>>
> > > >>
> > > >> Gah! Thanks for finding this.
> > > >>
> > > >> Can you try the following diff?
> > > >>
> > > >> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/q=
com/qcom_scm.c
> > > >> index 794388c3212f..b0d4ea237034 100644
> > > >> --- a/drivers/firmware/qcom/qcom_scm.c
> > > >> +++ b/drivers/firmware/qcom/qcom_scm.c
> > > >> @@ -556,6 +556,7 @@ int qcom_scm_pas_init_image(u32 peripheral, co=
nst
> > > >> void *metadata, size_t size,
> > > >>                  dev_err(__scm->dev, "Allocation of metadata buffe=
r failed.\n");
> > > >>                  return -ENOMEM;
> > > >>          }
> > > >> +        mdata_phys =3D qcom_scm_mem_to_phys(mdata_buf);
> > > >>          memcpy(mdata_buf, metadata, size);
> > > >>
> > > >>          ret =3D qcom_scm_clk_enable();
> > > >> @@ -578,7 +579,7 @@ int qcom_scm_pas_init_image(u32 peripheral, co=
nst
> > > >> void *metadata, size_t size,
> > > >>                  qcom_scm_mem_free(mdata_buf);
> > > >>          } else if (ctx) {
> > > >>                  ctx->ptr =3D mdata_buf;
> > > >> -                ctx->phys =3D qcom_scm_mem_to_phys(mdata_buf);
> > > >> +                ctx->phys =3D mdata_phys;
> > > >>                  ctx->size =3D size;
> > > >>          }
> > > >>
> > > >> Bart
> > > >>
> > > >
> > > > For some reason that I can't explain that is still not working. It =
seems
> > > > the SMC call is returning !0 and then we return -EINVAL from there
> > > > with qcom_scm_remap_error().
> > > >
> > > > Here's a really crummy diff of what I hacked in during lunch to deb=
ug (don't
> > > > judge my primitive debug skills):
> > > >
> > >
> > > I don't know what you're talking about :-)
> > >
> > > > diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmwar=
e/qcom/qcom_scm-smc.c
> > > > index 0d5554df1321..56eab0ae5f3a 100644
> > > > --- a/drivers/firmware/qcom/qcom_scm-smc.c
> > > > +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> > > > @@ -162,6 +162,8 @@ int __scm_smc_call(struct device *dev, const st=
ruct qcom_scm_desc *desc,
> > > >         struct arm_smccc_res smc_res;
> > > >         struct arm_smccc_args smc =3D {0};
> > > >
> > > > +       dev_err(dev, "%s: %d: We are in this function\n", __func__,=
 __LINE__);
> > > > +
> > > >         smc.args[0] =3D ARM_SMCCC_CALL_VAL(
> > > >                 smccc_call_type,
> > > >                 qcom_smccc_convention,
> > > > @@ -174,6 +176,7 @@ int __scm_smc_call(struct device *dev, const st=
ruct qcom_scm_desc *desc,
> > > >         if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
> > > >                 alloc_len =3D SCM_SMC_N_EXT_ARGS * sizeof(u64);
> > > >                 args_virt =3D qcom_scm_mem_alloc(PAGE_ALIGN(alloc_l=
en), flag);
> > > > +               dev_err(dev, "%s: %d: Hit the unlikely case!\n", __=
func__, __LINE__);
> > > >
> > > >                 if (!args_virt)
> > > >                         return -ENOMEM;
> > > > @@ -197,6 +200,7 @@ int __scm_smc_call(struct device *dev, const st=
ruct qcom_scm_desc *desc,
> > > >
> > > >         /* ret error check follows after args_virt cleanup*/
> > > >         ret =3D __scm_smc_do(dev, &smc, &smc_res, atomic);
> > > > +       dev_err(dev, "%s: %d: ret: %d\n", __func__, __LINE__, ret);
> > > >
> > > >         if (ret)
> > > >                 return ret;
> > > > @@ -205,8 +209,10 @@ int __scm_smc_call(struct device *dev, const s=
truct qcom_scm_desc *desc,
> > > >                 res->result[0] =3D smc_res.a1;
> > > >                 res->result[1] =3D smc_res.a2;
> > > >                 res->result[2] =3D smc_res.a3;
> > > > +               dev_err(dev, "%s: %d: 0: %llu, 1: %llu: 2: %llu\n",=
 __func__, __LINE__, res->result[0], res->result[1], res->result[2]);
> > > >         }
> > > >
> > > > +       dev_err(dev, "%s: %d: smc_res.a0: %lu\n", __func__, __LINE_=
_, smc_res.a0);
> > > >         return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) =
: 0;
> > > >
> > > >
> > > > And that all spams dmesg successfully for most cases, but the
> > > > pas_init_image calls log this out:
> > > >
> > > > [   16.362965] remoteproc remoteproc1: powering up 1b300000.remotep=
roc
> > > > [   16.364897] remoteproc remoteproc1: Booting fw image qcom/sc8280=
xp/LENOVO/21BX/qccdsp8280.mbn, size 3575808
> > > > [   16.365009] qcom_scm firmware:scm: __scm_smc_call: 165: We are i=
n this function
> > > > [   16.365251] qcom_scm firmware:scm: __scm_smc_call: 203: ret: 0
> > > > [   16.365256] qcom_scm firmware:scm: __scm_smc_call: 212: 0: 0, 1:=
 0: 2: 0
> > > > [   16.365261] qcom_scm firmware:scm: __scm_smc_call: 215: smc_res.=
a0: 4291821558
> > > >
> > > > At the moment I am unsure why...
> > > >
> > > Does the issue appear right after taking patch 6 or does it only appe=
ar after taking
> > > the whole series? If it's just to this patch, then maybe something wr=
ong with
> > > the refactor: shm bridge isn't enabled at this point in the series.
> > >
> >
> > I've only been testing the series as a whole on top of a 6.6 based
> > branch, I'm going to try and test some more today to see if just the
> > allocator bits (but not the SHM bridge enablement) works alright for
> > me.
> >
>
> After testing a little more with the fix Bart sent above,
> the allocator refactor seems to work well.
> With "firmware: qcom: scm: enable SHM bridge" applied is when I see the
> errors I pointed out above. All prior patches cause no problems on boot
> for me.
>
> For patches 1-9 (with the fix sent here for patch 6) please feel free
> to add:
>
>     Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thi=
nkpad-x13s
>
> If anyone has suggestions for debugging why the switch to using
> SHM bridge is breaking firmware loading for me, I'm willing to give
> that a try.
>

Is it possible that sc8280xp doesn't support SHM bridge but for some
reason __qcom_scm_is_call_available() returns true when checking if it
does?

That's the only thing that comes to my mind ATM.

Bart
