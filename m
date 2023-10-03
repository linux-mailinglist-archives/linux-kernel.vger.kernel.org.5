Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47E7B5EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjJCCRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjJCCRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:17:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0547AD;
        Mon,  2 Oct 2023 19:17:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50305abe5f0so465416e87.2;
        Mon, 02 Oct 2023 19:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696299432; x=1696904232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vy7HP7S+bIn4v9pIEd0dIc0fwjXzhU2HqPC7qUpnLI=;
        b=FBJW8xNl1igx46yD016YT2TUFSemd7HNidr6igybyqi1iVe7l9ZeZw1N4F6wgAZErx
         z89LG0gZA5uBDdRIPZu/bl3fzTTxy2ywQ7CTB34CRCrU0WuaEpwfypmnri2W1jlWYwwb
         HREOlRjmePYdGncN8af/wqxo2uAkS/opXcWBV5oqSmSOFEMiJbiKwuRaU5hh5QQ69+dZ
         Zny1VuCs+O1XnoOKG7/ZDc5vEkifDbGHOZ8icBYIhlqLzOgCB+FQUPC7jc/UtlPjWlx8
         8rV2V6l9/805L1n9ZSMQ8VKRjJB4BCso9R6uJkFusGm3lvH9Z/nruEsyZBAvnXqSoLmD
         D4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696299432; x=1696904232;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vy7HP7S+bIn4v9pIEd0dIc0fwjXzhU2HqPC7qUpnLI=;
        b=ozGz1xfzJCMLj80U7WuNeWhbI9hwMy7CSDJ2G3A04siDwRgcKiP2NBOnzuFLSAsYNU
         MNRNvny/83SNxldcFuG2Vtc/YSdXzbEmenEvn28wb6hOlZc/SnJ2/57g/winOLzDoRxE
         raDEs5Xbf1PSaW2fMFkf19RMpWy/2CzxvvNY7VzHMJr04AYygFeSC0tPJviwI/7hDSe1
         BPW/7zDxL7ur2tfISlMOk3VGOyZ4O1uSwfI/tutY6NhNbMEig2VxNqdSBC+UuY5FEBSb
         Vd/GSOmKy1fQAV3h28cxo28TKEOfXqozzoVb5SGYiBE/Wc/+CKSMOpmigfUZ4KvZ3ceR
         R+3g==
X-Gm-Message-State: AOJu0YyEfm2OgJhVLXhhaAsjU/zGkxkYNG5x+BfKF55gpf3tL2m/uAA+
        RKQFRf7GnpzXOHS6RRYHevnt7jdao9nbxL60BKo=
X-Google-Smtp-Source: AGHT+IHJS1T/GroG+DU47CRG6NyZHgzyeh+7aBS/B7HZ38LrhMLxPXT3GdPENECEp/F88DUlqojOhqZNFzy6blEiAUI=
X-Received: by 2002:a19:8c43:0:b0:4fe:1681:9377 with SMTP id
 i3-20020a198c43000000b004fe16819377mr10120810lfj.44.1696299431581; Mon, 02
 Oct 2023 19:17:11 -0700 (PDT)
MIME-Version: 1.0
From:   Sophon Wu <wuxilin123@gmail.com>
Date:   Tue, 3 Oct 2023 10:17:01 +0800
Message-ID: <CAEPPPKu=yxS6SgdLZiuhbF2DRURKVUBNgNbUQ96LxHHbtsJ6Sg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clk: qcom: add SM8550 DISPCC driver
To:     neil.armstrong@linaro.org
Cc:     Andy Gross <agross@kernel.org>, andersson@kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 16:47, Neil Armstrong wrote:

> Add support for the display clock controller found in SM8550
> based devices.

> This clock controller feeds the Multimedia Display SubSystem (MDSS).
> This driver is based on the SM8450 support.

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Hi Neil,

I'm trying to enable display on SM8550 but having trouble with clocks. Do you
have any idea on this maybe? Full dmesg here: https://bpa.st/7E6Q

Regards,
Xilin

 ------------[ cut here ]------------
 disp_cc_mdss_mdp_clk_src: rcg didn't update its configuration.
 WARNING: CPU: 4 PID: 73 at drivers/clk/qcom/clk-rcg2.c:133
update_config+0xd4/0xf0
 Modules linked in:
 CPU: 4 PID: 73 Comm: kworker/u16:2 Tainted: G S
