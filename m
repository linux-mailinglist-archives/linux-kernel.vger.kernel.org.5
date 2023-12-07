Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB41808A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443189AbjLGO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443474AbjLGO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:26:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04231173F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:25:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D73C433C7;
        Thu,  7 Dec 2023 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701959158;
        bh=BB8B5e3lcX0yXeV5twd8WMzv2yRfLB0d40M15sMzN1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6mSC/cjKDFaqugND65JRTmW92mbljTgTTmg6CGaAWNF0WL82rxgt67mmfiMxerqK
         rJ4P489cZCnC7C3g2l5oP7kQ2XzO/AXyIRNsDzFY/Sj44qg6AfCgNI8qMpNpWvkdho
         rqqiksxl7IPdOkeJKAnFsIKaBo5BPRYalNd6/B6/N3Wd+oZM40WlVLf1S4+8eXvq4T
         pbJzP4yk44WEsLM8O6Kx2S123xf+VKdn9YNvZDyA89Rsa+d9MKgQmX9RazBaFt6HNp
         suPFRquwASN0RSww3bbJSYv1LpBkuG+objnLfTJWlYzwIGw7esFaBIx4YcQB4x9d7a
         7uEGlhVRRzmDg==
Date:   Thu, 7 Dec 2023 14:25:50 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev,
        Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Message-ID: <20231207142550.GD8867@google.com>
References: <20231130013615.14287-5-quic_amelende@quicinc.com>
 <17a8a637-3477-41fe-959f-7784cf6d6b2e@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17a8a637-3477-41fe-959f-7784cf6d6b2e@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023, Dan Carpenter wrote:

> Hi Anjelique,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/dt-bindings-soc-qcom-Add-qcom-pbs-bindings/20231130-094701
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20231130013615.14287-5-quic_amelende%40quicinc.com
> patch subject: [PATCH v7 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
> config: csky-randconfig-r071-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302200.RcTP9m0Y-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231130/202311302200.RcTP9m0Y-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311302200.RcTP9m0Y-lkp@intel.com/
> 
> smatch warnings:
> drivers/leds/rgb/leds-qcom-lpg.c:1055 lpg_pattern_set() error: uninitialized symbol 'lo_pause'.
> drivers/leds/rgb/leds-qcom-lpg.c:1056 lpg_pattern_set() error: uninitialized symbol 'hi_pause'.

FYI, I'll not review this set until these are fixed.

-- 
Lee Jones [李琼斯]
