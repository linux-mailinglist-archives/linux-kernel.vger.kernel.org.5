Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E947B5043
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjJBK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjJBK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:27:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C18B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:27:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50444e756deso21330042e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696242439; x=1696847239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpKL6ooo2RC7L7hkwqJ1ttaddflHNZUjlxIn+1dGSiM=;
        b=TTDHhxEU57dFD9aSFS2D6f/N7D5NnLjMmP5Y7KfHVF3N0X60nBPXv91VJCpS0+1n7V
         +fNNG8JxUeKdsmFndcKMjmQjxYTFys31K4VZ2EvvzvNrt/wEE88icONK/o8IG26bvFbK
         Ppc+zUAxw0nnIaZ0dqJSX37y9stxn9CvtvVpT1xh5gnvsMOg9Bvq2whq4lZYOyHj0f+M
         M67jwXvsh7laF9creM/NPK6rHJWtPaBO74JBc9I4d3oPdHuxluGEH9H2lLldfUJa14D7
         sOVbZXoD7Etn5OOwYvGP8A88Vhjtp9lyd6sWkOyY6sQsJrXPJ13eQtvSCoXSrJuDD7MB
         TGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242439; x=1696847239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpKL6ooo2RC7L7hkwqJ1ttaddflHNZUjlxIn+1dGSiM=;
        b=eT/iMWzZVwHqV4EVcDxxIUguneCYnrIlphxcFsMwiN2LaI0vaiM7MC8QilGuRv85UO
         AOl/rFYN2X8sTE2w8fNeqYHqKit9HOYr3/4w/TtDiTpUL4JOoDUK1WS9OQ+Eww1AkFei
         zA9OJ63tYZlRinfA8iCTCKdNEclRDXDVIjyAQnk1t6iAwpISX1xsyPgvNTcu2TVnB9eu
         mQC8NLLMKKX4KjlHp9Dn9oRB5P3jBlLmyMmDoQqaIajaHLnI9yrnAzaBYTOL0qNof3fp
         7VowDQOU2TL/Mj+s7s3WV01MRHtMG2YiMmEg/8hcOkcD6qgv3e2T3T8zCapxGxWklacC
         vmhw==
X-Gm-Message-State: AOJu0Yxa6vVhlkSDLNCrVonYmfovlyQPjzqE6GAw2p7vW2dpNvpzcPw9
        oYt9PUesuSScTPuYDMBKe1rmVg==
X-Google-Smtp-Source: AGHT+IE0QMjbAtS/nGnThzbZ/c8rz8+Z49l0o3tC09CTEm8TdkH5/oAxSd86Hsv63OFODt5PPvblpg==
X-Received: by 2002:a05:6512:3148:b0:500:cb2b:8678 with SMTP id s8-20020a056512314800b00500cb2b8678mr8963795lfi.40.1696242438834;
        Mon, 02 Oct 2023 03:27:18 -0700 (PDT)
Received: from [172.30.204.164] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512359200b00500b0809179sm2461818lfr.290.2023.10.02.03.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 03:27:18 -0700 (PDT)
Message-ID: <f123856e-c741-3eb1-ec8e-51ba78ff6090@linaro.org>
Date:   Mon, 2 Oct 2023 12:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/4] usb: ucsi: glink: use the connector orientation
 GPIO to provide switch events
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231002-topic-sm8550-upstream-type-c-orientation-v2-0-125410d3ff95@linaro.org>
 <20231002-topic-sm8550-upstream-type-c-orientation-v2-2-125410d3ff95@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231002-topic-sm8550-upstream-type-c-orientation-v2-2-125410d3ff95@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/23 12:20, Neil Armstrong wrote:
> On SM8550, the non-altmode orientation is not given anymore within
> altmode events, even with USB SVIDs events.
> 
> On the other side, the Type-C connector orientation is correctly
> reported by a signal from the PMIC.
> 
> Take this gpio signal when we detect some Type-C port activity
> to notify any Type-C switches tied to the Type-C port connectors.
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]

> +	device_for_each_child_node(dev, fwnode) {
> +		struct gpio_desc *desc;
> +		u32 port;
> +
> +		ret = fwnode_property_read_u32(fwnode, "reg", &port);
> +		if (ret < 0) {
> +			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> +			return ret;
> +		}
> +
> +		if (port >= PMIC_GLINK_MAX_PORTS) {
> +			dev_warn(dev, "invalid connector number, ignoring\n");
> +			continue;
> +		}
> +
> +		desc = devm_gpiod_get_index_optional(&adev->dev, "orientation", port, GPIOD_IN);
Personally, I'd add a comment about this being a lookup on the 
pmic-glink node, as dev is reused throughout this function

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
