Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A57B0C78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjI0TVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0TVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:21:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0228F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:21:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso202015121fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695842504; x=1696447304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET8vDjRxZmD/gtfR63OsJJa9r1kBzCcQAiKWB7PIBa0=;
        b=LzKTYX7Jv4SnY1Yudh6U9JmVkbymKuvk54oD1cuPwfnz8SrWxEmmRNrPWszQVRoaue
         5GcyEn+BP6QUD5keEtCfTje28Y9St/YN+6PQgX3lFN0dYz+szOKThPkZzDdfmHkoFu/f
         2k35H+Mk0TEhu2/xWQNpeUJLINLmNRuVPOZRnR1w5oFnzh0TOvS5iPo9U6mndyvpRJTq
         4PUVcLk8yHEzZnERjbW37nxEyNyhMt+VD8ovOdmz0xHLrr9yB2q0fp5DP7stc2GIHhwg
         jhF831RYQZy1OA4Qpd+He02JC7fj3Sul4VCSnING4ymozhk/RazzWsu+NDnT2tBVsQQk
         Fk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695842504; x=1696447304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ET8vDjRxZmD/gtfR63OsJJa9r1kBzCcQAiKWB7PIBa0=;
        b=NexieoPWaAZ3L7vO+K2BSrgY82xVZ9NdkI9CWE26YUi3zfXJf1LPVrF+b1TTQWzQQ9
         ydQhiwds1Z/CNjcxUCJ2/sBqRNGf8pHDpH3VHv5e0suJA1159xBp7d5ciNlpsEaRKLp+
         YnQwxH0681GDyk8dAhV5+VBd6M/FupqXRbIis7f/+gSTdd0+NYOIDLo3Yl9z3PS4XwBX
         a1+RlTM4TWL+cVF13LHGEYDEb31l9uKHc6KyPQ2HQQ6YwoGuA7g4Ngjr1AKj6jsiyOvm
         fPlVRzERpIhby4AEChup9Zl9l5N7T4+cnXGBGhctwX1y+2nFWLHQeXMjaQeRxYG0Q2ci
         DjhA==
X-Gm-Message-State: AOJu0YzJ7U13oQSpKKlSGk8SCt+fFsug8wW3IHrXHZ7sy/fEBZQJfp/d
        hWyrk53RNQZ+j8X1tSweArd2CKjkcg==
X-Google-Smtp-Source: AGHT+IHz98pWnYgAoX9LLN6BI6sPelJP6WX47N+toUrrMt0trgp0iHa/o6v/TDn4gHbC8Nns/J1TMQ==
X-Received: by 2002:a2e:901a:0:b0:2c0:2bb1:20ee with SMTP id h26-20020a2e901a000000b002c02bb120eemr2727316ljg.26.1695842504373;
        Wed, 27 Sep 2023 12:21:44 -0700 (PDT)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00993a37aebc5sm9753699ejb.50.2023.09.27.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:21:43 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:21:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <david.laight@aculab.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
        david.laight@aculab.com, andriy.shevchenko@linux.intel.com,
        akpm@linux-foundation.org
Subject: Re: + minmax-add-umina-b-and-umaxa-b.patch added to
 mm-nonmm-unstable branch
Message-ID: <d74a3644-1d03-42c7-b258-4d5d63416ee0@p183>
References: <20230927173033.AF86DC433C7@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927173033.AF86DC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:30:33AM -0700, Andrew Morton wrote:
> +#define umin(x, y)	\
> +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)

kmin() and kmax() are (of course!) much better names.
