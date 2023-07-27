Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7620B766030
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjG0XTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG0XTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:19:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8BD30CD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:18:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7656652da3cso123317185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690499938; x=1691104738;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eqsvR8ArPDNLU8M8dRL2kGGBZ8sdxb/GzvscPRCsI0=;
        b=rFysnfUkZvohOOkSOpuzfTqrK5P8z+iKk67xpCv9+GruAQFKjUS+hHdRm3xE2gvtA3
         7LY1DkMBvJSVWByiY2ZO7GTf+hw1aOnV7S6TW3fztNHpqcjQPqN///LDwXDZBrsBgswE
         5iS2b1HzSkqTrJlqXWsf1GA/w1ElVWv0PRSXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690499938; x=1691104738;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eqsvR8ArPDNLU8M8dRL2kGGBZ8sdxb/GzvscPRCsI0=;
        b=kUIjo5EOtIRIy/UZB+QgBFRrVqCUMNgPt8RLj5NTX8sCYJ2s9FjeFYJAaaji+ncBaT
         zhmndowOSUt0/YBrJJcujwN5Wep/bAPmSNYr0H9uka9acLWDBBjBsGC+makXSWHMln3r
         CzzNqX22qKJjLkR/RiniQFWdV43cQ4440ZRGnmy9iFBHaGXZj1P98BKayjKZ19aJfHir
         t3M3Lp3MspMjj7PqR2md3a20xyhmc0YDqL/oSW/tfwIZ0H7kF8g8LgwsWKzEcrkZZH/q
         qIF/0A6923GEquViRv/C0/WvNWXuZpWQDAcTHhbk/KLSy3LTZ9KyiNbXYubobKQwYrl+
         uwUQ==
X-Gm-Message-State: ABy/qLaPBqm0kSm8vS7vH1T4lNwsp0XKer0qUEvImp95gLjrXDwoF2PL
        SY6zCRzU62GUx+G/rWW63aSebQ==
X-Google-Smtp-Source: APBJJlGf1ShXIjwMeRDfcXZ8/7keIefA4h0SQysr1DmuyJiC4+NAK0q2N1dZe//gPOCkvEZrytfpEw==
X-Received: by 2002:a05:622a:11d6:b0:405:433f:5de4 with SMTP id n22-20020a05622a11d600b00405433f5de4mr1359867qtk.7.1690499937802;
        Thu, 27 Jul 2023 16:18:57 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.68])
        by smtp.gmail.com with ESMTPSA id s12-20020ac8758c000000b004009f6e7e7csm759101qtq.31.2023.07.27.16.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 16:18:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Date:   Thu, 27 Jul 2023 19:18:45 -0400
Message-Id: <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
Cc:     Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
In-Reply-To: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2023, at 4:33 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Jul 27, 2023 at 10:39:17AM -0700, Guenter Roeck wrote:
>> On 7/27/23 09:07, Paul E. McKenney wrote:
>>=20
>> ...]
>>=20
>>>> No. However, (unrelated) in linux-next, rcu tests sometimes result in a=
pparent hangs
>>>> or long runtime.
>>>>=20
>>>> [    0.778841] Mount-cache hash table entries: 512 (order: 0, 4096 byte=
s, linear)
>>>> [    0.779011] Mountpoint-cache hash table entries: 512 (order: 0, 4096=
 bytes, linear)
>>>> [    0.797998] Running RCU synchronous self tests
>>>> [    0.798209] Running RCU synchronous self tests
>>>> [    0.912368] smpboot: CPU0: AMD Opteron 63xx class CPU (family: 0x15,=
 model: 0x2, stepping: 0x0)
>>>> [    0.923398] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_a=
djust=3D1.
>>>> [    0.925419] Running RCU-tasks wait API self tests
>>>>=20
>>>> (hangs until aborted). This is primarily with Opteron CPUs, but also wi=
th others such as Haswell,
>>>> Icelake-Server, and pentium3. It is all but impossible to bisect becaus=
e it doesn't happen
>>>> all the time. All I was able to figure out was that it has to do with r=
cu changes in linux-next.
>>>> I'd be much more concerned about that.
>>>=20
>>> First I have heard of this, so thank you for letting me know.
>>>=20
>>> About what fraction of the time does this happen?
>>>=20
>>=20
>> Here is a sample test log from yesterday's -next. This is with x86_64.
>> Today's -next always crashes, so no data.
>>=20
>> Building x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd=
 ... running ....... passed
