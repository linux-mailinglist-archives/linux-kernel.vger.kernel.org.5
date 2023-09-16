Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356B7A3345
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjIPWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjIPWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:42:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E9CD1;
        Sat, 16 Sep 2023 15:42:54 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1330666072F0;
        Sat, 16 Sep 2023 23:42:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694904173;
        bh=WXk/aZaoMVg5RvFmSYCLfLhSZ+wNpAQpcnkQpMiVggE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PhNX2dsAzbV+NOKAxX+fXov0jISr1GPbkTm60cryzZ0gvldwkZnlMRek4+Y3m1k2P
         Qs04CJ+mtN5y5a/XXoOPEg1HGvMVLWOM9AG0Bz+aCbi+JTqFoFtIqmoEolpDhYr8mD
         bxu8OlsmhBBcRYpt+OzGjSg8LWKHWvwm8MW2jvoTC/g/UsVdAOoq1bfdUeRLkqb2ng
         n6aPWcdTVENRoaa6UE9FuOj8WVDI3HYA+9xpfFBC0v3wRAOMsqjKANtz22N/eUMFAZ
         N1c+Kgu46b9UbL7tI2hb12hxsn/Ukn9kPYjbTutScYOBBYUZTHhxXwWKRe6P7dQCCZ
         2vvl7ryr7ieRw==
Received: by mercury (Postfix, from userid 1000)
        id 45A111060450; Sun, 17 Sep 2023 00:42:49 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230916-topic-mm8013_2-v1-1-02495e07fca0@linaro.org>
References: <20230916-topic-mm8013_2-v1-1-02495e07fca0@linaro.org>
Subject: Re: [PATCH] psy: mm8013: Add more properties
Message-Id: <169490416926.888543.10300420943338889530.b4-ty@collabora.com>
Date:   Sun, 17 Sep 2023 00:42:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Sep 2023 02:31:59 +0200, Konrad Dybcio wrote:
> While scanning the internet for MM8013 PDFs, I found one for a different
> IC from Mitsumi, MM8118 at [1]. It turned out however, that when you
> search through the PDF, the MM8118 text has an invsible text layer
> containing "MM8013" underneath..
> 
> With some elbow grease, I was able to confirm that most of the registers
> match between the two ICs. Based on that finding, introduce live battery
> voltage readout, hw-decided charge behavior readout and max current
> readout. Also, expand the existing POWER_SUPPLY_HEALTH reporting.
> 
> [...]

Applied, thanks!

[1/1] psy: mm8013: Add more properties
      commit: e39257cde7e8ceec6165f54b6e20c72e2862a0b1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

