Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150247D8911
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbjJZTl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJZTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:41:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E054F1AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:41:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507c91582fdso1919818e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698349313; x=1698954113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv9e3c0vYJpSQOu3wQ5pqkHQb4sf+fuiufdpkPLTfYY=;
        b=BJWPYixO/5WAyXDGb/3or2z+oQayR6+1u2DT8sAOy9aGFbt7mY5ubznO1G2cGncOCY
         Gvi2x8/Edg8WGbqiWF0SfpOCjvZHHUVwDXxIonKDu/gp8uYva8ZWo8Rhj4w7Bn11cnjc
         IR9ETN39R2neX+xNDxTNOXoKKDh2pRfBbQkXwG92nabJMMxSXJUF9cq98s5S3nSYsZeN
         Q+HZIOppz5i8JW/7uYeLfDIf/Fs+T7JGPIlKTXFm6Hb3L57jif46oX+GkgmPZXl14HfN
         q0OT/ERKeqC/9uGMTp2eXHmpHGH63CIoIXWXXkC3ubcCwtzBsQEC6LTKoVG61EtpQR3B
         KyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698349313; x=1698954113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv9e3c0vYJpSQOu3wQ5pqkHQb4sf+fuiufdpkPLTfYY=;
        b=rkWvHB62nSdg8vldRyGoB6fO6gAxjCY+9yWa7lNfjEw1Qu3vckQ5MtDcIMtpyuO9NN
         Jp0Kfv0pQJ3gGpVgWJBELONb/ub97E15tPadL6ICkoH2B2reHLggqvl5A0aSb+ekyZbQ
         kZFyBh8X3VqLh2dfB2Ugbd4/4NxiSN0aN5JEYvffxwcH8DqHuYXziu8PrU6HyguZMIP9
         XoDYgouVnjuUB4pBAYzyuZatd3Sn7wQc6hJcJ3OivaU0MPzQOdeYhmPKdo6DyNlztcDb
         VE3QnZzcGhJUW4PY7uHO7vKVfbfSEWQ+JkvCBGkQ3VzWlAAG0eVjP1VZBIQh3B3gmhv5
         8fLg==
X-Gm-Message-State: AOJu0YxKP0s4pzVh3c9EqDY+FvMzxV6Ow0AwB3kJqSAJonfsRTE4srnY
        u1l/q27XtZm6spBRO6j6hFA8HQ==
X-Google-Smtp-Source: AGHT+IEV42/WXjDvpBt1MNwbTOucybdRAINQLTcLLH26E/VA4usoRuNIF9H1t8+PSj5EnJq1P/1cHw==
X-Received: by 2002:a19:f70c:0:b0:503:3278:3221 with SMTP id z12-20020a19f70c000000b0050332783221mr250707lfe.69.1698349313166;
        Thu, 26 Oct 2023 12:41:53 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p26-20020ac246da000000b0050799f7cd6esm3140466lfo.208.2023.10.26.12.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:41:52 -0700 (PDT)
Message-ID: <c1929d63-93a4-4425-bdd1-d76a696b528e@linaro.org>
Date:   Thu, 26 Oct 2023 21:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] arm: dts: qcom: Add pmic glink support for sm8450-qrd
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-6-quic_kriskura@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231017131851.8299-6-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 15:18, Krishna Kurapati wrote:
> Add Pmic Glink support for sm8450-qrd to facilitate passing
> of roe switch notifications generated by ADSP to dwc3 core
> via ucsi and pmic glink's.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
No phy+redriver+dp configuration?

Konrad
