Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DEC80B40A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjLILsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLILsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:48:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE6F1;
        Sat,  9 Dec 2023 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702122470; x=1702727270; i=linosanfilippo@gmx.de;
        bh=1UF6FDdhmJ4WxT0YV5JeVePLp1zU4VEaSmjDTTuAp70=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
         In-Reply-To;
        b=OyTUA1WX5/d7+mEig8rVLrCnlQdSN7S6sfv7mH+W7cPclf7wOroPmAH+MXRo+c+B
         pOzWybX/hWMH+BmEHcBQidsgapRVms31Kta0IQgP50Uys2Wg6BIAL6lNtBKQkD3kT
         roGLno+RtO0zRYXI+fx1xXsKoYyC6LAk3A+EkoUDMw5cA36MlrVT5hBDXTjIWOBs/
         eTjyau0AboXzj/zsDEJq4T7ODlHdy51FSZIBzqaYvi4jAhjhcblXaww55SYy58rg4
         pJwBdBxGquIhdTyqcRT3+B2nHABLwsSqvPOlEZf4/l+a9G/6CFAbiXruSWuJtu7ZB
         biqrUyuaNfpdu32TDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1rItm03Kyv-016d0u; Sat, 09
 Dec 2023 12:47:49 +0100
Message-ID: <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
Date:   Sat, 9 Dec 2023 12:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
In-Reply-To: <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0XbavJOj6kPYHuY2oqtdIJRTO4bm7RpNZrWc4dxKAl/SToIlDiD
 etgjnvuTWY5NbDj6DCIjpfVQfL7o/Ejo2gwKvCQC0afFcjZVUntHTqwLBQ4SbNhlA0JDUAT
 hTrz4QF9NRuO6y8mnPh+k+j38zoaX8kfa2psegY//i8Qh/QPOE3QfVRNOr2i8kFeiv5h4jW
 oHWqvSsY8NGlCeczOxYKw==
UI-OutboundReport: notjunk:1;M01:P0:0oeAITP1Ax0=;PFdM72vaTGu0XG/wGErDFlODzYO
 PzT9UFQ9grUckTuGOMBCD0ba7EtDJnP4DB4D2aE8EtUyBn9RER+tv1uLQgf1o6cbMR5PZ0Y9u
 yo90fe4LIrj9lzlGfACRxF1LKrC8YyVszew2PZ4C01BRoTRKie0TvZPRsh0ZTEO0tFtWwAWky
 57DNGAF2WgsBG9PnxkU0BI+L7vvfJHnLNxQrJ5rRb6ZWP7euAC904jqT6vVaSW7e9TZna9e/V
 tEj3YD7Bfq76G4X9botSlhbfVpZNd7zFooPFU9We3WId9KVvbzG44j3ogH02VHm6k5r/F2jX9
 0uDd3EAuc4dWtc7hU7x+uR8vVgpagnhjcBRJmSB5f8QBD9pVvupNZ3RoHpIxKBPb+qkUbsrLA
 4+KNmS9oGAv6HZIVAORwqPXiVuEK3ndK8I3F078ojstL7AL/7MfwCmTkuxC96s06wcNpWjS+D
 DkLjkUQTsFxJGbQqQ4OnnRQYEg81f2B8pvHzKM8cZp1fyydphuOuaZQI26xk2RBEpqnv9dppv
 XzzpyzPr8LQcJexLZV0OWEzmUbJTPxynLfl4lrT5u58xTIuzBfWmSqvO5rG4fVMx/QYF+9p/I
 JzBZHhf7NslomSHoDAnGpJr8On6OJiW30MDQrTZtA7kyXP0HcK28tHbfaoXMpq+jDZgtGJePJ
 VqrPHdeO9R7e4HH2PBwLPx8Ja9XPuu7Tnfx44FswZIRFAvIncBNkwHdaIPOX1LUV2o8zIkkmE
 KRYoE+YtPCfLxwFkeqJZRmSD9Cptq5BPZkIMU9vKtpOmd6Gos2Jx520kJEcLrGLR1J9EC7vMV
 Q8LcZ2JH3XFxey8fnJO3+8AJdRB5t874tJQI/HNTWxldkPbvS7iJG6D8+9yN0MHVF31h7BuhN
 6aaA8TtbWgpXv72CspBewdC6OE6h1+ZjrguVchD7AJkOwFG9h2zOalEvtb+Pm0rn2L1P2dW9p
 g2EeDtA0oIc/URFH5/LeSirppt0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.12.23 16:42, Lino Sanfilippo wrote:
>

>>>>
>>>> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode b=
it
>>>> to struct serial_rs485:
>>>>
>>>> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@m=
oxa.com/
>>>>
>>>
>>> That new flag was suggested by me instead of using SER_RS422_ENABLED, =
which
>>> would mostly be redundant to SER_RS485_ENABLED.

A cleaner solution would probably be to not handle RS422 with the RS485 se=
ttings at
all, but to introduce another set of ioctls to set and read it.

An own RS422 structure like

struct serial_rs422 {
	__u32	flags;
#define SER_RS422_ENABLED		(1 << 0)
#define SER_RS422_TERMINATE_BUS		(1 << 1)
};


could be used as the parameter for these new ioctls.

Any comments on this?


Regards,
Lino
