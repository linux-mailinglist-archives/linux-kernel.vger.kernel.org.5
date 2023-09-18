Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9587A4976
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbjIRMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbjIRMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:20:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0329F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:20:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-503065c4b25so2624838e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695039611; x=1695644411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37gGL6Jw2l0tKYWgVGTCg3eSN+EAxtW6F9x/TNJWld4=;
        b=KwTCEsd4Z9EC9n6Y7NqI5fHh4S4UMCyDip5G83Gikn4/5JC/rt/nz4Ev3hpvS7ax/m
         iqul//xCSnyFR1fJkCMpatOdVFQNQCxlZGBtm3xbW0eNfJ66B6+1EeeJhCcoA+NgruHh
         9sU6eMDhLS4jramsQUHjeVbyk9cUYVoxRioewKQpPEJZR+ArS/Ilmu2/xp39jNPe0iDT
         IiMMU1jps4KSEwZkfYbx9XTUmywALJmN5PZYbqNbkLDWCjgnKMo1LulAmQsPhNxABjm6
         1PCDtKn3q5x0Kn0/UuhROiJzZAHEh2NLTmKeZSleKAOj8Y/kDz6RiBbHhvMfHEwcE8/W
         8nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039611; x=1695644411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37gGL6Jw2l0tKYWgVGTCg3eSN+EAxtW6F9x/TNJWld4=;
        b=Tghi1i4Wvs0aYiE7vmWo0+sdRMLI/ejmfq08oKC55uDy1TM6srak9COllISAbldasi
         uwiEx3joRs6jefydaAM47A8Cwt4a+HuFNVdO3MN4cy4w6B8Qu6oY0ETCJLGIprleeSdJ
         8My5xU7RK+newbCwbaZNdYXmU1du5pkNKs5cM/Bi5jIZhizYmvAZr6BFCL9v/v+eQ0pq
         ZBGZaFSoS9cW2fetEnpLQUcBlVNuJNVBxJuKIdLf39ZWXtq9R2m7raF6R6nDNHB3ir07
         pSG9SgbiZ2RrWYgq9iEJt+csrF9780iyZ7F1MV3LI9eJHuSzpgX+OaOJBDV9NQQy1Fnm
         crIw==
X-Gm-Message-State: AOJu0YwdRg9AWRZWCjchkYJNOtID1B6mJJfVZGNmqAK5eWRtZN5KiGQn
        ct4DaHzh29QTnr7sIXQWeiyJJQ==
X-Google-Smtp-Source: AGHT+IHMkJKZiVpJg+tLigw+N6NXKAtpmNFN/BdLPmJ+19DhydtwsrfEqqkG3R0omuA7UHeHeMpURw==
X-Received: by 2002:a05:6512:1115:b0:4fb:9f93:365f with SMTP id l21-20020a056512111500b004fb9f93365fmr8492523lfg.38.1695039611392;
        Mon, 18 Sep 2023 05:20:11 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id a3-20020aa7cf03000000b0052e1959db1csm5966342edy.20.2023.09.18.05.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:20:10 -0700 (PDT)
Message-ID: <d70ae419-0038-c9da-8e4a-5ce90fe61f79@linaro.org>
Date:   Mon, 18 Sep 2023 14:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Content-Language: en-US
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230918031835.12352-1-chun-jen.tseng@mediatek.com>
 <20230918031835.12352-2-chun-jen.tseng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918031835.12352-2-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 05:18, Mark Tseng wrote:
> Add mt8188 svs compatible in dt-bindings.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

