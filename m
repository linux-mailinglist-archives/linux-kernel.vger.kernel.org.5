Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D5778E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjHKMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHKMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:00:34 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C237121
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:00:33 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79a2216a2d1so616035241.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691755232; x=1692360032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA1BdRxXOOi+C9ExLa1NYvfVDEtXPjrBgamRoRQ7ho8=;
        b=BOabHuNJf0zucJWLFarKtddPx7kzNUntHeAya9Bi3l6VgBfbsknbqK1e3DHgvCxj9O
         9K4Omdj+iGg6PSqrwGvwVO/Sgc3sGg0lIjsyg/WOt5eASVGH02Vkpxnj4LM7wo5h1EmD
         oo5pZcshlYOg0Iat0YFq0Qzrb5i0ZwFckXWfbhwOUybSm95W10a90TJiCs8yMBb47MBB
         V/e7/le4y6PwNWeiTpF4pHvR6v9EEzJFYIdamYW1eTg6IdBnZpvab+GXlizaHzvuakt4
         Wt1lZ+j9SG6Tgh+MqfhsnJze5aJZXG2Jelfv3fTN8WgwQn8SEHkxW13RU4x38lWPgmM8
         v+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755232; x=1692360032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA1BdRxXOOi+C9ExLa1NYvfVDEtXPjrBgamRoRQ7ho8=;
        b=kGCYMT6y+kj2n4v0N5CzyyUFRc0VdCpxBT71N9Y/wAQY7I9HDh53UYNAmR+pxyh2GZ
         TNkV8xkgmp+kQI11JNj/de/MpCb+WHSeWpRWl9TYiGWkaqYR8ROK3wKK3JrhcPZmvnTq
         8jcHB2pZBjwyYk+siNPVrsKEnkndfwpN1QIsIeMr1Sy4TY4G5KEvTWIu5w11GRyMBhVy
         suR5FIBmwYgKuf06yAsbL+8wwsA4ScSnC+ZZQ5gp3uPVrq10/fauyZTNjxSJ018ysEiM
         8fV8aSW+xbcdEqX22ZQEaKCKNurgDUoQdJOsaXnk3bBwsf66f4JsBk9oVHvzjenDbIj9
         3b+w==
X-Gm-Message-State: AOJu0YxRUvgeot9WDkFS5a4tsaGzWqIuwlWhz8vVqsIjpXoiPrf5MnVf
        i4nulDJP3vxAeGz7POp5XI/1c1bZNEMhH6YxcQon9Q==
X-Google-Smtp-Source: AGHT+IGi9YgHRgNxQ9yldhJHrwxPEB80cvxKjC+LAdb39UPsnP/Xwio2On+ZgwFqdcIvjxmtlfSPc/oEdwmFIHdDnb0=
X-Received: by 2002:a05:6102:11ee:b0:447:6901:a090 with SMTP id
 e14-20020a05610211ee00b004476901a090mr964338vsg.35.1691755232659; Fri, 11 Aug
 2023 05:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230810080909.6259-1-brgl@bgdev.pl> <j57dowviaas552jt6fdynyowkwm6j6xjc5ixjdk2v4nn4doibn@qnr47drkhljp>
In-Reply-To: <j57dowviaas552jt6fdynyowkwm6j6xjc5ixjdk2v4nn4doibn@qnr47drkhljp>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 14:00:21 +0200
Message-ID: <CAMRc=Md4UR=KdS716GTQ0+34NR4S5QDBM0HAoxj59=Y5G13L3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: enable EMAC1 on sa8775p
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:13=E2=80=AFPM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Thu, Aug 10, 2023 at 10:09:00AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This series contains changes required to enable EMAC1 on sa8775p-ride.
> > This iteration no longer depends on any changes to the stmmac driver to
> > be functional. It turns out I was mistaken in thinking that the two
> > MACs' MDIO masters share the MDIO clock and data lines. In reality, onl=
y
> > one MAC is connected to an MDIO bus and it controlls PHYs for both MAC0
> > and MAC1. The MDIO master on MAC1 is not connected to anything.
> >
>
> I've taken this for a quick (disconnected from network) spin, and things
> work as expected without having anything plugged in.
>
> I'm trying to get someone to plug it in so I can test that networking
> actually works, but the interesting bit is the phy/mdio bit here, and
> that's at least working ok I can tell. The rest is boilerplate similar
> to the other MAC instance which works fine.
>
> Removing the driver results in the following oops, but that's already
> discussed[0] and is independent of the devicetree description:
>
> I'd add a test tag but I want to wait for some network traffic tests
> before I do such. I wouldn't wait on picking it up just because of
> that though.
>
> [0] https://lore.kernel.org/netdev/ZNKLjuxnR2+V3g1D@shell.armlinux.org.uk=
/
>
> [root@dhcp19-243-28 ~]# modprobe -r dwmac_qcom_ethqos
> [ 1260.620402] qcom-ethqos 23040000.ethernet eth1: stmmac_dvr_remove: rem=
oving driver
> [ 1260.655724] qcom-ethqos 23040000.ethernet eth1: FPE workqueue stop
> [ 1261.034265] qcom-ethqos 23000000.ethernet eth0: stmmac_dvr_remove: rem=
oving driver
> [ 1261.042108] Unable to handle kernel paging request at virtual address =
dead000000000122
> [ 1261.050379] Mem abort info:
> [ 1261.053251]   ESR =3D 0x0000000096000044
> [ 1261.057113]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [ 1261.062573]   SET =3D 0, FnV =3D 0
> [ 1261.065712]   EA =3D 0, S1PTW =3D 0
> [ 1261.068946]   FSC =3D 0x04: level 0 translation fault
> [ 1261.073956] Data abort info:
> [ 1261.076916]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
> [ 1261.082552]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> [ 1261.087882]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [ 1261.093338] [dead000000000122] address between user and kernel address=
 ranges
