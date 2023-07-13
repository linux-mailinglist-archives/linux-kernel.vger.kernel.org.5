Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099A775170D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGMD7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjGMD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:59:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E91FDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:59:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3142970df44so344772f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689220740; x=1691812740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFW6tqBAxT55agMZmiEFwB6JiIx6o3r1moqtycR28gM=;
        b=sqtOqbOMGsZ/+23+X1nR4wUn1C5ui47aYlSieK8DaCIn+hlDjdMeaBAqBM4QDNfzoi
         tg1PMzZngUeBC+4n+X+v5AyvdmDaNSnJwinpHlNrvDswC4sozGqbQ7RQcduezQtZBzE6
         ywtjjYpvZaUu5ORn4puAux/ti1zDOL5fj1EaIASkYUR/9avpCDgfksSpl2HublbEHswC
         FjjHLCoPqW5DsvrskCZWOrlno+QzY0rf9U23lnR8RvdWZptAN35sFveFdTPyq2BFbh3a
         dSC4MC7kS+kYmtNItkyPbfRK4B3KXlgyhekapXpn2fGVv/e+maVl0Ai6w4fTkbVImeh/
         izqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689220740; x=1691812740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFW6tqBAxT55agMZmiEFwB6JiIx6o3r1moqtycR28gM=;
        b=GQGMGwMS2mGule4g+GnEzk9RQ+l3ch+v6OWHTD01tHfj3ymZZqm1MTpqIWWz6UfwqD
         BqUG2ApAf4nTyiT0aXapUvcn6WYfqNF5nbQj7BsRTOV5qEopF27LJjvSHw6C7IbJEYza
         MgFQE6c4XWe2EF1nzbhoNhMayxiOd96vVuBcd7IcNWXws/HcywAFf+TlZdTLfS63wmrO
         4uYZe2iYa30WFINh57Ge4eH0Ac11s4qxVx2O3SAcm+WbYAuILAGqOJDHl2tYVpH4p0r9
         pU2O3hBkcj/NqG1ml3KxEQBppUsCcSp5krqnig2DNXZ64yh9GV7v8A1gfFT64uXlsv1b
         aWlw==
X-Gm-Message-State: ABy/qLaB5vlkZZJhpRr8JRb8WhdCoc+olnF4+Q2Xnq6s6PGvqmY6hARk
        epdRNNv3s+350EqfZk40CsBtFg==
X-Google-Smtp-Source: APBJJlF/ygydXtHK2WcQNwIKWn1rvchM1vP5X4HM9fxjmdLjwiZaVb+zEwVYoMQskpjEIkVIxT4lKw==
X-Received: by 2002:adf:e983:0:b0:314:149a:4f28 with SMTP id h3-20020adfe983000000b00314149a4f28mr320572wrm.23.1689220740127;
        Wed, 12 Jul 2023 20:59:00 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d690e000000b003112f836d4esm6633993wru.85.2023.07.12.20.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:58:59 -0700 (PDT)
Message-ID: <59d54d8a-7c23-c6d3-5608-b06b1ce31bda@linaro.org>
Date:   Thu, 13 Jul 2023 06:58:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com
References: <20230705130010.2999839-1-mamta.shukla@leica-geosystems.com>
 <419d80f252f12f091b9c555da0965c84@walle.cc>
 <582915cc4adc89b8ce16568f4d0421ca@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <582915cc4adc89b8ce16568f4d0421ca@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.07.2023 10:26, Michael Walle wrote:
> Am 2023-07-05 15:22, schrieb Michael Walle:
> 
>> FWIW, I noticed the difference between MT25QU and MT25QL here. But
>> I don't think we can do anything about it. It is just another example,
>> that the name is mostly irrelavant/cannot be trusted. Vendors tend to
>> reuse the id for different (software compatible probably) parts. Maybe
>> we can get rid of it entirely. Tudor, Pratyush?
> 
> I must have been blind, the ID is different (ba vs bb), but my point
> is still valid.
> 

the name is good for debug purposes to differentiate between flashes
that use the same ID. But otherwise I too don't see a great benefit of
showing/printing the flash name.
