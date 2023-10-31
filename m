Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8D7DD453
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjJaRLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjJaRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:11:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB71B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:11:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40837ebba42so39086925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698772258; x=1699377058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hG5ETkTuNrf6KK1bB0ZgfqAbszVVBfmdYME5EdmIhg=;
        b=PQOos9T4qPCO/8KJbW//TCGUI17gYbbPEPO+q5pC+3WDAyYgBZvG8FzlKunqrLG1Zi
         Du5k+f/4ewcZCMn2IHcWcXWSExmnF4olXBaaDsVO+lkm3YFcMkz8+UWzSvihQKANMSMa
         h5AZVX/OT1HuViXVdNUCFh7ROROHTOiZ9khC24FnSLICjC61Jd1SoYafGKTT6S5ZzQES
         EWnqwmFMrbCfv61fV+e69VXvjsl+SkO/0O4ZiApKXl9YZyAi9qRA6/Z6rgk0/oqJKpvW
         Md03qu2Di5AfLYacolbMB98Hg305/kb8uZh9iws6TtNQZrRPYKPDJ7BkYVZ/Ej+Tjjwj
         npYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772258; x=1699377058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hG5ETkTuNrf6KK1bB0ZgfqAbszVVBfmdYME5EdmIhg=;
        b=toPt+nYX6oZ2pBBz/D9XLpNCljx+Ca14IzGcBb/JuejYjWph3Fz9URDzAWVRku3fjj
         Qr2cuWVOYjU9Y2eE2V/APL3+SsBMuYOAK1mdcwjtcDGMX8BYNPYLZuSyBuO/mqjPgjVJ
         r2KUHdPCKkMdI/i6YKg6eF/eky99kLA+TLSba+Co2wSpsUvC0ofK9bElxJTQrQxDGG95
         Oyg1zlq3MMyz9zSFaM3F73EDGVFGMUQ1hMFsfSEkdwbaFNRAJ8XuGeGquCED4gO5dHPM
         d2rP8USBizwcNxZ3Q+T/PZZsA2Ai+aUwSIyL8Ag8DWGxKh+skBiIS1CrbPBlafQIa7pY
         295A==
X-Gm-Message-State: AOJu0YwKCjWk9q1iqiNa9WuY+XvFO2yZ12mMuVf/ILFRkxIvHf45Zjip
        lWPraOxpVbweg+ghuk7l845ncQ==
X-Google-Smtp-Source: AGHT+IGWkOX2KWxdhnPOaVhZDYxwxShGQt4+bSCz+3ner/geP+bqBZF/CZeQGL2ly06Ea34s9R+Pgg==
X-Received: by 2002:a05:600c:1d95:b0:409:375:5a44 with SMTP id p21-20020a05600c1d9500b0040903755a44mr10948586wms.24.1698772258547;
        Tue, 31 Oct 2023 10:10:58 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600c2e4200b004064e3b94afsm2230179wmf.4.2023.10.31.10.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:10:58 -0700 (PDT)
Message-ID: <4d30de97-597a-47c3-a58f-7034f2e91439@linaro.org>
Date:   Tue, 31 Oct 2023 17:10:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
 <20231026155042.551731-6-bryan.odonoghue@linaro.org>
 <d411e561-b0d0-48db-959e-3347006bce77@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <d411e561-b0d0-48db-959e-3347006bce77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 10:53, Konrad Dybcio wrote:
