Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B38076D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379731AbjLFRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjLFRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:42:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA5D4D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:42:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1caddd6d28so159144866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701884571; x=1702489371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cQSdmy5VXvMhl1lDfSWOEIqrjKBlLF9FrQbjdBXHKU=;
        b=eg1Ofqpzx0mijHYdklLtSTbybubwXFBzq8Bv6wPaiV9rG6eJVuF4Ods+YnItuvJ/VE
         mT8HIJgHBKBKLmrnUNQpSfwwr7mMwDj7zl1HpMcwbbHYJx02G466rqLzc8/FlkdPm95/
         eIpsUDKUw8TOOZxn5IBA/LhUJyKY0MQ2LzH7cb2EANXOINbBpnuZsaO+orLhDkKsV7ES
         lsbZDTD4jeQuj71/i0el2P0bfxO96adHgboDphlHzdtGRqmdMxOKhtB3qnXhQUD4Qy68
         zkF0VzwzLG9dnKFFLDqdvX0YPz+05mkZk/Mt5ytyXO87wsLt99ORPWqjX8WlC9S+7gkf
         tpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884571; x=1702489371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQSdmy5VXvMhl1lDfSWOEIqrjKBlLF9FrQbjdBXHKU=;
        b=r/rys754Gs7vHwYBsWwwoHNMJhvypUb3tbzQ57/2At5azYg1YSfobXZoIRF5YhmGjg
         emScE/2WnOYyyuVpgesjz7hAWkLQWT6W7oy3Uz9L3SWAkBLcEJ26/oQYpZx+AL0mlCZi
         RJT7u2XL//w+T0+KogdG3+rzR9A98gzhCaOcbhrWw74YiME6loAZ3ARv2PB1etLGiB2j
         a4b2ymsKVYmeWcV9bZI8mlulynOGp078R3poUXnvjetm0ub1XOffBJEsoxttFM91DBRl
         btkmaVxZZavm4U787IauN1GWY6LAy+/gHxmOe6r1lEskIn4jDnz2O4y+f9skUT3CLxgu
         GTNg==
X-Gm-Message-State: AOJu0Yy2sIEApOwkKjjy9PW3tZNtm+DOO7csuZg9CLQoBir3llZ8tqEd
        hur3IAcvk9oMFGL3wcEpAwU=
X-Google-Smtp-Source: AGHT+IEqNY3yzxYYXl8igoGLjOk/4cPykJ/7Y/Xr3Wh21g/tUrcHy0cIIuxSjqPNQCjvvDdSWt6cPg==
X-Received: by 2002:a17:907:bb98:b0:a19:a19b:4265 with SMTP id xo24-20020a170907bb9800b00a19a19b4265mr646334ejc.208.1701884570832;
        Wed, 06 Dec 2023 09:42:50 -0800 (PST)
Received: from andrea ([31.189.124.152])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709061c8b00b00a1cd9151af6sm207563ejh.210.2023.12.06.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:42:49 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:42:44 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Message-ID: <ZXCylOEXSbEMGB96@andrea>
References: <ZXCA+4WyI6D+Somy@andrea>
 <mhng-26a1b3dd-ca9e-4b82-86e9-1faf1e3571e5@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-26a1b3dd-ca9e-4b82-86e9-1faf1e3571e5@palmer-ri-x1c9>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The final version of this fix will likely depend on some machinery/code
> > introduced by 3ccfebedd8cf54 ("powerpc, membarrier: Skip memory barrier
> > in switch_mm()"); but, yes, nothing we can't safely adjust I think.
> 
> Ya, I guess we'll have to look to know for sure but hopefully it's
> manageable.

Absolutely.  One approach would be to follow what PowerPC did: AFAIU, before
3ccfebedd8cf54 membarrier/powerpc used to hard code the required barrier in
in finish_task_switch(), "masking" it as an smp_mb__after_unlock_lock(); riscv
could use a similar approach (though with a different/new mask function).
Alternatively, we could maybe keep the barrier in switch_mm().

But let me complete and send out v2 with the fix at stake...  this should give
us a more concrete basis to discuss about these matters.

  Andrea
