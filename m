Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6F7F1264
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjKTLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:48:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C29D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:48:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9208C433C8;
        Mon, 20 Nov 2023 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700480906;
        bh=UJCr0Qxyssxmu6qLQ79trNX/zz2V3o6aWjqu9Go9EGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kz/Brs50IcMgJfxqKA3Y45Qnhy8zmk2rLYiKRpB5gtTmmIT5c1FTOWLh9+v0r3E/f
         /F4UgkVSOXxaDkI65mOp8SyHQES4a3VHlPa3Bv+XolZFGSOrHlaeiEho+40GWOyrIK
         xMeB3zP2c+KKRrNcDFvO7eaHgu7l2y7Eq4lJ4vqsQV7DXhb7Uj4fb7dfirehA3r7V4
         aTng1b9w/0jH0cKHhSXP9YCUfDs2IinC0+wm3XsRgBm4nX018THuQXsDWM+c+OfD5e
         xPm9rJKN7dS26zFB4c9DIEuCP0COqiKjHOvBWZaOKX9ZByD7FXg9FbjP/q6zYvqEgq
         5pzIQbH37FRTg==
Message-ID: <47925f9e-32aa-4762-a4ec-aa559e18ff12@kernel.org>
Date:   Mon, 20 Nov 2023 12:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] Add runtime PM support for videocc on SM8150
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2023 13:39, Satya Priya Kakitapalli wrote:
> Add runtime support for videocc on SM8150 and update the resets
> and video_pll0_config configuration.
> 
> Satya Priya Kakitapalli (4):
>   dt-bindings: clock: Update the videocc resets for sm8150
>   clk: qcom: videocc-sm8150: Update the videocc resets
>   clk: qcom: videocc-sm8150: Add missing PLL config properties
>   clk: qcom: videocc-sm8150: Add runtime PM support
Hi, it's good practive to include a link to the previous revision
and a summary of changes.

The b4 tool [1] does that for you, please consider using it.

Konrad

[1] https://b4.docs.kernel.org/en/latest/index.html
