Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1927F8526
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjKXUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjKXUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:20:47 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88B172E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:20:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a06e59384b6so273660266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700857252; x=1701462052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViRdTSishNWqaCbUV2uSiB5xfGwWROv1i1ATWCTnWTA=;
        b=R+HwbpZoTKxb9HCK8daSFvrA68GKJoJdKGpmkh76wMxNmonp/oedt9z1ibJLExAYfD
         clsxh3Vn75qAoKA3Ugl96Ej+7p/dOfAkd448k5oFJrctZtEqvTfPP3y1VQZgBnKE0LXr
         X99URVnewv+1JjMmmT1YHIoLDL7UY2xLQBK5lqUD8c9x8/6sDXjRYyEroS6n6dIxxuMP
         7L5TQ1gQcNQH0xbSRmu2GLkUsFGr2Ykc0j9qO3iUdBCFtoUSJHVi8SSfXcx+TV/nXRS7
         jop4MjQc1EghdUSJD08BsqEw6KTyw/S/rUW2WTi6WQ0b17HRFwDT69ITTtHZiSBeQofC
         63UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700857252; x=1701462052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViRdTSishNWqaCbUV2uSiB5xfGwWROv1i1ATWCTnWTA=;
        b=PdZehb9ORxeNJswodbJAOAv+QvMwfo6gmwoZZyc5Nlj+xnm1ku/L0SYY0EOFKWjydl
         Yy2NGL9zbQzMtCApYrQEVrrsPLS8//cvDhvlR4UES/dpcctBIUbP/mTrltjczPwpopfR
         RA6XX5GWE8o63/SIFurX3y7dVBPwIR507IUeQn1pIHtXb3FQ0dOQRjNSdjrl9S6T2t+w
         59GcIXomqF8iNaemOBxyQ2CEXpjWv0PCIFI43bq3zex2AwwTDeQGzZHIpfFGv1OpWUB1
         S3oneOgnwpDvkhqx4JAn54VY4T5DlgQWsOKqWfdVlMJxRBbOCu2scxbqgUxDO2+EE+LL
         YEkw==
X-Gm-Message-State: AOJu0YzIjUgtXIYFZJlQTfapVcUigpnSE46PD9j1yIQz1wwRHROy7Xbz
        Pu3a3TuEjOGS4IR3R3Qi8eSX3w==
X-Google-Smtp-Source: AGHT+IFn1Sx7rXRl6dVxMZBYTRWrjxX7S2eKanbthlEva2ddzupq9Obo7nDZY2VTzHvPyL/U1S/CTw==
X-Received: by 2002:a17:907:d407:b0:a02:ad84:3ab3 with SMTP id vi7-20020a170907d40700b00a02ad843ab3mr4271261ejc.44.1700857251967;
        Fri, 24 Nov 2023 12:20:51 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id cf16-20020a170906b2d000b0099bd7b26639sm2458153ejb.6.2023.11.24.12.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 12:20:51 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, bagasdotme@gmail.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] docs: mtd: spi-nor: add sections about flash additions and testing
Date:   Fri, 24 Nov 2023 22:20:42 +0200
Message-Id: <170085693794.1196935.11331460822270915583.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
References: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=z5Gv5g8CG0O6R3uZ2jYBbxtCMSKnIZn+Qt1oDzYZlX0=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYQWZHXwqSKgQJis+6i9/ivqKhWebRQEeB3NCf HUNer9eXrSJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWEFmQAKCRBLVU9HpY0U 6VpvB/9TU12yTGGWVuKnS9CNZLjA0Pi8FLC646PN3qnQl5UnNCb25Q7R1O3g0prog9w1+JIPllP nXVBrD2MlMfqA9c86jeSoo6zNQeCtjCBFMkT5ho59k8ZP1OWIwSu61IvQV93vDt6TNYa9DXcTO0 dfYXCF4gAv0uzHju2RnRBnVGttNq4j/bMUaZticjbjFDv04gZso01Fowq+ZHICq+ODtEsfZq7e5 gQPhXCXYzTwyMsCdwpeXXUGQJjY++kh4hLHGbdEckM9LFNwg7wZrAlUOlTaMd0crUXUx7Wjg4ic qm6C8Y8hAhC/cK+NBSwhzbw+XpUwuD/VbNeMoNUdqs85Q5/G
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 20:49:00 +0200, Tudor Ambarus wrote:
> v2:
> - specify that we prefer to dump the SFDP data with ``xxd -p`` (Michael)
> - update the mtd-utils tests (Pratyush)
> - fix formatting (Bagas)
> 
> Introduce guide about when to propose a new flash addition and what are
> the minimum testing requirements. Dropped the old documentation as it
> no longer applies to the current SPI NOR framework state.
> 
> [...]

Introduced the extra erase test. I guess the proposed mtd-utils
test suite can be implemented as a dedicated mtd-utils standard test.
Exercise for the readers or for future self.

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/2] docs: mtd: spi-nor: add sections about flash additions and testing
      https://git.kernel.org/mtd/c/bb1f9e39c1bf
[2/2] docs: mtd: spi-nor: drop obsolete info
      https://git.kernel.org/mtd/c/9b3eae3486c8

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
