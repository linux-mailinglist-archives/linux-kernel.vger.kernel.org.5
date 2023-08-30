Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7578DFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbjH3TPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbjH3NYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC4137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc83a96067so34672365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693401843; x=1694006643; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl5m/u5DBSkuFPju71gMtPySMQtwHuHyHO7Z+IRR/0E=;
        b=dwZjoA+X0AzMhWhp4T4B6ecuH6cdhSkFZaHm9TTe6Ourx7gEru//EPLF3Sgg8gh3vW
         yiUbAwEUwyvlJjyg3v6EfP3/ihwbQ6O1LxIzfQEhEleWq6Un/QXDM1hi6XqUQbl6pwt1
         Lk2eGnUZ7QFqnnQJYsVbngOFC9+Ff4eM0TiGNaO4zw/9enU9fN1qxQSMTjzHWm2HScCH
         pkgNLITINbtdsgPezAxItzXfGyuhjj9GLosbmx5SXcJcXwuTSWSUdXGb3N/NMA2C0VkG
         k9VmMak7lZ3I+FYH+n3K4d4EcFWYigaMNUcqqatshoEHTuzBO9YWALfmIkrrwBTrJxpr
         WYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401843; x=1694006643;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl5m/u5DBSkuFPju71gMtPySMQtwHuHyHO7Z+IRR/0E=;
        b=GhPjRywzs/UMzum3TYYFeUqqwIeThHTPNjxp129oBTgRiFUsHTHPmja5QHm/At1bZb
         9EeWrL3D8JcoURNPTG0gvuo+yAMGSMjK1E4lAkBrBUIpnTu2GWzaOmKnjJ0qt3MKIpqS
         jXI9393a0Iw7gUoEexCOUAvEts67ONwLt+Uq6ueiGRuGPDSKlEpu+wN2vaWmveVn+8/M
         0CJL0tMZ5siaTo/HjF+4W8noYxWiS187oy0dcSsN9hpAedVFjStSvr7YjBN3lhrgpGLl
         00+l2lvc9zMXTvhIv97Wk92DBzymfuF9qLr2le6pST/nxRcOPhWtDb0ZG1QTdad7/ai4
         gc7Q==
X-Gm-Message-State: AOJu0YwQVgoPKNMd3qkxdgIuehnK9E4pxG1/auejn3DQruekGdOZ3WUm
        u02Veh5rTBV+FTYzwlGYlxc=
X-Google-Smtp-Source: AGHT+IHvPjbC6cQ6R7dwzx5G8ASsbdBYGcjoPd4otAgobSujUbK+P1uF8x96ng8HnaiZoyXjPKfupw==
X-Received: by 2002:a17:903:444:b0:1c0:b17a:7554 with SMTP id iw4-20020a170903044400b001c0b17a7554mr1640671plb.64.1693401842513;
        Wed, 30 Aug 2023 06:24:02 -0700 (PDT)
Received: from [127.0.0.1] ([103.135.102.124])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001c0a4146961sm11148028plb.19.2023.08.30.06.24.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:24:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1] firmware: arm_scmi: Fix NULL pointer dereference in
 mailbox_clear_channel
From:   Qiujun Huang <hqjagain@gmail.com>
In-Reply-To: <20230830093902.duvvjimgwddh7qbt@bogus>
Date:   Wed, 30 Aug 2023 21:23:58 +0800
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F59FC6AB-40E6-4BBA-A0BD-C7221160854B@gmail.com>
References: <ED5DC8DB-AE81-4380-8AE5-588F370CD4B0@gmail.com>
 <20230830093902.duvvjimgwddh7qbt@bogus>
To:     Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B48=E6=9C=8830=E6=97=A5 =E4=B8=8B=E5=8D=885:39=EF=BC=8CSudeep=
 Holla <sudeep.holla@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Aug 30, 2023 at 01:07:47AM +0800, Qiujun Huang wrote:
>> There is a race between the failure of probe and rx_callback (due to =
a
>> delayed response).
>>=20
>> scmi_probe
>> scmi_acquire_protocal
>> do_xfer
>> timeout
>> mailbox_chan_free
>>                                                    <--- delay =
response
>>                                                           rx_callback
>> mbox_free_channel
>> cinfo->transport_info =3D NULL
>>                                                          =
mailbox_clear_channel
>>                                                         dereference =
cinfo->transport_info
>=20
> It is always good to provide the kernel stacktrace which you get when =
a
> NULL pointer is dereference. It helps for review and also to document =
it.
>=20
> --=20
> Regards,
> Sudeep