>> Building x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:at=
a:cd ... running .................R....... passed
>> Building x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:h=
d ... running ...... passed
>> Building x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:u=
sb:hd ... running ......... passed
>> Building x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub=
:hd ... running ....... passed
>> Building x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas=
:hd ... running .................R.... passed
>> Building x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi=
:mem4G:sdhci:mmc:hd ... running ....... passed
>> Building x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC3=
95]:hd ... running ....... passed
>> Building x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC=
395]:hd ... running ....... passed
>> Building x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scs=
i[DC395]:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53=
C974]:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[=
AM53C974]:hd ... running ....... passed
>> Building x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi=
:mem1G:scsi[53C810]:cd ... running .................R........... passed
>> Building x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544=
gc:efi32:mem2G:scsi[53C895A]:hd ... running ............. passed
>> Building x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[=
FUSION]:hd ... running ..................R.......... passed
>> Building x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:=
scsi[MEGASAS]:hd ... running ....... passed
>> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:sc=
si[MEGASAS2]:hd ... running ...... passed
>> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEG=
ASAS2]:hd ... running .................R.............. failed (silent)
>> Building x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGA=
SAS2]:hd ... running .......... passed
>> Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd ... ru=
nning ........ passed
>> Building x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd=
 ... running ...... passed
>> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virt=
io-pci]:hd ... running .................R................. passed
>> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virt=
io-pci-old]:hd ... running ................... passed
>> Building x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:=
hd ... running ......... passed
>> Building x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio=
:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio=
:hd ... running .................R... passed
>> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:ef=
i:mem2G:virtio:cd ... running ......... passed
>> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem=
4G:nvme:hd ... running ...... passed
>> Building x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558=
b:efi32:mem1G:sdhci:mmc:hd ... running ...... passed
>> Building x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:=
initrd ... running ...... passed
>> Building x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi=
[53C810]:hd ... running ....... passed
>> Building x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:=
hd ... running ......... passed
>> Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd ... r=
unning ....................R................. failed (silent)
>> Building x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:at=
a:hd ... running .....................R....... passed
>> Building x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:me=
m2G:ata:hd ... running .................R.............. failed (silent)
>>=20
>> An earlier test run:
>>=20
>> Building x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd=
 ... running ....... passed
>> Building x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:at=
a:cd ... running .................R....... passed
>> Building x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:h=
d ... running ........ passed
>> Building x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:u=
sb:hd ... running .......... passed
>> Building x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub=
:hd ... running ....... passed
>> Building x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas=
:hd ... running .................R.... passed
>> Building x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi=
:mem4G:sdhci:mmc:hd ... running ....... passed
>> Building x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC3=
95]:hd ... running ......... passed
>> Building x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC=
395]:hd ... running ....... passed
>> Building x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scs=
i[DC395]:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53=
C974]:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[=
AM53C974]:hd ... running ........ passed
>> Building x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi=
:mem1G:scsi[53C810]:cd ... running .......... passed
>> Building x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544=
gc:efi32:mem2G:scsi[53C895A]:hd ... running .................R..... passed
>> Building x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[=
FUSION]:hd ... running .................R.............. failed (silent)
>> Building x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:=
scsi[MEGASAS]:hd ... running ....... passed
>> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:sc=
si[MEGASAS2]:hd ... running ....... passed
>> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEG=
ASAS2]:hd ... running ....... passed
>> Building x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGA=
SAS2]:hd ... running .......... passed
>> Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd ... ru=
nning ........ passed
>> Building x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd=
 ... running ...... passed
>> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virt=
io-pci]:hd ... running .......... passed
>> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virt=
io-pci-old]:hd ... running .......... passed
>> Building x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:=
hd ... running ...... passed
>> Building x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio=
:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio=
:hd ... running ...... passed
>> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:ef=
i:mem2G:virtio:cd ... running ......... passed
>> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem=
4G:nvme:hd ... running ....... passed
>> Building x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558=
b:efi32:mem1G:sdhci:mmc:hd ... running ....... passed
>> Building x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:=
initrd ... running ....... passed
>> Building x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi=
[53C810]:hd ... running ........ passed
>> Building x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:=
hd ... running ......... passed
>> Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd ... r=
unning ....................R................. failed (silent)
>> Building x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:at=
a:hd ... running ....... passed
>> Building x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:me=
m2G:ata:hd ... running ....... passed
>>=20
>> "R" means retry, and the dots reflect time expired. It looks like it happ=
ens most of the time,
>> but not always, on affected CPUs. I don't have specific data for non-Inte=
l CPUs. I don't think
>> I see the problem there, but there is too much interference from other pr=
oblems to be sure.
>>=20
>> For comparison, here is the result from the latest mainline:
>>=20
>> Building x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd=
 ... running ....... passed
