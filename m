Return-Path: <linux-kernel+bounces-13068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3C81FF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BF1F234FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A6111AD;
	Fri, 29 Dec 2023 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bDmSEa6M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BB11188
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f0629e67f4so1917257b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703850172; x=1704454972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKLtJ4hqV7dBOrzQ3MVEituBOzeOEbpMil7YSmlOV20=;
        b=bDmSEa6M604J5VnLukH9Gl5fyz3KA1IruIlhH2yDq04G6Srn6+Ca3xSsGH92hN4WcD
         PU8Z/1SSUNwiAbaCJYhRZBBngh3hP2uBv6V3zqPGFrbH7/MhJHXECTB86XyKjSDayGu3
         c+d/0A4VhO3ha3htuhgj+E21JQe5gLQcnswuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703850172; x=1704454972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKLtJ4hqV7dBOrzQ3MVEituBOzeOEbpMil7YSmlOV20=;
        b=Kr0XpW1Ulsf+uNRp/Mx42mCG1hatWlbP+l3q5ccVBlxN+zCRBoaQF1NrLDNb+FZ+lc
         tcE/QnZ8vCmwVpZ+FBfBkTJQzg1dgD9EBSmQPwZG6cuRNbConeKJhMniOIvollWRngyg
         Z9zmiPDTaVI00ysV8hl/XbV+xxzv+ueZmwmobUAFXWTienkO4VAad9r5PKveolvbeoyf
         bsfSDNtRqwTR6BEu45OHu5W1iKNt1m2oNZ0yohVCKYrU7cySNklKAKXszPVX87JQBgoz
         bIuFdDG7L9u+iBvnnLpCmT2xAOfBwTqIXCbW5HYgiscEw71djc+29P4yVbdSCZ+iz26a
         USaA==
X-Gm-Message-State: AOJu0YyiVwqNIEUwyMHtMNrEs2UZ/uwnwxQAjaB1W06PO2B7kTnXiVYL
	sIMfchrBkMJ5FUthQqb78kclXm6sSW68bPAFaoDm1fOK68u19Q==
X-Google-Smtp-Source: AGHT+IHHHDBjTHIGWfd+SVwFBnK23zm+4XlQ1ZMvVrBDaGN7uZOEJ5ABESZyPm81Cv18KUiXu0qd6iGVyIsw0R+dKOM=
X-Received: by 2002:a81:4c95:0:b0:5ec:2eb3:e80e with SMTP id
 z143-20020a814c95000000b005ec2eb3e80emr4051477ywa.1.1703850171359; Fri, 29
 Dec 2023 03:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf> <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
In-Reply-To: <20231226153055.4yihsmu6kiak6hkf@skbuf>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 29 Dec 2023 17:12:39 +0530
Message-ID: <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Andrew F. Davis" <afd@ti.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, 
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 9:00=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Tue, Dec 26, 2023 at 01:11:08PM +0530, Jagan Teki wrote:
> > &fec {
> >           pinctrl-names =3D "default";
> >           pinctrl-0 =3D <&pinctrl_enet>;
> >           phy-mode =3D "mii";
> >           status =3D "okay";
>
> tl;dr: I think what is missing is:
>
>                 fixed-link {
>                         speed =3D <100>;
>                         full-duplex;
>                 };

Okay. I added this and now the warning seems gone. Please check the below l=
og.

>
> >
> >           mdio {
> >              #address-cells =3D <1>;
> >              #size-cells =3D <0>;
> >
> >             ethphy0: ethernet-phy@0 {
> >                       compatible =3D "ethernet-phy-ieee802.3-c22";
> >                       reg =3D <0>;
> >             };
> >
> >             ethphy1: ethernet-phy@1 {
> >                     compatible =3D "ethernet-phy-ieee802.3-c22";
> >                     reg =3D <1>;
> >            };
> >         };
> > };
> >
> > root@imx6solo:~# ip link set dev eth0 down
> > root@imx6solo:~# ip link set dev ethphy0 down
> > root@imx6solo:~# ip link set dev ethphy1 down
> > root@imx6solo:~# ip link set dev ethphy0 address 00:11:22:33:44:55
> > root@imx6solo:~# ip link set dev ethphy1 address 00:11:22:33:44:66
> > root@imx6solo:~# ip addr add dev ethphy0 192.168.1.1/16
> > root@imx6solo:~# ip addr add dev ethphy1 192.168.1.5/16
> > root@imx6solo:~# ip link set dev eth0 up
> > [  617.126753] dp83848_config_init: ret 0
> > [  617.130831] TI DP83849I 10/100 Mbps PHY 2188000.ethernet-1:00: attac=
hed PHY driver (mii_bus:phy_addr=3D2188000.ethernet-1:00, irq=3DPOLL)
> > root@imx6solo:~# [  619.207519] fec 2188000.ethernet eth0: Link is Up -=
 100Mbps/Full - flow control rx/tx
> > [  619.215698] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>
> eth0 is the FEC port, right?

Yes.

With fec0 fixed-link and 3 different switch port configurations, the
result of the link seems to be up but the ping not working and even
the packets are not transmitted via eth0.

DT Combinations:

- Port0 is ethphy0, Port1 is ethphy1, Port2 is disabled, Port3 is
disabled, Port4 is FEC
- Port0 is disabled, Port1 is ethphy0, Port2 is ethphy1, Port3 is
disabled, Port4 is FEC
- Port0 is disabled, Port1 is disabled, Port2 is ethphy0, Port3 is
ethphy1, Port4 as FEC


DT: (with Port0 is ethphy0, Port1 is ethphy1, Port2 is disabled, Port3
is disabled, Port4 is FEC)

