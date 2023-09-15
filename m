Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD707A2685
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjIOSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjIOSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:47:41 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F36E26B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:45:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ab244f2c89so1608632b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694803544; x=1695408344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc6N8q1gZ95xd8ZpHAufgS4nDSL1wE+rjEdZ65KQsuw=;
        b=qaGc3i2kjpKiLBAflyHXKX/F+6iOeJ+awGWr88gEK67InMTl5x/kuRDzAKHO4bD2rj
         EMTcLNDozSD5VlUEBf1zaHmcu0MNKrkDcTamASiqNbvuLnLSE44Or5sCLEXqPgExxIrT
         a5oOlZyC7j2973zEvGxNjCcPtH1MRzYz0+FB8e6xqxh0Aioau0Qh2boDzwn0tbTYjDog
         QwL1n3Q6ENrblqq4zn1Mfzdhz++wodZDJESN7U25WsbTp7N9S9i8we1Ugcowsm0N6xCY
         XGPF5aYlECdwT3QVIkWslAzBGzUX6gtJ4XlvQM7ZgoU6+rqoVKwDp9XXD571GxzMmEbO
         l3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803544; x=1695408344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc6N8q1gZ95xd8ZpHAufgS4nDSL1wE+rjEdZ65KQsuw=;
        b=KY41wR8/c0SZ0JMt/cOhCE8Io457owW5aKa7FG83IqGsBYNqod4MCmjxD3ue73nmny
         KtJQ5LF1MBdL9x/thp7g9EomDEPlF6X4oYQ5gO447XUCdq4gMcLmbXPUZ1Oz0WnuttBJ
         QcO7k/3s022BBo61EplgBbBvGhv//DospcAvNss82UP1QuPjjrtGtJ+y9wcdY6OPAq63
         RwK/c0wHgkpSI5a41YufNfxoh6RQtECR8Vplsrm5G9HHrTzoS+xAO21eJuAekL4vngi4
         IU2J+mf+nGAsLiJf83s1GP2kWS/CJPsPaUvngAc7WgUyAi0w3vBGWR4IUtEbAWQMCxV9
         W54g==
X-Gm-Message-State: AOJu0YzQZaN8HAFGvAcV7fFcyhRQYLQTmHbHZxPE/nEIAsJ4jqa8J6yv
        6MYx46ujOzsn8Y0l196xC0hZ+F953H2mm7MXdaVrQw==
X-Google-Smtp-Source: AGHT+IHzJEqXtPBsPW5jLeFQcrS9Dk5aUh3URVKOBbbZYM9R7XAZ4gEp09I5Ct3eiDOjHZCwgOeYUuK9STXkvNcsKSs=
X-Received: by 2002:a54:418a:0:b0:3a7:45e0:c0eb with SMTP id
 10-20020a54418a000000b003a745e0c0ebmr2846439oiy.24.1694803544202; Fri, 15 Sep
 2023 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230915121504.806672-1-quic_srichara@quicinc.com> <20230915121504.806672-3-quic_srichara@quicinc.com>
In-Reply-To: <20230915121504.806672-3-quic_srichara@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Sep 2023 21:45:33 +0300
Message-ID: <CAA8EJpo6hb=cxJ8wTLf+fEc8B30dhT67XWbqiNrMoRfUxUnqSw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] thermal/drivers/qcom: Add new feat for soc without rpm
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 15:15, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
> enable tsens would not be done. So add a flag for that in feat
> and skip enable checks. Without this, tsens probe fails.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
