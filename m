Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5147E4954
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjKGTjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKGTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:02:48 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E80810A;
        Tue,  7 Nov 2023 11:02:46 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-577fff1cae6so4446426a12.1;
        Tue, 07 Nov 2023 11:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383766; x=1699988566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uETg7nqrlrw09uZVX3TWZA1o4y5dupi3TkwOXHUBO7A=;
        b=mRAgALkFcnQ9qaPnI8wkPD6ZK+Esne4h82Wrqt1nYAdcVBRc4ncBkCA1taQ94oivac
         GezeZyf3wwEZCwVc5pASkE62C1h0FAm0AEniei96UGIVI7g07KaP7VZFTsVn8DljtX7+
         /H1H9KxU9ti03hGNY7sc96AmBv2QIq877lgTrBVdXjnFuySJoAlLRW9BqbcBP8v3zCW5
         k9wv3krjlnxiOsIYwn7jCFXBlPDzFO39L3HY9k0qkQAafA/2yDvadi6ywHWdWi2ZUYxQ
         kjYIdzq9WdMw1y1G33zneWa2A7DFhMvBfrniYA44e+gksHvhOsUacWXV9i+vgQ/TAq7E
         wGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383766; x=1699988566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uETg7nqrlrw09uZVX3TWZA1o4y5dupi3TkwOXHUBO7A=;
        b=mJihnsEPXDFOeM1I4ZYJw0j4aIfDFYjllYtEPL7WAV+5qa+X49we5VTs0vyrdho1hq
         RPjgt0P69KRvomu1RdbIFDQnlLOUflkUM66bpAz1H017tcw16Zm9A0Neg4mrwdbAOi2b
         ov33kKIM/V/c6wuGd7j0iqaGFa6AuUF9oNSQdB+do88ktD7if7WoKDyCQKbfUPeqR7gW
         32665CxZyG/ELBawTtFF4cdkW+A4j1XaBJXCqFsgpFyBPZ9ZlHV6quNoqixYfCtF/SZr
         ioiryMEuj3Se8XM4lQWi4mdyAcEiNbYhgPbgx+3Gk3RSlscXvVkdD2o5457MAqFwM4iw
         y5KQ==
X-Gm-Message-State: AOJu0YzW9hj1cjaq3Dr7ufEfqUKhXVAsHw6SUV8wTt2cu/AvtTFNrkht
        tHY+rjsql2KmmIHIaL3Qj5Y=
X-Google-Smtp-Source: AGHT+IHG8f7EVbCLP390BSgk3BzXB03QP5F0o2Xp+ILvSlT1DunvIht/tDZx/zCvjzJxc3fvFoyW5A==
X-Received: by 2002:a17:90b:4d12:b0:280:2b48:f264 with SMTP id mw18-20020a17090b4d1200b002802b48f264mr5256854pjb.0.1699383765604;
        Tue, 07 Nov 2023 11:02:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090a2e1600b00280c6f35546sm150057pjd.49.2023.11.07.11.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 11:02:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
Date:   Tue, 7 Nov 2023 11:02:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, corbet@lwn.net,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, naresh.solanki@9elements.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        BMC-SW@aspeedtech.com, patrick@stwcx.xyz
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 02:50, Billy Tsai wrote:
> Unlike the old design that the register setting of the TACH should based
> on the configure of the PWM. In ast26xx, the dependency between pwm and
> tach controller is eliminated and becomes a separate hardware block. One
> is used to provide pwm output and another is used to monitor the frequency
> of the input. This driver implements them by exposing two kernel
> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> existing drivers for controlling elements such as fans (pwm-fan.c),
> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> provides sysfs interfaces for fan.
> 
> Changes since v9:
> Change the type of fan-driving-mode to string
> Fix some typos and formatting issues.
> 

What is the resend about ?

Guenter