&ecspi2 {
    cs-gpios =3D <&gpio2 27 GPIO_ACTIVE_HIGH>;
    pinctrl-names =3D "default";
    pinctrl-0 =3D <&pinctrl_ecspi2>;
    status =3D "okay";

    switch@0 {
        compatible =3D "nxp,sja1105q";
        reg =3D <0>;
        spi-max-frequency =3D <4000000>;
        spi-rx-delay-us =3D <1>;
        spi-tx-delay-us =3D <1>;
        spi-cpha;

       clocks =3D <&clk25m>;

       pinctrl-0 =3D <&pinctrl_sja1105_rst>;
       pinctrl-names =3D "default";
       reset-gpios =3D <&gpio6 5 GPIO_ACTIVE_LOW>;

       ports {
              #address-cells =3D <1>;
              #size-cells =3D <0>;

             port@0 {
                  reg =3D <0>;
                  label =3D "ethphy0";
                  phy-handle =3D <&ethphy0>;
                  phy-mode =3D "mii";
            };

            port@1 {
                 reg =3D <1>;
                 label =3D "ethphy1";
                 phy-handle =3D <&ethphy1>;
                 phy-mode =3D "mii";
           };

           port@2 {
                reg =3D <2>;
                status =3D "disabled";
           };

            port@3 {
                 reg =3D <3>;
                 status =3D "disabled";
           };

           port@4 {
                reg =3D <4>;
                label =3D "cpu";
                ethernet =3D <&fec>;
                phy-mode =3D "mii";
                rx-internal-delay-ps =3D <2000>;
                tx-internal-delay-ps =3D <2000>;

               fixed-link {
                   speed =3D <100>;
                   full-duplex;
               };
            };
          };
     };
};

&fec {
       pinctrl-names =3D "default";
       pinctrl-0 =3D <&pinctrl_enet>;
       phy-mode =3D "mii";
       status =3D "okay";

       fixed-link {
          speed =3D <100>;
          full-duplex;
       };

       mdio {
            #address-cells =3D <1>;
            #size-cells =3D <0>;

            ethphy0: ethernet-phy@0 {
                    compatible =3D "ethernet-phy-ieee802.3-c22";
                    reg =3D <0>;
            };

           ethphy1: ethernet-phy@1 {
               compatible =3D "ethernet-phy-ieee802.3-c22";
                reg =3D <1>;
            };
    };
};

