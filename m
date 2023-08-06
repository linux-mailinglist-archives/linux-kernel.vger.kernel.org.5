Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8067713EF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHFIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:14:53 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B41FC1;
        Sun,  6 Aug 2023 01:14:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76c64da0e46so143104539f.0;
        Sun, 06 Aug 2023 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691309692; x=1691914492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oslzktuLlQuV/9tgiDlABRFZ0qfHlpBYOi45TJmyGLc=;
        b=NS97xhilq3s4K9gvE596eIPyUH6XJ3jAL2zU2p3wZ+cfKxMAHLImT//P4m38V7sCZ6
         vv8nvf+rZYq0QqByOHrhjyW272TdHCaANT4iNBGeKgr8sqFLbwpW/a/OqPs6auAMF9z3
         79aYzKb4uB0HoSFnNoZR7i3p/3wSL8B+7EHaLHyt6UIfW3DMZDCZBnkBxjJEdqQxVO30
         DGDBRrl5JcoAyL2Ziav5Yt35PlOECglhgQvkXqh2DrnAOhHudNk7xt/RIGdusKsmS7H2
         m0NMWbdEkF6YirHhO74fRJOS819AoQCKOOAe7+bR+nzZHNd6hHDz72GSfWldy+X1wXOC
         c2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691309692; x=1691914492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oslzktuLlQuV/9tgiDlABRFZ0qfHlpBYOi45TJmyGLc=;
        b=g/nmhGVnugQeQ1J2V8zDD3D9gKTOPlXiBhvc1BeHXSfw7HSomyMweFTxNqcLA3E9OC
         v2433Gl1mjqV/EdK+z4HBKuFd7iPKTUcwmIsiD9JGammguXHy5U+Nm5fgEicupTR+lV+
         ZDkEHOfhUffWXp79kCC/kCdcOBzYGtvFXD07eQEb0ZTt7d5pnhzSE+m6QA7Xt6v3JaHq
         nXf31+i/yXz/XD7+Crw2powASKbV4DZv3nKv3zBF16izdL21eOi3zdpprtIPETCujReM
         1gO6xCMwvUeoEXID7otNBGwIHg66m93+DlLeohYsRPDtwBnvbUhw4NshjafDjXc3o1mp
         IxPg==
X-Gm-Message-State: AOJu0YxfcN6YO4mwwytFwJI/DY5r5gAXbBhc51qvbZtuQyiGSu7vyePt
        T8lCYmz+kXlP25H4snpK2iW8+S5s0qSSKKwcldI=
X-Google-Smtp-Source: AGHT+IHVc2Fooi3YCjJ9SgBa4bKFKhmqzl4AFAaiBQoPiHD7T07vcjs8HA++6tkd7d3k2lgS0UnRj85G1NAGLWHtTl0=
X-Received: by 2002:a05:6602:254a:b0:783:3899:e1d0 with SMTP id
 cg10-20020a056602254a00b007833899e1d0mr7146880iob.6.1691309691790; Sun, 06
 Aug 2023 01:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230802133509.29381-1-aboutphysycs@gmail.com> <20230805193052.690c87e8@jic23-huawei>
In-Reply-To: <20230805193052.690c87e8@jic23-huawei>
From:   Andrei Coardos <aboutphysycs@gmail.com>
Date:   Sun, 6 Aug 2023 11:14:40 +0300
Message-ID: <CAMu7dgvt0mmQTkL9t1F_NpEBSew+0fa1aQnn=Aw=6FA9KpP2nw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drvdata()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much!

On Sat, 5 Aug 2023 at 21:31, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  2 Aug 2023 16:35:09 +0300
> Andrei Coardos <aboutphysycs@gmail.com> wrote:
>
> > This function call was found to be unnecessary as there is no equivalent
> > platform_get_drvdata() call to access the private data of the driver. Also,
> > the private data is defined in this driver, so there is no risk of it being
> > accessed outside of this driver file.
> >
> > Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> > ---
> >
> > Changelog V1->V2:
> >
> > * https://lore.kernel.org/linux-iio/CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com/T/#t
> > * Adjusted the returning values of the function
> >
> >
> >  drivers/iio/trigger/stm32-lptimer-trigger.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
> > index df2416e33375..ab1cc6a05f26 100644
> > --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> > +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> > @@ -88,11 +88,7 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
> >       priv->dev = &pdev->dev;
> >       priv->trg = stm32_lptim_triggers[index];
> >
> > -     ret = stm32_lptim_setup_trig(priv);
> > -     if (ret)
> > -             return ret;
> > -
> > -     return 0;
> > +     return stm32_lptim_setup_trig(priv);
> Both of us failed to notice ret isn't used any more.  Anyhow, I cleaned that
> up after spotting the build warning.
>
> Jonathan
>
> >  }
> >
> >  static const struct of_device_id stm32_lptim_trig_of_match[] = {
>
