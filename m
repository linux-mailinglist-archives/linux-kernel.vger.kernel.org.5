Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95478F90B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbjIAHWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjIAHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:22:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76710D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:22:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so2122412a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693552947; x=1694157747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPFsQnNFOyEr/TykWKNk6Jb2skH/iHM6FQJgvqRqvps=;
        b=WPTuZWSXyo1h+b+TfFV5S1aQRMEl8CHlEKKlmrZTy9oMNFvwuiE4P6gTkUV87w0SsC
         +tqwKyQQ9bLDkZafmJEowPP0xLZPbx/2/MJncB9ew0zHTe7tQE2tuT+BU4TH3dbDMXPK
         IAWrn4mKXkAZD3rsWQGvlrAr2RCnrlXjBMVstwPX5VjLfl89lTIG0so58yC2v/l1vTws
         o5S30pRg5SjurCikElK92Hu09M/XCbBkGKJYbr7NvDvfsaMdvcG0H1gCUo+yTduIRW2/
         5ko9kIk7Chkdy1gNO36Jof057/wYH8Dx+58xPNqPwSturygAsV/cmyM8dZXoRVP8MMG2
         xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693552947; x=1694157747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPFsQnNFOyEr/TykWKNk6Jb2skH/iHM6FQJgvqRqvps=;
        b=dcLVfW8axQ0+89L9iFki842BcyRsJzKhhkIhU1WYEGO02eccADzNT00H7QisfxUVhJ
         eFdKX1OF1YKCNaIftNqmrhz3t6pyKv4dcJsf5NQxDnzlvgh9jmmxYT4aFBn9JQopM/b7
         +Qcj1bohvnqEKMIiJwvzBEM8dFuyitYnlQvwfEm1fc4qw4+pWQ78PuNeZVFmIGsnHWdH
         84CfiXHOKbZJGdvGZ2OjBKLlyZBh6AeSTkMv6kFfNkW0YP9QxECgfekKgrDTKN0B3bbp
         RwK4O6Vl/vav9hpojS7Y/Qm9doaPvrZIR5flkaj2lhqN7k80K5wlgzY1IfRRpGA14QZV
         6JuQ==
X-Gm-Message-State: AOJu0YwK0bDEzByXxJbp17H+LGbESsx/Zj3iZnYKpQk2m/7MWjSw2gpA
        YtP+jAZp1myI+bAlG7dMzNCDag==
X-Google-Smtp-Source: AGHT+IFgN+HP2h7HdCEHswR/JfRaRMzRiHzFqtC23Op5CwtCJi3SNSIxWFUJtkdGiI04AMI4XWMdvA==
X-Received: by 2002:aa7:c3d4:0:b0:522:2711:863 with SMTP id l20-20020aa7c3d4000000b0052227110863mr1351919edr.1.1693552946615;
        Fri, 01 Sep 2023 00:22:26 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id i14-20020aa7dd0e000000b0052bcdbe263esm1748912edv.36.2023.09.01.00.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 00:22:26 -0700 (PDT)
Message-ID: <f340f731-8471-39be-c7b2-7d930916e3b1@linaro.org>
Date:   Fri, 1 Sep 2023 09:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: firmware: Add documentation for
 qcom,platform-parts-info
To:     Naman Jain <quic_namajain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_rohiagar@quicinc.com,
        kernel@quicinc.com
References: <20230901060223.19575-1-quic_namajain@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230901060223.19575-1-quic_namajain@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 08:02, Naman Jain wrote:
> Add documentation to describe device tree bindings for QCOM's
> platform-parts-info node. Firmware populates these nodes to pass the
> information to kernel regarding the subset of hardware blocks
> and features like Camera, Modem, Display present in a product.
> 
> This is to support that the same software image runs seamlessly on
> different platforms where one or more HW blocks are not supported or
> if some sub parts for a particular block are not supported.
> 
> Purpose of these definitions is to allow clients to know about this,
> and thus, handle these cases gracefully.

Whether camera is or is not supported, is defined by presence of camera
node or by its status field.

Existing firmware (e.g. U-Boot) is also doing this - patching DTS when
needed.

I do not think introducing some parallel way makes any sense, so no,
that's not the way to do it.

Best regards,
Krzysztof

