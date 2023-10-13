Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88027C83B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJMKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjJMKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:51:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F478CF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:51:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3231df054c4so1621211f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697194262; x=1697799062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kip9DJFTL9bMNWFq3/LHE2ELIE/tSjyhKv8w3kgG/c=;
        b=J6qkJJf4V/KMSQSOgW14oB3AWsJldtN+hCDJwxVH6/nO2O2YhXpIcqaBukFYWNKoj0
         MQK/Z7N/TnnSkJZ5EW+O8Jf07ghJi5in6vDfHXYQmY96waMMJvivwMNJLRbFqN0GUwiw
         hg/g2PYzny+kD0iIOMIbTmdV8VvK/RWtEmD4mMctJSEnLLcw/nPRM1wzaKyQYGw4ztsA
         WV8gJ58LMAFgbr4iI+JNQWtvMUzPOmWA0NlDYOSROGXurluN9fFnUpo0j8iG8QCIU9n3
         JAZj3UcAhgC7snnivCOsi7qFZ+DgsYDCqIktNVd9NRn+U1ZhX1qZ7LgAMYQHfvUeFC/b
         7p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194262; x=1697799062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kip9DJFTL9bMNWFq3/LHE2ELIE/tSjyhKv8w3kgG/c=;
        b=rMimJdGiBVsjSWvV2drH+lUMZ1lJSt/kSgXXggqOBTyD1uMN5/gEDcgKaUT3bf5x5Y
         35JqSFiFybNgFKc/Vs+3Q1tjFvdYWthDkB51NAcb9z0Dw85LAhUXpAgYckxjFI0aG+wU
         inkrR+Vfbuotos828L5z6VG0x+E7Jf7fcQ63LjGdx5fE59uH0Ac/MgsIcfkUPakx5cSc
         tMjRaDB34FbndMJaWp1DVhLoMmvCP6ysFwdxP2q3bEuT+rPnEbYcaCSe8mJaUrAOZQkv
         n+iExVSnWrQOgXHR+JOXzZ8seDYM1VP+iEf1pPerboKXOO6bVWgmr7B+cTu3RHYOgrSa
         CGZQ==
X-Gm-Message-State: AOJu0YxxwA9Q2WbnHvDPctO1xDca7wDv4/vxkLEOjR/FcrfRBp6QKRXY
        JlxwpP+b0dRA+uHeqkeKzQuZYgUXHXg=
X-Google-Smtp-Source: AGHT+IGwmsRc/kDf+3BN9NYhw05llJFc0XiGxKJpQwxg47nl/l58DOVPH822iLYK28kHm5qvj0rNFw==
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id c11-20020adffb0b000000b0031fc1b5d4c1mr21424542wrr.35.1697194261742;
        Fri, 13 Oct 2023 03:51:01 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6109000000b0031f3ad17b2csm1522231wrt.52.2023.10.13.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:51:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 12:50:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZSkhE2GWfGRW+9Hh@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
 <20231012170548.o5vi4kgpvpjyld7s@treble>
 <ZShALJDaxJ9VJvek@gmail.com>
 <20231012204347.4aei5jr64fsv2iv5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012204347.4aei5jr64fsv2iv5@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Thu, Oct 12, 2023 at 08:51:24PM +0200, Ingo Molnar wrote:
> > > Another way to avoid ifdeffery:
> > > 
> > > static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> > > 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
> > 
> > I think we could make it a simple:
> > 
> > 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_RETBLEED);
> > 
> > Because RETBLEED_CMD_AUTO && RETBLEED_CMD_OFF maps naturally to 1 and 0. 
> > Maybe add a comment to the enum to maintain this property in the future 
> > too.
> 
> Hm, that both obfuscates the default and makes it fragile.  The fact
> that it would need a comment to try to prevent breaking it in the future
> is a clue that maybe we shouldn't do it ;-)

Can be enforced with BUILD_BUG_ON().

Thanks,

	Ingo
