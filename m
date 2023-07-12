Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD23A751037
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGLSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjGLSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:04:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1AD1BFB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:04:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b9e93a538dso16963245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689185047; x=1691777047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DPqQvrqEcuM8QfMK2D4w0RCKWDpgX6iSDHJktjRFe4=;
        b=CrUIJ2s7hBFpEhiEyQkj4m8810Y6ZbMHKQwSlkM864oZPBGY6CgroF8QM60cAaxc73
         eoq2Vp6DjLRlMAKlpnLaGvnCzwxY6BH5UvjZOy+sIkxWN0zlbDG+tPlV9CDB2uLFWh38
         penysPKf1wJJWYaoUD+7pmHuSmD/cNmFY0RKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689185047; x=1691777047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DPqQvrqEcuM8QfMK2D4w0RCKWDpgX6iSDHJktjRFe4=;
        b=Ey+xRMtTPBgj9RLQquW2+cZ4RRjDpZvcIUrzdBKwdNe7EFcYStwuZvd0jdgm/Ty92e
         Cd23jkO1/Gz53X424U5fsaOj/kIk9QonWj5iC+960iOfAOSM4wl4Z1Oj5YKEyMIjOXlr
         +LPvei9Jjb8yISeCIWQPc3j/6tY/RE0z/BwLxsjM6s3sDRVgvcRk0CixlZugYojrytA+
         EOPPV9qEccku2nj5rdt+JG7rFki/zW3CygwxgiIF+AiZDqyP3CaBJO0yxrb17gOwzlw2
         47b7gTL5dyS6sb6VQxfo4mAvmnPuy/CMVvSwRIFPniXdxneOIpFHAL/2QwWqxZTA/1x6
         pQSw==
X-Gm-Message-State: ABy/qLYYkC7g+RBGrqAoKbq4ql6nItvfhpwol9w6l+dTqvhOIj7hLjJv
        s62KcAW8EEBnBYGdGW0Be9giAg==
X-Google-Smtp-Source: APBJJlGiYUJifT1keXdZg9+4cHh4iEQYO+9aEAZ/+ymxyR4AFfMgTGdOVTMfY6nLSwvJbQFsDkZW2w==
X-Received: by 2002:a17:902:b691:b0:1b8:c1f:fd2c with SMTP id c17-20020a170902b69100b001b80c1ffd2cmr13628055pls.33.1689185046857;
        Wed, 12 Jul 2023 11:04:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b9d88a4d1asm4246172pll.289.2023.07.12.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 11:04:06 -0700 (PDT)
Date:   Wed, 12 Jul 2023 11:04:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] hwmon: Remove strlcpy occurences
Message-ID: <202307121100.A6E650B@keescook>
References: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
 <3034082b-4ec8-2a8d-35a2-2551e9feef34@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3034082b-4ec8-2a8d-35a2-2551e9feef34@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:16:39AM -0700, Guenter Roeck wrote:
> On 7/12/23 07:44, Azeem Shaikh wrote:
> > [...]
> > +	len = strlen(result);
> >   	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
> 
> This still copies tbuf, meaning all those constant strings won't actually
> be reported.

Ah dang, thanks for catching that. Yeah, "tbuf" should be replaced by
"result" in the simple_read_from_buffer().

-- 
Kees Cook