Full dmesg:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.1.58 (oe-user@oe-host)
(arm-fslc-linux-gnueabi-gcc (GCC) 11.4.0, GNU ld (GNU Binutils)
2.38.20220708) #1 SMP Sun Oct 15 16:32:41 UTC 2023
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: LTTS i.MX6DL/SOLO Processor
Board (P0-PHY0, P1-PHY1)
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 64 MiB at 0x4c000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x000000003fffffff]
[    0.000000]   HighMem  [mem 0x0000000040000000-0x000000004fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000010000000-0x000000004fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000010000000-0x000000004ffff=
fff]
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] percpu: Embedded 17 pages/cpu s38452 r8192 d22988 u69632
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 26060=
8
[    0.000000] Kernel command line: console=3Dttymxc1,115200
root=3D/dev/mmcblk0p2 rootwait rw
mtdparts=3Dgpmi-nand:2m(spl),2m(uboot),1m(env),16m(kernel),1m(dtb),-(rootfs=
)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7,
524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 942324K/1048576K available (15360K kernel code,
2198K rwdata, 5632K rodata, 1024K init, 6674K bss, 40716K reserved,
65536K cma-reserved, 196608K highmem)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.000000] trace event string verifier disabled
[    0.000000] Running RCU self tests
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU lockdep checking is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=
=3D2.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76450001
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000001] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000026] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.002024] Console: colour dummy device 80x30
[    0.002103] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.002115] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.002127] ... MAX_LOCK_DEPTH:          48
[    0.002140] ... MAX_LOCKDEP_KEYS:        8192
[    0.002151] ... CLASSHASH_SIZE:          4096
[    0.002163] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.002174] ... MAX_LOCKDEP_CHAINS:      65536
[    0.002186] ... CHAINHASH_SIZE:          32768
[    0.002197]  memory used by lock dependency info: 4061 kB
[    0.002209]  memory used for stack traces: 2112 kB
[    0.002220]  per task-struct memory footprint: 1536 bytes
[    0.002337] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.002370] CPU: Testing write buffer coherency: ok
[    0.002550] CPU0: Spectre v2: using BPIALL workaround
[    0.002570] pid_max: default: 32768 minimum: 301
[    0.003241] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[    0.003279] Mountpoint-cache hash table entries: 2048 (order: 1,
8192 bytes, linear)
[    0.008782] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.012642] cblist_init_generic: Setting adjustable number of
callback queues.
[    0.012663] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.013078] Running RCU-tasks wait API self tests
[    0.013428] Setting up static identity map for 0x10100000 - 0x10100078
[    0.014115] Callback from call_rcu_tasks_trace() invoked.
[    0.014401] rcu: Hierarchical SRCU implementation.
[    0.014416] rcu:     Max phase no-delay instances is 1000.
[    0.017147] smp: Bringing up secondary CPUs ...
[    0.020861] smp: Brought up 1 node, 1 CPU
[    0.020887] SMP: Total of 1 processors activated (6.00 BogoMIPS).
[    0.020906] CPU: All CPU(s) started in SVC mode.
[    0.023936] devtmpfs: initialized
[    0.064038] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.066614] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.066685] futex hash table entries: 512 (order: 3, 32768 bytes, linear=
)
[    0.069638] pinctrl core: initialized pinctrl subsystem
[    0.076431] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.103057] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.108831] thermal_sys: Registered thermal governor 'step_wise'
[    0.109233] cpuidle: using governor menu
[    0.109642] CPU identified as i.MX6DL, silicon rev 1.4
[    0.129331] platform soc: Fixed dependency cycle(s) with
/soc/bus@2000000/gpc@20dc000
[    0.196131] platform 2400000.ipu: Fixed dependency cycle(s) with
/ldb/lvds-channel@0/port@1/endpoint
[    0.196257] platform 2400000.ipu: Fixed dependency cycle(s) with
/ldb/lvds-channel@0/port@0/endpoint
[    0.196358] platform 2400000.ipu: Fixed dependency cycle(s) with
/soc/bus@2000000/iomuxc-gpr@20e0000/ipu1_csi1_mux/port@5/endpoint
[    0.196495] platform 2400000.ipu: Fixed dependency cycle(s) with
/soc/bus@2000000/iomuxc-gpr@20e0000/ipu1_csi0_mux/port@5/endpoint
[    0.201135] platform panel: Fixed dependency cycle(s) with
/ldb/lvds-channel@0/port@4/endpoint
[    0.208560] No ATAGs?
[    0.208881] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.208926] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.214921] imx6dl-pinctrl 20e0000.pinctrl: initialized IMX pinctrl driv=
er
[    0.272738] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    1.498973] SCSI subsystem initialized
[    1.501106] usbcore: registered new interface driver usbfs
[    1.501396] usbcore: registered new interface driver hub
[    1.501565] usbcore: registered new device driver usb
[    1.502033] usb_phy_generic usbphynop1: supply vcc not found, using
dummy regulator
[    1.502911] usb_phy_generic usbphynop1: dummy supplies not allowed
for exclusive requests
[    1.503404] usb_phy_generic usbphynop2: supply vcc not found, using
dummy regulator
[    1.504037] usb_phy_generic usbphynop2: dummy supplies not allowed
for exclusive requests
[    1.510235] i2c i2c-0: IMX I2C adapter registered
[    1.514947] i2c i2c-1: IMX I2C adapter registered
[    1.518067] i2c i2c-2: IMX I2C adapter registered
[    1.518853] mc: Linux media interface: v0.10
[    1.519141] videodev: Linux video capture interface: v2.00
[    1.522785] pps_core: LinuxPPS API ver. 1 registered
[    1.522807] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    1.522874] PTP clock support registered
[    1.525697] Advanced Linux Sound Architecture Driver Initialized.
[    1.529830] Bluetooth: Core ver 2.22
[    1.529992] NET: Registered PF_BLUETOOTH protocol family
[    1.530010] Bluetooth: HCI device and connection manager initialized
[    1.530145] Bluetooth: HCI socket layer initialized
[    1.530180] Bluetooth: L2CAP socket layer initialized
[    1.530347] Bluetooth: SCO socket layer initialized
[    1.533222] vgaarb: loaded
[    1.535344] clocksource: Switched to clocksource mxc_timer1
[    1.538364] VFS: Disk quotas dquot_6.6.0
[    1.538543] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    1.579519] NET: Registered PF_INET protocol family
[    1.580549] IP idents hash table entries: 16384 (order: 5, 131072
bytes, linear)
[    1.584148] tcp_listen_portaddr_hash hash table entries: 512
(order: 2, 20480 bytes, linear)
[    1.584256] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    1.584303] TCP established hash table entries: 8192 (order: 3,
32768 bytes, linear)
[    1.584658] TCP bind hash table entries: 8192 (order: 7, 655360
bytes, linear)
[    1.586988] TCP: Hash tables configured (established 8192 bind 8192)
[    1.587712] UDP hash table entries: 512 (order: 3, 49152 bytes, linear)
[    1.587929] UDP-Lite hash table entries: 512 (order: 3, 49152 bytes, lin=
ear)
[    1.588553] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.591483] RPC: Registered named UNIX socket transport module.
[    1.591536] RPC: Registered udp transport module.
[    1.591553] RPC: Registered tcp transport module.
[    1.591567] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.593486] PCI: CLS 0 bytes, default 64
[    1.595609] armv7-pmu pmu: hw perfevents: no interrupt-affinity
property, guessing.
[    1.598721] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    1.606329] Initialise system trusted keyrings
[    1.607301] workingset: timestamp_bits=3D30 max_order=3D18 bucket_order=
=3D0
[    1.635184] NFS: Registering the id_resolver key type
[    1.635456] Key type id_resolver registered
[    1.635507] Key type id_legacy registered
[    1.635885] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.635995] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    1.636188] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    1.637781] fuse: init (API version 7.37)
[    1.730733] Key type asymmetric registered
[    1.730857] Asymmetric key parser 'x509' registered
[    1.731593] bounce: pool size: 64 pages
[    1.732072] io scheduler mq-deadline registered
[    1.732097] io scheduler kyber registered
[    1.749796] pwm-backlight backlight-lvds: supply power not found,
using dummy regulator
[    1.794041] mxs-dma 110000.dma-apbh: initialized
[    1.830861] pfuze100-regulator 1-0008: Full layer: 2, Metal layer: 1
[    1.831964] pfuze100-regulator 1-0008: FAB: 0, FIN: 0
[    1.831988] pfuze100-regulator 1-0008: pfuze100 found.
[    1.911047] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 268,
base_baud =3D 5000000) is a IMX
[    3.289603] printk: console [ttymxc1] enabled
[    3.298390] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq =3D 269,
base_baud =3D 5000000) is a IMX
[    3.310022] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq =3D 270,
base_baud =3D 5000000) is a IMX
[    3.339597] panel-simple panel: supply power not found, using dummy regu=
lator
[    3.365682] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
[    3.372400] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
[    3.378114] etnaviv-gpu 130000.gpu: model: GC880, revision: 5106
[    3.385550] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
[    3.395114] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on mino=
r 0
[    3.409334] imx-ipuv3 2400000.ipu: IPUv3H probed
[    3.456061] brd: module loaded
[    3.491073] loop: module loaded
[    3.506529] nand: device found, Manufacturer ID: 0xef, Chip ID: 0xd3
[    3.512923] nand: Winbond W29N08GV
[    3.516421] nand: 1024 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    3.525991] Bad block table found at page 524224, version 0x01
[    3.532422] Bad block table found at page 524160, version 0x01
[    3.538885] 6 cmdlinepart partitions found on MTD device gpmi-nand
[    3.545094] Creating 6 MTD partitions on "gpmi-nand":
[    3.550240] 0x000000000000-0x000000200000 : "spl"
[    3.566776] 0x000000200000-0x000000400000 : "uboot"
[    3.579186] 0x000000400000-0x000000500000 : "env"
[    3.591520] 0x000000500000-0x000001500000 : "kernel"
[    3.604423] 0x000001500000-0x000001600000 : "dtb"
[    3.618303] 0x000001600000-0x000040000000 : "rootfs"
[    3.659665] gpmi-nand 112000.nand-controller: driver registered.
[    3.666959] SPI driver spidev has no spi_device_id for ltts,evalspi
[    3.686253] CAN device driver interface
[    3.702126] pps pps0: new PPS source ptp0
[    3.709056] fec 2188000.ethernet: Invalid MAC address: 00:00:00:00:00:00
[    3.715988] fec 2188000.ethernet: Using random MAC address: 86:d6:01:18:=
ff:de
[    3.733304] fec 2188000.ethernet eth0: registered PHC device 0
[    3.741777] usbcore: registered new interface driver r8152
[    3.747648] usbcore: registered new interface driver lan78xx
[    3.753513] usbcore: registered new interface driver asix
[    3.759328] usbcore: registered new interface driver ax88179_178a
[    3.765791] usbcore: registered new interface driver cdc_ether
[    3.771827] usbcore: registered new interface driver smsc95xx
[    3.777918] usbcore: registered new interface driver net1080
[    3.783727] usbcore: registered new interface driver cdc_subset
[    3.789881] usbcore: registered new interface driver zaurus
[    3.795672] usbcore: registered new interface driver MOSCHIP
usb-ethernet driver
[    3.803385] usbcore: registered new interface driver cdc_ncm
[    3.809271] usbcore: registered new interface driver r8153_ecm
[    3.815506] usbcore: registered new interface driver usb-storage
[    3.831006] SPI driver ads7846 has no spi_device_id for ti,tsc2046
[    3.837316] SPI driver ads7846 has no spi_device_id for ti,ads7843
[    3.843521] SPI driver ads7846 has no spi_device_id for ti,ads7845
[    3.849776] SPI driver ads7846 has no spi_device_id for ti,ads7873
[    4.445853] input: ILI210x Touchscreen as
/devices/platform/soc/2100000.bus/21a0000.i2c/i2c-0/0-0041/input/input0
[    4.463608] pwm-beeper buzzer: supply amp not found, using dummy regulat=
or
[    4.471904] input: pwm-beeper as /devices/platform/buzzer/input/input1
[    4.489945] rtc-rv3032 2-0051: registered as rtc0
[    4.495855] rtc-rv3032 2-0051: hctosys: unable to read the hardware cloc=
k
[    4.508809] hwmon hwmon0: temp1_input not attached to any thermal zone
[    4.521570] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc1
[    4.528373] i2c_dev: i2c /dev entries driver
[    4.549409] Bluetooth: HCI UART driver ver 2.3
[    4.553894] Bluetooth: HCI UART protocol H4 registered
[    4.559248] Bluetooth: HCI UART protocol LL registered
[    4.564605] usbcore: registered new interface driver btusb
[    4.573887] sdhci: Secure Digital Host Controller Interface driver
[    4.580184] sdhci: Copyright(c) Pierre Ossman
[    4.584567] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.594237] sdhci-esdhc-imx 2190000.mmc: Got CD GPIO
[    4.608457] caam 2100000.crypto: Entropy delay =3D 3200
[    4.674334] caam 2100000.crypto: Instantiated RNG4 SH0
[    4.735099] caam 2100000.crypto: Instantiated RNG4 SH1
[    4.745853] caam 2100000.crypto: device ID =3D 0x0a16010000000100 (Era 4=
)
[    4.752569] caam 2100000.crypto: job rings =3D 2, qi =3D 0
[    4.766963] caam algorithms registered in /proc/crypto
[    4.772822] caam 2100000.crypto: registering rng-caam
[    4.786217] mmc0: SDHCI controller on 2190000.mmc [2190000.mmc] using AD=
MA
[    4.797221] caam 2100000.crypto: rng crypto API alg registered prng-caam
[    4.810644] usbcore: registered new interface driver usbhid
[    4.816367] usbhid: USB HID core driver
[    4.826100] imx-ipuv3-csi imx-ipuv3-csi.0: Registered ipu1_csi0
capture as /dev/video0
[    4.836462] imx-ipuv3 2400000.ipu: Registered ipu1_ic_prpenc
capture as /dev/video1
[    4.845191] imx-ipuv3 2400000.ipu: Registered ipu1_ic_prpvf capture
as /dev/video2
[    4.854918] imx-ipuv3-csi imx-ipuv3-csi.1: Registered ipu1_csi1
capture as /dev/video3
[    4.871518] mmc0: host does not support reading read-only switch,
assuming write-enable
[    4.887794] mmc0: new high speed SDHC card at address 0001
[    4.907708] mmcblk0: mmc0:0001 USD 7.44 GiB
[    4.923964] NET: Registered PF_INET6 protocol family
[    4.938124]  mmcblk0: p1 p2 p3
[    4.949653] Segment Routing with IPv6
[    4.953421] In-situ OAM (IOAM) with IPv6
[    4.958277] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.967245] NET: Registered PF_PACKET protocol family
[    4.973235] can: controller area network core
[    4.978040] NET: Registered PF_CAN protocol family
[    4.982948] can: raw protocol
[    4.986206] random: crng init done
[    4.989816] can: broadcast manager protocol
[    4.994071] can: netlink gateway - max_hops=3D1
[    4.999596] Key type dns_resolver registered
[    5.016720] Registering SWP/SWPB emulation handler
[    5.022738] Loading compiled-in X.509 certificates
[    5.204409] Stack Depot allocating hash table of 65536 entries with kvca=
lloc
[    5.216619] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops
ipu_crtc_ops)
[    5.224503] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops
ipu_crtc_ops)
[    5.232738] imx-drm display-subsystem: bound ldb (ops imx_ldb_ops)
[    5.242432] [drm] Initialized imx-drm 1.0.0 20120507 for
display-subsystem on minor 1
[    5.336982] Console: switching to colour frame buffer device 160x50
[    5.363752] imx-drm display-subsystem: [drm] fb0: imx-drmdrmfb
frame buffer device
[    5.997424] mxs_phy 20c9000.usbphy: Data pin can't make good contact.
[    6.013128] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    6.018536] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    6.055398] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    6.062453] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.01
[    6.071010] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    6.078308] usb usb1: Product: EHCI Host Controller
[    6.083208] usb usb1: Manufacturer: Linux 6.1.58 ehci_hcd
[    6.089002] usb usb1: SerialNumber: ci_hdrc.1
[    6.098174] hub 1-0:1.0: USB hub found
[    6.102309] hub 1-0:1.0: 1 port detected
[    6.113416] video-mux 20e0000.iomuxc-gpr:ipu1_csi0_mux: Consider
updating driver video-mux to match on endpoints
[    6.126877] video-mux 20e0000.iomuxc-gpr:ipu1_csi1_mux: Consider
updating driver video-mux to match on endpoints
[    6.145163] imx-media: Registered ipu_ic_pp csc/scaler as /dev/video4
[    6.156758] imx_thermal 20c8000.anatop:tempmon: Extended Commercial
CPU temperature grade - max:105C critical:100C passive:95C
[    6.181973] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    6.196443] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.204613] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    6.213542] platform regulatory.0: Falling back to sysfs fallback
for: regulatory.db
[    6.224065] ALSA device list:
[    6.230889]   No soundcards found.
[    6.271484] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
data mode. Quota mode: none.
[    6.281110] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    6.289875] devtmpfs: mounted
[    6.295188] Freeing unused kernel image (initmem) memory: 1024K
[    6.302075] Run /sbin/init as init process
[    6.395409] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    6.598005] usb 1-1: New USB device found, idVendor=3D0451,
idProduct=3D8142, bcdDevice=3D 1.00
[    6.606485] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    6.613748] usb 1-1: SerialNumber: EA030849138F
[    6.628789] hub 1-1:1.0: USB hub found
[    6.633391] hub 1-1:1.0: 4 ports detected
[    6.772078] systemd[1]: System time before build time, advancing clock.
[    6.900824] systemd[1]: systemd 250.5+ running in system mode (-PAM
-AUDIT -SELINUX -APPARMOR +IMA -SMACK +SECCOMP -GCRYPT -GNUTLS
-OPENSSL +ACL +BLKID -CURL -ELFUTILS -FIDO2 -IDN2 -IDN -IPTC +KMOD
-LIBCRYPTSETUP +LIBFDISK -PCRE2 -PWQUALITY -P11KIT -QRENCODE -BZIP2
-LZ4 -XZ -ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT
default-hierarchy=3Dhybrid)
[    6.934384] systemd[1]: Detected architecture arm.

