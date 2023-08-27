Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268478A2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjH0W1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjH0W1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:27:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E3128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:27:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so328224766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693175232; x=1693780032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YbIHdhv+mU6ZQ/4jyYH5LBYMtEme8GL5cG7vGjkPQA=;
        b=IJvWkDX/VaqY1Cj5/4UO7pdMR2l41xGdi8dCKtPzeybTZw/AuvEnxj9dItxaWsHLrU
         QWKxwFweURZNVi73rOqvHjqtsX5ZNA+UpMfeX8V62Ppb/jSblA8t3pIVNBBCef3ggBcT
         XBFRYhGnwsaYRYhbiNOYTwOECtwGhGq8RB27okVXCquHqb5cIlpI5lf0znDdrbuRaunC
         /remlutxzn44A+odzV2dWBO8WUK4Xgkt9Os98FPjLbXHetqHQ1Fbc8TYZMusZBh9tNG8
         U36zcpWWFCvbEatDkCW5lx1b/giB48KYVJssLzIX3f4Bwhy5BhO6UDTYDEwer1jiyQqm
         qEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693175232; x=1693780032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YbIHdhv+mU6ZQ/4jyYH5LBYMtEme8GL5cG7vGjkPQA=;
        b=fo2g5UdsI3I4kpRhKEyTx0obyZK6xoiAZx4qtRyDGLlPHhf3uOnBfn7mqGyxtzofNZ
         w5t81cXJwWaxf9uVz7rwrqa1NRdLmjmqnphXh5dBH/yXZPnWZ+0MJZIuwFubQXBVysoM
         AQTQ6g+XZuVjIE6KdmJjgknwzlo33p/8u798A55ryiaC8PQjwb+BgSNw6XfxjM3CmdQx
         5YQEI1d8NepnITRN/+L5OQIFHTRF4IXLJjEJgMofvOof7JkBEYXwpizIl9Zw1o3X95J/
         kDATTotzzNlvZxPzVCpLasmRkBlLQ/BQtZykmLvOCA/G6dGNgkhSbMsFUlygIkI2oS0K
         VMlA==
X-Gm-Message-State: AOJu0YxYnogyFkfbO4rwA/bp9LcsYZk1l1qDEvqWLC2fEA3+nhAxnAnd
        vnMzmDobXlTH3melAn8MJ5o=
X-Google-Smtp-Source: AGHT+IE/f9vLn93SlidftzfnBTAqmuoN2lz7DeJrY36pahuG1SeuBIhpVCeqdqIolBpwwJvceI0Vvg==
X-Received: by 2002:a17:907:7602:b0:9a1:d400:39e7 with SMTP id jx2-20020a170907760200b009a1d40039e7mr10522197ejc.5.1693175231739;
        Sun, 27 Aug 2023 15:27:11 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b0099315454e76sm3842680ejn.211.2023.08.27.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 15:27:11 -0700 (PDT)
Date:   Mon, 28 Aug 2023 00:27:10 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <ZOvNvkRJstLt4ghx@nam-dell>
References: <PH7PR11MB76436F3A05897D8F8DC9F967BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB76436F3A05897D8F8DC9F967BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:12:04PM -0400, Oliver Crumrine wrote:
> Make the octeon ethernet driver better adhere to the
> kernel coding standard
> 
> Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>

See this conversation about a similar mistake that you also made with your
patch series:
https://lore.kernel.org/linux-staging/ZOpq4t22iRXewekD@alolivei-thinkpadt480s.gru.csb/T/#t

Best regards,
Nam
