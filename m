Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D02B79E8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbjIMNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjIMNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:10:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7F19B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:10:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4018af1038cso73861405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694610622; x=1695215422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhylJXVHu1y/JGAQAiQbLZVjvUVFnXfhI4SjrH0o0KY=;
        b=bOPVLz2/iYEgxXqilRq5ckSvGAs2EuwzWzcYdolBx5i1zK6WPtbc7yptYilZOg3URf
         13RrwClMyHvliMUFHLBbx3aAR8hr4EU/n3NguP6jjyIkVqmszfpscO4Ah9QGSSIvIzS1
         f7K7FV7t+ugYooV9pGkNxesgX4a93Ko+SuvObEdHGNqWELFRZ0yuSYehmunui/g5hH0i
         YaFPu8l/2wXCyEmBXweYAUIuuTIzWjsFk2Ujt/KvS3FR0NVCOqCIMcPOG8B5NcdEXZKx
         iTAuGrxMFoJMB8v1EvGW8mKsngUmP34rZcWjhM6qSOv4jnFt6WrUu8xwAidrDq0MQl57
         +BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694610622; x=1695215422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhylJXVHu1y/JGAQAiQbLZVjvUVFnXfhI4SjrH0o0KY=;
        b=eJ/7kPXsjpy2RV6B5HKwcnVN8AUUHOolFz1BfyM0RsskpoqVYRVu/184IbwsS7a2eM
         DUhkk9j0P1wHyhL3iJLXsoTY6Sem2uPMnzOVFTRKR+a7HcdFwK8gjY++Dp+UdMzFTH1N
         KJrt+yzlEWTiODXtDNlALxi57YezQcjoIaBAH+NgC1LFYkLgNyy2m7+jMlJnBnEMayLL
         60j5X05YUnohI3c0zv0d1xuLSJ/hL0uc3kR7Qv2XuTIibiahCoVsjS5y8yAuOp6SofaK
         zDc07gSXhHFWxP4D5UurwzaWeJbSvAA7G6Una3BbWrtq7jAIYa7WJTgHdgJ080BqgB6F
         h76A==
X-Gm-Message-State: AOJu0Ywa0CbiPd7cJ2kViNCpQanif9W+z+Pq+gb3guw6gSfVP/K8XFI2
        txqxw6/XSGsSFV1HrPAuT7135A==
X-Google-Smtp-Source: AGHT+IHiJzJhe1Xrs12iA0t2UFcejF5aY0fuGShabimjAwKWm+vmmwmawqlnxHfAfdo7W9D+0o04pg==
X-Received: by 2002:a1c:4c1a:0:b0:400:57d1:4915 with SMTP id z26-20020a1c4c1a000000b0040057d14915mr2173211wmf.37.1694610622229;
        Wed, 13 Sep 2023 06:10:22 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003fee6e170f9sm1972778wmf.45.2023.09.13.06.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 06:10:21 -0700 (PDT)
Message-ID: <9486b1f0-9c5f-4c2e-9032-18efc4a63b24@linaro.org>
Date:   Wed, 13 Sep 2023 14:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] dt-bindings: mtd: add basic bindings for UBI
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1691717480.git.daniel@makrotopia.org>
 <a640bb10e6fbaeef96efdb9e8b666ca39e993589.1691717480.git.daniel@makrotopia.org>
 <169263908218.2000617.16931192155432403196.robh@kernel.org>
 <ZP9kJYHMFwZ8GFnA@makrotopia.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZP9kJYHMFwZ8GFnA@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 9/11/23 20:01, Daniel Golle wrote:
> Is there anything I can do from my end to have this series moving forward?

You could review other UBI submissions to reduce the review load on
Richard. I guess the queue of UBI pending patches is at:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=&submitter=&state=&q=ubi&archive=&delegate=

Cheers,
ta
