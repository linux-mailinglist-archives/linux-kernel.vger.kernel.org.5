Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFFF7978B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbjIGQwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244364AbjIGQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:52:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30161FDC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:52:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501bd7711e8so2023556e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105469; x=1694710269; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wPPunoJweAisiG61XaqfURd25US3DbZZdoZ6G+g2JY=;
        b=QHGVJwZJJyj2sSncwjntG3NvO7PbXtuwzJIg6DbRxWXcbOOUlEWHeUZO2BZwaAdxfv
         rFbiiZ7K1hDtwhtm9UiyiO8FXhD6A1thwAIm3upxFcARsi20Xw4KT2lW8ZGf3okPTEyN
         Vb1eFzYXIq95heEVapiNyAZzXqqOcAgrBaeXzd/YIZATwHIYnbPZetdJDythR7Nla7H9
         DVZKsDqVmgK6wX8EaVECMAHkLNguyiN3IGXVy0Zs8XLwdSx+Fck62mkEyewm10HOJsct
         Js6BJ6k6uVc5ivw6vdpSfzGYgzFUQZ+CyEWpTB0rZZSTGMdE+sdPkI/AbMqks5gjDTEV
         TNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105469; x=1694710269;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wPPunoJweAisiG61XaqfURd25US3DbZZdoZ6G+g2JY=;
        b=grw91PcmP7CnE8WpqSc1xvF3e6NOvKioeeEAKdtog8RaP2uHNSyWpFEcZltXP8acUY
         mJHfP+LyXsz7tryuemTYSNO2YIp+2v9eNfCIa5OrfCW/g6tAfJ+sdn+2O7nTqap8RoLh
         EwKQPhEjEYADbv1umzkqIqTGXkmBsINS2I4JsXGXRkuVpxiuaKzbRzBJFB0U8Y1KDtjJ
         7+CiYPOwxgRNel/CgjiBlQy/EMlVcrFJQvFKmlyMG6fhgDqP1+Fk+/5NC91F/WuQPMAO
         C09zTw4PqQduNxtwz8HOR0qKYlclIf4/Co6gaNq5Nhh0xi6e5uf6gxO2rIAeMyv0dRCH
         Nw7w==
X-Gm-Message-State: AOJu0YyUUA3XXoeub9d93Ic4JX1+wLrbpURrOHARteac3I1RUWRHnHzQ
        Xc+bTHyZsbnckTJ+UkaHn9jDDPpcW+ekFZsj080=
X-Google-Smtp-Source: AGHT+IFkGoYeNhD80XRXiu4J3BySdBgX4kx7Q/cBAx337ZDivO9FJW07aVYeg6Jxv26gzJ+jFFW2XQ==
X-Received: by 2002:adf:edc9:0:b0:31c:8c93:61e3 with SMTP id v9-20020adfedc9000000b0031c8c9361e3mr4104296wro.60.1694083970810;
        Thu, 07 Sep 2023 03:52:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm22952369wrt.67.2023.09.07.03.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 03:52:50 -0700 (PDT)
Date:   Thu, 7 Sep 2023 13:52:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Rob Herring <robh@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: drivers/of/dynamic.c:935 of_changeset_action() warn: possible memory
 leak of 'ce'
Message-ID: <eaa86211-436d-445b-80bd-84cea5745b5a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f
commit: 914d9d831e6126a6e7a92e27fcfaa250671be42c of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
config: x86_64-randconfig-161-20230831 (https://download.01.org/0day-ci/archive/20230901/202309011059.EOdr4im9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230901/202309011059.EOdr4im9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/

smatch warnings:
drivers/of/dynamic.c:935 of_changeset_action() warn: possible memory leak of 'ce'

vim +/ce +935 drivers/of/dynamic.c

201c910bd6898d Pantelis Antoniou 2014-07-04  925  int of_changeset_action(struct of_changeset *ocs, unsigned long action,
201c910bd6898d Pantelis Antoniou 2014-07-04  926  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  927  {
201c910bd6898d Pantelis Antoniou 2014-07-04  928  	struct of_changeset_entry *ce;
201c910bd6898d Pantelis Antoniou 2014-07-04  929  
201c910bd6898d Pantelis Antoniou 2014-07-04  930  	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
606ad42aa3b1fe Rob Herring       2016-06-15  931  	if (!ce)
201c910bd6898d Pantelis Antoniou 2014-07-04  932  		return -ENOMEM;
606ad42aa3b1fe Rob Herring       2016-06-15  933  
914d9d831e6126 Rob Herring       2023-08-18  934  	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
914d9d831e6126 Rob Herring       2023-08-18 @935  		return -EINVAL;

No kfree(ce).  Probably we move this check before the kmalloc()?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

