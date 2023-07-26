Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7F762AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjGZFZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGZFZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:25:34 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EC1212D;
        Tue, 25 Jul 2023 22:25:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9f47214a3so5793001a34.0;
        Tue, 25 Jul 2023 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690349133; x=1690953933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lHvF+ZP+0haOLHn0VbIkloIdVOeWuG2FX3VUkNfPwo=;
        b=UCgmIBrBIBIx5CELpPEkhMO8rxqk8S3p/aAG3/pDxhSzUtsaLQR8Ux94khw7OWBh4W
         I9/WiI8mkPCkfcPLT5nqVSsoNbj6nr2muQsxg/0POCEeRXgRVyIzyVyYETdhxSGR+AP6
         EUQpr3MNyxJYjgXEpbXpXpklEEq6PO5Tv/p4ZzGXLhzX2ARJLqYAFOIPvtiRMFg/zJ54
         E+YstzhXL3wtkajKtHdePx0RvrqpobpcccF0oY8Pkx+BnZy5q0Ed9r1wbj/NZiuo/SXV
         qhjIxPxZnrCY14o1xlnJbkCZNAbzDpVATSy5yiK5DfwIfGmRfikQzp2D0LnmPMUSyFMT
         +HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690349133; x=1690953933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lHvF+ZP+0haOLHn0VbIkloIdVOeWuG2FX3VUkNfPwo=;
        b=JeJoumlv/9rtXkB2eBqTinsFgsFY8EtjOHM31Jbnw/lM/lnACdkArGwcYkeJJaRG/C
         opu3KLXk58/COqXwTrA/WR/beqCo2krCoN83Ey07ysAqpHIYhlTktxsQC3Hm/0xqhUuU
         jzeGb5c8qUbrI3AZ9oGk8tDvHm1yBYBvF4sF5/NvVzb8eYRjm8XySExIV2vOnxwUvGsG
         2WaSDRKovUaMpeaHSs10fbZZf1UlMFI0CvpkfpIaiGTAVZICYE+kFrOOCN71HZdO4tcd
         8pd55XT7cAjkYlHTxWYZGWHo5zQU7MbSNZpAXVYv9mHsfcJ6zs6Pdfnubz/HhUJlhYQq
         tKMA==
X-Gm-Message-State: ABy/qLaCYqh1qj8pbM/hTJXSVr6IrJk0ZCK8NLS7bG+ziw3o0ISc4TNc
        P+PoZbwzdNz1+PAOOV4YuqACofBpbaw=
X-Google-Smtp-Source: APBJJlFx5uPk2u2KKQW2qyBYvhoEmXAc4H0jW8UfEEThFzsyc1v5RAw/+R2kgj/yBAMsL9UP3uFuDw==
X-Received: by 2002:a05:6358:5919:b0:135:acfd:8786 with SMTP id g25-20020a056358591900b00135acfd8786mr1140120rwf.3.1690349132813;
        Tue, 25 Jul 2023 22:25:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b0055b61cd99a1sm11682812pgd.81.2023.07.25.22.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:25:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 22:25:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     werneazc@gmail.com
Cc:     jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH v6 2/2] hwmon: (hs3001) Add driver for Renesas HS3001
Message-ID: <a3406e39-8580-4ad7-b7ad-19e24eb33526@roeck-us.net>
References: <0f32155b-bcc1-4d9e-bba9-058d63194abc@roeck-us.net>
 <20230725042207.22310-2-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725042207.22310-2-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 06:22:07AM +0200, werneazc@gmail.com wrote:
> From: Andre Werner <andre.werner@systec-electronic.com>
> 
> Add base support for Renesas HS3001 temperature
> and humidity sensors and its compatibles HS3002,
> HS3003 and HS3004.
> 
> The sensor has a fix I2C address 0x44. The resolution
> is fixed to 14bit (ref. Missing feature).
> 
> Missing feature:
> - Accessing non-volatile memory: Custom board has no
>   possibility to control voltage supply of sensor. Thus,
>   we cannot send the necessary control commands within
>   the first 10ms after power-on.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

Applied.

Thanks,
Guenter
