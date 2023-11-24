Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F407F6B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjKXE7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjKXE6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:58:50 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC51728
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:58:46 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f94b07b6b3so991344fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700801924; x=1701406724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfhK67FyusLvStSApD7vetzf+oT4pnAcc7rPRlAFEMY=;
        b=XlbYglJSrrDixihSmeEBfvyGetEovlDTwN3BrfcW88/B8i47AK+vt3o4IH48drcBHw
         5bs5AWHJlnDqfqc6lgg17cndQbooyvtMZBAR0zyGWgszYfM6yBFV73cloCWXtFyQxxvp
         yRbQvHtWg4634BBm4KqqS/5GiweI2Ay/T6YrrTa5kj5iPzn6A7YB9jWdxB6dMxjTIX8F
         AxCHu9eUxL8MF656/IPvuvVUwSis6oXvW+z6XKWHFNnKg306t7ySHL6n2rEtcgSnAlXz
         rj/0qNmMWdCmcivta3pDxaA49cBlkDxTrY8iqsXE9zHNCXWwR5G+o+ttf4A5N2dL+cFF
         LMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700801924; x=1701406724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfhK67FyusLvStSApD7vetzf+oT4pnAcc7rPRlAFEMY=;
        b=VsO6pauADwB/M52OF+DyDdpbHjyVLJmHYJ6dmUe51/V0/qXtUBKnVZTlI82ZFPUNbQ
         HHcMmsRQNYOHu+00HGfiDqPP7YWTGuWeuSrxOEfw5IsB7e4fcbsTBiIJR3oCnDFlu89S
         AE0WEtknslic9Vl+Bg2KuTxL1kaWIUXbHLnDa3TFUWAL9rvNHLEx7KSHMT4ODAZY7Z9L
         B3HH0hiRBk8Yo1QJ9XA1cn0TALV6YHuwu6BpO8T6aRrQdgIExX6RqlZAX+UlAY7UjPDa
         /bs2zlRAzQAW7OvUQkX2ta1D8L8eMzWG8BEwI/qlTxj46lLRDLZ//cYbbZF3zmXrSMrl
         McNw==
X-Gm-Message-State: AOJu0YzKpJvrH2r0/qzzUv7xPsI9WkNiiZEURrLZpSmQqOetMIfgllkr
        1d+MWkZN/DN9OR7sEVOvlDaUD2fpvUmgANO5XCk=
X-Google-Smtp-Source: AGHT+IGAUvkpnx5D1rNimxZgo21GO3TZARewQ4I61N8MNb+4nwptwinuVw+ahLqzVFBlJGjG2DY0mf/cL5ijYHdzXao=
X-Received: by 2002:a05:6870:8894:b0:1f9:496b:e261 with SMTP id
 m20-20020a056870889400b001f9496be261mr1731527oam.15.1700801924026; Thu, 23
 Nov 2023 20:58:44 -0800 (PST)
MIME-Version: 1.0
References: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
 <CAGXv+5E4TXrPmhb++r3vMGA4WoPc=covi7_=zgLLcOhGt9UBgg@mail.gmail.com>
 <CAKpemQJDf9RqeOStB4Rm5hzuQdzYF6JEbuz00Cr-a80cWZKR6w@mail.gmail.com> <CAGXv+5HuxOtFfdWdocspTcDRytCK+0Ny+c_aFLJyHCUbYTboJQ@mail.gmail.com>
In-Reply-To: <CAGXv+5HuxOtFfdWdocspTcDRytCK+0Ny+c_aFLJyHCUbYTboJQ@mail.gmail.com>
From:   Bret Joseph <bretjoseph@gmail.com>
Date:   Fri, 24 Nov 2023 06:58:31 +0200
Message-ID: <CAKpemQLyieDP1r11v1WJ+-SXeseUiPKsCK6SBf-FSCOxGkEWHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] regulator: mt6358: Add output voltage fine tuning
 to variable LDOs
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ok if thats the case it means I will have to customize things on my end.