Welcome to FSLC FrameBuffer [    6.955469] usb 1-1.1: new high-speed
USB device number 3 using ci_hdrc
4.0 (kirkstone)!

[    6.987732] systemd[1]: Hostname set to <ltts-imx6solo>.
[    7.002838] systemd[1]: Initializing machine ID from random generator.
[    7.107401] usb 1-1.1: New USB device found, idVendor=3D04b4,
idProduct=3Dbd30, bcdDevice=3D 1.00
[    7.116088] usb 1-1.1: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    7.138412] hub 1-1.1:1.0: USB hub found
[    7.145842] hub 1-1.1:1.0: 2 ports detected
[    7.575615] usb 1-1.1.1: new high-speed USB device number 4 using ci_hdr=
c
[    7.747978] usb 1-1.1.1: New USB device found, idVendor=3D04b4,
idProduct=3Dbd29, bcdDevice=3D 0.01
[    7.756770] usb 1-1.1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    7.764382] usb 1-1.1.1: Product: Remote Download Wireless Adapter
[    7.770725] usb 1-1.1.1: Manufacturer: Cypress Semiconductor Corp.
[    7.776982] usb 1-1.1.1: SerialNumber: 000000000001
[    7.905545] usb 1-1.1.2: new high-speed USB device number 5 using ci_hdr=
c
[    8.067618] usb 1-1.1.2: New USB device found, idVendor=3D04b4,
idProduct=3D640c, bcdDevice=3D 1.12
[    8.076399] usb 1-1.1.2: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    8.083962] usb 1-1.1.2: Product: BCM2045A0
[    8.088278] usb 1-1.1.2: Manufacturer: Cypress Semiconductor Corp.
[    8.094481] usb 1-1.1.2: SerialNumber: C0EE40822FFD
[    8.115037] Bluetooth: : invalid diagnostic descriptors
[    8.258777] Bluetooth: hci0: BCM: chip id 135
[    8.264757] Bluetooth: hci0: BCM: features 0x0f
[    8.270748] Bluetooth: hci0: BCM4373A0
[    8.274527] Bluetooth: hci0: BCM (001.001.025) build 0000
[    8.586409] systemd[1]: Queued start job for default target
Multi-User System.
[    8.603805] systemd[1]: Created slice Slice /system/getty.
[  OK  ] Created slice Slice /system/getty.
[    8.648833] systemd[1]: Created slice Slice /system/modprobe.
[  OK  ] Created slice Slice /system/modprobe.
[    8.688774] systemd[1]: Created slice Slice /system/serial-getty.
[  OK  ] Created slice Slice /system/serial-getty.
[    8.727817] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    8.766815] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[  OK  ] Started Dispatch Password =E2=80=A6ts to Console Directory Watch.
[    8.806596] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[  OK  ] Started Forward Password R=E2=80=A6uests to Wall Directory Watch.
[    8.846133] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    8.885810] systemd[1]: Reached target Slice Units.
[  OK  ] Reached target Slice Units.
[    8.915823] systemd[1]: Reached target Swaps.
[  OK  ] Reached target Swaps.
[    9.039331] systemd[1]: Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[    9.075978] systemd[1]: Reached target RPC Port Mapper.
[  OK  ] Reached target RPC Port Mapper.
[    9.118117] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[    9.157256] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[    9.209924] systemd[1]: Journal Audit Socket was skipped because of
a failed condition check (ConditionSecurity=3Daudit).
[    9.222922] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[    9.267869] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    9.307376] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[    9.348009] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    9.387020] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    9.427590] systemd[1]: Listening on User Database Manager Socket.
[  OK  ] Listening on User Database Manager Socket.
[    9.467036] systemd[1]: Huge Pages File System was skipped because
of a failed condition check
(ConditionPathExists=3D/sys/kernel/mm/hugepages).
[    9.481016] systemd[1]: POSIX Message Queue File System was skipped
because of a failed condition check
(ConditionPathExists=3D/proc/sys/fs/mqueue).
[    9.527378] systemd[1]: Mounting Kernel Debug File System...
         Mounting Kernel Debug File System...
