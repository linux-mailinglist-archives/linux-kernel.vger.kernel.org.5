Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919477E0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbjHPL7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbjHPL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:59:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229412121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:59:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so10391622e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692187164; x=1692791964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrjzBslgbGZ9bpoeR45JjTw7/ZPEgHiY5QlVRz4wxmY=;
        b=byoKrU0IUP+TaIMLiMyhcIyk1V1HBEjmnpAtmkfMzWgdZso5dlKv+oDH3x4L9mBqFI
         FQ9YOP6Iakhr8OApjsTtVuD8osKnDREiuXHvumZMEH92KThwJqrpE836XzWxzBqtpXZd
         Kko5RiFXa4XKp25MGIMW360SzAv5Gzu5h2CRP1PLa2/RKhYlzYQC+lQ6Dx9QRFk0eWDv
         F2yOYXd7Ug657uawd7kk2Zt3gnVL3LdsqmFyPjocTBg0pIAyZ4F5nPgogXaXM2E2anj/
         8AUfFeIMp1KeqR5sImtDiqYSQc8r6Xle82EsKaBrilDDK3LmTlwvqCLcPq8qChQZO4iu
         1TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692187164; x=1692791964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrjzBslgbGZ9bpoeR45JjTw7/ZPEgHiY5QlVRz4wxmY=;
        b=GlFtWTP54VWmIT/5620u9L5d5nNKbHQgn8FNj/wqbViCA0YXziJq2Kj8+E9exKebBh
         dfnPAvYrDYVPLBeGcNW5lr5dwuKYYvWXtYE3jP4gkOG0x9XyqZGVSrWJd9ssD1r2ZO5Q
         SB+K9MlRYVwSRMGD1WP5TeEKWJ9sAIPS26nMB/3B3U5Xfvn0OfCBjyPUQM0aU+xhHb0Z
         KzyXoKbK33GTGumvzzbcPw4DokFoQJFMCFH8Xhd/I2AbJCKrFMzcl9SgAb9tHOgkNm61
         j+jFLq7l93HOisLd1LHZpO8k+veweW8K5lUqq+hHnx6sd73pcnofDL9/C0kUNxw+9Uzc
         v0Sg==
X-Gm-Message-State: AOJu0Yw/7sM84HzGRAmAH4C04A/fKIVZ3mSmqfZ6MiXrd+1yEYa2FA7T
        mRFd8JDJR8rpUwuOxWgSsXtQw8bzalvNNREB7OxTqQ==
X-Google-Smtp-Source: AGHT+IHkPw8Z++C0XeOANREQGb/F7aTBQn7hukjOj1Q/g0vsdie6QkT2t9Q5MEPUmJnDQxadMFjU/AVAIqYDipvMyok=
X-Received: by 2002:a19:8c01:0:b0:4fb:9105:58b0 with SMTP id
 o1-20020a198c01000000b004fb910558b0mr1240905lfd.20.1692187164381; Wed, 16 Aug
 2023 04:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
 <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com> <CADQ0-X_dJag7EuEEEgCZrnJNNH9Va77mxmGYA9vPFw9DkoB-AA@mail.gmail.com>
In-Reply-To: <CADQ0-X_dJag7EuEEEgCZrnJNNH9Va77mxmGYA9vPFw9DkoB-AA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 16 Aug 2023 14:58:48 +0300
Message-ID: <CAC_iWjLzaSBz3_j=rz73QLCBX_YouCL+KBvR7sXMFFMQA3pOPg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 05:41, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Jan,
>
> 2023=E5=B9=B48=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:23 Jan Kiszka <jan.kiszka=
@siemens.com>:
>>
>> On 14.08.23 11:24, Ilias Apalodimas wrote:
>> > Hi Jan,
>> >
>> > On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro.o=
rg> wrote:
>> >>
>> >> This series introduces the tee based EFI Runtime Variable Service.
>> >>
>> >> The eMMC device is typically owned by the non-secure world(linux in
>> >> this case). There is an existing solution utilizing eMMC RPMB partiti=
on
>> >> for EFI Variables, it is implemented by interacting with
>> >> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>> >> and tee-supplicant. The last piece is the tee-based variable access
>> >> driver to interact with OP-TEE and StandaloneMM.
>> >>
>> >> Changelog:
>> >> v7 -> v8
>> >> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
>> >> - fix typos
>> >> - refactor error handling, direct return if applicable
>> >> - use devm_add_action_or_reset() for closing of tee context/session
>> >> - remove obvious comment
>> >
>> > Any chance you can run this and see if it solves your issues?
>> >
>>
>> I also need [1], and I still need a cleanup script before terminating
>> the tee-supplicant, right?
>
>
> Yes, we need patch[1] and a cleanup script.
> Sorry, I should note in the cover letter.
>
>> And if need some service in the initrd
>> already, I still need to start the supplicant there and transfer its
>> ownership to systemd later on?
>
> Yes.
>
>> These patches here only make life easier
>> if the supplicant is started by systemd, after efivarfs has been
>> mounted, correct?

Not systemd specifically.  Any tool that can signal
<dev>/driver/unbind would work.  Sumit is just reusing the default
unbind notification mechanism

Thanks
/Ilias

>
> Yes.
>
> Thanks,
> Masahisa Kojima
>
>>
>>
>> Jan
>>
>> [1] https://lkml.org/lkml/2023/7/28/853
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center
>>
