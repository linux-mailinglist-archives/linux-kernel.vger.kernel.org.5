Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB217D6C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjJYMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJYMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:45:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C65CC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:45:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso83016791fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698237934; x=1698842734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hwbHxNJHKIYfg2V9fOMg3eCs72qgcfQnjq8FaDx1jw=;
        b=K7esk2lQBlWmBMhBDLYiBSS2MczKLeLq+HDpYsabyFfEwFcgzRSXzstS1nbH3dq+ZQ
         vZimVR7IWlHmKCxwLaRIYJhzoQgzqLTJndJ9Gbhm2h+DuhGANXueQhwEVS46m0rmDfvz
         Mkf43m3q8HQHi2vIunxat5DJcQGPLvZ7K0AFBy6brTdL6nPr8mjxi8ZnOcmMV1FzcHQp
         dMewcZ+vLDdmRADNhNxvG5kpD4L5PnEnZlGyL10ckoZjzZQIUtGyPMtYncHjZRRYULPt
         XzHnj9gILBbCRprmhZiypYAQJETL+gj1Y8l99xnOlnl8ke2ibxJ5E1uBDk95Y7tSIj/P
         CN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237934; x=1698842734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hwbHxNJHKIYfg2V9fOMg3eCs72qgcfQnjq8FaDx1jw=;
        b=ruz7OjwZdSY09LByGp1RIJUIOnDLllae/8CKpinSBmYa3oaxc7Br0+i556HtjpGzR/
         3OwB/WyApFNJthe0TovH8bHCEGpG66gv/WJNDQZ0RlCoF/2cFZBx02Pb8O0jVgqEVr60
         vpXsrMYusPo4VWi4su1Ef5nHzapqdi/GKm+akk33vNVSjDygrKkCStxla1JWz7dcMfnJ
         ReDLn8y5D/UPpuimjQ79vmkmUchv4sXl9Qfw0+Ny1QF38jnUzc7iKNXPBNVHzG6xkXgu
         L7WFAe40SevXb7soIXPdvqSvjnK9/UKoli38GJKmw3/t1CQCXzC0cIFEvqB30G9QdE/t
         RPVw==
X-Gm-Message-State: AOJu0Yxjt7Gjk0biGhQjq0xXaopNzb+G9n84NSEXd5OG9P4/orcfg+FO
        cOFBZZcXL2gXGIn7l/v7FlHMpA==
X-Google-Smtp-Source: AGHT+IGm4J06QL06svQANFyfaj+/EUWPdef+xMSV/kjvuIObpEBzlgVccGrT3eMK/MQ05YabvI6mnA==
X-Received: by 2002:a2e:9c44:0:b0:2c5:12c4:5ff with SMTP id t4-20020a2e9c44000000b002c512c405ffmr10140098ljj.17.1698237934113;
        Wed, 25 Oct 2023 05:45:34 -0700 (PDT)
Received: from [192.168.53.189] ([188.162.65.61])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e8e6d000000b002c4faf47378sm2419884ljk.28.2023.10.25.05.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:45:33 -0700 (PDT)
Message-ID: <65f841ba-5b70-4cbe-98e0-3d53e5b7944c@linaro.org>
Date:   Wed, 25 Oct 2023 15:45:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix connector type to be
 DisplayPort
Content-Language: en-GB
To:     Simon Ser <contact@emersion.fr>, Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231010225229.77027-1-dmitry.baryshkov@linaro.org>
 <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
 <NDl6Ye92jJDp3fm20AwcuUKWuP8tzQ9CyWGGRltZ_DxYgxep2DO8Wil0Nmsfmhp1j4vAp9Yu1duiHeQkjBG-bcAdFoW3ZbWxvVqrCEpQe_4=@emersion.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <NDl6Ye92jJDp3fm20AwcuUKWuP8tzQ9CyWGGRltZ_DxYgxep2DO8Wil0Nmsfmhp1j4vAp9Yu1duiHeQkjBG-bcAdFoW3ZbWxvVqrCEpQe_4=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 15:29, Simon Ser wrote:
> On Wednesday, October 25th, 2023 at 14:22, Johan Hovold <johan@kernel.org> wrote:
> 
>> I was just going to post a patch fixing this after finally investigating
>> why the DisplayPort outputs on the X13s were annoyingly identified as
>> "Unknown20-1" and "Unknown20-2" instead of the expected "DP-1" and
>> "DP-2".
> 
> Note, ideally userspace should use drmModeGetConnectorTypeName() from
> libdrm to figure out the proper name for a connector type. That way we
> only need to update a single spot when adding a new connector type,
> instead of patching a whole bunch of programs.

X11 does its own thing. It further "renames" DP MST connectors. So on my 
laptop I end up with DP-1-1 in xrandr, but DP-3 in kernel.

-- 
With best wishes
Dmitry

