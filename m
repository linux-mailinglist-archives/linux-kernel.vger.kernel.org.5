Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D77C723E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbjJLQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbjJLQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:16:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7FA9;
        Thu, 12 Oct 2023 09:16:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405d70d19bcso2440235e9.0;
        Thu, 12 Oct 2023 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127369; x=1697732169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ozq89ZVImu+VFbUodXs67/WQLM2XUzrt4ew1bbqvvc=;
        b=QUstCcNvNcQx4JmN5VCCkqSK2ZcA19l1pqgqt4OnIOSKYoryLdzr2iQcLOOw9HHp0r
         2oNSx+1W6x8UBRoAlVnzwTrvMiZbX+1B++W0zB6x3t/Hdz5Wkl4eKBwvWj+P9cNhG1T6
         haJhO5q4QXbObcReedSVODptKBSvOlgAFOsjwvHjJk5GL4T/K7v/rKUZubNrKlvaqsFN
         iIE21XxUSd/75kYAvYoaHfqF9n+Um8uCFqziWBUSxv9RoNFilA/k5kQcOej9FVGD2Lqh
         LvUKv2J+oEzYvatWxdrwuOGL+yzf9pg6JkcHWK8xNYF4Y6tkiBLDAS67Lt+OfYkEY/EB
         tGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127369; x=1697732169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ozq89ZVImu+VFbUodXs67/WQLM2XUzrt4ew1bbqvvc=;
        b=jeQN1SIAQfC1lYOrYgwjcYGzBhxloYmqRc425cLtZR4R+Oyz7LNzwSxnD2Ta8CoLog
         9jl2c9uEOARwy2CGfiC7dsv/r7EA9QPa4mLvLTAmU4PbVJZ8dNL6j9+TjlpA6SIgapNE
         muR69A7835p00TiGxR1RK1Dns7ph19MyyNnUdNWUpATsvxG9YgCZv6BODGAjvbAcua9Z
         PzDegInEADop/HAXyGCU/3K13sh6nfGKRymqsLc7uORRE9H9c5H8u8yNxfhHJNbULA4P
         JxEfMPKuFED85VLuF+5F/48PYyXQ0ulWLpxHDKRAch8O8F1hd4pswzHhT6oHeC0UOQl7
         iR8Q==
X-Gm-Message-State: AOJu0YwJ4MfDqMtjtm/nphDxKl5pr2y4wRymp2QpSg+85aYT8mhzcNIS
        YGRnIanjRfOF43AcS12fUIk=
X-Google-Smtp-Source: AGHT+IFc0tMzaENSKcJzOmy69mZYDNpmzbDNLoSVYManGTw2vTqI4L7A6X6S4uZ6PY+sQnDzhERXIw==
X-Received: by 2002:a05:600c:5192:b0:405:1ba2:4fcf with SMTP id fa18-20020a05600c519200b004051ba24fcfmr21565540wmb.4.1697127368564;
        Thu, 12 Oct 2023 09:16:08 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c235300b004065d67c3c9sm233127wmq.8.2023.10.12.09.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:16:07 -0700 (PDT)
Message-ID: <bd45c5d9-ed42-41e1-bb6e-6662ed0937f2@gmail.com>
Date:   Thu, 12 Oct 2023 18:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
To:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
 <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
 <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
 <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 16:36, Arnd Bergmann wrote:
> I'll also send Greg a patch to remove rtl8192u now that we know that 
> this has been broken for 7 years.

Hi Arnd,

please allow me to do this.
I had a separate mail with Greg this morning...
https://lore.kernel.org/linux-staging/2023101244-unaudited-sadly-d9d6@gregkh/T/#t

Waiting for your confirmation who is sending the patch for removal.

Thanks

Bye Philipp
