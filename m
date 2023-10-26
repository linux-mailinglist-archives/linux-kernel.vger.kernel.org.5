Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7407D850E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbjJZOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJZOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:46:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC3DB9;
        Thu, 26 Oct 2023 07:46:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5af5b532d8fso2148097b3.2;
        Thu, 26 Oct 2023 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698331574; x=1698936374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fUbufR/c9jm4nMCCKXr72SFpV/0ht1NtD/NLIfrFeo=;
        b=FU7W6Hzppb6msQIdrNyHDKH8uvwbh4Mgx5AsKSXBotWAhe8ffpxyoFNFqyU/jLwgAN
         jAaDJLa4tXEz7Ybx43aBjFdZe6swDvNs7mrL1ITeyGcTJo41t1z7gO10rwJx0n7nklrf
         B+lVVyZmiW1J65uBUfCSUPyuqhdYhiVpIL+hZblCG9ISw8+W5txKKAD0If+RhhXSAv6Q
         5WnGbyUUsGukWRMFBWl6FMoBIq+A1fLYNcNjaccRXVLzStgwun/LkBhxJq4CNPoYFQ+n
         +PIaRqdaqphKm4VTvWoHseae1a3OoC8V7vaVqdlWgubzgzOAB5EaSCJlxlzGUfn7H2FQ
         ZyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331574; x=1698936374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fUbufR/c9jm4nMCCKXr72SFpV/0ht1NtD/NLIfrFeo=;
        b=HtX5G/D8VSzJAqyVnJEykixE8XG7C53X4uQg5hjSgzPnw9z26ZVSBujcdreYn5hAyL
         x2d4vJ+D6I3KEj8FaBgMzoxebobQKaqh/kSFz8sSir6D0fqipnEU+7hhI7v+qOviYDuC
         UuL5Ig2r8HbbMLv1esEQjM80HDxG6AJMohXREMiwcyLOLqpAKEXCnfldUulNeXK3aCW6
         pmTEs86+mL10xEdfjIe+k/CuHASwR/qyofqPz6X3UQp2QjPlmYV8CewZfgnRKLjV6veU
         onuANnSAXKYZFZzLii2DMPiKB1i0HMs6dd3LuHMmTHzD0ArqcZyiFarAoqwpdzZzmpwH
         2vMw==
X-Gm-Message-State: AOJu0YzX2OBni+kmtrqEW6HO/RpUkKS0COFI+t2CKbdklmOVb18cPAf+
        aFSFru4TmJeeP6Llx9IpaRM=
X-Google-Smtp-Source: AGHT+IEyT24EznHUVkkwOVYRgeSkn2vuZYmkCo70Dwt97OPD9rrmjf0wgEqlWXHnltkue81HkZts9A==
X-Received: by 2002:a05:690c:d93:b0:5a7:cfd0:4b43 with SMTP id da19-20020a05690c0d9300b005a7cfd04b43mr25064348ywb.13.1698331574601;
        Thu, 26 Oct 2023 07:46:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6-20020a0dd406000000b0059f802fad40sm6030351ywd.22.2023.10.26.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:46:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 26 Oct 2023 07:46:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ellie Hermaszewska <kernel@monoid.al>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
Message-ID: <6e8a5054-0082-4f7d-9443-a5dcfc159df5@roeck-us.net>
References: <df22c0f4-671f-4108-85a0-d1667ec1da77@monoid.al>
 <20231026104332.906357-1-kernel@monoid.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026104332.906357-1-kernel@monoid.al>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 06:43:22PM +0800, Ellie Hermaszewska wrote:
> Only the temp sensors that I can verify are present.
> 
> T_Sensor is the temperature reading of a 10kΩ β=3435K NTC thermistor
> optionally connected to the T_SENSOR header.
> 
> The other sensors are as found on the X670E Hero.
> 
> Signed-off-by: Ellie Hermaszewska <kernel@monoid.al>

Applied, but please provide changelogs in the future.

Guenter
