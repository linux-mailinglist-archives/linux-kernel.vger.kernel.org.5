Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38183754EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGPM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGPM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 08:58:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BAE18B;
        Sun, 16 Jul 2023 05:58:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991ef0b464cso1012515866b.0;
        Sun, 16 Jul 2023 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689512301; x=1692104301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrmohUiY7T4ILlEFhYMLVCoadgvGMU03E4HWw0oS++I=;
        b=kVQtozN7OBRc+vBd99v0afvonKNTamS9n4hJ4Qw4AEFTmuri7hfC2FPDCc4q5AGjFL
         D3mw3TXdCD3DXONlN7sSj7b0F9cE02Qzg0+EYbUuSroyh1pkeAiW09EO+NILGsNCW1N6
         L9x3UNy3b+FZs4vH2uk2utPGPQUL9nwXGlClCqRnkVJS1ABvs6BvwGMGgD6w5yAcVFeL
         0XUZcjSAk23lqIsj5KicbzbKwo4EMVz7OVlHt4U+lKjQ/3H8G7blTu7m3GaFujc6UcID
         aLTCFIsLKmQED2KWiWv1UubQBzQIt+obyTLTCDlVquul5xliQKg5O58VOuSfGCxEkuFO
         LTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689512301; x=1692104301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrmohUiY7T4ILlEFhYMLVCoadgvGMU03E4HWw0oS++I=;
        b=PsZtJxwBzDjihtsgJbxn1yJQDobgPVRXFv44cA2jPb6BzCynWjEk8mt4hv6oGQinLA
         tfNRQyqVvHx29YLjT4rohAVv+4gfc032LIwcsdTsAugmgJi7mMn5NS55NXXJuSOId2vi
         Lf1awJsfN1EldYJC/ttpAK1eJBkHLoYlonjLHzSwo42gMYltFzSGKRx3o3OXf6avwLFp
         JioXWzGVtgOUUefKT1sTKlYBX8jadPKBeUFumKolD6oFHZA+qudurQip3msCmvzlDEXs
         YwDK8gC103VWO5YBMM6YPOtVFPbEeskMP8gYTfnOGrmWRKk4t8qY6iG+RI1nWuuxLF4b
         MGjg==
X-Gm-Message-State: ABy/qLYmYCOts09QoLU9jx26zcHgZHO8wWhuCSIGZNZ/coHOPtzlorMX
        4/QsFXaFPGKFba7WGnMJArk=
X-Google-Smtp-Source: APBJJlFcLIe6Xa5YLwDX4668/Qsd27Zgo0thPLy/1Ku0J/49K22y8mZxJAGq6d/10sf4rNi4MzDupg==
X-Received: by 2002:a17:906:64cf:b0:994:13c3:2f89 with SMTP id p15-20020a17090664cf00b0099413c32f89mr9067057ejn.27.1689512300717;
        Sun, 16 Jul 2023 05:58:20 -0700 (PDT)
Received: from shift (p200300d5ff4df000aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff4d:f000:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906131600b009927a49ba94sm7871815ejb.169.2023.07.16.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 05:58:20 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qL1KN-0031TK-2R;
        Sun, 16 Jul 2023 14:58:19 +0200
Message-ID: <3e99caed-13bb-204c-4458-e0670fa9e8c9@gmail.com>
Date:   Sun, 16 Jul 2023 14:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
References: <20230306211237.14876-1-asmaa@nvidia.com>
 <CACRpkdZoVo-6BMYcuike2eC85ZGpP93_4WQVLTfjRAa1ho5xhg@mail.gmail.com>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <CACRpkdZoVo-6BMYcuike2eC85ZGpP93_4WQVLTfjRAa1ho5xhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 09:42, Linus Walleij wrote:
> On Mon, Mar 6, 2023 at 10:12 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
> 
>> bgpio_init() uses "sz" argument to populate ngpio, which is not
>> accurate. Instead, read the "ngpios" property from the DT and if it
>> doesn't exist, use the "sz" argument. With this change, drivers no
>> longer need to overwrite the ngpio variable after calling bgpio_init().
>>
>> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

For context:
<https://patchwork.kernel.org/project/linux-arm-kernel/patch/535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com/>

Regards,
Christian
