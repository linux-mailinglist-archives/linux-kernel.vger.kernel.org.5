Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE897D7A09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjJZBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:17:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDECC;
        Wed, 25 Oct 2023 18:17:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a90d6ab962so2598767b3.2;
        Wed, 25 Oct 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698283071; x=1698887871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcmLAk60kL6zlNKUKvl55N1AQyampPE6Tm8116de3PE=;
        b=d4YQ05Z1eSR0iFs1fb2+roWk806jLyzrkI+Iszb4HJskZynuRSsXye7Yn4q5mHXQFt
         k43+zy/e7R4kffTPoILxc85+FfoAa+GtXCr5ugiJ8WkxXQ/Q+OfKWyEzjnJ+pW2ThfAq
         e+ST+z2zE+guCTxmPlnBazIcjVpLxxHYWeJMvmPliDDUV+CBzSBlE435MvS+DVbJRC4V
         xopaS7iM4pYxBSharp0l4g2Wv59sBz1i+CZ2kG5/ttF3tnta64Y/sUXimOI4GVjjdgbc
         banoTAHBZ4TOUCbuhgy8JIMjpJs9Hv0p86L2IAWZa3EfZrbwDSDEweMQKKNUF4PJq4IO
         ov6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283071; x=1698887871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcmLAk60kL6zlNKUKvl55N1AQyampPE6Tm8116de3PE=;
        b=hqtMjH1e0/CAARbD5k3aUxf9Y/IYz6oX+jbSXbJTyKN77gJo4KieyNr96mkt1oEmSH
         9YV+HuvPF9IuPwILvnc1keMOTFRxzFC8vvY1JcDYj246+sGeYYMRRlMrQ9uhekaaqsD3
         MP73yed1Ol4CT5M0R3lw8/DHppvGacKq+ca+uBFdhiVWynoW2Yef8JiQmFsXLvABpYx0
         2OU6v2aexD0qkPDjaHyF7vb/nfdHocJfIneSGN4k2ZCGpwScJTR8BZp6VyqFLXBGxOeP
         KHZy2yJSwGbPINFdQu/W2Lhz9P8rw4+zPAoG7CH1T3kOEjCM8TnvQEL2hmft2UV3VPhe
         AxVg==
X-Gm-Message-State: AOJu0Ywv1gPH4xl4kcM/Zqc8vipAUrnd1XXIE3tc6Qbxl0A/OYXw18p0
        TCxfXJlLfqMIo8xIclaUwhVjKEyYCTg=
X-Google-Smtp-Source: AGHT+IGBDty2Lzt/doppZU9GoLg2YB4L7L8+Ym72Uj/4azHX11JABN1vi7B6DaufwVKrxDH1WtPtAQ==
X-Received: by 2002:a0d:cc8c:0:b0:5a7:acae:3bb0 with SMTP id o134-20020a0dcc8c000000b005a7acae3bb0mr19966732ywd.5.1698283071201;
        Wed, 25 Oct 2023 18:17:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h84-20020a816c57000000b005a0f9718a5fsm5551608ywc.78.2023.10.25.18.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 18:17:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 18:17:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drivers: hwmon: max31827: handle vref regulator
Message-ID: <68af4cea-39b9-4f66-b653-cde1a6369cc6@roeck-us.net>
References: <20230925122929.10610-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925122929.10610-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:29:28PM +0300, Antoniu Miclaus wrote:
> Add missing implementation for the max31827 supply regulator.
> This is a hardware required property that is not handled.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Applied.

Thanks,
Guenter
