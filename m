Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55DA7F9B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjK0ITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjK0ITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:19:01 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1687F181
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:07 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so50827501fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073145; x=1701677945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0HbzSFHktdmLOX25jug4aYGWz0JCpvccscLtTAHhqA=;
        b=QphDvuiwQjGHdTXhqUBiB2JEVlMOJZSHVDOL20dEKq+VU3gcwo7gkyMuDgSS6b5iUy
         Ztx4McJ8qqLhGFucGM1d3sjHRWv7Ptf5ITPdaK+3P6eG9A/STs51B0sHsSFDSyKU9WbB
         o9+AYOZtRnYWuvBgv2fQg6COVD1GFehFEqVhFssyxS9fraUVC4ycM1KCj5t/V7H+Dx4l
         zZYpUG38gcWUw9CVzNL02XJYYp+5e22UmIWq0JM0CjmiuhNCof3jjj+NmfjFiSptYOGp
         1msPi0e52b/ccp+SRlDzLRa9qw5uhvFtnmI9HZFYQocEvjKz6Wwlicch1arUs7Dd0Gyt
         46oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073145; x=1701677945;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0HbzSFHktdmLOX25jug4aYGWz0JCpvccscLtTAHhqA=;
        b=sdKIbTkXyvayoW5R7njgdWX2UW19Nrmp+2jJwESM8tdW/FNsbPL/0jnUygkFey1K82
         e2ssZAFQtyCEaIe9gve/cgQYWfsgC5tn5fQftK5GHu+o4mneOEoDJguUeFG+a9lioxnz
         9dQ4CxxxLcxKyM9CiPd6gST5ER43rkhlbYdJU3VHO9HhpGViLDRoNuLsFMU7wrMCHDjx
         1irNHeBRu7JTZ+8BlRwdImuw0AXs1sYk4LRvUDNK+J+VToF2VkiJGVILFe2wOfgYHn3w
         W3S06+wZOOKSg8/YHCY9eOnRtQWWsIyjEs1/EXIxNI6CU/EZAYTRz/AnlecMcpKA2wpW
         IFKA==
X-Gm-Message-State: AOJu0YxxsRxTmZos5b3nBHbMwdKEt6GsY8NukrFJRiIKZ4e+lPYfunIa
        cLYvAZI5u91EqpCpzXkqM7TVFw==
X-Google-Smtp-Source: AGHT+IEuMirGebq4a6v9lO8Go4zAoGpsFpnVjJ30a4fq7OT4bnU7eMDXEQmoxjW6cmOOXG5zErDs5Q==
X-Received: by 2002:a2e:3207:0:b0:2c5:15dc:ba99 with SMTP id y7-20020a2e3207000000b002c515dcba99mr6829008ljy.51.1701073145285;
        Mon, 27 Nov 2023 00:19:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm13516568wmb.14.2023.11.27.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:19:04 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Viacheslav Bocharov <adeep@lexina.in>
In-Reply-To: <20231102061233.3113249-1-adeep@lexina.in>
References: <20231102061233.3113249-1-adeep@lexina.in>
Subject: Re: [PATCH] arm64: dts: meson-axg: jethub-jxx add support for
 EEPROM
Message-Id: <170107314458.1083800.6313353700407370845.b4-ty@linaro.org>
Date:   Mon, 27 Nov 2023 09:19:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 02 Nov 2023 09:12:33 +0300, Viacheslav Bocharov wrote:
> Add dts node for EEPROM placed on baseboard in JetHub D1+ devices.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[1/1] arm64: dts: meson-axg: jethub-jxx add support for EEPROM
      https://git.kernel.org/amlogic/c/bee505184fd5543b9e901a37523e39fd1db06860

These changes has been applied on the intermediate git tree [1].

The v6.8/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

