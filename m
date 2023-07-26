Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD7763463
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjGZK6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGZK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:58:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AECE42
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:58:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so3076813f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690369101; x=1690973901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69jj580P1DSe8cr6wdR9bzkleON+onBpdSJQbX0RqQQ=;
        b=abCtLTAHxzLZQx3yZP7Jwy4wSL5/u0dolDfq845g7zh8r+qohhm8WyQ+I08DytVAGW
         ov2RCtlAbso2q1msLc44f4Pn2L4C5m4OhY/FW+ucsvoB1+dYUb91WvHy+R+wdv67Hf99
         VBFCnBwPuVvzZ14c8i5mauC35jRBgiU7bRl3jo52k8wT5YXoSarMnQbycr5BopNVsxeQ
         BmDlAe2ugU2cpcJWzqTLcpMks9xh/dyZZ5aAUFuKqteDD7iRu7C0mZeBL17G+KpOTtgt
         2DEn4g5qMf3a6AKY7IRjhPtr9qEuNY3RHTNaW2qC8xRijyBvzM/cPoWyu0lT7cQ80ceb
         ntMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690369101; x=1690973901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69jj580P1DSe8cr6wdR9bzkleON+onBpdSJQbX0RqQQ=;
        b=chQvONZVB9cHIw0bwKMsYNByJ5AoPZ1TKSxdB0KPlFv9ad78JAiKeU1hV3J9hMsker
         jFUF4Oy79cy3mXAlpK0pdALj6oM0sJ0JFdtdUevtd4waa84oo/GNtmsVN7rTvdErRdTi
         /yNVNe1MdEZjxrrX8IINpKhKri4IGa1B0FRQ/OYjnsD1i4iLYg9U4q2WGfoZ+2SfatGi
         XDJGP/tudBddp2WgfU7unKrX4Oy20rxM/eli3j8Z9CHx8S+a2FOtvevDi1sOH1J7W84N
         T1yF9S40v6yLiBxJwWU5uN4bhJvcoJj4TLRKRN/kPcLGYcS2gqoa6QwdHKO4HsbzJGIW
         QxaQ==
X-Gm-Message-State: ABy/qLZdJNwtKKfJ30W+D0Sta1EYV354UfY6Idr+xKHtCpJzjx6FfQ1p
        AZcyH9V5lcorytWVHfUk+9rcag==
X-Google-Smtp-Source: APBJJlFuFExWjA3/qcQB/qgB2FxAoydz5gV11+BnboLGZNTKevsjTGJMa3597JykIshfwxKFQJTPDA==
X-Received: by 2002:a5d:4450:0:b0:317:70cb:4f58 with SMTP id x16-20020a5d4450000000b0031770cb4f58mr997310wrr.63.1690369101230;
        Wed, 26 Jul 2023 03:58:21 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r15-20020adff70f000000b003143ba62cf4sm19225643wrp.86.2023.07.26.03.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 03:58:20 -0700 (PDT)
Message-ID: <d939d08d-9e5a-b620-5d4f-cc805bcc76b7@linaro.org>
Date:   Wed, 26 Jul 2023 11:58:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/6] media: starfive: camss: Add basic driver
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-4-jack.zhu@starfivetech.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230619112838.19797-4-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 12:28, Jack Zhu wrote:
> Add basic platform driver for StarFive Camera Subsystem.

Another nit here.

"Add basic driver" isn't a great title. Recommend "Add core driver".

Basic implies a thing that will be added to or improved upon but, this 
code here is your "core" interface where you do your probing and 
resource parsing/allocation etc.

Use "core" not "basic" to describe this.

---
bod