Get it. Here is the splat.

[    1.942240][    C0] Unable to handle kernel NULL pointer dereference =
at virtual address 0000000000000048
[    1.942241][    C0] Mem abort info:
[    1.942243][    C0]   ESR =3D 0x96000005
[    1.944888][    T9] spmi spmi-1: PMIC arbiter version v7 (0x70000000)
[    1.950652][    C0]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    1.950653][    C0]   SET =3D 0, FnV =3D 0
[    1.950654][    C0]   EA =3D 0, S1PTW =3D 0
[    1.950656][    C0] Data abort info:
[    1.950657][    C0]   ISV =3D 0, ISS =3D 0x00000005
[    1.950658][    C0]   CM =3D 0, WnR =3D 0
[    1.950660][    C0] [0000000000000048] user address but active_mm is =
swapper
[    1.950663][    C0] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    2.338929][    C0] pc : mailbox_clear_channel+0x18/0x64
[    2.344384][    C0] lr : scmi_handle_response+0x17c/0x4f4
[    2.349923][    C0] sp : ffffffc010003db0
[    2.354045][    C0] x29: ffffffc010003dc0 x28: ffffffd85263f000=20
[    2.360216][    C0] x27: ffffffd851621068 x26: ffffffd84ec815c8=20
[    2.366386][    C0] x25: ffffffd85263bf80 x24: ffffffd85263d230=20
[    2.372556][    C0] x23: ffffff803cd70cc0 x22: 0000000000000008=20
[    2.378726][    C0] x21: ffffff8036cf0df8 x20: ffffffd85161bac8=20
[    2.384896][    C0] x19: ffffff8043ffa580 x18: ffffffc010005050=20
[    2.391065][    C0] x17: 0000000000000000 x16: 00000000000000d8=20
[    2.397234][    C0] x15: ffffffd8507965e8 x14: ffffffd84eaebdf0=20
[    2.403404][    C0] x13: 00000000000001ea x12: 0000000000007ffb=20
[    2.409574][    C0] x11: 000000000000ffff x10: ffffffd852c5a000=20
[    2.415744][    C0] x9 : d7be1a9b75f29500 x8 : 0000000000000000=20
[    2.421914][    C0] x7 : 382e31202020205b x6 : ffffffd852c57e7c=20
[    2.428084][    C0] x5 : ffffffffffffffff x4 : 0000000000000000=20
[    2.434254][    C0] x3 : ffffffd84eae6668 x2 : 0000000000000001=20
[    2.440424][    C0] x1 : 0000000000000000 x0 : ffffff8043ffa580=20
[    2.446594][    C0] Call trace:
[    2.449819][    C0]  mailbox_clear_channel+0x18/0x64
[    2.454916][    C0]  scmi_handle_response+0x17c/0x4f4
[    2.460100][    C0]  rx_callback+0x60/0xec
[    2.464311][    C0]  mbox_chan_received_data+0x44/0x94
[    2.469584][    C0]  qcom_rimps_rx_interrupt+0xc0/0x144 [qcom_rimps]
[    2.476111][    C0]  __handle_irq_event_percpu+0xa0/0x414
[    2.481652][    C0]  handle_irq_event+0x84/0x1cc
[    2.486393][    C0]  handle_fasteoi_irq+0x150/0x394
[    2.491403][    C0]  __handle_domain_irq+0x114/0x1e4
[    2.496500][    C0]  gic_handle_irq.33979+0x6c/0x2b8
[    2.501597][    C0]  el1_irq+0xe4/0x1c0
[    2.505537][    C0]  cpuidle_enter_state+0x3a4/0xa04
[    2.510634][    C0]  do_idle+0x308/0x574
[    2.514661][    C0]  cpu_startup_entry+0x84/0x90
[    2.519402][    C0]  kernel_init+0x0/0x310
[    2.523611][    C0]  start_kernel+0x0/0x648
[    2.527908][    C0]  start_kernel+0x52c/0x648
[    2.532390][    C0] Code: f800865e a9017bfd 910043fd f9400808 =
(f9402508)=20
[    2.539360][    C0] ---[ end trace da7fdd5fdd7f7f09 ]---
[    2.550088][    C0] Kernel panic - not syncing: Oops: Fatal exception =
in interrupt


- - -
thanks

