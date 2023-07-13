Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4C751D94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjGMJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjGMJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:42:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7730D0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:41:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so274503f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689241262; x=1691833262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04nTS9GASlP/qX97jZg5PHm4hlTLa4+xP2ZUsEmQz90=;
        b=eSb7APXlqCioZXC+JB23Ihu6CbEpIT0pn2kG5nk0bCRMkELnR+/lPcnIvyJwwo9t14
         7mELT57tvSy08SOU9TSsmYCRUkjfsBJPhLk8HKpWRkLFNwguA9UJ+JofWplbLFX6T7TL
         LO2r2g8cB5aNkO80hiIEtxze9ZI3Z0c5TFO9x39FPRqbaHmmLFfhqwlOPs5VRdbsBkkC
         Bth53D9ptLJhzUOoen5BnGdaENuw/KNw3snhuIIn+fHATwBcwaalZ2N+m05ywY2FWumI
         azVYjmWzGFMDzszLOsWchH/V5ptwO4a3gmkjrz4mfQgs+3iyLnEX5OGGh7Mtc3Xe3Nek
         nomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241262; x=1691833262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04nTS9GASlP/qX97jZg5PHm4hlTLa4+xP2ZUsEmQz90=;
        b=JPKe9ll7d0iVga9ExDRfWH3wSG9EfmNbAlNxSwqjtryYy4gx4WWjdiwGAdJrXcAIJv
         bHX+5wJfhKb6xuTSs7eAf9jiGDEbjI9PSJl4tuY6sF0P7GKWa6877DwfcHJKRLTJfnF5
         u7SZywgPxGGfCxeq6xJpcnv5rqcY2gO2zj8v2dxaKcnp8YTcSK7Kf6ajkzoezaXRWj4O
         Cokk48DjZZPV+2kFyWjCkJOCVPTikLf7pCR4sA2VuO/sSo6dklna18lJion1V5MB04q+
         54oe5Tiep6O2dEj/XgCCQjvoZlI7ozbmMVUEthCMjNU58QO4U6kea2AwMalhcAs5jMwD
         hG6A==
X-Gm-Message-State: ABy/qLZMxeNUazQ/F1Lx5siRPYa3HL3m2lEntab+N0uLZjuKLwaRtgdV
        9oSNH+VjVXId90CE2HQW3VxeWQ==
X-Google-Smtp-Source: APBJJlHoDRm4B6MgfAyPwK1+7gGtdhJoH2pKzbPaqR7/Lyu/IbR86f4kF8AqF+MOmjWppc/hzg8CXA==
X-Received: by 2002:adf:db02:0:b0:313:f977:479f with SMTP id s2-20020adfdb02000000b00313f977479fmr1207290wri.20.1689241261954;
        Thu, 13 Jul 2023 02:41:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x6-20020a5d6506000000b003143b14848dsm7411472wru.102.2023.07.13.02.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:41:01 -0700 (PDT)
Message-ID: <e8777141-882c-d5a0-b93b-2dbeb6ea93f7@linaro.org>
Date:   Thu, 13 Jul 2023 11:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] wifi: iwlwifi: mvm: enable thermal zone only when
 firmware is loaded
Content-Language: en-US
To:     Harry Austen <hpausten@protonmail.com>,
        linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230710104626.8399-1-hpausten@protonmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230710104626.8399-1-hpausten@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 12:47, Harry Austen wrote:
> In iwl_mvm_thermal_zone_register(), when registering a thermal zone, the
> thermal subsystem will evaluate its temperature.
> But iwl_mvm_tzone_get_temp() fails at this time because
> iwl_mvm_firmware_running() returns false.
> And that's why many users report that they see
> "thermal thermal_zoneX: failed to read out thermal zone (-61)"
> message during wifi driver probing.
> 
> This patch attempts to fix this by delaying enabling of the thermal zone
> until after the firmware has been loaded/initialized. It also gets
> disabled when going into suspend.

Thanks for taking care of this bug.

The thermal zone will be accessible from userspace and can be enabled 
manually. The resulting temperature read error will be the same in this 
case.

IMO, it is cleaner to actually [un]register the thermal zone when the 
firmware is [un]loaded

> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c  | 18 ++++++++++++++++++
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c    |  9 +--------
>   2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index ce7905faa08f..a47d29a64dd4 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -1187,6 +1187,17 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
> 
>   	mutex_unlock(&mvm->mutex);
> 
> +#ifdef CONFIG_THERMAL
> +	/* Needs to be done outside of mutex guarded section to prevent deadlock, since enabling
> +	 * the thermal zone calls the .get_temp() callback, which attempts to acquire the mutex.
> +	 */
> +	if (!ret) {
> +		ret = thermal_zone_device_enable(mvm->tz_device.tzone);
> +		if (ret)
> +			IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone (err = %d)\n", ret);
> +	}
> +#endif
> +
>   	iwl_mvm_mei_set_sw_rfkill_state(mvm);
> 
>   	return ret;
> @@ -1282,6 +1293,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
>   void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
>   {
>   	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
> +	int ret;
> 
>   	flush_work(&mvm->async_handlers_wk);
>   	flush_work(&mvm->add_stream_wk);
> @@ -1307,6 +1319,12 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
> 
>   	iwl_mvm_mei_set_sw_rfkill_state(mvm);
> 
> +#ifdef CONFIG_THERMAL
> +	ret = thermal_zone_device_disable(mvm->tz_device.tzone);
> +	if (ret)
> +		IWL_DEBUG_TEMP(mvm, "Failed to disable thermal zone (err = %d)\n", ret);
> +#endif
> +
>   	mutex_lock(&mvm->mutex);
>   	__iwl_mvm_mac_stop(mvm);
>   	mutex_unlock(&mvm->mutex);
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 157e96fa23c1..964d2d011c6b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -680,7 +680,7 @@ static  struct thermal_zone_device_ops tzone_ops = {
> 
>   static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
>   {
> -	int i, ret;
> +	int i;
>   	char name[16];
>   	static atomic_t counter = ATOMIC_INIT(0);
> 
> @@ -707,13 +707,6 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
>   		return;
>   	}
> 
> -	ret = thermal_zone_device_enable(mvm->tz_device.tzone);
> -	if (ret) {
> -		IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone\n");
> -		thermal_zone_device_unregister(mvm->tz_device.tzone);
> -		return;
> -	}
> -
>   	/* 0 is a valid temperature,
>   	 * so initialize the array with S16_MIN which invalid temperature
>   	 */
> --
> 2.41.0
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

