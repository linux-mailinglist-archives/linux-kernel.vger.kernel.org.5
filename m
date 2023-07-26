Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8128762F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGZITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjGZISV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B82C659B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690358856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doH+Gc+pvfSmMN9JRX0ZHP8FjJCTxeeLb0vPQ04C/z4=;
        b=hHJ/KSp5L1ancLougfDn+x7L+3rheOsFs+8YoAF1bDhmsoiAQ4cS7gOSIlJL1UgdWeIVsb
        Xz54O+GKPfRYycJAV41kZgKhEdXWy4OL3zVLCsdBs5bmf88fr2oYhtWLd2vJmY2X1fmZti
        tQqW8AMm+3ltZUe1j/qH9q77wfA9cDI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-IWrEjwGJMWGbS8l1pLAvaw-1; Wed, 26 Jul 2023 04:07:34 -0400
X-MC-Unique: IWrEjwGJMWGbS8l1pLAvaw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-521dd050a78so4510382a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358853; x=1690963653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doH+Gc+pvfSmMN9JRX0ZHP8FjJCTxeeLb0vPQ04C/z4=;
        b=LBZVqxAcCfvdGnPTTv1O+QpWGE0PP60pN0oDdSRo/N40rHzMEhAWMoHoG/NL7VGvM5
         /Ce3R1HT4LakrUXtx1RmMQcbOHF1Y8HR5mV4pi00wR5VZ5i6Iz9cln4cc8sQU3mYNW8b
         J7c7ExmAjIkCYauUfWLCNnRxp/EDX/rVL1bjgk3F97ql3FnWBsUiEtJ/i1WwfKKF1+7f
         /7295b5XGl8R5zLf/egYAhFSIGQZ++ymNBOSptxWuDwliDW12BpriUrymcJWkU6xXGWK
         2mBb2zJgg451ZyL0y35EXLQGy9zRQOfCY6sN9KdSE77tSzmOcPfBSUl69aNts/NXeWXf
         KpTw==
X-Gm-Message-State: ABy/qLb3pfH4w0MCec6PbFubfsd8u9wL3mFV68xYQvzhz5eR+MXE+xyt
        TbBKwRHKz9l5pAXG/9DdQgMSXDBAsY4HEyI5eR/YPaKmFbENpkD6pGKPiOU5dutM3KJKqxVxRlC
        lZaDgrgGWwxKBogQxEzl8gjaK
X-Received: by 2002:a05:6402:1246:b0:522:5855:ee78 with SMTP id l6-20020a056402124600b005225855ee78mr964862edw.32.1690358853687;
        Wed, 26 Jul 2023 01:07:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2XrWgjm/sLJUUbD9LYlxGifKI8T30aaMlr4mQGKC/gjS5LhzfuV5hHjzYlRuIpESGb6pJgQ==
X-Received: by 2002:a05:6402:1246:b0:522:5855:ee78 with SMTP id l6-20020a056402124600b005225855ee78mr964847edw.32.1690358853344;
        Wed, 26 Jul 2023 01:07:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x5-20020aa7dac5000000b005221fd1103esm5249650eds.41.2023.07.26.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:07:32 -0700 (PDT)
Date:   Wed, 26 Jul 2023 10:07:32 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [RFC 0/3] acpipcihp: fix kernel crash on 2nd resume
Message-ID: <20230726100732.1b9ae446@imammedo.users.ipa.redhat.com>
In-Reply-To: <46437825-3bd0-2f8a-12d8-98a2b54d7c22@gmail.com>
References: <20230725113938.2277420-1-imammedo@redhat.com>
        <88a06e12-600a-a4bd-f216-44753965ce48@gmail.com>
        <20230725171958.1eacd24e@imammedo.users.ipa.redhat.com>
        <46437825-3bd0-2f8a-12d8-98a2b54d7c22@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 11:59:56 -0400
Woody Suwalski <terraluna977@gmail.com> wrote:

> Igor Mammedov wrote:
> > On Tue, 25 Jul 2023 09:51:53 -0400
> > Woody Suwalski <terraluna977@gmail.com> wrote:
> > =20
> >> Igor Mammedov wrote: =20
> >>> Changelog:
> >>>     * split out debug patch into a separate one with extra printk add=
ed
> >>>     * fixed inverte bus->self check (probably a reason why it didn't =
work before)
> >>>
> >>>
> >>> 1/3 debug patch
> >>> 2/3 offending patch
> >>> 3/3 potential fix
> >>>    =20
> >>> I added more files to trace, add following to kernel CLI
> >>>      dyndbg=3D"file drivers/pci/access.c +p; file drivers/pci/hotplug=
/acpiphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; f=
ile drivers/pci/setup-bus.c +p; file drivers/acpi/bus.c +p" ignore_loglevel
> >>>
> >>> should be applied on top of
> >>>      e8afd0d9fccc PCI: pciehp: Cancel bringup sequence if card is not=
 present
> >>>
> >>> apply a patch one by one and run testcase + capture dmesg after each =
patch
> >>> one shpould endup with 3 dmesg to ananlyse
> >>>    1st - old behaviour - no crash
> >>>    2nd - crash
> >>>    3rd - no crash hopefully
> >>>
> >>> Igor Mammedov (3):
> >>>     acpiphp: extra debug hack
> >>>     PCI: acpiphp: Reassign resources on bridge if necessary
> >>>     acpipcihp: use __pci_bus_assign_resources() if bus doesn't have b=
ridge
> >>>
> >>>    drivers/pci/hotplug/acpiphp_glue.c | 23 ++++++++++++++++++-----
> >>>    1 file changed, 18 insertions(+), 5 deletions(-)
> >>>    =20
> >> Actually applying patch1 is already creating the crash (why???), =20
> > probably it's due to an extra debug line, I've added.
> > I dropped suspicions one, can you try again and see if it works.
> > =20
> >> hence I
> >> have added also dmesg-6.5-0.txt which shows a working condition based =
on
> >> git e8afd0d9fccc level (acpiphp_glue in kernel 6.4)
> >>
> >> Patch3 did not fix the issue, it seems that the culprit is somewhere
> >> else triggered by=C2=A0 "benign" patch1 :-(
> >>
> >> Also note about the trigger description in patch3: the dmesg trace on
> >> Inspiron laptop is collected after the first wake from suspend to ram.
> >> The consecutive=C2=A0 attempt to sleep results in a frozen system. =20
> > Thanks for clarification, I'll correct commit message once culprit
> > is found.
> > =20
> Good news. After removing the botched debug statement which was masking=20
> the original issue, the testing went as you have predicted, and on patch=
=20
> 3 system suspends to RAM OK.
Thanks for confirmation,
I'll post cleaned up 3/3 patch today.

>=20
> Here are the requested 3 dmesg outputs, #2 is for the bad run.
>=20
> I can retest with a final version of the patch once you have it ready...
>=20
> Thanks, Woody
>=20

