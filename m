Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6027E9FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjKMPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMPbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:31:02 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBED63;
        Mon, 13 Nov 2023 07:30:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77ba957043cso310752385a.2;
        Mon, 13 Nov 2023 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889458; x=1700494258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42zhaoIyMCBHeyrbAA4zIRqsQzSZSBrSFxVPTutgP68=;
        b=dEUpzZDirY4pl2VLYg/L3H2omi++inqk1XvPSS25BgBNgNM5Hhhrb8z8zEdFv8uxo9
         3Qgzo5MMQW3Fz7KHoI2nbMCzBUtF12fh3DE+/DPemdGBQjkZa+lb7htMjZdtLoYPamrm
         /B5KrucF52e5DXF7mzXtmO2zTx2Bh1iM5HPe0QHpXCEpGkZHBOoQrbe7dqMvKr5AUYqk
         oadWrTlEBtl0obaM3LLTQFIrwLwTBuolEqPqTEd/t9JOFpK6dIdVL1StiOETHP54Iubi
         BgGMGYQMg3/sH6WJxLZxfMQ6/jRB7svKAQr4JOAOl2Ha1VpFxbUD1wpKikczFUbtUoN6
         fSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889458; x=1700494258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42zhaoIyMCBHeyrbAA4zIRqsQzSZSBrSFxVPTutgP68=;
        b=ng5rOzQ7h7hQ29fxwelg0EHdI2TVeh8mSTRymmiYbRiT305UAtMITvf3TOz/gM1HZv
         zVC6dyddqchDsk9a6LjXcdqJ7TeA+KT+Wa0UzhWDEKhshySAMbX+xcfMiSQftVAPq6sr
         D6o7F17sgcdlloKTFG4/E5A57gnJKHt9aC7DxXEof06sIAQu3sKh1EfcIeS/n6u1bcI9
         etnOQv9Y+fsrC9/QnrYkrlRTIdMdMSnNsVtmlPiVB/4hw0IYr/7uAtBfytLOwpDIaGaC
         Qicr6S2FEp9k5hP79rWf5e078KfMT0u1wbryJjZ9URM/kRXXQbC90rdjiT/xLTjIgCj/
         i5yg==
X-Gm-Message-State: AOJu0YwTuAAzWaujz1TpQmCqtOB4T0m8hlSqwUgADwHXJiLaseCvuqMT
        OBY2K1MLtjaVP2npbeWryLg=
X-Google-Smtp-Source: AGHT+IElU8MvpadKl2wRkEqmz45iilbvkGXlfOxNER4Oz1lClrz8qKoz4tOA3mvn7UFt2PjegOfdTQ==
X-Received: by 2002:a05:620a:f03:b0:77b:9360:8839 with SMTP id v3-20020a05620a0f0300b0077b93608839mr8383762qkl.68.1699889458387;
        Mon, 13 Nov 2023 07:30:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a2a0100b007778503ebf4sm1944477qkp.16.2023.11.13.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:30:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Nov 2023 07:30:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, afaerber@suse.de,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: realtek,rtd1295-watchdog: convert
 txt to yaml
Message-ID: <f4deb233-0dc5-442c-9519-b68e62d9e27f@roeck-us.net>
References: <20231112162049.12633-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112162049.12633-1-n2h9z4@gmail.com>
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

On Sun, Nov 12, 2023 at 05:20:49PM +0100, Nik Bune wrote:
> Convert txt file to yaml. Add maintainers from git blame.
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
