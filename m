Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FEA77F37C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbjHQJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349724AbjHQJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC272724
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:33:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso12398656e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692264834; x=1692869634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfGB3g3RWlk4pTiBzTjkI2NYKqXVPiMYIlgoqN16OM8=;
        b=t+PO8gtMECp+oxq5s5iN81tsfEty6xQLNdrSWafmhVXuNwG7SiHw/xTEYAlhW58xzg
         m8Mlyfqv2YTsEnXgZgTlQQrWkk1WJHUOwvTAcq8V70KTrINUgZk/RzqE9YlBebAyZG1p
         Vgn7yVmM11OXRr52PWOYHkNgX0eVOMoS0wMq+oT3bDXnlTT4etp96T4gW1iLFaSKfomG
         SAmysKoBN1oxf3r7JX6mtMpWQXf50AQlgDTXvEcQhbs/WCn66ln0NpWY7DuG6mVprA5Q
         qZ5c5HZk7JUHQxHl040vxQ7UA99FMZcfLBapmDoqG21QRsWFnHpFvj4U95cA0MsaShJp
         6rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264834; x=1692869634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfGB3g3RWlk4pTiBzTjkI2NYKqXVPiMYIlgoqN16OM8=;
        b=N7dL20NapBs7Lzn1ePlRe/wAspzLyg9HII06sqwmo6ws3eLgBVJyFGhgHVRyZPDe8U
         BAjxZ1GfCBI5FaCA5qtwCFbD/qAWjT+GtjDfE9FWZ0gLFdtLR9a8OrWFaPe/DvVx+iK+
         HjwZVE7wWRXDdy/wwMoKl76UlpZf+AF82I/6EB8fphXCYUNLOwBfR5QYitja/eHZK+NQ
         PNitHXUeTxBqRA4UITNrVC9oN06gDgQg8YYjv13Tw+OhB6fwhZcioHwHvdOxU0pYBw5h
         80pKjftxNPHKymwLPwq7Mv4mvkOhP7/PF9n68Hsami+sn3HuHzeDgkhFXU7VhPSuYXwW
         lT8Q==
X-Gm-Message-State: AOJu0YzHyagFWS4ispcqfb8/UVEE4rzuMlJRE4iZmnn2bc2t0aNeadls
        0HOxeVBj5tmuIrjy9mhtWZm1HakmYalh/E5ewktkjw==
X-Google-Smtp-Source: AGHT+IHfwj0i9uwfsgg6RcvInzE5lmZuYzRbrI/+YwW9XzvSMq0JWWwQwmdWSh7u93nH7lqnmirF5j/IW/j0/PMq39g=
X-Received: by 2002:a05:6512:3c87:b0:4fb:8a0a:31f2 with SMTP id
 h7-20020a0565123c8700b004fb8a0a31f2mr4353093lfv.69.1692264833831; Thu, 17 Aug
 2023 02:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
 <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com> <CADQ0-X_dJag7EuEEEgCZrnJNNH9Va77mxmGYA9vPFw9DkoB-AA@mail.gmail.com>
 <CAC_iWjLzaSBz3_j=rz73QLCBX_YouCL+KBvR7sXMFFMQA3pOPg@mail.gmail.com>
 <1fd4b729-3896-48b6-865e-85b4f1ba5ee9@siemens.com> <CAFA6WYMekJC8dOUU-d7DJDK6fiUh27sWw8xbVMvFGmBe8VYxLA@mail.gmail.com>
In-Reply-To: <CAFA6WYMekJC8dOUU-d7DJDK6fiUh27sWw8xbVMvFGmBe8VYxLA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 17 Aug 2023 12:33:17 +0300
Message-ID: <CAC_iWjJ5Sw8YtLYnqaJfwrqsrV3vAKv0VHYL2uyGxttsg-TNHQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 12:22, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 16 Aug 2023 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 16.08.23 13:58, Ilias Apalodimas wrote:
> > > On Tue, 15 Aug 2023 at 05:41, Masahisa Kojima
> > > <masahisa.kojima@linaro.org> wrote:
> > >>
> > >> Hi Jan,
> > >>
> > >> 2023=E5=B9=B48=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:23 Jan Kiszka <jan.k=
iszka@siemens.com>:
> > >>>
> > >>> On 14.08.23 11:24, Ilias Apalodimas wrote:
> > >>>> Hi Jan,
> > >>>>
> > >>>> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@lina=
ro.org> wrote:
> > >>>>>
> > >>>>> This series introduces the tee based EFI Runtime Variable Service=
.
> > >>>>>
> > >>>>> The eMMC device is typically owned by the non-secure world(linux =
in
> > >>>>> this case). There is an existing solution utilizing eMMC RPMB par=
tition
> > >>>>> for EFI Variables, it is implemented by interacting with
> > >>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC dri=
ver
> > >>>>> and tee-supplicant. The last piece is the tee-based variable acce=
ss
> > >>>>> driver to interact with OP-TEE and StandaloneMM.
> > >>>>>
> > >>>>> Changelog:
> > >>>>> v7 -> v8
> > >>>>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated=
.
> > >>>>> - fix typos
> > >>>>> - refactor error handling, direct return if applicable
> > >>>>> - use devm_add_action_or_reset() for closing of tee context/sessi=
on
> > >>>>> - remove obvious comment
> > >>>>
> > >>>> Any chance you can run this and see if it solves your issues?
> > >>>>
> > >>>
> > >>> I also need [1], and I still need a cleanup script before terminati=
ng
> > >>> the tee-supplicant, right?
> > >>
> > >>
> > >> Yes, we need patch[1] and a cleanup script.
> > >> Sorry, I should note in the cover letter.
> > >>
> > >>> And if need some service in the initrd
> > >>> already, I still need to start the supplicant there and transfer it=
s
> > >>> ownership to systemd later on?
> > >>
> > >> Yes.
> > >>
> > >>> These patches here only make life easier
> > >>> if the supplicant is started by systemd, after efivarfs has been
> > >>> mounted, correct?
> > >
> > > Not systemd specifically.  Any tool that can signal
> > > <dev>/driver/unbind would work.  Sumit is just reusing the default
> > > unbind notification mechanism
> > >
> >
> > I was referring to the boot ordering topic, not the shutdown issue.
> >
> > The latter has now a nicer way to trigger the device shutdown prior to
> > killing tee-supplicant, but you still need to do that explicitly, no?
> >
>
> Yeah it has to be done explicitly in user-space. As you have already
> seen, my first try (v1 patch) to do it in kernel space failed. The
> reason being that when those devices are being removed, the
> tee-supplicant has to be alive to handle RPC calls. The kernel only
> gets notified once "/dev/teepriv0" fd is closed and by that time
> tee-supplicant is already dead.

Yea, that was along the lines of what I asked in a past mail.  IOW
bind the cleanups needed on the opening/closing of the
"/dev/teepriv0", but unfortunately that's not doable.  What we could
do as a future enhancement is add a signal handler in the supplicant
that signals the events without relying on a different userspace app
to do that.

Sumit pointed out a few things we need to be cautious about on the
signal handler, but in any case, that's orthogonal to the current
approach.

Thanks
/Ilias

>
> -Sumit
>
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Linux Expert Center
> >
