Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9627806F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358483AbjHRIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358486AbjHRIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:14:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E02D73
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:14:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c0cb7285fso73292966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692346457; x=1692951257;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bGmlfoBsv84hlbfqJxlX7Gz/ol1KDJpGEn228luPPI=;
        b=e/pSsqt/AiPKDRQuExczBM/KFwSX/zoUMyFgznPH+qnJweX6CO7LTAtC0rnz5O1vUt
         E1368b9qwSeIFAMuHJukxt3D5AyHJmQ3ut7G6vBnNZjRKgRhCpzHkMiiKjyxhcGLep3q
         rqTwbD2yXf+Sz6UcqI2TSe6rZVj8dZc8ScKdd1d+8htCroPFFFkiidMrrH0B0ChhIr6E
         /OOQPqm041gYqqKNu3wA0On3bm3nVbrOjbT4Fp3H+iklMrRCfayZ9Z4PhXW2mOOKMFUv
         OEVJGPp/aFaQ15GzP/AlXuxyVLDrFuYjn/9ft2WZqTld31TSdRyxnbYfr4c8S0ZZXdUA
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692346457; x=1692951257;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bGmlfoBsv84hlbfqJxlX7Gz/ol1KDJpGEn228luPPI=;
        b=g3PhPixuo4Cgbd7JTAUSgCzk0BX1ebPYgLyZExaGcyTJi1FH9PCuj0eWtfF2w34Cfm
         lR+EvqmXRr2uFLkX5WGgBXJlTBeSfCIL2bLsyEVJC/dbwAmxdmBURwlILYtgCLWo/K4I
         9UCFfiRiHK5uJdnIPM4ksDDdT4tFt40qgItGECHi4vOuW1ZptzxLEkAJgVhNE0ucoxRe
         oPbYXlx09Y5XSeh1G/Egduu7T1wUAXIad8CMjJee5rS5MNunM3A09BRSxOv/f5ANaMDF
         nOcv+AlFxgNAJ705kydmPNyn2hh2l/BVBBLyGGQ3PLWbVk5P3OQrxMwF8rpTBrsa0k50
         aKtg==
X-Gm-Message-State: AOJu0YxeOIumAJaTwi2YwDiF4o4g7nsihtNHEqObxLEDLNxslUscUTzG
        irXNNq+tniV/dgQlQR5J4Shxdirgfuvaog==
X-Google-Smtp-Source: AGHT+IH4zzKKONXlBideDmvuEMsklrC9xaCKbjJgQbsDxMNkz+aNsg83+bR3bLJ+wFrqGL/aC1G76Q==
X-Received: by 2002:a17:907:2bf5:b0:992:1233:9c45 with SMTP id gv53-20020a1709072bf500b0099212339c45mr1396686ejc.69.1692346456838;
        Fri, 18 Aug 2023 01:14:16 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id qq12-20020a17090720cc00b0099d0c0bb92bsm870993ejb.80.2023.08.18.01.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:14:16 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:14:15 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: where is TASK_TI_KERNEL_SP defined?
Message-ID: <ZN8oV98hs1Kt0KzS@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not sure why but I cannot find the definition of TASK_TI_KERNEL_SP. Can
someone tell me?

Thanks!
Nam
