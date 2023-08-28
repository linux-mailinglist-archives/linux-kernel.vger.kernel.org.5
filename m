Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2078B351
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjH1Oiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjH1Oik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:38:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0010C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:38:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a0856b4fdso4372679a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693233513; x=1693838313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4s4gvqIGyF3PL0WV1Hs8kg7yCGjq/lL5qZsL8CvtqI4=;
        b=eDjJ/trNeUKfJJIPkz1v8S2ENlWGGtY2DO+7pe+A0aot+oko35vujCtMJmSOiU77DB
         PIzAMCM+tjJP+nNFEKt6moLi5MwIuOVIwztwgn7RDIZDYTuxcQ3Ia0wf9etwkSIX2+pL
         lx87il3CaYx6tdsP3BO8FP7kgGlZCCWPns/9jNxkJtGXUx9Ue0E8SYkrN20612xbHjDX
         KliC+vVClrJp5mFnj685dy/qzOPBD0kP6qCAmI/Hp0E3nzWL1C3lCwuX5z3wMIkXpuhk
         WCSiT7aoNMZyzjtOn6M/ZKzgBbLOe3SbnKP/iuD86EL5cZwTuHEsMk/QhLsuj7R5X2M3
         OVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233513; x=1693838313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s4gvqIGyF3PL0WV1Hs8kg7yCGjq/lL5qZsL8CvtqI4=;
        b=FwFiAoi3VrH7AwyskWQP1RjyabQqS7GuL/awkjXiguTu0wyLD/4Lj4CfCjbhu05+AD
         qhWHkVe63/i3xLX6iVCxbPoFZLI8g6+4GvV4X6E9J4MjJCgSTCQzr9fH6+VFgnV6Urhv
         7rJZXkWUR0mBDOUsBCN1wmm0XoZqDaX6OygNUqvViCmYiaqd3B3zGkH3DPwEztFypfaM
         qyoKjTJU+p/QOWiRRQsyqlIGw7/agnPApF7kqUa25L07TbNtLKCP8tMlIpwFrXWJGhwi
         ESMUGFZWJT21Z8e3AVJ97ew3xIhFGKFZj2fSXsx7y5UmAXWB8iCjLuBbUofqxfiXpU7x
         hycg==
X-Gm-Message-State: AOJu0YwMImizFhKT8zw8cgn4cyrgHPIi7w57pRD5Q0qY1XvLFOGS33E1
        Og+tToM0TeUZE2S4V0V8nO4=
X-Google-Smtp-Source: AGHT+IE87KzS9bEzrr8Y0EZ6EpGP+ApCQioItRU8nouVpJwSwnNKnYT890IqwGJAU0fJNg6738yCGQ==
X-Received: by 2002:a05:6402:2039:b0:525:4dd9:d247 with SMTP id ay25-20020a056402203900b005254dd9d247mr18298871edb.35.1693233513458;
        Mon, 28 Aug 2023 07:38:33 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id z6-20020aa7cf86000000b00523d5d9bf1bsm4486393edx.23.2023.08.28.07.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:38:33 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:38:32 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4 1/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <ZOyxaLDCI81W96/X@nam-dell>
References: <cover.1693229582.git.ozlinux@hotmail.com>
 <PH7PR11MB7643C65E067BAB032F930488BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7643C65E067BAB032F930488BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:39:14AM -0400, Oliver Crumrine wrote:
> Make the octeon ethernet driver better adhere to the
> kernel coding standard
> 
> Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> ---
> v2: Actually send the patch set properly
> v3: Fixed a bug where I forgot to change all instances of a struct
> v4: Actually fix that bug (this is my first patch, give me a break)

Don't give up! You will get it right eventually.

This is not important, but I prefer you revert the order of the change log.
The changes compared to the last version is most relevant, so preferably they
should be put on top.

Best regards,
Nam
