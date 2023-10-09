Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1F7BED76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378760AbjJIViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378731AbjJIViS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:38:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B3199;
        Mon,  9 Oct 2023 14:38:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47504C433C8;
        Mon,  9 Oct 2023 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696887497;
        bh=bERebXPDUaNc/lQltowjvc5/z7bVq/9gDNUCTZ2cnXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j0ZiwlfXwpIUT66IaHHI/4ENkgcqpr9c6pfwQBdrLSXKxd08Tf5PCMu1SjuZ7v5EM
         Sc6sC/YTHl0XzeSow+xEiycD7s5T18sN6pb1LMZXeE9OfaI6Dw+i+IO5p6OlRr7yjo
         isrzZVYdxCuQf42zTUqZdrq39Mh2m5UQMJdY6t35Gk0l2p0mG3VRA8v+nf6X0q0tcw
         inFUcefTazRnBapDqNgS4JUzzPkmrQ4zt9zHiRWwzd4+fa5ufzYkt1q3YAY6ZqP6ww
         svTX2vtY/AIiH2+KNb8OjI4iEpCFk5f2lDM/YZjjv5O0St0vA2ONYSG78bqBmX5FdX
         Xekj/N0qeQEQQ==
Message-ID: <86d2d69c-f72b-4510-b3b8-46f207609232@kernel.org>
Date:   Tue, 10 Oct 2023 00:38:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Fix up icc clock rate calculation on some
 platforms
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
 <8a5297ed-be23-4498-bf8f-27326abc33a8@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <8a5297ed-be23-4498-bf8f-27326abc33a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.23 18:13, Konrad Dybcio wrote:
> On 25.08.2023 17:38, Konrad Dybcio wrote:
>> Certain platforms require that some buses (or individual nodes) make
>> some additional changes to the clock rate formula, throwing in some
>> magic, Qualcomm-defined coefficients, to account for "inefficiencies".
>>
>> Add the framework for it and utilize it on a couple SoCs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> Georgi,
> 
> since this has been on the list for quite a while and there
> haven't been major objections, could you please review and
> queue them up?

Hi Konrad,
I have applied patches 1-9. Apologies for the delay. It looks like
patch 10 is unrelated to the rest and can be applied independently
by Bjorn. I can also take it with ack.

Thanks,
Georgi

