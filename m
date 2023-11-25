Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B577F88C2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjKYHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:12:57 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F119E;
        Fri, 24 Nov 2023 23:13:03 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1957245a12.1;
        Fri, 24 Nov 2023 23:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700896383; x=1701501183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtqF80WLttDzEODiE7Bbxwbs4nxVZwokhMgPSxT4dEQ=;
        b=Ar87xtHNaH5PRnurB85K1IGNMyzXYQ6VT8QUM+0BHDi/8Z5pQCD2qUJkZXQrhl1RsZ
         96ZGgKnHVYwRG0V1G8NYWrR0MZRK4Eu7HP3xYX0ulKKSdoU6rvrJ2h0GnEkUIQqwfREr
         0zhgh8r/hCiuYSnOjxKAbjuOOuhIzmWmzg4GBZKXu7J/VDppB4IaR2nSPpZ9o5/ecRem
         MGhlIlP1HNxnT3RUKg9+GwXd8hy7xoGnb4HzprBUa93JVitshy2vg3qVZYeIbU4ht5iN
         fohqjA58meN4L+t2iP/YXCXcmO7j2WddyC2SOig3/WJqpJ6IM6V3c7qs6UhMC67X0xhY
         c5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700896383; x=1701501183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtqF80WLttDzEODiE7Bbxwbs4nxVZwokhMgPSxT4dEQ=;
        b=bwYZqGbmL8pONjWoIt2O7zfNsUVMPDWb9ILZ1jsAyLqc+7ccf6Nm4lNZwvvnLxdm+/
         +gZjruAo3N/++AqNw6N86qqStCyGcbnLFV0cs1MnuywnoaP4CzJnTMfhYy7U07/a5iDs
         qZFTUNF3CVpDx/N0Ak6abeXCGMUySCoxM+rssoy9dzCLyaRtFWiKn6HVe2lGamGhpqQg
         +fnNAeRlHfv8hQniwoWATUXZ4QwV530Ceax7qAd9OJjkYzLpI48Masa6rjEEU6UJ7fxM
         N8tFDKuQYPxtNCJCeU5M0fuC24B1JHQGt1sOingZxpI0WnfW4oczw1bkqOv1xogb9wgn
         +8zQ==
X-Gm-Message-State: AOJu0YzCy6nkA94ifcp+dmMVXNPcu59L8OFevaVKdRcfjDtrMexOsIY/
        UbJZZqHAGdUdgrABwvY0xnBsdgMGrY8ae+KBH1CUf5alCapQiwZt
X-Google-Smtp-Source: AGHT+IGaNH7fS0iuKiLVJx9efwqeQT0c6EltM7hmQCQVaOg6Ga0b0I2i4sPz23HYXj4pfnwwRDx401MO2Xi0yrlkjfc=
X-Received: by 2002:a17:90b:1d09:b0:280:c98f:2090 with SMTP id
 on9-20020a17090b1d0900b00280c98f2090mr6878396pjb.32.1700896382977; Fri, 24
 Nov 2023 23:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20231122161304.12434-1-ghanshyam1898@gmail.com> <ZWEj5sDUs83qn0pc@equinox>
In-Reply-To: <ZWEj5sDUs83qn0pc@equinox>
From:   Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date:   Sat, 25 Nov 2023 12:42:26 +0530
Message-ID: <CAG-BmodoZyi50XK-pQ=YPZ-q6BLKCbwSpck7jn=dgRsXVQxUwA@mail.gmail.com>
Subject: Re: [PATCH V2] media: stk1160: Fixed high volume of stk1160_dbg messages
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 4:00=E2=80=AFAM Phillip Potter <phil@philpotter.co.=
uk> wrote:
>
> On Wed, Nov 22, 2023 at 09:43:04PM +0530, Ghanshyam Agrawal wrote:
> > The function stk1160_dbg gets called too many times, which causes
> > the output to get flooded with messages. Since stk1160_dbg uses
> > printk, it is now replaced with dev_warn_ratelimited.
> >
> > Suggested-by: Phillip Potter <phil@philpotter.co.uk>
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> > v2:
> > Thanks for your suggestions Phillip. I have updated the TODO comment an=
d
> > used dev_warn_ratelimited for inclusion of kernel warning.
> >
> >  drivers/media/usb/stk1160/stk1160-video.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/=
usb/stk1160/stk1160-video.c
>
> Hi Ghanshyam,
>
> Thank you for the patch, but it is sadly incorrect.
>
> You have created this V2 against a tree including the V1 version of your
> patch. A V2 patch should apply cleanly against the source tree, with no
> previous version first needing to be applied.
>
> On another note, why are you using dev_warn_ratelimited here, and if
> there's a good reason, why not use it for the other callsites in this
> function? (Genuine question here, I've not studied the difference).
>
> Please create a V3, many thanks.
>
> Nacked-by: Phillip Potter <phil@philpotter.co.uk>
>
> Regards,
> Phil

Hi Phillip,

Thank you for taking time to review my patch.

I will fix the issue with my patch needing previous versions being applied
first.

I had used dev_warn_ratelimited because the checkpatch script mentioned
a sequence of priorities to use various logging functions and
dev_warn_ratelimited had higher priority. But now I have found other issues
with using this function here, so I will switch back to printk_ratelimited.

Let me fix the issues and submit a V3 patch. Thanks again for your time
and kind suggestions.

Regards,
Ghanshyam Agrawal