[    9.558506] systemd[1]: Mounting Kernel Trace File System...
         Mounting Kernel Trace File System...
[    9.616712] systemd[1]: Mounting Temporary Directory /tmp...
         Mounting Temporary Directory /tmp...
[    9.656702] systemd[1]: Create List of Static Device Nodes was
skipped because of a failed condition check
(ConditionFileNotEmpty=3D/lib/modules/6.1.58/modules.devname).
[    9.707567] systemd[1]: Starting Load Kernel Module configfs...
         Starting Load Kernel Module configfs...
[    9.751753] systemd[1]: Starting Load Kernel Module drm...
         Starting Load Kernel Module drm...
[    9.798167] systemd[1]: Starting Load Kernel Module fuse...
         Starting Load Kernel Module fuse...
[    9.832532] systemd[1]: Starting RPC Bind...
         Starting RPC Bind...
[    9.886356] systemd[1]: File System Check on Root Device was
skipped because of a failed condition check
(ConditionPathIsReadWrite=3D!/).
[    9.957558] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    9.988890] systemd[1]: Load Kernel Modules was skipped because all
trigger condition checks failed.
[   10.042346] systemd[1]: Starting Generate network units from Kernel
command line...
         Starting Generate network =E2=80=A6ts from Kernel command line...
[   10.133724] systemd[1]: Starting Remount Root and Kernel File Systems...
         Starting Remount Root and Kernel File Systems...
