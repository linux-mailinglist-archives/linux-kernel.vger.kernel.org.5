Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051057EDF39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjKPLK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbjKPLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:10:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C857B5;
        Thu, 16 Nov 2023 03:10:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc9b626a96so5972545ad.2;
        Thu, 16 Nov 2023 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700133051; x=1700737851; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFz7+oVHI5NX8C0fnm8IRqMzIqbCT/WXK6LRYxJxeAE=;
        b=d4fqKnGMR/0L1eh2b2CTGUI87uOf3oqvheRu87djvvqi3pHCBeNnunqWgofXaTNcAp
         XpueMUJwA30kkBS7ZnUhcrnQc+yW3sLtBjdcKNybMIFyUddV1QZLVu3BBm5tmui6t2Um
         /fyqfGSe/72vP3TvoZWI6BRjshhM2JWu2KOJAORq2D8mlGl9o1AhS1dLY6MGlRCJHp6n
         NbxtolMFo98SPFt9/kMHKf+I0GM0eHIsSxPOW3PuaVxW8chNlwMAeA5Xdf/uC2ONo6mr
         t4R1mmLOr0YNV5yfCRLGxpFvKia5oUUbNJMil/hUbQXrZy8YAs5eDNKSh1mUKzchG+jq
         uAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133051; x=1700737851;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFz7+oVHI5NX8C0fnm8IRqMzIqbCT/WXK6LRYxJxeAE=;
        b=Y9ZBQSKIRpq/nR5bshtFUCfWueH3Na/QpP4+YiULdyBIWg2h1nO5ABOAaoqNFFxHFA
         UE92DYkjJH2YcNJKesCXzEgSSMdK9sEsuqZ340lBRq+qyal7O8npt/JUilipgCNHR+1B
         kn9BozAKKh2I227qiVaYcoynWcyCy4Yo4MK2c9F/es6AG7V4njfNiIBPNQJbQbL3bbLk
         CF0cgQ2l46zqR23558TmmusVIkQk8Xx04QZbqVkXnKEnLRKG0LbF0D42QR5AdUblOFxM
         XWa+FNHyYqCc8Xq9stWc/+ITDLMtiGN0NgDEOllhOMpZy7pZJ2vmH1ogp7rrnWM2IFLs
         Vckg==
X-Gm-Message-State: AOJu0YzRQkXN004IEQXM7M0dgcj1qBeZR4Ir5KshWwAvob17EHzZa6Np
        8iByWbqVu+UAoA8ICuEolAEN2BOOSE6P7Q==
X-Google-Smtp-Source: AGHT+IHdY0XUN3LIBMmFyQ/ijvMnft+nsGEUJv1hua8fnJIpPVmBnHfdyu9e06SELEggK2aJGRPBTA==
X-Received: by 2002:a17:902:70c7:b0:1cc:32b7:e5b9 with SMTP id l7-20020a17090270c700b001cc32b7e5b9mr7088429plt.67.1700133051430;
        Thu, 16 Nov 2023 03:10:51 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001cc3a6813f8sm9025422plb.154.2023.11.16.03.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:10:51 -0800 (PST)
Message-ID: <8bd0e77f-720b-4804-bbd8-477bd7df938e@gmail.com>
Date:   Thu, 16 Nov 2023 18:10:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Sound System <linux-sound@vger.kernel.org>,
        Linux ALSA Development <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ollisieber@gmail.com
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: acp3x: Missing product ID for Thinkpad T14s Gen2 AMD Ryzen 7 PRO
 5850U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hey,sound/soc/amd/renoir/rn-pci-acp3x.c has a hard-coded list of quirks. It seems like some product IDs may be missing. In my case, I am using a Lenovo Thinkpad t14s gen2 with an AMD Ryzen 7 PRO 5850U. 
> My audio output is fine but my internal microphone cannot be found.
> 
> Running `dmidecode` yields:
> 
> Handle 0x000F, DMI type 1, 27 bytes
> System Information
> 	Manufacturer: LENOVO
> 	Product Name: 20XGS1KT02
> 	Version: ThinkPad T14s Gen 2a
> 
> Could it be that one may have to add the product ID "20XGS1KT02" to the hard-coded list of quirks in rn-pci-acp3x.c?
> 
> 
> It seems as there have been similar problems in the past, e.g. https://bugzilla.kernel.org/show_bug.cgi?id=216270.

See Bugzilla for the full thread.

ollisieber, can you send the quirk patch?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218148

-- 
An old man doll... just what I always wanted! - Clara
