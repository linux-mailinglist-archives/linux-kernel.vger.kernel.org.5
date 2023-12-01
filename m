Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670F80025F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjLAEFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:05:53 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FFD54;
        Thu, 30 Nov 2023 20:06:00 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b83fc26e4cso65233b6e.2;
        Thu, 30 Nov 2023 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403560; x=1702008360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17YNEO7OFkyhrdMdvlv3Fdhs+ffMvgf1+XXjuFPzMXk=;
        b=K/5ZJdG8KvbvRf41BCYG3ZEc7DE8pvIZdzGmWv/QTx5q16pTs12XR/oSZiahqP7wMT
         isIqMw0l33sS0JpKdPlZAF4uds+uFIqHe5FX7SB63XKyDSW58Mtz3WnjAP5EH9y5QfV8
         Nbo3HIqG/HDlmRyfVfsoO+ghlRcfeHq45RpmNFOpaErqCPdQfddMfISQwlNAyXdUyzY/
         BXA0qnuWMZtMuzr98oiDugJw4Z7hF80U3KyHjlELdvEjX5gtkxfBg0OW8nSFdW60T9a7
         As3NTmFI6ZORH1Z02x7BdJKAWVipvePUQRtQPx8CBbNy3xaBBD0aUinYKR640pow44KO
         O11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403560; x=1702008360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17YNEO7OFkyhrdMdvlv3Fdhs+ffMvgf1+XXjuFPzMXk=;
        b=mKrcv9Ii94gSBOFgXNTSQvj/7521DPf7N6z862crEueG226K0qutuLIkIY8A/d+t7N
         L0iabfc4R8XF4ih/Ovu0CQ1EOyMeuZxd26RV7hmeqvgH3ox23417yjuEuqPyh4AeFejs
         iRzSfIFIayHmacjwPWgk6H3QxUMBbfJRh4m/boHuYQxoqJyX1+4klxv/jF0TdM85NFDK
         BxgYtUIrr2XCB5YVJlwxGWlsidfRpSqfWJN0vMKEmvSu216WpJpUhVArY4TA4Ke2hiOv
         B2f2uQaKlKozCewqwbP7Uf295tvNGUpduRfvkl3I+UWJpOMj0n7PRCOAz8j2toUB31Tq
         wHGw==
X-Gm-Message-State: AOJu0YxMdXaOiXSaVMOIV6BWz7J+LFISqxZ7By6OtOPYAFf1zsf5jIkv
        64Adv0RIG0GNUHNGdXAQ6ZTiwPAhv2Q=
X-Google-Smtp-Source: AGHT+IGYdvrltukNUozm0MOWGLIV2/mZ/1ZG1qW98/6LX4hN258DITtplPR19RLdyoTMSF3atgPTuw==
X-Received: by 2002:aca:1312:0:b0:3b8:5c24:80da with SMTP id e18-20020aca1312000000b003b85c2480damr1486972oii.58.1701403559866;
        Thu, 30 Nov 2023 20:05:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a056808211000b003ae53e64549sm419398oiw.31.2023.11.30.20.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:05:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Nov 2023 20:05:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        naresh.solanki@9elements.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: peci: Bump timeout
Message-ID: <2d717ded-3a0e-4f64-bb5c-4c10c7ac6d75@roeck-us.net>
References: <20231130090422.2535542-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130090422.2535542-1-patrick.rudolph@9elements.com>
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

On Thu, Nov 30, 2023 at 10:04:21AM +0100, Patrick Rudolph wrote:
> The PECI CPU sensors are available as soon as the CPU is powered,
> however the PECI DIMM sensors are available after DRAM has been
> trained and thresholds have been written by host firmware.
> 
> The default timeout of 30 seconds isn't enough for modern multisocket
> platforms utilizing DDR5 memory to bring up the memory and enable PECI
> sensor data.
> Bump the default timeout to 10 minutes in case the system starts
> without cached DDR5 training data.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Applied. Note that the affected driver (peci/dimmtemp) should be
listed in the subject. I updated that.

Guenter