On Fri, 24 Nov 2023 at 06:29, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Please keep the whole CC list. Please don't top post.
>
> On Thu, Nov 23, 2023 at 7:27=E2=80=AFPM Bret Joseph <bretjoseph@gmail.com=
> wrote:
> >
> > /sys/kernel/debug/regmap/1000d000.pwrap/registers
> > 1e00: 2808
> > 1e02: 2808
> > 1e04: 2000
> > 1e06: 2000
> > 1e08: 2808
>
> According to the datasheet I have, x8xx is not a valid voltage setting.
> It wasn't valid before my patch either.
>
> This is vcama1.
>
> > 1e0a: 2808
> > 1e0c: 2000
> > 1e0e: 2000
> > 1e10: 0000 # I have deleted everything with 0000
> > 1e20: 2808
> > 1e22: 2808
> > 1e24: 2000
> > 1e26: 2000
> > 1e28: 2808
>
> x8xx is not valid here either. This is vcn33.
>
> > 1e2a: 2808
> > 1e2c: 2000
>
> x0xx is not valid here either. This is vsim1.
>
> > 1e2e: 2000
>
> x0xx for register 0x1e30 is not valid. This is vsim2.
> x0xx for register 0x1e38 is not valid. This is vemc.
> x0xx for register 0x1e3c is not valid. This is vldo28.
> x0xx for register 0x1e48 is not valid. This is vmch.
> x0xx for register 0x1e4c is not valid. This is vmc.
>
> > 1e80: 2808
> > 1e82: 2808
> > 1e84: 2000
> > 1e86: 2000
> > 1e88: 2808
> > 1e8a: 2808
> > 1e8c: 2000
> > 1e8e: 2000
>
> x0xx for register 0x1e98 is not valid. This is vefuse.
>
> > 1ea0: 2808
> > 1ea2: 2808
> > 1ea4: 2000
> > 1ea6: 2000
> > 1ea8: 2808
> > 1eaa: 2808
> > 1eac: 2000
> > 1eae: 2000
>
> x0xx for register 0x1eae is not valid. This is vcamd.
>
> So basically all the failures you see are due to (as far as the datasheet
> says) invalid values. The driver prior to my patch would error out as wel=
l.
>
> Either the register readback is faulty on your platform, or your bootload=
er
> has configured the system into a weird state.
>
>
> ChenYu
>
> > /sys/kernel/debug/regulator/regulator_summary
> >  regulator                      use open bypass  opmode voltage
> > current     min     max
> > -----------------------------------------------------------------------=
----------------
> >  regulator-dummy         3   35      0 unknown     0mV     0mA     0mV =
    0mV
