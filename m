Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2B7ACBF0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjIXU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 16:58:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E27EE;
        Sun, 24 Sep 2023 13:58:20 -0700 (PDT)
Received: from mercury (cust-west-par-46-193-56-210.cust.wifirst.net [46.193.56.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C93366072E9;
        Sun, 24 Sep 2023 21:58:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695589098;
        bh=h8S0AVpoW3F2EytvwOGglewnFQNIvkNAQbE34WlVL0E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XeUq47K7GoNnjFu0Z/Xl6fZURJ+CNaPsMYNqh2EYtwcf88C/4ahy2EBGI/7ioASQm
         SyngW67glqcbQX/gvOCwXWxW9wpfS2KLxQrKoxzk6eMw5+1CVl6o++Ttk2uVgqA7uI
         TU8qq9SAqEuA7rOzh2LeIgY6EyytQwHAyxZiGsolgYiLE4IhznVXzsdZTYw1k6dLZR
         CRnxjy4mX1yUXxO5XY/5oLAzCcXpZxEPi7XMkkEIs5KB2CDe5B9HuI8c8ODhA1IoMs
         BlOKefBWl5QLOEMFHpUBylE5j7g4KAwJLYE/vtM3UKWUQvz2YUJeDFVnNKG867Cglw
         3JpD8g7/fG+vQ==
Received: by mercury (Postfix, from userid 1000)
        id A0C3D10611D9; Sun, 24 Sep 2023 22:58:15 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20230923114807.2829188-1-harshit.m.mogalapalli@oracle.com>
References: <20230923114807.2829188-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH next] power: supply: mm8013: Fix error code in
 mm8013_probe()
Message-Id: <169558909561.1797612.1920151492515517327.b4-ty@collabora.com>
Date:   Sun, 24 Sep 2023 22:58:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Sep 2023 04:48:06 -0700, Harshit Mogalapalli wrote:
> The value of ret is zero when passed to dev_error_probe(), we are passing
> zero to dev_err_probe() is a success which is incorrect.
> 
> Fix this by getting the error code using PTR_ERR().
> 
> 

Applied, thanks!

[1/1] power: supply: mm8013: Fix error code in mm8013_probe()
      commit: 43ee22422db545800b8bf2c24ef53d040372fc7a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

