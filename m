Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98FA80E390
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjLLFFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLFE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:04:58 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B111BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:05:05 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1feeea75fbfso3483851fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702357504; x=1702962304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p08chQNSh3PD1wtmZIuc6+rRft68Xk8lY5p5BHfJ4CM=;
        b=cB725xNfqkrANU+C79zGrLlh38FoqFm9V/G7vPcjGITQxd4JVjqsBJbwj1FTvfeWYk
         6FgctPgv5nCiJ4jnUlzFlITwIeyEg+QvaMGfPYL02ejLN3+r17OfMnvF91ANTmOSVGBK
         QLZ2eXQqHZr4WxqPp22yt4CtgdtC93+9mgmNCN5uNDlzMyM28HlaOwTmxB1KxQz3yNMh
         67HOYAgwdZX+yvcWrjV8fUKIHK7kq7Iewdbs+U0NF2+DznnjohVcWfce5tbRD+mqwpsB
         l2EBWkeLIno9I3lwMRdxHiIVbie3gipYKqZFF3PGyuhWBUtBL7FCi1PBLeYujumD4BcP
         S31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702357504; x=1702962304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p08chQNSh3PD1wtmZIuc6+rRft68Xk8lY5p5BHfJ4CM=;
        b=HcfoLBgRQYNwXzpv9baW9xlDq6bRjt8Dwa9sVMOGp1tTj5Tu8rybBBstlMvM4A3ADW
         3eSeiQ2eqlbQ4sjoz96l3Glbe+yadz+lJWvYlcXSgroh+ELOKnjyzVRGckEHwoY6CLua
         0OjHAO3wVZhzPN74tHz0Kz6bNi6DGE8hOOnk7oCnKjRBwRLUhslK0kD6JPk0TLmOwRl3
         mI64ZHavrnzrmZrMlI1pGohjDWt4wrH1jLRrCaxPFlSulb8cFv+V6upLs0RV2b0mka6t
         qCGbHcUaqJHYmUqKjpGPEcutZ8xghXe/fcLvr5FKVWpx8aCYsJ8bBGjpvjqUI6ygGORO
         gzSg==
X-Gm-Message-State: AOJu0YzHRle0/UdBpVkZvuoU7kMpQgXObiDStNkCUyvg78o1NmWZN9M9
        ltbqXJUZFGfXZHVtIXIiwzXV+zrnKhTLAIkW7UM=
X-Google-Smtp-Source: AGHT+IGWqv5/TW2dVlT8w2gB3JQITBAdmLL+a1qpOqc0LzFyKSebQYVDrMD929RiaCZSrSLyBklpVP1SzZmW39NGRYo=
X-Received: by 2002:a05:6870:d8b:b0:1e9:96c6:e04c with SMTP id
 mj11-20020a0568700d8b00b001e996c6e04cmr5320921oab.32.1702357503830; Mon, 11
 Dec 2023 21:05:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
 <CAGXv+5E4TXrPmhb++r3vMGA4WoPc=covi7_=zgLLcOhGt9UBgg@mail.gmail.com>
 <CAKpemQJDf9RqeOStB4Rm5hzuQdzYF6JEbuz00Cr-a80cWZKR6w@mail.gmail.com>
 <CAGXv+5HuxOtFfdWdocspTcDRytCK+0Ny+c_aFLJyHCUbYTboJQ@mail.gmail.com> <CAKpemQLyieDP1r11v1WJ+-SXeseUiPKsCK6SBf-FSCOxGkEWHw@mail.gmail.com>
In-Reply-To: <CAKpemQLyieDP1r11v1WJ+-SXeseUiPKsCK6SBf-FSCOxGkEWHw@mail.gmail.com>
From:   Bret Joseph <bretjoseph@gmail.com>
Date:   Tue, 12 Dec 2023 07:04:51 +0200
Message-ID: <CAKpemQJkFxDnqob4NpqYc7iTWNiaoVUJ+rFvw+nRv0mYvoNJcg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the LDO regulators that were not probing, I changed the pickable
regmap to just a regmap function.
In static int mt6358_get_buck_voltage_sel(struct regulator_dev *rdev){}

For LDO1
        ret = (regval & info->da_vsel_mask) >> (ffs(info->da_vsel_mask) - 1);
returns
[    3.470672] shift exponent -1 is negative
[    3.470910] CPU: 7 PID: 63 Comm: kworker/u16:2 Not tainted 6.7.0-rc5 #3
[    3.471278] Hardware name: MT6769H (DT)
[    3.471521] Workqueue: events_unbound async_run_entry_fn

fixed by adding
        .da_vsel_shift = 8

--- linux-6.7.0-rc5/drivers/regulator/mt6358-regulator.c 2023-12-12
05:32:19.703310500 +0200
+++ linux/drivers/regulator/mt6358-regulator.c 2023-12-12
06:25:06.855132318 +0200
@@ -27,6 +27,7 @@
  u32 qi;
  u32 da_vsel_reg;
  u32 da_vsel_mask;
+ u32 da_vsel_shift;
  u32 modeset_reg;
  u32 modeset_mask;
 };
@@ -108,6 +109,7 @@
  }, \
  .da_vsel_reg = _da_vsel_reg, \
  .da_vsel_mask = _da_vsel_mask, \
+ .da_vsel_shift = 8, \
  .status_reg = MT6358_LDO_##vreg##_DBG1, \
  .qi = BIT(0), \
 }
@@ -209,6 +211,7 @@
  }, \
  .da_vsel_reg = _da_vsel_reg, \
  .da_vsel_mask = _da_vsel_mask, \
+ .da_vsel_shift = 8, \
  .status_reg = MT6358_LDO_##vreg##_DBG1, \
  .qi = BIT(0), \
 }
@@ -381,7 +384,7 @@
  return ret;
  }

- ret = (regval & info->da_vsel_mask) >> (ffs(info->da_vsel_mask) - 1);
+ ret = (regval >> info->da_vsel_shift) & info->da_vsel_mask;

  return ret;
 }
@@ -478,8 +481,8 @@
 static const struct regulator_ops mt6358_volt_table_ops = {
  .list_voltage = regulator_list_voltage_pickable_linear_range,
  .map_voltage = regulator_map_voltage_pickable_linear_range,
- .set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
- .get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+ .set_voltage_sel = regulator_set_voltage_sel_regmap,
+ .get_voltage_sel = regulator_get_voltage_sel_regmap,
  .set_voltage_time_sel = regulator_set_voltage_time_sel,
  .enable = regulator_enable_regmap,
  .disable = regulator_disable_regmap,
