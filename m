Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C87806ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377268AbjLFJgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377344AbjLFJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:35:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171ED9C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:36:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so32177845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701855359; x=1702460159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V085j9b1+XGSVNMOHyQlbtD0/ESoGyPOPlyN1ExIKto=;
        b=WlX0byvmYb01vGpV+6wNwO233nwn5CkRViNi6GhDt8qdOialTe+ink6sAPDXZXy68w
         pwCx026IuldVzFO+on4Sxpo0M7NBxQ1afQLoPQrFRioha/tttkXC6MzF+ewi3vk6W8f9
         HwAyZAYTVjsDoxrY4RcJcaPKyaNZP6fmlSbSu3hUv+mT3SkYIfo1mFSQFFGU+0A9LdFL
         /jvJjiNWaUQadpt5hVdB+fTpPlDqLc0SLETK/pXTA8jonGl6EwmyTXyMgIaksAQ9b9+r
         MJfqJBMZHALxYqv1B6ISrWbe69vlwtl8XYp1QTFQV6PIbZ0YkKvoWAXOFGrFzkQdp96u
         aPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855359; x=1702460159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V085j9b1+XGSVNMOHyQlbtD0/ESoGyPOPlyN1ExIKto=;
        b=J24VddhMVZJZTBMdw0RDcCAzrkoo9gnlNbkV+tEcPplFHIm8Bw2I47k+kBtp5TggCo
         75D18fRayap29OG/ZAXKYQ2W8lV2TKL8IJksxH0/F4YBfmP+c5idS9FlWszlvBRfu1nV
         Xa4vSYNmtBvPptvCgZA5cewv36vbhbqT2kIfCOSmYAfa3IHCOVNJAnhBtxC3Zk4Liypm
         uJXtLNDpFQxj+eiDtb+20xK6RqwHIaLWDYyxK7sOps+cXnD9vd6vzn+g3Di3nSXcvRxN
         ZRPzkzk+fE5MmDNmuHyPOBrbeeVSbBcHDtYIlpCu+wND/Gtgz7HLpp6fSFyp66Ehh4Bd
         U6Qw==
X-Gm-Message-State: AOJu0Yxeb0eW+lQt7yBz+dOdGbms6GfHcw2dtvz1FHXDO/5BjwtLiJeq
        99AlAbaHeVP3MzeIFjtclq0fag==
X-Google-Smtp-Source: AGHT+IGsQVqjgraYuEaAzvkja+x5HQZdl5VNixjgL2N4QDKNZjYPEClOfVdf+H10b2QMCazqQTunJw==
X-Received: by 2002:a7b:cb95:0:b0:40c:1855:1c27 with SMTP id m21-20020a7bcb95000000b0040c18551c27mr384050wmi.103.1701855359427;
        Wed, 06 Dec 2023 01:35:59 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm20095541wms.34.2023.12.06.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 01:35:59 -0800 (PST)
Message-ID: <581d7e03-7415-49f7-b348-f4f6dc1c336b@linaro.org>
Date:   Wed, 6 Dec 2023 10:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: cadence-ttc: fix some kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Michal Simek <michal.simek@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20231205230448.772-1-rdunlap@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231205230448.772-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 00:04, Randy Dunlap wrote:
> Fix some function kernel-doc warnings to placate scripts/kernel-doc.
> 
> timer-cadence-ttc.c:79: warning: Function parameter or member 'clk_rate_change_nb' not described in 'ttc_timer'
> timer-cadence-ttc.c:158: warning: Function parameter or member 'cs' not described in '__ttc_clocksource_read'
> timer-cadence-ttc.c:194: warning: expecting prototype for ttc_set_{shutdown|oneshot|periodic}(). Prototype was for ttc_shutdown() instead
> timer-cadence-ttc.c:196: warning: No description found for return value of 'ttc_shutdown'
> timer-cadence-ttc.c:212: warning: No description found for return value of 'ttc_set_periodic'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

