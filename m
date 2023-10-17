Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE97CC865
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjJQQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjJQQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:08:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A09FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:08:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5056059e0so64631431fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697558889; x=1698163689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXUVFLuGWe++aoZT0wJj36hT5pM9P4ypUZCtPuexOjw=;
        b=ZsHDtaFC4jqbz0k2U0XYVY5Ugpp5Vx3dNvixSgq2lGFIfQPjBFbCiOoSzDQZngWRjC
         iLlVME80l3QJ44TFlTbdlauMZiAVj2YnL5hHKO5RoEmcJVVXXj/6jd4HCkTJO1wd0dt6
         nC7Co9Qx9lxCQo6kR4kdu8Y88mwUvYSHMe7BPVx5L/P75YsNjNNOEc9mKRoALxR3N+zU
         zMeFgWpstfb2JdnpRghi6V8R5U+nWFn8v5fG/4hOQPIhTeZfonB0psIiqWHl6tIzMQQy
         fDePddXo4lpY7lOtxIftgZ90pDlhopfNKINi8I0Y7DheTEkldFdf6Qiv0fdellD2bSS4
         qcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558889; x=1698163689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXUVFLuGWe++aoZT0wJj36hT5pM9P4ypUZCtPuexOjw=;
        b=BNIUhICYLaYtKGMj5dOd+swX+H3s3GXDZzdWQuhG9PWejsUimJEn1dRvuvn5MEFWo/
         H59i1xZ7wBHHwk4nDSVnUm7YYfi7p2FgombOZiq/GVsEN182Pq1s2wYULFYnptNMiaHc
         mK2JWcWghuIC0ggnsASZgQTC1K5n7NcItEcje9KUfnBcJl4Ht/+nA+Ko2m9bH5MQf9AY
         hEu0KTb4dNXlXaO4N183gu8hinEeSZuRnhUNyPDU+10If/T8kL1WISC+XfZWSpXBZ3fK
         XApDiaKhBlTvMDhQv/LxVEVmwSQG71KZbKzPS2V2SQEl8s5tTYJKUgaOBTt2KDXnnZfx
         z+Dg==
X-Gm-Message-State: AOJu0YzIk5/HGsEqYGr29nSsJ2d894kqub4LchAUUduaewsrfejpd7D8
        owHz+BreKydQBCPufljRxoH2BQ==
X-Google-Smtp-Source: AGHT+IHh5FeDbyGyeVnlphOki8VZ9lFsnG2X0Mgs4+Vrv20Krkq5G5q3XcJAERLYzPkoSS+n65D84A==
X-Received: by 2002:a2e:a793:0:b0:2c5:409a:a901 with SMTP id c19-20020a2ea793000000b002c5409aa901mr754407ljf.49.1697558889419;
        Tue, 17 Oct 2023 09:08:09 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id l6-20020a2ea306000000b002c123b976acsm320345lje.76.2023.10.17.09.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:08:09 -0700 (PDT)
Message-ID: <e2e8c78a-98b2-42a9-a472-fe0c3332a2d7@linaro.org>
Date:   Tue, 17 Oct 2023 18:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] usb: dwc3: qcom: Rename dwc3 platform_device
 reference
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-2-ab4a84165470@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231016-dwc3-refactor-v1-2-ab4a84165470@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 05:11, Bjorn Andersson wrote:
> In preparation for the introduction of a direct reference to the struct
> dwc3 in the dwc3_qcom struct, rename the generically named "dwc3" to
> reduce the risk for confusion.
> 
> No functional change.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
