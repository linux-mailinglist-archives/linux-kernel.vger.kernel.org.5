Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA1809110
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjLGTKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjLGTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:10:42 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053C8E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:10:48 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so13507411fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701976246; x=1702581046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfswJHbbaE8lthgCuxsCEF+7HdLrX0KCYICyRwFYL8Q=;
        b=DRqd+z8mWcy9cSBAJFc7XovxoM6gE47GuGITuKPQK4NkbBOVry5J6gPE5gfcD7lwWi
         WEbLXO3DL86Lbj9d5q23MNd9tTDTZC8Mr8KaAEt4r6uQvnySUNmNuu4RYzP6kJ4UI8mN
         XkqfyYS6hm7YZfnvTc4641eYzQ/UUuHa1xBsTOIe82yQ5BIS89bO3wIE+lPe0juZC6Jx
         rikzEimLdfdtjE5VLlpagn4OC1KYSVaV28sMGdmAXaYmO9++Hn7K7gSfPut3utapgvRL
         42WyR44zjJ+bsH8VtCk024ehGbooNIlnpJmAxokVqUTKRNgTYfPNOlRBMuAfJODG8F4C
         gpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976246; x=1702581046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfswJHbbaE8lthgCuxsCEF+7HdLrX0KCYICyRwFYL8Q=;
        b=ATuZOZDQUpok7LmypmlSExv9+YdCrvlg09zEjCRS4OdpwQgJJKSZTFCGQwrSizjwjf
         aO6wcjuLH17rPlGlTG5w5z+FyMYsSmLaYuUh+rShPaLnpfOAtSSyK41/Ins30VBN5foy
         aGdKvkGhEnDWnYzTMALRU5KDJ/pU0clkuINV92jspeUJ/juxJTT2GmdJDCsopdiHHaCh
         STg+SVL8lLhacOjRespxsMs1RyAC+l9ZArFpQrVGoE6JM47hPAwSFAubkp3pgIefvqKM
         tHbQaibEPqJPurnhk+XreXZtO8xckE9tWurO8sbTxvWS4sKXLWnNV4PHaW40em8Q2NO7
         tqjg==
X-Gm-Message-State: AOJu0YxObIhO9nuxKJKvBOB4j0Bqud6h8M8XphQpxACMvf78e6JF5ccW
        EHpWr1kK+XM3+7dvo7JnQgINIQ==
X-Google-Smtp-Source: AGHT+IHHZzDwVjEoqj5L0COX7ANyUFp8QKEMmxG3cMwdjoXkbsmuUH84Uxh48VDZssIMNDNTOto8AQ==
X-Received: by 2002:a2e:9991:0:b0:2c9:c8f4:1c0c with SMTP id w17-20020a2e9991000000b002c9c8f41c0cmr1649768lji.32.1701976246456;
        Thu, 07 Dec 2023 11:10:46 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e9b52000000b002c9f75a48fcsm23408ljj.16.2023.12.07.11.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:10:45 -0800 (PST)
Message-ID: <014a4a44-0da2-49e9-ab1c-f4cc1ca2e218@linaro.org>
Date:   Thu, 7 Dec 2023 20:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect provider
 driver
To:     kernel test robot <lkp@intel.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>
References: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
 <202312071325.M9cg1wry-lkp@intel.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <202312071325.M9cg1wry-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 07:06, kernel test robot wrote:
> Hi Stephan,
> 
> kernel test robot noticed the following build errors:
(.remove -> .remove_new)

Konrad
