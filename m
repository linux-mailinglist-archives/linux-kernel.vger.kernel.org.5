Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0A770E4D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjHEHNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHEHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:12:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862184C04
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:12:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-522c9d388d2so3441421a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691219576; x=1691824376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EYKHh9zvdAN2J1bA5/eS1HMxCXCRGCzihmZHexGE78=;
        b=k1k3AGZmulqQC8ludWvwxbPiYrcVqk+o7I68hdA9euUYhnNu7buw3mc9Lm7HHiDDkz
         u/r86NEkT9ycpKdcFLo+o6FGvlxHbT7bzJ52FVp2/gpPUe7hy3+EHe+n50gfFt5qbu/t
         7/Z2B91DENrTVCGt28Dsr/Tt8z7eyC5/oE7IBXjocUG46pnhI63N5RwCCEpdCMkExvk+
         s8roCyu4Xfj8MHQbRKo71dx1BM5qaKq2bPh49C7L3kPlLg403q2ySgeHlM8bK7zhlx9e
         jXNDlrxhICvlw2xIvO/js9FwG4CRqjlK6rDjmnz3XoXTWW+mB0/p1u4/7FX03bFZ0Ypw
         0Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691219576; x=1691824376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EYKHh9zvdAN2J1bA5/eS1HMxCXCRGCzihmZHexGE78=;
        b=H8fC4QzZ3oWta5xNKtG/Igfothgf3rWzPY9wBSF5syFSBHl4H7Lb59b5uxvuC6HeUg
         sR0FrnUQA3nw7iss7IEB7lgxgBBhoeirV5k+eJjbD4YvH8zLi4NWefykp1J2s7i/9XW9
         7t9Zkpa4d3x6fCdk0GIZAXNFlKIGOYIuEfmCQ0/5Yuolo1HPgAOzxjasbHn3syjtRii6
         oIlLHyZDyhZobkyahoit7PrEET8xJP1llLbjPdma7yQbBs0yoHRMt/kfQYYwTs4PK6zG
         R4TQ9RxOhb77sXXYvynsBU+vu/kSVsGneLrb2nw/X6Nfp8AvePaKFXcNfN/GeUKGBaXt
         CRTA==
X-Gm-Message-State: AOJu0YyNmUx9xGiXiYDfpLBA60MHhIO7SFRwXyMbqeyjfq3gRT6v6Fx9
        AK6wY8e2qao5oJrbIoR32fRR3g==
X-Google-Smtp-Source: AGHT+IEBKGPV9a+L0ZJ9F30Yqa3AMwT7ZmB0w3Kd7xbiSD1oCem6izMufS7UEUKCnXqOxqNDfjIOIg==
X-Received: by 2002:a17:906:2081:b0:99b:c689:3f3d with SMTP id 1-20020a170906208100b0099bc6893f3dmr3165876ejq.25.1691219576097;
        Sat, 05 Aug 2023 00:12:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id bw4-20020a170906c1c400b009829d2e892csm2366994ejb.15.2023.08.05.00.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 00:12:55 -0700 (PDT)
Message-ID: <c113197b-038f-c2a1-bc83-4e009b4ac187@linaro.org>
Date:   Sat, 5 Aug 2023 09:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad
 DTS
Content-Language: en-US
To:     Matthew Croughan <matthew.croughan@nix.how>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230805044558.279473-2-matthew.croughan@nix.how>
 <20230805044558.279473-4-matthew.croughan@nix.how>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230805044558.279473-4-matthew.croughan@nix.how>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2023 06:42, Matthew Croughan wrote:
> Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
> and its peripherals
> 
> Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This is FAKE, no. Please do not invent fake tags.

Best regards,
Krzysztof

