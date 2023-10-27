Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0E7D9949
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJ0NGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:06:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326DC2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:06:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507ad511315so3022120e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698412001; x=1699016801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nu2VeM2bpbDZ39w77ii5UziGxcyQWjBjZDE8cV/yDQg=;
        b=wjOf78Vz/+v4VLw8gmoqPb0fgK9quPH/fdVtmUd8C0qOOqlCxqvcExN3znyTTuIyLP
         uu32t3KeEhOPpioraohdHxfqVCtiOEqqTt+HB6S1hwwHhztCE8C/fZbzzva5DRB5s8jr
         4blKhvkGpiS+SEcH2SgYNib/9ETBsDANOnosYc0gLXjwv0Vhf70WEr4MLEeuLOi4SArv
         EARORJeDO7EW1qerutdvczHY9H/AGUEwlyeeEGei2N6l7TCV3fNk6dvjcU1R4X89iFXY
         28aemiVyFpEm0C8ABzxATdKUFxndvSbs7gGRExpSQ9+WaXFwY93mre+0IQ/lO4Rlbto9
         fExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412001; x=1699016801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nu2VeM2bpbDZ39w77ii5UziGxcyQWjBjZDE8cV/yDQg=;
        b=mipjsFWE6ADhryx4K/Gz9NHAb4kfA8c9QBUEa/ng30JladIawvTi3SbyRMCIy8i1Qs
         FpealbvEepJrJXDuWOW7DeynoqUjzsvdopQUlbIE5P8lHuVbYXZ9llM/Qz95s09WZKXg
         u0lzs4oH+xw/VPV6TKyyuytY63rQak6o6RYMDhWP6LKxK5ybMV/158JB+EEkr83Hj7GS
         wrZAUJ7wZmxiEO/AQlouFqZ1vReTqP2yCYV41LdUjIiXTuxpca975o8BddoUqwEqZ7h1
         g8xEP0UHeldlZ00HHWUqyAXpX3haSLM74xDAWPJasMMv+lTe16SkedZBcvUVzXHOL/bm
         vz6Q==
X-Gm-Message-State: AOJu0YxPx51cpJrdxRb31tbp2i6KGGnt7Kv7WagFHJpWTo1HUiN+57Yf
        XVNjo1EJYMSMJN+sdCaPHsZL6Uz9xX0QkkWqa24o7g==
X-Google-Smtp-Source: AGHT+IEBLB2nN/ef9pZBgy3RFNNpqxfjiMoZeDEQUi7lkPIQV2IRHWZurGb23aTa3oeQMaODmGmRyfcYqLEa9OzF2sY=
X-Received: by 2002:a05:6512:3d8f:b0:507:b099:749d with SMTP id
 k15-20020a0565123d8f00b00507b099749dmr2027161lfv.15.1698412000897; Fri, 27
 Oct 2023 06:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <ZS_C7ej5jDNICLkA@hera> <CADQ0-X8fEUw2pkeWRKGsYs8cNfDnyM=ibj9emZ5Q0zL9btdz=A@mail.gmail.com>
In-Reply-To: <CADQ0-X8fEUw2pkeWRKGsYs8cNfDnyM=ibj9emZ5Q0zL9btdz=A@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 27 Oct 2023 16:06:04 +0300
Message-ID: <CAC_iWjLQPL1a8Zu38+98PgDO8mGzZ=WzCaQxab9bZDrRJNTL7g@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] introduce tee-based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kojima-san,

Thanks for looking into this

On Fri, 27 Oct 2023 at 10:27, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 18 Oct 2023 at 20:35, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Kojima-san,
> >
> > I found some time to do some extended testing here's what I found
> >
> > Switching the permissions from RO->RW when the supplicant is started works
> > correctly
> > # mount | grep efiv
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
> > # tee-supplicant -d
> > [   77.374878] efivars: Unregistered efivars operations
> > [   77.381604] Use tee-based EFI runtime variable services
> > [   77.386862] efivars: Registered efivars operations
> > # mount | grep efiv
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
> > I didn't test unbinding yet, but I assume it's going to work fine and
> > remove the efivar ops.
> >
> > Reading an writing non-authenticated EFI variables seems to work fine.
> > I verified this with U-Boot and the BootOrder changed correctly.
> > # efibootmgr -o 0001,0002,0000
> > BootCurrent: 0002
> > BootOrder: 0001,0002,0000
> > Boot0000* nvme 0:1
> > Boot0001* nvme 0:2
> > Boot0002* debian
> > # efibootmgr -o 0002,0000,0001
> > BootCurrent: 0002
> > BootOrder: 0002,0000,0001
> > Boot0000* nvme 0:1
> > Boot0001* nvme 0:2
> > Boot0002* debian
> >
> > Writing authenticated EFI variables works the first time.
> > I also dumped those variables from both Linux and U-Boot and they matched
> > # efi-updatevar -f PK.auth PK
> > # efi-updatevar -f KEK.auth KEK
> > # efi-updatevar -f db.auth db
> >
> > But removing the PK at runtime fails.
> > # efi-updatevar -f noPK.auth PK
> > # Failed to update PK: Operation not permitted
> > My guess is that the EDK2 code prohibits that, but we need to check why
> > this is happening.  I also got similar failures trying to update KEK and db.
>
> "# efi-updatevar -f noPK.auth PK" does not reach the kernel efivarfs code.
> With strace, error occurs when efi-updatevar tries to open
> /sys/firmware/efi/efivars/KEK-*** file.
> I guess O_TRUNC option in open() is not required?
>
> openat(AT_FDCWD,
> "/sys/firmware/efi/efivars/KEK-8be4df61-93ca-11d2-aa0d-00e098032b8c",
> O_RDWR|O_CREAT|O_TRUNC, 0644) = -1 EPERM (Operation not permitted)
> write(2, "Failed to update KEK: ", 22Failed to update KEK: )  = 22
> write(2, "Operation not permitted\n", 24Operation not permitted
> ) = 24
> exit_group(1)                           = ?
> +++ exited with 1 +++
>
> We can use "efivar" instead to remove the keys. It also works for KEK and db.
> # efi-updatevar -f PK.auth PK
> # efi-updatevar -f noPK.auth PK     <--- it does not work
> # efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
> <--- it works

Ok, that's fine then

>
> >
> > But the most worrying thing is this. From Linux program KEK and db
> > # efi-updatevar -f KEK.auth KEK
> > # efi-updatevar -f db.auth db
> >
> > Reboot the machine and U-Boot complains when it tries to populate the
> > runtime vars with:
> > Loading Linux 6.6.0-rc2-00654-g82a013b37495 ...
> > Loading initial ramdisk ...
> > EFI stub: Booting Linux Kernel...
> > EFI stub: Using DTB from configuration table
> > EFI stub: Exiting boot services...
> > Can't populate EFI variables. No runtime variables will be available <-- This
>
> I could not reproduce this issue.
> I tried the following command then reboot the board. Linux boots fine.
>  # efi-updatevar -f KEK.auth KEK
>  # efi-updatevar -f db.auth db
>
> I also enroll the PK, then UEFI secure boot works.
> Signed grub and signed kernel boot in UEFI secure boot enabled.
>
> Are there any additional steps to reproduce?

Hmm, how big is that db? I think I have 2 signatures in mine, a custom
one and the MS one.
Can you test again with these certs [0]

[...]

[0] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/blob/master/meta-trustedsubstrate/uefi-certificates/uefi_certs.tgz?ref_type=heads

Thanks
/Ilias