>> +
>> +	if (res->pd_name) {
> No need to nullcheck, dev_pm_domain_attach_by_name seems to return
> NULL when the name is NULL

So I tried removing the NULL check and of_property_match_string chokes

[    9.303798] msm_vfe_subdev_init/1386 camss->dev 000000004c790a88 
res->pd_name ife0
[    9.317650] msm_vfe_subdev_init/1386 camss->dev 000000004c790a88 
res->pd_name ife1
[    9.328085] msm_vfe_subdev_init/1386 camss->dev 000000004c790a88 
res->pd_name (null)
[    9.330602] lt9611uxc 5-002b: LT9611 revision: 0x17.04.93
[    9.336128] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
[    9.350861] Mem abort info:
[    9.353751]   ESR = 0x0000000096000004
[    9.357617]   EC = 0x25: DABT (current EL), IL = 32 bits
[    9.363083]   SET = 0, FnV = 0
[    9.366231]   EA = 0, S1PTW = 0
[    9.368917] remoteproc remoteproc1: powering up 17300000.remoteproc
[    9.369463]   FSC = 0x04: level 0 translation fault
[    9.380922] Data abort info:
[    9.383919]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    9.389579]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    9.394775]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    9.395986] remoteproc remoteproc1: Booting fw image 
qcom/sm8250/adsp.mbn, size 15515796
[    9.400187] ax88179_178a 2-1.1:1.0 eth0: register 'ax88179_178a' at 
usb-xhci-hcd.0.auto-1.1, ASIX AX88179 USB 3.0 Gigabit Ethernet, 
00:0e:c6:81:79:01
[    9.400237] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001067b2000
[    9.400239] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    9.400242] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    9.400243] Modules linked in: venus_enc venus_dec 
videobuf2_dma_contig qcom_camss(+) fastrpc qrtr_smd venus_core imx412 
videobuf2_dma_sg mcp251xfd msm v4l2_fwnode v4l2_mem2mem videc
[    9.409624] lt9611uxc 5-002b: LT9611 version: 0x43
[    9.422292]  snd_soc_sm8250 qcom_spmi_adc_tm5 qcom_spmi_adc5 
videobuf2_common xhci_plat_hcd drm_dp_aux_bus snd_soc_qcom_sdw xhci_hcd 
crct10dif_ce qrtr rtc_pm8xxx qcom_vadc_common qcs
[    9.492865] lt9611uxc 5-002b: failed to find dsi host
[    9.529472] CPU: 7 PID: 205 Comm: (udev-worker) Not tainted 
6.6.0-rc3-00380-g7b823ffc4ec0-dirty #1
[    9.529474] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[    9.529475] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    9.529477] pc : __pi_strcmp+0x24/0x140
[    9.529482] lr : of_property_match_string+0x6c/0x130
[    9.536672] msm_dsi ae94000.dsi: supply refgen not found, using dummy 
regulator
[    9.543865] sp : ffff800080d8b6d0
[    9.543866] x29: ffff800080d8b6d0 x28: ffffd06ec3419ef8 x27: 
ffff12a54b8660a0
[    9.543868] x26: 0000000000000000 x25: ffffd06f3cca22b0 x24: 
ffffd06f3d8e2798
[    9.543870] x23: 0000000000000000 x22: 0000000000000000 x21: 
fffffbfffde0e590
[    9.599837] x20: fffffbfffde0e59e x19: fffffbfffde0e595 x18: 
ffffffffffffffff
[    9.607171] x17: 6d616e5f64703e2d x16: ffffd06f3bc66bc4 x15: 
3937633430303030
[    9.614503] x14: ffffffffffffffff x13: 0000000000000020 x12: 
0101010101010101
[    9.621839] x11: 7f7f7f7f7f7f7f7f x10: fffffbfffde0e590 x9 : 
7f7f7f7f7f7f7f7f
[    9.629174] x8 : 0101010101010101 x7 : 0000000080000000 x6 : 
0000000000000000
[    9.636507] x5 : 6f63710000000000 x4 : 000000706f740031 x3 : 
6566760030656676
[    9.643840] x2 : fffffbfffde0e5a0 x1 : fffffbfffde0e590 x0 : 
0000000000000000
[    9.651174] Call trace:
[    9.653698]  __pi_strcmp+0x24/0x140
[    9.657285]  genpd_dev_pm_attach_by_name+0x2c/0x64
[    9.662217]  dev_pm_domain_attach_by_name+0x20/0x2c
[    9.667231]  msm_vfe_subdev_init+0x78/0x50c [qcom_camss]
[    9.672704]  camss_probe+0x288/0xc8c [qcom_camss]
[    9.677542]  platform_probe+0x68/0xc0
[    9.681311]  really_probe+0x184/0x3c8
[    9.685081]  __driver_probe_device+0x7c/0x16c
[    9.689562]  driver_probe_device+0x3c/0x110
[    9.693862]  __driver_attach+0xf4/0x1fc
[    9.697811]  bus_for_each_dev+0x74/0xd4
[    9.701762]  driver_attach+0x24/0x30
[    9.705446]  bus_add_driver+0x110/0x214
[    9.709397]  driver_register+0x60/0x128
[    9.713348]  __platform_driver_register+0x28/0x34
[    9.718180]  qcom_camss_driver_init+0x20/0x1000 [qcom_camss]
[    9.723998]  do_one_initcall+0x6c/0x1b0
[    9.727950]  do_init_module+0x58/0x1e4
[    9.731804]  load_module+0x1df4/0x1ee0
[    9.735656]  init_module_from_file+0x84/0xc4
[    9.740041]  __arm64_sys_finit_module+0x1f4/0x300
[    9.744871]  invoke_syscall+0x48/0x114
[    9.748724]  el0_svc_common.constprop.0+0xc0/0xe0
[    9.753555]  do_el0_svc+0x1c/0x28
[    9.756962]  el0_svc+0x40/0xe8
[    9.760102]  el0t_64_sync_handler+0x100/0x12c
[    9.764583]  el0t_64_sync+0x190/0x194
[    9.768352] Code: 54000401 b50002c6 d503201f f86a6803 (f8408402)
[    9.774609] ---[ end trace 0000000000000000 ]---

---
bod
