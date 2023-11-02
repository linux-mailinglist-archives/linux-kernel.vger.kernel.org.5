Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64117DFBD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjKBVC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:02:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66918C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:02:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c34e87b571so417620b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698958940; x=1699563740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPuGtKMPlEfvRS+P+xBusUQd48EgHVGydBMy1D5IEL4=;
        b=eCOLRmCofS/3Ru4fUr+jV98QuZNjY+W6xFtaZwYepsCQIxArwfbuDQtmNEpEOK5cTT
         vVvdYi7xaY9tdvuo89d0dVnJbpjFeo/XHDI1vrF1d6JsgU0DgDwF6sJ72LnCVxzbpBVR
         4mPBusHKhtyx7b+9gynEH8ygpwxsHfjoG6gSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958940; x=1699563740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPuGtKMPlEfvRS+P+xBusUQd48EgHVGydBMy1D5IEL4=;
        b=vbPlLIXFnilK1zfBr6Ck5dQZvMGV+4UMN5fdnQ4bl+sduigIbFS8hf1H5X16xGELgt
         PRD1+89RWWc2LLebMlsUryOUOJUe7wfR0QocLsa8bXwcDEPFtLqHG+/3OeZ1mvmEmvr9
         oAidHNMXZq7Ds7FsCwmvzK5RQsmHDlvviM8isDHCMkBEM4brQeVlkzUKOcOVs7ZnoN30
         WpBo/j32xp+eXrh+HzcznvNQCZTrJZuazUfFLW9zQEp3nXYfCSoTIwPJoA9zp2zzyyt1
         Jn2BUouZsyOz82qBv5at0DLYcN2JRuypOuEX38rMA+ORaDaXm4XUFySNyOeOe5yFpLKG
         I1xg==
X-Gm-Message-State: AOJu0Yxq164BUweYMTy4dWnG+hEnUUFgsbc/ePFT0HykIsLFl3jdT0cN
        lHbnWPIu5nc0+KV5fRnYxanOXg==
X-Google-Smtp-Source: AGHT+IFYvdfRwpri72fkum0U8llMGbXB5T3T/b0kSk4KbqyH+3NrsK9gYNXQO1FoJxEDxjHW0gjP7w==
X-Received: by 2002:a05:6a00:2d0b:b0:692:6d3f:485b with SMTP id fa11-20020a056a002d0b00b006926d3f485bmr18420114pfb.3.1698958940181;
        Thu, 02 Nov 2023 14:02:20 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:a601:95c2:1e12:1936])
        by smtp.gmail.com with UTF8SMTPSA id fh21-20020a056a00391500b006b22218cb92sm172254pfb.43.2023.11.02.14.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 14:02:19 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:02:18 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Karel Balej <balejk@matfyz.cz>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mwifiex: document use with the SD8777
 chipset
Message-ID: <ZUQOWtIofdSDHi3t@google.com>
References: <20231029111807.19261-1-balejk@matfyz.cz>
 <20231029111807.19261-2-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029111807.19261-2-balejk@matfyz.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 12:08:16PM +0100, Karel Balej wrote:
> Document the corresponding compatible string for the use of this driver
> with the Marvell SD8777 wireless chipset.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

FWIW, the binding looks fine from mwifiex point of view, so:

Acked-by: Brian Norris <briannorris@chromium.org>

But see cover letter. We can't merge driver support without a
linux-firmware-compatible (or otherwise redistributable) firmware, so
NAK for the series.
