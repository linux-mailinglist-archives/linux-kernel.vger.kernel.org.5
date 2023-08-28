Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7157378B301
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjH1OXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjH1OXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:23:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45801CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:23:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c0cb7285fso433532266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693232611; x=1693837411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR+WaKAv8bFCpNLn1HT9C6vyjEwM7tIBgDBW1Ng29Oc=;
        b=oRWijh8pUECA+jhR1lOWv4zM0KbH+oQt9jKyakF4lLp3j0B1qgj2b12WX9KYkq2ZiV
         ucWpBdeYdiUDB7YJb/Xx9NYPG5nuAd0wo+w5+K90OkBceOKXg9+abSSwjO1JEMFtzfXX
         DWfWnqdRO2ZVos2vjg9GxJMkUly5qOh/qKCkk7uqPr0tPJhoI0FQttQCsNs3iVx4MOeE
         whxSb6pL8ne7CS1sADbgrH5nFsWP4JCD6ou5KLl0A6NollLYqkigDjHq4KabX0ZaXOWD
         ULOwEeWq/CcLYcA52Awj50Tgmq8PtCbeHfks+mZrDCEhAgOaglgKufVCnGehwRWn7yIe
         bgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232611; x=1693837411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR+WaKAv8bFCpNLn1HT9C6vyjEwM7tIBgDBW1Ng29Oc=;
        b=ks1XOLbyMA7iCucuLTqjDb9GNFLF3MI4pinw4v4GTSMqH60Sw/jPQBhEczuvCbm2gy
         VpKx8/P0ZZXjVlv+EVWQeJVoDyQI2wNb1DNlaYdFTZ+pa5lO78yFA+b0ptx8Q/keAYcY
         46c1ZOJFCZmC3bJ+Eevz+1jOad4DzTGVvMVB5zQcTsMc8v0qipS9xRG9AnBm28eWasZt
         SslAwrNPY0dzkdiFexYcQYZYjnMHOp2IQwPAteQ/H2BLGOHV0DMlrGfR1dQF5pU1BxPK
         XMeQIMfJ5srG6eHc8UxXVyE5mKDWqHEEGYvEisTekwU0srPTtckcBQTnps8butbCSYii
         aXLA==
X-Gm-Message-State: AOJu0YznrAW6D7QeQpyai1hG6er0er/P8mctKzpj/cDHbCzah4BRKNGn
        DQuQzp1xBzPsbLEXGNw7DYg=
X-Google-Smtp-Source: AGHT+IFsdWF4nx4kMCBbcVt4bM6HLGc1akJNpCdNi1oJzcLJPhDWDutIOU5aAhV3RjleKfdHuDRz0A==
X-Received: by 2002:a17:906:209b:b0:9a1:c225:1cea with SMTP id 27-20020a170906209b00b009a1c2251ceamr13949482ejq.65.1693232610645;
        Mon, 28 Aug 2023 07:23:30 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906710600b0099cc1ffd8f5sm4686690ejj.53.2023.08.28.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:23:30 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:23:29 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4 1/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <ZOyt4QEYivtMVaFE@nam-dell>
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

Try to be more specific with your description. For example, mention that the
patch remove typedef cvmx_spi_mode_t because "...". Same thing for your title,
it's way too generic.

Have a look at the accepted patches to see how commit messages should be written.

Best regards,
Nam
