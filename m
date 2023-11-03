Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B27E0558
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjKCPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:14:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDBC1B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:14:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32fb1d757f7so867719f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699024491; x=1699629291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQmtajR/Lo5kWZGagJsWizBqcJuSRUlM8N3Px2Mnlzc=;
        b=WLW0DLxhI6kNo/vp1JLsCwd5z2ctRoiSgmOMUmrtNkjrJS8ksnB6Lnr9KClsKfeR6s
         zLs+7jabuSJYFFvMJVzKgEF9uj3trz0B868fvE33Ysywxoue0FB5HxzP4RQ5HoAC2tIJ
         XATbApGnxbjk6HmtsQ58KIvR5Os8kzjii/IiExYsHHaot80spaquxlfVqiOrS/JU9SUb
         U9VBacCBzWuuGy+0wt5kwf+qeHEkSJomzZUrLXU+dnwkxphzqm7EETBxDC+mVpzxr3hT
         uZN1pW91Ys5b+etp8ISYEmrCUJCZseUxQbASPULys4blLcC2v3g05tV+OLy+9/FCJBN3
         8vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699024491; x=1699629291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQmtajR/Lo5kWZGagJsWizBqcJuSRUlM8N3Px2Mnlzc=;
        b=m4z79gTa/DbFicp9ECvrVhueZW+q+xJwNapREHk/e75a4IWuy7r4tIr4oh+Tayespt
         fameojOKcmjWfioG7kaCoqj2TNGobyHuSW29/MN03o4Qzrjb1ix/QZ2OHJGPZFZC6Phl
         rPGkTOKT6oYGVPmE2uYUeoFApNZOe6hR33UX3Zm23nftHNumYKJh3y1fqjwc/0Y84qDF
         r3Q6fSFZxrGGD862fCEJe7rr2lfREn/K55vTDD1033P8u8rI+LRsWiM6Xu4xd60kC6Ub
         //1XrguLt2OvglH/8J+uQs7T0ZT+4y0vPOVl2unTGPM9ZAhQMcfwoVIv5TI8N/TlvoUh
         zKOQ==
X-Gm-Message-State: AOJu0YxW+LMlSfeMJHKGw8iyWZZKUNnsrX+7QXGd42R82qBikLJMGvAb
        eqQ5Rj8Bk0au9Z7K2Q6l37/VJQ==
X-Google-Smtp-Source: AGHT+IGD/xeq7bY+n2+xagtvTANWbDHhn+sJbmaTPg5nPjbUi9qXD9HyIs80yHobXO3D3Wqg4buNJw==
X-Received: by 2002:a5d:6f1a:0:b0:32d:b2cf:8ccd with SMTP id ay26-20020a5d6f1a000000b0032db2cf8ccdmr27222679wrb.47.1699024490887;
        Fri, 03 Nov 2023 08:14:50 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0032f99801273sm2065454wro.66.2023.11.03.08.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 08:14:50 -0700 (PDT)
Message-ID: <e700133b-58f7-4a4d-8e5c-0d04441b789b@linaro.org>
Date:   Fri, 3 Nov 2023 15:14:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] usb: dwc3: core: Register vendor hooks for dwc3-qcom
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-3-quic_kriskura@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231017131851.8299-3-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 14:18, Krishna Kurapati wrote:
> Currently on QC targets, the conndone/disconnect events in device mode are
> generated by controller when software writes to QSCRATCH registers in qcom
> glue layer rather than the vbus line being routed to dwc3 core IP for it
> to recognize and generate these events.
> 
> We need to write '1' to  UTMI_OTG_VBUS_VALID bit of QSCRATCH_HS_PHY_CTRL
> register to generate a connection done event and "0" if we need to
> generate a disconnect event during cable removal or mode switch. Exactly
> what is done by "dwc3_qcom_vbus_override_enable" call in dwc3-qcom.
> 
> When the disconnect is not generated upon cable removal, the connected
> flag of dwc3 is left marked as "true" and it blocks runtime suspend.
> 
> The goal of these vendor hooks is to let the mode change and cable removal
> notifications from core reach the  glue layers so that glue can take
> necessary action.
> 
> Before flattening the device tree, glue driver is not sure when the core
> probe was completed as core probe can be deferred. In this case, glue is
> not sure when to register vendor hooks. So mandate enabling runtime only
> for flattened device node platforms so that glue can know when to register
> vendor hooks.
> 
> The following are the requirements aimed in this implementation:
> 
> 1. When enum in device mode, Glue/core must stay active.
> 
> 2. When cable is connected but UDC is not written yet, then glue/core
> must be suspended.
> 
> 3. Upon removing cable in device mode, the disconnect event must be
> generated and unblock runtime suspend for dwc3 core.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

What happens to this code if you

static int count;

1. sleep in dwc3_probe for 10 milliseconds
2. return -EPROBE_DEFER
3. if count++ < 5 goto 1

i.e. if we simulate say waiting on a PHY driver to probe in dwc3_probe()

and what happens if we introduce a 100 millsecond sleep into 
dwc3_qcom_probe() - and run a fake disconnect event from 
dwc3_qcom_probe_core() directly ?

In other words if make it that dwc3_probe() completes and struct 
dwc3_glue_ops->notify_cable_disconnect() fires prior to 
dwc3_qcom_probe_core() completing ?

i.e. I don't immediately see how you've solved the probe() completion 
race condition here.

---
bod