>> Building x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:at=
a:cd ... running .......... passed
>> Building x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:h=
d ... running ...... passed
>> Building x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:u=
sb:hd ... running ......... passed
>> Building x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub=
:hd ... running ........... passed
>> Building x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas=
:hd ... running ........ passed
>> Building x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi=
:mem4G:sdhci:mmc:hd ... running ....... passed
>> Building x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC3=
95]:hd ... running ....... passed
>> Building x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC=
395]:hd ... running ....... passed
>> Building x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scs=
i[DC395]:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53=
C974]:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[=
AM53C974]:hd ... running ....... passed
>> Building x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi=
:mem1G:scsi[53C810]:cd ... running .......... passed
>> Building x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544=
gc:efi32:mem2G:scsi[53C895A]:hd ... running ....... passed
>> Building x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[=
FUSION]:hd ... running ............. passed
>> Building x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:=
scsi[MEGASAS]:hd ... running ....... passed
>> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:sc=
si[MEGASAS2]:hd ... running ....... passed
>> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEG=
ASAS2]:hd ... running ...... passed
>> Building x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGA=
SAS2]:hd ... running ......... passed
>> Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd ... ru=
nning ......... passed
>> Building x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd=
 ... running ......... passed
>> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virt=
io-pci]:hd ... running ......... passed
>> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virt=
io-pci-old]:hd ... running ......... passed
>> Building x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:=
hd ... running ...... passed
>> Building x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio=
:hd ... running ....... passed
>> Building x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio=
:hd ... running ...... passed
>> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:ef=
i:mem2G:virtio:cd ... running ............ passed
>> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem=
4G:nvme:hd ... running ....... passed
>> Building x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558=
b:efi32:mem1G:sdhci:mmc:hd ... running ...... passed
>> Building x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:=
initrd ... running ...... passed
>> Building x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi=
[53C810]:hd ... running ....... passed
>> Building x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:=
hd ... running .......... passed
>> Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd ... r=
unning .......... passed
>> Building x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:at=
a:hd ... running ...... passed
>> Building x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:me=
m2G:ata:hd ... running ...... passed
>=20
> I freely confess that I am having a hard time imagining what would
> be CPU dependent in that code.  Timing, maybe?  Whatever the reason,
> I am not seeing these failures in my testing.
>=20
> So which of the following Kconfig options is defined in your .config?
> CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
>=20
> If you have more than one of them, could you please apply this patch
> and show me the corresponding console output from the resulting hang?

FWIW, I am not able to repro this issue either. If a .config can be shared o=
f the problem system, I can try it out to see if it can be reproduced on my s=
ide.

Cheers,

 - Joel=20


>=20
>                            Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit 709a917710dc01798e01750ea628ece4bfc42b7b
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Jul 27 13:13:46 2023 -0700
>=20
>    rcu-tasks: Add printk()s to localize boot-time self-test hang
>=20
>    Currently, rcu_tasks_initiate_self_tests() prints a message and then
>    initiates self tests on up to three different RCU Tasks flavors.  If on=
e
>    of the flavors has a grace-period hang, it is not easy to work out whic=
h
>    of the three hung.  This commit therefore prints a message prior to eac=
h
>    individual test.
>=20
>    Reported-by: Guenter Roeck <linux@roeck-us.net>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 56c470a489c8..427433c90935 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1981,20 +1981,22 @@ static void test_rcu_tasks_callback(struct rcu_hea=
d *rhp)
>=20
> static void rcu_tasks_initiate_self_tests(void)
> {
> -    pr_info("Running RCU-tasks wait API self tests\n");
> #ifdef CONFIG_TASKS_RCU
> +    pr_info("Running RCU Tasks wait API self tests\n");
>    tests[0].runstart =3D jiffies;
>    synchronize_rcu_tasks();
>    call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> #endif
>=20
> #ifdef CONFIG_TASKS_RUDE_RCU
> +    pr_info("Running RCU Tasks Rude wait API self tests\n");
>    tests[1].runstart =3D jiffies;
>    synchronize_rcu_tasks_rude();
>    call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
> #endif
>=20
> #ifdef CONFIG_TASKS_TRACE_RCU
> +    pr_info("Running RCU Tasks Trace wait API self tests\n");
>    tests[2].runstart =3D jiffies;
>    synchronize_rcu_tasks_trace();
>    call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