[   10.243537] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[   10.343465] systemd[1]: Starting Coldplug All udev Devices...
[   10.374405] EXT4-fs (mmcblk0p2): re-mounted. Quota mode: none.
         Starting Coldplug All udev Devices...
[   10.534913] systemd[1]: Started RPC Bind.
[  OK  ] Started RPC Bind.
[   10.608027] systemd[1]: Mounted Kernel Debug File System.
[  OK  ] Mounted Kernel Debug File System.
[   10.637271] systemd[1]: Mounted Kernel Trace File System.
[  OK  ] Mounted Kernel Trace File System.
[   10.657321] systemd[1]: Mounted Temporary Directory /tmp.
[  OK  ] Mounted Temporary Directory /tmp.
[   10.681203] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[   10.737464] systemd[1]: Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module configfs.
[   10.760018] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   10.806004] systemd[1]: Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module drm.
[   10.849819] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   10.886052] systemd[1]: Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Module fuse.
[   10.936205] systemd[1]: Finished Generate network units from Kernel
command line.
[  OK  ] Finished Generate network units from Kernel command line.
[   10.969049] systemd[1]: Finished Remount Root and Kernel File Systems.
[  OK  ] Finished Remount Root and Kernel File Systems.
[   11.036198] systemd[1]: Finished Apply Kernel Variables.
[  OK  ] Finished Apply Kernel Variables.
[   11.087501] systemd[1]: Mounting FUSE Control File System...
         Mounting FUSE Control File System...
[   11.176360] systemd[1]: Mounting Kernel Configuration File System...
         Mounting Kernel Configuration File System...