> >    vdram1                      0    0      0  normal   500mV     0mA
> > 500mV  2087mV
> >    vcore                         0    0      0  normal   500mV     0mA
> >   500mV  1293mV
> >    vpa                            0    0      0  normal   500mV
> > 0mA   500mV  3650mV
> >    vproc11                     0    0      0  normal   500mV     0mA
> > 500mV  1293mV
> >    vproc12                     0    0      0  normal   500mV     0mA
> > 500mV  1293mV
> >    vgpu                          0    0      0  normal   500mV     0mA
> >   500mV  1293mV
> >    vs2                            0    0      0  normal   500mV
> > 0mA   500mV  2087mV
> >    vmodem                    0    0      0  normal   500mV     0mA
> > 500mV  1293mV
> >    vs1                            2    5      0  normal  1000mV
> > 0mA  1000mV  2587mV
> >       vio18                      1    0      0 unknown  1800mV     0mA
> >  1800mV  1800mV
> >       vcamio                   0    0      0 unknown  1800mV     0mA
> > 1800mV  1800mV
> >       vcn18                     0    0      0 unknown  1800mV     0mA
> > 1800mV  1800mV
> >       vefuse                    0    0      0 unknown  1700mV     0mA
> > 1700mV  1900mV
> >       vrf18                       0    0      0 unknown  1800mV
> > 0mA  1800mV  1800mV
> >    vdram2                      0    0      0 unknown   600mV     0mA
> > 600mV  1800mV
> >    vsim1                         0    0      0 unknown  1700mV     0mA
> >  1700mV  3100mV
> >    vibr                            0    0      0 unknown  1200mV
> > 0mA  1200mV  3300mV
> >    vrf12                          0    0      0 unknown  1200mV
> > 0mA  1200mV  1200mV
> >    vusb                           0    0      0 unknown  3000mV
> > 0mA  3000mV  3100mV
> >    vcamd                        0    0      0 unknown   900mV     0mA
> >  900mV  1800mV
> >    vfe28                          0    0      0 unknown  2800mV
> > 0mA  2800mV  2800mV
> >    vsram_proc11            0    0      0 unknown   500mV     0mA   500m=
V  1293mV
> >    vcn28                         0    0      0 unknown  2800mV     0mA
> >  2800mV  2800mV
> >    vsram_others             0    0      0 unknown   500mV     0mA
> > 500mV  1293mV
> >    vsram_gpu                 0    0      0 unknown   500mV     0mA
> > 500mV  1293mV
> >    vxo22                         0    0      0 unknown  2200mV     0mA
> >  2200mV  2200mV
> >    vaux18                       0    0      0 unknown  1800mV     0mA
> > 1800mV  1800mV
> >    vmch                          0    0      0 unknown  2900mV     0mA
> >  2900mV  3300mV
> >    vbif28                         0    0      0 unknown  2800mV
> > 0mA  2800mV  2800mV
> >    vsram_proc12            0    0      0 unknown   550mV     0mA   500m=
V  1293mV
> >    vcama1                      0    0      0 unknown  1800mV     0mA
> > 1800mV  3000mV
> >    vemc                          0    0      0 unknown  2900mV     0mA
> >  2900mV  3300mV
> >    vio28                          1    0      0 unknown  2800mV
> > 0mA  2800mV  2800mV
> >    va12                           0    0      0 unknown  1200mV
> > 0mA  1200mV  1200mV
> >    VCN33                       0    0      0 unknown  3300mV     0mA
> >   0mV     0mV
> >    vcama2                      0    0      0 unknown  1800mV     0mA
> > 1800mV  3000mV
> >    vmc                            0    0      0 unknown  1800mV
> > 0mA  1800mV  3300mV
> >    vldo28                        0    0      0 unknown  2800mV     0mA
> >  2800mV  3000mV
> >    vaud28                       0    0      0 unknown  2800mV     0mA
> > 2800mV  2800mV
> >    vsim2                         0    0      0 unknown  1700mV     0mA
> >  1700mV  3100mV
> >
> > I have also seen errors when consumers use regulators which I think
> > could be related to setting values on regulators
> > Here is an example using mtk-ccifreq driver
> > [ 0.668869] mtk-ccifreq cci: no pinctrl handle
> > [ 0.669128] device: 'regulator:regulator.5--platform:cci': device_add
> > [ 0.669278] devices_kset: Moving cci to end of list
> > [ 0.669311] PM: Moving platform:cci to end of list
> > [ 0.669340] mtk-ccifreq cci: Linked as a consumer to regulator.5
> > [ 0.669713] of: _opp_add_static_v2: turbo:0 rate:500000000 uv:600000
> > uvmin:600000 uvmax:600000 latency:0 level:0
> > [ 0.669969] of: _opp_add_static_v2: turbo:0 rate:560000000 uv:675000
> > uvmin:675000 uvmax:675000 latency:0 level:0
> > [ 0.670245] of: _opp_add_static_v2: turbo:0 rate:612000000 uv:693750
> > uvmin:693750 uvmax:693750 latency:0 level:0
> > [ 0.670512] of: _opp_add_static_v2: turbo:0 rate:682000000 uv:718750
> > uvmin:718750 uvmax:718750 latency:0 level:0
> > [ 0.670763] of: _opp_add_static_v2: turbo:0 rate:752000000 uv:743750
> > uvmin:743750 uvmax:743750 latency:0 level:0
> > [ 0.671031] of: _opp_add_static_v2: turbo:0 rate:822000000 uv:768750
> > uvmin:768750 uvmax:768750 latency:0 level:0
> > [ 0.671598] of: _opp_add_static_v2: turbo:0 rate:875000000 uv:781250
> > uvmin:781250 uvmax:781250 latency:0 level:0
> > [ 0.671921] of: _opp_add_static_v2: turbo:0 rate:927000000 uv:800000
> > uvmin:800000 uvmax:800000 latency:0 level:0
> > [ 0.672178] of: _opp_add_static_v2: turbo:0 rate:980000000 uv:818750
> > uvmin:818750 uvmax:818750 latency:0 level:0
> > [ 0.672434] of: _opp_add_static_v2: turbo:0 rate:1050000000 uv:843750
> > uvmin:843750 uvmax:843750 latency:0 level:0
> > [ 0.672681] of: _opp_add_static_v2: turbo:0 rate:1120000000 uv:862500
> > uvmin:862500 uvmax:862500 latency:0 level:0
> > [ 0.672945] of: _opp_add_static_v2: turbo:0 rate:1155000000 uv:887500
> > uvmin:887500 uvmax:887500 latency:0 level:0
> > [ 0.673200] of: _opp_add_static_v2: turbo:0 rate:1190000000 uv:906250
> > uvmin:906250 uvmax:906250 latency:0 level:0
> > [ 0.673465] of: _opp_add_static_v2: turbo:0 rate:1260000000 uv:950000
> > uvmin:950000 uvmax:950000 latency:0 level:0
> > [ 0.673720] of: _opp_add_static_v2: turbo:0 rate:1330000000 uv:993750
> > uvmin:993750 uvmax:993750 latency:0 level:0
> > [ 0.673988] of: _opp_add_static_v2: turbo:0 rate:1400000000 uv:1031250
> > uvmin:1031250 uvmax:1031250 latency:0 level:0
> > [ 0.674327] device: 'cci': device_add
> > [ 0.674499] PM: Adding info for No Bus:cci
> > [ 0.674643] mtk-ccifreq cci: error -EPROBE_DEFER: devfreq_add_device:
> > Unable to start governor for the device
> > [ 0.675571] device: 'cci': device_unregister
> > [ 0.675730] PM: Removing info for No Bus:cci
> > [ 0.675862] mtk-ccifreq cci: failed to add devfreq device: -517
> > [ 0.680084] mtk-ccifreq cci: Driver mtk-ccifreq requests probe deferral
> > [ 0.680148] ------------[ cut here ]------------
> > [ 0.680163] WARNING: CPU: 6 PID: 56 at _regulator_put+0x340/0x354
> > [ 0.680190] Modules linked in:
> > [ 0.680208] CPU: 6 PID: 56 Comm: kworker/u16:1 Tainted: G W
> > 6.7.0-rc1-next-20231115-g2b600507077d-dirty #34
> > [ 0.680232] Hardware name: MT6769H (DT)
> > [ 0.680246] Workqueue: events_unbound deferred_probe_work_func
> > [ 0.680268] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
> > [ 0.680285] pc : _regulator_put+0x340/0x354
> > [ 0.680302] lr : regulator_put+0x58/0x8c
> > [ 0.680317] sp : ffffffc080483950
> > [ 0.680328] x29: ffffffc080483950 x28: ffffff80c0030000 x27: ffffffdd00=
2037f0
> > [ 0.680353] x26: ffffffdd01747650 x25: ffffff80c0f5d0c0 x24: ffffffdd00=
180d80
> > [ 0.680376] x23: ffffffc080483a98 x22: ffffffdd01f46d50 x21: ffffff80c0=
f5d780
> > [ 0.680400] x20: ffffffdd01ee2bc0 x19: ffffff80c0f5d780 x18: ffffff80c1=
f8c660
> > [ 0.680423] x17: 000000040044ffff x16: 005000f4b5593519 x15: ffffffdd02=
21fdb0
> > [ 0.680446] x14: 0000000000000891 x13: 0000000000000891 x12: 0000000000=
000001
> > [ 0.680468] x11: 0000000000000891 x10: 000000000001cde2 x9 : 0000000000=
001464
> > [ 0.680491] x8 : 000000008020001f x7 : ffffff80c249e600 x6 : 0000000000=
00018d
> > [ 0.680513] x5 : 00000000000091ec x4 : 00000000000091d3 x3 : ffffffdd01=
a5e070
> > [ 0.680535] x2 : 0000000000000001 x1 : ffffffdd01ee2b60 x0 : 0000000000=
000002
> > [ 0.680558] Call trace:
> > [ 0.680568] _regulator_put+0x340/0x354
> > [ 0.680583] regulator_put+0x58/0x8c
> > [ 0.680597] devm_regulator_release+0x30/0x4c
> > [ 0.680613] release_nodes+0x8c/0xdc
> > [ 0.680629] devres_release_all+0xc0/0x164
> > [ 0.680646] device_unbind_cleanup+0x34/0xe4
> > [ 0.680660] really_probe+0x200/0x75c
> > [ 0.680674] __driver_probe_device+0x100/0x2e4
> > [ 0.680688] driver_probe_device+0x6c/0x1d4
> > [ 0.680703] __device_attach_driver+0x170/0x238
> > [ 0.680717] bus_for_each_drv+0xbc/0x18c
> > [ 0.680734] __device_attach+0x124/0x2ec
> > [ 0.680748] device_initial_probe+0x30/0x4c
> > [ 0.680762] bus_probe_device+0x138/0x168
> > [ 0.680775] deferred_probe_work_func+0x134/0x1fc
> > [ 0.680790] process_scheduled_works+0x26c/0x73c
> > [ 0.680808] worker_thread+0x294/0x690
> > [ 0.680823] kthread+0x1fc/0x22c
> > [ 0.680837] ret_from_fork+0x10/0x20
> > [ 0.680853] ---[ end trace 0000000000000000 ]---
> > [ 0.680923] mtk-ccifreq cci: Dropping the link to regulator.5
> > [ 0.680941] device: 'regulator:regulator.5--platform:cci': device_unreg=
ister
> > [ 0.681041] platform cci: Added to deferred list
> >
> > On Thu, 23 Nov 2023 at 08:25, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > >
> > > Hi Bret,
> > >
> > > On Thu, Nov 16, 2023 at 12:52=E2=80=AFAM Bret Joseph <bretjoseph@gmai=
l.com> wrote:
> > > >
> > > > In mt6358-regulator.c
> > > >
> > > > static const struct regulator_ops mt6358_volt_table_ops =3D {
> > > >     .list_voltage =3D regulator_list_voltage_pickable_linear_range,
> > > >     .map_voltage =3D regulator_map_voltage_pickable_linear_range,
> > > >     .set_voltage_sel =3D regulator_set_voltage_sel_pickable_regmap,
> > > >     .get_voltage_sel =3D mt6358_get_buck_voltage_sel /*regulator_ge=
t_voltage_sel_pickable_regmap*/,
> > > >     .set_voltage_time_sel =3D regulator_set_voltage_time_sel,
> > > >     .enable =3D regulator_enable_regmap,
> > > >     .disable =3D regulator_disable_regmap,
> > > >     .is_enabled =3D regulator_is_enabled_regmap,
> > > >     .get_status =3D mt6358_get_status,
> > > > };
> > > >
> > > > the function [regulator_get_voltage_sel_pickable_regmap] causes a -=
EINVAL=E2=80=AC when registering
> > > >
> > > > vsim1 vusb vcamd vefuse vmch vcama1 vemc vmc vldo28 vsim2
> > > >
> > > > using [mt6358_get_buck_voltage_sel] results in a successful probe
> > >
> > > Sure it will probe, but any values you read back will be bogus.
> > >
> > > Can you provide a dump of /sys/kernel/debug/regulator/regulator_summa=
ry
> > > and `grep ^1e..: /sys/kernel/debug/regmap/1000d000.pwrap/registers`,
> > > and also any relevant logs?
> > >
> > > ChenYu
