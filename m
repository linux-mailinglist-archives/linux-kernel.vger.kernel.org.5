Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC57B53A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjJBM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjJBM7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:59:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BA9B7;
        Mon,  2 Oct 2023 05:59:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696251555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wk+Vd4eULYF6GTN5ms33Ajkxz1U/FDjksj9rBwwG4bQ=;
        b=vxt9IJ3yWc7vxn1l58lQ7shpJIqd/Fiq0tUNlQuAkcJQgErqrUQwNni5Gea3KwzNI0ARzg
        3B3+wQnmxFrmGSeshLMYwIN8hOyKZve+gLxxkDoJKW0OeKXbGzcpDpNlmQ533fHkBTFDlC
        GJYNJQ0EmGI2o8isY4ugN+SVVMlSUkgxEc6sOD0tnWygTeG4rwmj96Dg2okl46lsENEtUU
        AcyjSMTBy24SrCkb3OXywPwrr/rlfyj7R3udt9iYKK2236JRCxCjtofTc4AQFb79KEDLWl
        he0i5WkUnL9Cxp3oB+w4OBwDHglPVsVBcuROXDnyGbOX3n77fT5ugmTviL1wAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696251555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wk+Vd4eULYF6GTN5ms33Ajkxz1U/FDjksj9rBwwG4bQ=;
        b=rrUEy7PNBA5rIIASxUtHU3PHDdzrf9ZmpNn4zI8lJkY7PxZN7/AhQal0tk4U6onHNfQbn/
        qHBLZb3u6vmTrfCA==
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 1/2] irqchip/qcom-pdc: Add support for v3.2 HW
In-Reply-To: <20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org>
References: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
 <20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org>
Date:   Mon, 02 Oct 2023 14:59:14 +0200
Message-ID: <87wmw5ch99.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05 2023 at 15:19, Neil Armstrong wrote:
> Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
> IRQ_i_CFG register and requires a change of the driver to avoid
> writing into an undefined register address.
>
> Get the HW version from registers and set the IRQ_ENABLE bit to the
> correct register depending on the HW version.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

This S-O-B chain is broken. Who is the real author of that?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Thanks,

        tglx