[   11.215767] systemd[1]: Rebuild Hardware Database was skipped
because all trigger condition checks failed.
[   11.251767] systemd[1]: Platform Persistent Storage Archival was
skipped because of a failed condition check
(ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[   11.328008] systemd[1]: Starting Create System Users...
         Starting Create System Users...
[   11.364934] systemd[1]: Mounted FUSE Control File System.
[  OK  ] Mounted FUSE Control File System.
[   11.497676] systemd[1]: Mounted Kernel Configuration File System.
[  OK  ] Mounted Kernel Configuration File System.
[   11.646076] systemd[1]: Finished Create System Users.
[  OK  ] Finished Create System Users.
[   11.713902] systemd[1]: Starting Create Static Device Nodes in /dev...
         Starting Create Static Device Nodes in /dev...
[   11.874042] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
         Starting Flush Journal to Persistent Storage...
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Preparation for Local File Systems.
[   12.106123] systemd-journald[189]: Received client request to flush
runtime journal.
         Mounting /var/volatile...
         Starting Rule-based Manage=E2=80=A6for Device Events and Files...
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Mounted /var/volatile.
         Starting Load/Save Random Seed...
[  OK  ] Reached target Local File Systems.
         Starting Rebuild Dynamic Linker Cache...
         Starting Create Volatile Files and Directories...
[  OK  ] Finished Load/Save Random Seed.
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Finished Create Volatile Files and Directories.
         Starting Rebuild Journal Catalog...
         Starting Network Time Synchronization...
         Starting Record System Boot/Shutdown in UTMP...
[  OK  ] Finished Record System Boot/Shutdown in UTMP.
[  OK  ] Finished Rebuild Journal Catalog.
[   16.493054] platform 2008000.spi: deferred probe pending
[   16.499144] platform 200c000.spi: deferred probe pending
[  OK  ] Finished Rebuild Dynamic Linker Cache.
         Starting Update is Completed...
[  OK  ] Started Network Time Synchronization.
[  OK  ] Reached target System Time Set.
[  OK  ] Finished Update is Completed.
[  OK  ] Created slice Slice /system/systemd-backlight.
         Starting Load/Save Screen =E2=80=A6of backlight:backlight-lvds...
[   18.799032] mtdblock: MTD device 'spl' is NAND, please consider
using UBI block devices instead.
[   18.816735] mtdblock: MTD device 'env' is NAND, please consider
using UBI block devices instead.
[   18.828089] mtdblock: MTD device 'uboot' is NAND, please consider
using UBI block devices instead.
[  OK  ] Finished Load/Save Screen =E2=80=A6s of backlight:backlight-lvds.
[   18.876158] mtdblock: MTD device 'kernel' is NAND, please consider
using UBI block devices instead.
[   19.041189] mtdblock: MTD device 'dtb' is NAND, please consider
using UBI block devices instead.
[   19.110839] mtdblock: MTD device 'rootfs' is NAND, please consider
using UBI block devices instead.
[  OK  ] Finished Coldplug All udev Devices.
[   19.724404] coda 2040000.vpu: Firmware code revision: 46076
[   19.730290] coda 2040000.vpu: Initialized CODA960.
[   19.735106] coda 2040000.vpu: Firmware version: 3.1.1
[  OK  ] Reached target System Initialization.
[  OK  ] Started CUPS Scheduler.
[   19.976908] coda 2040000.vpu: coda-jpeg-encoder registered as video5
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Path Units.
[  OK  ] Reached target Timer Units.
[   20.070627] coda 2040000.vpu: coda-jpeg-decoder registered as video6
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[   20.152447] coda 2040000.vpu: coda-video-encoder registered as video7
[   20.209677] coda 2040000.vpu: coda-video-decoder registered as video8
[   20.338632] switch@0 enforce active low on chipselect handle
[  OK  ] Listening on [   20.369744] imx-sdma 20ec000.dma-controller:
loaded firmware 3.5
CUPS LPD Server Socket.
[  OK  ] Listening on CUPS Scheduler.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Socket Units.
[  OK  ] Reached target Basic System.
[  OK  ] Started Kernel Logging Service.
[  OK  ] Started System Logging Service.
         Starting D-Bus System Message Bus...
[  OK  ] Started Getty on tty1.
         Starting IPv6 Packet Filtering Framework...
         Starting IPv4 Packet Filtering Framework...
         Starting Turn OFF RGB LED...
         Starting Telephony service...
[  OK  ] Started Serial Getty on ttymxc1.
[   22.118482] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac4373 for chip BCM4373/0
[  OK  ] Reached target Login Prompts.
[   22.318014] usbcore: registered new interface driver brcmfmac
         Starting User Login Management...
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Finished IPv6 Packet Filtering Framework.
[  OK  ] Finished IPv4 Packet Filtering Framework.
[  OK  ] Finished Turn OFF RGB LED.
[   25.296596] sja1105 spi1.0: Probed switch chip: SJA1105Q
[   25.567725] sja1105 spi1.0: configuring for fixed/mii link mode
[   25.646176] sja1105 spi1.0 ethphy0 (uninitialized): PHY
[2188000.ethernet-1:00] driver [TI DP83848C 10/100 Mbps PHY]
(irq=3DPOLL)
[  OK  ] Started Telephony service.
[   25.805638] sja1105 spi1.0 ethphy1 (uninitialized): PHY
[2188000.ethernet-1:01] driver [TI DP83848C 10/100 Mbps PHY]
(irq=3DPOLL)
[   25.925915] device eth0 entered promiscuous mode
[   25.930974] DSA: tree 0 setup

FSLC FrameBuffer 4.0 ltts-imx6solo ttymxc1

ltts-imx6solo login: [   27.736803] usb 1-1.1.1: USB disconnect, device num=
ber 4
[   27.844068] brcmfmac: brcmf_usb_dl_cmd: usb_submit_urb failed -19
[   27.936752] sja1105 spi1.0: Link is Up - 100Mbps/Full - flow control off
[   28.235476] usb 1-1.1.1: new high-speed USB device number 6 using ci_hdr=
c
[   28.418004] usb 1-1.1.1: New USB device found, idVendor=3D04b4,
idProduct=3D0bdc, bcdDevice=3D 0.01
[   28.426753] usb 1-1.1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[   28.434317] usb 1-1.1.1: Product: Cypress USB 802.11 Wireless Adapter
[   28.440924] usb 1-1.1.1: Manufacturer: Cypress Semiconductor Corp.
[   28.447196] usb 1-1.1.1: SerialNumber: 000000000001
[   28.565571] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac4373 for chip BCM4373/0
[   28.627016] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4373/0
wl0: Nov 16 2022 23:54:18 version 13.10.246.300 (ed9caf7 CY) FWID
01-3b88916b
[   29.486120] Generic PHY fixed-0:00: attached PHY driver
(mii_bus:phy_addr=3Dfixed-0:00, irq=3DPOLL)
[   29.497422] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full -
flow control off
[   29.623164] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   29.637065] Bluetooth: BNEP socket layer initialized
[   29.836814] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   69.610610] cfg80211: failed to load regulatory.db
[   69.620405] Bluetooth: hci0: BCM 'brcm/BCM-04b4-640c.hcd' Patch
[   70.347701] Bluetooth: hci0: BCM: features 0x0f
[   70.353703] Bluetooth: hci0: CYW94373 UART 37.4MHz Class 1 wlbga sLNA-01=
02
[   70.360747] Bluetooth: hci0: BCM (001.001.025) build 0149
[   70.422010] Bluetooth: MGMT ver 1.22

ltts-imx6solo login: root
root@ltts-imx6solo:~# cat /usr/phynew.sh
#!/bin/sh

echo =3D=3D=3D=3D=3D=3D=3D MDIO: PHY0 =3D=3D=3D=3D=3D=3D=3D=3D
mdio 2188000.ethernet-1 phy 0 raw 0x0
mdio 2188000.ethernet-1 phy 0 raw 0x1
mdio 2188000.ethernet-1 phy 0 raw 0x2
mdio 2188000.ethernet-1 phy 0 raw 0x3
mdio 2188000.ethernet-1 phy 0 raw 0x4
mdio 2188000.ethernet-1 phy 0 raw 0x5
mdio 2188000.ethernet-1 phy 0 raw 0x6
mdio 2188000.ethernet-1 phy 0 raw 0x7
mdio 2188000.ethernet-1 phy 0 raw 0x10
mdio 2188000.ethernet-1 phy 0 raw 0x19

echo =3D=3D=3D=3D=3D=3D=3D MDIO: PHY1 =3D=3D=3D=3D=3D=3D=3D=3D
mdio 2188000.ethernet-1 phy 1 raw 0x0
mdio 2188000.ethernet-1 phy 1 raw 0x1
mdio 2188000.ethernet-1 phy 1 raw 0x2
mdio 2188000.ethernet-1 phy 1 raw 0x3
mdio 2188000.ethernet-1 phy 1 raw 0x4
mdio 2188000.ethernet-1 phy 1 raw 0x5
mdio 2188000.ethernet-1 phy 1 raw 0x6
mdio 2188000.ethernet-1 phy 1 raw 0x7
mdio 2188000.ethernet-1 phy 1 raw 0x10
mdio 2188000.ethernet-1 phy 1 raw 0x19

