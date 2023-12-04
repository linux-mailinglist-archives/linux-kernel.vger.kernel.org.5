Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F48802BEE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjLDHSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:18:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2081D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:18:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so10265295e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 23:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701674328; x=1702279128; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi3hpr0cHxx12GZtLwmUPUIkOwLCvXJWVDSx0cpa88g=;
        b=Z1XXUnDmZEMEC2uJankEMEP1kiuLx0yJDTGVVm7jRArB3olG+FIM4mgEldC8J+L380
         Cow5Tc9pz4QhIvAVSRva/01r1+1VOfI6/OsOi0xaiaSEiNFye3GzTcko2Y+08E0UwP3O
         VKzBFCVu08MgVjEx810T5d1iJH2Pw2fT2heKTAWpTOZGfS+w4mcYhHLbKgTF5e+/9jIv
         cxJF32GP5bCmUNu+T37kElfLEDanWBEgBReWCBFGpnXQtVumKUiVD+DzuY76vJYPmDPq
         B4kSG+bzWd0sOIcjIOzkwLorK81tic5NJADHQgjUGB5g4bN5uit/F0TrskHAzTvjz4kZ
         lYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701674328; x=1702279128;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi3hpr0cHxx12GZtLwmUPUIkOwLCvXJWVDSx0cpa88g=;
        b=qSGHkRPI22ZyiOlpbj8tWVra1DLdJqt1Y+FOED0lcsK/KCrriXKLeaR1U3FvC2kGAe
         zOajlLb35nn2vH/71ompzw5IBvCREAHxyJNuNagwF4Sxx51pCOYlxRDHyb/Xfdlr4BIb
         Q/MiNRK6OGYpy7EnqU9Wlz2I7M2bGw3fMKEAG7BNvr+HD5iazUgRn/Kx1mYDenSi+Os9
         TpY0ZIlntPNp/BU3XzGGOZN4IV7Hi36xr9ZgGYXm3Me+GNtDDHjl5xVktWxLxxqdh8tS
         xfFLSyZblU4Z1h4u7Izo9EWBLQjLbm6vEpHKos6p4pUIsW3wQe/10mfkyocUuzq+jbtm
         YBnA==
X-Gm-Message-State: AOJu0Yy5gJYiYbauj7mcs9WDCYOW4TG7bZ7+TfpJWdusjZIxDjKXyeSY
        p7khXBgYy7V8Q7VoVOvPXchhHw==
X-Google-Smtp-Source: AGHT+IHTJZPgn1igTSaSOMA9yAKQ+r/YPyqOdfW1wVBF1zkCtYQGNmA3D7yPtB1abWxOSw/BJghDjQ==
X-Received: by 2002:a05:600c:468f:b0:40b:5e21:c5e7 with SMTP id p15-20020a05600c468f00b0040b5e21c5e7mr1577142wmo.181.1701674328040;
        Sun, 03 Dec 2023 23:18:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b0040b478da760sm13950950wms.48.2023.12.03.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 23:18:47 -0800 (PST)
Date:   Mon, 4 Dec 2023 10:18:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:466
 gf100_gr_chan_new() warn: inconsistent returns '&gr->fecs.mutex'.
Message-ID: <09303e3b-40ba-4558-b001-e4b8586c6a60@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: ca081fff6ecc63c86a99918230cc9b947bebae8a drm/nouveau/gr/gf100-: generate golden context during first object alloc
config: i386-randconfig-141-20231105 (https://download.01.org/0day-ci/archive/20231203/202312031611.BpCtNGvw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031611.BpCtNGvw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312031611.BpCtNGvw-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:466 gf100_gr_chan_new() warn: inconsistent returns '&gr->fecs.mutex'.

vim +466 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c

27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  377  static int
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  378  gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_fifo_chan *fifoch,
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  379  		  const struct nvkm_oclass *oclass,
e3c71eb27419b6 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-01-14  380  		  struct nvkm_object **pobject)
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  381  {
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  382  	struct gf100_gr *gr = gf100_gr(base);
bfee3f3d97db88 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  383  	struct gf100_gr_data *data = gr->mmio_data;
bfee3f3d97db88 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  384  	struct gf100_gr_mmio *mmio = gr->mmio_list;
e3c71eb27419b6 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-01-14  385  	struct gf100_gr_chan *chan;
019e4d76c6e91b drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2017-11-01  386  	struct gf100_vmm_map_v0 args = { .priv = 1 };
227c95d90a3c50 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  387  	struct nvkm_device *device = gr->base.engine.subdev.device;
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  388  	int ret, i;
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  389  
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  390  	if (!(chan = kzalloc(sizeof(*chan), GFP_KERNEL)))
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  391  		return -ENOMEM;
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  392  	nvkm_object_ctor(&gf100_gr_chan, oclass, &chan->object);
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  393  	chan->gr = gr;
019e4d76c6e91b drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2017-11-01  394  	chan->vmm = nvkm_vmm_ref(fifoch->vmm);
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  395  	*pobject = &chan->object;
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  396  
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  397  	/* Generate golden context image. */
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  398  	mutex_lock(&gr->fecs.mutex);
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  399  	if (gr->data == NULL) {
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  400  		ret = gf100_grctx_generate(gr, chan, fifoch->inst);
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  401  		if (ret) {
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  402  			nvkm_error(&base->engine.subdev, "failed to construct context\n");
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  403  			return ret;

mutex_unlock(&gr->fecs.mutex) before returning?

ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  404  		}
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  405  	}
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  406  	mutex_unlock(&gr->fecs.mutex);
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  407  
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  408  	/* allocate memory for a "mmio list" buffer that's used by the HUB
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  409  	 * fuc to modify some per-context register settings on first load
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  410  	 * of the context.
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  411  	 */

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

