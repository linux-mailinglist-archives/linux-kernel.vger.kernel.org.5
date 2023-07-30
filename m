Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D781D768391
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 05:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjG3DEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3DEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 23:04:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EEE1984
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 20:04:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2681223aaacso2097442a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690686284; x=1691291084;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNcYqtQlXpQKPqeWxLmdg5dB7w855CQ3qgqSePzZ6Tg=;
        b=V80Q/pOE5gi31O/Ld769fJM8GVmaqF7lBAFN8Aal93hLdUFkmtWzREJmQuqyANl1J0
         B+ZCnnTsWtu2q8OLTaNRS7fF8gYn6oOO8/fYQ5GTyH+k5nUKayJCj6sVLHomDE4dTrst
         AJv7tJokbaBnzaasAzokAPT8BekdY6YOwKrtri1I9vFgKWyLtcfeS1YTjacsTDoHbdZI
         E8ox6wHB3q9dlnmC/MvvsFO0D8KQG0nAVG/OKgpQaIrap0CTn34J+nY3gTkCE8vnNIGg
         HclzpcPbqkpSJGH8g44BjcTf576rEHl2rpjMnfOM5gSSB1GW7UaIPNprCgfnNamyhAIC
         AO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690686284; x=1691291084;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNcYqtQlXpQKPqeWxLmdg5dB7w855CQ3qgqSePzZ6Tg=;
        b=PvrGLrhfcEH930cKxtK3ESgwo7C0cK5ruO4PM3VGZZXs2eIugpTI7s6q8lGAawBe+D
         f3jllsvUPuObd+0KuOzDXwc+R5Vgo7S72ZPrUx+PgO1zE7sPsDG68KK4W4VY7n/mx04O
         4d5eA73OjzdskAYfulaCiN7Jxe3OHNhKYjaO1rSuaixuSHh5BexDXYLjhpw4LbRAquC6
         jEzbs5g896KdOZTVbDbxLzMLFTEYmQsLfz8vTTfSg4iOCEryta6eKHimoeixAoi+I+/t
         HkfCZBZh3b2lEM5EJi8fl7pv6qTpopJ6QE1xoVAY2+c9KOoHagfyxQA+zVn7KFY0uU/9
         pI+A==
X-Gm-Message-State: ABy/qLY9PsHvD+4IIiBn+tFFG1vQ6YkMRd3tbAq63MLu98vr99Lxb2S8
        nRAxKt7E/v8s0LrNyQKTk2oa2oJ0Zqv1Og==
X-Google-Smtp-Source: APBJJlEpO6/wwlipyMenNK9nps6iI6rK9vIpM7B0kVPpxXFeMalJXL1819lt+kwARIorHBfFhk7fuw==
X-Received: by 2002:a17:90b:3e83:b0:268:4716:d0cc with SMTP id rj3-20020a17090b3e8300b002684716d0ccmr7274474pjb.22.1690686283632;
        Sat, 29 Jul 2023 20:04:43 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jd6-20020a170903260600b001b7feed285csm5899909plb.36.2023.07.29.20.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 20:04:42 -0700 (PDT)
Message-ID: <9759f20c-cb24-dde4-cca6-f893033b7802@gmail.com>
Date:   Sun, 30 Jul 2023 10:04:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Conan <formyneeds2@tutanota.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA Development <alsa-devel@alsa-project.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Lenovo Thinkpad T490 Microphone Noise
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> I have reported this issue to the Arch but they redirected me to here.
> https://bugs.archlinux.org/task/79245
> 
> 
> Description:
> When I use microphone for online meetings, my sound reaches them with a high noise that prevent it from being understood. I tested the microphone on my own and yes the noise is there. I tried pulseaudio and pipewire, but neither has solved the problem. This problem is not stemming from hardware since I do not have this issue with Windows 10.
> 
> Additional info:
> * pulseaudio: 16.1-6, piprewire: 1:0.3.75-2, kernel: 6.4.6-arch1-1
> 
> Steps to reproduce:
> 1 - Open a chat app/website or online meeting tool like, Whatsapp, Signal, Zoom, etc.
> 2 - Speak to the microphone. You can use Whatsapp and Signal to listen your microphone sound.

See Bugzilla for the full thread.

The reporter chose the incorrect component when this bug was being filed
on Bugzilla (only generic `Kernel`), hence missing sound maintainers
and I had to forward it to the mailing list instead.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217730

-- 
An old man doll... just what I always wanted! - Clara