ip link set dev eth0 down
ip link set dev ethphy0 down
ip link set dev ethphy1 down

ip link set dev ethphy0 address 00:11:22:33:44:55
ip link set dev ethphy1 address 00:11:22:33:44:66

ip addr add dev ethphy0 169.254.178.1/16
ip addr add dev ethphy1 169.253.178.2/16

ip link set dev eth0 up
ip link set dev ethphy0 up
ip link set dev ethphy1 up
ip link

echo ########## MDIO: PHY0 ###########
mdio 2188000.ethernet-1 phy 0 raw 0x0
mdio 2188000.ethernet-1 phy 0 raw 0x1
mdio 2188000.ethernet-1 phy 0 raw 0x2
mdio 2188000.ethernet-1 phy 0 raw 0x3
mdio 2188000.ethernet-1 phy 0 raw 0x4
mdio 2188000.ethernet-1 phy 0 raw 0x5
mdio 2188000.ethernet-1 phy 0 raw 0x6
mdio 2188000.ethernet-1 phy 0 raw 0x7
mdio 2188000.ethernet-1 phy 0 raw 0x10
mdio 2188000.ethernet-1 phy 0 raw 0x19

echo ########## MDIO: PHY1 ###########
mdio 2188000.ethernet-1 phy 1 raw 0x0
mdio 2188000.ethernet-1 phy 1 raw 0x1
mdio 2188000.ethernet-1 phy 1 raw 0x2
mdio 2188000.ethernet-1 phy 1 raw 0x3
mdio 2188000.ethernet-1 phy 1 raw 0x4
mdio 2188000.ethernet-1 phy 1 raw 0x5
mdio 2188000.ethernet-1 phy 1 raw 0x6
mdio 2188000.ethernet-1 phy 1 raw 0x7
mdio 2188000.ethernet-1 phy 1 raw 0x10
mdio 2188000.ethernet-1 phy 1 raw 0x19


root@ltts-imx6solo:~# bash /usr/phynew.sh
=3D=3D=3D=3D=3D=3D=3D MDIO: PHY0 =3D=3D=3D=3D=3D=3D=3D=3D
[  162.426515] mdio_netlink: loading out-of-tree module taints kernel.
0x3100
0x7869
0x2000
0x5ca2
0x01e1
0x45e1
0x0007
0x2801
0x4015
0x8020
=3D=3D=3D=3D=3D=3D=3D MDIO: PHY1 =3D=3D=3D=3D=3D=3D=3D=3D
0x3100
0x7869
0x2000
0x5ca2
0x01e1
0x45e1
0x0007
0x2801
0x0015
0x8021
[  162.992201] Generic PHY fixed-0:00: attached PHY driver
(mii_bus:phy_addr=3Dfixed-0:00, irq=3DPOLL)
[  163.002179] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full -
flow control off
[  163.035906] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  163.074193] sja1105 spi1.0 ethphy0: configuring for phy/mii link mode
[  163.144909] sja1105 spi1.0 ethphy1: configuring for phy/mii link mode
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1504 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 1000
    link/ether 6a:fb:08:df:d3:77 brd ff:ff:ff:ff:ff:ff
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT
group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
4: ethphy0@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
    link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff
5: ethphy1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
    link/ether 00:11:22:33:44:66 brd ff:ff:ff:ff:ff:ff
6: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000
    link/ether c0:ee:40:82:2f:fc brd ff:ff:ff:ff:ff:ff

0x3100
0x7849
0x2000
0x5ca2
0x0141
0x0000
0x0005
0x2801
0x4000
0x8020

0x3100
0x7849
0x2000
0x5ca2
0x0141
0x0000
0x0005
0x2801
0x0000
0x8021
root@ltts-imx6solo:~# [  165.208656] sja1105 spi1.0 ethphy0: Link is
Up - 100Mbps/Full - flow control off
[  165.225788] sja1105 spi1.0 ethphy1: Link is Up - 100Mbps/Full -
flow control off
[  165.235925] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy0: link becomes ready
[  165.255777] IPv6: ADDRCONF(NETDEV_CHANGE): ethphy1: link becomes ready

root@ltts-imx6solo:~# ifconfig
eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504
        inet6 fe80::68fb:8ff:fedf:d377  prefixlen 64  scopeid 0x20<link>
        ether 6a:fb:08:df:d3:77  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ethphy0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 169.254.178.1  netmask 255.255.0.0  broadcast 0.0.0.0
        inet6 fe80::211:22ff:fe33:4455  prefixlen 64  scopeid 0x20<link>
        ether 00:11:22:33:44:55  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 30  bytes 4071 (3.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ethphy1: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 169.253.178.2  netmask 255.255.0.0  broadcast 0.0.0.0
        inet6 fe80::211:22ff:fe33:4466  prefixlen 64  scopeid 0x20<link>
        ether 00:11:22:33:44:66  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 30  bytes 4071 (3.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=3D73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 89  bytes 7675 (7.4 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 89  bytes 7675 (7.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

mytsl02383@MYTSL02383:~$ ifconfig -a
enp43s0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 169.254.178.2  netmask 255.255.0.0  broadcast 169.254.255.255
        inet6 fe80::d71b:4bdd:27bd:2a1a  prefixlen 64  scopeid 0x20<link>
        ether 00:be:43:20:9a:26  txqueuelen 1000  (Ethernet)
        RX packets 272356  bytes 27099064 (27.0 MB)
        RX errors 0  dropped 19  overruns 0  frame 0
        TX packets 862  bytes 300806 (300.8 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
mytsl02383@MYTSL02383:~$ ping 169.254.178.1
PING 169.254.178.1 (169.254.178.1) 56(84) bytes of data.
From 169.254.178.2 icmp_seq=3D1 Destination Host Unreachable

Let me know if you need any more details.

Thanks,
Jagan.

