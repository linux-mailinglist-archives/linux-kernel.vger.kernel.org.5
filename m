Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739ED76CE52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjHBNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHBNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:19:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCCE1724
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:19:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so35233125e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690982367; x=1691587167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/2WIVROlZsV9PaE7ZRV5iugvs6edZ71omTT4F/SSvo=;
        b=b5ttnfL5oEhNHJ+OuMs3TaY01QRb+YOyogeni8rOKLZRF34u4K7seXIEgc9zybGmDy
         i6CL1VdjafelnmnuFFrUfjUn2XCMDV0Dn0c/CIQ9VnH35f0a/AmkWcnQFD931P2VnAvi
         ppn66jIET8cdYTFhWERY2AFPKxopY+IyxBsAoKoVMSGyYaEEJ8wLYHFH0qM/WdDzm75M
         DzRsx+xyBo/RoEwtmvScNiwcPUmZqmpPSfsQ8SI1HOKOfgCjojPjI/zbXUF++XjXeVIu
         Hc7uLzGLqp0iKRBZg5lmWkB4q5qcyV1ZRNIRmrHJzWBF5GaE84d3dQLZxFnfxu2x7ca0
         6FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982367; x=1691587167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/2WIVROlZsV9PaE7ZRV5iugvs6edZ71omTT4F/SSvo=;
        b=BqDNIY5vbYwiGVJQrgowAEYyirnEBvCe8Ah2f7yM0OHzwU28UqP9CI45vu3/0S9UJP
         I0YCOO3XsobyfnCDiz89m8FZ0oszDmiq0YMMRGbX93FhoUitcRTU+3UeqnHuKDuN6oS8
         n/Orw6beMlGyuy/VBkLD9k23yzv1tzdrqlMKC9yJbto8W5JuHrr2r1j0AOj2c+OJg/gy
         hKsqxMuAFN6EqvWCqRqGWX1rr1n76BftwIIVp4RGI1Tke2HduVPEGWtAoOw/YlRrfbMl
         hMAODcUTIPOdfpC+CHIrbFqmZzrCHpOgZyR21H3MvO0neLv4//FJAe2gUsaXs/XwUeyR
         KZVA==
X-Gm-Message-State: ABy/qLbJtOG40akg/biWX/uKZUIBbcC7BS5nb/imS4JZaMik/x08uyB9
        X0hYmYTMIFYHAyOLwjVHwdBFyQ==
X-Google-Smtp-Source: APBJJlHDtPxPkjUQDc9Cgo3moh4rigDIqtwormB9fceq6QeriPzioOsRh/evkwesGLHEjyC7EvY7hw==
X-Received: by 2002:adf:f44c:0:b0:317:3f64:4901 with SMTP id f12-20020adff44c000000b003173f644901mr4651149wrp.41.1690982367568;
        Wed, 02 Aug 2023 06:19:27 -0700 (PDT)
Received: from [192.168.1.14] (host-92-17-103-66.as13285.net. [92.17.103.66])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm15276105wrp.99.2023.08.02.06.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:19:27 -0700 (PDT)
Message-ID: <2c0860e2-40d6-ec91-60cf-2684edd52676@linaro.org>
Date:   Wed, 2 Aug 2023 14:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/power/supply/qcom_pmi8998_charger.c:565
 smb2_status_change_work() error: uninitialized symbol 'usb_online'.
Content-Language: en-US
To:     kernel test robot <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, Dan Carpenter <error27@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <ZMNWCD66TAhahJ2Y@kadam>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ZMNWCD66TAhahJ2Y@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2023 06:45, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   57012c57536f8814dec92e74197ee96c3498d24e
> commit: 8648aeb5d7b70e13264ff5f444f22081d37d4670 power: supply: add Qualcomm PMI8998 SMB2 Charger driver
> config: arm-randconfig-m041-20230727 (https://download.01.org/0day-ci/archive/20230728/202307280638.556PrzIS-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280638.556PrzIS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202307280638.556PrzIS-lkp@intel.com/
> 
> smatch warnings:
> drivers/power/supply/qcom_pmi8998_charger.c:565 smb2_status_change_work() error: uninitialized symbol 'usb_online'.

Hi, thanks for the report.
> 
> vim +/usb_online +565 drivers/power/supply/qcom_pmi8998_charger.c
> 
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  556  static void smb2_status_change_work(struct work_struct *work)
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  557  {
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  558  	unsigned int charger_type, current_ua;
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  559  	int usb_online, count, rc;
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  560  	struct smb2_chip *chip;
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  561  
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  562  	chip = container_of(work, struct smb2_chip, status_change_work.work);
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  563  
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  564  	smb2_get_prop_usb_online(chip, &usb_online);
> 
> This can only happen if regmap_read() fails, and in real life they
> can't actually fail can they?  We can't really recover if regmap
> breaks so in that situation this uninitialized variable would be the
> least of our concerns.  Right?

In this case, the driver is for a peripheral on the SPMI bus, a read
failing is extremely unlikely but under some conditions like bandwidth
constraints it could happen. Though admittedly there are likely bigger
issues to deal with in that situation heh.

It's a trivial fix so I'll send a patch over.
> 
> So what I could do is just delete the regmap_read error paths from
> the DB.  I just add these two lines to smatch_data/db/kernel.delete.return_states
> 
> regmap_read (-22)
> regmap_read (-4095)-(-1)
> 
> 8648aeb5d7b70e Caleb Connolly 2023-05-26 @565  	if (!usb_online)
>                                                      ^^^^^^^^^^
> 
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  566  		return;
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  567  
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  568  	for (count = 0; count < 3; count++) {
> 8648aeb5d7b70e Caleb Connolly 2023-05-26  569  		dev_dbg(chip->dev, "get charger type retry %d\n", count);
> 

-- 
// Caleb (they/them)
