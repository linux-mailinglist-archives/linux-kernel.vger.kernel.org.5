Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEA804CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjLEIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjLEIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:46:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255631A1;
        Tue,  5 Dec 2023 00:46:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so31934311fa.1;
        Tue, 05 Dec 2023 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765970; x=1702370770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaWG7/CZxl2KHzhnk5GgUba5m7ip8EXxndbqPEU7QEQ=;
        b=fiGI05FzczUqHbDZeYmZb4MYlDvkJRBIxeXTZJdVxblhYlC/m85HTEXUM4rXjHxYhK
         o/pi+glUTdJpJJNJ7oLj8F7cnunbwNcfGddpOVN7/GHf+nUmnF4Uwv0lOrTsTVs0d+/U
         0W32k9xl6qNFHYBN0U+VkTbkifrTa5DTRMCEEhRaW0yw0Yjfw56OvY+03owF0n/p5jNo
         9H6M0XJjlNc5dgoznG8ceuAxiCq4ewWiXTGfPN6FvDwhEBwwk3qk8+v/aG669CfdtQJ+
         ajoi3MXpybQ8A5eG0KcSPhHMl2mH9WpNdb6bLywncsPKwNasc4GfalbF97eWVKTfkHQb
         cJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765970; x=1702370770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaWG7/CZxl2KHzhnk5GgUba5m7ip8EXxndbqPEU7QEQ=;
        b=Kf2I5bVtOmjd7zlcwJeveQeWRdLwTq3X6Og+47tvR7piOk5uQHWWhaO2QG+2jhN3D5
         Cgm04pi8voBxLz+/vFE2z1wCytMCbg6Ph+fWd2Yg5hPZ/3KS1gnvfjJH/fNsvE7dPWrS
         kbrjSrV2KG3/S4EAU/qyUumvoUtnqRY3g/dsurMo+h4UuphPVzAO8f2vlf0AQL8FMb7b
         pPZe/t6ROVi5uXA8iRkxqJylLyDq1/1ubeVYLorU2IpY6bGGX7MF9lN5rEsY7frYo9W4
         eIzlGH1iirAvh3UcTACo+wkK20sqBHpbE5m/C6CAnywtiZTfQvgRz3sxcZbfaiD8gVwd
         Dd5Q==
X-Gm-Message-State: AOJu0YyHLGpYWzjoWbgfL64uc8hoqwmZh+BiwEL4QteCkOqhKG51no2c
        8GNsCrZfLDfx5yJv7OfNg0k=
X-Google-Smtp-Source: AGHT+IH4DRTf/fstZk9qVunSZr8jAtoTOJrZKjTTpPvE1K07EjLle/jHTKAuQtLmzBBQuYaoiVjbwg==
X-Received: by 2002:a2e:8841:0:b0:2c9:caf6:cc87 with SMTP id z1-20020a2e8841000000b002c9caf6cc87mr2773105ljj.21.1701765970248;
        Tue, 05 Dec 2023 00:46:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id d8-20020a2e3608000000b002c9fe11efe4sm725751lja.28.2023.12.05.00.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:46:09 -0800 (PST)
Message-ID: <9c09ecf8-a16f-4e5b-beed-46a881741ae3@gmail.com>
Date:   Tue, 5 Dec 2023 10:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] overflow: Replace fake root_device with kunit_device
Content-Language: en-US, en-GB
To:     davidgow@google.com, Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-3-635036d3bc13@google.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231205-kunit_bus-v1-3-635036d3bc13@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/5/23 09:31, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

