Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9147E0D21
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjKDCAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKDCAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:00:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CCDD52;
        Fri,  3 Nov 2023 19:00:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE6C433C7;
        Sat,  4 Nov 2023 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063228;
        bh=FKbs+2MdAbGKYRQisPKhmvfQIVpVesxEPJ/R8DtoaIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFtFpDZ0WPssxiW90AfZHYgq6gwAneqaWAUHT552Pm4CNhTHAn88uNFPGbV1Le+uF
         uLEinZGYT0fMid5+fQvg4LmJtNVxD/EGsXPXEuNhhCtH9c8yqlDyCCtifDFCuVk9Xp
         TS0PJe0IuWIUtL6n32RguwsKGyE/I586lSh3WHTVl/NdUB4JaQPGStPOrlyqQVHnnM
         XudOUL0SnfVmZai3ujpqClE//VBnN+NoHetKsNxgdGcexKS6Ztm5aWKJWSc/LWYLVs
         lWsBZSM9jtBXQoFeYC/CKjhuYwwluvHD5QJqZ38oeQ1YoJJAvzE3/f9QN5cU3u/Cp1
         S/ulAtwwqHTFA==
Date:   Fri, 3 Nov 2023 22:00:27 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.15 13/28] ASoC: codecs: wsa-macro: handle
 component name prefix
Message-ID: <ZUWlu5tOtjmO-GlF@sashalap>
References: <20231029225916.791798-1-sashal@kernel.org>
 <20231029225916.791798-13-sashal@kernel.org>
 <c42a83ff-fb7f-4020-b2c3-d8656433a0b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c42a83ff-fb7f-4020-b2c3-d8656433a0b1@linaro.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:32:52AM +0100, Krzysztof Kozlowski wrote:
>On 29/10/2023 23:58, Sasha Levin wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> [ Upstream commit c29e5263d32a6d0ec094d425ae7fef3fa8d4da1c ]
>>
>> When comparing widget names in wsa_macro_spk_boost_event(), consider
>> also the component's name prefix.  Otherwise the WSA codec won't have
>> proper mixer setup resulting in no sound playback through speakers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Link: https://lore.kernel.org/r/20231003155710.821315-3-krzysztof.kozlowski@linaro.org
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This requires previous patch in Mark's queue adding
>snd_soc_dapm_widget_name_cmp(). I did not get any email about it, so are
>you sure you picked up the dependency?

Nope, I'll just drop this patch.

-- 
Thanks,
Sasha
