Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD27C6FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjJLNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjJLNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:55:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689691;
        Thu, 12 Oct 2023 06:55:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso1920615a12.0;
        Thu, 12 Oct 2023 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118910; x=1697723710; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu8VOT2Hnt8xZp2XbOVoQ85nqe18SW0MJ+Lu2qeF2EE=;
        b=kSa4UhHPZXPWVfLnPt7vIeVI4rIz7hsokcU+vxL4wA1nnlo9K+HgMNJcDHw2UPV1I9
         ju7HeeqKCTsDtz8M0KaskJzTi+YCCQ7W5C0lqRqLwStlMuKeZD1ntQU/s9Cvudrt45zh
         sUKeB/kZUceKfZLjIuG6gLSpMYN6S8Lv61SlYPXsH6qDYwOFx3KLkFcs3ABJSQzN9a6X
         zSgNGDB+jMvevoJbnVMhUGhG7eEMIUzkcOmCh4OaiHc1aKr94TYXWsFnZAWjVq+U24vI
         AAGgMqI+RdbMj/lEjQtg32H1Ec3Mh4oHoiX6VZrZnndqz/+DteiS9EK8YW46W1r/CvjV
         pvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118910; x=1697723710;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fu8VOT2Hnt8xZp2XbOVoQ85nqe18SW0MJ+Lu2qeF2EE=;
        b=VUY57f7WArh81WWyh0CCKkOZvjS2zcRalss8DN+mg0iBCW/drZ9sgpO2fZT/1z9tBn
         eEZICAjT0lWfgiPdLuuNFtjkQz/qzNm65L8Fw47zSVePH/9IYtDft8ubXILneRp88FzU
         R/JmKC3onnru5LES7n4shOc43aHw/4bXM2aLHAWme3fhXKbVCRv4qAFawiTYwdgY0GoU
         iSWbvoUqz4n0IJ+8mtPJ2F1pxPmaPZOaHGxB1cQsMd6HGfm9Qm5dfpcWW7B9z+6JH7xb
         wo87tuKBeCedqjmqadNHaYrYDZxDZqmexNOBt+c5yOGUY17XRc2RL3FnxOhkUu468w7m
         Y1ug==
X-Gm-Message-State: AOJu0YzI1m5Kq+AIFmZLyJqAfkxVo8gjkLv6IYcB4RNohFkyVY6IAqSj
        +005/xLC4+lgVNUpZuGjg9E=
X-Google-Smtp-Source: AGHT+IGFL/GdmvGinRbRH7PZlZJVM+sNoLaueLqYAs31lFSe24A12+nl+91t4XdlRciydU++p+bA/w==
X-Received: by 2002:a05:6402:1cb1:b0:53b:3225:93c2 with SMTP id cz17-20020a0564021cb100b0053b322593c2mr14950542edb.8.1697118909629;
        Thu, 12 Oct 2023 06:55:09 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cw2-20020a056402228200b0053dea07b669sm1783014edb.87.2023.10.12.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:55:09 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:55:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, Angus Clark <angus.clark@broadcom.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pwm: bcm2835: Add support for suspend/resume
Message-ID: <ZSf6uxz4CPNtM59z@orome.fritz.box>
References: <20231011170717.3738712-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231011170717.3738712-1-florian.fainelli@broadcom.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:07:17AM -0700, Florian Fainelli wrote:
> Similar to other drivers, we need to make sure that the clock is
> disabled during suspend and re-enabled during resume.
>=20
> Reported-by: Angus Clark <angus.clark@broadcom.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v3:
>=20
> - removed __maybe_unused and use pm_ptr()
>=20
> Changes in v2:
>=20
> - use DEFINE_SIMPLE_DEV_PM_OPS as suggested by Uwe
>=20
>  drivers/pwm/pwm-bcm2835.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied, thanks.

Thierry
