Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE77D1E64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjJUQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjJUQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:48:39 -0400
Received: from box.trvn.ru (unknown [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD9C9;
        Sat, 21 Oct 2023 09:48:12 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 64C3141885;
        Sat, 21 Oct 2023 21:47:35 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1697906856; bh=yICm6dRSai3l3BNB3f2xPBxCmxJwxpldtGL7sOQDsbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmvO0iEu77pUW+VBiQ6/14IhlkveueWvBgs/uAMqO8W3PHAkomMHaRlI1JAVI1NUH
         e3/BCc9k+feKmhLqKBvrZZFMWvHXz0RClKFiy9ajs4lXoLTiELs7KTK1Tx2q7ZKO7V
         OLY9gmYnW580+aRCxxdrR3s1pqf/g5l2jRqaRbsY1YbQqY9pAiYzMPPXkMV7tiR8g/
         G5tmO1kZps6OU9vCI1l0y2BQF9Rda9G4FPzTNa8i9gYWzG4RRrAgM5505k0yD6Qd3h
         brmb5wrakeSxVbpRbiwo9NqxzvsgnYP30iS0hRyUElxRyr9lN4toZMnKIP7QTkY5ks
         aCJQ+aX25Jitg==
MIME-Version: 1.0
Date:   Sat, 21 Oct 2023 21:47:34 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, jenneron@postmarketos.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sc7180: Add qdsp baked soundcard
In-Reply-To: <ae070706-2f0a-4932-b917-b8cc9a59b46e@linaro.org>
References: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
 <ae070706-2f0a-4932-b917-b8cc9a59b46e@linaro.org>
Message-ID: <2b5dfc98e82fed3d2eef9eca3912c089@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 21.10.2023 21:17:
> On 10/20/23 17:33, Nikita Travkin wrote:
>> Some devices, such as Acer Aspire 1, can't use lpass dirrectly, but
>> instead must use adsp core to play sound. Since otherwise the hardware
>> is, usually, very similar across the devices on the same platform, it
>> makes sense to reuse the same boardfile.
>>
>> This series refactors the sc7180.c slightly and adds the functions to
>> control clocks via adsp instead of controlling the hardware directly.
>>
>> Existing google devices should experience no change.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
> s/baked/backed, unless it's a nice bread :)

At least I was consistent in failing to pick the correct word...

If we get to v2, I will try to remember about those, but if not,
I guess I will accept the chance, that in a couple of years I may
wake up in cold sweat upon realizing that this mistake is forever
immortalized in the Linux git history...

Thanks for noticing this!
Nikita

> 
> Konrad
