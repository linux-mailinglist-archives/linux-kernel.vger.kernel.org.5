Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2F7663B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjG1Fpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1Fpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:45:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3135B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:45:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso19458131fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690523148; x=1691127948;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sQXttJnykhKVDMwbiijzxff1XBZQFDGDEMk6NB3ReU=;
        b=kgLA/R1R1IDZO40aa97Pv2S7Goyt+AhDthxuhRtWcKwutIS6WTZdb213eaJM2Sn9Z+
         M+o07TTT1+v2BXmNZ8m9s3g/jrDNphfJZTlFSXVLixA9qSt4A5vAMhP27cxgAcOf0w5c
         yxrkkA4yPa2KYrPqrDGYqivGHZB4MJBQrRvSGiDcmEQpZ99n61KwdyGYZSoWq/h6K72Q
         U751DTGH7pkMqUb/SOehaSyi5PCufa0CpBBk0nDy0yQb4a4wEmF7dc2kc7VAkuW20U9e
         UwKzr4C65oHBPAHlTiRerQfguua1fKxtVXGAmAi+D8AtlnvVVJx2xrUTdjG9jOtB9UDh
         Yd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690523148; x=1691127948;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sQXttJnykhKVDMwbiijzxff1XBZQFDGDEMk6NB3ReU=;
        b=Lz4FUt21zVrwF5IC4MarIW9zNUBVZ+J2PS5pjbP5cG//Ja7l2G7aFfwUlkJhRVjH9V
         XDcu0bVGSKoBYBq3s0+42Sp3i2Bysqpdw+nQnB/NtJb6vemoYgsqJLURNzZ4Cw3VXf55
         anudUwWUY2EizULhsIPhgi6aoVC8Lz189SXHzizkj9SziqdDFVz6/xX/lCaOsXegcaw+
         06wf28+kB+2YXNlrVAmSEMlr3PPEwD1eugamHlulmxEUo6ldc6x+fOBQpTxmTmvpoHji
         IfKNRsqLARcPVuI3r1vKp/DA94T4aeRsxhJnzZF3YWfGt4bAgpndqC48lssNCq5f/V57
         ZxTQ==
X-Gm-Message-State: ABy/qLZmulpXwQJeSwqAoW4A2BkMTVWc/lLe6kEwfNuvwHqZ/HNx0GqP
        TJ+opZGgJFKEzJ6Snr96MRxKE5iQuwGrLDh9dSw=
X-Google-Smtp-Source: APBJJlGyGsI4r7dzgYdqmWjNyQNwwjtQNvH3s0KWZh0XKpQ9Uit9XoQBlL9VtgG1IsIjaGSyBxO2oA==
X-Received: by 2002:a2e:b0ce:0:b0:2b7:1dd:b416 with SMTP id g14-20020a2eb0ce000000b002b701ddb416mr897908ljl.15.1690523147893;
        Thu, 27 Jul 2023 22:45:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r13-20020adff70d000000b00313f9085119sm3765216wrp.113.2023.07.27.22.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:45:47 -0700 (PDT)
From:   kernel test robot <dan.carpenter@linaro.org>
X-Google-Original-From: kernel test robot <lkp@intel.com>
Date:   Fri, 28 Jul 2023 08:45:44 +0300
To:     oe-kbuild@lists.linux.dev,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     lkp@intel.com, Dan Carpenter <error27@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: drivers/power/supply/qcom_pmi8998_charger.c:565
 smb2_status_change_work() error: uninitialized symbol 'usb_online'.
Message-ID: <ZMNWCD66TAhahJ2Y@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57012c57536f8814dec92e74197ee96c3498d24e
commit: 8648aeb5d7b70e13264ff5f444f22081d37d4670 power: supply: add Qualcomm PMI8998 SMB2 Charger driver
config: arm-randconfig-m041-20230727 (https://download.01.org/0day-ci/archive/20230728/202307280638.556PrzIS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280638.556PrzIS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202307280638.556PrzIS-lkp@intel.com/

smatch warnings:
drivers/power/supply/qcom_pmi8998_charger.c:565 smb2_status_change_work() error: uninitialized symbol 'usb_online'.

vim +/usb_online +565 drivers/power/supply/qcom_pmi8998_charger.c

8648aeb5d7b70e Caleb Connolly 2023-05-26  556  static void smb2_status_change_work(struct work_struct *work)
8648aeb5d7b70e Caleb Connolly 2023-05-26  557  {
8648aeb5d7b70e Caleb Connolly 2023-05-26  558  	unsigned int charger_type, current_ua;
8648aeb5d7b70e Caleb Connolly 2023-05-26  559  	int usb_online, count, rc;
8648aeb5d7b70e Caleb Connolly 2023-05-26  560  	struct smb2_chip *chip;
8648aeb5d7b70e Caleb Connolly 2023-05-26  561  
8648aeb5d7b70e Caleb Connolly 2023-05-26  562  	chip = container_of(work, struct smb2_chip, status_change_work.work);
8648aeb5d7b70e Caleb Connolly 2023-05-26  563  
8648aeb5d7b70e Caleb Connolly 2023-05-26  564  	smb2_get_prop_usb_online(chip, &usb_online);

This can only happen if regmap_read() fails, and in real life they
can't actually fail can they?  We can't really recover if regmap
breaks so in that situation this uninitialized variable would be the
least of our concerns.  Right?

So what I could do is just delete the regmap_read error paths from
the DB.  I just add these two lines to smatch_data/db/kernel.delete.return_states

regmap_read (-22)
regmap_read (-4095)-(-1)

8648aeb5d7b70e Caleb Connolly 2023-05-26 @565  	if (!usb_online)
                                                     ^^^^^^^^^^

8648aeb5d7b70e Caleb Connolly 2023-05-26  566  		return;
8648aeb5d7b70e Caleb Connolly 2023-05-26  567  
8648aeb5d7b70e Caleb Connolly 2023-05-26  568  	for (count = 0; count < 3; count++) {
8648aeb5d7b70e Caleb Connolly 2023-05-26  569  		dev_dbg(chip->dev, "get charger type retry %d\n", count);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