> [ 1261.100667] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> [ 1261.107096] Modules linked in: r8152 rfkill marvell dwmac_qcom_ethqos(=
-) qcom_pon stmmac_platform crct10dif_ce stmmac spi_geni_qcom i2c_qcom_geni=
 phy_qcom_qmp_usb phy_qcom_sgmii_eth phy_qcom_snps_femto_v2 pcs_xpcs qcom_w=
dt socinfo phy_qcom_qmp_pcie fuse ufs_qcom phy_qcom_qmp_ufs
> [ 1261.132407] CPU: 2 PID: 610 Comm: modprobe Not tainted 6.5.0-rc4-next-=
20230731-00008-g18ccccee8230 #7
> [ 1261.141860] Hardware name: Qualcomm SA8775P Ride (DT)
> [ 1261.147042] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [ 1261.154185] pc : device_link_put_kref+0x44/0x110
> [ 1261.158926] lr : device_link_put_kref+0xf4/0x110
> [ 1261.163662] sp : ffff800082a938e0
> [ 1261.167066] x29: ffff800082a938e0 x28: ffff6ec68bdc9d80 x27: 000000000=
0000000
> [ 1261.174390] x26: 0000000000000000 x25: 0000000000000000 x24: 000000000=
0000000
> [ 1261.181714] x23: ffff800082a93b38 x22: ffff6ec68690f2d8 x21: ffff6ec68=
96aed30
> [ 1261.189031] x20: ffff6ec68246b830 x19: ffff6ec68246b800 x18: 000000000=
0000006
> [ 1261.196355] x17: ffff9259b7856000 x16: ffffdc7b42e3eaec x15: 725f72766=
45f6361
> [ 1261.203679] x14: 0000000000000000 x13: 0000000000000002 x12: 000000000=
0000000
> [ 1261.210996] x11: 0000000000000040 x10: ffffdc7b447de0b0 x9 : ffffdc7b4=
47de0a8
> [ 1261.218321] x8 : ffff6ec680400028 x7 : 0000000000000000 x6 : 000000000=
0000000
> [ 1261.225645] x5 : ffff6ec680400000 x4 : 00000000c0000000 x3 : ffff6ec68=
96ae8b0
> [ 1261.232963] x2 : dead000000000122 x1 : dead000000000122 x0 : ffff6ec68=
246b830
> [ 1261.240287] Call trace:
> [ 1261.242806]  device_link_put_kref+0x44/0x110
> [ 1261.247190]  device_link_del+0x30/0x48
> [ 1261.251040]  phy_detach+0x24/0x15c
> [ 1261.254530]  phy_disconnect+0x44/0x5c
> [ 1261.258295]  phylink_disconnect_phy+0x64/0xb0
> [ 1261.262764]  stmmac_release+0x58/0x2d4 [stmmac]
> [ 1261.267425]  __dev_close_many+0xac/0x14c
> [ 1261.271458]  dev_close_many+0x88/0x134
> [ 1261.275308]  unregister_netdevice_many_notify+0x130/0x7d0
> [ 1261.280852]  unregister_netdevice_queue+0xd4/0xdc
> [ 1261.285682]  unregister_netdev+0x24/0x38
> [ 1261.289715]  stmmac_dvr_remove+0x80/0x150 [stmmac]
> [ 1261.294636]  devm_stmmac_pltfr_remove+0x24/0x48 [stmmac_platform]
> [ 1261.300887]  devm_action_release+0x14/0x20
> [ 1261.305090]  devres_release_all+0xa0/0x100
> [ 1261.309293]  device_unbind_cleanup+0x18/0x68
> [ 1261.313676]  device_release_driver_internal+0x1f4/0x228
> [ 1261.319039]  driver_detach+0x4c/0x98
> [ 1261.322708]  bus_remove_driver+0x6c/0xbc
> [ 1261.326739]  driver_unregister+0x30/0x60
> [ 1261.330772]  platform_driver_unregister+0x14/0x20
> [ 1261.335603]  qcom_ethqos_driver_exit+0x18/0x1a8 [dwmac_qcom_ethqos]
> [ 1261.342035]  __arm64_sys_delete_module+0x19c/0x288
> [ 1261.346952]  invoke_syscall+0x48/0x110
> [ 1261.350804]  el0_svc_common.constprop.0+0xc4/0xe4
> [ 1261.355636]  do_el0_svc+0x38/0x94
> [ 1261.359040]  el0_svc+0x2c/0x84
> [ 1261.362178]  el0t_64_sync_handler+0x120/0x12c
> [ 1261.366646]  el0t_64_sync+0x190/0x194
> [ 1261.370413] Code: d2802441 aa1403e0 f2fbd5a1 f9000462 (f9000043)
> [ 1261.376661] ---[ end trace 0000000000000000 ]---
> Segmentation fault
>

Yep. This is a very deep problem and will be the same for any MAC
reaching into another MAC's node to get its PHY's phandle. :(

Bart
