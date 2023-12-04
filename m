Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C8802C59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjLDHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjLDHue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:50:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA6F2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:50:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so10370775e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 23:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701676239; x=1702281039; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfuyjfI5rrot2b9MMBgHHf0/98+FnGTUcM8RRu9KaxI=;
        b=dLINimhnGsaNrlYBShAcda1NiRN4Jmxtv2SGTgzV5mITJxxL+8StnAQxTC0m4BpRcP
         kMGoWPAnIL0SfjfSSxM0fAWwRG0u2uGY6cqBOZoEyTEkjq30LYQQzYi4mMcQ/YTu0voV
         wmhbVgX2QJpEQreiFXkldIiOaq0CFBCVidws0xPDniXHoYM2GwUygXsK8hV6HUbJr0KX
         xFNJdJ9Z4i1w48H3RcX5HjT5f5WJFKBi8wcUUwcTvNAef46Rt8BPIi8o/z5AG2/t4Hbz
         A4qiFYAPcMcKP1tDHVTJ7bkbDwjzKmfV+b3ekTCumXVYaLkcZo7SIAT44hMjfJRqkrfq
         JbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701676239; x=1702281039;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfuyjfI5rrot2b9MMBgHHf0/98+FnGTUcM8RRu9KaxI=;
        b=eLQHIu93IXdUvPIhu4QNZ8hYqedGLyuZONN9rQBQd3tB5gHGjTD/yLvs8rlRBLcwO8
         Kgyvw2p0TjWNynL6NadOOXDsWdmoQOyJMsCK9apyymGT4dXfPWb9UqOKhU/PBTlUVrCl
         hg8mAJw43gzH/MxUuHYu/RavVHyXBZbsNTzg00k3CnD84/MSsHyF8d16xy4WVZPs/OO9
         ktY5dXGfApV9IAp6dW16w7IDrxPuJdjDPgITNOFrfkla76f3VRpYiztVJuCB3nrr/iYo
         5g8XFUgx8QIzXROxK5A64qZopG7b8Auy5Ntr/AfBXwsmF4wA/nXB9ZyAiHHUiHlRH1CU
         nhQw==
X-Gm-Message-State: AOJu0Yx0BZ6sOmKGa5ZnNZkdmDf/TywUGCjwoxRMil3egqVjOKEmo8Zk
        LIU2EVcn6PylWl65ppAHCA4aJsbW6jkShVchi6s=
X-Google-Smtp-Source: AGHT+IHbASZQoLoy6RN0GqhWWZK5CgZjrGLQtZNFlTvZiBv33lm0s2DYxwn7PAhZqQ035t2VpWvJIw==
X-Received: by 2002:a05:600c:219a:b0:40c:d1d:7822 with SMTP id e26-20020a05600c219a00b0040c0d1d7822mr157525wme.135.1701676238639;
        Sun, 03 Dec 2023 23:50:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0040b3e79bad3sm13947798wmq.40.2023.12.03.23.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 23:50:38 -0800 (PST)
Date:   Mon, 4 Dec 2023 10:50:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Dragos Bogdan <dragos.bogdan@analog.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: drivers/clk/uniphier/clk-uniphier-mux.c:47
 uniphier_clk_mux_get_parent() warn: signedness bug returning '(-22)'
Message-ID: <6322ed2e-8f2d-49e5-bebf-2fb109790cd4@suswa.mountain>
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

Hi Dragos,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: f26e433185cb2830b933df3a4d378558fe2fccd9 arch: nios2: Enable the common clk subsystem on Nios2
config: nios2-randconfig-r081-20231120 (https://download.01.org/0day-ci/archive/20231204/202312041541.LK8ZbiIf-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312041541.LK8ZbiIf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312041541.LK8ZbiIf-lkp@intel.com/

smatch warnings:
drivers/clk/uniphier/clk-uniphier-mux.c:47 uniphier_clk_mux_get_parent() warn: signedness bug returning '(-22)'

vim +47 drivers/clk/uniphier/clk-uniphier-mux.c

734d82f4a678e8 Masahiro Yamada 2016-09-16  31  static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
734d82f4a678e8 Masahiro Yamada 2016-09-16  32  {
734d82f4a678e8 Masahiro Yamada 2016-09-16  33  	struct uniphier_clk_mux *mux = to_uniphier_clk_mux(hw);
734d82f4a678e8 Masahiro Yamada 2016-09-16  34  	int num_parents = clk_hw_get_num_parents(hw);
734d82f4a678e8 Masahiro Yamada 2016-09-16  35  	int ret;
c0ce317f0c8863 Masahiro Yamada 2016-10-17  36  	unsigned int val;
734d82f4a678e8 Masahiro Yamada 2016-09-16  37  	u8 i;
734d82f4a678e8 Masahiro Yamada 2016-09-16  38  
734d82f4a678e8 Masahiro Yamada 2016-09-16  39  	ret = regmap_read(mux->regmap, mux->reg, &val);
734d82f4a678e8 Masahiro Yamada 2016-09-16  40  	if (ret)
734d82f4a678e8 Masahiro Yamada 2016-09-16  41  		return ret;
734d82f4a678e8 Masahiro Yamada 2016-09-16  42  
734d82f4a678e8 Masahiro Yamada 2016-09-16  43  	for (i = 0; i < num_parents; i++)
734d82f4a678e8 Masahiro Yamada 2016-09-16  44  		if ((mux->masks[i] & val) == mux->vals[i])
734d82f4a678e8 Masahiro Yamada 2016-09-16  45  			return i;
734d82f4a678e8 Masahiro Yamada 2016-09-16  46  
734d82f4a678e8 Masahiro Yamada 2016-09-16 @47  	return -EINVAL;

kbuild has decided to dig through ancient warnings today.  This function
is type u8 so returning -EINVAL doesn't work.

734d82f4a678e8 Masahiro Yamada 2016-09-16  48  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