6.6.0-rc3-next-20230929-00006-g019d41d2e78e-dirty #252
d692e32c53d7001f1537e28f80b45291db95a48f
 Hardware name: AYN Odin 2 (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 614000c5 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
 pc : update_config+0xd4/0xf0
 lr : update_config+0xd4/0xf0
 sp : ffff8000861435d0
 x29: ffff8000861435d0 x28: 0000000000000000 x27: 0000000000000000
 x26: ffff0008011da0f4 x25: 0000000000000000 x24: 0000000000000000
 x23: 0000000000000004 x22: ffff000804f0eac0 x21: ffff800082395f68
 x20: ffff800085109c20 x19: 0000000000000000 x18: 0000000000000014
 x17: 0000000043567dcd x16: 00000000c6ba16a0 x15: 0000000040b16970
 x14: 0000000000000001 x13: 2e6e6f6974617275 x12: 6769666e6f632073
 x11: 7469206574616470 x10: 752074276e646964 x9 : ffff8000801bfc5c
 x8 : 2073746920657461 x7 : 6470752074276e64 x6 : 0000000000000010
 x5 : 40000000ffff0254 x4 : ffff8000848907d0 x3 : 00000000ffffffff
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000801320000
 Call trace:
  update_config+0xd4/0xf0
  clk_rcg2_shared_enable+0x58/0x98
  clk_core_enable+0x78/0x1f8
  clk_core_enable+0x58/0x1f8
  clk_enable+0x34/0x60
  clk_bulk_enable+0x54/0xe8
  msm_mdss_enable+0xac/0x250
  mdss_runtime_resume+0x3c/0x58
  pm_generic_runtime_resume+0x34/0x58
  __genpd_runtime_resume+0x38/0x90
  genpd_runtime_resume+0x11c/0x2b0
  __rpm_callback+0x50/0x1f0
  rpm_callback+0x74/0x88
  rpm_resume+0x534/0x760
  __pm_runtime_resume+0x64/0xc0
  __device_attach+0x8c/0x1c0
  device_initial_probe+0x1c/0x30
  bus_probe_device+0xb4/0xc0
  device_add+0x64c/0x848
  of_device_add+0x4c/0x70
  of_platform_device_create_pdata+0x94/0x130
  of_platform_bus_create+0x188/0x4c8
  of_platform_populate+0x60/0x160
  mdss_probe+0x278/0x398
  platform_probe+0x70/0xd8
  really_probe+0x190/0x3d8
  __driver_probe_device+0x84/0x180
  driver_probe_device+0x44/0x120
  __device_attach_driver+0xc4/0x168
  bus_for_each_drv+0x8c/0xf0
  __device_attach+0xa4/0x1c0
  device_initial_probe+0x1c/0x30
  bus_probe_device+0xb4/0xc0
  deferred_probe_work_func+0xbc/0x118
  process_one_work+0x154/0x3c8
  worker_thread+0x2bc/0x3e0
  kthread+0x118/0x128
  ret_from_fork+0x10/0x20
 ---[ end trace 0000000000000000 ]---
 Failed to enable clk '(null)': -16
 msm-mdss ae00000.display-subsystem: clock enable failed, ret:-16
 ------------[ cut here ]------------
 disp_cc_mdss_ahb_clk status stuck at 'off'
 WARNING: CPU: 4 PID: 73 at drivers/clk/qcom/clk-branch.c:86
clk_branch_wait+0x148/0x168
 Modules linked in:
 CPU: 4 PID: 73 Comm: kworker/u16:2 Tainted: G S      W
6.6.0-rc3-next-20230929-00006-g019d41d2e78e-dirty #252
d692e32c53d7001f1537e28f80b45291db95a48f
 Hardware name: AYN Odin 2 (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 614000c5 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
 pc : clk_branch_wait+0x148/0x168
 lr : clk_branch_wait+0x148/0x168
 sp : ffff800086143650
 x29: ffff800086143650 x28: 0000000000000000 x27: 0000000000000000
 x26: 0000000000000000 x25: ffff000a7e7b50d8 x24: ffff80008517ac90
 x23: ffff800082395ed0 x22: 0000000000000001 x21: ffff800080bb09f0
 x20: 0000000000000000 x19: ffff8000851094d0 x18: 0000000000000006
 x17: 0000000000000000 x16: 0000000000000020 x15: 0000000000000002
 x14: 0000000000000001 x13: 0000000000000004 x12: 0000000000000000
 x11: 0000000000000000 x10: 0000000000000020 x9 : ffff8000801bfc5c
 x8 : 0000000000000020 x7 : 00000000ffffffff x6 : 0000000000000000
 x5 : 0000000000000050 x4 : ffff800083df7e80 x3 : 00000000ffffffff
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000801320000
 Call trace:
  clk_branch_wait+0x148/0x168
  clk_branch2_enable+0x38/0x50
  clk_core_enable+0x78/0x1f8
  clk_enable+0x34/0x60
  dsi_phy_enable_resource+0x98/0xb8
  dsi_phy_driver_probe+0x26c/0x408
  platform_probe+0x70/0xd8
  really_probe+0x190/0x3d8
  __driver_probe_device+0x84/0x180
  driver_probe_device+0x44/0x120
  __device_attach_driver+0xc4/0x168
  bus_for_each_drv+0x8c/0xf0
  __device_attach+0xa4/0x1c0
  device_initial_probe+0x1c/0x30
  bus_probe_device+0xb4/0xc0
  device_add+0x64c/0x848
  of_device_add+0x4c/0x70
  of_platform_device_create_pdata+0x94/0x130
  of_platform_bus_create+0x188/0x4c8
  of_platform_populate+0x60/0x160
  mdss_probe+0x278/0x398
  platform_probe+0x70/0xd8
  really_probe+0x190/0x3d8
  __driver_probe_device+0x84/0x180
  driver_probe_device+0x44/0x120
  __device_attach_driver+0xc4/0x168
  bus_for_each_drv+0x8c/0xf0
  __device_attach+0xa4/0x1c0
  device_initial_probe+0x1c/0x30
  bus_probe_device+0xb4/0xc0
  deferred_probe_work_func+0xbc/0x118
  process_one_work+0x154/0x3c8
  worker_thread+0x2bc/0x3e0
  kthread+0x118/0x128
  ret_from_fork+0x10/0x20
 ---[ end trace 0000000000000000 ]---
 msm_dsi_phy ae97000.phy: [drm:dsi_phy_enable_resource] *ERROR*
dsi_phy_enable_resource: can't enable ahb clk, -16
 msm_dsi_phy: probe of ae97000.phy failed with error -16
