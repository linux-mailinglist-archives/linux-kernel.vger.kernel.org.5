Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4212F7BA038
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjJEOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjJEOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:22 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDEF72B3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:02:56 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd7139aa57so413834fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696489375; x=1697094175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sykav7kHqqi8q7/u6IWk2uLR08rKtlD8qNcinnjqeE=;
        b=EK3LQLq2BSoHaJfCXYvCINOxMNAd5CDOeIfd6HdoUSpoJM9Pf/mtQiaKpxALLmv4WJ
         TDzJHA1fSovX3qu4DorOfeOHWFf2ldAVRJNBb2i+Unixm5qFm1JreiS6sOc9DffUO67D
         tda1FErfEqiVjtYnuvLI9tV6z1O79o97vG/4YCbmIAbF/ubLYwvLfWoSrIz96+CilOrC
         TkCW1Oghw3JTNkT1nAwYb1iwrA3sab7jLI9F3LxkWPU3Xj3hbRpD5oEH6xZ2w42+gp1/
         UryWBt3xuZiEgS9XoD4fcx3OAQ5X0uNOzGFzJoU+dy+STuO5Odisjh7O8lOvN8ADgxNV
         3wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489375; x=1697094175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sykav7kHqqi8q7/u6IWk2uLR08rKtlD8qNcinnjqeE=;
        b=CISXj3dLzbAeE5Vc3fvNIny5KWEsIH2NVynDgy9bWrwMg4mWb3WRJL3grN/uQIttJs
         iIdCb3lGdHs2FYYWgwKfU/FbRGuDY30eQvA4grbDgDUEYr87ecAoC8V0hmRKQEgbSCb3
         4jD3nEA1bj0VC4ns6XbjU7g8jPOGSviS7/OQQjza3dgQewu9mHdy9vzumxx4E3kcQ0I4
         YBLe2m+dEf29a2znEHLNL1/aBginByte0EXWB1iWA9O7y13H4si183ZkhPTMwCacVF5z
         vk8NfeExANwBicJ0Cf9CMkg7gpxDHJ/rtxIgADYuUpJr62+WVayXJI8t8preeDV0zw80
         n6qQ==
X-Gm-Message-State: AOJu0YwjBpWfKVidRbIVPMOe6ltVTD3afSuJJwStId50CGFnHdZ5eM+F
        mHt56LuKv9ubO87KlVD06365MtiT1gdAWl3B8dBJUQ==
X-Google-Smtp-Source: AGHT+IEohgIk5UquNb/UwnJ5C2hvcdK98D8tmyk7HEt7s924VZVpqhRHV2s1uYLWOC8Y/4LxNPQ3sYtYYNYJ/BjIuxs=
X-Received: by 2002:a05:6870:c195:b0:1be:ffae:29a3 with SMTP id
 h21-20020a056870c19500b001beffae29a3mr4873386oad.23.1696489375332; Thu, 05
 Oct 2023 00:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
In-Reply-To: <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
From:   Mattias Nissler <mnissler@rivosinc.com>
Date:   Thu, 5 Oct 2023 09:02:44 +0200
Message-ID: <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     cz172638@gmail.com, bhelgaas@google.com,
        Jagannathan Raman <jag.raman@oracle.com>, kishon@kernel.org,
        kvijayab@amd.com, kw@linux.com, levon@movementarian.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        robh@kernel.org, thanos.makatos@nutanix.com, vaishnav.a@ti.com,
        william.henderson@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 3:31=E2=80=AFAM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> Hi Jiri, Mattias and all.
>
> 2023=E5=B9=B410=E6=9C=884=E6=97=A5(=E6=B0=B4) 16:36 Mattias Nissler <mnis=
sler@rivosinc.com>:
>>>
>>> hi shunsuke, all,
>>> what about vfio-user + qemu?
>
> Thank you for the suggestion.
>
>> FWIW, I have had some good success using VFIO-user to bridge software co=
mponents to hardware designs. For the most part, I have been hooking up sof=
tware endpoint models to hardware design components speaking the PCIe trans=
action layer protocol. The central piece you need is a way to translate bet=
ween the VFIO-user protocol and PCIe transaction layer messages, basically =
converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts betwee=
n the two worlds. I have some code which implements the basics of that. It'=
s certainly far from complete (TLP is a massive protocol), but it works wel=
l enough for me. I believe we should be able to open-source this if there's=
 interest, let me know.
>
> It is what I want to do, but I'm not familiar with the vfio and vfio-user=
, and I have a question. QEMU has a PCI TLP communication implementation fo=
r Multi-process QEMU[1]. It is similar to your success.

I'm no qemu expert, but my understanding is that the plan is for the
existing multi-process QEMU implementation to eventually be
superseded/replaced by the VFIO-user based one (qemu folks, please
correct me if I'm wrong). From a functional perspective they are more
or less equivalent AFAICT.

> The multi-process qemu also communicates TLP over UDS. Could you let me k=
now your opinion about it?

Note that neither multi-process qemu nor VFIO-user actually pass
around TLPs, but rather have their own command language to encode
ECAM, MMIO, DMA, interrupts etc. However, translation from/to TLP is
possible and works well enough in my experience.

>
>> One thing to note is that there are currently some limits to bridging VF=
IO-user / TLP that I haven't figured out and/or will need further work: Adv=
anced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalents o=
n the VFIO-user side that would have to be filled in. The folk behind libvf=
io-user[2] have been very approachable and open to improvements in my exper=
ience though.
>>
>> If I understand correctly, the specific goal here is testing PCIe endpoi=
nt designs against a Linux host. What you'd need for that is a PCI host con=
troller for the Linux side to talk to and then hooking up endpoints on the =
transaction layer. QEMU can simulate host controllers that work with existi=
ng Linux drivers just fine. Then you can put a vfio-user-pci stub device (I=
 don't think this has landed in qemu yet, but you can find the code at [1])=
 on the simulated PCI bus which will expose any software interactions with =
the endpoint as VFIO-user protocol messages over unix domain socket. The pi=
ece you need to bring is a VFIO-user server that handles these messages. It=
s task is basically translating between VFIO-user and TLP and then injectin=
g TLP into your hardware design.
>
> Yes, If the pci host controller you said can be implemented, I can achiev=
e my goal.

I meant to say that the existing PCIe host controller implementations
in qemu can be used as is.

>
> To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.
>
> [1] https://www.qemu.org/docs/master/system/multi-process.html
>
> Best,
> Shunsuke
>>
>>
>> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe that'=
s the latest version, Jagannathan Raman will know best
>> [2] https://github.com/nutanix/libvfio-user
>>
>
