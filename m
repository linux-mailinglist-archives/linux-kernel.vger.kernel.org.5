Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0D75953B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGSMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjGSMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:36:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8831A6;
        Wed, 19 Jul 2023 05:36:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668709767b1so5068040b3a.2;
        Wed, 19 Jul 2023 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689770213; x=1692362213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2RDjShEnxx2CITlna+cx0sylIfu7E+lS3FgCJq6HD0=;
        b=UNoXC15EsWDFkjQoZnZY4lnoy8K5+rhFAfW6hitGkvfYJI9XJCRWsq6EwAki92xBNn
         /0oNaXsP/U6xsEiDgwbrog7fQTwE44ZDy1Qc9+PakqjY/e060iSu39wJv0eCaG4ofmxa
         dxSGPtq9ty38PsG/f/1ovUpZ9a/EYlNZVfmqWaHcEUU6R/Sxt3KBeq596HpVP7kkVpqw
         l2Cfxab1A/Pr9AoE/4S2a4F2NtjXf9FnD0Z6MSiQTEGBCYAxXP+KEvV+Tw0z6MkQ0nCI
         O4uni1skj8s9mlYU1eju2GrB5H9lvVdkGajzazCX6NyCiGiHP2qSPrkZbX96jDsR2UMJ
         BRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689770213; x=1692362213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2RDjShEnxx2CITlna+cx0sylIfu7E+lS3FgCJq6HD0=;
        b=cC4xnRWC1mun2ihPVnj2l+rkGciKMbnuBfS7wreboMJlpU0Xmu1d+z6sYXrh8rFijE
         jje+gfMVPvRj9VZFppfhXR3GUGLzPjXnZbMwKqxRzBjD1Wu6mXHXLWBbLtkQH9jvFVMJ
         ND8eR9AoMtyEW6hE8lsngTllT81YbXU+SovuPtW11nkCYBGlmXZIcBtf3m5qDrgdI9uz
         4KqYVegGRRkjCXE9FgGaPoNZo9e86myj9rn0fLEHd6k7RQ3IvfY19WgKN4OU6n37U+tq
         RmU33SBf/PMUFv20pA5kiGoX69+pcb8rjtpGzAbdBhZxthsMh1KMo9u3fWE/crMzozXl
         f+Ew==
X-Gm-Message-State: ABy/qLYbrcCjBs9qweCy57FrMGSDZwix7yFLvwIvBH5uz0Fp+uqr+ByD
        7/7APRpdU6lGG/EXAaFQfIg=
X-Google-Smtp-Source: APBJJlEDIe9vpBDJWHhVQgQNRN7veJEG2fM1DUO/yd5SkFEj75LXilVEy9YB9KT/RL+4rZvyMDFjgQ==
X-Received: by 2002:a05:6a21:6da6:b0:134:40f0:5d04 with SMTP id wl38-20020a056a216da600b0013440f05d04mr6036578pzb.13.1689770212730;
        Wed, 19 Jul 2023 05:36:52 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k6-20020aa790c6000000b006765cb3255asm3186759pfk.68.2023.07.19.05.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 05:36:52 -0700 (PDT)
Message-ID: <5983cf9d-dc1e-75bd-3624-770951661245@gmail.com>
Date:   Wed, 19 Jul 2023 19:36:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230713123710.5d7d81e4@canb.auug.org.au>
 <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
 <ZLYHtVuS7AElXcCb@debian.me>
 <f5e6258b-ba76-001b-4942-588f4cbb0aa7@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <f5e6258b-ba76-001b-4942-588f4cbb0aa7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 17:06, Thorsten Leemhuis wrote:
> I'm missing something here:
> 
> * What makes you think this is caused by bdb616479eff419? I didn't see
> anything in the thread that claims this, but I might be missing something
> * related: if I understand Randy right, this is only happening in -next;
> so why is bdb616479eff419 the culprit, which is also in mainline since
> End of June?
> 

Actually drivers/video/fbdev/ps3bf.c only had two non-merge commits during
previous cycle: 25ec15abb06194 and bdb616479eff419. The former was simply
adding .owner field in ps3fb_ops (hence trivial), so I inferred that the
culprit was likely the latter (due to it was being authored by Thomas).

Thanks for the question.

-- 
An old man doll... just what I always wanted! - Clara

