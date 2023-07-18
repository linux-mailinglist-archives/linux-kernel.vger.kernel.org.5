Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B64757E10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjGRNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjGRNqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:46:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BAC19BA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:46:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb41682472so9265362e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689687965; x=1692279965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnKBW7yye6QuXNJD55LzwMeZTay30fjhiKJ9RuY3aUs=;
        b=ilESjBsdKoTgGKH055J5KBwRCfpNLvPlLlk+vrZFkaUpKOjrB2lM9AzrNMiOwGjH3x
         eST+B7zY+EdJ4pV1oqMSlNNiw+9FYjAOfSAsOrCH1v6Gdof7oo5GlrQodkBk87yFbcj8
         GcyvW/yHdkY8oMwCgmQdoXXeVOCg0g9Fq/5ZfhNhQrJ8b2E/Dwlv0VHX/XdxehQCWPgw
         xP3mYd7vZAtXfWwYD+FA9YrXWrBFyxNvKrAb4goEU6DtYX0HJmOJk1+3MvgyjHLLP5MT
         vNjD30Jnpo1U6vyiWjDcM/eNo920OGZYd33NahtJu7PWpEcnIySNLZPgA0nYdsRRbp2g
         74wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687965; x=1692279965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnKBW7yye6QuXNJD55LzwMeZTay30fjhiKJ9RuY3aUs=;
        b=gh5CgR4LSgg2O34SM/Oejm4nZSegQPsVRSeK5pfz4bk07B6i6Y/ao6annSGIfU6FqY
         vybK/K6mKeupfIXg1FBMyeSUej3g3XgfMbj2tk0+gsXoiK5LqMckaFadu0JLdHvRlMRE
         I/PPQWXagVMHPh/YO7QBK8B6ioJai2jTvbbCB0dyGuNLTFEh4xqtMDJKa0ZHRiSz7uuf
         5pDudNmvC36UZnCUgJQ21s7ohc5vpurM5B+xIZzsB2H1hZg0lv77B3yhLCVBc9RLm5G+
         GyRTO0l7Q/EqxTuhTnG3spsQJ8r+Vxjlwg3VBIy9Zf4xlRT2c16oW+XsNXHRJQAJwXdm
         fX3w==
X-Gm-Message-State: ABy/qLa0YT9wfVFaUyZ+bB7uRc0mot6c8ygQ+kZbqy9h9vPWpfCgQtZU
        uI1OVf1etnM11ORb8lMsEeFDTQ==
X-Google-Smtp-Source: APBJJlE6OoSoxSXBAegX9xpf3nzq6Ie2ropKqv2Sr98dFazxMHT2h5TeezIhq+GHW2af7GFYkNtNMg==
X-Received: by 2002:a05:6512:ea3:b0:4f9:5c89:5b08 with SMTP id bi35-20020a0565120ea300b004f95c895b08mr16166091lfb.21.1689687965005;
        Tue, 18 Jul 2023 06:46:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id y5-20020a197505000000b004fbbe067a5dsm445674lfe.179.2023.07.18.06.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:46:04 -0700 (PDT)
Message-ID: <1da2842e-e5a3-e0e5-ea7d-7da5f4b84001@linaro.org>
Date:   Tue, 18 Jul 2023 15:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] clk: qcom: fix runtime PM bugs
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230718132902.21430-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230718132902.21430-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2023 15:28, Johan Hovold wrote:
> This series fixes a number of runtime PM related bugs found through
> inspection.
> 
> Johan
I was thinking whether we should maybe incorporate RPM enablement
into qcom common functions.. The only issue I see is that some
clocks register pm clocks atop that, but I guess we could introduce
some sort of a pm_clks names array to solve that?

Konrad
